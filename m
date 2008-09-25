Date: Thu, 25 Sep 2008 21:15:08 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080925191508.GA8854@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Sync hash implementation of batgat and
	batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

The compare functions had a different interpretation of its return value and
kmalloc can sleep inside batgat because we are running in user context of
kernel.
---
 batman/linux/modules/gateway.c   |    4 +-
 batman/linux/modules/gateway24.c |    4 +-
 batman/linux/modules/hash.c      |  266 ++++++++++++++++++++------------------
 batman/linux/modules/hash.h      |    9 +-
 4 files changed, 149 insertions(+), 134 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 41d75b5..1f2dc24 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -713,12 +713,12 @@ static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr)
  * the ip address is the first/second field in the struct */
 int compare_wip(void *data1, void *data2)
 {
-	return ( memcmp( data1, data2, 4 ) );
+	return ( !memcmp( data1, data2, 4 ) );
 }
 
 int compare_vip(void *data1, void *data2)
 {
-	return ( memcmp( data1 + 4, data2 + 4, 4 ) );
+	return ( !memcmp( data1 + 4, data2 + 4, 4 ) );
 }
 
 /* hashfunction to choose an entry in a hash table of given size */
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index dbd1f42..a8d58e6 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -693,12 +693,12 @@ static int kernel_recvmsg(struct socket *sock, struct msghdr *msg, struct iovec
 
 int compare_wip(void *data1, void *data2)
 {
-	return ( memcmp( data1, data2, 4 ) );
+	return ( !memcmp( data1, data2, 4 ) );
 }
 
 int compare_vip(void *data1, void *data2)
 {
-	return ( memcmp( data1 + 4, data2 + 4, 4 ) );
+	return ( !memcmp( data1 + 4, data2 + 4, 4 ) );
 }
 
 int choose_wip(void *data, int32_t size)
diff --git a/batman/linux/modules/hash.c b/batman/linux/modules/hash.c
index ae009be..e88c6e0 100644
--- a/batman/linux/modules/hash.c
+++ b/batman/linux/modules/hash.c
@@ -1,6 +1,6 @@
-/* Copyright (C) 2006 B.A.T.M.A.N. contributors:
+/*
+ * Copyright (C) 2006-2008 B.A.T.M.A.N. contributors:
  * Simon Wunderlich, Marek Lindner
- *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -17,294 +17,304 @@
  *
  */
 
+
+
+
+
 #include <linux/string.h>	/* strlen, strstr, strncmp ... */
 #include <linux/slab.h>
 #include "hash.h"
 
 
+
 /* clears the hash */
-void hash_init(struct hashtable_t *hash) {
+void hash_init(struct hashtable_t *hash)
+{
 	int i;
-	hash->elements=0;
-	for (i=0 ; i<hash->size ; i++) {
+
+	hash->elements = 0;
+
+	for (i = 0 ; i < hash->size; i++)
 		hash->table[i] = NULL;
-	}
 }
 
-
 /* remove the hash structure. if hashdata_free_cb != NULL,
  * this function will be called to remove the elements inside of the hash.
  * if you don't remove the elements, memory might be leaked. */
-void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb) {
+void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
+{
 	struct element_t *bucket, *last_bucket;
 	int i;
 
-	for (i=0; i<hash->size; i++) {
+	for (i = 0; i < hash->size; i++) {
+		bucket = hash->table[i];
 
-		bucket= hash->table[i];
 		while (bucket != NULL) {
+			if (free_cb != NULL)
+				free_cb(bucket->data);
 
-			if (free_cb!=NULL)
-				free_cb( bucket->data );
-
-			last_bucket= bucket;
-			bucket= bucket->next;
+			last_bucket = bucket;
+			bucket = bucket->next;
 			kfree(last_bucket);
-
 		}
 
 	}
+
 	hash_destroy(hash);
 }
 
-
-
 /* free only the hashtable and the hash itself. */
-void hash_destroy(struct hashtable_t *hash) {
-
-	kfree( hash->table );
-	kfree( hash );
-
+void hash_destroy(struct hashtable_t *hash)
+{
+	kfree(hash->table);
+	kfree(hash);
 }
 
-
-
-
 /* iterate though the hash. first element is selected with iter_in NULL.
  * use the returned iterator to access the elements until hash_it_t returns NULL. */
-struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_in) {
+struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_in)
+{
 	struct hash_it_t *iter;
 
 	if (iter_in == NULL) {
-		iter= kmalloc(sizeof(struct hash_it_t), GFP_KERNEL);
-		iter->index =  -1;
+		iter = kmalloc(sizeof(struct hash_it_t), GFP_KERNEL);
+		iter->index = -1;
 		iter->bucket = NULL;
 		iter->prev_bucket = NULL;
-	} else
+	} else {
 		iter= iter_in;
+	}
 
 	/* sanity checks first (if our bucket got deleted in the last iteration): */
-	if (iter->bucket!=NULL) {
+	if (iter->bucket != NULL) {
 		if (iter->first_bucket != NULL) {
-
 			/* we're on the first element and it got removed after the last iteration. */
 			if ((*iter->first_bucket) != iter->bucket) {
-
 				/* there are still other elements in the list */
-				if ( (*iter->first_bucket) != NULL ) {
+				if ((*iter->first_bucket) != NULL) {
 					iter->prev_bucket = NULL;
-					iter->bucket= (*iter->first_bucket);
-					iter->first_bucket = &hash->table[ iter->index ];
-					return(iter);
+					iter->bucket = (*iter->first_bucket);
+					iter->first_bucket = &hash->table[iter->index];
+					return iter;
 				} else {
 					iter->bucket = NULL;
 				}
-
 			}
-
-		} else if ( iter->prev_bucket != NULL ) {
-
-			/* we're not on the first element, and the bucket got removed after the last iteration.
+		} else if (iter->prev_bucket != NULL) {
+			/*
+			* we're not on the first element, and the bucket got removed after the last iteration.
 			* the last bucket's next pointer is not pointing to our actual bucket anymore.
-			* select the next. */
-			if ( iter->prev_bucket->next != iter->bucket )
-				iter->bucket= iter->prev_bucket;
-
+			* select the next.
+			*/
+			if (iter->prev_bucket->next != iter->bucket)
+				iter->bucket = iter->prev_bucket;
 		}
-
 	}
 
 	/* now as we are sane, select the next one if there is some */
-	if (iter->bucket!=NULL) {
-		if (iter->bucket->next!=NULL) {
-			iter->prev_bucket= iter->bucket;
-			iter->bucket= iter->bucket->next;
+	if (iter->bucket != NULL) {
+		if (iter->bucket->next != NULL) {
+			iter->prev_bucket = iter->bucket;
+			iter->bucket = iter->bucket->next;
 			iter->first_bucket = NULL;
-			return(iter);
+			return iter;
 		}
 	}
-	/* if not returned yet, we've reached the last one on the index and have to search forward */
 
+	/* if not returned yet, we've reached the last one on the index and have to search forward */
 	iter->index++;
-	while ( iter->index < hash->size ) {		/* go through the entries of the hash table */
-		if ((hash->table[ iter->index ]) != NULL){
+	/* go through the entries of the hash table */
+	while (iter->index < hash->size) {
+		if ((hash->table[iter->index]) != NULL){
 			iter->prev_bucket = NULL;
-			iter->bucket = hash->table[ iter->index ];
-			iter->first_bucket = &hash->table[ iter->index ];
-			return(iter);						/* if this table entry is not null, return it */
-		} else
-			iter->index++;						/* else, go to the next */
+			iter->bucket = hash->table[iter->index];
+			iter->first_bucket = &hash->table[iter->index];
+			return iter;
+		} else {
+			iter->index++;
+		}
 	}
+
 	/* nothing to iterate over anymore */
 	kfree(iter);
-	return(NULL);
+	return NULL;
 }
 
-
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(int size, hashdata_compare_cb compare, hashdata_choose_cb choose) {
+struct hashtable_t *hash_new(int size, hashdata_compare_cb compare, hashdata_choose_cb choose)
+{
 	struct hashtable_t *hash;
 
-	hash= kmalloc( sizeof(struct hashtable_t) , GFP_KERNEL);
-	if ( hash == NULL ) 			/* could not allocate the hash control structure */
-		return (NULL);
+	hash = kmalloc(sizeof(struct hashtable_t) , GFP_KERNEL);
+
+	if (hash == NULL)
+		return NULL;
 
-	hash->size= size;
-	hash->table= kmalloc( sizeof(struct element_t *) * size, GFP_KERNEL);
-	if ( hash->table == NULL ) {	/* could not allocate the table */
+	hash->size = size;
+	hash->table = kmalloc(sizeof(struct element_t *) * size, GFP_KERNEL);
+
+	if (hash->table == NULL) {
 		kfree(hash);
-		return(NULL);
+		return NULL;
 	}
+
 	hash_init(hash);
-	hash->compare= compare;
-	hash->choose= choose;
-	return(hash);
-}
 
+	hash->compare = compare;
+	hash->choose = choose;
+
+	return hash;
+}
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, void *data) {
+int hash_add(struct hashtable_t *hash, void *data)
+{
 	int index;
 	struct element_t *bucket, *prev_bucket = NULL;
 
-	index = hash->choose( data, hash->size );
+	index = hash->choose(data, hash->size);
 	bucket = hash->table[index];
 
-	while ( bucket!=NULL ) {
-		if (0 == hash->compare( bucket->data, data ))
-			return(-1);
+	while (bucket != NULL) {
+		if (hash->compare(bucket->data, data))
+			return -1;
 
 		prev_bucket = bucket;
-		bucket= bucket->next;
+		bucket = bucket->next;
 	}
 
 	/* found the tail of the list, add new element */
-	if (NULL == (bucket= kmalloc(sizeof(struct element_t),GFP_KERNEL)))
-		return(-1); /* debugMalloc failed */
+	bucket = kmalloc(sizeof(struct element_t),GFP_KERNEL);
+
+	if (bucket == NULL)
+		return -1;
 
-	bucket->data= data;				/* init the new bucket */
-	bucket->next= NULL;
+	bucket->data = data;
+	bucket->next = NULL;
 
 	/* and link it */
-	if ( prev_bucket == NULL ) {
+	if (prev_bucket == NULL)
 		hash->table[index] = bucket;
-	} else {
+	else
 		prev_bucket->next = bucket;
-	}
 
 	hash->elements++;
-	return(0);
-
+	return 0;
 }
+
 /* finds data, based on the key in keydata. returns the found data on success, or NULL on error */
-void *hash_find(struct hashtable_t *hash, void *keydata) {
+void *hash_find(struct hashtable_t *hash, void *keydata)
+{
 	int index;
 	struct element_t *bucket;
 
-	index = hash->choose( keydata , hash->size );
+	index = hash->choose(keydata , hash->size);
 	bucket = hash->table[index];
 
-	while ( bucket!=NULL ) {
-		if (0 == hash->compare( bucket->data, keydata ))
-			return( bucket->data );
+	while (bucket != NULL) {
+		if (hash->compare(bucket->data, keydata))
+			return bucket->data;
 
-		bucket= bucket->next;
+		bucket = bucket->next;
 	}
 
-	return(NULL);
-
+	return NULL;
 }
 
 /* remove bucket (this might be used in hash_iterate() if you already found the bucket
  * you want to delete and don't need the overhead to find it again with hash_remove().
  * But usually, you don't want to use this function, as it fiddles with hash-internals. */
-void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t) {
+void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
+{
 	void *data_save;
 
-	data_save = hash_it_t->bucket->data;	/* save the pointer to the data */
+	data_save = hash_it_t->bucket->data;
 
-	if ( hash_it_t->prev_bucket != NULL ) {
+	if (hash_it_t->prev_bucket != NULL)
 		hash_it_t->prev_bucket->next = hash_it_t->bucket->next;
-	} else if ( hash_it_t->first_bucket != NULL ) {
+	else if (hash_it_t->first_bucket != NULL)
 		(*hash_it_t->first_bucket) = hash_it_t->bucket->next;
-	}
 
 	kfree(hash_it_t->bucket);
-
 	hash->elements--;
-	return( data_save );
 
+	return data_save;
 }
 
-
 /* removes data from hash, if found. returns pointer do data on success,
  * so you can remove the used structure yourself, or NULL on error .
  * data could be the structure you use with just the key filled,
  * we just need the key for comparing. */
-void *hash_remove(struct hashtable_t *hash, void *data) {
+void *hash_remove(struct hashtable_t *hash, void *data)
+{
 	struct hash_it_t hash_it_t;
 
-	hash_it_t.index = hash->choose( data, hash->size );
+	hash_it_t.index = hash->choose(data, hash->size);
 	hash_it_t.bucket = hash->table[hash_it_t.index];
 	hash_it_t.prev_bucket = NULL;
 
-	while ( hash_it_t.bucket!=NULL ) {
-		if (0 == hash->compare( hash_it_t.bucket->data, data )) {
+	while (hash_it_t.bucket != NULL) {
+		if (hash->compare(hash_it_t.bucket->data, data)) {
 			hash_it_t.first_bucket = (hash_it_t.bucket == hash->table[hash_it_t.index] ? &hash->table[ hash_it_t.index ] : NULL);
-			return( hash_remove_bucket(hash, &hash_it_t) );
+			return hash_remove_bucket(hash, &hash_it_t);
 		}
 
 		hash_it_t.prev_bucket = hash_it_t.bucket;
 		hash_it_t.bucket= hash_it_t.bucket->next;
 	}
 
-	return(NULL);
-
+	return NULL;
 }
 
-
 /* resize the hash, returns the pointer to the new hash or NULL on error. removes the old hash on success. */
-struct hashtable_t *hash_resize(struct hashtable_t *hash, int size) {
+struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
+{
 	struct hashtable_t *new_hash;
 	struct element_t *bucket;
 	int i;
 
 	/* initialize a new hash with the new size */
-	if (NULL == (new_hash= hash_new(size, hash->compare, hash->choose)))
-		return(NULL);
+	new_hash = hash_new(size, hash->compare, hash->choose);
+
+	if (new_hash == NULL)
+		return NULL;
 
 	/* copy the elements */
-	for (i=0; i<hash->size; i++) {
-		bucket= hash->table[i];
+	for (i = 0; i < hash->size; i++) {
+		bucket = hash->table[i];
+
 		while (bucket != NULL) {
-			hash_add( new_hash, bucket->data );
-			bucket= bucket->next;
+			hash_add(new_hash, bucket->data);
+			bucket = bucket->next;
 		}
 	}
-	hash_delete(hash, NULL);	/* remove hash and eventual overflow buckets but not the content itself. */
 
-	return( new_hash);
+	/* remove hash and eventual overflow buckets but not the content itself. */
+	hash_delete(hash, NULL);
 
+	return new_hash;
 }
 
 
-/* print the hash table for debugging */
-void hash_debug(struct hashtable_t *hash) {
+/* print the hash table for debugging
+void hash_debug(struct hashtable_t *hash)
+{
 	int i;
 	struct element_t *bucket;
 
 	for (i=0; i<hash->size;i++) {
-		printk("[%d] ",i);
+		printf("[%d] ",i);
 		bucket= hash->table[i];
 
 		while (bucket != NULL) {
-			printk("-> [%10p] ", bucket);
+			printf("-> [%10p] ", bucket);
 			bucket= bucket->next;
 		}
 
-		printk("\n");
+		printf("\n");
 
 	}
-	printk("\n");
+	printf("\n");
 }
+ */
 
diff --git a/batman/linux/modules/hash.h b/batman/linux/modules/hash.h
index a87cdcb..a778f04 100644
--- a/batman/linux/modules/hash.h
+++ b/batman/linux/modules/hash.h
@@ -1,6 +1,6 @@
-/* Copyright (C) 2006 B.A.T.M.A.N. contributors:
+/*
+ * Copyright (C) 2006-2008 B.A.T.M.A.N. contributors:
  * Simon Wunderlich, Marek Lindner
- *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
@@ -16,6 +16,11 @@
  * 02110-1301, USA
  *
  */
+
+
+
+
+
 #ifndef _BATMAN_HASH_H
 #define _BATMAN_HASH_H
 
-- 
1.6.0.1


