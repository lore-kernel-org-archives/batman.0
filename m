Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:27 +0100
Message-Id: <1417519009-20699-10-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/31] batman-adv: hash, Add helper functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Add helper functions for the hash structure in an attempt to capsulate
the hash struct. It creates a cleaner and more defined interface to the
hashtable and it is more obvious how the hash table is accessed.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 hash.c | 21 +++++++++++++++++++++
 hash.h |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/hash.c b/hash.c
index c68bb8b3e8b9..d3313b54347c 100644
--- a/hash.c
+++ b/hash.c
@@ -18,6 +18,27 @@
 #include "main.h"
 #include "hash.h"
 
+uint32_t batadv_hash_size(struct batadv_hashtable *hash)
+{
+	return hash->size;
+}
+
+struct hlist_head *batadv_hash_get(struct batadv_hashtable *hash,
+				   uint32_t index)
+{
+	return &hash->table[index];
+}
+
+void batadv_hash_lock(struct batadv_hashtable *hash, uint32_t index)
+{
+	spin_lock_bh(&hash->list_locks[index]);
+}
+
+void batadv_hash_unlock(struct batadv_hashtable *hash, uint32_t index)
+{
+	spin_unlock_bh(&hash->list_locks[index]);
+}
+
 /* clears the hash */
 static void batadv_hash_init(struct batadv_hashtable *hash)
 {
diff --git a/hash.h b/hash.h
index 0761b64be337..d0681ecac0f0 100644
--- a/hash.h
+++ b/hash.h
@@ -63,4 +63,13 @@ void *batadv_hash_remove(struct batadv_hashtable *hash,
 			 batadv_hashdata_compare_cb compare,
 			 batadv_hashdata_choose_cb choose, void *data);
 
+uint32_t batadv_hash_size(struct batadv_hashtable *hash);
+
+struct hlist_head *batadv_hash_get(struct batadv_hashtable *hash,
+				   uint32_t index);
+
+void batadv_hash_lock(struct batadv_hashtable *hash, uint32_t index);
+
+void batadv_hash_unlock(struct batadv_hashtable *hash, uint32_t index);
+
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
-- 
2.1.3

