Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 18:33:54 +0200
Message-Id: <1336840447-6580-5-git-send-email-sven@narfation.org>
In-Reply-To: <1336840447-6580-1-git-send-email-sven@narfation.org>
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/18] batman-adv: Prefix
	distributed-arp-table local static functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 distributed-arp-table.c |  106 ++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3a0c7a7..07ef1fe 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -56,8 +56,8 @@ static uint32_t batadv_hash_ipv4(const void *data, uint32_t size)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 
-static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
-			uint16_t type, int hdr_size, char *msg)
+static void batadv_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
+			   uint16_t type, int hdr_size, char *msg)
 {
 	struct unicast_4addr_packet *unicast_4addr_packet;
 
@@ -118,18 +118,18 @@ static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
 
 #else
 
-static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
-			uint16_t type, int hdr_size, char *msg)
+static void batadv_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
+			   uint16_t type, int hdr_size, char *msg)
 {
 }
 
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
 
-static bool is_orig_node_eligible(struct dht_candidate *res, int select,
-				  dat_addr_t tmp_max, dat_addr_t max,
-				  dat_addr_t last_max,
-				  struct orig_node *candidate,
-				  struct orig_node *max_orig_node)
+static bool batadv_is_orig_node_eligible(struct dht_candidate *res, int select,
+					 dat_addr_t tmp_max, dat_addr_t max,
+					 dat_addr_t last_max,
+					 struct orig_node *candidate,
+					 struct orig_node *max_orig_node)
 {
 	bool ret = false;
 	int j;
@@ -164,9 +164,10 @@ out:
 /* selects the next candidate by populating cands[select] and modifies last_max
  * accordingly
  */
-static void choose_next_candidate(struct bat_priv *bat_priv,
-				  struct dht_candidate *cands, int select,
-				  dat_addr_t ip_key, dat_addr_t *last_max)
+static void batadv_choose_next_candidate(struct bat_priv *bat_priv,
+					 struct dht_candidate *cands,
+					 int select, dat_addr_t ip_key,
+					 dat_addr_t *last_max)
 {
 	dat_addr_t max = 0, tmp_max = 0;
 	struct orig_node *orig_node, *max_orig_node = NULL;
@@ -191,9 +192,10 @@ static void choose_next_candidate(struct bat_priv *bat_priv,
 			/* the dht space is a ring and addresses are unsigned */
 			tmp_max = DAT_ADDR_MAX - orig_node->dht_addr + ip_key;
 
-			if (!is_orig_node_eligible(cands, select, tmp_max, max,
-						   *last_max, orig_node,
-						   max_orig_node))
+			if (!batadv_is_orig_node_eligible(cands, select,
+							  tmp_max, max,
+							  *last_max, orig_node,
+							  max_orig_node))
 				continue;
 
 			if (!atomic_inc_not_zero(&orig_node->refcount))
@@ -224,8 +226,8 @@ static void choose_next_candidate(struct bat_priv *bat_priv,
  *
  * return an array of size DHT_CANDIDATES_NUM
  */
-static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
-						   __be32 ip_dst)
+static struct dht_candidate *
+batadv_dht_select_candidates(struct bat_priv *bat_priv, __be32 ip_dst)
 {
 	int select;
 	dat_addr_t last_max = DAT_ADDR_MAX, ip_key;
@@ -245,7 +247,8 @@ static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
 		   ip_key);
 
 	for (select = 0; select < DHT_CANDIDATES_NUM; select++)
-		choose_next_candidate(bat_priv, res, select, ip_key, &last_max);
+		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
+					     &last_max);
 
 	return res;
 }
@@ -257,15 +260,16 @@ static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
  * If the packet is successfully sent to at least one candidate, then this
  * function returns true
  */
-static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
-			  __be32 ip, int packet_subtype)
+static bool batadv_dht_send_data(struct bat_priv *bat_priv,
+				 struct sk_buff *skb, __be32 ip,
+				 int packet_subtype)
 {
 	int i;
 	bool ret = false;
 	int send_status;
 	struct neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
-	struct dht_candidate *cand = dht_select_candidates(bat_priv, ip);
+	struct dht_candidate *cand = batadv_dht_select_candidates(bat_priv, ip);
 
 	if (!cand)
 		goto out;
@@ -309,7 +313,8 @@ out:
  * the hw address hw. If the neighbour entry doesn't exists, then it will be
  * created
  */
-static void arp_neigh_update(struct bat_priv *bat_priv, __be32 ip, uint8_t *hw)
+static void batadv_arp_neigh_update(struct bat_priv *bat_priv, __be32 ip,
+				    uint8_t *hw)
 {
 	struct neighbour *n = NULL;
 	struct hard_iface *primary_if;
@@ -336,8 +341,8 @@ out:
 /* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
  * returns 0
  */
-static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
-			     int hdr_size)
+static uint16_t batadv_arp_get_type(struct bat_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size)
 {
 	struct arphdr *arphdr;
 	struct ethhdr *ethhdr;
@@ -404,14 +409,14 @@ bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 	struct hard_iface *primary_if = NULL;
 	struct sk_buff *skb_new;
 
-	type = arp_get_type(bat_priv, skb, 0);
+	type = batadv_arp_get_type(bat_priv, skb, 0);
 	/* If we get an ARP_REQUEST we have to send the unicast message to the
 	 * selected DHT candidates
 	 */
 	if (type != ARPOP_REQUEST)
 		goto out;
 
-	bat_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
+	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
 
 	ip_src = ARP_IP_SRC(skb, 0);
 	hw_src = ARP_HW_SRC(skb, 0);
@@ -421,7 +426,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 	if (!primary_if)
 		goto out;
 
-	arp_neigh_update(bat_priv, ip_src, hw_src);
+	batadv_arp_neigh_update(bat_priv, ip_src, hw_src);
 
 	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
 	/* check if it is a valid neigh entry */
@@ -444,7 +449,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 	} else {
 		/* Send the request on the DHT */
 		inc_counter(bat_priv, BAT_CNT_DAT_REQUEST_TX);
-		ret = dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_GET);
+		ret = batadv_dht_send_data(bat_priv, skb, ip_dst,
+					   BAT_P_DAT_DHT_GET);
 	}
 out:
 	if (n)
@@ -470,7 +476,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 	struct neighbour *n = NULL;
 	bool ret = false;
 
-	type = arp_get_type(bat_priv, skb, hdr_size);
+	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REQUEST)
 		goto out;
 
@@ -478,14 +484,14 @@ bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 	ip_src = ARP_IP_SRC(skb, hdr_size);
 	ip_dst = ARP_IP_DST(skb, hdr_size);
 
-	bat_dbg_arp(bat_priv, skb, type, hdr_size,
-		    "Parsing incoming ARP REQUEST");
+	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
+		       "Parsing incoming ARP REQUEST");
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
 
-	arp_neigh_update(bat_priv, ip_src, hw_src);
+	batadv_arp_neigh_update(bat_priv, ip_src, hw_src);
 
 	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
 	/* check if it is a valid neigh entry */
@@ -526,27 +532,27 @@ bool batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 
-	type = arp_get_type(bat_priv, skb, 0);
+	type = batadv_arp_get_type(bat_priv, skb, 0);
 	if (type != ARPOP_REPLY)
 		goto out;
 
-	bat_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
+	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
 
 	hw_src = ARP_HW_SRC(skb, 0);
 	ip_src = ARP_IP_SRC(skb, 0);
 	hw_dst = ARP_HW_DST(skb, 0);
 	ip_dst = ARP_IP_DST(skb, 0);
 
-	arp_neigh_update(bat_priv, ip_src, hw_src);
-	arp_neigh_update(bat_priv, ip_dst, hw_dst);
+	batadv_arp_neigh_update(bat_priv, ip_src, hw_src);
+	batadv_arp_neigh_update(bat_priv, ip_dst, hw_dst);
 
 	inc_counter(bat_priv, BAT_CNT_DAT_REPLY_TX);
 
 	/* Send the ARP reply to the candidates for both the IP addresses we
 	 * fetched from the ARP reply
 	 */
-	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
-	dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_PUT);
+	batadv_dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
+	batadv_dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_PUT);
 	ret = true;
 out:
 	return ret;
@@ -563,12 +569,12 @@ bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 
-	type = arp_get_type(bat_priv, skb, hdr_size);
+	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REPLY)
 		goto out;
 
-	bat_dbg_arp(bat_priv, skb, type, hdr_size,
-		    "Parsing incoming ARP REPLY");
+	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
+		       "Parsing incoming ARP REPLY");
 
 	hw_src = ARP_HW_SRC(skb, hdr_size);
 	ip_src = ARP_IP_SRC(skb, hdr_size);
@@ -578,8 +584,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses we fetched from
 	 * the ARP reply
 	 */
-	arp_neigh_update(bat_priv, ip_src, hw_src);
-	arp_neigh_update(bat_priv, ip_dst, hw_dst);
+	batadv_arp_neigh_update(bat_priv, ip_src, hw_src);
+	batadv_arp_neigh_update(bat_priv, ip_dst, hw_dst);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -594,29 +600,27 @@ bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 				      struct forw_packet *forw_packet)
 {
 	struct neighbour *n;
+	const size_t bcast_len = sizeof(struct bcast_packet);
 
 	/* If this packet is an ARP_REQUEST and we already have the information
 	 * that it is going to ask, we can drop the packet
 	 */
 	if (!forw_packet->num_packets &&
-	    (ARPOP_REQUEST == arp_get_type(bat_priv, forw_packet->skb,
-					   sizeof(struct bcast_packet)))) {
+	    (ARPOP_REQUEST == batadv_arp_get_type(bat_priv, forw_packet->skb,
+						  bcast_len))) {
 		n = neigh_lookup(&arp_tbl,
-				 &ARP_IP_DST(forw_packet->skb,
-					     sizeof(struct bcast_packet)),
+				 &ARP_IP_DST(forw_packet->skb, bcast_len),
 				 forw_packet->if_incoming->soft_iface);
 		/* check if we already know this neigh */
 		if (n && (n->nud_state & NUD_CONNECTED)) {
 			batadv_dbg(DBG_DAT, bat_priv,
 				   "ARP Request for %pI4: fallback prevented\n",
-				   &ARP_IP_DST(forw_packet->skb,
-					       sizeof(struct bcast_packet)));
+				   &ARP_IP_DST(forw_packet->skb, bcast_len));
 			return true;
 		}
 
 		batadv_dbg(DBG_DAT, bat_priv, "ARP Request for %pI4: fallback\n",
-			   &ARP_IP_DST(forw_packet->skb,
-				       sizeof(struct bcast_packet)));
+			   &ARP_IP_DST(forw_packet->skb, bcast_len));
 	}
 	return false;
 }
-- 
1.7.10

