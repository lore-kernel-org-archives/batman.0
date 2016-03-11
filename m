Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 16:44:06 +0100
Message-Id: <1457711046-4603-2-git-send-email-sven@narfation.org>
In-Reply-To: <1457711046-4603-1-git-send-email-sven@narfation.org>
References: <1457711046-4603-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix reference counting of
	hardif_neigh_node object for neigh_node
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

The batadv_neigh_node was specific to a batadv_hardif_neigh_node and held
an implicit reference to it. But this reference was never stored in form of
a pointer in the batadv_neigh_node itself. Instead
batadv_neigh_node_release depends on a consistent state of
hard_iface->neigh_list and that batadv_hardif_neigh_get always returns the
batadv_hardif_neigh_node object which it has a reference for. But
batadv_hardif_neigh_get cannot guarantee that because it is working only
with rcu_read_lock on this list. It can therefore happen that a neigh_addr
is in this list twice or that batadv_hardif_neigh_get cannot find the
batadv_hardif_neigh_node for an neigh_addr due to some other list
operations taking place at the same time.

Instead add a batadv_hardif_neigh_node pointer directly in
batadv_neigh_node which will be used for the reference counter decremented
on release of batadv_neigh_node.

Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors per hard-interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
See https://www.open-mesh.org/issues/242

v1:
 - Remove the old code blocks
 - make the _put unconditional
---
 net/batman-adv/originator.c | 16 +++++-----------
 net/batman-adv/types.h      |  2 ++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2d288ea..217f8ed 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -250,7 +250,6 @@ static void batadv_neigh_node_release(struct kref *ref)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
-	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 	struct batadv_algo_ops *bao;
 
@@ -262,13 +261,7 @@ static void batadv_neigh_node_release(struct kref *ref)
 		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 
-	hardif_neigh = batadv_hardif_neigh_get(neigh_node->if_incoming,
-					       neigh_node->addr);
-	if (hardif_neigh) {
-		/* batadv_hardif_neigh_get() increases refcount too */
-		batadv_hardif_neigh_put(hardif_neigh);
-		batadv_hardif_neigh_put(hardif_neigh);
-	}
+	batadv_hardif_neigh_put(neigh_node->hardif_neigh);
 
 	if (bao->bat_neigh_free)
 		bao->bat_neigh_free(neigh_node);
@@ -648,6 +641,10 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	neigh_node->if_incoming = hard_iface;
 	neigh_node->orig_node = orig_node;
 
+	/* increment unique neighbor refcount */
+	kref_get(&hardif_neigh->refcount);
+	neigh_node->hardif_neigh = hardif_neigh;
+
 	/* extra reference for return */
 	kref_init(&neigh_node->refcount);
 	kref_get(&neigh_node->refcount);
@@ -656,9 +653,6 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
-	/* increment unique neighbor refcount */
-	kref_get(&hardif_neigh->refcount);
-
 	batadv_dbg(BATADV_DBG_BATMAN, orig_node->bat_priv,
 		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
 		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 1480538..58a3fa5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -433,6 +433,7 @@ struct batadv_hardif_neigh_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard-interface
  * @last_seen: when last packet via this neighbor was received
+ * @hardif_neigh: hardif_neigh of this neighbor
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
@@ -444,6 +445,7 @@ struct batadv_neigh_node {
 	spinlock_t ifinfo_lock;	/* protects ifinfo_list and its members */
 	struct batadv_hard_iface *if_incoming;
 	unsigned long last_seen;
+	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct kref refcount;
 	struct rcu_head rcu;
 };
-- 
2.7.0

