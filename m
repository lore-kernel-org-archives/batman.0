Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  2 Dec 2017 19:51:50 +0100
Message-Id: <20171202185153.552-6-sven@narfation.org>
In-Reply-To: <20171202185153.552-1-sven@narfation.org>
References: <20171202185153.552-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: Add kernel-doc to structs in
 headers
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

All structs in types.h are already documented. But some other headers
still have private structs which also should be documented.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hash.h  | 14 +++++++++++---
 net/batman-adv/sysfs.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 1aabe40b..accac5c2 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -45,10 +45,18 @@ typedef bool (*batadv_hashdata_compare_cb)(const struct hlist_node *,
 typedef u32 (*batadv_hashdata_choose_cb)(const void *, u32);
 typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 
+/**
+ * struct batadv_hashtable - Wrapper of simple hlist based hashtable
+ */
 struct batadv_hashtable {
-	struct hlist_head *table;   /* the hashtable itself with the buckets */
-	spinlock_t *list_locks;     /* spinlock for each hash list entry */
-	u32 size;		    /* size of hashtable */
+	/** @table: the hashtable itself with the buckets */
+	struct hlist_head *table;
+
+	/** @list_locks: spinlock for each hash list entry */
+	spinlock_t *list_locks;
+
+	/** @size: size of hashtable */
+	u32 size;
 };
 
 /* allocates and clears the hash */
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index e487412e..8fe65c9b 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -35,10 +35,23 @@ struct net_device;
  */
 #define BATADV_SYSFS_VLAN_SUBDIR_PREFIX "vlan"
 
+/**
+ * struct batadv_attribute - sysfs export helper for batman-adv attributes
+ */
 struct batadv_attribute {
+	/** @attr: sysfs attribute file */
 	struct attribute attr;
+
+	/**
+	 * @show: function to export the current attribute's content to sysfs
+	 */
 	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
 			char *buf);
+
+	/**
+	 * @store: function to load new value from character buffer and save it
+	 * in batman-adv attribute
+	 */
 	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
 			 char *buf, size_t count);
 };
-- 
2.11.0

