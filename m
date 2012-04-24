Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 24 Apr 2012 10:47:08 +0200
Message-Id: <1335257230-14871-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1335257230-14871-1-git-send-email-ordex@autistici.org>
References: <1335257230-14871-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix comment style in DAT code
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c |   60 +++++++++++++++++++++++++++++++----------------
 distributed-arp-table.h |    5 ++--
 main.c                  |    9 ++++---
 main.h                  |    3 ++-
 unicast.c               |    6 +++--
 5 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b43bece..db1694d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -51,7 +51,8 @@ static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
 		return;
 
 	/* if the AP packet is encapsulated in a batman packet, let's print some
-	 * debug messages */
+	 * debug messages
+	 */
 	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
 
 	switch (unicast_4addr_packet->u.header.packet_type) {
@@ -118,11 +119,13 @@ static bool is_orig_node_eligible(struct dht_candidate *res, int select,
 	if (tmp_max > last_max)
 		goto out;
 	/* check if during this iteration we have already found an originator
-	 * with a closer dht address */
+	 * with a closer dht address
+	 */
 	if (tmp_max < max)
 		goto out;
 	/* this is an hash collision with the temporary selected node. Choose
-	 * the one with the lowest address */
+	 * the one with the lowest address
+	 */
 	if ((tmp_max == max) &&
 	    (compare_eth(candidate->orig, max_orig_node->orig) > 0))
 		goto out;
@@ -133,7 +136,8 @@ out:
 }
 
 /* selects the next candidate by populating cands[select] and modifies last_max
- * accordingly */
+ * accordingly
+ */
 static void choose_next_candidate(struct bat_priv *bat_priv,
 				  struct dht_candidate *cands, int select,
 				  dat_addr_t ip_key, dat_addr_t *last_max)
@@ -146,11 +150,13 @@ static void choose_next_candidate(struct bat_priv *bat_priv,
 	int i;
 
 	/* if no node is eligible as candidate, we will leave the candidate as
-	 * NOT_FOUND */
+	 * NOT_FOUND
+	 */
 	cands[select].type = DHT_CANDIDATE_NOT_FOUND;
 
 	/* iterate over the originator list and find the node with closest
-	 * dht_address which has not been selected yet */
+	 * dht_address which has not been selected yet
+	 */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
@@ -190,7 +196,8 @@ static void choose_next_candidate(struct bat_priv *bat_priv,
  * closest values (from the LEFT, with wrap around if needed) then the hash
  * value of the key. ip_dst is the key.
  *
- * return an array of size DHT_CANDIDATES_NUM */
+ * return an array of size DHT_CANDIDATES_NUM
+ */
 static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
 						   uint32_t ip_dst)
 {
@@ -222,7 +229,8 @@ static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
  * and is sent as unicast packet to each of the selected candidate.
  *
  * If the packet is successfully sent to at least one candidate, then this
- * function returns true */
+ * function returns true
+ */
 static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
 			  uint32_t ip, int packet_subtype)
 {
@@ -269,7 +277,8 @@ out:
 
 /* Update the neighbour entry corresponding to the IP passed as parameter with
  * the hw address hw. If the neighbour entry doesn't exists, then it will be
- * created */
+ * created
+ */
 static void arp_neigh_update(struct bat_priv *bat_priv, uint32_t ip,
 			     uint8_t *hw)
 {
@@ -293,7 +302,8 @@ out:
 }
 
 /* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
- * returns 0 */
+ * returns 0
+ */
 static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
 			     int hdr_size)
 {
@@ -347,7 +357,8 @@ out:
 
 /* return true if the message has been sent to the dht candidates, false
  * otherwise. In case of true the message has to be enqueued to permit the
- * fallback */
+ * fallback
+ */
 bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 				    struct sk_buff *skb)
 {
@@ -361,7 +372,8 @@ bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 
 	type = arp_get_type(bat_priv, skb, 0);
 	/* If we get an ARP_REQUEST we have to send the unicast message to the
-	 * selected DHT candidates */
+	 * selected DHT candidates
+	 */
 	if (type != ARPOP_REQUEST)
 		goto out;
 
@@ -409,7 +421,8 @@ out:
 /* This function is meant to be invoked for an ARP request which is coming into
  * the bat0 interfaces from the mesh network. It will check for the needed data
  * into the local table. If found, an ARP reply is sent immediately, otherwise
- * the caller has to deliver the ARP request to the upper layer */
+ * the caller has to deliver the ARP request to the upper layer
+ */
 bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 				    struct sk_buff *skb, int hdr_size)
 {
@@ -465,7 +478,8 @@ out:
 
 /* This function is meant to be invoked on an ARP reply packet going into the
  * soft interface. The related neighbour entry has to be updated and the DHT has
- * to be populated as well */
+ * to be populated as well
+ */
 bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 				  struct sk_buff *skb)
 {
@@ -489,7 +503,8 @@ bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 	arp_neigh_update(bat_priv, ip_dst, hw_dst);
 
 	/* Send the ARP reply to the candidates for both the IP addresses we
-	 * fetched from the ARP reply */
+	 * fetched from the ARP reply
+	 */
 	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
 	dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_PUT);
 	ret = true;
@@ -498,7 +513,8 @@ out:
 }
 
 /* This function has to be invoked on an ARP reply coming into the soft
- * interface from the mesh network. The local table has to be updated */
+ * interface from the mesh network. The local table has to be updated
+ */
 bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 				  struct sk_buff *skb, int hdr_size)
 {
@@ -520,12 +536,14 @@ bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	ip_dst = ARP_IP_DST(skb, hdr_size);
 
 	/* Update our internal cache with both the IP addresses we fetched from
-	 * the ARP reply */
+	 * the ARP reply
+	 */
 	arp_neigh_update(bat_priv, ip_src, hw_src);
 	arp_neigh_update(bat_priv, ip_dst, hw_dst);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
-	 * packet to the interface */
+	 * packet to the interface
+	 */
 	ret = !is_my_client(bat_priv, hw_dst);
 out:
 	/* if ret == false packet has to be delivered to the interface */
@@ -538,7 +556,8 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	struct neighbour *n;
 
 	/* If this packet is an ARP_REQUEST and we already have the information
-	 * that it is going to ask, we can drop the packet */
+	 * that it is going to ask, we can drop the packet
+	 */
 	if (!forw_packet->num_packets &&
 	    (ARPOP_REQUEST == arp_get_type(bat_priv, forw_packet->skb,
 					   sizeof(struct bcast_packet)))) {
@@ -572,7 +591,8 @@ void arp_change_timeout(struct net_device *soft_iface, const char *name)
 	}
 
 	/* Introduce a delay in the ARP state-machine transactions. Entries
-	 * will be kept in the ARP table for the default time multiplied by 4 */
+	 * will be kept in the ARP table for the default time multiplied by 4
+	 */
 	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
 	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
 	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index fcf6c15..5e23577 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -51,8 +51,9 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 			       struct forw_packet *forw_packet);
 void arp_change_timeout(struct net_device *soft_iface, const char *name);
 
-/* hash function to choose an entry in a hash table of given size */
-/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
+/* hash function to choose an entry in a hash table of given size.
+ * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
+ */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
 {
 	const unsigned char *key = data;
diff --git a/main.c b/main.c
index 0757c2d..9137aa0 100644
--- a/main.c
+++ b/main.c
@@ -191,7 +191,8 @@ static int recv_unhandled_packet(struct sk_buff *skb,
 }
 
 /* incoming packets with the batman ethertype received on any active hard
- * interface */
+ * interface
+ */
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		    struct packet_type *ptype, struct net_device *orig_dev)
 {
@@ -238,7 +239,8 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	/* all receive handlers return whether they received or reused
-	 * the supplied skb. if not, we have to free the skb. */
+	 * the supplied skb. if not, we have to free the skb.
+	 */
 	idx = batman_ogm_packet->header.packet_type;
 	ret = (*recv_packet_handler[idx])(skb, hard_iface);
 
@@ -247,7 +249,8 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	/* return NET_RX_SUCCESS in any case as we
 	 * most probably dropped the packet for
-	 * routing-logical reasons. */
+	 * routing-logical reasons.
+	 */
 	return NET_RX_SUCCESS;
 
 err_free:
diff --git a/main.h b/main.h
index c8bfe28..97d0258 100644
--- a/main.h
+++ b/main.h
@@ -72,7 +72,8 @@
 /* numbers of originator to contact for any PUT/GET DHT operation */
 #define DHT_CANDIDATES_NUM 3
 /* Factor which default ARP timeout values of the soft_iface table are
- * multiplied by */
+ * multiplied by
+ */
 #define ARP_TIMEOUT_FACTOR 4
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/unicast.c b/unicast.c
index 63ab35b..62ea9f1 100644
--- a/unicast.c
+++ b/unicast.c
@@ -328,7 +328,8 @@ bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
 
 	/* pull the header space and fill the unicast_packet substructure.
 	 * We can do that because the first member of the unicast_4addr_packet
-	 * is of type struct unicast_packet */
+	 * is of type struct unicast_packet
+	 */
 	if (!pull_and_fill_unicast(skb, sizeof(*unicast_4addr_packet),
 				   orig_node))
 		goto out;
@@ -387,7 +388,8 @@ find_router:
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
-		 * should never be invoked with any other packet type */
+		 * should never be invoked with any other packet type
+		 */
 		goto out;
 	}
 
-- 
1.7.9.4

