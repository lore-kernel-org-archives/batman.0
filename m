Return-Path: <mihail.costea2005@gmail.com>
From: mihail.costea2005@gmail.com
Date: Mon,  8 Jul 2013 03:12:41 +0300
Message-Id: <1373242365-763-2-git-send-email-mihail.costea2005@gmail.com>
In-Reply-To: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 2/6] batman-adv: Renames
	batadv_dat_snoop_*_arp_* functions to batadv_dat_snoop_*_pkt_*
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Mihail Costea <mihail.costea90@gmail.com>

Renames snooping functions in order to suggest that they should work on
more protocols than ARP.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |   16 ++++++++--------
 distributed-arp-table.h |   16 ++++++++--------
 routing.c               |    8 ++++----
 soft-interface.c        |    6 +++---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 90565d0..b2a4fe5 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -976,7 +976,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 }
 
 /**
- * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try to
+ * batadv_dat_snoop_outgoing_pkt_request - snoop the ARP request and try to
  * answer using DAT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
@@ -985,7 +985,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
  * otherwise. In case of a positive return value the message has to be enqueued
  * to permit the fallback.
  */
-bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
+bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
 	uint16_t type = 0;
@@ -1063,7 +1063,7 @@ out:
 }
 
 /**
- * batadv_dat_snoop_incoming_arp_request - snoop the ARP request and try to
+ * batadv_dat_snoop_incoming_pkt_request - snoop the ARP request and try to
  * answer using the local DAT storage
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
@@ -1071,7 +1071,7 @@ out:
  *
  * Returns true if the request has been answered, false otherwise.
  */
-bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
+bool batadv_dat_snoop_incoming_pkt_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
 	uint16_t type;
@@ -1137,11 +1137,11 @@ out:
 }
 
 /**
- * batadv_dat_snoop_outgoing_arp_reply - snoop the ARP reply and fill the DHT
+ * batadv_dat_snoop_outgoing_pkt_reply - snoop the ARP reply and fill the DHT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  */
-void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
+void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
 	uint16_t type;
@@ -1178,13 +1178,13 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 			     BATADV_P_DAT_DHT_PUT);
 }
 /**
- * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
+ * batadv_dat_snoop_incoming_pkt_reply - snoop the ARP reply and fill the local
  * DAT storage only
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  */
-bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
+bool batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
 	uint16_t type;
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 557bab9..21d7b24 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -31,13 +31,13 @@
 #define BATADV_DAT_DATA_MAX_LEN 16
 
 void batadv_dat_status_update(struct net_device *net_dev);
-bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
+bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb);
-bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
+bool batadv_dat_snoop_incoming_pkt_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size);
-void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
+void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
-bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
+bool batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size);
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet);
@@ -105,28 +105,28 @@ static inline void batadv_dat_status_update(struct net_device *net_dev)
 }
 
 static inline bool
-batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
+batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb)
 {
 	return false;
 }
 
 static inline bool
-batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
+batadv_dat_snoop_incoming_pkt_request(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb, int hdr_size)
 {
 	return false;
 }
 
 static inline bool
-batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
+batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
 	return false;
 }
 
 static inline bool
-batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
+batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int hdr_size)
 {
 	return false;
diff --git a/routing.c b/routing.c
index e63b05d..d4fae86 100644
--- a/routing.c
+++ b/routing.c
@@ -937,10 +937,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
 		}
 
-		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
+		if (batadv_dat_snoop_incoming_pkt_request(bat_priv, skb,
 							  hdr_size))
 			goto rx_success;
-		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
+		if (batadv_dat_snoop_incoming_pkt_reply(bat_priv, skb,
 							hdr_size))
 			goto rx_success;
 
@@ -1142,9 +1142,9 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
 		goto out;
 
-	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_pkt_request(bat_priv, skb, hdr_size))
 		goto rx_success;
-	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_pkt_reply(bat_priv, skb, hdr_size))
 		goto rx_success;
 
 	/* broadcast for me */
diff --git a/soft-interface.c b/soft-interface.c
index d897194..d294e36 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -245,7 +245,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		 * packet, instead we first wait for DAT to try to retrieve the
 		 * correct ARP entry
 		 */
-		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
+		if (batadv_dat_snoop_outgoing_pkt_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
 		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
@@ -284,10 +284,10 @@ static int batadv_interface_tx(struct sk_buff *skb,
 				goto dropped;
 		}
 
-		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
+		if (batadv_dat_snoop_outgoing_pkt_request(bat_priv, skb))
 			goto dropped;
 
-		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
+		batadv_dat_snoop_outgoing_pkt_reply(bat_priv, skb);
 
 		ret = batadv_send_skb_unicast(bat_priv, skb, vid);
 		if (ret != 0)
-- 
1.7.10.4

