Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 17 Oct 2010 16:30:52 +0200
Message-Id: <1287325852-8786-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Limit spin_locks to spin_lock_bh
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
To: b.a.t.m.a.n@lists.open-mesh.org

spin_lock_irqsave disables the IRQs and stores them inside the flags
provided by the caller. This is needed to protect a bottom half handler
or a user context critical section from being interrupted by an
interrupt handler which also tries to acquire the spinlock and locks
forever.

The linux device drivers will receive the packets inside an interrupt
handler and the network infrastructure will process them inside bottom
half. Thus batman-adv will only run in user context and bottom half
handlers. We can conclude that batman-adv doesn't share its own
spinlocks with real interrupt handlers.

This makes it possible to exchange the quite complex spin_lock_irqsave
with spin_lock_bh which only stops bottom halves from running on the
current cpu, but allows interrupt handlers to take over to keep the
interrupt latency low.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/aggregation.c       |   12 ++---
 batman-adv/bat_debugfs.c       |   12 +++---
 batman-adv/gateway_client.c    |   15 +++----
 batman-adv/icmp_socket.c       |   24 ++++------
 batman-adv/originator.c        |   37 +++++++----------
 batman-adv/routing.c           |   49 +++++++++------------
 batman-adv/send.c              |   32 ++++++--------
 batman-adv/soft-interface.c    |   10 ++---
 batman-adv/translation-table.c |   70 +++++++++++++------------------
 batman-adv/unicast.c           |   12 ++---
 batman-adv/vis.c               |   90 ++++++++++++++++-----------------------
 11 files changed, 153 insertions(+), 210 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index 46b9c2b..2573db5 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -104,7 +104,6 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct forw_packet *forw_packet_aggr;
-	unsigned long flags;
 	unsigned char *skb_buff;
 
 	/* own packet should always be scheduled */
@@ -150,9 +149,9 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 		forw_packet_aggr->direct_link_flags |= 1;
 
 	/* add new packet to packet list */
-	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	hlist_add_head(&forw_packet_aggr->list, &bat_priv->forw_bat_list);
-	spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
@@ -195,10 +194,9 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)packet_buff;
 	bool direct_link = batman_packet->flags & DIRECTLINK ? 1 : 0;
-	unsigned long flags;
 
 	/* find position for the packet in the forward queue */
-	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	/* own packets are not to be aggregated */
 	if ((atomic_read(&bat_priv->aggregation_enabled)) && (!own_packet)) {
 		hlist_for_each_entry(forw_packet_pos, tmp_node,
@@ -219,7 +217,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	 * suitable aggregation packet found */
 	if (forw_packet_aggr == NULL) {
 		/* the following section can run without the lock */
-		spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
+		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
 		/**
 		 * if we could not aggregate this packet with one of the others
@@ -237,7 +235,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 		aggregate(forw_packet_aggr,
 			  packet_buff, packet_len,
 			  direct_link);
-		spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
+		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 	}
 }
 
diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 3fcb102..11e5f65 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -62,7 +62,7 @@ static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
 	if (!debug_log)
 		return 0;
 
-	spin_lock_irqsave(&debug_log->lock, flags);
+	spin_lock_bh(&debug_log->lock);
 	va_start(args, fmt);
 	printed_len = vscnprintf(debug_log_buf, sizeof(debug_log_buf),
 				 fmt, args);
@@ -71,7 +71,7 @@ static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
 	for (p = debug_log_buf; *p != 0; p++)
 		emit_log_char(debug_log, *p);
 
-	spin_unlock_irqrestore(&debug_log->lock, flags);
+	spin_unlock_bh(&debug_log->lock);
 
 	wake_up(&debug_log->queue_wait);
 
@@ -134,7 +134,7 @@ static ssize_t log_read(struct file *file, char __user *buf,
 	if (error)
 		return error;
 
-	spin_lock_irqsave(&debug_log->lock, flags);
+	spin_lock_bh(&debug_log->lock);
 
 	while ((!error) && (i < count) &&
 	       (debug_log->log_start != debug_log->log_end)) {
@@ -142,18 +142,18 @@ static ssize_t log_read(struct file *file, char __user *buf,
 
 		debug_log->log_start++;
 
-		spin_unlock_irqrestore(&debug_log->lock, flags);
+		spin_unlock_bh(&debug_log->lock);
 
 		error = __put_user(c, buf);
 
-		spin_lock_irqsave(&debug_log->lock, flags);
+		spin_lock_bh(&debug_log->lock);
 
 		buf++;
 		i++;
 
 	}
 
-	spin_unlock_irqrestore(&debug_log->lock, flags);
+	spin_unlock_bh(&debug_log->lock);
 
 	if (!error)
 		return i;
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index ae1ab1e..9ec880d 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -234,7 +234,6 @@ static void gw_node_add(struct bat_priv *bat_priv,
 {
 	struct gw_node *gw_node;
 	int down, up;
-	unsigned long flags;
 
 	gw_node = kmalloc(sizeof(struct gw_node), GFP_ATOMIC);
 	if (!gw_node)
@@ -245,9 +244,9 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	gw_node->orig_node = orig_node;
 	kref_init(&gw_node->refcount);
 
-	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
+	spin_lock_bh(&bat_priv->gw_list_lock);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
-	spin_unlock_irqrestore(&bat_priv->gw_list_lock, flags);
+	spin_unlock_bh(&bat_priv->gw_list_lock);
 
 	gw_srv_class_to_kbit(new_gwflags, &down, &up);
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -312,9 +311,8 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 	struct gw_node *gw_node;
 	struct hlist_node *node, *node_tmp;
 	unsigned long timeout = 2 * PURGE_TIMEOUT * HZ;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
+	spin_lock_bh(&bat_priv->gw_list_lock);
 
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
 						&bat_priv->gw_list, list) {
@@ -326,16 +324,15 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 		}
 	}
 
-	spin_unlock_irqrestore(&bat_priv->gw_list_lock, flags);
+	spin_unlock_bh(&bat_priv->gw_list_lock);
 }
 
 void gw_node_list_free(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node;
 	struct hlist_node *node, *node_tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
+	spin_lock_bh(&bat_priv->gw_list_lock);
 
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
 				 &bat_priv->gw_list, list) {
@@ -344,7 +341,7 @@ void gw_node_list_free(struct bat_priv *bat_priv)
 	}
 
 	gw_deselect(bat_priv);
-	spin_unlock_irqrestore(&bat_priv->gw_list_lock, flags);
+	spin_unlock_bh(&bat_priv->gw_list_lock);
 }
 
 static int _write_buffer_text(struct bat_priv *bat_priv,
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index aa64ff8..2d517cb 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -86,9 +86,8 @@ static int bat_socket_release(struct inode *inode, struct file *file)
 	struct socket_client *socket_client = file->private_data;
 	struct socket_packet *socket_packet;
 	struct list_head *list_pos, *list_pos_tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&socket_client->lock, flags);
+	spin_lock_bh(&socket_client->lock);
 
 	/* for all packets in the queue ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &socket_client->queue_list) {
@@ -100,7 +99,7 @@ static int bat_socket_release(struct inode *inode, struct file *file)
 	}
 
 	socket_client_hash[socket_client->index] = NULL;
-	spin_unlock_irqrestore(&socket_client->lock, flags);
+	spin_unlock_bh(&socket_client->lock);
 
 	kfree(socket_client);
 	dec_module_count();
@@ -115,7 +114,6 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 	struct socket_packet *socket_packet;
 	size_t packet_len;
 	int error;
-	unsigned long flags;
 
 	if ((file->f_flags & O_NONBLOCK) && (socket_client->queue_len == 0))
 		return -EAGAIN;
@@ -132,14 +130,14 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 	if (error)
 		return error;
 
-	spin_lock_irqsave(&socket_client->lock, flags);
+	spin_lock_bh(&socket_client->lock);
 
 	socket_packet = list_first_entry(&socket_client->queue_list,
 					 struct socket_packet, list);
 	list_del(&socket_packet->list);
 	socket_client->queue_len--;
 
-	spin_unlock_irqrestore(&socket_client->lock, flags);
+	spin_unlock_bh(&socket_client->lock);
 
 	error = __copy_to_user(buf, &socket_packet->icmp_packet,
 			       socket_packet->icmp_len);
@@ -165,7 +163,6 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	struct batman_if *batman_if;
 	size_t packet_len = sizeof(struct icmp_packet);
 	uint8_t dstaddr[ETH_ALEN];
-	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -225,7 +222,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dst_unreach;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   icmp_packet->dst));
 
@@ -238,7 +235,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	if (!batman_if)
 		goto dst_unreach;
@@ -258,7 +255,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	goto out;
 
 unlock:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 dst_unreach:
 	icmp_packet->msg_type = DESTINATION_UNREACHABLE;
 	bat_socket_add_packet(socket_client, icmp_packet, packet_len);
@@ -313,7 +310,6 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 				  size_t icmp_len)
 {
 	struct socket_packet *socket_packet;
-	unsigned long flags;
 
 	socket_packet = kmalloc(sizeof(struct socket_packet), GFP_ATOMIC);
 
@@ -324,12 +320,12 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 	memcpy(&socket_packet->icmp_packet, icmp_packet, icmp_len);
 	socket_packet->icmp_len = icmp_len;
 
-	spin_lock_irqsave(&socket_client->lock, flags);
+	spin_lock_bh(&socket_client->lock);
 
 	/* while waiting for the lock the socket_client could have been
 	 * deleted */
 	if (!socket_client_hash[icmp_packet->uid]) {
-		spin_unlock_irqrestore(&socket_client->lock, flags);
+		spin_unlock_bh(&socket_client->lock);
 		kfree(socket_packet);
 		return;
 	}
@@ -346,7 +342,7 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 		socket_client->queue_len--;
 	}
 
-	spin_unlock_irqrestore(&socket_client->lock, flags);
+	spin_unlock_bh(&socket_client->lock);
 
 	wake_up(&socket_client->queue_wait);
 }
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 6868a2a..ce44025 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -42,22 +42,21 @@ static void start_purge_timer(struct bat_priv *bat_priv)
 
 int originator_init(struct bat_priv *bat_priv)
 {
-	unsigned long flags;
 	if (bat_priv->orig_hash)
 		return 1;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	bat_priv->orig_hash = hash_new(128, compare_orig, choose_orig);
 
 	if (!bat_priv->orig_hash)
 		goto err;
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	start_purge_timer(bat_priv);
 	return 1;
 
 err:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 }
 
@@ -110,17 +109,15 @@ static void free_orig_node(void *data, void *arg)
 
 void originator_free(struct bat_priv *bat_priv)
 {
-	unsigned long flags;
-
 	if (!bat_priv->orig_hash)
 		return;
 
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	hash_delete(bat_priv->orig_hash, free_orig_node, bat_priv);
 	bat_priv->orig_hash = NULL;
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 /* this function finds or creates an originator entry for the given
@@ -269,9 +266,8 @@ static void _purge_orig(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* for all origins... */
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
@@ -289,7 +285,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 			frag_list_free(&orig_node->frag_list);
 	}
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	gw_node_purge_deleted(bat_priv);
 	gw_election(bat_priv);
@@ -323,7 +319,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	int batman_count = 0;
 	int last_seen_secs;
 	int last_seen_msecs;
-	unsigned long flags;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
 	if ((!bat_priv->primary_if) ||
@@ -346,7 +341,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", "Potential nexthops");
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 
@@ -380,7 +375,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		batman_count++;
 	}
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	if ((batman_count == 0))
 		seq_printf(seq, "No batman nodes in range ...\n");
@@ -422,12 +417,11 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct orig_node *orig_node;
-	unsigned long flags;
 	HASHIT(hashit);
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
@@ -436,11 +430,11 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 			goto err;
 	}
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
 
@@ -501,13 +495,12 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct batman_if *batman_if_tmp;
 	struct orig_node *orig_node;
-	unsigned long flags;
 	HASHIT(hashit);
 	int ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
@@ -537,10 +530,10 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	rcu_read_unlock();
 
 	batman_if->if_num = -1;
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 1377f01..353fa6b 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -42,9 +42,8 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
@@ -55,7 +54,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 			bit_packet_count(word);
 	}
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
@@ -759,7 +758,6 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct ethhdr *ethhdr;
-	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct batman_packet))))
@@ -785,12 +783,12 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	receive_aggr_bat_packet(ethhdr,
 				skb->data,
 				skb_headlen(skb),
 				batman_if);
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
@@ -804,7 +802,6 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
 	int ret;
-	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
@@ -821,7 +818,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   icmp_packet->orig));
 	ret = NET_RX_DROP;
@@ -833,7 +830,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 		 * copy the required data before sending */
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 		/* create a copy of the skb, if needed, to modify it. */
 		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -852,7 +849,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 		ret = NET_RX_SUCCESS;
 
 	} else
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	return ret;
 }
@@ -865,7 +862,6 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
 	int ret;
-	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
 	icmp_packet = (struct icmp_packet *)skb->data;
@@ -883,7 +879,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		return NET_RX_DROP;
 
 	/* get routing information */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, icmp_packet->orig));
 	ret = NET_RX_DROP;
@@ -895,7 +891,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		 * copy the required data before sending */
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 		/* create a copy of the skb, if needed, to modify it. */
 		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -914,7 +910,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		ret = NET_RX_SUCCESS;
 
 	} else
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	return ret;
 }
@@ -929,7 +925,6 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct batman_if *batman_if;
 	int hdr_size = sizeof(struct icmp_packet);
 	int ret;
-	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
 	/**
@@ -977,7 +972,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ret = NET_RX_DROP;
 
 	/* get routing information */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, icmp_packet->dst));
 
@@ -988,7 +983,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		 * copy the required data before sending */
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 		/* create a copy of the skb, if needed, to modify it. */
 		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -1005,7 +1000,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		ret = NET_RX_SUCCESS;
 
 	} else
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	return ret;
 }
@@ -1141,7 +1136,6 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	struct neigh_node *router;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
-	unsigned long flags;
 	struct unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	int ret;
@@ -1158,14 +1152,14 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	}
 
 	/* get routing information */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, unicast_packet->dest));
 
 	router = find_router(orig_node, recv_if);
 
 	if (!router) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1175,7 +1169,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	batman_if = router->if_incoming;
 	memcpy(dstaddr, router->addr, ETH_ALEN);
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -1275,7 +1269,6 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
 	int32_t seq_diff;
-	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1304,12 +1297,12 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (bcast_packet->ttl < 2)
 		return NET_RX_DROP;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, bcast_packet->orig));
 
 	if (orig_node == NULL) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1317,7 +1310,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (get_bit_status(orig_node->bcast_bits,
 			   orig_node->last_bcast_seqno,
 			   ntohl(bcast_packet->seqno))) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1326,7 +1319,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->bcast_seqno_reset)) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1335,7 +1328,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
 
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 180e18b..d06bcfc 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -374,13 +374,12 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
 				      struct forw_packet *forw_packet,
 				      unsigned long send_time)
 {
-	unsigned long flags;
 	INIT_HLIST_NODE(&forw_packet->list);
 
 	/* add new packet to packet list */
-	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
-	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
+	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
@@ -450,14 +449,13 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		container_of(work, struct delayed_work, work);
 	struct forw_packet *forw_packet =
 		container_of(delayed_work, struct forw_packet, delayed_work);
-	unsigned long flags;
 	struct sk_buff *skb1;
 	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 
-	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_del(&forw_packet->list);
-	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
+	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
@@ -495,13 +493,12 @@ void send_outstanding_bat_packet(struct work_struct *work)
 		container_of(work, struct delayed_work, work);
 	struct forw_packet *forw_packet =
 		container_of(delayed_work, struct forw_packet, delayed_work);
-	unsigned long flags;
 	struct bat_priv *bat_priv;
 
 	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
-	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	hlist_del(&forw_packet->list);
-	spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
@@ -529,7 +526,6 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 {
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
-	unsigned long flags;
 
 	if (batman_if)
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -540,7 +536,7 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 			"purge_outstanding_packets()\n");
 
 	/* free bcast list */
-	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
 				  &bat_priv->forw_bcast_list, list) {
 
@@ -552,19 +548,19 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 		    (forw_packet->if_incoming != batman_if))
 			continue;
 
-		spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
+		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
 		/**
 		 * send_outstanding_bcast_packet() will lock the list to
 		 * delete the item from the list
 		 */
 		cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
+		spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	}
-	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
+	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
 	/* free batman packet list */
-	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
 				  &bat_priv->forw_bat_list, list) {
 
@@ -576,14 +572,14 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 		    (forw_packet->if_incoming != batman_if))
 			continue;
 
-		spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
+		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
 		/**
 		 * send_outstanding_bat_packet() will lock the list to
 		 * delete the item from the list
 		 */
 		cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
+		spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	}
-	spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 }
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 683ec5f..3090e5c 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -100,9 +100,8 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
 {
 	struct softif_neigh *softif_neigh, *softif_neigh_tmp;
 	struct hlist_node *node, *node_tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->softif_neigh_lock, flags);
+	spin_lock_bh(&bat_priv->softif_neigh_lock);
 
 	hlist_for_each_entry_safe(softif_neigh, node, node_tmp,
 				  &bat_priv->softif_neigh_list, list) {
@@ -129,7 +128,7 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
 		call_rcu(&softif_neigh->rcu, softif_neigh_free_rcu);
 	}
 
-	spin_unlock_irqrestore(&bat_priv->softif_neigh_lock, flags);
+	spin_unlock_bh(&bat_priv->softif_neigh_lock);
 }
 
 static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
@@ -137,7 +136,6 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
 {
 	struct softif_neigh *softif_neigh;
 	struct hlist_node *node;
-	unsigned long flags;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(softif_neigh, node,
@@ -162,9 +160,9 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
 	kref_init(&softif_neigh->refcount);
 
 	INIT_HLIST_NODE(&softif_neigh->list);
-	spin_lock_irqsave(&bat_priv->softif_neigh_lock, flags);
+	spin_lock_bh(&bat_priv->softif_neigh_lock);
 	hlist_add_head_rcu(&softif_neigh->list, &bat_priv->softif_neigh_list);
-	spin_unlock_irqrestore(&bat_priv->softif_neigh_lock, flags);
+	spin_unlock_bh(&bat_priv->softif_neigh_lock);
 
 found:
 	kref_get(&softif_neigh->refcount);
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 9cae140..232c4d6 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -59,13 +59,12 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 	hna_local_entry =
 		((struct hna_local_entry *)hash_find(bat_priv->hna_local_hash,
 						     addr));
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 
 	if (hna_local_entry) {
 		hna_local_entry->last_seen = jiffies;
@@ -101,7 +100,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	else
 		hna_local_entry->never_purge = 0;
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 	hash_add(bat_priv->hna_local_hash, hna_local_entry);
 	bat_priv->num_local_hna++;
@@ -118,10 +117,10 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 			bat_priv->hna_local_hash = swaphash;
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 
 	/* remove address from global hash if present */
-	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_ghash_lock);
 
 	hna_global_entry = ((struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash, addr));
@@ -130,7 +129,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 		_hna_global_del_orig(bat_priv, hna_global_entry,
 				     "local hna received");
 
-	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 }
 
 int hna_local_fill_buffer(struct bat_priv *bat_priv,
@@ -139,9 +138,8 @@ int hna_local_fill_buffer(struct bat_priv *bat_priv,
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	int i = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
 
@@ -158,7 +156,7 @@ int hna_local_fill_buffer(struct bat_priv *bat_priv,
 	if (i == bat_priv->num_local_hna)
 		atomic_set(&bat_priv->hna_local_changed, 0);
 
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 	return i;
 }
 
@@ -169,7 +167,6 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	HASHIT(hashit_count);
-	unsigned long flags;
 	size_t buf_size, pos;
 	char *buff;
 
@@ -183,7 +180,7 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 		   "announced via HNA:\n",
 		   net_dev->name);
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
@@ -192,7 +189,7 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+		spin_unlock_bh(&bat_priv->hna_lhash_lock);
 		return -ENOMEM;
 	}
 	buff[0] = '\0';
@@ -205,7 +202,7 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 				hna_local_entry->addr);
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
@@ -236,16 +233,15 @@ void hna_local_remove(struct bat_priv *bat_priv,
 		      uint8_t *addr, char *message)
 {
 	struct hna_local_entry *hna_local_entry;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 	hna_local_entry = (struct hna_local_entry *)
 		hash_find(bat_priv->hna_local_hash, addr);
 	if (hna_local_entry)
 		hna_local_del(bat_priv, hna_local_entry, message);
 
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 }
 
 static void hna_local_purge(struct work_struct *work)
@@ -256,10 +252,9 @@ static void hna_local_purge(struct work_struct *work)
 		container_of(delayed_work, struct bat_priv, hna_work);
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
-	unsigned long flags;
 	unsigned long timeout;
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
 		hna_local_entry = hashit.bucket->data;
@@ -272,7 +267,7 @@ static void hna_local_purge(struct work_struct *work)
 				      "address timed out");
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 	hna_local_start_timer(bat_priv);
 }
 
@@ -307,19 +302,17 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 	struct hna_local_entry *hna_local_entry;
 	struct hashtable_t *swaphash;
 	int hna_buff_count = 0;
-	unsigned long flags;
 	unsigned char *hna_ptr;
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= hna_buff_len) {
-		spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+		spin_lock_bh(&bat_priv->hna_ghash_lock);
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
 			hash_find(bat_priv->hna_global_hash, hna_ptr);
 
 		if (!hna_global_entry) {
-			spin_unlock_irqrestore(&bat_priv->hna_ghash_lock,
-					       flags);
+			spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
 			hna_global_entry =
 				kmalloc(sizeof(struct hna_global_entry),
@@ -335,16 +328,16 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 				"%pM (via %pM)\n",
 				hna_global_entry->addr, orig_node->orig);
 
-			spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+			spin_lock_bh(&bat_priv->hna_ghash_lock);
 			hash_add(bat_priv->hna_global_hash, hna_global_entry);
 
 		}
 
 		hna_global_entry->orig_node = orig_node;
-		spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+		spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
 		/* remove address from local hash if present */
-		spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+		spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_local_entry = (struct hna_local_entry *)
@@ -354,7 +347,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 			hna_local_del(bat_priv, hna_local_entry,
 				      "global hna received");
 
-		spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+		spin_unlock_bh(&bat_priv->hna_lhash_lock);
 
 		hna_buff_count++;
 	}
@@ -371,7 +364,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 		}
 	}
 
-	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_ghash_lock);
 
 	if (bat_priv->hna_global_hash->elements * 4 >
 					bat_priv->hna_global_hash->size) {
@@ -384,7 +377,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 			bat_priv->hna_global_hash = swaphash;
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 }
 
 int hna_global_seq_print_text(struct seq_file *seq, void *offset)
@@ -394,7 +387,6 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct hna_global_entry *hna_global_entry;
 	HASHIT(hashit);
 	HASHIT(hashit_count);
-	unsigned long flags;
 	size_t buf_size, pos;
 	char *buff;
 
@@ -407,7 +399,7 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "Globally announced HNAs received via the mesh %s\n",
 		   net_dev->name);
 
-	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_ghash_lock);
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx via xx:xx:xx:xx:xx:xx\n"*/
@@ -416,7 +408,7 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+		spin_unlock_bh(&bat_priv->hna_ghash_lock);
 		return -ENOMEM;
 	}
 	buff[0] = '\0';
@@ -430,7 +422,7 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 				hna_global_entry->orig_node->orig);
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
@@ -455,13 +447,12 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 {
 	struct hna_global_entry *hna_global_entry;
 	int hna_buff_count = 0;
-	unsigned long flags;
 	unsigned char *hna_ptr;
 
 	if (orig_node->hna_buff_len == 0)
 		return;
 
-	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_ghash_lock);
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= orig_node->hna_buff_len) {
 		hna_ptr = orig_node->hna_buff + (hna_buff_count * ETH_ALEN);
@@ -476,7 +467,7 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 		hna_buff_count++;
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
 	orig_node->hna_buff_len = 0;
 	kfree(orig_node->hna_buff);
@@ -500,12 +491,11 @@ void hna_global_free(struct bat_priv *bat_priv)
 struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 {
 	struct hna_global_entry *hna_global_entry;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_ghash_lock);
 	hna_global_entry = (struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash, addr);
-	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
 	if (!hna_global_entry)
 		return NULL;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index bca69f6..96c0939 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -170,7 +170,6 @@ void frag_list_free(struct list_head *head)
 int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb)
 {
-	unsigned long flags;
 	struct orig_node *orig_node;
 	struct frag_packet_list_entry *tmp_frag_entry;
 	int ret = NET_RX_DROP;
@@ -178,7 +177,7 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		(struct unicast_frag_packet *)skb->data;
 
 	*new_skb = NULL;
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)
 		    hash_find(bat_priv->orig_hash, unicast_packet->orig));
 
@@ -210,7 +209,7 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	if (*new_skb)
 		ret = NET_RX_SUCCESS;
 out:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	return ret;
 }
@@ -278,9 +277,8 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	struct neigh_node *router;
 	int data_len = skb->len;
 	uint8_t dstaddr[6];
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* get routing information */
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
@@ -304,7 +302,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	batman_if = router->if_incoming;
 	memcpy(dstaddr, router->addr, ETH_ALEN);
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dropped;
@@ -334,7 +332,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	return 0;
 
 unlock:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 dropped:
 	kfree_skb(skb);
 	return 1;
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index ddfdcd8..72b4257 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -54,16 +54,15 @@ static void free_info(struct kref *ref)
 	struct vis_info *info = container_of(ref, struct vis_info, refcount);
 	struct bat_priv *bat_priv = info->bat_priv;
 	struct recvlist_node *entry, *tmp;
-	unsigned long flags;
 
 	list_del_init(&info->send_list);
-	spin_lock_irqsave(&bat_priv->vis_list_lock, flags);
+	spin_lock_bh(&bat_priv->vis_list_lock);
 	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
 		list_del(&entry->list);
 		kfree(entry);
 	}
 
-	spin_unlock_irqrestore(&bat_priv->vis_list_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_list_lock);
 	kfree_skb(info->skb_packet);
 }
 
@@ -192,7 +191,6 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_node *pos, *n;
 	int i;
 	char tmp_addr_str[ETH_STR_LEN];
-	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 	size_t buff_pos, buf_size;
 	char *buff;
@@ -203,7 +201,7 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 
 	buf_size = 1;
 	/* Estimate length */
-	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	spin_lock_bh(&bat_priv->vis_hash_lock);
 	while (hash_iterate(bat_priv->vis_hash, &hashit_count)) {
 		info = hashit_count.bucket->data;
 		packet = (struct vis_packet *)info->skb_packet->data;
@@ -236,7 +234,7 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->vis_hash_lock);
 		return -ENOMEM;
 	}
 	buff[0] = '\0';
@@ -281,7 +279,7 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 		}
 	}
 
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
@@ -314,16 +312,15 @@ static void recv_list_add(struct bat_priv *bat_priv,
 			  struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
-	unsigned long flags;
 
 	entry = kmalloc(sizeof(struct recvlist_node), GFP_ATOMIC);
 	if (!entry)
 		return;
 
 	memcpy(entry->mac, mac, ETH_ALEN);
-	spin_lock_irqsave(&bat_priv->vis_list_lock, flags);
+	spin_lock_bh(&bat_priv->vis_list_lock);
 	list_add_tail(&entry->list, recv_list);
-	spin_unlock_irqrestore(&bat_priv->vis_list_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_list_lock);
 }
 
 /* returns 1 if this mac is in the recv_list */
@@ -331,17 +328,15 @@ static int recv_list_is_in(struct bat_priv *bat_priv,
 			   struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->vis_list_lock, flags);
+	spin_lock_bh(&bat_priv->vis_list_lock);
 	list_for_each_entry(entry, recv_list, list) {
 		if (memcmp(entry->mac, mac, ETH_ALEN) == 0) {
-			spin_unlock_irqrestore(&bat_priv->vis_list_lock,
-					       flags);
+			spin_unlock_bh(&bat_priv->vis_list_lock);
 			return 1;
 		}
 	}
-	spin_unlock_irqrestore(&bat_priv->vis_list_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_list_lock);
 	return 0;
 }
 
@@ -445,12 +440,11 @@ void receive_server_sync_packet(struct bat_priv *bat_priv,
 {
 	struct vis_info *info;
 	int is_new, make_broadcast;
-	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 
 	make_broadcast = (vis_server == VIS_TYPE_SERVER_SYNC);
 
-	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	spin_lock_bh(&bat_priv->vis_hash_lock);
 	info = add_packet(bat_priv, vis_packet, vis_info_len,
 			  &is_new, make_broadcast);
 	if (!info)
@@ -461,7 +455,7 @@ void receive_server_sync_packet(struct bat_priv *bat_priv,
 	if (vis_server == VIS_TYPE_SERVER_SYNC && is_new)
 		send_list_add(bat_priv, info);
 end:
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
@@ -472,7 +466,6 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	struct vis_info *info;
 	struct vis_packet *packet;
 	int is_new;
-	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 	int are_target = 0;
 
@@ -485,7 +478,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	    is_my_mac(vis_packet->target_orig))
 		are_target = 1;
 
-	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	spin_lock_bh(&bat_priv->vis_hash_lock);
 	info = add_packet(bat_priv, vis_packet, vis_info_len,
 			  &is_new, are_target);
 
@@ -506,7 +499,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	}
 
 end:
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 }
 
 /* Walk the originators and find the VIS server with the best tq. Set the packet
@@ -559,12 +552,11 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	struct vis_info_entry *entry;
 	struct hna_local_entry *hna_local_entry;
 	int best_tq = -1;
-	unsigned long flags;
 
 	info->first_seen = jiffies;
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
 	packet->ttl = TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
@@ -575,8 +567,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		best_tq = find_best_vis_server(bat_priv, info);
 
 		if (best_tq < 0) {
-			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
-					       flags);
+			spin_unlock_bh(&bat_priv->orig_hash_lock);
 			return -1;
 		}
 	}
@@ -607,15 +598,14 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		packet->entries++;
 
 		if (vis_packet_full(info)) {
-			spin_unlock_irqrestore(
-					&bat_priv->orig_hash_lock, flags);
+			spin_unlock_bh(&bat_priv->orig_hash_lock);
 			return 0;
 		}
 	}
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
-	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	spin_lock_bh(&bat_priv->hna_lhash_lock);
 	while (hash_iterate(bat_priv->hna_local_hash, &hashit_local)) {
 		hna_local_entry = hashit_local.bucket->data;
 		entry = (struct vis_info_entry *)skb_put(info->skb_packet,
@@ -626,13 +616,12 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		packet->entries++;
 
 		if (vis_packet_full(info)) {
-			spin_unlock_irqrestore(&bat_priv->hna_lhash_lock,
-					       flags);
+			spin_unlock_bh(&bat_priv->hna_lhash_lock);
 			return 0;
 		}
 	}
 
-	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 	return 0;
 }
 
@@ -666,12 +655,11 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
 	struct sk_buff *skb;
-	unsigned long flags;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
@@ -692,17 +680,17 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 		memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 		skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 		if (skb)
 			send_skb_packet(skb, batman_if, dstaddr);
 
-		spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+		spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	}
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 static void unicast_vis_packet(struct bat_priv *bat_priv,
@@ -711,11 +699,10 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	struct orig_node *orig_node;
 	struct sk_buff *skb;
 	struct vis_packet *packet;
-	unsigned long flags;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   packet->target_orig));
@@ -727,7 +714,7 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	 * copy the required data before sending */
 	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 	if (skb)
@@ -736,7 +723,7 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	return;
 
 out:
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 /* only send one vis packet. called from send_vis_packets() */
@@ -769,9 +756,8 @@ static void send_vis_packets(struct work_struct *work)
 	struct bat_priv *bat_priv =
 		container_of(delayed_work, struct bat_priv, vis_work);
 	struct vis_info *info, *temp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	spin_lock_bh(&bat_priv->vis_hash_lock);
 	purge_vis_packets(bat_priv);
 
 	if (generate_vis_packet(bat_priv) == 0) {
@@ -783,16 +769,16 @@ static void send_vis_packets(struct work_struct *work)
 				 send_list) {
 
 		kref_get(&info->refcount);
-		spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->vis_hash_lock);
 
 		if (bat_priv->primary_if)
 			send_vis_packet(bat_priv, info);
 
-		spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+		spin_lock_bh(&bat_priv->vis_hash_lock);
 		send_list_del(info);
 		kref_put(&info->refcount, free_info);
 	}
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 	start_vis_timer(bat_priv);
 }
 
@@ -801,12 +787,11 @@ static void send_vis_packets(struct work_struct *work)
 int vis_init(struct bat_priv *bat_priv)
 {
 	struct vis_packet *packet;
-	unsigned long flags;
 
 	if (bat_priv->vis_hash)
 		return 1;
 
-	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	spin_lock_bh(&bat_priv->vis_hash_lock);
 
 	bat_priv->vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
 	if (!bat_priv->vis_hash) {
@@ -854,7 +839,7 @@ int vis_init(struct bat_priv *bat_priv)
 		goto err;
 	}
 
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 	start_vis_timer(bat_priv);
 	return 1;
 
@@ -862,7 +847,7 @@ free_info:
 	kfree(bat_priv->my_vis_info);
 	bat_priv->my_vis_info = NULL;
 err:
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 	vis_quit(bat_priv);
 	return 0;
 }
@@ -879,18 +864,17 @@ static void free_info_ref(void *data, void *arg)
 /* shutdown vis-server */
 void vis_quit(struct bat_priv *bat_priv)
 {
-	unsigned long flags;
 	if (!bat_priv->vis_hash)
 		return;
 
 	cancel_delayed_work_sync(&bat_priv->vis_work);
 
-	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	spin_lock_bh(&bat_priv->vis_hash_lock);
 	/* properly remove, kill timers ... */
 	hash_delete(bat_priv->vis_hash, free_info_ref, NULL);
 	bat_priv->vis_hash = NULL;
 	bat_priv->my_vis_info = NULL;
-	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->vis_hash_lock);
 }
 
 /* schedule packets for (re)transmission */
-- 
1.7.2.3

