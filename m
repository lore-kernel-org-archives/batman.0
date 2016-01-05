Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:42 +0100
Message-Id: <1451992006-13191-27-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 27/31] batman-adv: Convert
	batadv_hard_iface to kref
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
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/bat_iv_ogm.c     |  4 ++--
 net/batman-adv/hard-interface.c | 20 +++++++++++++-------
 net/batman-adv/hard-interface.h | 16 +++++++---------
 net/batman-adv/originator.c     |  8 ++++----
 net/batman-adv/types.h          |  2 +-
 5 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 895e697..c9a9e39 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -642,10 +642,10 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	unsigned char *skb_buff;
 	unsigned int skb_size;
 
-	if (!atomic_inc_not_zero(&if_incoming->refcount))
+	if (!kref_get_unless_zero(&if_incoming->refcount))
 		return;
 
-	if (!atomic_inc_not_zero(&if_outgoing->refcount))
+	if (!kref_get_unless_zero(&if_outgoing->refcount))
 		goto out_free_incoming;
 
 	/* own packet should always be scheduled */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index aea4d06..aeb3de2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -18,6 +18,7 @@
 #include "hard-interface.h"
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
@@ -26,6 +27,7 @@
 #include <linux/if_ether.h>
 #include <linux/if.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
@@ -50,10 +52,13 @@
 /**
  * batadv_hardif_release - release hard interface from lists and queue for
  *  free after rcu grace period
- * @hard_iface: the hard interface to free
+ * @ref: kref pointer of the hard interface
  */
-void batadv_hardif_release(struct batadv_hard_iface *hard_iface)
+void batadv_hardif_release(struct kref *ref)
 {
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
 	dev_put(hard_iface->net_dev);
 
 	kfree_rcu(hard_iface, rcu);
@@ -67,7 +72,7 @@ batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->net_dev == net_dev &&
-		    atomic_inc_not_zero(&hard_iface->refcount))
+		    kref_get_unless_zero(&hard_iface->refcount))
 			goto out;
 	}
 
@@ -172,7 +177,7 @@ batadv_hardif_get_active(const struct net_device *soft_iface)
 			continue;
 
 		if (hard_iface->if_status == BATADV_IF_ACTIVE &&
-		    atomic_inc_not_zero(&hard_iface->refcount))
+		    kref_get_unless_zero(&hard_iface->refcount))
 			goto out;
 	}
 
@@ -206,7 +211,7 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 
 	ASSERT_RTNL();
 
-	if (new_hard_iface && !atomic_inc_not_zero(&new_hard_iface->refcount))
+	if (new_hard_iface && !kref_get_unless_zero(&new_hard_iface->refcount))
 		new_hard_iface = NULL;
 
 	curr_hard_iface = rcu_dereference_protected(bat_priv->primary_if, 1);
@@ -434,7 +439,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount))
+	if (!kref_get_unless_zero(&hard_iface->refcount))
 		goto out;
 
 	soft_iface = dev_get_by_name(&init_net, iface_name);
@@ -655,7 +660,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
 	/* extra reference for return */
-	atomic_set(&hard_iface->refcount, 2);
+	kref_init(&hard_iface->refcount);
+	kref_get(&hard_iface->refcount);
 
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 4d74c04..32a1e84 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -20,8 +20,8 @@
 
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/compiler.h>
+#include <linux/kref.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/stddef.h>
@@ -61,18 +61,16 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
-void batadv_hardif_release(struct batadv_hard_iface *hard_iface);
+void batadv_hardif_release(struct kref *ref);
 
 /**
- * batadv_hardif_free_ref - decrement the hard interface refcounter and
- *  possibly release it
+ * batadv_hardif_free_ref - decrement the hard interface refcounter and possibly
+ *  release it
  * @hard_iface: the hard interface to free
  */
-static inline void
-batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
+static inline void batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
 {
-	if (atomic_dec_and_test(&hard_iface->refcount))
-		batadv_hardif_release(hard_iface);
+	kref_put(&hard_iface->refcount, batadv_hardif_release);
 }
 
 static inline struct batadv_hard_iface *
@@ -85,7 +83,7 @@ batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 	if (!hard_iface)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount))
+	if (!kref_get_unless_zero(&hard_iface->refcount))
 		hard_iface = NULL;
 
 out:
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e615174..41d0aef 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -367,7 +367,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		goto out;
 
 	if (if_outgoing != BATADV_IF_DEFAULT &&
-	    !atomic_inc_not_zero(&if_outgoing->refcount)) {
+	    !kref_get_unless_zero(&if_outgoing->refcount)) {
 		kfree(orig_ifinfo);
 		orig_ifinfo = NULL;
 		goto out;
@@ -447,7 +447,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 	if (!neigh_ifinfo)
 		goto out;
 
-	if (if_outgoing && !atomic_inc_not_zero(&if_outgoing->refcount)) {
+	if (if_outgoing && !kref_get_unless_zero(&if_outgoing->refcount)) {
 		kfree(neigh_ifinfo);
 		neigh_ifinfo = NULL;
 		goto out;
@@ -524,7 +524,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (hardif_neigh)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount))
+	if (!kref_get_unless_zero(&hard_iface->refcount))
 		goto out;
 
 	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
@@ -635,7 +635,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	if (!neigh_node)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+	if (!kref_get_unless_zero(&hard_iface->refcount)) {
 		kfree(neigh_node);
 		neigh_node = NULL;
 		goto out;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 75e1b45..d69be62 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -111,7 +111,7 @@ struct batadv_hard_iface {
 	struct net_device *net_dev;
 	u8 num_bcasts;
 	struct kobject *hardif_obj;
-	atomic_t refcount;
+	struct kref refcount;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
-- 
2.6.4

