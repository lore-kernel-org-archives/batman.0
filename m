Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:32:50 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718143250.GI4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup aggregation.[ch]
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

Make aggregation.[ch] clean with respect to the 2.6.29 checkpatch script.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/aggregation.c
===================================================================
--- batman-adv-kernelland/aggregation.c	(revision 1351)
+++ batman-adv-kernelland/aggregation.c	(working copy)
@@ -17,146 +17,212 @@
  *
  */
 
-
-
-
 #include "main.h"
 #include "aggregation.h"
 #include "send.h"
 #include "routing.h"
 
+/* calculate the size of the hna information for a given packet */
+static int hna_len(struct batman_packet *batman_packet)
+{
+	return batman_packet->num_hna * ETH_ALEN;
+}
 
+/* return true if new_packet can be aggregated with forw_packet */
+static bool can_aggregate_with(struct batman_packet *new_packet,
+			       int packet_len,
+			       unsigned long send_time,
+			       bool directlink,
+			       struct batman_if *if_incoming,
+			       struct forw_packet *forw_packet_pos)
+{
 
-void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len, struct batman_if *if_incoming, char own_packet, unsigned long send_time)
-{
+	struct batman_packet *forw_packet =
+		(struct batman_packet *)forw_packet_pos->packet_buff;
+	int aggregated_bytes = forw_packet_pos->packet_len + packet_len;
+
 	/**
-	 * _aggr -> pointer to the packet we want to aggregate with
-	 * _pos -> pointer to the position in the queue
+	 * we can aggregate the current packet to this aggregated packet
+	 * if:
+	 *
+	 * - the send time is within our MAX_AGGREGATION_MS time
+	 * - the resulting packet wont be bigger than
+	 *   MAX_AGGREGATION_BYTES
 	 */
-	struct forw_packet *forw_packet_aggr = NULL, *forw_packet_pos = NULL;
-	struct hlist_node *tmp_node;
-	struct batman_packet *batman_packet;
-	unsigned char directlink = (((struct batman_packet *)packet_buff)->flags & DIRECTLINK ? 1 : 0);
 
-	/* find position for the packet in the forward queue */
-	spin_lock(&forw_bat_list_lock);
-	hlist_for_each_entry(forw_packet_pos, tmp_node, &forw_bat_list, list) {
+	if (time_before(send_time, forw_packet_pos->send_time) &&
+	    (aggregated_bytes <= MAX_AGGREGATION_BYTES)) {
 
-		/* own packets are not to be aggregated */
-		if ((atomic_read(&aggregation_enabled)) && (!own_packet)) {
+		/**
+		 * check aggregation compatibility
+		 * -> direct link packets are broadcasted on
+		 *    their interface only
+		 * -> aggregate packet if the current packet is
+		 *    a "global" packet as well as the base
+		 *    packet
+		 */
 
-			/* don't save aggregation position if aggregation is disabled */
-			forw_packet_aggr = forw_packet_pos;
+		/* packets without direct link flag and high TTL
+		 * are flooded through the net  */
+		if ((!directlink) &&
+		    (!(forw_packet->flags & DIRECTLINK)) &&
+		    (forw_packet->ttl != 1) &&
 
-			/**
-			 * we can aggregate the current packet to this packet if:
-			 * - the send time is within our MAX_AGGREGATION_MS time
-			 * - the resulting packet wont be bigger than MAX_AGGREGATION_BYTES
-			 */
-			if ((time_before(send_time, forw_packet_pos->send_time)) &&
-						(forw_packet_pos->packet_len + packet_len <= MAX_AGGREGATION_BYTES)) {
+		    /* own packets originating non-primary
+		     * interfaces leave only that interface */
+		    ((!forw_packet_pos->own) ||
+		     (forw_packet_pos->if_incoming->if_num == 0)))
+			return true;
 
-				batman_packet = (struct batman_packet *)forw_packet_pos->packet_buff;
+		/* if the incoming packet is sent via this one
+		 * interface only - we still can aggregate */
+		if ((directlink) &&
+		    (new_packet->ttl == 1) &&
+		    (forw_packet_pos->if_incoming == if_incoming))
+			return true;
 
-				/**
-				 * check aggregation compatibility
-				 * -> direct link packets are broadcasted on their interface only
-				 * -> aggregate packet if the current packet is a "global" packet
-				 *    as well as the base packet
-				 */
+	}
+	return false;
+}
 
-				/* packets without direct link flag and high TTL are flooded through the net  */
-				if ((!directlink) && (!(batman_packet->flags & DIRECTLINK)) && (batman_packet->ttl != 1) &&
+/* create a new aggregated packet and add this packet to it */
+void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
+			   unsigned long send_time,
+			   bool direct_link,
+			   struct batman_if *if_incoming,
+			   int own_packet)
+{
+	struct forw_packet *forw_packet_aggr;
 
-				/* own packets originating non-primary interfaces leave only that interface */
-						((!forw_packet_pos->own) || (forw_packet_pos->if_incoming->if_num == 0)))
-					break;
+	forw_packet_aggr = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
+	if (!forw_packet_aggr)
+		return;
 
-				batman_packet = (struct batman_packet *)packet_buff;
+	forw_packet_aggr->packet_buff = kmalloc(MAX_AGGREGATION_BYTES,
+						GFP_ATOMIC);
+	if (!forw_packet_aggr->packet_buff) {
+		kfree(forw_packet_aggr);
+		return;
+	}
 
-				/* if the incoming packet is sent via this one interface only - we still can aggregate */
-				if ((directlink) && (batman_packet->ttl == 1) && (forw_packet_pos->if_incoming == if_incoming))
-					break;
+	INIT_HLIST_NODE(&forw_packet_aggr->list);
 
-			}
+	forw_packet_aggr->packet_len = packet_len;
+	memcpy(forw_packet_aggr->packet_buff,
+	       packet_buff,
+	       forw_packet_aggr->packet_len);
 
-			/* could not find packet to aggregate with */
-			forw_packet_aggr = NULL;
+	forw_packet_aggr->own = own_packet;
+	forw_packet_aggr->if_incoming = if_incoming;
+	forw_packet_aggr->num_packets = 0;
+	forw_packet_aggr->direct_link_flags = 0;
+	forw_packet_aggr->send_time = send_time;
 
-		}
+	/* save packet direct link flag status */
+	if (direct_link)
+		forw_packet_aggr->direct_link_flags |= 1;
 
-	}
+	/* add new packet to packet list */
+	spin_lock(&forw_bat_list_lock);
+	hlist_add_head(&forw_packet_aggr->list, &forw_bat_list);
+	spin_unlock(&forw_bat_list_lock);
 
-	/* nothing to aggregate with - either aggregation disabled or no suitable aggregation packet found */
-	if (forw_packet_aggr == NULL) {
+	/* start timer for this packet */
+	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
+			  send_outstanding_bat_packet);
+	queue_delayed_work(bat_event_workqueue,
+			   &forw_packet_aggr->delayed_work,
+			   send_time - jiffies);
+}
 
-		/* the following section can run without the lock */
-		spin_unlock(&forw_bat_list_lock);
+/* aggregate a new packet into the existing aggregation */
+static void aggregate(struct forw_packet *forw_packet_aggr,
+		      unsigned char *packet_buff, int packet_len,
+		      bool direct_link)
+{
+	memcpy((forw_packet_aggr->packet_buff + forw_packet_aggr->packet_len),
+	       packet_buff, packet_len);
+	forw_packet_aggr->packet_len += packet_len;
+	forw_packet_aggr->num_packets++;
 
-		forw_packet_aggr = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
-		forw_packet_aggr->packet_buff = kmalloc(MAX_AGGREGATION_BYTES, GFP_ATOMIC);
+	/* save packet direct link flag status */
+	if (direct_link)
+		forw_packet_aggr->direct_link_flags |=
+			(1 << forw_packet_aggr->num_packets);
+}
 
-		INIT_HLIST_NODE(&forw_packet_aggr->list);
+void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
+			    struct batman_if *if_incoming, char own_packet,
+			    unsigned long send_time)
+{
+	/**
+	 * _aggr -> pointer to the packet we want to aggregate with
+	 * _pos -> pointer to the position in the queue
+	 */
+	struct forw_packet *forw_packet_aggr = NULL, *forw_packet_pos = NULL;
+	struct hlist_node *tmp_node;
+	struct batman_packet *batman_packet =
+		(struct batman_packet *)packet_buff;
+	bool direct_link = batman_packet->flags & DIRECTLINK ? 1 : 0;
 
-		forw_packet_aggr->packet_len = packet_len;
-		memcpy(forw_packet_aggr->packet_buff, packet_buff, forw_packet_aggr->packet_len);
+	/* find position for the packet in the forward queue */
+	spin_lock(&forw_bat_list_lock);
+	/* own packets are not to be aggregated */
+	if ((atomic_read(&aggregation_enabled)) && (!own_packet)) {
+		hlist_for_each_entry(forw_packet_pos, tmp_node, &forw_bat_list,
+				     list) {
+			if (can_aggregate_with(batman_packet,
+					       packet_len,
+					       send_time,
+					       direct_link,
+					       if_incoming,
+					       forw_packet_pos)) {
+				forw_packet_aggr = forw_packet_pos;
+				break;
+			}
+		}
+	}
 
-		forw_packet_aggr->own = own_packet;
-		forw_packet_aggr->if_incoming = if_incoming;
-		forw_packet_aggr->num_packets = 0;
-		forw_packet_aggr->direct_link_flags = 0;
-
-		forw_packet_aggr->send_time = send_time;
-
-		batman_packet = (struct batman_packet *)packet_buff;
-
-		/* save packet direct link flag status */
-		if (batman_packet->flags & DIRECTLINK)
-			forw_packet_aggr->direct_link_flags = forw_packet_aggr->direct_link_flags | (1 << forw_packet_aggr->num_packets);
-
-		/* add new packet to packet list */
-		spin_lock(&forw_bat_list_lock);
-		hlist_add_head(&forw_packet_aggr->list, &forw_bat_list);
+	/* nothing to aggregate with - either aggregation disabled or no
+	 * suitable aggregation packet found */
+	if (forw_packet_aggr == NULL) {
+		/* the following section can run without the lock */
 		spin_unlock(&forw_bat_list_lock);
-
-		/* start timer for this packet */
-		INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work, send_outstanding_bat_packet);
-		queue_delayed_work(bat_event_workqueue, &forw_packet_aggr->delayed_work, send_time - jiffies);
-
+		new_aggregated_packet(packet_buff, packet_len,
+				      send_time, direct_link,
+				      if_incoming, own_packet);
 	} else {
-
-		batman_packet = (struct batman_packet *)packet_buff;
-
-		memcpy(forw_packet_aggr->packet_buff + forw_packet_aggr->packet_len, packet_buff, packet_len);
-		forw_packet_aggr->packet_len += packet_len;
-
-		forw_packet_aggr->num_packets++;
-
-		/* save packet direct link flag status */
-		if (batman_packet->flags & DIRECTLINK)
-			forw_packet_aggr->direct_link_flags = forw_packet_aggr->direct_link_flags | (1 << forw_packet_aggr->num_packets);
-
+		aggregate(forw_packet_aggr,
+			  packet_buff, packet_len,
+			  direct_link);
 		spin_unlock(&forw_bat_list_lock);
-
 	}
 }
 
-void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff, int packet_len, struct batman_if *if_incoming)
+/* unpack the aggregated packets and process them one by one */
+void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
+			     int packet_len, struct batman_if *if_incoming)
 {
 	struct batman_packet *batman_packet;
-	int16_t buff_pos = 0;
+	int buff_pos = 0;
+	unsigned char *hna_buff;
 
 	batman_packet = (struct batman_packet *)packet_buff;
 
-	/* unpack the aggregated packets and process them one by one */
-	while (aggregated_packet(buff_pos, packet_len, batman_packet->num_hna)) {
+	while (aggregated_packet(buff_pos, packet_len,
+				 batman_packet->num_hna)) {
 
-		/* network to host order for our 16bit seqno. */
+		/* network to host order for our 16bit seqno, and the
+		   orig_interval. */
 		batman_packet->seqno = ntohs(batman_packet->seqno);
 
-		receive_bat_packet(ethhdr, batman_packet, packet_buff + buff_pos + sizeof(struct batman_packet), batman_packet->num_hna * ETH_ALEN, if_incoming);
+		hna_buff = packet_buff + buff_pos + BAT_PACKET_LEN;
+		receive_bat_packet(ethhdr, batman_packet,
+				   hna_buff, hna_len(batman_packet),
+				   if_incoming);
 
-		buff_pos += sizeof(struct batman_packet) + batman_packet->num_hna * ETH_ALEN;
-		batman_packet = (struct batman_packet *)(packet_buff + buff_pos);
+		buff_pos += BAT_PACKET_LEN + hna_len(batman_packet);
+		batman_packet = (struct batman_packet *)
+			(packet_buff + buff_pos);
 	}
 }
Index: batman-adv-kernelland/aggregation.h
===================================================================
--- batman-adv-kernelland/aggregation.h	(revision 1351)
+++ batman-adv-kernelland/aggregation.h	(working copy)
@@ -17,15 +17,19 @@
  *
  */
 
-
-
-
 #include "main.h"
 
-#define aggregated_packet(buff_pos, packet_len, num_hna) \
-		buff_pos + sizeof(struct batman_packet) + (num_hna * ETH_ALEN) <= packet_len && \
-		buff_pos + sizeof(struct batman_packet) + (num_hna * ETH_ALEN) <= MAX_AGGREGATION_BYTES
+/* is there another aggregated packet here? */
+static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna)
+{
+	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_hna * ETH_ALEN);
 
+	return (next_buff_pos <= packet_len) &&
+		(next_buff_pos <= MAX_AGGREGATION_BYTES);
+}
 
-void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len, struct batman_if *if_outgoing, char own_packet, unsigned long send_time);
-void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff, int packet_len, struct batman_if *if_incoming);
+void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
+			    struct batman_if *if_outgoing, char own_packet,
+			    unsigned long send_time);
+void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
+			     int packet_len, struct batman_if *if_incoming);
