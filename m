Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:35 +0100
Message-Id: <1450222316-1764-2-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/23] batman-adv: Convert
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

batadv_hardif_neigh_node perfectly resamples the examples for the kernel
reference counter kref. So switch to kref instead of using the self-made,
atomic_t-based implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/kref.h | 39 ++++++++++++++++++
 net/batman-adv/bat_iv_ogm.c |  2 +-
 net/batman-adv/originator.c | 96 +++++++++++++++++++++++++++++++--------------
 net/batman-adv/originator.h |  2 +-
 net/batman-adv/types.h      |  3 +-
 5 files changed, 109 insertions(+), 33 deletions(-)
 create mode 100644 compat-include/linux/kref.h

diff --git a/compat-include/linux/kref.h b/compat-include/linux/kref.h
new file mode 100644
index 0000000..08b6328
--- /dev/null
+++ b/compat-include/linux/kref.h
@@ -0,0 +1,39 @@
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
+
+#include <linux/version.h>
+#include_next <linux/kref.h>
+
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
+
+static inline int __must_check kref_get_unless_zero(struct kref *kref)
+{
+	return atomic_add_unless(&kref->refcount, 1, 0);
+}
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 12bdffa..b9db667 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1571,7 +1571,7 @@ out:
 	if (orig_neigh_router)
 		batadv_neigh_node_free_ref(orig_neigh_router);
 	if (hardif_neigh)
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 
 	kfree_skb(skb_priv);
 }
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2681c7d..24c62a8 100644
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
@@ -208,6 +209,47 @@ void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 }
 
 /**
+ * batadv_hardif_neigh_free - remove unreferenced hardif neighbor
+ * @hardif_neigh: hardif neigh neighbor to free
+ */
+static void
+batadv_hardif_neigh_free(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
+	kfree(hardif_neigh);
+}
+
+/**
+ * batadv_hardif_neigh_release_now - release hardif neigh node from lists and
+ *  free without waiting for rcu grace period
+ * @ref: kref pointer of the neigh_node
+ */
+static void batadv_hardif_neigh_release_now(struct kref *ref)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	hardif_neigh = container_of(ref, struct batadv_hardif_neigh_node,
+				    refcount);
+
+	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+	hlist_del_init_rcu(&hardif_neigh->list);
+	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+
+	batadv_hardif_neigh_free(hardif_neigh);
+}
+
+/**
+ * batadv_hardif_neigh_put_now - decrement the hardif neighbors refcounter
+ *  and possibly release it (without rcu callback)
+ * @hardif_neigh: hardif neigh neighbor to free
+ */
+static void
+batadv_hardif_neigh_put_now(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release_now);
+}
+
+/**
  * batadv_hardif_neigh_free_rcu - free the hardif neigh_node
  * @rcu: rcu pointer of the neigh_node
  */
@@ -216,42 +258,36 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
 	struct batadv_hardif_neigh_node *hardif_neigh;
 
 	hardif_neigh = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
-
-	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
-	kfree(hardif_neigh);
+	batadv_hardif_neigh_free(hardif_neigh);
 }
 
 /**
- * batadv_hardif_neigh_free_now - decrement the hardif neighbors refcounter
- *  and possibly free it (without rcu callback)
- * @hardif_neigh: hardif neigh neighbor to free
+ * batadv_hardif_neigh_release_rcu - release hardif neigh node from lists and
+ *  queue for free after rcu grace period
+ * * @ref: kref pointer of the neigh_node
  */
-static void
-batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
+static void batadv_hardif_neigh_release_rcu(struct kref *ref)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount)) {
-		spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-		hlist_del_init_rcu(&hardif_neigh->list);
-		spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+	struct batadv_hardif_neigh_node *hardif_neigh;
 
-		batadv_hardif_neigh_free_rcu(&hardif_neigh->rcu);
-	}
+	hardif_neigh = container_of(ref, struct batadv_hardif_neigh_node,
+				    refcount);
+
+	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+	hlist_del_init_rcu(&hardif_neigh->list);
+	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+
+	call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
 }
 
 /**
- * batadv_hardif_neigh_free_ref - decrement the hardif neighbors refcounter
- *  and possibly free it
+ * batadv_hardif_neigh_put - decrement the hardif neighbors refcounter
+ *  and possibly release it
  * @hardif_neigh: hardif neigh neighbor to free
  */
-void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
+void batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount)) {
-		spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-		hlist_del_init_rcu(&hardif_neigh->list);
-		spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-
-		call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
-	}
+	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release_rcu);
 }
 
 /**
@@ -278,8 +314,8 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 					       neigh_node->addr);
 	if (hardif_neigh) {
 		/* batadv_hardif_neigh_get() increases refcount too */
-		batadv_hardif_neigh_free_now(hardif_neigh);
-		batadv_hardif_neigh_free_now(hardif_neigh);
+		batadv_hardif_neigh_put_now(hardif_neigh);
+		batadv_hardif_neigh_put_now(hardif_neigh);
 	}
 
 	if (bao->bat_neigh_free)
@@ -576,7 +612,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	hardif_neigh->if_incoming = hard_iface;
 	hardif_neigh->last_seen = jiffies;
 
-	atomic_set(&hardif_neigh->refcount, 1);
+	kref_init(&hardif_neigh->refcount);
 
 	if (bat_priv->bat_algo_ops->bat_hardif_neigh_init)
 		bat_priv->bat_algo_ops->bat_hardif_neigh_init(hardif_neigh);
@@ -631,7 +667,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 		if (!batadv_compare_eth(tmp_hardif_neigh->addr, neigh_addr))
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp_hardif_neigh->refcount))
+		if (!kref_get_unless_zero(&tmp_hardif_neigh->refcount))
 			continue;
 
 		hardif_neigh = tmp_hardif_neigh;
@@ -695,7 +731,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	/* increment unique neighbor refcount */
-	atomic_inc(&hardif_neigh->refcount);
+	kref_get(&hardif_neigh->refcount);
 
 	batadv_dbg(BATADV_DBG_BATMAN, orig_node->bat_priv,
 		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
@@ -703,7 +739,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 
 out:
 	if (hardif_neigh)
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 	return neigh_node;
 }
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 2955775..0dd1beb 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -45,7 +45,7 @@ struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr);
 void
-batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh);
+batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 		      struct batadv_hard_iface *hard_iface,
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

