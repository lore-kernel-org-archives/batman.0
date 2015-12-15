Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:43 +0100
Message-Id: <1450222316-1764-10-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/23] batman-adv: Convert batadv_nc_node to
	kref
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/network-coding.c | 36 +++++++++++++++++++-----------------
 net/batman-adv/types.h          |  2 +-
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 56100c5..246cd90 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -32,6 +32,7 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -207,28 +208,28 @@ void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 }
 
 /**
- * batadv_nc_node_free_rcu - rcu callback to free an nc node and remove
- *  its refcount on the orig_node
- * @rcu: rcu pointer of the nc node
+ * batadv_nc_node_release - release nc_node from lists and queue for free after
+ *  rcu grace period
+ * * @ref: kref pointer of the nc_node
  */
-static void batadv_nc_node_free_rcu(struct rcu_head *rcu)
+static void batadv_nc_node_release(struct kref *ref)
 {
 	struct batadv_nc_node *nc_node;
 
-	nc_node = container_of(rcu, struct batadv_nc_node, rcu);
+	nc_node = container_of(ref, struct batadv_nc_node, refcount);
+
 	batadv_orig_node_free_ref(nc_node->orig_node);
-	kfree(nc_node);
+	kfree_rcu(nc_node, rcu);
 }
 
 /**
- * batadv_nc_node_free_ref - decrements the nc node refcounter and possibly
- * frees it
- * @nc_node: the nc node to free
+ * batadv_nc_node_put - decrement the nc_node refcounter and possibly
+ *  release it
+ * @nc_node: nc_node to be free'd
  */
-static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
+static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
 {
-	if (atomic_dec_and_test(&nc_node->refcount))
-		call_rcu(&nc_node->rcu, batadv_nc_node_free_rcu);
+	kref_put(&nc_node->refcount, batadv_nc_node_release);
 }
 
 /**
@@ -342,7 +343,7 @@ batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
 			   "Removing nc_node %pM -> %pM\n",
 			   nc_node->addr, nc_node->orig_node->orig);
 		list_del_rcu(&nc_node->list);
-		batadv_nc_node_free_ref(nc_node);
+		batadv_nc_node_put(nc_node);
 	}
 	spin_unlock_bh(lock);
 }
@@ -800,7 +801,7 @@ static struct batadv_nc_node
 		if (!batadv_compare_eth(nc_node->addr, orig_node->orig))
 			continue;
 
-		if (!atomic_inc_not_zero(&nc_node->refcount))
+		if (!kref_get_unless_zero(&nc_node->refcount))
 			continue;
 
 		/* Found a match */
@@ -851,7 +852,8 @@ static struct batadv_nc_node
 	INIT_LIST_HEAD(&nc_node->list);
 	ether_addr_copy(nc_node->addr, orig_node->orig);
 	nc_node->orig_node = orig_neigh_node;
-	atomic_set(&nc_node->refcount, 2);
+	kref_init(&nc_node->refcount);
+	kref_get(&nc_node->refcount);
 
 	/* Select ingoing or outgoing coding node */
 	if (in_coding) {
@@ -927,9 +929,9 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 
 out:
 	if (in_nc_node)
-		batadv_nc_node_free_ref(in_nc_node);
+		batadv_nc_node_put(in_nc_node);
 	if (out_nc_node)
-		batadv_nc_node_free_ref(out_nc_node);
+		batadv_nc_node_put(out_nc_node);
 }
 
 /**
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c56b99c..9a2371a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1067,7 +1067,7 @@ struct batadv_tt_roam_node {
 struct batadv_nc_node {
 	struct list_head list;
 	u8 addr[ETH_ALEN];
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 	struct batadv_orig_node *orig_node;
 	unsigned long last_seen;
-- 
2.6.4

