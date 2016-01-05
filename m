Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:40 +0100
Message-Id: <1451992006-13191-25-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 25/31] batman-adv: Convert
	batadv_orig_ifinfo to kref
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

 net/batman-adv/originator.c | 15 +++++++++------
 net/batman-adv/routing.c    |  5 +++--
 net/batman-adv/types.h      |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index eb366c5..4874526 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -326,7 +326,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 		if (tmp->if_outgoing != if_outgoing)
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp->refcount))
+		if (!kref_get_unless_zero(&tmp->refcount))
 			continue;
 
 		orig_ifinfo = tmp;
@@ -377,7 +377,8 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 	orig_ifinfo->batman_seqno_reset = reset_time;
 	orig_ifinfo->if_outgoing = if_outgoing;
 	INIT_HLIST_NODE(&orig_ifinfo->list);
-	atomic_set(&orig_ifinfo->refcount, 2);
+	kref_init(&orig_ifinfo->refcount);
+	kref_get(&orig_ifinfo->refcount);
 	hlist_add_head_rcu(&orig_ifinfo->list,
 			   &orig_node->ifinfo_list);
 out:
@@ -704,12 +705,15 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 /**
  * batadv_orig_ifinfo_release - release orig_ifinfo from lists and queue for
  *  free after rcu grace period
- * @orig_ifinfo: the orig_ifinfo object to release
+ * @ref: kref pointer of the orig_ifinfo
  */
-static void batadv_orig_ifinfo_release(struct batadv_orig_ifinfo *orig_ifinfo)
+static void batadv_orig_ifinfo_release(struct kref *ref)
 {
+	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *router;
 
+	orig_ifinfo = container_of(ref, struct batadv_orig_ifinfo, refcount);
+
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
 		batadv_hardif_free_ref(orig_ifinfo->if_outgoing);
 
@@ -728,8 +732,7 @@ static void batadv_orig_ifinfo_release(struct batadv_orig_ifinfo *orig_ifinfo)
  */
 void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
 {
-	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		batadv_orig_ifinfo_release(orig_ifinfo);
+	kref_put(&orig_ifinfo->refcount, batadv_orig_ifinfo_release);
 }
 
 /**
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0ba5993..99fd1df 100644
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

