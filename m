Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:38 +0100
Message-Id: <1451992006-13191-23-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 23/31] batman-adv: Convert
	batadv_tt_orig_list_entry to kref
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

 net/batman-adv/translation-table.c | 26 +++++++++++++++++---------
 net/batman-adv/types.h             |  2 +-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9fcf6bf..0f61b03 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -31,6 +31,7 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -346,22 +347,28 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 /**
  * batadv_tt_orig_list_entry_release - release tt orig entry from lists and
  *  queue for free after rcu grace period
- * @orig_entry: tt orig entry to be free'd
+ * @ref: kref pointer of the tt orig entry
  */
-static void
-batadv_tt_orig_list_entry_release(struct batadv_tt_orig_list_entry *orig_entry)
+static void batadv_tt_orig_list_entry_release(struct kref *ref)
 {
+	struct batadv_tt_orig_list_entry *orig_entry;
+
+	orig_entry = container_of(ref, struct batadv_tt_orig_list_entry,
+				  refcount);
+
 	batadv_orig_node_free_ref(orig_entry->orig_node);
 	kfree_rcu(orig_entry, rcu);
 }
 
+/**
+ * batadv_tt_orig_list_entry_free_ref - decrement the tt orig entry refcounter
+ *  and possibly release it
+ * @orig_entry: tt orig entry to be free'd
+ */
 static void
 batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
-	if (!atomic_dec_and_test(&orig_entry->refcount))
-		return;
-
-	batadv_tt_orig_list_entry_release(orig_entry);
+	kref_put(&orig_entry->refcount, batadv_tt_orig_list_entry_release);
 }
 
 /**
@@ -1270,7 +1277,7 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 	hlist_for_each_entry_rcu(tmp_orig_entry, head, list) {
 		if (tmp_orig_entry->orig_node != orig_node)
 			continue;
-		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
+		if (!kref_get_unless_zero(&tmp_orig_entry->refcount))
 			continue;
 
 		orig_entry = tmp_orig_entry;
@@ -1331,7 +1338,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	batadv_tt_global_size_inc(orig_node, tt_global->common.vid);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
-	atomic_set(&orig_entry->refcount, 2);
+	kref_init(&orig_entry->refcount);
+	kref_get(&orig_entry->refcount);
 
 	spin_lock_bh(&tt_global->list_lock);
 	hlist_add_head_rcu(&orig_entry->list,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 60d304b..58ae09e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1014,7 +1014,7 @@ struct batadv_tt_orig_list_entry {
 	struct batadv_orig_node *orig_node;
 	u8 ttvn;
 	struct hlist_node list;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

