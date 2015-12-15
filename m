Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:45 +0100
Message-Id: <1450222316-1764-12-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 12/23] batman-adv: Convert batadv_dat_entry
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
 net/batman-adv/distributed-arp-table.c | 43 +++++++++++++++++++++++-----------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 60df823..34d0950 100644
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
- * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
- * free it
- * @dat_entry: the entry to free
+ * batadv_dat_entry_release - release dat_entry from lists and queue for free
+ *  after rcu grace period
+ * * @ref: kref pointer of the dat_entry
  */
-static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
+static void batadv_dat_entry_release(struct kref *ref)
 {
-	if (atomic_dec_and_test(&dat_entry->refcount))
-		kfree_rcu(dat_entry, rcu);
+	struct batadv_dat_entry *dat_entry;
+
+	dat_entry = container_of(ref, struct batadv_dat_entry, refcount);
+
+	kfree_rcu(dat_entry, rcu);
+}
+
+/**
+ * batadv_dat_entry_put - decrement the dat_entry refcounter and possibly
+ * free it
+ * @dat_entry: dat_entry to be free'd
+ */
+static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
+{
+	kref_put(&dat_entry->refcount, batadv_dat_entry_release);
 }
 
 /**
@@ -121,7 +135,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 				continue;
 
 			hlist_del_rcu(&dat_entry->hash_entry);
-			batadv_dat_entry_free_ref(dat_entry);
+			batadv_dat_entry_put(dat_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
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
@@ -334,7 +349,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 		goto out;
 	}
 
@@ -343,7 +358,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -1014,7 +1029,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	return ret;
 }
 
@@ -1094,7 +1109,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	if (ret)
 		kfree_skb(skb);
 	return ret;
@@ -1247,6 +1262,6 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	return ret;
 }
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

