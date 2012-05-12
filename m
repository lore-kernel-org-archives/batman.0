Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:28 +0200
Message-Id: <1336781383-15649-8-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 08/23] batman-adv: Prefix
	distributed-arp-table non-static functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 distributed-arp-table.c |   22 ++++++++--------
 distributed-arp-table.h |   67 +++++++++++++++++++++++++----------------------
 hard-interface.c        |    2 +-
 originator.c            |    2 +-
 send.c                  |    2 +-
 soft-interface.c        |   10 +++----
 6 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 31699a4..d9f1c9b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -362,8 +362,8 @@ out:
  * otherwise. In case of true the message has to be enqueued to permit the
  * fallback
  */
-bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb)
+bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb)
 {
 	uint16_t type = 0;
 	__be32 ip_dst, ip_src;
@@ -428,8 +428,8 @@ out:
  * into the local table. If found, an ARP reply is sent immediately, otherwise
  * the caller has to deliver the ARP request to the upper layer
  */
-bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size)
+bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb, int hdr_size)
 {
 	uint16_t type;
 	__be32 ip_src, ip_dst;
@@ -487,8 +487,8 @@ out:
  * soft interface. The related neighbour entry has to be updated and the DHT has
  * to be populated as well
  */
-bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb)
+bool batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb)
 {
 	uint16_t type;
 	__be32 ip_src, ip_dst;
@@ -524,8 +524,8 @@ out:
 /* This function has to be invoked on an ARP reply coming into the soft
  * interface from the mesh network. The local table has to be updated
  */
-bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb, int hdr_size)
+bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb, int hdr_size)
 {
 	uint16_t type;
 	__be32 ip_src, ip_dst;
@@ -559,8 +559,8 @@ out:
 	return ret;
 }
 
-bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet)
+bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+				      struct forw_packet *forw_packet)
 {
 	struct neighbour *n;
 
@@ -590,7 +590,7 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	return false;
 }
 
-void arp_change_timeout(struct net_device *soft_iface, const char *name)
+void batadv_arp_change_timeout(struct net_device *soft_iface, const char *name)
 {
 	struct in_device *in_dev = in_dev_get(soft_iface);
 	if (!in_dev) {
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index bf72275..23ffbfb 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -39,17 +39,17 @@
 #define ARP_IP_DST(skb, hdr_size) (*(__be32 *)(ARP_HW_SRC(skb, hdr_size) + \
 				   ETH_ALEN * 2 + 4))
 
-bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb);
-bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size);
-bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb);
-bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb, int hdr_size);
-bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet);
-void arp_change_timeout(struct net_device *soft_iface, const char *name);
+bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb);
+bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb, int hdr_size);
+bool batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb);
+bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb, int hdr_size);
+bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+				      struct forw_packet *forw_packet);
+void batadv_arp_change_timeout(struct net_device *soft_iface, const char *name);
 
 /* hash function to choose an entry in a hash table of given size.
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
@@ -73,14 +73,15 @@ static inline uint32_t hash_ipv4(const void *data, uint32_t size)
 	return hash % size;
 }
 
-static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+static inline void
+batadv_dat_init_orig_node_dht_addr(struct orig_node *orig_node)
 {
 	orig_node->dht_addr = (dat_addr_t)choose_orig(orig_node->orig,
 						      DAT_ADDR_MAX);
 }
 
-static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
-					 struct hard_iface *primary_if)
+static inline void batadv_dat_init_own_dht_addr(struct bat_priv *bat_priv,
+						struct hard_iface *primary_if)
 {
 	bat_priv->dht_addr = (dat_addr_t)
 				choose_orig(primary_if->net_dev->dev_addr,
@@ -89,49 +90,53 @@ static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
 
 #else
 
-static inline bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-						  struct sk_buff *skb)
+static inline bool
+batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+				      struct sk_buff *skb)
 {
 	return false;
 }
 
-static inline bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-						  struct sk_buff *skb,
-						  int hdr_size)
+static inline bool
+batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+				      struct sk_buff *skb, int hdr_size)
 {
 	return false;
 }
 
-static inline bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-						struct sk_buff *skb)
+static inline bool
+batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+				    struct sk_buff *skb)
 {
 	return false;
 }
 
-static inline bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-						struct sk_buff *skb,
-						int hdr_size)
+static inline bool
+batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size)
 {
 	return false;
 }
 
-static inline bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-					     struct forw_packet *forw_packet)
+static inline bool
+batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+				 struct forw_packet *forw_packet)
 {
 	return false;
 }
 
-static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+static inline void
+batadv_dat_init_orig_node_dht_addr(struct orig_node *orig_node)
 {
 }
 
-static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
-					 struct hard_iface *primary_if)
+static inline void batadv_dat_init_own_dht_addr(struct bat_priv *bat_priv,
+						struct hard_iface *primary_if)
 {
 }
 
-static inline void arp_change_timeout(struct net_device *soft_iface,
-				      const char *name)
+static inline void batadv_arp_change_timeout(struct net_device *soft_iface,
+					     const char *name)
 {
 }
 
diff --git a/hard-interface.c b/hard-interface.c
index a42b2d3..6cf9c13 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -113,7 +113,7 @@ static void primary_if_update_addr(struct bat_priv *bat_priv,
 	if (!primary_if)
 		goto out;
 
-	dat_init_own_dht_addr(bat_priv, primary_if);
+	batadv_dat_init_own_dht_addr(bat_priv, primary_if);
 
 	vis_packet = (struct vis_packet *)
 				bat_priv->my_vis_info->skb_packet->data;
diff --git a/originator.c b/originator.c
index c17dc0c..6f3e7fc 100644
--- a/originator.c
+++ b/originator.c
@@ -221,7 +221,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
-	dat_init_orig_node_dht_addr(orig_node);
+	batadv_dat_init_orig_node_dht_addr(orig_node);
 	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
diff --git a/send.c b/send.c
index 836b70d..43f6f39 100644
--- a/send.c
+++ b/send.c
@@ -203,7 +203,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
-	if (dat_drop_broadcast_packet(bat_priv, forw_packet))
+	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
 		goto out;
 
 	/* rebroadcast packet */
diff --git a/soft-interface.c b/soft-interface.c
index 92956c6..74b31e9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -206,7 +206,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (!primary_if)
 			goto dropped;
 
-		if (dat_snoop_outgoing_arp_request(bat_priv, skb))
+		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
 		if (my_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
@@ -242,7 +242,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 				goto dropped;
 		}
 
-		dat_snoop_outgoing_arp_reply(bat_priv, skb);
+		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
@@ -276,10 +276,10 @@ void interface_rx(struct net_device *soft_iface,
 	if (!pskb_may_pull(skb, hdr_size))
 		goto dropped;
 
-	if (dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto out;
 
-	if (dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
 		goto out;
 
 	skb_pull_rcsum(skb, hdr_size);
@@ -388,7 +388,7 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
-	arp_change_timeout(soft_iface, name);
+	batadv_arp_change_timeout(soft_iface, name);
 
 	bat_priv = netdev_priv(soft_iface);
 
-- 
1.7.10

