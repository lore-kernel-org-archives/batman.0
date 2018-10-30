Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 22:01:25 +0100
Message-Id: <20181030210130.18152-5-sven@narfation.org>
In-Reply-To: <20181030210130.18152-1-sven@narfation.org>
References: <20181030210130.18152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Store modification counter
 via hash helpers
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

Multiple datastructures use the hash helper functions to add and remove
entries from the simple hlist based hashes. These are often also dumped to
userspace via netlink and thus should have a generation sequence counter.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hash.c | 2 ++
 net/batman-adv/hash.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 7b49e400..9194f4d8 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -32,6 +32,8 @@ static void batadv_hash_init(struct batadv_hashtable *hash)
 		INIT_HLIST_HEAD(&hash->table[i]);
 		spin_lock_init(&hash->list_locks[i]);
 	}
+
+	atomic_set(&hash->generation, 0);
 }
 
 /**
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 9490a7ca..0e36fa1c 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -21,6 +21,7 @@
 
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/rculist.h>
@@ -58,6 +59,9 @@ struct batadv_hashtable {
 
 	/** @size: size of hashtable */
 	u32 size;
+
+	/** @generation: current (generation) sequence number */
+	atomic_t generation;
 };
 
 /* allocates and clears the hash */
@@ -112,6 +116,7 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 
 	/* no duplicate found in list, add new element */
 	hlist_add_head_rcu(data_node, head);
+	atomic_inc(&hash->generation);
 
 	ret = 0;
 
@@ -154,6 +159,7 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 
 		data_save = node;
 		hlist_del_rcu(node);
+		atomic_inc(&hash->generation);
 		break;
 	}
 	spin_unlock_bh(&hash->list_locks[index]);
-- 
2.19.1

