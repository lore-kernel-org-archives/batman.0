Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:17 +0100
Message-Id: <20171215114320.13645-18-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 17/20] batman-adv: Add kernel-doc to structs
 in headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

All structs in types.h are already documented. But some other headers
still have private structs which also should be documented.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hash.h  | 14 +++++++++++---
 net/batman-adv/sysfs.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 7647757d3660..239f394512b9 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -48,10 +48,18 @@ typedef bool (*batadv_hashdata_compare_cb)(const struct hlist_node *,
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
index 0a3d41d52208..7cf7da70e1a5 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -38,10 +38,23 @@ struct net_device;
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

