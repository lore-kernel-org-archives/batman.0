Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 28 May 2013 11:49:47 +0200
Message-Id: <1369734587-13104-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove useless find_router look
	up
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

This is not used anymore with the new fragmentation, and it might
actually mess up the bonding code because find_router() assumes it
is only called once per packet.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
This patch was originally part of the RFC series
"add network wide multi interface optimization", but since it is
just a fix it is resent as PATCH to be applied now.
---
 send.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/send.c b/send.c
index 8f74201..d780b9d 100644
--- a/send.c
+++ b/send.c
@@ -251,30 +251,19 @@ int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node *neigh_node;
 	int ret = NET_RX_DROP;
 
 	/* get routing information */
-	if (is_multicast_ether_addr(ethhdr->h_dest)) {
+	if (is_multicast_ether_addr(ethhdr->h_dest))
 		orig_node = batadv_gw_get_selected_orig(bat_priv);
-		if (orig_node)
-			goto find_router;
-	}
+	else
+		/* check for tt host - increases orig_node refcount.
+		 * returns NULL in case of AP isolation
+		 */
+		orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+						     ethhdr->h_dest);
 
-	/* check for tt host - increases orig_node refcount.
-	 * returns NULL in case of AP isolation
-	 */
-	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-					     ethhdr->h_dest);
-
-find_router:
-	/* find_router():
-	 *  - if orig_node is NULL it returns NULL
-	 *  - increases neigh_nodes refcount if found.
-	 */
-	neigh_node = batadv_find_router(bat_priv, orig_node, NULL);
-
-	if (!neigh_node)
+	if (!orig_node)
 		goto out;
 
 	switch (packet_type) {
@@ -306,8 +295,6 @@ find_router:
 		ret = 0;
 
 out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	if (ret == NET_RX_DROP)
-- 
1.7.10.4

