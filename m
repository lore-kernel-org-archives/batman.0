Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun,  1 Mar 2015 00:50:17 +0800
Message-Id: <1425142217-18966-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1425142217-18966-1-git-send-email-mareklindner@neomailbox.ch>
References: <1425142217-18966-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: add bat_neigh_free API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This API has to be used to let any routing protocol free
neighbor specific allocated resources

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 originator.c | 6 ++++++
 types.h      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/originator.c b/originator.c
index 90e805a..9e04e60 100644
--- a/originator.c
+++ b/originator.c
@@ -197,13 +197,19 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
+	struct batadv_algo_ops *bao;
 
 	neigh_node = container_of(rcu, struct batadv_neigh_node, rcu);
+	bao = neigh_node->orig_node->bat_priv->bat_algo_ops;
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
 		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
 	}
+
+	if (bao->bat_neigh_free)
+		bao->bat_neigh_free(neigh_node);
+
 	batadv_hardif_free_ref_now(neigh_node->if_incoming);
 
 	kfree(neigh_node);
diff --git a/types.h b/types.h
index de09807..3b096c4 100644
--- a/types.h
+++ b/types.h
@@ -1120,6 +1120,8 @@ struct batadv_forw_packet {
  * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or better
  *  than neigh2 for their respective outgoing interface from the metric
  *  prospective
+ * @bat_neigh_free: free the resources allocated by the routing algorithm for a
+ *  neigh_node object
  * @bat_orig_print: print the originator table (optional)
  * @bat_orig_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
@@ -1137,6 +1139,7 @@ struct batadv_algo_ops {
 	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
+	/* neigh_node handling API */
 	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
 			     struct batadv_hard_iface *if_outgoing1,
 			     struct batadv_neigh_node *neigh2,
@@ -1146,6 +1149,7 @@ struct batadv_algo_ops {
 		 struct batadv_hard_iface *if_outgoing1,
 		 struct batadv_neigh_node *neigh2,
 		 struct batadv_hard_iface *if_outgoing2);
+	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
 			       struct batadv_hard_iface *hard_iface);
-- 
2.1.4

