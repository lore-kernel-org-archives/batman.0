Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:18:09 +0100
Message-Id: <1450617490-3544-29-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 29/30] batman-adv: Convert
	batadv_tt_common_entry to kref
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

 net/batman-adv/translation-table.c | 64 +++++++++++++++++++++++++++++---------
 net/batman-adv/types.h             |  2 +-
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7d395b6..898d438 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -142,7 +142,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		if (tt->vid != vid)
 			continue;
 
-		if (!atomic_inc_not_zero(&tt->refcount))
+		if (!kref_get_unless_zero(&tt->refcount))
 			continue;
 
 		tt_tmp = tt;
@@ -203,25 +203,59 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
-static void
-batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
+/**
+ * batadv_tt_local_entry_release - release tt_local_entry from lists and queue
+ *  for free after rcu grace period
+ * @ref: kref pointer of the nc_node
+ */
+static void batadv_tt_local_entry_release(struct kref *ref)
 {
-	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
-		kfree_rcu(tt_local_entry, common.rcu);
+	struct batadv_tt_local_entry *tt_local_entry;
+
+	tt_local_entry = container_of(ref, struct batadv_tt_local_entry,
+				      common.refcount);
+
+	kfree_rcu(tt_local_entry, common.rcu);
 }
 
 /**
- * batadv_tt_global_entry_free_ref - decrement the refcounter for a
- *  tt_global_entry and possibly free it
- * @tt_global_entry: the object to free
+ * batadv_tt_local_entry_free_ref - decrement the tt_local_entry refcounter and
+ *  possibly release it
+ * @tt_local_entry: tt_local_entry to be free'd
+ */
+static void
+batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
+{
+	kref_put(&tt_local_entry->common.refcount,
+		 batadv_tt_local_entry_release);
+}
+
+/**
+ * batadv_tt_global_entry_release - release tt_global_entry from lists and queue
+ *  for free after rcu grace period
+ * @ref: kref pointer of the nc_node
+ */
+static void batadv_tt_global_entry_release(struct kref *ref)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+
+	tt_global_entry = container_of(ref, struct batadv_tt_global_entry,
+				       common.refcount);
+
+	batadv_tt_global_del_orig_list(tt_global_entry);
+	kfree_rcu(tt_global_entry, common.rcu);
+}
+
+/**
+ * batadv_tt_global_entry_free_ref - decrement the tt_global_entry refcounter
+ *  and possibly release it
+ * @tt_global_entry: tt_global_entry to be free'd
  */
 static void
 batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 {
-	if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
-		batadv_tt_global_del_orig_list(tt_global_entry);
-		kfree_rcu(tt_global_entry, common.rcu);
-	}
+	kref_put(&tt_global_entry->common.refcount,
+		 batadv_tt_global_entry_release);
 }
 
 /**
@@ -633,7 +667,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	tt_local->common.vid = vid;
 	if (batadv_is_wifi_netdev(in_dev))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	atomic_set(&tt_local->common.refcount, 2);
+	kref_init(&tt_local->common.refcount);
+	kref_get(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 
@@ -1415,7 +1450,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 */
 		if (flags & BATADV_TT_CLIENT_ROAM)
 			tt_global_entry->roam_at = jiffies;
-		atomic_set(&common->refcount, 2);
+		kref_init(&common->refcount);
+		kref_get(&common->refcount);
 		common->added_at = jiffies;
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c8c7ab8..ef421ba 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -972,7 +972,7 @@ struct batadv_tt_common_entry {
 	struct hlist_node hash_entry;
 	u16 flags;
 	unsigned long added_at;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

