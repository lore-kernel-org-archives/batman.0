Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:57 +0100
Message-Id: <20181114140804.18381-10-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/16] batman-adv: Store modification counter
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Multiple datastructures use the hash helper functions to add and remove
entries from the simple hlist based hashes. These are often also dumped to
userspace via netlink and thus should have a generation sequence counter.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hash.c | 2 ++
 net/batman-adv/hash.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 7b49e4001778..9194f4d891b1 100644
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
index 9490a7ca2ba6..0e36fa1c7c3e 100644
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
2.11.0

