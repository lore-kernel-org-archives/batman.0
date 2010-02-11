Return-Path: <andrew@lunn.ch>
Date: Thu, 11 Feb 2010 10:46:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100211094659.GH2900@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100130165059.GV24649@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Linus

Here is a new version of the patch. I've tested it this time using
five UML machines. It should not immediately opps now. 

Please could you test it with your test setup.

       Thanks
   	  Andrew

Staging: batman-adv: Don't have interrupts disabled while sending.

send_vis_packets() would disable interrupts before calling
dev_queue_xmit() which resulting in a backtrace in local_bh_enable().
Fix this by using kref on the vis_info object so that we can call
send_vis_packets() without holding vis_hash_lock. vis_hash_lock also
used to protect recv_list, so we now need a new lock to protect that
instead of vis_hash_lock.

Also a few checkpatch cleanups.

Reported-by: Linus L\374ssing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Index: vis.c


Index: vis.c
===================================================================
--- vis.c	(revision 1568)
+++ vis.c	(working copy)
@@ -30,22 +30,26 @@
 
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
+static DEFINE_SPINLOCK(recv_list_lock);
 static struct vis_info *my_vis_info;
 static struct list_head send_list;	/* always locked with vis_hash_lock */
 
 static void start_vis_timer(void);
 
 /* free the info */
-static void free_info(void *data)
+static void free_info(struct kref *ref)
 {
-	struct vis_info *info = data;
+	struct vis_info *info = container_of(ref, struct vis_info, refcount);
 	struct recvlist_node *entry, *tmp;
+	unsigned long flags;
 
 	list_del_init(&info->send_list);
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
 		list_del(&entry->list);
 		kfree(entry);
 	}
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 	kfree(info);
 }
 
@@ -147,32 +151,41 @@
 static void recv_list_add(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
+	unsigned long flags;
+
 	entry = kmalloc(sizeof(struct recvlist_node), GFP_ATOMIC);
 	if (!entry)
 		return;
 
 	memcpy(entry->mac, mac, ETH_ALEN);
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_add_tail(&entry->list, recv_list);
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 }
 
 /* returns 1 if this mac is in the recv_list */
 static int recv_list_is_in(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
+	unsigned long flags;
 
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_for_each_entry(entry, recv_list, list) {
-		if (memcmp(entry->mac, mac, ETH_ALEN) == 0)
+		if (memcmp(entry->mac, mac, ETH_ALEN) == 0) {
+			spin_unlock_irqrestore(&recv_list_lock, flags);
 			return 1;
+		}
 	}
-
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 	return 0;
 }
 
 /* try to add the packet to the vis_hash. return NULL if invalid (e.g. too old,
- * broken.. ).  vis hash must be locked outside.  is_new is set when the packet
+ * broken.. ).	vis hash must be locked outside.  is_new is set when the packet
  * is newer than old entries in the hash. */
 static struct vis_info *add_packet(struct vis_packet *vis_packet,
-				   int vis_info_len, int *is_new)
+				   int vis_info_len, int *is_new,
+				   int make_broadcast)
 {
 	struct vis_info *info, *old_info;
 	struct vis_info search_elem;
@@ -199,7 +212,7 @@
 		}
 		/* remove old entry */
 		hash_remove(vis_hash, old_info);
-		free_info(old_info);
+		kref_put(&old_info->refcount, free_info);
 	}
 
 	info = kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
@@ -208,6 +221,7 @@
 
 	INIT_LIST_HEAD(&info->send_list);
 	INIT_LIST_HEAD(&info->recv_list);
+	kref_init(&info->refcount);
 	info->first_seen = jiffies;
 	memcpy(&info->packet, vis_packet,
 	       sizeof(struct vis_packet) + vis_info_len);
@@ -215,16 +229,21 @@
 	/* initialize and add new packet. */
 	*is_new = 1;
 
+	/* Make it a broadcast packet, if required */
+	if (make_broadcast)
+		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+
 	/* repair if entries is longer than packet. */
 	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
-		info->packet.entries = vis_info_len / sizeof(struct vis_info_entry);
+		info->packet.entries = vis_info_len /
+			sizeof(struct vis_info_entry);
 
 	recv_list_add(&info->recv_list, info->packet.sender_orig);
 
 	/* try to add it */
 	if (hash_add(vis_hash, info) < 0) {
 		/* did not work (for some reason) */
-		free_info(info);
+		kref_put(&old_info->refcount, free_info);
 		info = NULL;
 	}
 
@@ -235,19 +254,20 @@
 void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
 {
 	struct vis_info *info;
-	int is_new;
+	int is_new, make_broadcast;
 	unsigned long flags;
 	int vis_server = atomic_read(&vis_mode);
 
+	make_broadcast = (vis_server == VIS_TYPE_SERVER_SYNC);
+
 	spin_lock_irqsave(&vis_hash_lock, flags);
-	info = add_packet(vis_packet, vis_info_len, &is_new);
+	info = add_packet(vis_packet, vis_info_len, &is_new, make_broadcast);
 	if (info == NULL)
 		goto end;
 
 	/* only if we are server ourselves and packet is newer than the one in
 	 * hash.*/
 	if (vis_server == VIS_TYPE_SERVER_SYNC && is_new) {
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
 	}
@@ -263,24 +283,27 @@
 	int is_new;
 	unsigned long flags;
 	int vis_server = atomic_read(&vis_mode);
+	int are_target = 0;
 
 	/* clients shall not broadcast. */
 	if (is_bcast(vis_packet->target_orig))
 		return;
 
+	/* Are we the target for this VIS packet? */
+	if (vis_server == VIS_TYPE_SERVER_SYNC	&&
+	    is_my_mac(vis_packet->target_orig))
+		are_target = 1;
+
 	spin_lock_irqsave(&vis_hash_lock, flags);
-	info = add_packet(vis_packet, vis_info_len, &is_new);
+	info = add_packet(vis_packet, vis_info_len, &is_new, are_target);
 	if (info == NULL)
 		goto end;
 	/* note that outdated packets will be dropped at this point. */
 
 
 	/* send only if we're the target server or ... */
-	if (vis_server == VIS_TYPE_SERVER_SYNC  &&
-	    is_my_mac(info->packet.target_orig) &&
-	    is_new) {
+	if (are_target && is_new) {
 		info->packet.vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
 
@@ -362,14 +385,17 @@
 	while (hash_iterate(orig_hash, &hashit_global)) {
 		orig_node = hashit_global.bucket->data;
 		if (orig_node->router != NULL
-			&& compare_orig(orig_node->router->addr, orig_node->orig)
+			&& compare_orig(orig_node->router->addr,
+					orig_node->orig)
 			&& orig_node->batman_if
 			&& (orig_node->batman_if->if_active == IF_ACTIVE)
 		    && orig_node->router->tq_avg > 0) {
 
 			/* fill one entry into buffer. */
 			entry = &entry_array[info->packet.entries];
-			memcpy(entry->src, orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
+			memcpy(entry->src,
+			       orig_node->batman_if->net_dev->dev_addr,
+			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality = orig_node->router->tq_avg;
 			info->packet.entries++;
@@ -401,6 +427,8 @@
 	return 0;
 }
 
+/* free old vis packets. Must be called with this vis_hash_lock
+ * held */
 static void purge_vis_packets(void)
 {
 	HASHIT(hashit);
@@ -413,7 +441,7 @@
 		if (time_after(jiffies,
 			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
 			hash_remove_bucket(vis_hash, &hashit);
-			free_info(info);
+			kref_put(&info->refcount, free_info);
 		}
 	}
 }
@@ -423,6 +451,8 @@
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	unsigned long flags;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 
@@ -431,46 +461,57 @@
 		orig_node = hashit.bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
-		if (orig_node &&
-		    (orig_node->flags & VIS_SERVER) &&
-		    orig_node->batman_if &&
-		    orig_node->router) {
+		if ((!orig_node) || (!orig_node->batman_if) ||
+		    (!orig_node->router))
+			continue;
+		if (!(orig_node->flags & VIS_SERVER))
+			continue;
+		/* don't send it if we already received the packet from
+		 * this node. */
+		if (recv_list_is_in(&info->recv_list, orig_node->orig))
+			continue;
 
-			/* don't send it if we already received the packet from
-			 * this node. */
-			if (recv_list_is_in(&info->recv_list, orig_node->orig))
-				continue;
+		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
+		batman_if = orig_node->batman_if;
+		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-			memcpy(info->packet.target_orig,
-			       orig_node->orig, ETH_ALEN);
+		send_raw_packet((unsigned char *)&info->packet,
+				packet_length, batman_if, dstaddr);
 
-			send_raw_packet((unsigned char *) &info->packet,
-					packet_length,
-					orig_node->batman_if,
-					orig_node->router->addr);
-		}
+		spin_lock_irqsave(&orig_hash_lock, flags);
+
 	}
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
 
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
 	unsigned long flags;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, info->packet.target_orig));
 
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
-		send_raw_packet((unsigned char *) &info->packet, packet_length,
-				orig_node->batman_if,
-				orig_node->router->addr);
-	}
+	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
+		goto out;
+
+	/* don't lock while sending the packets ... we therefore
+	 * copy the required data before sending */
+	batman_if = orig_node->batman_if;
+	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	send_raw_packet((unsigned char *)&info->packet,
+			packet_length, batman_if, dstaddr);
+	return;
+
+out:
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
 
 /* only send one vis packet. called from send_vis_packets() */
@@ -503,6 +544,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
+
 	purge_vis_packets();
 
 	if (generate_vis_packet() == 0)
@@ -511,7 +553,11 @@
 
 	list_for_each_entry_safe(info, temp, &send_list, send_list) {
 		list_del_init(&info->send_list);
+		kref_get(&info->refcount);
+		spin_unlock_irqrestore(&vis_hash_lock, flags);
 		send_vis_packet(info);
+		spin_lock_irqsave(&vis_hash_lock, flags);
+		kref_put(&info->refcount, free_info);
 	}
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 	start_vis_timer();
@@ -544,6 +590,7 @@
 	my_vis_info->first_seen = jiffies - atomic_read(&vis_interval);
 	INIT_LIST_HEAD(&my_vis_info->recv_list);
 	INIT_LIST_HEAD(&my_vis_info->send_list);
+	kref_init(&my_vis_info->refcount);
 	my_vis_info->packet.version = COMPAT_VERSION;
 	my_vis_info->packet.packet_type = BAT_VIS;
 	my_vis_info->packet.ttl = TTL;
@@ -557,9 +604,9 @@
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		printk(KERN_ERR
-			  "batman-adv:Can't add own vis packet into hash\n");
-		free_info(my_vis_info);	/* not in hash, need to remove it
-					 * manually. */
+		       "batman-adv:Can't add own vis packet into hash\n");
+		/* not in hash, need to remove it manually. */
+		kref_put(&my_vis_info->refcount, free_info);
 		goto err;
 	}
 
@@ -573,6 +620,13 @@
 	return 0;
 }
 
+/* Decrease the reference count on a hash item info */
+static void free_info_ref(void *data)
+{
+	struct vis_info *info = data;
+	kref_put(&info->refcount, free_info);
+}
+
 /* shutdown vis-server */
 void vis_quit(void)
 {
@@ -584,7 +638,7 @@
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	/* properly remove, kill timers ... */
-	hash_delete(vis_hash, free_info);
+	hash_delete(vis_hash, free_info_ref);
 	vis_hash = NULL;
 	my_vis_info = NULL;
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
@@ -594,5 +648,5 @@
 static void start_vis_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (atomic_read(&vis_interval) * HZ ) / 1000);
+			   (atomic_read(&vis_interval) * HZ) / 1000);
 }
Index: vis.h
===================================================================
--- vis.h	(revision 1568)
+++ vis.h	(working copy)
@@ -29,6 +29,7 @@
 			    /* list of server-neighbors we received a vis-packet
 			     * from.  we should not reply to them. */
 	struct list_head send_list;
+	struct kref refcount;
 	/* this packet might be part of the vis send queue. */
 	struct vis_packet packet;
 	/* vis_info may follow here*/
