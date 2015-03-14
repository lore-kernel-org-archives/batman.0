Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:59 +0100
Message-Id: <1426333379-17777-15-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 14/14] alfred: Use Linux-net style comment
	blocks
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h       |  4 +---
 batadv_query.c |  4 +---
 batadv_query.h |  5 ++---
 client.c       |  4 +---
 debugfs.c      |  4 +---
 debugfs.h      |  4 +---
 hash.c         | 40 +++++++++++++++++++++++++---------------
 hash.h         | 32 ++++++++++++++++++++------------
 list.h         |  4 +---
 main.c         |  4 +---
 netsock.c      |  4 +---
 packet.h       |  4 +---
 recv.c         | 10 +++++-----
 send.c         |  7 +++----
 server.c       |  4 +---
 unix_sock.c    |  4 +---
 util.c         |  4 +---
 17 files changed, 67 insertions(+), 75 deletions(-)

diff --git a/alfred.h b/alfred.h
index f26c80c..2fc8da6 100644
--- a/alfred.h
+++ b/alfred.h
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #ifndef SOURCE_VERSION
diff --git a/batadv_query.c b/batadv_query.c
index c289b80..6a7abea 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include "batadv_query.h"
diff --git a/batadv_query.h b/batadv_query.h
index 8991ee9..694ef4c 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
@@ -16,8 +15,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
+
 #ifndef _BATADV_QUERY_H
 #define _BATADV_QUERY_H
 
diff --git a/client.c b/client.c
index 22b8439..91a0696 100644
--- a/client.c
+++ b/client.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <ctype.h>
diff --git a/debugfs.c b/debugfs.c
index fbf992e..a672f55 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2009 Clark Williams <williams@redhat.com>
+/* Copyright (C) 2009 Clark Williams <williams@redhat.com>
  * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
  *
  * This program is free software; you can redistribute it and/or
@@ -15,7 +14,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include "debugfs.h"
diff --git a/debugfs.h b/debugfs.h
index b4dc6bb..8fe7eab 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2009 Clark Williams <williams@redhat.com>
+/* Copyright (C) 2009 Clark Williams <williams@redhat.com>
  * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
  *
  * This program is free software; you can redistribute it and/or
@@ -15,7 +14,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #ifndef __DEBUGFS_H__
diff --git a/hash.c b/hash.c
index f2c8b9c..c6b34a4 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include "hash.h"
@@ -37,7 +35,8 @@ void hash_init(struct hashtable_t *hash)
 
 /* remove the hash structure. if hashdata_free_cb != NULL,
  * this function will be called to remove the elements inside of the hash.
- * if you don't remove the elements, memory might be leaked. */
+ * if you don't remove the elements, memory might be leaked.
+ */
 void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 {
 	struct element_t *bucket, *last_bucket;
@@ -60,7 +59,8 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 }
 
 /* adds data to the hashtable and reuse bucket.
- * returns 0 on success, -1 on error  */
+ * returns 0 on success, -1 on error
+ */
 static int hash_add_bucket(struct hashtable_t *hash, void *data,
 			   struct element_t *bucket, int check_duplicate)
 {
@@ -108,7 +108,8 @@ void hash_iterate_free(struct hash_it_t *iter_in)
 
 /* iterate though the hash. first element is selected with iter_in NULL.
  * use the returned iterator to access the elements until hash_it_t returns
- * NULL. */
+ * NULL.
+ */
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			       struct hash_it_t *iter_in)
 {
@@ -124,11 +125,13 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	}
 
 	/* sanity checks first (if our bucket got deleted in the last
-	 * iteration): */
+	 * iteration):
+	 */
 	if (iter->bucket) {
 		if (iter->first_bucket) {
 			/* we're on the first element and it got removed after
-			 * the last iteration. */
+			 * the last iteration.
+			 */
 			if ((*iter->first_bucket) != iter->bucket) {
 				/* there are still other elements in the list */
 				if (*iter->first_bucket) {
@@ -144,7 +147,8 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			/* we're not on the first element, and the bucket got
 			 * removed after the last iteration. The last bucket's
 			 * next pointer is not pointing to our actual bucket
-			 * anymore. Select the next. */
+			 * anymore. Select the next.
+			 */
 			if (iter->prev_bucket->next != iter->bucket)
 				iter->bucket = iter->prev_bucket;
 		}
@@ -160,7 +164,8 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 		}
 	}
 	/* if not returned yet, we've reached the last one on the index and
-	 * have to search forward */
+	 * have to search forward
+	 */
 
 	iter->index++;
 	/* go through the entries of the hash table */
@@ -225,7 +230,8 @@ int hash_add(struct hashtable_t *hash, void *data)
 }
 
 /* finds data, based on the key in keydata. returns the found data on success,
- * or NULL on error */
+ * or NULL on error
+ */
 void *hash_find(struct hashtable_t *hash, void *keydata)
 {
 	int index;
@@ -247,7 +253,8 @@ void *hash_find(struct hashtable_t *hash, void *keydata)
 /* remove bucket (this might be used in hash_iterate() if you already found
  * the bucket you want to delete and don't need the overhead to find it again
  * with hash_remove(). But usually, you don't want to use this function, as it
- * fiddles with hash-internals. */
+ * fiddles with hash-internals.
+ */
 void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 {
 	void *data_save;
@@ -269,7 +276,8 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 /* removes data from hash, if found. returns pointer do data on success,
  * so you can remove the used structure yourself, or NULL on error .
  * data could be the structure you use with just the key filled,
- * we just need the key for comparing. */
+ * we just need the key for comparing.
+ */
 void *hash_remove(struct hashtable_t *hash, void *data)
 {
 	struct hash_it_t hash_it_t;
@@ -298,7 +306,8 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 }
 
 /* resize the hash, returns the pointer to the new hash or NULL on error.
- * removes the old hash on success. */
+ * removes the old hash on success.
+ */
 struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 {
 	struct hashtable_t *new_hash;
@@ -319,7 +328,8 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 		}
 	}
 	/* remove hash and eventual overflow buckets but not the
-	 * content itself. */
+	 * content itself.
+	 */
 	hash_delete(hash, NULL);
 	return new_hash;
 }
diff --git a/hash.h b/hash.h
index 6e027bb..09ee8ef 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
@@ -16,8 +15,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
+
 #ifndef _BATMAN_HASH_H
 #define _BATMAN_HASH_H
 
@@ -39,17 +38,20 @@ struct hash_it_t {
 
 struct hashtable_t {
 	struct element_t **table;	/* the hashtable itself, with the
-					 * buckets */
+					 * buckets
+					 */
 	int elements;			/* number of elements registered */
 	int size;			/* size of hashtable */
 	hashdata_compare_cb compare;	/* callback to a compare function.
 					 * should compare 2 element datas for
 					 * their keys, return 0 if same and not
-					 *  0 if not same */
+					 *  0 if not same
+					 */
 	hashdata_choose_cb choose;	/* the hashfunction, should return an
 					 * index based on the key in the data
 					 * of the first argument and the size
-					 * the second */
+					 * the second
+					 */
 };
 
 /* clears the hash */
@@ -62,13 +64,15 @@ struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
 /* remove bucket (this might be used in hash_iterate() if you already found
  * the bucket you want to delete and don't need the overhead to find it again
  * with hash_remove(). But usually, you don't want to use this function, as it
- * fiddles with hash-internals. */
+ * fiddles with hash-internals.
+ */
 void *hash_remove_bucket(struct hashtable_t *hash,
 			 struct hash_it_t *hash_it_t);
 
 /* remove the hash structure. if hashdata_free_cb != NULL,
  * this function will be called to remove the elements inside of the hash.
- * if you don't remove the elements, memory might be leaked. */
+ * if you don't remove the elements, memory might be leaked.
+ */
 void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb);
 
 /* free only the hashtable and the hash itself. */
@@ -80,15 +84,18 @@ int hash_add(struct hashtable_t *hash, void *data);
 /* removes data from hash, if found. returns pointer do data on success,
  * so you can remove the used structure yourself, or NULL on error .
  * data could be the structure you use with just the key filled,
- * we just need the key for comparing. */
+ * we just need the key for comparing.
+ */
 void *hash_remove(struct hashtable_t *hash, void *data);
 
 /* finds data, based on the key in keydata. returns the found data on success,
- * or NULL on error */
+ * or NULL on error
+ */
 void *hash_find(struct hashtable_t *hash, void *keydata);
 
 /* resize the hash, returns the pointer to the new hash or NULL on error.
- * removes the old hash on success */
+ * removes the old hash on success
+ */
 struct hashtable_t *hash_resize(struct hashtable_t *hash, int size);
 
 /* print the hash table for debugging */
@@ -96,7 +103,8 @@ void hash_debug(struct hashtable_t *hash);
 
 /* iterate though the hash. first element is selected with iter_in NULL.
  * use the returned iterator to access the elements until hash_it_t
- * returns NULL. */
+ * returns NULL.
+ */
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			       struct hash_it_t *iter_in);
 
diff --git a/list.h b/list.h
index 2ac2c87..a436270 100644
--- a/list.h
+++ b/list.h
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 1991-2013 linux kernel contributors
+/* Copyright (C) 1991-2013 linux kernel contributors
  *
  * Linus Torvalds, ...
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #ifndef _LINUX_LIST_H
diff --git a/main.c b/main.c
index 02553c0..0ee4984 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <getopt.h>
diff --git a/netsock.c b/netsock.c
index 592f3e3..f5fdf48 100644
--- a/netsock.c
+++ b/netsock.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <sys/socket.h>
diff --git a/packet.h b/packet.h
index 5ecdf39..cbdfc24 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Sven Eckelmann
  *
@@ -14,7 +13,6 @@
  * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */
 
 #ifndef _ALFRED_PACKET_H
diff --git a/recv.c b/recv.c
index 02d96c9..a3b862a 100644
--- a/recv.c
+++ b/recv.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <errno.h>
@@ -95,7 +93,8 @@ static int finish_alfred_push_data(struct globals *globals,
 		memcpy(dataset->buf, data->data, data_len);
 
 		/* if the sender is also the the source of the dataset, we
-		 * got a first hand dataset. */
+		 * got a first hand dataset.
+		 */
 		if (memcmp(&mac, data->source, ETH_ALEN) == 0)
 			dataset->data_source = SOURCE_FIRST_HAND;
 		else
@@ -185,7 +184,8 @@ static int process_alfred_push_data(struct globals *globals,
 	head = hash_find(globals->transaction_hash, &search);
 	if (!head) {
 		/* slave must create the transactions to be able to correctly
-		 *  wait for it */
+		 *  wait for it
+		 */
 		if (globals->opmode != OPMODE_MASTER)
 			goto err;
 
diff --git a/send.c b/send.c
index cc55489..911f29e 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <netinet/in.h>
@@ -79,7 +77,8 @@ int push_data(struct globals *globals, struct interface *interface,
 			continue;
 
 		/* would the packet be too big? send so far aggregated data
-		 * first */
+		 * first
+		 */
 		if (total_length + dataset->data.header.length + sizeof(*data) >
 		    MAX_PAYLOAD - sizeof(*push)) {
 			tlv_length = total_length;
diff --git a/server.c b/server.c
index 83dfc9b..8b0cbdc 100644
--- a/server.c
+++ b/server.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <errno.h>
diff --git a/unix_sock.c b/unix_sock.c
index 2c862d5..1aadeee 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <errno.h>
diff --git a/util.c b/util.c
index 84d4b2d..7c0f7e4 100644
--- a/util.c
+++ b/util.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
@@ -16,7 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
- *
  */
 
 #include <stddef.h>
-- 
2.1.4

