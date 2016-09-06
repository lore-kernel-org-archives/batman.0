Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue,  6 Sep 2016 09:25:29 +0200
Message-Id: <20160906072529.5587-3-sw@simonwunderlich.de>
In-Reply-To: <20160906072529.5587-1-sw@simonwunderlich.de>
References: <20160906072529.5587-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4.7] batman-adv: Fix pagefault during
	neigh_node free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Marek Lindner <mareklindner@neomailbox.ch>

commit d9f179877e50ae2681fe7b0b83e0d9f63b6165ad upstream.

The access of the neigh_node->orig_node is not allowed anymore when the
batadv_neigh_node is freed. But this function is still trying to do it go
get an routing algorithm specific function pointer via the
neigh_node->orig_node. This function is then used to free the routing
algorithm specific neighbor node data.

This sometimes causes a crash when the orig_node was already freed when the
this function tries to read from its old memory region.

The code can just be removed since no routing algorithm implements the
function pointer.

Reported-by: Lars Bußmann <ffsoest@kill-you.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
[sven@narfation.org: rewritten commit message to make clear that it is an
 bugfix to an user reported crash]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 5 -----
 net/batman-adv/types.h      | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ab8c4f9..1da7bfc 100644
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
index 74d865a..40aed16 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1284,8 +1284,6 @@ struct batadv_forw_packet {
  *  better than neigh2 for their respective outgoing interface from the metric
  *  prospective
  * @bat_neigh_print: print the single hop neighbor list (optional)
- * @bat_neigh_free: free the resources allocated by the routing algorithm for a
- *  neigh_node object
  * @bat_orig_print: print the originator table (optional)
  * @bat_orig_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
@@ -1316,7 +1314,6 @@ struct batadv_algo_ops {
 		 struct batadv_neigh_node *neigh2,
 		 struct batadv_hard_iface *if_outgoing2);
 	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
-	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
 			       struct batadv_hard_iface *hard_iface);
-- 
2.8.1

