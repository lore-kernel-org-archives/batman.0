Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue,  7 Aug 2018 21:05:16 +0800
Message-Id: <20180807130518.27018-6-mareklindner@neomailbox.ch>
In-Reply-To: <20180807130518.27018-1-mareklindner@neomailbox.ch>
References: <20180807130518.27018-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v4 5/7] batman-adv: tp_meter - add option to
 perform one-hop test
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
Cc: Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

A link test is a TP session ran over a specific one-hop link,
rather than towards an originator in the mesh.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 include/uapi/linux/batadv_packet.h |   2 +
 net/batman-adv/netlink.c           |   2 +-
 net/batman-adv/routing.c           |   6 +-
 net/batman-adv/tp_meter.c          | 232 +++++++++++++++++++----------
 net/batman-adv/tp_meter.h          |   5 +-
 net/batman-adv/types.h             |   3 +
 6 files changed, 167 insertions(+), 83 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 894d8d2f..4e6e075b 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -351,10 +351,12 @@ struct batadv_icmp_tp_packet {
  * enum batadv_icmp_tp_subtype - ICMP TP Meter packet subtypes
  * @BATADV_TP_MSG: Msg from sender to receiver
  * @BATADV_TP_ACK: acknowledgment from receiver to sender
+ * @BATADV_TP_MSG_LINK: Msg from sender to receiver used for link test (one-hop)
  */
 enum batadv_icmp_tp_subtype {
 	BATADV_TP_MSG	= 0,
 	BATADV_TP_ACK,
+	BATADV_TP_MSG_LINK,
 };
 
 #define BATADV_RR_LEN 16
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index b0e1b73c..064020cc 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -378,7 +378,7 @@ batadv_netlink_tp_meter_start(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	bat_priv = netdev_priv(soft_iface);
-	batadv_tp_start(bat_priv, dst, test_length, &cookie,
+	batadv_tp_start(bat_priv, dst, NULL, test_length, &cookie,
 			BATADV_TP_USERSPACE);
 
 	ret = batadv_netlink_tp_meter_put(msg, cookie);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cc3ed93a..dbf2d556 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -223,12 +223,14 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 /**
  * batadv_recv_my_icmp_packet() - receive an icmp packet locally
  * @bat_priv: the bat priv with all the soft interface information
+ * @recv_if: interface that the skb is received on
  * @skb: icmp packet to process
  *
  * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
  * otherwise.
  */
 static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
+				      struct batadv_hard_iface *recv_if,
 				      struct sk_buff *skb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
@@ -281,7 +283,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 		if (!pskb_may_pull(skb, sizeof(struct batadv_icmp_tp_packet)))
 			goto out;
 
-		batadv_tp_meter_recv(bat_priv, skb);
+		batadv_tp_meter_recv(bat_priv, recv_if, skb);
 		ret = NET_RX_SUCCESS;
 		/* skb was consumed */
 		skb = NULL;
@@ -418,7 +420,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, icmph->dst))
-		return batadv_recv_my_icmp_packet(bat_priv, skb);
+		return batadv_recv_my_icmp_packet(bat_priv, recv_if, skb);
 
 	/* TTL exceeded */
 	if (icmph->ttl < 2)
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 50a0e4fa..87aaeb1d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -381,6 +381,9 @@ static void batadv_tp_vars_release(struct kref *ref)
 	}
 	spin_unlock_bh(&tp_vars->unacked_lock);
 
+	if (tp_vars->hardif_neigh)
+		batadv_hardif_neigh_put(tp_vars->hardif_neigh);
+
 	kfree_rcu(tp_vars, rcu);
 }
 
@@ -579,9 +582,8 @@ static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
 
 /**
  * batadv_tp_send_msg() - send a single message
+ * @bat_priv: the bat priv with all the soft interface information
  * @tp_vars: the private TP meter data for this session
- * @src: source mac address
- * @orig_node: the originator of the destination
  * @seqno: sequence number of this packet
  * @len: length of the entire packet
  * @session: session identifier
@@ -594,26 +596,56 @@ static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
  * not reachable, BATADV_TP_REASON_MEMORY_ERROR if the packet couldn't be
  * allocated
  */
-static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
-			      struct batadv_orig_node *orig_node,
-			      u32 seqno, size_t len, const u8 *session,
-			      int uid, u32 timestamp)
+static int batadv_tp_send_msg(struct batadv_priv *bat_priv,
+			      struct batadv_tp_vars *tp_vars, u32 seqno,
+			      size_t len, const u8 *session, int uid,
+			      u32 timestamp)
 {
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_tp_packet *icmp;
 	struct sk_buff *skb;
-	int r;
-	u8 *data;
+	int r, ret = 0;
+	u8 *data, *src, *dst, subtype;
+	struct net_device *netdev;
 	size_t data_len;
 
-	skb = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
-	if (unlikely(!skb))
-		return BATADV_TP_REASON_MEMORY_ERROR;
+	/* link test */
+	if (tp_vars->hardif_neigh) {
+		dst = tp_vars->hardif_neigh->addr;
+		src = tp_vars->hardif_neigh->if_incoming->net_dev->dev_addr;
+		subtype = BATADV_TP_MSG_LINK;
+		netdev = tp_vars->hardif_neigh->if_incoming->net_dev;
+	} else {
+		orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
+		if (unlikely(!orig_node)) {
+			ret = BATADV_TP_REASON_DST_UNREACHABLE;
+			goto out;
+		}
+
+		primary_if = batadv_primary_if_get_selected(bat_priv);
+		if (unlikely(!primary_if)) {
+			ret = BATADV_TP_REASON_DST_UNREACHABLE;
+			goto out;
+		}
+
+		dst = orig_node->orig;
+		src = primary_if->net_dev->dev_addr;
+		subtype = BATADV_TP_MSG;
+		netdev = NULL;
+	}
+
+	skb = netdev_alloc_skb_ip_align(netdev, len + ETH_HLEN);
+	if (unlikely(!skb)) {
+		ret = BATADV_TP_REASON_MEMORY_ERROR;
+		goto out;
+	}
 
 	skb_reserve(skb, ETH_HLEN);
 	icmp = skb_put(skb, sizeof(*icmp));
 
 	/* fill the icmp header */
-	ether_addr_copy(icmp->dst, orig_node->orig);
+	ether_addr_copy(icmp->dst, dst);
 	ether_addr_copy(icmp->orig, src);
 	icmp->version = BATADV_COMPAT_VERSION;
 	icmp->packet_type = BATADV_ICMP;
@@ -621,7 +653,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 	icmp->msg_type = BATADV_TP;
 	icmp->uid = uid;
 
-	icmp->subtype = BATADV_TP_MSG;
+	icmp->subtype = subtype;
 	memcpy(icmp->session, session, sizeof(icmp->session));
 	icmp->seqno = htonl(seqno);
 	icmp->timestamp = htonl(timestamp);
@@ -630,11 +662,23 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 	data = skb_put(skb, data_len);
 	batadv_tp_fill_prerandom(tp_vars, data, data_len);
 
-	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (r == NET_XMIT_SUCCESS)
-		return 0;
+	if (tp_vars->hardif_neigh)
+		r = batadv_send_skb_packet(skb,
+					   tp_vars->hardif_neigh->if_incoming,
+					   dst);
+	else
+		r = batadv_send_skb_to_orig(skb, orig_node, NULL);
 
-	return BATADV_TP_REASON_CANT_SEND;
+	if (unlikely(r != NET_XMIT_SUCCESS))
+		ret = BATADV_TP_REASON_CANT_SEND;
+
+out:
+	if (likely(primary_if))
+		batadv_hardif_put(primary_if);
+	if (likely(orig_node))
+		batadv_orig_node_put(orig_node);
+
+	return ret;
 }
 
 /**
@@ -653,7 +697,6 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	struct batadv_tp_vars *tp_vars;
 	size_t packet_len, mss;
 	u32 rtt, recv_ack, cwnd;
-	unsigned char *dev_addr;
 
 	packet_len = BATADV_TP_PLEN;
 	mss = BATADV_TP_PLEN;
@@ -675,13 +718,11 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 			      (u32)atomic_read(&tp_vars->last_acked)))
 		goto out;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (unlikely(!primary_if))
-		goto out;
-
-	orig_node = batadv_orig_hash_find(bat_priv, icmp->orig);
-	if (unlikely(!orig_node))
-		goto out;
+	if (!tp_vars->hardif_neigh) {
+		primary_if = batadv_primary_if_get_selected(bat_priv);
+		if (unlikely(!primary_if))
+			goto out;
+	}
 
 	/* update RTO with the new sampled RTT, if any */
 	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
@@ -703,8 +744,11 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-		batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
-				   orig_node, recv_ack, packet_len,
+
+		/* if we have a hardif_neigh, it means that this is a LINK test,
+		 * therefore use the according function
+		 */
+		batadv_tp_send_msg(bat_priv, tp_vars, recv_ack, packet_len,
 				   icmp->session, icmp->uid,
 				   jiffies_to_msecs(jiffies));
 
@@ -741,9 +785,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 				 * immediately as specified by NewReno (see
 				 * Section 3.2 of RFC6582 for details)
 				 */
-				dev_addr = primary_if->net_dev->dev_addr;
-				batadv_tp_send_msg(tp_vars, dev_addr,
-						   orig_node, recv_ack,
+				batadv_tp_send_msg(bat_priv, tp_vars, recv_ack,
 						   packet_len, icmp->session,
 						   icmp->uid,
 						   jiffies_to_msecs(jiffies));
@@ -827,8 +869,6 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
  */
 static void batadv_tp_send(struct work_struct *work)
 {
-	struct batadv_hard_iface *primary_if = NULL;
-	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tp_vars *tp_vars;
 	size_t payload_len, packet_len;
 	struct batadv_priv *bat_priv;
@@ -843,20 +883,6 @@ static void batadv_tp_send(struct work_struct *work)
 		goto out;
 	}
 
-	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
-	if (unlikely(!orig_node)) {
-		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
-		goto out;
-	}
-
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (unlikely(!primary_if)) {
-		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
-		goto out;
-	}
-
 	/* assume that all the hard_interfaces have a correctly
 	 * configured MTU, so use the soft_iface MTU as MSS.
 	 * This might not be true and in that case the fragmentation
@@ -883,10 +909,9 @@ static void batadv_tp_send(struct work_struct *work)
 		 */
 		packet_len = payload_len + sizeof(struct batadv_unicast_packet);
 
-		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
-					 orig_node, tp_vars->last_sent,
-					 packet_len,
-					 tp_vars->session, tp_vars->icmp_uid,
+		err = batadv_tp_send_msg(bat_priv, tp_vars, tp_vars->last_sent,
+					 packet_len, tp_vars->session,
+					 tp_vars->icmp_uid,
 					 jiffies_to_msecs(jiffies));
 
 		/* something went wrong during the preparation/transmission */
@@ -908,11 +933,6 @@ static void batadv_tp_send(struct work_struct *work)
 	}
 
 out:
-	if (likely(primary_if))
-		batadv_hardif_put(primary_if);
-	if (likely(orig_node))
-		batadv_orig_node_put(orig_node);
-
 	batadv_tp_sender_end(bat_priv, tp_vars);
 	batadv_tp_sender_cleanup(bat_priv, tp_vars);
 
@@ -934,23 +954,27 @@ static void batadv_tp_start_work(struct batadv_tp_vars *tp_vars)
  * batadv_tp_start() - start a new tp meter session
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the receiver MAC address
+ * @neigh: neighbour towars which we have to run the test (one-hop test)
  * @test_length: test length in milliseconds
  * @cookie: session cookie
  * @caller: caller of tp meter session (user space or ELP)
  */
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
+		     struct batadv_hardif_neigh_node *neigh,
 		     u32 test_length, u32 *cookie,
 		     enum batadv_tp_meter_caller caller)
 {
 	struct batadv_tp_vars *tp_vars;
 	u8 session_id[2];
 	u8 icmp_uid;
-	u32 session_cookie;
+	u32 session_cookie = 0;
 
 	get_random_bytes(session_id, sizeof(session_id));
 	get_random_bytes(&icmp_uid, 1);
-	session_cookie = batadv_tp_session_cookie(session_id, icmp_uid);
-	*cookie = session_cookie;
+	if (cookie) {
+		session_cookie = batadv_tp_session_cookie(session_id, icmp_uid);
+		*cookie = session_cookie;
+	}
 
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM_QUEUE)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -971,6 +995,10 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* initialize tp_vars */
 	ether_addr_copy(tp_vars->other_end, dst);
+	if (neigh) {
+		kref_get(&neigh->refcount);
+		tp_vars->hardif_neigh = neigh;
+	}
 	kref_init(&tp_vars->refcount);
 	tp_vars->role = BATADV_TP_SENDER;
 	tp_vars->caller = caller;
@@ -1132,7 +1160,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 /**
  * batadv_tp_send_ack() - send an ACK packet
  * @bat_priv: the bat priv with all the soft interface information
- * @dst: the mac address of the destination originator
+ * @tp_vars: the private data of the current TP meter session
  * @seq: the sequence number to ACK
  * @timestamp: the timestamp to echo back in the ACK
  * @session: session identifier
@@ -1141,29 +1169,42 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
  * Return: 0 on success, a positive integer representing the reason of the
  * failure otherwise
  */
-static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
+static int batadv_tp_send_ack(struct batadv_priv *bat_priv,
+			      struct batadv_tp_vars *tp_vars,
 			      u32 seq, __be32 timestamp, const u8 *session,
 			      int socket_index)
 {
 	struct batadv_hard_iface *primary_if = NULL;
-	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_tp_packet *icmp;
+	struct net_device *netdev = NULL;
 	struct sk_buff *skb;
+	u8 *src, *dst;
 	int r, ret;
 
-	orig_node = batadv_orig_hash_find(bat_priv, dst);
-	if (unlikely(!orig_node)) {
-		ret = BATADV_TP_REASON_DST_UNREACHABLE;
-		goto out;
-	}
+	if (tp_vars->hardif_neigh) {
+		dst = tp_vars->hardif_neigh->addr;
+		src = tp_vars->hardif_neigh->if_incoming->net_dev->dev_addr;
+		netdev = tp_vars->hardif_neigh->if_incoming->net_dev;
+	} else {
+		orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
+		if (unlikely(!orig_node)) {
+			ret = BATADV_TP_REASON_DST_UNREACHABLE;
+			goto out;
+		}
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (unlikely(!primary_if)) {
-		ret = BATADV_TP_REASON_DST_UNREACHABLE;
-		goto out;
+		primary_if = batadv_primary_if_get_selected(bat_priv);
+		if (unlikely(!primary_if)) {
+			ret = BATADV_TP_REASON_DST_UNREACHABLE;
+			goto out;
+		}
+
+		dst = orig_node->orig;
+		src = primary_if->net_dev->dev_addr;
+		netdev = NULL;
 	}
 
-	skb = netdev_alloc_skb_ip_align(NULL, sizeof(*icmp) + ETH_HLEN);
+	skb = netdev_alloc_skb_ip_align(netdev, sizeof(*icmp) + ETH_HLEN);
 	if (unlikely(!skb)) {
 		ret = BATADV_TP_REASON_MEMORY_ERROR;
 		goto out;
@@ -1175,8 +1216,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 	icmp->version = BATADV_COMPAT_VERSION;
 	icmp->ttl = BATADV_TTL;
 	icmp->msg_type = BATADV_TP;
-	ether_addr_copy(icmp->dst, orig_node->orig);
-	ether_addr_copy(icmp->orig, primary_if->net_dev->dev_addr);
+	ether_addr_copy(icmp->dst, dst);
+	ether_addr_copy(icmp->orig, src);
 	icmp->uid = socket_index;
 
 	icmp->subtype = BATADV_TP_ACK;
@@ -1185,7 +1226,13 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 	icmp->timestamp = timestamp;
 
 	/* send the ack */
-	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (tp_vars->hardif_neigh)
+		r = batadv_send_skb_packet(skb,
+					   tp_vars->hardif_neigh->if_incoming,
+					   dst);
+	else
+		r = batadv_send_skb_to_orig(skb, orig_node, NULL);
+
 	if (unlikely(r < 0) || r == NET_XMIT_DROP) {
 		ret = BATADV_TP_REASON_DST_UNREACHABLE;
 		goto out;
@@ -1313,14 +1360,17 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 /**
  * batadv_tp_init_recv() - return matching or create new receiver tp_vars
  * @bat_priv: the bat priv with all the soft interface information
+ * @recv_if: interface that the skb is received on
  * @icmp: received icmp tp msg
  *
  * Return: corresponding tp_vars or NULL on errors
  */
 static struct batadv_tp_vars *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
+		    struct batadv_hard_iface *recv_if,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
+	struct batadv_hardif_neigh_node *neigh = NULL;
 	struct batadv_tp_vars *tp_vars;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
@@ -1335,15 +1385,30 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		goto out_unlock;
 	}
 
+	/* the sender is starting a LINK test, therefore we have retrieve its
+	 * corresponding hardif_neigh_node that we'll use later to send ACKs
+	 * back
+	 */
+	if (icmp->subtype == BATADV_TP_MSG_LINK) {
+		neigh = batadv_hardif_neigh_get(recv_if, icmp->orig);
+		if (!neigh) {
+			batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
+				   "Meter: %s() can't retrieve sender neigh object for %pM\n",
+				   __func__, icmp->orig);
+			goto out_unlock;
+		}
+	}
+
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
 	if (!tp_vars)
-		goto out_unlock;
+		goto err_neigh_put;
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
 	memcpy(tp_vars->session, icmp->session, sizeof(tp_vars->session));
 	tp_vars->last_recv = BATADV_TP_FIRST_SEQ;
 	tp_vars->bat_priv = bat_priv;
+	tp_vars->hardif_neigh = neigh;
 	kref_init(&tp_vars->refcount);
 
 	spin_lock_init(&tp_vars->unacked_lock);
@@ -1356,7 +1421,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
 	batadv_tp_reset_receiver_timer(tp_vars);
+	goto out_unlock;
 
+err_neigh_put:
+	batadv_hardif_neigh_put(neigh);
 out_unlock:
 	spin_unlock_bh(&bat_priv->tp_list_lock);
 
@@ -1366,11 +1434,13 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 /**
  * batadv_tp_recv_msg() - process a single data message
  * @bat_priv: the bat priv with all the soft interface information
+ * @recv_if: interface that the skb is received on
  * @skb: the buffer containing the received packet
  *
  * Process a received TP MSG packet
  */
 static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
+			       struct batadv_hard_iface *recv_if,
 			       const struct sk_buff *skb)
 {
 	const struct batadv_icmp_tp_packet *icmp;
@@ -1385,7 +1455,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	 * first packet is lost, the tp meter does not work anymore!
 	 */
 	if (seqno == BATADV_TP_FIRST_SEQ) {
-		tp_vars = batadv_tp_init_recv(bat_priv, icmp);
+		tp_vars = batadv_tp_init_recv(bat_priv, recv_if, icmp);
 		if (!tp_vars) {
 			batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 				   "Meter: seqno != BATADV_TP_FIRST_SEQ cannot initiate connection\n");
@@ -1441,7 +1511,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	 * is going to be sent is a duplicate (the sender will count them and
 	 * possibly enter Fast Retransmit as soon as it has reached 3)
 	 */
-	batadv_tp_send_ack(bat_priv, icmp->orig, tp_vars->last_recv,
+	batadv_tp_send_ack(bat_priv, tp_vars, tp_vars->last_recv,
 			   icmp->timestamp, icmp->session, icmp->uid);
 out:
 	if (likely(tp_vars))
@@ -1451,9 +1521,12 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 /**
  * batadv_tp_meter_recv() - main TP Meter receiving function
  * @bat_priv: the bat priv with all the soft interface information
+ * @recv_if: interface that the skb is received on
  * @skb: the buffer containing the received packet
  */
-void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
+void batadv_tp_meter_recv(struct batadv_priv *bat_priv,
+			  struct batadv_hard_iface *recv_if,
+			  struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
@@ -1461,7 +1534,8 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 
 	switch (icmp->subtype) {
 	case BATADV_TP_MSG:
-		batadv_tp_recv_msg(bat_priv, skb);
+	case BATADV_TP_MSG_LINK:
+		batadv_tp_recv_msg(bat_priv, recv_if, skb);
 		break;
 	case BATADV_TP_ACK:
 		batadv_tp_recv_ack(bat_priv, skb);
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index 3b11a3e9..3a1be483 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -28,10 +28,13 @@ struct sk_buff;
 int batadv_tp_meter_init(void);
 void batadv_tp_meter_destroy(void);
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
+		     struct batadv_hardif_neigh_node *neigh,
 		     u32 test_length, u32 *cookie,
 		     enum batadv_tp_meter_caller caller);
 void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value);
-void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb);
+void batadv_tp_meter_recv(struct batadv_priv *bat_priv,
+			  struct batadv_hard_iface *recv_if,
+			  struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_TP_METER_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 56034b54..f72db6cf 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1455,6 +1455,9 @@ struct batadv_tp_vars {
 
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
+
+	/** @hardif_neigh: in case of LINK test, represents the other-end */
+	struct batadv_hardif_neigh_node *hardif_neigh;
 };
 
 /**
-- 
2.18.0

