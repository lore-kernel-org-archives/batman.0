Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:08:59 +0200
Message-Id: <1467378549-9646-8-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/17] batman-adv: remove unused callback
	from batadv_algo_ops struct
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 5 -----
 net/batman-adv/types.h      | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b0bad57..076d258 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -251,10 +251,8 @@ static void batadv_neigh_node_release(struct kref *ref)
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
-	struct batadv_algo_ops *bao;
 
 	neigh_node = container_of(ref, struct batadv_neigh_node, refcount);
-	bao = neigh_node->orig_node->bat_priv->bat_algo_ops;
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
@@ -263,9 +261,6 @@ static void batadv_neigh_node_release(struct kref *ref)
 
 	batadv_hardif_neigh_put(neigh_node->hardif_neigh);
 
-	if (bao->bat_neigh_free)
-		bao->bat_neigh_free(neigh_node);
-
 	batadv_hardif_put(neigh_node->if_incoming);
 
 	kfree_rcu(neigh_node, rcu);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6a577f4..114d150 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1278,8 +1278,6 @@ struct batadv_forw_packet {
  *  better than neigh2 for their respective outgoing interface from the metric
  *  prospective
  * @bat_neigh_print: print the single hop neighbor list (optional)
- * @bat_neigh_free: free the resources allocated by the routing algorithm for a
- *  neigh_node object
  * @bat_orig_print: print the originator table (optional)
  * @bat_orig_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
@@ -1310,7 +1308,6 @@ struct batadv_algo_ops {
 		 struct batadv_neigh_node *neigh2,
 		 struct batadv_hard_iface *if_outgoing2);
 	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
-	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
 			       struct batadv_hard_iface *hard_iface);
-- 
2.8.1

