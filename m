Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 14 Jul 2009 18:37:50 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090714163750.GR19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] VIS startup race condition fix plus
	coding style	cleanup
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

There is a race condition between batman starting, adding the
interfaces and creating the bat0 interface, and setting VIS into
server mode, by echo'ing server into /proc/net/batman/vis. If you
enable server mode before the bat0 interface is up and running, this
gets forgotten when bat0 comes up. The vis_init() function has been
split into two parts, vis_init() and vis_start(). vis_init() is called
during the module init function and vis_start() is called when the
bat0 interface is setup, thus closing the race.

The files vis.[ch] have also been cleaned up with respect to the Linux
kernel coding standard and 2.6.29 checkpatch script.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/vis.c
===================================================================
--- batman-adv-kernelland/vis.c	(revision 1343)
+++ batman-adv-kernelland/vis.c	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "send.h"
 #include "translation-table.h"
@@ -31,30 +27,68 @@
 #include "hash.h"
 #include "compat.h"
 
-
-static DECLARE_DELAYED_WORK(vis_timer_wq, send_vis_packets);
-
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
-static struct vis_info *my_vis_info = NULL;
-static struct list_head send_list;	/* always locked with vis_hash_lock ... */
+static struct vis_info my_vis_info;
+static struct list_head send_list;	/* always locked with vis_hash_lock */
 
-void free_info(void *data);
-void send_vis_packet(struct vis_info *info);
-void start_vis_timer(void);
-volatile uint8_t vis_format = DOT_DRAW;
+static void start_vis_timer(void);
 
+/* free the info */
+static void free_info(void *data)
+{
+	struct vis_info *info = data;
+	struct recvlist_node *entry, *tmp;
 
-int vis_info_cmp(void *data1, void *data2) {
+	list_del_init(&info->send_list);
+	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	kfree(info);
+}
+
+/* set the mode of the visualization to client or server */
+void vis_set_mode(int mode)
+{
+	spin_lock(&vis_hash_lock);
+	my_vis_info.packet.vis_type = mode;
+	spin_unlock(&vis_hash_lock);
+}
+
+/* is_vis_server(), locked outside */
+static int is_vis_server_locked(void)
+{
+	if (my_vis_info.packet.vis_type == VIS_TYPE_SERVER_SYNC)
+		return 1;
+	return 0;
+}
+
+/* get the current set mode */
+int is_vis_server(void)
+{
+	int ret = 0;
+
+	spin_lock(&vis_hash_lock);
+	ret = is_vis_server_locked();
+	spin_unlock(&vis_hash_lock);
+
+	return ret;
+}
+
+/* Compare two vis packets, used by the hashing algorithm */
+static int vis_info_cmp(void *data1, void *data2)
+{
 	struct vis_info *d1, *d2;
 	d1 = data1;
 	d2 = data2;
-	return(memcmp(d1->packet.vis_orig, d2->packet.vis_orig, ETH_ALEN) == 0);
+	return memcmp(d1->packet.vis_orig, d2->packet.vis_orig, ETH_ALEN) == 0;
 }
 
-/* hashfunction to choose an entry in a hash table of given size */
+/* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
-int vis_info_choose(void *data, int size) {
+static int vis_info_choose(void *data, int size)
+{
 	struct vis_info *vis_info = data;
 	unsigned char *key;
 	uint32_t hash = 0;
@@ -71,11 +105,11 @@
 	hash ^= (hash >> 11);
 	hash += (hash << 15);
 
-	return (hash%size);
+	return hash%size;
 }
 
 /* tries to add one entry to the receive list. */
-void recv_list_add(struct list_head *recv_list, char *mac)
+static void recv_list_add(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
 	entry = kmalloc(sizeof(struct recvlist_node), GFP_KERNEL);
@@ -87,24 +121,23 @@
 }
 
 /* returns 1 if this mac is in the recv_list */
-int recv_list_is_in(struct list_head *recv_list, char *mac)
+static int recv_list_is_in(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
 
 	list_for_each_entry(entry, recv_list, list) {
-
 		if (memcmp(entry->mac, mac, ETH_ALEN) == 0)
 			return 1;
 	}
-
 	return 0;
 }
 
-/* try to add the packet to the vis_hash. return NULL if invalid (e.g. too old, broken.. ).
- * vis hash must be locked outside.
- * is_new is set when the packet is newer than old entries in the hash. */
+/* try to add the packet to the vis_hash. return NULL if invalid (e.g. too old,
+ * broken.. ).  vis hash must be locked outside.  is_new is set when the packet
+ * is newer than old entries in the hash. */
 
-struct vis_info *add_packet(struct vis_packet *vis_packet, int vis_info_len, int *is_new)
+static struct vis_info *add_packet(struct vis_packet *vis_packet,
+				   int vis_info_len, int *is_new)
 {
 	struct vis_info *info, *old_info;
 	struct vis_info search_elem;
@@ -121,12 +154,12 @@
 	if (old_info != NULL) {
 		if (vis_packet->seqno - old_info->packet.seqno <= 0) {
 			if (old_info->packet.seqno == vis_packet->seqno) {
-
-				recv_list_add(&old_info->recv_list, vis_packet->sender_orig);
-				return(old_info);
+				recv_list_add(&old_info->recv_list,
+					      vis_packet->sender_orig);
+				return old_info;
 			} else {
 				/* newer packet is already in hash. */
-				return(NULL);
+				return NULL;
 			}
 		}
 		/* remove old entry */
@@ -134,14 +167,15 @@
 		free_info(old_info);
 	}
 
-	info = kmalloc(sizeof(struct vis_info) + vis_info_len,GFP_KERNEL);
+	info = kmalloc(sizeof(struct vis_info), GFP_KERNEL);
 	if (info == NULL)
 		return NULL;
 
 	INIT_LIST_HEAD(&info->send_list);
 	INIT_LIST_HEAD(&info->recv_list);
 	info->first_seen = jiffies;
-	memcpy(&info->packet, vis_packet, sizeof(struct vis_packet) + vis_info_len);
+	memcpy(&info->packet, vis_packet,
+	       sizeof(struct vis_packet) + vis_info_len);
 
 	/* initialize and add new packet. */
 	*is_new = 1;
@@ -153,7 +187,7 @@
 	recv_list_add(&info->recv_list, info->packet.sender_orig);
 
 	/* try to add it */
-	if (hash_add(vis_hash, info)< 0) {
+	if (hash_add(vis_hash, info) < 0) {
 		/* did not work (for some reason) */
 		free_info(info);
 		info = NULL;
@@ -162,7 +196,8 @@
 }
 
 /* handle the server sync packet, forward if needed. */
-void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
+void receive_server_sync_packet(struct vis_packet *vis_packet,
+				int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new;
@@ -172,20 +207,20 @@
 	if (info == NULL)
 		goto end;
 
-	/* only if we are server ourselves and packet is newer than the one in hash.*/
+	/* only if we are server ourselves and packet is newer than the one in
+	 * hash.*/
 	if (is_vis_server_locked() && is_new) {
 		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
 	}
-
 end:
 	spin_unlock(&vis_hash_lock);
-
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
-void receive_client_update_packet(struct vis_packet *vis_packet, int vis_info_len)
+void receive_client_update_packet(struct vis_packet *vis_packet,
+				  int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new;
@@ -197,63 +232,59 @@
 	info = add_packet(vis_packet, vis_info_len, &is_new);
 	if (info == NULL)
 		goto end;
+
 	/* note that outdated packets will be dropped at this point. */
 
-
 	/* send only if we're the target server or ... */
-	if (is_vis_server_locked()
-		&& is_my_mac(info->packet.target_orig)
-		&& is_new) {
-
+	if (is_vis_server_locked() &&
+	    is_my_mac(info->packet.target_orig) &&
+	    is_new) {
 		info->packet.vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
 		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
 
-	 /* ... we're not the recipient (and thus need to forward). */
+		/* ... we're not the recipient (and thus need to forward). */
 	} else if (!is_my_mac(info->packet.target_orig)) {
-
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
 	}
-
 end:
 	spin_unlock(&vis_hash_lock);
 }
 
-/* set the mode of the visualization to client or server */
-void vis_set_mode(int mode)
+/* Walk the originators and find the VIS server with the best tq. Set the packet
+ * address to its address and return the best_tq.
+ *
+ * Must be called with the originator hash locked */
+static int find_best_vis_server(struct vis_info *info)
 {
-	spin_lock(&vis_hash_lock);
+	struct hash_it_t *hashit = NULL;
+	struct orig_node *orig_node;
+	int best_tq = -1;
 
-	if (my_vis_info != NULL)
-		my_vis_info->packet.vis_type = mode;
-
-	spin_unlock(&vis_hash_lock);
-
+	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
+		orig_node = hashit->bucket->data;
+		if ((orig_node != NULL) &&
+		    (orig_node->router != NULL) &&
+		    (orig_node->flags & VIS_SERVER) &&
+		    (orig_node->router->tq_avg > best_tq)) {
+			best_tq = orig_node->router->tq_avg;
+			memcpy(info->packet.target_orig, orig_node->orig,
+			       ETH_ALEN);
+		}
+	}
+	return best_tq;
 }
 
-/* is_vis_server(), locked outside */
-int is_vis_server_locked(void)
+/* Return true if the vis packet is full. */
+static bool vis_packet_full(struct vis_info *info)
 {
-	if (my_vis_info != NULL)
-		if (my_vis_info->packet.vis_type == VIS_TYPE_SERVER_SYNC)
-			return 1;
-
-	return 0;
+	if (info->packet.entries + 1 > ARRAY_SIZE(info->entries))
+		return true;
+	return false;
 }
-/* get the current set mode */
-int is_vis_server(void)
-{
-	int ret = 0;
 
-	spin_lock(&vis_hash_lock);
-	ret = is_vis_server_locked();
-	spin_unlock(&vis_hash_lock);
-
-	return ret;
-}
-
 /* generates a packet of own vis data,
  * returns 0 on success, -1 if no packet could be generated */
 
@@ -261,7 +292,7 @@
 {
 	struct hash_it_t *hashit = NULL;
 	struct orig_node *orig_node;
-	struct vis_info *info = (struct vis_info *)my_vis_info;
+	struct vis_info *info = &my_vis_info;
 	struct vis_info_entry *entry, *entry_array;
 	struct hna_local_entry *hna_local_entry;
 	int best_tq = -1;
@@ -276,45 +307,34 @@
 	info->packet.entries = 0;
 
 	if (!is_vis_server_locked()) {
-		/* find vis-server to receive. */
-		while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-			orig_node = hashit->bucket->data;
-			if ((orig_node != NULL) && (orig_node->router != NULL)) {
-				if ((orig_node->flags & VIS_SERVER) && orig_node->router->tq_avg > best_tq) {
-					best_tq = orig_node->router->tq_avg;
-					memcpy(info->packet.target_orig, orig_node->orig,6);
-				}
-			}
-		}
+		best_tq = find_best_vis_server(info);
 		if (best_tq < 0) {
 			spin_unlock(&orig_hash_lock);
 			return -1;
 		}
 	}
 	hashit = NULL;
+	entry_array = info->entries;
 
-	entry_array = (struct vis_info_entry *)((char *)info + sizeof(struct vis_info));
-
 	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
 		orig_node = hashit->bucket->data;
-		if (orig_node->router != NULL
-			&& memcmp(orig_node->router->addr, orig_node->orig, ETH_ALEN) == 0
-			&& orig_node->router->tq_avg > 0) {
+		if (orig_node->router != NULL &&
+		    memcmp(orig_node->router->addr,
+			   orig_node->orig, ETH_ALEN) == 0 &&
+		    orig_node->router->tq_avg > 0) {
 
 			/* fill one entry into buffer. */
 			entry = &entry_array[info->packet.entries];
-
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality = orig_node->router->tq_avg;
 			info->packet.entries++;
-			/* don't fill more than 1000 bytes */
-			if (info->packet.entries + 1 > (1000 - sizeof(struct vis_info)) / sizeof(struct vis_info_entry)) {
+
+			if (vis_packet_full(info)) {
 				spin_unlock(&orig_hash_lock);
 				return 0;
 			}
 		}
 	}
-
 	spin_unlock(&orig_hash_lock);
 
 	hashit = NULL;
@@ -323,21 +343,19 @@
 		hna_local_entry = hashit->bucket->data;
 
 		entry = &entry_array[info->packet.entries];
-
 		memcpy(entry->dest, hna_local_entry->addr, ETH_ALEN);
 		entry->quality = 0; /* 0 means HNA */
 		info->packet.entries++;
 
-		/* don't fill more than 1000 bytes */
-		if (info->packet.entries + 1 > (1000 - sizeof(struct vis_info)) / sizeof(struct vis_info_entry)) {
+		if (vis_packet_full(info)) {
 			spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 			return 0;
 		}
 	}
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 	return 0;
+}
 
-}
 void purge_vis_packets(void)
 {
 	struct hash_it_t *hashit = NULL;
@@ -346,9 +364,10 @@
 	spin_lock(&vis_hash_lock);
 	while (NULL != (hashit = hash_iterate(vis_hash, hashit))) {
 		info = hashit->bucket->data;
-		if (info == my_vis_info)	/* never purge own data. */
+		if (info == &my_vis_info)	/* never purge own data. */
 			continue;
-		if (time_after(jiffies, info->first_seen + (VIS_TIMEOUT/1000)*HZ)) {
+		if (time_after(jiffies,
+			       info->first_seen + (VIS_TIMEOUT/1000)*HZ)) {
 			hash_remove_bucket(vis_hash, hashit);
 			free_info(info);
 		}
@@ -356,159 +375,165 @@
 	spin_unlock(&vis_hash_lock);
 }
 
-/* called from timer; send (and maybe generate) vis packet. */
-void send_vis_packets(struct work_struct *work)
+static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 {
-	struct vis_info *info, *temp;
+	struct hash_it_t *hashit = NULL;
+	struct orig_node *orig_node;
 
-	purge_vis_packets();
-	spin_lock(&vis_hash_lock);
-	if (generate_vis_packet() == 0)
-		/* schedule if generation was successful */
-		list_add_tail(&my_vis_info->send_list, &send_list);
+	spin_lock(&orig_hash_lock);
 
-	list_for_each_entry_safe(info, temp, &send_list, send_list) {
-		list_del_init(&info->send_list);
-		send_vis_packet(info);
+	/* send to all routers in range. */
+	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
+		orig_node = hashit->bucket->data;
+
+		/* if it's a vis server and reachable, send it. */
+		if (orig_node &&
+		    (orig_node->flags & VIS_SERVER) &&
+		    orig_node->batman_if &&
+		    orig_node->router) {
+
+			/* don't send it if we already received the packet from
+			 * this node. */
+			if (recv_list_is_in(&info->recv_list, orig_node->orig))
+				continue;
+
+			memcpy(info->packet.target_orig,
+			       orig_node->orig, ETH_ALEN);
+
+			send_raw_packet((unsigned char *) &info->packet,
+					packet_length,
+					orig_node->batman_if->net_dev->dev_addr,
+					orig_node->router->addr,
+					orig_node->batman_if);
+		}
 	}
-	spin_unlock(&vis_hash_lock);
-	start_vis_timer();
+	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+	spin_unlock(&orig_hash_lock);
+}
 
+static void unicast_vis_packet(struct vis_info *info, int packet_length)
+{
+	struct orig_node *orig_node;
+
+	spin_lock(&orig_hash_lock);
+	orig_node = ((struct orig_node *)
+		     hash_find(orig_hash, info->packet.target_orig));
+
+	if ((orig_node != NULL) &&
+	    (orig_node->batman_if != NULL) &&
+	    (orig_node->router != NULL)) {
+		send_raw_packet((unsigned char *) &info->packet, packet_length,
+				orig_node->batman_if->net_dev->dev_addr,
+				orig_node->router->addr, orig_node->batman_if);
+	}
+	spin_unlock(&orig_hash_lock);
 }
 
 /* only send one vis packet. called from send_vis_packets() */
 void send_vis_packet(struct vis_info *info)
 {
-	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
 	int packet_length;
 
-
 	if (info->packet.ttl < 2) {
-		debug_log(LOG_TYPE_NOTICE, "Error - can't send vis packet: ttl exceeded\n");
+		debug_log(LOG_TYPE_NOTICE,
+			  "Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
 	memcpy(info->packet.sender_orig, mainIfAddr, ETH_ALEN);
-
 	info->packet.ttl--;
 
-	packet_length = sizeof(struct vis_packet) + info->packet.entries * sizeof(struct vis_info_entry);
+	packet_length = sizeof(struct vis_packet) +
+		info->packet.entries * sizeof(struct vis_info_entry);
 
-	if (is_bcast(info->packet.target_orig)) {
-		/* broadcast packet */
-		spin_lock(&orig_hash_lock);
+	if (is_bcast(info->packet.target_orig))
+		broadcast_vis_packet(info, packet_length);
+	else
+		unicast_vis_packet(info, packet_length);
+	info->packet.ttl++; /* restore TTL */
+}
 
-		/* send to all routers in range. */
-		while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
+/* called from timer; send (and maybe generate) vis packet. */
+static void send_vis_packets(struct work_struct *work)
+{
+	struct vis_info *info, *temp;
 
-			orig_node = hashit->bucket->data;
+	purge_vis_packets();
+	spin_lock(&vis_hash_lock);
+	if (generate_vis_packet() == 0)
+		/* schedule if generation was successful */
+		list_add_tail(&my_vis_info.send_list, &send_list);
 
-			/* if it's a vis server and reachable, send it. */
-			if ((orig_node != NULL) && (orig_node->flags & VIS_SERVER) && (orig_node->batman_if != NULL) && (orig_node->router != NULL)) {
-
-				/* don't send it if we already received the packet from this node. */
-				if (recv_list_is_in(&info->recv_list, orig_node->orig))
-					continue;
-
-
-				memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
-				send_raw_packet((unsigned char *) &info->packet, packet_length,
-						orig_node->batman_if->net_dev->dev_addr, orig_node->router->addr, orig_node->batman_if);
-			}
-		}
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-
-		spin_unlock(&orig_hash_lock);
-	} else {
-		/* unicast packet */
-		spin_lock(&orig_hash_lock);
-		orig_node = ((struct orig_node *) hash_find(orig_hash, info->packet.target_orig));
-
-		if ((orig_node != NULL) && (orig_node->batman_if != NULL) && (orig_node->router != NULL)) {
-			send_raw_packet((unsigned char *) &info->packet, packet_length,
-					orig_node->batman_if->net_dev->dev_addr, orig_node->router->addr, orig_node->batman_if);
-		}
-		spin_unlock(&orig_hash_lock);
-
+	list_for_each_entry_safe(info, temp, &send_list, send_list) {
+		list_del_init(&info->send_list);
+		send_vis_packet(info);
 	}
-	info->packet.ttl++; /* restore TTL */
+	spin_unlock(&vis_hash_lock);
+	start_vis_timer();
 }
 
-/* init the vis server. this may only be called when if_list is already initialized
- * (e.g. bat0 is initialized, interfaces have been added) */
+static DECLARE_DELAYED_WORK(vis_timer_wq, send_vis_packets);
+
+/* init the vis server, but don't start it yet. However it is possible for the
+ * proc interface to set the vis_type, which will take affect once the vis
+ * server is started.  */
 int vis_init(void)
 {
 	vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
 	if (vis_hash == NULL) {
 		debug_log(LOG_TYPE_CRIT, "Can't initialize vis_hash\n");
-		return(-1);
+		return -1;
 	}
 
-	my_vis_info = kmalloc(1000, GFP_KERNEL);
-	if (my_vis_info == NULL) {
-		vis_quit();
-		debug_log(LOG_TYPE_CRIT, "Can't initialize vis packet\n");
-		return(-1);
-	}
 	/* prefill the vis info */
-	my_vis_info->first_seen = jiffies - atomic_read(&vis_interval);
-	INIT_LIST_HEAD(&my_vis_info->recv_list);
-	INIT_LIST_HEAD(&my_vis_info->send_list);
-	my_vis_info->packet.version = COMPAT_VERSION;
-	my_vis_info->packet.packet_type = BAT_VIS;
-	my_vis_info->packet.vis_type = VIS_TYPE_CLIENT_UPDATE;
-	my_vis_info->packet.ttl = TTL;
-	my_vis_info->packet.seqno = 0;
-	my_vis_info->packet.entries = 0;
-
+	INIT_LIST_HEAD(&my_vis_info.recv_list);
+	INIT_LIST_HEAD(&my_vis_info.send_list);
+	my_vis_info.packet.version = COMPAT_VERSION;
+	my_vis_info.packet.packet_type = BAT_VIS;
+	my_vis_info.packet.vis_type = VIS_TYPE_CLIENT_UPDATE;
+	my_vis_info.packet.ttl = TTL;
+	my_vis_info.packet.seqno = 0;
+	my_vis_info.packet.entries = 0;
 	INIT_LIST_HEAD(&send_list);
+	return 0;
+}
 
-	memcpy(my_vis_info->packet.vis_orig, mainIfAddr, ETH_ALEN);
-	memcpy(my_vis_info->packet.sender_orig, mainIfAddr, ETH_ALEN);
+/* This may only be called when if_list is already initialized (e.g. bat0 is
+ * initialized, interfaces have been added). */
+int vis_start(void)
+{
+	my_vis_info.first_seen = jiffies - atomic_read(&vis_interval);
+	memcpy(my_vis_info.packet.vis_orig, mainIfAddr, ETH_ALEN);
+	memcpy(my_vis_info.packet.sender_orig, mainIfAddr, ETH_ALEN);
 
-	if (hash_add(vis_hash, my_vis_info) < 0) {
-		debug_log(LOG_TYPE_CRIT, "Can't add own vis packet into hash\n");
-		free_info(my_vis_info);	/* not in hash, need to remove it manually. */
+	if (hash_add(vis_hash, &my_vis_info) < 0) {
+		debug_log(LOG_TYPE_CRIT,
+			  "Can't add own vis packet into hash\n");
+		/* not in hash, need to remove it manually. */
 		vis_quit();
-		return(-1);
+		return -1;
 	}
-
 	start_vis_timer();
-	return(0);
+	return 0;
 }
 
-/* free the info */
-void free_info(void *data)
-{
-	struct vis_info *info = data;
-	struct recvlist_node *entry, *tmp;
-
-	list_del_init(&info->send_list);
-	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-	kfree(info);
-}
-
 /* shutdown vis-server */
 int vis_quit(void)
 {
 	if (vis_hash != NULL) {
 		cancel_delayed_work_sync(&vis_timer_wq);
 		spin_lock(&vis_hash_lock);
-		hash_delete(vis_hash, free_info);	/* properly remove, kill timers ... */
+		/* properly remove, kill timers ... */
+		hash_delete(vis_hash, free_info);
 		vis_hash = NULL;
-		my_vis_info = NULL;
 		spin_unlock(&vis_hash_lock);
 	}
-	return(0);
+	return 0;
 }
 
 /* schedule packets for (re)transmission */
-void start_vis_timer(void)
+static void start_vis_timer(void)
 {
-	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,  (atomic_read(&vis_interval)/1000) * HZ);
+	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
+			   (atomic_read(&vis_interval)/1000) * HZ);
 }
-
Index: batman-adv-kernelland/vis.h
===================================================================
--- batman-adv-kernelland/vis.h	(revision 1343)
+++ batman-adv-kernelland/vis.h	(working copy)
@@ -17,31 +17,29 @@
  *
  */
 
-
 #define VIS_TIMEOUT		200000
 #define VIS_FORMAT_DD_NAME	"dot_draw"
 #define VIS_FORMAT_JSON_NAME	"json"
 
+struct vis_info_entry {
+	uint8_t  dest[ETH_ALEN];
+	uint8_t  quality;	/* quality = 0 means HNA */
+} __attribute__((packed));
 
 struct vis_info {
 	unsigned long       first_seen;
 	struct list_head    recv_list;
-			/* list of server-neighbors we received a vis-packet from.
-			 * we should not reply to them. */
+	/* list of server-neighbors we received a vis-packet from.
+	 * we should not reply to them. */
 	struct list_head send_list;
-			/* this packet might be part of the vis send queue. */
+	/* this packet might be part of the vis send queue. */
 	struct vis_packet packet;
-	/* vis_info may follow here*/
+	struct vis_info_entry entries[130];
 } __attribute__((packed));
 
-struct vis_info_entry {
-	uint8_t  dest[ETH_ALEN];
-	uint8_t  quality;	/* quality = 0 means HNA */
-} __attribute__((packed));
-
 struct recvlist_node {
 	struct list_head list;
-	uint8_t mac[6];
+	uint8_t mac[ETH_ALEN];
 };
 
 enum vis_formats {
@@ -51,14 +49,13 @@
 
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
-extern volatile uint8_t vis_format;
 
-void receive_vis_packet(struct ethhdr *ethhdr, struct vis_packet *vis_packet, int vis_info_len);
 void vis_set_mode(int mode);
 int is_vis_server(void);
-int is_vis_server_locked(void);
-void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len);
-void receive_client_update_packet(struct vis_packet *vis_packet, int vis_info_len);
-void send_vis_packets(struct work_struct *work);
+void receive_server_sync_packet(struct vis_packet *vis_packet,
+				int vis_info_len);
+void receive_client_update_packet(struct vis_packet *vis_packet,
+				  int vis_info_len);
 int vis_init(void);
+int vis_start(void);
 int vis_quit(void);
Index: batman-adv-kernelland/proc.c
===================================================================
--- batman-adv-kernelland/proc.c	(revision 1343)
+++ batman-adv-kernelland/proc.c	(working copy)
@@ -31,8 +31,8 @@
 #include "types.h"
 #include "hash.h"
 
+volatile uint8_t vis_format = DOT_DRAW;
 
-
 static struct proc_dir_entry *proc_batman_dir = NULL, *proc_interface_file = NULL, *proc_orig_interval_file = NULL, *proc_originators_file = NULL;
 static struct proc_dir_entry *proc_log_file = NULL, *proc_log_level_file = NULL, *proc_transtable_local_file = NULL, *proc_transtable_global_file = NULL;
 static struct proc_dir_entry *proc_vis_file = NULL, *proc_vis_format_file = NULL, *proc_aggr_file = NULL;
@@ -643,7 +643,7 @@
 	spin_lock(&vis_hash_lock);
 	while (NULL != (hashit = hash_iterate(vis_hash, hashit))) {
 		info = hashit->bucket->data;
-		entries = (struct vis_info_entry *)((char *)info + sizeof(struct vis_info));
+		entries = info->entries;
 		addr_to_string(from, info->packet.vis_orig);
 		for (i = 0; i < info->packet.entries; i++) {
 			addr_to_string(to, entries[i].dest);
Index: batman-adv-kernelland/main.c
===================================================================
--- batman-adv-kernelland/main.c	(revision 1343)
+++ batman-adv-kernelland/main.c	(working copy)
@@ -114,6 +114,9 @@
 	hna_local_add(soft_device->dev_addr);
 
 	start_hardif_check_timer();
+
+        vis_init();
+        
 	debug_log(LOG_TYPE_CRIT, "B.A.T.M.A.N. advanced %s%s (compability version %i) loaded \n", SOURCE_VERSION, (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""), COMPAT_VERSION);
 
 	return 0;
@@ -179,7 +182,7 @@
 
 	bat_device_setup();
 
-	vis_init();
+	vis_start();
 }
 
 /* shuts down the whole module.*/
