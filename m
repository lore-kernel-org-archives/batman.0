Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue,  6 Sep 2016 09:25:27 +0200
Message-Id: <20160906072529.5587-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4.4] batman-adv: Fix pagefault during
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
 net/batman-adv/originator.c | 6 ------
 net/batman-adv/types.h      | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 17851d3..6282f02 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -197,18 +197,12 @@ static void batadv_neigh_node_release(struct batadv_neigh_node *neigh_node)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
-	struct batadv_algo_ops *bao;
-
-	bao = neigh_node->orig_node->bat_priv->bat_algo_ops;
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
 		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
 	}
 
-	if (bao->bat_neigh_free)
-		bao->bat_neigh_free(neigh_node);
-
 	batadv_hardif_free_ref(neigh_node->if_incoming);
 
 	kfree_rcu(neigh_node, rcu);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d260efd..cbd347c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1136,8 +1136,6 @@ struct batadv_forw_packet {
  * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or better
  *  than neigh2 for their respective outgoing interface from the metric
  *  prospective
- * @bat_neigh_free: free the resources allocated by the routing algorithm for a
- *  neigh_node object
  * @bat_orig_print: print the originator table (optional)
  * @bat_orig_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
@@ -1165,7 +1163,6 @@ struct batadv_algo_ops {
 		 struct batadv_hard_iface *if_outgoing1,
 		 struct batadv_neigh_node *neigh2,
 		 struct batadv_hard_iface *if_outgoing2);
-	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
 			       struct batadv_hard_iface *hard_iface);
-- 
2.8.1

