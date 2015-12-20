Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:59 +0100
Message-Id: <1450617490-3544-19-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 19/30] batman-adv: Convert
	batadv_dat_entry to kref
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

 net/batman-adv/distributed-arp-table.c | 25 ++++++++++++++++++++-----
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 60df823..ffbc45d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -30,6 +30,7 @@
 #include <linux/in.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -62,14 +63,27 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_dat_entry_release - release dat_entry from lists and queue for free
+ *  after rcu grace period
+ * @ref: kref pointer of the dat_entry
+ */
+static void batadv_dat_entry_release(struct kref *ref)
+{
+	struct batadv_dat_entry *dat_entry;
+
+	dat_entry = container_of(ref, struct batadv_dat_entry, refcount);
+
+	kfree_rcu(dat_entry, rcu);
+}
+
+/**
  * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
  * free it
- * @dat_entry: the entry to free
+ * @dat_entry: dat_entry to be free'd
  */
 static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
 {
-	if (atomic_dec_and_test(&dat_entry->refcount))
-		kfree_rcu(dat_entry, rcu);
+	kref_put(&dat_entry->refcount, batadv_dat_entry_release);
 }
 
 /**
@@ -281,7 +295,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 		if (dat_entry->ip != ip)
 			continue;
 
-		if (!atomic_inc_not_zero(&dat_entry->refcount))
+		if (!kref_get_unless_zero(&dat_entry->refcount))
 			continue;
 
 		dat_entry_tmp = dat_entry;
@@ -326,7 +340,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->vid = vid;
 	ether_addr_copy(dat_entry->mac_addr, mac_addr);
 	dat_entry->last_update = jiffies;
-	atomic_set(&dat_entry->refcount, 2);
+	kref_init(&dat_entry->refcount);
+	kref_get(&dat_entry->refcount);
 
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 49f0270..a6ba6c0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1230,7 +1230,7 @@ struct batadv_dat_entry {
 	unsigned short vid;
 	unsigned long last_update;
 	struct hlist_node hash_entry;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

