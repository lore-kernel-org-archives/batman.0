Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:50 +0100
Message-Id: <1450222316-1764-17-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 17/23] batman-adv: Convert batadv_orig_ifinfo
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
 net/batman-adv/bat_iv_ogm.c     |  4 ++--
 net/batman-adv/network-coding.c |  2 +-
 net/batman-adv/originator.c     | 46 ++++++++++++++++-------------------------
 net/batman-adv/originator.h     |  2 +-
 net/batman-adv/routing.c        | 13 ++++++------
 net/batman-adv/types.h          |  2 +-
 6 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index cfd2afe..f128e60 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1365,7 +1365,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	batadv_orig_node_free_ref(orig_node);
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 	return ret;
 }
 
@@ -1511,7 +1511,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 					  ogm_packet, if_incoming,
 					  if_outgoing, dup_status);
 	}
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	/* only forward for specific interface, not for the default one. */
 	if (if_outgoing == BATADV_IF_DEFAULT)
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9e96e7c..329219b 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -772,7 +772,7 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
 
 	last_ttl = orig_ifinfo->last_ttl;
 	last_real_seqno = orig_ifinfo->last_real_seqno;
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	if (last_real_seqno != ntohl(ogm_packet->seqno))
 		return false;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0a00757..919f464 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -339,7 +339,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 		if (tmp->if_outgoing != if_outgoing)
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp->refcount))
+		if (!kref_get_unless_zero(&tmp->refcount))
 			continue;
 
 		orig_ifinfo = tmp;
@@ -390,7 +390,8 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 	orig_ifinfo->batman_seqno_reset = reset_time;
 	orig_ifinfo->if_outgoing = if_outgoing;
 	INIT_HLIST_NODE(&orig_ifinfo->list);
-	atomic_set(&orig_ifinfo->refcount, 2);
+	kref_init(&orig_ifinfo->refcount);
+	kref_get(&orig_ifinfo->refcount);
 	hlist_add_head_rcu(&orig_ifinfo->list,
 			   &orig_node->ifinfo_list);
 out:
@@ -715,47 +716,36 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 }
 
 /**
- * batadv_orig_ifinfo_free_rcu - free the orig_ifinfo object
- * @rcu: rcu pointer of the orig_ifinfo object
+ * batadv_orig_ifinfo_release - release orig_ifinfo from lists and queue for
+ *  free after rcu grace period
+ * @ref: kref pointer of the orig_ifinfo
  */
-static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
+static void batadv_orig_ifinfo_release(struct kref *ref)
 {
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *router;
 
-	orig_ifinfo = container_of(rcu, struct batadv_orig_ifinfo, rcu);
+	orig_ifinfo = container_of(ref, struct batadv_orig_ifinfo, refcount);
 
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref_now(orig_ifinfo->if_outgoing);
+		batadv_hardif_free_ref(orig_ifinfo->if_outgoing);
 
 	/* this is the last reference to this object */
 	router = rcu_dereference_protected(orig_ifinfo->router, true);
 	if (router)
-		batadv_neigh_node_free_ref_now(router);
-	kfree(orig_ifinfo);
+		batadv_neigh_node_free_ref(router);
+
+	kfree_rcu(orig_ifinfo, rcu);
 }
 
 /**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
- *  the orig_ifinfo (without rcu callback)
- * @orig_ifinfo: the orig_ifinfo object to release
- */
-static void
-batadv_orig_ifinfo_free_ref_now(struct batadv_orig_ifinfo *orig_ifinfo)
-{
-	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		batadv_orig_ifinfo_free_rcu(&orig_ifinfo->rcu);
-}
-
-/**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
+ * batadv_orig_ifinfo_put - decrement the refcounter and possibly free
  *  the orig_ifinfo
  * @orig_ifinfo: the orig_ifinfo object to release
  */
-void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
+void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo)
 {
-	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		call_rcu(&orig_ifinfo->rcu, batadv_orig_ifinfo_free_rcu);
+	kref_put(&orig_ifinfo->refcount, batadv_orig_ifinfo_release);
 }
 
 static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
@@ -779,7 +769,7 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
 				  &orig_node->ifinfo_list, list) {
 		hlist_del_rcu(&orig_ifinfo->list);
-		batadv_orig_ifinfo_free_ref_now(orig_ifinfo);
+		batadv_orig_ifinfo_put(orig_ifinfo);
 	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
@@ -1000,10 +990,10 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 		ifinfo_purged = true;
 
 		hlist_del_rcu(&orig_ifinfo->list);
-		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+		batadv_orig_ifinfo_put(orig_ifinfo);
 		if (orig_node->last_bonding_candidate == orig_ifinfo) {
 			orig_node->last_bonding_candidate = NULL;
-			batadv_orig_ifinfo_free_ref(orig_ifinfo);
+			batadv_orig_ifinfo_put(orig_ifinfo);
 		}
 	}
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 5b2dc06..db1a65d 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -69,7 +69,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
-void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo);
+void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo);
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0ba5993..1018148 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -25,6 +25,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
+#include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
@@ -106,7 +107,7 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	/* decrease refcount of previous best neighbor */
 	if (curr_router)
@@ -497,7 +498,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 
 	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
 		/* acquire some structures and references ... */
-		if (!atomic_inc_not_zero(&cand->refcount))
+		if (!kref_get_unless_zero(&cand->refcount))
 			continue;
 
 		cand_router = rcu_dereference(cand->router);
@@ -524,7 +525,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		/* mark the first possible candidate */
 		if (!first_candidate) {
 			atomic_inc(&cand_router->refcount);
-			atomic_inc(&cand->refcount);
+			kref_get(&cand->refcount);
 			first_candidate = cand;
 			first_candidate_router = cand_router;
 		}
@@ -547,13 +548,13 @@ next:
 			batadv_neigh_node_free_ref(cand_router);
 			cand_router = NULL;
 		}
-		batadv_orig_ifinfo_free_ref(cand);
+		batadv_orig_ifinfo_put(cand);
 	}
 	rcu_read_unlock();
 
 	/* last_bonding_candidate is reset below, remove the old reference. */
 	if (orig_node->last_bonding_candidate)
-		batadv_orig_ifinfo_free_ref(orig_node->last_bonding_candidate);
+		batadv_orig_ifinfo_put(orig_node->last_bonding_candidate);
 
 	/* After finding candidates, handle the three cases:
 	 * 1) there is a next candidate, use that
@@ -566,7 +567,7 @@ next:
 		/* remove references to first candidate, we don't need it. */
 		if (first_candidate) {
 			batadv_neigh_node_free_ref(first_candidate_router);
-			batadv_orig_ifinfo_free_ref(first_candidate);
+			batadv_orig_ifinfo_put(first_candidate);
 		}
 		router = next_candidate_router;
 		orig_node->last_bonding_candidate = next_candidate;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7831bf0..a5e4310 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -141,7 +141,7 @@ struct batadv_orig_ifinfo {
 	u32 last_real_seqno;
 	u8 last_ttl;
 	unsigned long batman_seqno_reset;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

