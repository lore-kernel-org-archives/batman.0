Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jun 2011 12:37:07 +0200
Message-Id: <1308220627-27164-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix cleanup in send_tt_request()
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

The ret variable was never set to any value other than 0, therefore
the skb and tt_req_node would not be freed in case of an error.
Furthermore, the code assumed tt_req_node being always a valid
pointer by dereferencing it in the cleanup part.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 translation-table.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 373ee81..5f1fcd5 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1012,12 +1012,12 @@ out:
 int send_tt_request(struct bat_priv *bat_priv, struct orig_node *dst_orig_node,
 		    uint8_t ttvn, uint16_t tt_crc, bool full_table)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	struct tt_query_packet *tt_request;
 	struct neigh_node *neigh_node = NULL;
 	struct hard_iface *primary_if;
-	struct tt_req_node *tt_req_node;
-	int ret = 0;
+	struct tt_req_node *tt_req_node = NULL;
+	int ret = 1;
 
 	primary_if = primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -1066,8 +1066,9 @@ out:
 		neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		hardif_free_ref(primary_if);
-	if (ret) {
+	if (ret)
 		kfree_skb(skb);
+	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt_req_list_lock);
 		list_del(&tt_req_node->list);
 		spin_unlock_bh(&bat_priv->tt_req_list_lock);
-- 
1.7.5.3

