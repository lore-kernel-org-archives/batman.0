Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:52 +0100
Message-Id: <1450617490-3544-12-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 12/30] batman-adv: Convert
	batadv_hardif_neigh_node to kref
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

batman-adv uses a self-written reference implementation which is just based
on atomic_t. This is less obvious when reading the code than kref and
therefore increases the change that the reference counting will be missed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/originator.c | 22 +++++++++++++---------
 net/batman-adv/types.h      |  3 ++-
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ef82614..7e5c207 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -23,6 +23,7 @@
 #include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -196,11 +197,15 @@ void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 /**
  * batadv_hardif_neigh_release - release hardif neigh node from lists and
  *  queue for free after rcu grace period
- * @hardif_neigh: hardif neigh neighbor to free
+ * @ref: kref pointer of the neigh_node
  */
-static void
-batadv_hardif_neigh_release(struct batadv_hardif_neigh_node *hardif_neigh)
+static void batadv_hardif_neigh_release(struct kref *ref)
 {
+	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	hardif_neigh = container_of(ref, struct batadv_hardif_neigh_node,
+				    refcount);
+
 	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
@@ -211,13 +216,12 @@ batadv_hardif_neigh_release(struct batadv_hardif_neigh_node *hardif_neigh)
 
 /**
  * batadv_hardif_neigh_free_ref - decrement the hardif neighbors refcounter
- *  and possibly free it
+ *  and possibly release it
  * @hardif_neigh: hardif neigh neighbor to free
  */
 void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount))
-		batadv_hardif_neigh_release(hardif_neigh);
+	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release);
 }
 
 /**
@@ -529,7 +533,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	hardif_neigh->if_incoming = hard_iface;
 	hardif_neigh->last_seen = jiffies;
 
-	atomic_set(&hardif_neigh->refcount, 1);
+	kref_init(&hardif_neigh->refcount);
 
 	if (bat_priv->bat_algo_ops->bat_hardif_neigh_init)
 		bat_priv->bat_algo_ops->bat_hardif_neigh_init(hardif_neigh);
@@ -584,7 +588,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 		if (!batadv_compare_eth(tmp_hardif_neigh->addr, neigh_addr))
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp_hardif_neigh->refcount))
+		if (!kref_get_unless_zero(&tmp_hardif_neigh->refcount))
 			continue;
 
 		hardif_neigh = tmp_hardif_neigh;
@@ -648,7 +652,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	/* increment unique neighbor refcount */
-	atomic_inc(&hardif_neigh->refcount);
+	kref_get(&hardif_neigh->refcount);
 
 	batadv_dbg(BATADV_DBG_BATMAN, orig_node->bat_priv,
 		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5e8c8df..091ad76 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -25,6 +25,7 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/if_ether.h>
+#include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/sched.h> /* for linux/wait.h */
 #include <linux/spinlock.h>
@@ -359,7 +360,7 @@ struct batadv_hardif_neigh_node {
 	u8 addr[ETH_ALEN];
 	struct batadv_hard_iface *if_incoming;
 	unsigned long last_seen;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

