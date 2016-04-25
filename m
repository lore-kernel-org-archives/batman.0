Return-Path: <dvlasenk@redhat.com>
From: Denys Vlasenko <dvlasenk@redhat.com>
Date: Mon, 25 Apr 2016 15:25:22 +0200
Message-Id: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Deinline batadv_orig_hash_find,
	save 9024 bytes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, linux-kernel@vger.kernel.org

This function compiles to 473 bytes of machine code.
21 callsites.

    text     data      bss       dec     hex filename
95903266 20860288 35991552 152755106 91adba2 vmlinux_before
95894242 20860288 35991552 152746082 91ab862 vmlinux

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Marek Lindner <mareklindner@neomailbox.ch>
CC: Simon Wunderlich <sw@simonwunderlich.de>
CC: Antonio Quartulli <a@unstable.cc>
CC: Sven Eckelmann <sven@narfation.org>
CC: b.a.t.m.a.n@lists.open-mesh.org
CC: linux-kernel@vger.kernel.org
---
 net/batman-adv/originator.c | 29 +++++++++++++++++++++++++++++
 net/batman-adv/originator.h | 31 ++-----------------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e4cbb07..bcf78f1 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -47,6 +47,36 @@
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
index 4e8b67f..db7a87d 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -96,34 +96,7 @@ static inline u32 batadv_choose_orig(const void *data, u32 size)
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
1.8.1.4

