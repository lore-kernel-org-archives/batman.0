Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:31 +0200
Message-Id: <1283644718-653-15-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 14/21] Staging: batman-adv: Prepare vis
	packets directly inside a skb
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

The vis information structure is used in a way that it can be transfered
directly as packet. It still had to be copied into a skb because of an
extra buffer used for the actual preparation of the data. This is
unnecessary and can be replaced by a simple clone instead of an full
copy before each send.

This makes also the send_raw_packet function obsolete.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO   |    2 -
 drivers/staging/batman-adv/send.c |   17 ---
 drivers/staging/batman-adv/send.h |    2 -
 drivers/staging/batman-adv/vis.c  |  206 ++++++++++++++++++++++++-------------
 drivers/staging/batman-adv/vis.h  |    2 +-
 5 files changed, 133 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index d8bf845..1457c7f 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,5 +1,3 @@
- * Save/cache packets direktly as skb instead of using a normal memory region
-   and copying it in a skb using send_raw_packet and similar functions
  * Request a new review
  * Process the comments from the review
  * Move into mainline proper
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 6b138b9..aebd6c3 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -99,23 +99,6 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
-/* sends a raw packet. */
-void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
-		     struct batman_if *batman_if, uint8_t *dst_addr)
-{
-	struct sk_buff *skb;
-	char *data;
-
-	skb = dev_alloc_skb(pack_buff_len + sizeof(struct ethhdr));
-	if (!skb)
-		return;
-	data = skb_put(skb, pack_buff_len + sizeof(struct ethhdr));
-	memcpy(data + sizeof(struct ethhdr), pack_buff, pack_buff_len);
-	/* pull back to the batman "network header" */
-	skb_pull(skb, sizeof(struct ethhdr));
-	send_skb_packet(skb, batman_if, dst_addr);
-}
-
 /* Send a packet to a given interface */
 static void send_packet_to_if(struct forw_packet *forw_packet,
 			      struct batman_if *batman_if)
diff --git a/drivers/staging/batman-adv/send.h b/drivers/staging/batman-adv/send.h
index b64c627..0cfe027 100644
--- a/drivers/staging/batman-adv/send.h
+++ b/drivers/staging/batman-adv/send.h
@@ -27,8 +27,6 @@
 int send_skb_packet(struct sk_buff *skb,
 				struct batman_if *batman_if,
 				uint8_t *dst_addr);
-void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
-		     struct batman_if *batman_if, uint8_t *dst_addr);
 void schedule_own_packet(struct batman_if *batman_if);
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 4b6a504..e89a710 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -43,6 +43,8 @@
 			_dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
+#define MAX_VIS_PACKET_SIZE 1000
+
 static struct hashtable_t *vis_hash;
 static DEFINE_SPINLOCK(vis_hash_lock);
 static DEFINE_SPINLOCK(recv_list_lock);
@@ -65,6 +67,7 @@ static void free_info(struct kref *ref)
 		kfree(entry);
 	}
 	spin_unlock_irqrestore(&recv_list_lock, flags);
+	kfree_skb(info->skb_packet);
 	kfree(info);
 }
 
@@ -72,9 +75,12 @@ static void free_info(struct kref *ref)
 static int vis_info_cmp(void *data1, void *data2)
 {
 	struct vis_info *d1, *d2;
+	struct vis_packet *p1, *p2;
 	d1 = data1;
 	d2 = data2;
-	return compare_orig(d1->packet.vis_orig, d2->packet.vis_orig);
+	p1 = (struct vis_packet *)d1->skb_packet->data;
+	p2 = (struct vis_packet *)d2->skb_packet->data;
+	return compare_orig(p1->vis_orig, p2->vis_orig);
 }
 
 /* hash function to choose an entry in a hash table of given size */
@@ -82,11 +88,13 @@ static int vis_info_cmp(void *data1, void *data2)
 static int vis_info_choose(void *data, int size)
 {
 	struct vis_info *vis_info = data;
+	struct vis_packet *packet;
 	unsigned char *key;
 	uint32_t hash = 0;
 	size_t i;
 
-	key = vis_info->packet.vis_orig;
+	packet = (struct vis_packet *)vis_info->skb_packet->data;
+	key = packet->vis_orig;
 	for (i = 0; i < ETH_ALEN; i++) {
 		hash += key[i];
 		hash += (hash << 10);
@@ -179,6 +187,7 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	HASHIT(hashit);
 	HASHIT(hashit_count);
 	struct vis_info *info;
+	struct vis_packet *packet;
 	struct vis_info_entry *entries;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -201,22 +210,22 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	while (hash_iterate(vis_hash, &hashit_count)) {
 		info = hashit_count.bucket->data;
+		packet = (struct vis_packet *)info->skb_packet->data;
 		entries = (struct vis_info_entry *)
-			((char *)info + sizeof(struct vis_info));
+			  ((char *)packet + sizeof(struct vis_packet));
 
-		for (i = 0; i < info->packet.entries; i++) {
+		for (i = 0; i < packet->entries; i++) {
 			if (entries[i].quality == 0)
 				continue;
 			vis_data_insert_interface(entries[i].src, &vis_if_list,
-				compare_orig(entries[i].src,
-						info->packet.vis_orig));
+				compare_orig(entries[i].src, packet->vis_orig));
 		}
 
 		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-			buf_size += 18 + 26 * info->packet.entries;
+			buf_size += 18 + 26 * packet->entries;
 
 			/* add primary/secondary records */
-			if (compare_orig(entry->addr, info->packet.vis_orig))
+			if (compare_orig(entry->addr, packet->vis_orig))
 				buf_size +=
 					vis_data_count_prim_sec(&vis_if_list);
 
@@ -239,15 +248,15 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 
 	while (hash_iterate(vis_hash, &hashit)) {
 		info = hashit.bucket->data;
+		packet = (struct vis_packet *)info->skb_packet->data;
 		entries = (struct vis_info_entry *)
-			((char *)info + sizeof(struct vis_info));
+			  ((char *)packet + sizeof(struct vis_packet));
 
-		for (i = 0; i < info->packet.entries; i++) {
+		for (i = 0; i < packet->entries; i++) {
 			if (entries[i].quality == 0)
 				continue;
 			vis_data_insert_interface(entries[i].src, &vis_if_list,
-				compare_orig(entries[i].src,
-						info->packet.vis_orig));
+				compare_orig(entries[i].src, packet->vis_orig));
 		}
 
 		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
@@ -255,14 +264,14 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 			buff_pos += sprintf(buff + buff_pos, "%s,",
 					    tmp_addr_str);
 
-			for (i = 0; i < info->packet.entries; i++)
+			for (i = 0; i < packet->entries; i++)
 				buff_pos += vis_data_read_entry(buff + buff_pos,
 								&entries[i],
 								entry->addr,
 								entry->primary);
 
 			/* add primary/secondary records */
-			if (compare_orig(entry->addr, info->packet.vis_orig))
+			if (compare_orig(entry->addr, packet->vis_orig))
 				buff_pos +=
 					vis_data_read_prim_sec(buff + buff_pos,
 							       &vis_if_list);
@@ -345,7 +354,9 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 				   int make_broadcast)
 {
 	struct vis_info *info, *old_info;
+	struct vis_packet *search_packet, *old_packet;
 	struct vis_info search_elem;
+	struct vis_packet *packet;
 
 	*is_new = 0;
 	/* sanity check */
@@ -353,13 +364,21 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 		return NULL;
 
 	/* see if the packet is already in vis_hash */
-	memcpy(search_elem.packet.vis_orig, vis_packet->vis_orig, ETH_ALEN);
+	search_elem.skb_packet = dev_alloc_skb(sizeof(struct vis_packet));
+	if (!search_elem.skb_packet)
+		return NULL;
+	search_packet = (struct vis_packet *)skb_put(search_elem.skb_packet,
+						     sizeof(struct vis_packet));
+
+	memcpy(search_packet->vis_orig, vis_packet->vis_orig, ETH_ALEN);
 	old_info = hash_find(vis_hash, &search_elem);
+	kfree_skb(search_elem.skb_packet);
 
 	if (old_info != NULL) {
+		old_packet = (struct vis_packet *)old_info->skb_packet->data;
 		if (!seq_after(ntohl(vis_packet->seqno),
-				ntohl(old_info->packet.seqno))) {
-			if (old_info->packet.seqno == vis_packet->seqno) {
+				ntohl(old_packet->seqno))) {
+			if (old_packet->seqno == vis_packet->seqno) {
 				recv_list_add(&old_info->recv_list,
 					      vis_packet->sender_orig);
 				return old_info;
@@ -374,30 +393,39 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 		kref_put(&old_info->refcount, free_info);
 	}
 
-	info = kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
+	info = kmalloc(sizeof(struct vis_info), GFP_ATOMIC);
 	if (info == NULL)
 		return NULL;
 
+	info->skb_packet = dev_alloc_skb(sizeof(struct vis_packet) +
+					 vis_info_len + sizeof(struct ethhdr));
+	if (!info->skb_packet) {
+		kfree(info);
+		return NULL;
+	}
+	skb_reserve(info->skb_packet, sizeof(struct ethhdr));
+	packet = (struct vis_packet *)skb_put(info->skb_packet,
+					      sizeof(struct vis_packet) +
+					      vis_info_len);
+
 	kref_init(&info->refcount);
 	INIT_LIST_HEAD(&info->send_list);
 	INIT_LIST_HEAD(&info->recv_list);
 	info->first_seen = jiffies;
-	memcpy(&info->packet, vis_packet,
-	       sizeof(struct vis_packet) + vis_info_len);
+	memcpy(packet, vis_packet, sizeof(struct vis_packet) + vis_info_len);
 
 	/* initialize and add new packet. */
 	*is_new = 1;
 
 	/* Make it a broadcast packet, if required */
 	if (make_broadcast)
-		memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
+		memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
 
 	/* repair if entries is longer than packet. */
-	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
-		info->packet.entries = vis_info_len /
-			sizeof(struct vis_info_entry);
+	if (packet->entries * sizeof(struct vis_info_entry) > vis_info_len)
+		packet->entries = vis_info_len / sizeof(struct vis_info_entry);
 
-	recv_list_add(&info->recv_list, info->packet.sender_orig);
+	recv_list_add(&info->recv_list, packet->sender_orig);
 
 	/* try to add it */
 	if (hash_add(vis_hash, info) < 0) {
@@ -440,6 +468,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 				  int vis_info_len)
 {
 	struct vis_info *info;
+	struct vis_packet *packet;
 	int is_new;
 	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
@@ -456,20 +485,23 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	info = add_packet(vis_packet, vis_info_len, &is_new, are_target);
+
 	if (info == NULL)
 		goto end;
 	/* note that outdated packets will be dropped at this point. */
 
+	packet = (struct vis_packet *)info->skb_packet->data;
 
 	/* send only if we're the target server or ... */
 	if (are_target && is_new) {
-		info->packet.vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
+		packet->vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
 		send_list_add(info);
 
 		/* ... we're not the recipient (and thus need to forward). */
-	} else if (!is_my_mac(info->packet.target_orig)) {
+	} else if (!is_my_mac(packet->target_orig)) {
 		send_list_add(info);
 	}
+
 end:
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 }
@@ -482,8 +514,11 @@ static int find_best_vis_server(struct vis_info *info)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
+	struct vis_packet *packet;
 	int best_tq = -1;
 
+	packet = (struct vis_packet *)info->skb_packet->data;
+
 	while (hash_iterate(orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 		if ((orig_node != NULL) &&
@@ -491,8 +526,7 @@ static int find_best_vis_server(struct vis_info *info)
 		    (orig_node->flags & VIS_SERVER) &&
 		    (orig_node->router->tq_avg > best_tq)) {
 			best_tq = orig_node->router->tq_avg;
-			memcpy(info->packet.target_orig, orig_node->orig,
-			       ETH_ALEN);
+			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
 		}
 	}
 	return best_tq;
@@ -501,8 +535,11 @@ static int find_best_vis_server(struct vis_info *info)
 /* Return true if the vis packet is full. */
 static bool vis_packet_full(struct vis_info *info)
 {
-	if (info->packet.entries + 1 >
-	    (1000 - sizeof(struct vis_info)) / sizeof(struct vis_info_entry))
+	struct vis_packet *packet;
+	packet = (struct vis_packet *)info->skb_packet->data;
+
+	if (MAX_VIS_PACKET_SIZE / sizeof(struct vis_info_entry)
+		< packet->entries + 1)
 		return true;
 	return false;
 }
@@ -515,21 +552,23 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	HASHIT(hashit_global);
 	struct orig_node *orig_node;
 	struct vis_info *info = (struct vis_info *)my_vis_info;
-	struct vis_info_entry *entry, *entry_array;
+	struct vis_packet *packet = (struct vis_packet *)info->skb_packet->data;
+	struct vis_info_entry *entry;
 	struct hna_local_entry *hna_local_entry;
 	int best_tq = -1;
 	unsigned long flags;
 
 	info->first_seen = jiffies;
-	info->packet.vis_type = atomic_read(&bat_priv->vis_mode);
+	packet->vis_type = atomic_read(&bat_priv->vis_mode);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
-	info->packet.ttl = TTL;
-	info->packet.seqno = htonl(ntohl(info->packet.seqno) + 1);
-	info->packet.entries = 0;
+	memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
+	packet->ttl = TTL;
+	packet->seqno = htonl(ntohl(packet->seqno) + 1);
+	packet->entries = 0;
+	skb_trim(info->skb_packet, sizeof(struct vis_packet));
 
-	if (info->packet.vis_type == VIS_TYPE_CLIENT_UPDATE) {
+	if (packet->vis_type == VIS_TYPE_CLIENT_UPDATE) {
 		best_tq = find_best_vis_server(info);
 		if (best_tq < 0) {
 			spin_unlock_irqrestore(&orig_hash_lock, flags);
@@ -537,9 +576,6 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		}
 	}
 
-	entry_array = (struct vis_info_entry *)
-		((char *)info + sizeof(struct vis_info));
-
 	while (hash_iterate(orig_hash, &hashit_global)) {
 		orig_node = hashit_global.bucket->data;
 		if (orig_node->router != NULL
@@ -550,13 +586,14 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		    && orig_node->router->tq_avg > 0) {
 
 			/* fill one entry into buffer. */
-			entry = &entry_array[info->packet.entries];
+			entry = (struct vis_info_entry *)
+				skb_put(info->skb_packet, sizeof(*entry));
 			memcpy(entry->src,
 			     orig_node->router->if_incoming->net_dev->dev_addr,
 			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality = orig_node->router->tq_avg;
-			info->packet.entries++;
+			packet->entries++;
 
 			if (vis_packet_full(info)) {
 				spin_unlock_irqrestore(&orig_hash_lock, flags);
@@ -570,11 +607,12 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 	while (hash_iterate(hna_local_hash, &hashit_local)) {
 		hna_local_entry = hashit_local.bucket->data;
-		entry = &entry_array[info->packet.entries];
+		entry = (struct vis_info_entry *)skb_put(info->skb_packet,
+							 sizeof(*entry));
 		memset(entry->src, 0, ETH_ALEN);
 		memcpy(entry->dest, hna_local_entry->addr, ETH_ALEN);
 		entry->quality = 0; /* 0 means HNA */
-		info->packet.entries++;
+		packet->entries++;
 
 		if (vis_packet_full(info)) {
 			spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -605,15 +643,18 @@ static void purge_vis_packets(void)
 	}
 }
 
-static void broadcast_vis_packet(struct vis_info *info, int packet_length)
+static void broadcast_vis_packet(struct vis_info *info)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
+	struct vis_packet *packet;
+	struct sk_buff *skb;
 	unsigned long flags;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
+	packet = (struct vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
 	while (hash_iterate(orig_hash, &hashit)) {
@@ -629,31 +670,35 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 		if (recv_list_is_in(&info->recv_list, orig_node->orig))
 			continue;
 
-		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
+		memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-		send_raw_packet((unsigned char *)&info->packet,
-				packet_length, batman_if, dstaddr);
+		skb = skb_clone(info->skb_packet, GFP_ATOMIC);
+		if (skb)
+			send_skb_packet(skb, batman_if, dstaddr);
 
 		spin_lock_irqsave(&orig_hash_lock, flags);
 
 	}
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
-	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
+	memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
 }
 
-static void unicast_vis_packet(struct vis_info *info, int packet_length)
+static void unicast_vis_packet(struct vis_info *info)
 {
 	struct orig_node *orig_node;
+	struct sk_buff *skb;
+	struct vis_packet *packet;
 	unsigned long flags;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, info->packet.target_orig));
+	packet = (struct vis_packet *)info->skb_packet->data;
+	orig_node = ((struct orig_node *)hash_find(orig_hash,
+						   packet->target_orig));
 
 	if ((!orig_node) || (!orig_node->router))
 		goto out;
@@ -664,8 +709,10 @@ static void unicast_vis_packet(struct vis_info *info, int packet_length)
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-	send_raw_packet((unsigned char *)&info->packet,
-			packet_length, batman_if, dstaddr);
+	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
+	if (skb)
+		send_skb_packet(skb, batman_if, dstaddr);
+
 	return;
 
 out:
@@ -675,24 +722,22 @@ out:
 /* only send one vis packet. called from send_vis_packets() */
 static void send_vis_packet(struct vis_info *info)
 {
-	int packet_length;
+	struct vis_packet *packet;
 
-	if (info->packet.ttl < 2) {
+	packet = (struct vis_packet *)info->skb_packet->data;
+	if (packet->ttl < 2) {
 		pr_warning("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
-	memcpy(info->packet.sender_orig, main_if_addr, ETH_ALEN);
-	info->packet.ttl--;
+	memcpy(packet->sender_orig, main_if_addr, ETH_ALEN);
+	packet->ttl--;
 
-	packet_length = sizeof(struct vis_packet) +
-		info->packet.entries * sizeof(struct vis_info_entry);
-
-	if (is_bcast(info->packet.target_orig))
-		broadcast_vis_packet(info, packet_length);
+	if (is_bcast(packet->target_orig))
+		broadcast_vis_packet(info);
 	else
-		unicast_vis_packet(info, packet_length);
-	info->packet.ttl++; /* restore TTL */
+		unicast_vis_packet(info);
+	packet->ttl++; /* restore TTL */
 }
 
 /* called from timer; send (and maybe generate) vis packet. */
@@ -732,6 +777,7 @@ static DECLARE_DELAYED_WORK(vis_timer_wq, send_vis_packets);
  * initialized (e.g. bat0 is initialized, interfaces have been added) */
 int vis_init(void)
 {
+	struct vis_packet *packet;
 	unsigned long flags;
 	if (vis_hash)
 		return 1;
@@ -744,27 +790,36 @@ int vis_init(void)
 		goto err;
 	}
 
-	my_vis_info = kmalloc(1000, GFP_ATOMIC);
+	my_vis_info = kmalloc(MAX_VIS_PACKET_SIZE, GFP_ATOMIC);
 	if (!my_vis_info) {
 		pr_err("Can't initialize vis packet\n");
 		goto err;
 	}
 
+	my_vis_info->skb_packet = dev_alloc_skb(sizeof(struct vis_packet) +
+						MAX_VIS_PACKET_SIZE +
+						sizeof(struct ethhdr));
+	if (!my_vis_info->skb_packet)
+		goto free_info;
+	skb_reserve(my_vis_info->skb_packet, sizeof(struct ethhdr));
+	packet = (struct vis_packet *)skb_put(my_vis_info->skb_packet,
+					      sizeof(struct vis_packet));
+
 	/* prefill the vis info */
 	my_vis_info->first_seen = jiffies - msecs_to_jiffies(VIS_INTERVAL);
 	INIT_LIST_HEAD(&my_vis_info->recv_list);
 	INIT_LIST_HEAD(&my_vis_info->send_list);
 	kref_init(&my_vis_info->refcount);
-	my_vis_info->packet.version = COMPAT_VERSION;
-	my_vis_info->packet.packet_type = BAT_VIS;
-	my_vis_info->packet.ttl = TTL;
-	my_vis_info->packet.seqno = 0;
-	my_vis_info->packet.entries = 0;
+	packet->version = COMPAT_VERSION;
+	packet->packet_type = BAT_VIS;
+	packet->ttl = TTL;
+	packet->seqno = 0;
+	packet->entries = 0;
 
 	INIT_LIST_HEAD(&send_list);
 
-	memcpy(my_vis_info->packet.vis_orig, main_if_addr, ETH_ALEN);
-	memcpy(my_vis_info->packet.sender_orig, main_if_addr, ETH_ALEN);
+	memcpy(packet->vis_orig, main_if_addr, ETH_ALEN);
+	memcpy(packet->sender_orig, main_if_addr, ETH_ALEN);
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		pr_err("Can't add own vis packet into hash\n");
@@ -777,6 +832,9 @@ int vis_init(void)
 	start_vis_timer();
 	return 1;
 
+free_info:
+	kfree(my_vis_info);
+	my_vis_info = NULL;
 err:
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 	vis_quit();
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index bb13bf1..19dc325 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -32,7 +32,7 @@ struct vis_info {
 	struct list_head send_list;
 	struct kref refcount;
 	/* this packet might be part of the vis send queue. */
-	struct vis_packet packet;
+	struct sk_buff *skb_packet;
 	/* vis_info may follow here*/
 } __attribute__((packed));
 
-- 
1.7.1

