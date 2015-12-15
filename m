Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:52 +0100
Message-Id: <1450222316-1764-19-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 19/23] batman-adv: Convert batadv_hard_iface
	to kref
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
 net/batman-adv/bat_iv_ogm.c            | 14 +++++------
 net/batman-adv/bridge_loop_avoidance.c | 18 +++++++-------
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/gateway_client.c        |  2 +-
 net/batman-adv/hard-interface.c        | 45 ++++++++++++++++++++--------------
 net/batman-adv/hard-interface.h        | 15 +++++-------
 net/batman-adv/icmp_socket.c           |  2 +-
 net/batman-adv/main.c                  |  2 +-
 net/batman-adv/network-coding.c        |  2 +-
 net/batman-adv/originator.c            | 24 +++++++++---------
 net/batman-adv/routing.c               |  8 +++---
 net/batman-adv/send.c                  |  8 +++---
 net/batman-adv/soft-interface.c        |  6 ++---
 net/batman-adv/sysfs.c                 |  8 +++---
 net/batman-adv/translation-table.c     | 10 ++++----
 net/batman-adv/types.h                 |  2 +-
 17 files changed, 88 insertions(+), 82 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7d61afb..95399c9 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -513,7 +513,7 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -615,7 +615,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return res;
 }
 
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
@@ -709,9 +709,9 @@ out_nomem:
 	if (!own_packet)
 		atomic_inc(&bat_priv->batman_queue_left);
 out_free_outgoing:
-	batadv_hardif_free_ref(if_outgoing);
+	batadv_hardif_put(if_outgoing);
 out_free_incoming:
-	batadv_hardif_free_ref(if_incoming);
+	batadv_hardif_put(if_incoming);
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -956,7 +956,7 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 3315b27..e58bc6c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -423,7 +423,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 	netif_rx(skb);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -1281,7 +1281,7 @@ void batadv_bla_status_update(struct net_device *net_dev)
 	 * so just call that one.
 	 */
 	batadv_bla_update_orig_address(bat_priv, primary_if, primary_if);
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 }
 
 /**
@@ -1355,7 +1355,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bla.work,
 			   msecs_to_jiffies(BATADV_BLA_PERIOD_LENGTH));
@@ -1394,7 +1394,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	if (primary_if) {
 		crc = crc16(0, primary_if->net_dev->dev_addr, ETH_ALEN);
 		bat_priv->bla.claim_dest.group = htons(crc);
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	} else {
 		bat_priv->bla.claim_dest.group = 0; /* will be set later */
 	}
@@ -1598,7 +1598,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 		bat_priv->bla.backbone_hash = NULL;
 	}
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -1691,7 +1691,7 @@ handled:
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (claim)
 		batadv_claim_put(claim);
 	return ret;
@@ -1780,7 +1780,7 @@ handled:
 	ret = 1;
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (claim)
 		batadv_claim_put(claim);
 	return ret;
@@ -1838,7 +1838,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -1903,6 +1903,6 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fa605c3..782e80a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -840,7 +840,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 87b127c..69edc0b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -512,7 +512,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 
 out_err:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 
 	return ret;
 }
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a5b92ef..33ddd7d 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -661,7 +661,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 49e05d2..de8e54b 100644
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
@@ -47,13 +49,19 @@
 #include "sysfs.h"
 #include "translation-table.h"
 
-void batadv_hardif_free_rcu(struct rcu_head *rcu)
+/**
+ * batadv_hardif_release - release hard interface from lists and queue for
+ *  free after rcu grace period
+ * @ref: kref pointer of the hard interface
+ */
+void batadv_hardif_release(struct kref *ref)
 {
 	struct batadv_hard_iface *hard_iface;
 
-	hard_iface = container_of(rcu, struct batadv_hard_iface, rcu);
+	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
 	dev_put(hard_iface->net_dev);
-	kfree(hard_iface);
+
+	kfree_rcu(hard_iface, rcu);
 }
 
 struct batadv_hard_iface *
@@ -64,7 +72,7 @@ batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->net_dev == net_dev &&
-		    atomic_inc_not_zero(&hard_iface->refcount))
+		    kref_get_unless_zero(&hard_iface->refcount))
 			goto out;
 	}
 
@@ -169,7 +177,7 @@ batadv_hardif_get_active(const struct net_device *soft_iface)
 			continue;
 
 		if (hard_iface->if_status == BATADV_IF_ACTIVE &&
-		    atomic_inc_not_zero(&hard_iface->refcount))
+		    kref_get_unless_zero(&hard_iface->refcount))
 			goto out;
 	}
 
@@ -193,7 +201,7 @@ static void batadv_primary_if_update_addr(struct batadv_priv *bat_priv,
 	batadv_bla_update_orig_address(bat_priv, primary_if, oldif);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 static void batadv_primary_if_select(struct batadv_priv *bat_priv,
@@ -203,7 +211,7 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 
 	ASSERT_RTNL();
 
-	if (new_hard_iface && !atomic_inc_not_zero(&new_hard_iface->refcount))
+	if (new_hard_iface && !kref_get_unless_zero(&new_hard_iface->refcount))
 		new_hard_iface = NULL;
 
 	curr_hard_iface = rcu_dereference_protected(bat_priv->primary_if, 1);
@@ -217,7 +225,7 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 
 out:
 	if (curr_hard_iface)
-		batadv_hardif_free_ref(curr_hard_iface);
+		batadv_hardif_put(curr_hard_iface);
 }
 
 static bool
@@ -376,7 +384,7 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 static void
@@ -431,7 +439,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount))
+	if (!kref_get_unless_zero(&hard_iface->refcount))
 		goto out;
 
 	soft_iface = dev_get_by_name(&init_net, iface_name);
@@ -529,7 +537,7 @@ err_dev:
 	hard_iface->soft_iface = NULL;
 	dev_put(soft_iface);
 err:
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 	return ret;
 }
 
@@ -560,7 +568,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 		batadv_primary_if_select(bat_priv, new_if);
 
 		if (new_if)
-			batadv_hardif_free_ref(new_if);
+			batadv_hardif_put(new_if);
 	}
 
 	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
@@ -583,11 +591,11 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	}
 
 	hard_iface->soft_iface = NULL;
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -606,7 +614,7 @@ static void batadv_hardif_remove_interface_finish(struct work_struct *work)
 
 	batadv_debugfs_del_hardif(hard_iface);
 	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 }
 
 static struct batadv_hard_iface *
@@ -652,7 +660,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
 	/* extra reference for return */
-	atomic_set(&hard_iface->refcount, 2);
+	kref_init(&hard_iface->refcount);
+	kref_get(&hard_iface->refcount);
 
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
@@ -760,10 +769,10 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	}
 
 hardif_put:
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return NOTIFY_DONE;
 }
 
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 7b12ea8..16a6aec 100644
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
@@ -61,18 +61,15 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
-void batadv_hardif_free_rcu(struct rcu_head *rcu);
+void batadv_hardif_release(struct kref *ref);
 
 /**
- * batadv_hardif_free_ref - decrement the hard interface refcounter and
- *  possibly free it
+ * batadv_hardif_put - decrement the hard interface refcounter and possibly free
  * @hard_iface: the hard interface to free
  */
-static inline void
-batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
+static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
 {
-	if (atomic_dec_and_test(&hard_iface->refcount))
-		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
+	kref_put(&hard_iface->refcount, batadv_hardif_release);
 }
 
 static inline struct batadv_hard_iface *
@@ -85,7 +82,7 @@ batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 	if (!hard_iface)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount))
+	if (!kref_get_unless_zero(&hard_iface->refcount))
 		hard_iface = NULL;
 
 out:
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index d6574cb..27be960 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -288,7 +288,7 @@ free_skb:
 	kfree_skb(skb);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (neigh_node)
 		batadv_neigh_node_put(neigh_node);
 	if (orig_node)
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index eee2d82..33ac461 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -287,7 +287,7 @@ batadv_seq_print_text_primary_if_get(struct seq_file *seq)
 	seq_printf(seq,
 		   "BATMAN mesh %s disabled - primary interface not active\n",
 		   net_dev->name);
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 	primary_if = NULL;
 
 out:
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 41f0c2c..96e1390 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1950,7 +1950,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1f10658..a6eac81 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -181,7 +181,7 @@ static void batadv_neigh_ifinfo_release(struct kref *ref)
 	neigh_ifinfo = container_of(ref, struct batadv_neigh_ifinfo, refcount);
 
 	if (neigh_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref(neigh_ifinfo->if_outgoing);
+		batadv_hardif_put(neigh_ifinfo->if_outgoing);
 
 	kfree_rcu(neigh_ifinfo, rcu);
 }
@@ -212,7 +212,7 @@ static void batadv_hardif_neigh_release(struct kref *ref)
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
-	batadv_hardif_free_ref(hardif_neigh->if_incoming);
+	batadv_hardif_put(hardif_neigh->if_incoming);
 	kfree_rcu(hardif_neigh, rcu);
 }
 
@@ -258,7 +258,7 @@ static void batadv_neigh_node_release(struct kref *ref)
 	if (bao->bat_neigh_free)
 		bao->bat_neigh_free(neigh_node);
 
-	batadv_hardif_free_ref(neigh_node->if_incoming);
+	batadv_hardif_put(neigh_node->if_incoming);
 
 	kfree_rcu(neigh_node, rcu);
 }
@@ -366,7 +366,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		goto out;
 
 	if (if_outgoing != BATADV_IF_DEFAULT &&
-	    !atomic_inc_not_zero(&if_outgoing->refcount)) {
+	    !kref_get_unless_zero(&if_outgoing->refcount)) {
 		kfree(orig_ifinfo);
 		orig_ifinfo = NULL;
 		goto out;
@@ -446,7 +446,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 	if (!neigh_ifinfo)
 		goto out;
 
-	if (if_outgoing && !atomic_inc_not_zero(&if_outgoing->refcount)) {
+	if (if_outgoing && !kref_get_unless_zero(&if_outgoing->refcount)) {
 		kfree(neigh_ifinfo);
 		neigh_ifinfo = NULL;
 		goto out;
@@ -523,12 +523,12 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (hardif_neigh)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount))
+	if (!kref_get_unless_zero(&hard_iface->refcount))
 		goto out;
 
 	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
 	if (!hardif_neigh) {
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 		goto out;
 	}
 
@@ -634,7 +634,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	if (!neigh_node)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+	if (!kref_get_unless_zero(&hard_iface->refcount)) {
 		kfree(neigh_node);
 		neigh_node = NULL;
 		goto out;
@@ -691,7 +691,7 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 		   primary_if->net_dev->dev_addr, net_dev->name,
 		   bat_priv->bat_algo_ops->name);
 
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 
 	if (!bat_priv->bat_algo_ops->bat_neigh_print) {
 		seq_puts(seq,
@@ -716,7 +716,7 @@ static void batadv_orig_ifinfo_release(struct kref *ref)
 	orig_ifinfo = container_of(ref, struct batadv_orig_ifinfo, refcount);
 
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref(orig_ifinfo->if_outgoing);
+		batadv_hardif_put(orig_ifinfo->if_outgoing);
 
 	/* this is the last reference to this object */
 	router = rcu_dereference_protected(orig_ifinfo->router, true);
@@ -1216,7 +1216,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		   primary_if->net_dev->dev_addr, net_dev->name,
 		   bat_priv->bat_algo_ops->name);
 
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 
 	if (!bat_priv->bat_algo_ops->bat_orig_print) {
 		seq_puts(seq,
@@ -1272,7 +1272,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (hard_iface)
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 	return 0;
 }
 
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 787da48..43b5875 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -269,7 +269,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -317,7 +317,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -702,7 +702,7 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 	ret = true;
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 
@@ -808,7 +808,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 
 	ether_addr_copy(unicast_packet->dest, primary_if->net_dev->dev_addr);
 
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 
 	unicast_packet->ttvn = curr_ttvn;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 06e21fa..be8011c 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -246,7 +246,7 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 	ret = true;
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return ret;
 }
 
@@ -409,9 +409,9 @@ static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
 	kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
-		batadv_hardif_free_ref(forw_packet->if_incoming);
+		batadv_hardif_put(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
-		batadv_hardif_free_ref(forw_packet->if_outgoing);
+		batadv_hardif_put(forw_packet->if_outgoing);
 	kfree(forw_packet);
 }
 
@@ -497,7 +497,7 @@ out_and_inc:
 	atomic_inc(&bat_priv->bcast_queue_left);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return NETDEV_TX_BUSY;
 }
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7268feb..c868afa 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -377,7 +377,7 @@ dropped_freed:
 	batadv_inc_counter(bat_priv, BATADV_CNT_TX_DROPPED);
 end:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return NETDEV_TX_OK;
 }
 
@@ -878,7 +878,7 @@ static int batadv_softif_slave_add(struct net_device *dev,
 
 out:
 	if (hard_iface)
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 	return ret;
 }
 
@@ -905,7 +905,7 @@ static int batadv_softif_slave_del(struct net_device *dev,
 
 out:
 	if (hard_iface)
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 	return ret;
 }
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 63a86c2..acf85d9 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -771,7 +771,7 @@ static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 
 	length = sprintf(buff, "%s\n", ifname);
 
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 
 	return length;
 }
@@ -795,7 +795,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: interface name too long '%s'\n",
 		       buff);
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 		return -EINVAL;
 	}
 
@@ -829,7 +829,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 unlock:
 	rtnl_unlock();
 out:
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 	return ret;
 }
 
@@ -863,7 +863,7 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 		break;
 	}
 
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 
 	return length;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f25b533..1ebdcd7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1023,7 +1023,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -1687,7 +1687,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -2600,7 +2600,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
 		/* hlist_del_init() verifies tt_req_node still is in the list */
@@ -2857,7 +2857,7 @@ out:
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	kfree(tvlv_tt_data);
 	/* The packet was for this host, so it doesn't need to be re-routed */
 	return true;
@@ -3180,7 +3180,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 static void batadv_tt_purge(struct work_struct *work)
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

