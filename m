Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:02 +0100
Message-Id: <20171215114320.13645-3-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/20] batman-adv: Deinline
 batadv_orig_hash_find, save 7339 bytes
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Denys Vlasenko <dvlasenk@redhat.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Denys Vlasenko <dvlasenk@redhat.com>

This function compiles to 288 bytes of machine code for Linux 4.14 on
Debian Stretch amd64 and (6.3.0-18) with the default configuration. 27
callsites (25 used in default config).

   text    data     bss     dec     hex filename
 179291   10317    4416  194024   2f5e8 batman-adv.ko.pre
 171952   10317    4416  186685   2d93d batman-adv.ko.post

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
[sven@narfation.org: Fix includes, correct sizes+counts in commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 32 ++++++++++++++++++++++++++++++++
 net/batman-adv/originator.h | 37 ++-----------------------------------
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2967b86c13da..0a565d0422bb 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -30,10 +30,12 @@
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/stddef.h>
 #include <linux/workqueue.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
@@ -55,6 +57,36 @@
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
 
+struct batadv_orig_node *
+batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
+{
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
+	int index;
+
+	if (!hash)
+		return NULL;
+
+	index = batadv_choose_orig(data, hash->size);
+	head = &hash->table[index];
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+		if (!batadv_compare_eth(orig_node, data))
+			continue;
+
+		if (!kref_get_unless_zero(&orig_node->refcount))
+			continue;
+
+		orig_node_tmp = orig_node;
+		break;
+	}
+	rcu_read_unlock();
+
+	return orig_node_tmp;
+}
+
 static void batadv_purge_orig(struct work_struct *work);
 
 /**
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index d94220a6d21a..40c7f039d5d7 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -23,14 +23,8 @@
 #include <linux/compiler.h>
 #include <linux/if_ether.h>
 #include <linux/jhash.h>
-#include <linux/kref.h>
-#include <linux/rculist.h>
-#include <linux/rcupdate.h>
-#include <linux/stddef.h>
 #include <linux/types.h>
 
-#include "hash.h"
-
 struct netlink_callback;
 struct seq_file;
 struct sk_buff;
@@ -100,34 +94,7 @@ static inline u32 batadv_choose_orig(const void *data, u32 size)
 	return hash % size;
 }
 
-static inline struct batadv_orig_node *
-batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
-{
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
-	int index;
-
-	if (!hash)
-		return NULL;
-
-	index = batadv_choose_orig(data, hash->size);
-	head = &hash->table[index];
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-		if (!batadv_compare_eth(orig_node, data))
-			continue;
-
-		if (!kref_get_unless_zero(&orig_node->refcount))
-			continue;
-
-		orig_node_tmp = orig_node;
-		break;
-	}
-	rcu_read_unlock();
-
-	return orig_node_tmp;
-}
+struct batadv_orig_node *
+batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data);
 
 #endif /* _NET_BATMAN_ADV_ORIGINATOR_H_ */
-- 
2.11.0

