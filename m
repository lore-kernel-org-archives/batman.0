Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Oct 2012 14:09:44 +0100
Message-Id: <1351602589-22844-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1351602589-22844-1-git-send-email-ordex@autistici.org>
References: <1351602589-22844-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: fix TT packet rerouting
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

when the node checks for a packet to be re-routed or not, first it should
consider whether the destination is a local client. Only after this check,
the node can eventually search the global table.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/routing.c b/routing.c
index 5da7724..c8d2fbf 100644
--- a/routing.c
+++ b/routing.c
@@ -890,22 +890,37 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 			      struct batadv_unicast_packet *unicast_packet,
 			      uint8_t *dst_addr)
 {
-	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
 	bool ret = false;
+	uint8_t *orig_addr, orig_ttvn;
 
-	orig_node = batadv_transtable_search(bat_priv, NULL, dst_addr);
-	if (!orig_node)
-		goto out;
+	if (batadv_is_my_client(bat_priv, dst_addr)) {
+		primary_if = batadv_primary_if_get_selected(bat_priv);
+		if (!primary_if)
+			goto out;
+		orig_addr = primary_if->net_dev->dev_addr;
+		orig_ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
+	} else {
+		orig_node = batadv_transtable_search(bat_priv, NULL, dst_addr);
+		if (!orig_node)
+			goto out;
 
-	if (batadv_compare_eth(orig_node->orig, unicast_packet->dest))
-		goto out;
+		if (batadv_compare_eth(orig_node->orig, unicast_packet->dest))
+			goto out;
+
+		orig_addr = orig_node->orig;
+		orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
+	}
 
 	/* update the packet header */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	unicast_packet->ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
+	memcpy(unicast_packet->dest, orig_addr, ETH_ALEN);
+	unicast_packet->ttvn = orig_ttvn;
 
 	ret = true;
 out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 
-- 
1.7.12.4

