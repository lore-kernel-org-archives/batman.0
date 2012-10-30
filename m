Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Oct 2012 14:09:45 +0100
Message-Id: <1351602589-22844-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1351602589-22844-1-git-send-email-ordex@autistici.org>
References: <1351602589-22844-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: fix debug message
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

In case of re-routing, the old_ttvn must be saved before being overwritten,
otherwise the debug message will obviously print the new one.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index c8d2fbf..6a84f0d 100644
--- a/routing.c
+++ b/routing.c
@@ -929,7 +929,7 @@ out:
 
 static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 				     struct sk_buff *skb) {
-	uint8_t curr_ttvn;
+	uint8_t curr_ttvn, old_ttvn;
 	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	struct batadv_hard_iface *primary_if;
@@ -994,6 +994,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	if (!is_old_ttvn)
 		return 1;
 
+	old_ttvn = unicast_packet->ttvn;
 	/* the packet was forged based on outdated network information. Its
 	 * destination can possibly be updated and forwarded towards the new
 	 * target host
@@ -1003,7 +1004,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
 					 "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
 					 unicast_packet->dest, ethhdr->h_dest,
-					 unicast_packet->ttvn, curr_ttvn);
+					 old_ttvn, curr_ttvn);
 		return 1;
 	}
 
-- 
1.7.12.4

