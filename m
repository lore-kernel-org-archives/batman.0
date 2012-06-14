Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 14 Jun 2012 23:27:27 +0200
Message-Id: <1339709247-8703-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't redirect tt_request for me
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

If a tt_request is directed to me, it never has to be redirected

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 2a6d7d6..c32c5f6 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1648,7 +1648,7 @@ out:
 
 }
 
-static bool
+static void
 batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			   struct batadv_tt_query_packet *tt_request)
 {
@@ -1656,7 +1656,6 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t my_ttvn, req_ttvn, ttvn;
-	int ret = false;
 	unsigned char *tt_buff;
 	bool full_table;
 	uint16_t tt_len, tt_tot;
@@ -1751,7 +1750,6 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = true;
 	goto out;
 
 unlock:
@@ -1765,8 +1763,6 @@ out:
 		batadv_hardif_free_ref(primary_if);
 	if (!ret)
 		kfree_skb(skb);
-	/* This packet was for me, so it doesn't need to be re-routed */
-	return true;
 }
 
 bool batadv_send_tt_response(struct batadv_priv *bat_priv,
@@ -1777,7 +1773,9 @@ bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 		if (batadv_bla_is_backbone_gw_orig(bat_priv, tt_request->src))
 			return true;
 
-		return batadv_send_my_tt_response(bat_priv, tt_request);
+		batadv_send_my_tt_response(bat_priv, tt_request);
+		/* This packet was for me, so it never needs to be re-routed */
+		return true;
 	} else {
 		return batadv_send_other_tt_response(bat_priv, tt_request);
 	}
-- 
1.7.9.4

