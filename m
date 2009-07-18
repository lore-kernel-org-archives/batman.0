Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 17:00:16 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718150016.GQ4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup translation-table.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make translation-table.[ch] clean with respect to the 2.6.29
checkpatch script. Exceptions are long lines with debug_log.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/translation-table.c
===================================================================
--- batman-adv-kernelland/translation-table.c	(revision 1351)
+++ batman-adv-kernelland/translation-table.c	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "translation-table.h"
 #include "log.h"
@@ -29,17 +25,14 @@
 #include "hash.h"
 #include "compat.h"
 
+struct hashtable_t *hna_local_hash;
+static struct hashtable_t *hna_global_hash;
 
-
-struct hashtable_t *hna_local_hash = NULL;
-static struct hashtable_t *hna_global_hash = NULL;
-
 DEFINE_SPINLOCK(hna_local_hash_lock);
 DEFINE_SPINLOCK(hna_global_hash_lock);
 
 static DECLARE_DELAYED_WORK(hna_local_purge_wq, hna_local_purge);
 
-
 static void hna_local_start_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &hna_local_purge_wq, 10 * HZ);
@@ -66,7 +59,8 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
-	hna_local_entry = ((struct hna_local_entry *)hash_find(hna_local_hash, addr));
+	hna_local_entry =
+		((struct hna_local_entry *)hash_find(hna_local_hash, addr));
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 
 	if (hna_local_entry != NULL) {
@@ -76,17 +70,19 @@
 
 	addr_to_string(hna_str, addr);
 
-	/* only announce as many hosts as possible in the batman-packet and space in batman_packet->num_hna
-	   That also should give a limit to MAC-flooding. */
-	if ((num_hna + 1 > (1500 - sizeof(struct batman_packet)) / 6) || (num_hna + 1 > 255)) {
+	/* only announce as many hosts as possible in the batman-packet and
+	   space in batman_packet->num_hna That also should give a limit to
+	   MAC-flooding. */
+	if ((num_hna + 1 > (1500 - sizeof(struct batman_packet)) / 6) ||
+	    (num_hna + 1 > 255)) {
 		debug_log(LOG_TYPE_ROUTES, "Can't add new local hna entry (%s): number of local hna entries exceeds packet size \n", hna_str);
 		return;
 	}
 
-	debug_log(LOG_TYPE_ROUTES, "Creating new local hna entry: %s \n", hna_str);
+	debug_log(LOG_TYPE_ROUTES, "Creating new local hna entry: %s \n",
+		  hna_str);
 
 	hna_local_entry = kmalloc(sizeof(struct hna_local_entry), GFP_KERNEL);
-
 	if (!hna_local_entry)
 		return;
 
@@ -106,7 +102,8 @@
 	hna_local_changed = 1;
 
 	if (hna_local_hash->elements * 4 > hna_local_hash->size) {
-		swaphash = hash_resize(hna_local_hash, hna_local_hash->size * 2);
+		swaphash = hash_resize(hna_local_hash,
+				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
 			debug_log(LOG_TYPE_CRIT, "Couldn't resize local hna hash table \n");
@@ -119,7 +116,8 @@
 	/* remove address from global hash if present */
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
-	hna_global_entry = ((struct hna_global_entry *)hash_find(hna_global_hash, addr));
+	hna_global_entry =
+		((struct hna_global_entry *)hash_find(hna_global_hash, addr));
 
 	if (hna_global_entry != NULL)
 		_hna_global_del_orig(hna_global_entry, "local hna received");
@@ -172,9 +170,14 @@
 
 		hna_local_entry = hashit->bucket->data;
 
-		bytes_written += snprintf(buff + bytes_written, ETH_STR_LEN + 4, " * %02x:%02x:%02x:%02x:%02x:%02x\n",
-					hna_local_entry->addr[0], hna_local_entry->addr[1], hna_local_entry->addr[2],
-					hna_local_entry->addr[3], hna_local_entry->addr[4], hna_local_entry->addr[5]);
+		bytes_written += snprintf(buff + bytes_written, ETH_STR_LEN + 4,
+					  " * %02x:%02x:%02x:%02x:%02x:%02x\n",
+					  hna_local_entry->addr[0],
+					  hna_local_entry->addr[1],
+					  hna_local_entry->addr[2],
+					  hna_local_entry->addr[3],
+					  hna_local_entry->addr[4],
+					  hna_local_entry->addr[5]);
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -189,12 +192,14 @@
 	hna_local_changed = 1;
 }
 
-static void hna_local_del(struct hna_local_entry *hna_local_entry, char *message)
+static void hna_local_del(struct hna_local_entry *hna_local_entry,
+			  char *message)
 {
 	char hna_str[ETH_STR_LEN];
 
 	addr_to_string(hna_str, hna_local_entry->addr);
-	debug_log(LOG_TYPE_ROUTES, "Deleting local hna entry (%s): %s \n", hna_str, message);
+	debug_log(LOG_TYPE_ROUTES, "Deleting local hna entry (%s): %s \n",
+		  hna_str, message);
 
 	hash_remove(hna_local_hash, hna_local_entry->addr);
 	_hna_local_del(hna_local_entry);
@@ -205,15 +210,18 @@
 	struct hna_local_entry *hna_local_entry;
 	struct hash_it_t *hashit = NULL;
 	unsigned long flags;
+	unsigned long timeout;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
 	while (NULL != (hashit = hash_iterate(hna_local_hash, hashit))) {
-
 		hna_local_entry = hashit->bucket->data;
 
-		if ((!hna_local_entry->never_purge) && (time_after(jiffies, hna_local_entry->last_seen + (LOCAL_HNA_TIMEOUT /1000) * HZ)))
-			hna_local_del(hna_local_entry, "address timeouted");
+		timeout = hna_local_entry->last_seen +
+			((LOCAL_HNA_TIMEOUT / 1000) * HZ);
+		if ((!hna_local_entry->never_purge) &&
+		    time_after(jiffies, timeout))
+			hna_local_del(hna_local_entry, "address timed out");
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -223,7 +231,6 @@
 void hna_local_free(void)
 {
 	if (hna_local_hash != NULL) {
-
 		cancel_delayed_work_sync(&hna_local_purge_wq);
 		hash_delete(hna_local_hash, _hna_local_del);
 	}
@@ -239,7 +246,8 @@
 	return 1;
 }
 
-void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff, int hna_buff_len)
+void hna_global_add_orig(struct orig_node *orig_node,
+			 unsigned char *hna_buff, int hna_buff_len)
 {
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
@@ -247,25 +255,28 @@
 	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 	int hna_buff_count = 0;
 	unsigned long flags;
+	unsigned char *hna_ptr;
 
 	addr_to_string(orig_str, orig_node->orig);
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= hna_buff_len) {
-
 		spin_lock_irqsave(&hna_global_hash_lock, flags);
 
-		hna_global_entry = ((struct hna_global_entry *)hash_find(hna_global_hash, hna_buff + (hna_buff_count * ETH_ALEN)));
+		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
+		hna_global_entry = (struct hna_global_entry *)
+			hash_find(hna_global_hash, hna_ptr);
 
 		if (hna_global_entry == NULL) {
-
 			spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 
-			hna_global_entry = kmalloc(sizeof(struct hna_global_entry), GFP_KERNEL);
+			hna_global_entry =
+				kmalloc(sizeof(struct hna_global_entry),
+					GFP_KERNEL);
 
 			if (!hna_global_entry)
 				break;
 
-			memcpy(hna_global_entry->addr, hna_buff + (hna_buff_count * ETH_ALEN), ETH_ALEN);
+			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
 			addr_to_string(hna_str, hna_global_entry->addr);
 			debug_log(LOG_TYPE_ROUTES, "Creating new global hna entry: %s (via %s)\n", hna_str, orig_str);
@@ -281,7 +292,9 @@
 		/* remove address from local hash if present */
 		spin_lock_irqsave(&hna_local_hash_lock, flags);
 
-		hna_local_entry = ((struct hna_local_entry *)hash_find(hna_local_hash, hna_buff + (hna_buff_count * ETH_ALEN)));
+		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
+		hna_local_entry = (struct hna_local_entry *)
+			hash_find(hna_local_hash, hna_ptr);
 
 		if (hna_local_entry != NULL)
 			hna_local_del(hna_local_entry, "global hna received");
@@ -294,7 +307,8 @@
 	orig_node->hna_buff_len = hna_buff_len;
 
 	if (orig_node->hna_buff_len > 0) {
-		orig_node->hna_buff = kmalloc(orig_node->hna_buff_len, GFP_KERNEL);
+		orig_node->hna_buff = kmalloc(orig_node->hna_buff_len,
+					      GFP_KERNEL);
 		memcpy(orig_node->hna_buff, hna_buff, orig_node->hna_buff_len);
 	} else {
 		orig_node->hna_buff = NULL;
@@ -303,7 +317,8 @@
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
 	if (hna_global_hash->elements * 4 > hna_global_hash->size) {
-		swaphash = hash_resize(hna_global_hash, hna_global_hash->size * 2);
+		swaphash = hash_resize(hna_global_hash,
+				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
 			debug_log(LOG_TYPE_CRIT, "Couldn't resize global hna hash table \n");
@@ -324,19 +339,26 @@
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
 	while (NULL != (hashit = hash_iterate(hna_global_hash, hashit))) {
-
 		if (buff_len < bytes_written + (2 * ETH_STR_LEN) + 10)
 			break;
 
 		hna_global_entry = hashit->bucket->data;
 
-		bytes_written += snprintf(buff + bytes_written, (2 * ETH_STR_LEN) + 10,
-					" * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x \n",
-					hna_global_entry->addr[0], hna_global_entry->addr[1], hna_global_entry->addr[2],
-					hna_global_entry->addr[3], hna_global_entry->addr[4], hna_global_entry->addr[5],
-					hna_global_entry->orig_node->orig[0], hna_global_entry->orig_node->orig[1],
-					hna_global_entry->orig_node->orig[2], hna_global_entry->orig_node->orig[3],
-					hna_global_entry->orig_node->orig[4], hna_global_entry->orig_node->orig[5]);
+		bytes_written += snprintf(buff + bytes_written,
+					  (2 * ETH_STR_LEN) + 10,
+					  " * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x \n",
+					  hna_global_entry->addr[0],
+					  hna_global_entry->addr[1],
+					  hna_global_entry->addr[2],
+					  hna_global_entry->addr[3],
+					  hna_global_entry->addr[4],
+					  hna_global_entry->addr[5],
+					  hna_global_entry->orig_node->orig[0],
+					  hna_global_entry->orig_node->orig[1],
+					  hna_global_entry->orig_node->orig[2],
+					  hna_global_entry->orig_node->orig[3],
+					  hna_global_entry->orig_node->orig[4],
+					  hna_global_entry->orig_node->orig[5]);
 	}
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
@@ -344,7 +366,8 @@
 	return bytes_written;
 }
 
-void _hna_global_del_orig(struct hna_global_entry *hna_global_entry, char *message)
+void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+			  char *message)
 {
 	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 
@@ -362,6 +385,7 @@
 	struct hna_global_entry *hna_global_entry;
 	int hna_buff_count = 0;
 	unsigned long flags;
+	unsigned char *hna_ptr;
 
 	if (orig_node->hna_buff_len == 0)
 		return;
@@ -369,10 +393,12 @@
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= orig_node->hna_buff_len) {
+		hna_ptr = orig_node->hna_buff + (hna_buff_count * ETH_ALEN);
+		hna_global_entry = (struct hna_global_entry *)
+			hash_find(hna_global_hash, hna_ptr);
 
-		hna_global_entry = ((struct hna_global_entry *)hash_find(hna_global_hash, orig_node->hna_buff + (hna_buff_count * ETH_ALEN)));
-
-		if ((hna_global_entry != NULL) && (hna_global_entry->orig_node == orig_node))
+		if ((hna_global_entry != NULL) &&
+		    (hna_global_entry->orig_node == orig_node))
 			_hna_global_del_orig(hna_global_entry, message);
 
 		hna_buff_count++;
@@ -402,7 +428,8 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
-	hna_global_entry = ((struct hna_global_entry *)hash_find(hna_global_hash, addr));
+	hna_global_entry = (struct hna_global_entry *)
+		hash_find(hna_global_hash, addr);
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 
 	if (hna_global_entry == NULL)
@@ -410,4 +437,3 @@
 
 	return hna_global_entry->orig_node;
 }
-
Index: batman-adv-kernelland/translation-table.h
===================================================================
--- batman-adv-kernelland/translation-table.h	(revision 1351)
+++ batman-adv-kernelland/translation-table.h	(working copy)
@@ -17,14 +17,8 @@
  *
  */
 
-
-
-
-
 #include "types.h"
 
-
-
 int hna_local_init(void);
 void hna_local_add(uint8_t *addr);
 int hna_local_fill_buffer(unsigned char *buff, int buff_len);
@@ -32,9 +26,11 @@
 void hna_local_purge(struct work_struct *work);
 void hna_local_free(void);
 int hna_global_init(void);
-void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff, int hna_buff_len);
+void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff,
+			 int hna_buff_len);
 int hna_global_fill_buffer_text(unsigned char *buff, int buff_len);
-void _hna_global_del_orig(struct hna_global_entry *hna_global_entry, char *orig_str);
+void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+			  char *orig_str);
 void hna_global_del_orig(struct orig_node *orig_node, char *message);
 void hna_global_free(void);
 struct orig_node *transtable_search(uint8_t *addr);
