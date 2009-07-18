Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 17:45:22 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718154522.GA15661@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] cleanup send.[ch]
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

Make send.[ch] clean with respect to the 2.6.29
checkpatch script. Exceptions are long lines with debug_log.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/send.c
===================================================================
--- batman-adv-kernelland/send.c	(revision 1351)
+++ batman-adv-kernelland/send.c	(working copy)
@@ -17,9 +17,6 @@
  *
  */
 
-
-
-
 #include "main.h"
 #include "send.h"
 #include "log.h"
@@ -32,10 +29,44 @@
 
 #include "compat.h"
 
+/* apply the hop penalty for a wireless link */
+static uint8_t wireless_hop_penalty(const uint8_t tq)
+{
+	return (tq * (TQ_MAX_VALUE - (2 * TQ_HOP_PENALTY))) / (TQ_MAX_VALUE);
+}
 
+/* apply hop penalty for a normal link */
+static uint8_t hop_penalty(const uint8_t tq)
+{
+	return (tq * (TQ_MAX_VALUE - TQ_HOP_PENALTY)) / (TQ_MAX_VALUE);
+}
 
+/* when do we schedule our own packet to be sent */
+static unsigned long own_send_time(void)
+{
+	return jiffies +
+		(((atomic_read(&originator_interval) - JITTER +
+		   (random32() % 2*JITTER)) * HZ) / 1000);
+}
+
+/* when do we schedule a forwarded packet to be sent */
+static unsigned long forward_send_time(void)
+{
+	unsigned long send_time = jiffies; /* Starting now plus... */
+
+	if (atomic_read(&aggregation_enabled))
+		send_time += (((MAX_AGGREGATION_MS - (JITTER/2) +
+				(random32() % JITTER)) * HZ) / 1000);
+	else
+		send_time += (((random32() % (JITTER/2)) * HZ) / 1000);
+
+	return send_time;
+}
+
 /* sends a raw packet. */
-void send_raw_packet(unsigned char *pack_buff, int pack_buff_len, uint8_t *src_addr, uint8_t *dst_addr, struct batman_if *batman_if)
+void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
+		     uint8_t *src_addr, uint8_t *dst_addr,
+		     struct batman_if *batman_if)
 {
 	struct ethhdr *ethhdr;
 	struct sk_buff *skb;
@@ -46,7 +77,8 @@
 		return;
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
-		debug_log(LOG_TYPE_WARN, "Interface %s is not up - can't send packet via that interface !\n", batman_if->dev);
+		debug_log(LOG_TYPE_WARN,
+			  "Interface %s is not up - can't send packet via that interface !\n", batman_if->dev);
 		batman_if->if_active = IF_TO_BE_DEACTIVATED;
 		return;
 	}
@@ -69,29 +101,103 @@
 	skb->protocol = __constant_htons(ETH_P_BATMAN);
 	skb->dev = batman_if->net_dev;
 
-	/* dev_queue_xmit() returns a negative result on error.
-	 * However on congestion and traffic shaping, it drops and returns
-	 * NET_XMIT_DROP (which is > 0). This will not be treated as an error. */
+	/* dev_queue_xmit() returns a negative result on error.	 However on
+	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
+	 * (which is > 0). This will not be treated as an error. */
 	retval = dev_queue_xmit(skb);
 	if (retval < 0) {
-		debug_log(LOG_TYPE_CRIT, "Can't write to raw socket: %i\n", retval);
+		debug_log(LOG_TYPE_CRIT, "Can't write to raw socket: %i\n",
+			  retval);
 		batman_if->if_active = IF_TO_BE_DEACTIVATED;
 	}
 }
 
+/* Send a packet to a given interface */
+static void send_packet_to_if(struct forw_packet *forw_packet,
+			      struct batman_if *batman_if)
+{
+	char *fwd_str;
+	uint8_t packet_num;
+	int16_t buff_pos;
+	struct batman_packet *batman_packet =
+		(struct batman_packet *)(forw_packet->packet_buff);
+	char orig_str[ETH_STR_LEN];
+
+	if (batman_if->if_active != IF_ACTIVE)
+		return;
+
+	packet_num = buff_pos = 0;
+	batman_packet = (struct batman_packet *)
+		(forw_packet->packet_buff);
+
+	/* adjust all flags and log packets */
+	while (aggregated_packet(buff_pos,
+				 forw_packet->packet_len,
+				 batman_packet->num_hna)) {
+
+		/* we might have aggregated direct link packets with an
+		 * ordinary base packet */
+		if ((forw_packet->direct_link_flags & (1 << packet_num)) &&
+		    (forw_packet->if_incoming == batman_if))
+			batman_packet->flags |= DIRECTLINK;
+		else
+			batman_packet->flags &= ~DIRECTLINK;
+
+		/* for later logging */
+		if (packet_num > 0)
+			addr_to_string(orig_str, batman_packet->orig);
+
+		/**
+		 * if the outgoing interface is a wifi interface and
+		 * equal to the incoming interface add extra penalty
+		 * (own packets are to be ignored)
+		 */
+		if ((batman_if->net_dev->wireless_handlers) &&
+		    (!forw_packet->own) &&
+		    (forw_packet->if_incoming == batman_if))
+			batman_packet->tq =
+				wireless_hop_penalty(batman_packet->tq);
+
+		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
+							    "Sending own" :
+							    "Forwarding"));
+		debug_log(LOG_TYPE_BATMAN,
+			  "%s %s packet (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
+			  fwd_str,
+			  (packet_num > 0 ? "aggregated " : ""),
+			  orig_str, ntohs(batman_packet->seqno),
+			  batman_packet->tq, batman_packet->ttl,
+			  (batman_packet->flags & DIRECTLINK ?
+			   "on" : "off"),
+			  batman_if->dev, batman_if->addr_str);
+
+		buff_pos += sizeof(struct batman_packet) +
+			(batman_packet->num_hna * ETH_ALEN);
+		packet_num++;
+		batman_packet = (struct batman_packet *)
+			(forw_packet->packet_buff + buff_pos);
+	}
+
+	send_raw_packet(forw_packet->packet_buff,
+			forw_packet->packet_len,
+			batman_if->net_dev->dev_addr,
+			broadcastAddr, batman_if);
+}
+
 /* send a batman packet */
 static void send_packet(struct forw_packet *forw_packet)
 {
 	struct batman_if *batman_if;
-	struct batman_packet *batman_packet = (struct batman_packet *)(forw_packet->packet_buff);
+	struct batman_packet *batman_packet =
+		(struct batman_packet *)(forw_packet->packet_buff);
 	char orig_str[ETH_STR_LEN];
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
-	uint8_t packet_num;
-	int16_t buff_pos;
 
-	/* according to calltree the incoming iface should always be specified. */
+	/* according to calltree the incoming iface should always be
+	 * specified. */
 	if (forw_packet->if_incoming == NULL) {
-		debug_log(LOG_TYPE_CRIT, "Error - can't forward packet: incoming iface not specified\n");
+		debug_log(LOG_TYPE_CRIT,
+			  "Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
@@ -103,94 +209,66 @@
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
 	if ((directlink && (batman_packet->ttl == 1)) ||
-		    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
+	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
 
 		/* FIXME: what about aggregated packets ? */
-		debug_log(LOG_TYPE_BATMAN, "%s packet (originator %s, seqno %d, TTL %d) on interface %s [%s]\n", (forw_packet->own ? "Sending own" : "Forwarding"), orig_str, ntohs(batman_packet->seqno), batman_packet->ttl, forw_packet->if_incoming->dev, forw_packet->if_incoming->addr_str);
+		debug_log(LOG_TYPE_BATMAN,
+			  "%s packet (originator %s, seqno %d, TTL %d) on interface %s [%s]\n",
+			  (forw_packet->own ? "Sending own" : "Forwarding"),
+			  orig_str, ntohs(batman_packet->seqno),
+			  batman_packet->ttl, forw_packet->if_incoming->dev,
+			  forw_packet->if_incoming->addr_str);
 
-		send_raw_packet(forw_packet->packet_buff, forw_packet->packet_len, forw_packet->if_incoming->net_dev->dev_addr, broadcastAddr, forw_packet->if_incoming);
+		send_raw_packet(forw_packet->packet_buff,
+				forw_packet->packet_len,
+				forw_packet->if_incoming->net_dev->dev_addr,
+				broadcastAddr, forw_packet->if_incoming);
 		return;
 	}
 
 	/* broadcast on every interface */
 	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (batman_if->if_active != IF_ACTIVE)
-			continue;
+	list_for_each_entry_rcu(batman_if, &if_list, list)
+		send_packet_to_if(forw_packet, batman_if);
+	rcu_read_unlock();
+}
 
-		packet_num = buff_pos = 0;
-		batman_packet = (struct batman_packet *)(forw_packet->packet_buff);
+static void rebuild_batman_packet(struct batman_if *batman_if)
+{
+	int new_len;
+	unsigned char *new_buff;
+	struct batman_packet *batman_packet;
 
-		/* adjust all flags and log packets */
-		while (aggregated_packet(buff_pos, forw_packet->packet_len, batman_packet->num_hna)) {
+	new_len = sizeof(struct batman_packet) + (num_hna * ETH_ALEN);
+	new_buff = kmalloc(new_len, GFP_ATOMIC);
 
-			/* we might have aggregated direct link packets with an ordinary base packet */
-			if ((forw_packet->direct_link_flags & (1 << packet_num)) && (forw_packet->if_incoming == batman_if))
-				batman_packet->flags |= DIRECTLINK;
-			else
-				batman_packet->flags &= ~DIRECTLINK;
+	/* keep old buffer if kmalloc should fail */
+	if (new_buff) {
+		memcpy(new_buff, batman_if->packet_buff,
+		       sizeof(struct batman_packet));
+		batman_packet = (struct batman_packet *)new_buff;
 
-			/* for later logging */
-			if (packet_num > 0)
-				addr_to_string(orig_str, batman_packet->orig);
+		batman_packet->num_hna = hna_local_fill_buffer(
+			new_buff + sizeof(struct batman_packet),
+			new_len - sizeof(struct batman_packet));
 
-			/**
-			 * if the outgoing interface is a wifi interface and equal to the incoming interface
-			 * add extra penalty (own packets are to be ignored)
-			 */
-			if ((batman_if->net_dev->wireless_handlers) && (!forw_packet->own) &&
-					(forw_packet->if_incoming == batman_if))
-				batman_packet->tq = (batman_packet->tq * (TQ_MAX_VALUE - (2 * TQ_HOP_PENALTY))) / (TQ_MAX_VALUE);
-
-			debug_log(LOG_TYPE_BATMAN,
-					"%s %s packet (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
-					(packet_num > 0 ? "Forwarding" : (forw_packet->own ? "Sending own" : "Forwarding")),
-					(packet_num > 0 ? "aggregated " : ""), orig_str, ntohs(batman_packet->seqno),
-					batman_packet->tq, batman_packet->ttl,
-					(batman_packet->flags & DIRECTLINK ? "on" : "off"),
-					batman_if->dev, batman_if->addr_str);
-
-			buff_pos += sizeof(struct batman_packet) + (batman_packet->num_hna * ETH_ALEN);
-			packet_num++;
-			batman_packet = (struct batman_packet *)(forw_packet->packet_buff + buff_pos);
-		}
-
-		send_raw_packet(forw_packet->packet_buff, forw_packet->packet_len, batman_if->net_dev->dev_addr, broadcastAddr, batman_if);
+		kfree(batman_if->packet_buff);
+		batman_if->packet_buff = new_buff;
+		batman_if->packet_len = new_len;
 	}
-	rcu_read_unlock();
 }
 
 void schedule_own_packet(struct batman_if *batman_if)
 {
-	unsigned char *new_buff;
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
-	int new_len;
 
 	batman_packet = (struct batman_packet *)batman_if->packet_buff;
 
 	/* if local hna has changed and interface is a primary interface */
-	if ((hna_local_changed) && (batman_if->if_num == 0)) {
+	if ((hna_local_changed) && (batman_if->if_num == 0))
+		rebuild_batman_packet(batman_if);
 
-		new_len = sizeof(struct batman_packet) + (num_hna * ETH_ALEN);
-		new_buff = kmalloc(new_len, GFP_ATOMIC);
-
-		/* keep old buffer if kmalloc should fail */
-		if (new_buff) {
-			memcpy(new_buff, batman_if->packet_buff, sizeof(struct batman_packet));
-			batman_packet = (struct batman_packet *)new_buff;
-
-			batman_packet->num_hna = hna_local_fill_buffer(
-						new_buff + sizeof(struct batman_packet),
-						new_len - sizeof(struct batman_packet));
-
-			kfree(batman_if->packet_buff);
-			batman_if->packet_buff = new_buff;
-			batman_if->packet_len = new_len;
-		}
-
-	}
-
 	/* change sequence number to network order */
 	batman_packet->seqno = htons((uint16_t)atomic_read(&batman_if->seqno));
 
@@ -203,11 +281,16 @@
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
-	send_time = jiffies + (((atomic_read(&originator_interval) - JITTER + (random32() % 2*JITTER)) * HZ) / 1000);
-	add_bat_packet_to_list(batman_if->packet_buff, batman_if->packet_len, batman_if, 1, send_time);
+	send_time = own_send_time();
+	add_bat_packet_to_list(batman_if->packet_buff,
+			       batman_if->packet_len, batman_if, 1, send_time);
 }
 
-void schedule_forward_packet(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, uint8_t directlink, int hna_buff_len, struct batman_if *if_incoming)
+void schedule_forward_packet(struct orig_node *orig_node,
+			     struct ethhdr *ethhdr,
+			     struct batman_packet *batman_packet,
+			     uint8_t directlink, int hna_buff_len,
+			     struct batman_if *if_incoming)
 {
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
@@ -223,7 +306,8 @@
 	batman_packet->ttl--;
 	memcpy(batman_packet->old_orig, ethhdr->h_source, ETH_ALEN);
 
-	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast of our best tq value */
+	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
+	 * of our best tq value */
 	if ((orig_node->router != NULL) && (orig_node->router->tq_avg != 0)) {
 
 		/* rebroadcast ogm of best ranking neighbor as is */
@@ -231,17 +315,17 @@
 
 			batman_packet->tq = orig_node->router->tq_avg;
 			batman_packet->ttl = orig_node->router->last_ttl - 1;
-
 		}
 
 		tq_avg = orig_node->router->tq_avg;
-
 	}
 
 	/* apply hop penalty */
-	batman_packet->tq = (batman_packet->tq * (TQ_MAX_VALUE - TQ_HOP_PENALTY)) / (TQ_MAX_VALUE);
+	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	debug_log(LOG_TYPE_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i \n", in_tq, tq_avg, batman_packet->tq, in_ttl - 1, batman_packet->ttl);
+	debug_log(LOG_TYPE_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i \n",
+		  in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
+		  batman_packet->ttl);
 
 	batman_packet->seqno = htons(batman_packet->seqno);
 
@@ -250,12 +334,10 @@
 	else
 		batman_packet->flags &= ~DIRECTLINK;
 
-	if (atomic_read(&aggregation_enabled))
-		send_time = jiffies + (((MAX_AGGREGATION_MS - (JITTER/2) + (random32() % JITTER)) * HZ) / 1000);
-	else
-		send_time = jiffies + (((random32() % (JITTER/2)) * HZ) / 1000);
-
-	add_bat_packet_to_list((unsigned char *)batman_packet, sizeof(struct batman_packet) + hna_buff_len, if_incoming, 0, send_time);
+	send_time = forward_send_time();
+	add_bat_packet_to_list((unsigned char *)batman_packet,
+			       sizeof(struct batman_packet) + hna_buff_len,
+			       if_incoming, 0, send_time);
 }
 
 static void forw_packet_free(struct forw_packet *forw_packet)
@@ -264,7 +346,8 @@
 	kfree(forw_packet);
 }
 
-static void _add_bcast_packet_to_list(struct forw_packet *forw_packet, unsigned long send_time)
+static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
+				      unsigned long send_time)
 {
 	INIT_HLIST_NODE(&forw_packet->list);
 
@@ -274,8 +357,10 @@
 	spin_unlock(&forw_bcast_list_lock);
 
 	/* start timer for this packet */
-	INIT_DELAYED_WORK(&forw_packet->delayed_work, send_outstanding_bcast_packet);
-	queue_delayed_work(bat_event_workqueue, &forw_packet->delayed_work, send_time);
+	INIT_DELAYED_WORK(&forw_packet->delayed_work,
+			  send_outstanding_bcast_packet);
+	queue_delayed_work(bat_event_workqueue, &forw_packet->delayed_work,
+			   send_time);
 }
 
 void add_bcast_packet_to_list(unsigned char *packet_buff, int packet_len)
@@ -297,8 +382,10 @@
 void send_outstanding_bcast_packet(struct work_struct *work)
 {
 	struct batman_if *batman_if;
-	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
-	struct forw_packet *forw_packet = container_of(delayed_work, struct forw_packet, delayed_work);
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct forw_packet *forw_packet =
+		container_of(delayed_work, struct forw_packet, delayed_work);
 
 	spin_lock(&forw_bcast_list_lock);
 	hlist_del(&forw_packet->list);
@@ -307,15 +394,19 @@
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		send_raw_packet(forw_packet->packet_buff, forw_packet->packet_len,
-				batman_if->net_dev->dev_addr, broadcastAddr, batman_if);
+		send_raw_packet(forw_packet->packet_buff,
+				forw_packet->packet_len,
+				batman_if->net_dev->dev_addr,
+				broadcastAddr, batman_if);
 	}
 	rcu_read_unlock();
 
 	forw_packet->num_packets++;
 
-	/* if we still have some more bcasts to send and we are not shutting down */
-	if ((forw_packet->num_packets < 3) && (module_state != MODULE_INACTIVE))
+	/* if we still have some more bcasts to send and we are not shutting
+	 * down */
+	if ((forw_packet->num_packets < 3) &&
+	    (module_state != MODULE_INACTIVE))
 		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
 	else
 		forw_packet_free(forw_packet);
@@ -323,8 +414,10 @@
 
 void send_outstanding_bat_packet(struct work_struct *work)
 {
-	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
-	struct forw_packet *forw_packet = container_of(delayed_work, struct forw_packet, delayed_work);
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct forw_packet *forw_packet =
+		container_of(delayed_work, struct forw_packet, delayed_work);
 
 	spin_lock(&forw_bat_list_lock);
 	hlist_del(&forw_packet->list);
@@ -352,7 +445,8 @@
 
 	/* free bcast list */
 	spin_lock(&forw_bcast_list_lock);
-	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node, &forw_bcast_list, list) {
+	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
+				  &forw_bcast_list, list) {
 
 		spin_unlock(&forw_bcast_list_lock);
 
@@ -367,7 +461,8 @@
 
 	/* free batman packet list */
 	spin_lock(&forw_bat_list_lock);
-	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node, &forw_bat_list, list) {
+	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
+				  &forw_bat_list, list) {
 
 		spin_unlock(&forw_bat_list_lock);
 
Index: batman-adv-kernelland/send.h
===================================================================
--- batman-adv-kernelland/send.h	(revision 1351)
+++ batman-adv-kernelland/send.h	(working copy)
@@ -17,18 +17,18 @@
  *
  */
 
-
-
-
-
 #include "types.h"
 
-
-
 void send_own_packet_work(struct work_struct *work);
-void send_raw_packet(unsigned char *pack_buff, int pack_buff_len, uint8_t *src_addr, uint8_t *dst_addr, struct batman_if *batman_if);
+void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
+		     uint8_t *src_addr, uint8_t *dst_addr,
+		     struct batman_if *batman_if);
 void schedule_own_packet(struct batman_if *batman_if);
-void schedule_forward_packet(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, uint8_t directlink, int hna_buff_len, struct batman_if *if_outgoing);
+void schedule_forward_packet(struct orig_node *orig_node,
+			     struct ethhdr *ethhdr,
+			     struct batman_packet *batman_packet,
+			     uint8_t directlink, int hna_buff_len,
+			     struct batman_if *if_outgoing);
 void add_bcast_packet_to_list(unsigned char *packet_buff, int packet_len);
 void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
