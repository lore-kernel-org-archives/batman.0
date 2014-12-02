Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:29 +0100
Message-Id: <1417519009-20699-12-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/31] batman-adv: hash,
	make struct hashtable private
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

All accesses to the struct hashtable were replaced by accessor functions
so we can move the struct into the private scope of the hashtable
implementation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 hash.c | 6 ++++++
 hash.h | 8 ++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hash.c b/hash.c
index d3313b54347c..1d3e5ebaa7ad 100644
--- a/hash.c
+++ b/hash.c
@@ -18,6 +18,12 @@
 #include "main.h"
 #include "hash.h"
 
+struct batadv_hashtable {
+	struct hlist_head *table;   /* the hashtable itself with the buckets */
+	spinlock_t *list_locks;     /* spinlock for each hash list entry */
+	uint32_t size;		    /* size of hashtable */
+};
+
 uint32_t batadv_hash_size(struct batadv_hashtable *hash)
 {
 	return hash->size;
diff --git a/hash.h b/hash.h
index d0681ecac0f0..8f5f832acd7c 100644
--- a/hash.h
+++ b/hash.h
@@ -20,6 +20,8 @@
 
 #include <linux/list.h>
 
+struct batadv_hashtable;
+
 /* callback to a compare function.  should compare 2 element datas for their
  * keys, return 0 if same and not 0 if not same
  */
@@ -33,12 +35,6 @@ typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
 typedef uint32_t (*batadv_hashdata_choose_cb)(const void *, uint32_t);
 typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 
-struct batadv_hashtable {
-	struct hlist_head *table;   /* the hashtable itself with the buckets */
-	spinlock_t *list_locks;     /* spinlock for each hash list entry */
-	uint32_t size;		    /* size of hashtable */
-};
-
 /* allocates and clears the hash */
 struct batadv_hashtable *batadv_hash_new(uint32_t size);
 
-- 
2.1.3

