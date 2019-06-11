Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v5 2/2] batman-adv: mcast: apply optimizations for routable
 packets, too
Date: Tue, 11 Jun 2019 22:58:41 +0200
Message-Id: <20190611205841.5841-3-linus.luessing@c0d3.blue>
In-Reply-To: <20190611205841.5841-1-linus.luessing@c0d3.blue>
References: <20190611205841.5841-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Now that we not only track the presence of multicast listeners but also
multicast routers we can safely apply group-aware multicast-to-unicast
forwarding to packets with a destination address of scope greater than
link-local as well.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast.c | 259 ++++++++++++++++++++++++++++++++++---
 1 file changed, 241 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 28486176..40ceab95 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -974,6 +974,7 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
+ * @is_routable: stores whether the destination is routable
  *
  * Checks whether the given IPv4 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -983,7 +984,8 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
  */
 static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
-					     bool *is_unsnoopable)
+					     bool *is_unsnoopable,
+					     int *is_routable)
 {
 	struct iphdr *iphdr;
 
@@ -996,16 +998,13 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 
 	iphdr = ip_hdr(skb);
 
-	/* TODO: Implement Multicast Router Discovery (RFC4286),
-	 * then allow scope > link local, too
-	 */
-	if (!ipv4_is_local_multicast(iphdr->daddr))
-		return -EINVAL;
-
 	/* link-local multicast listeners behind a bridge are
 	 * not snoopable (see RFC4541, section 2.1.2.2)
 	 */
-	*is_unsnoopable = true;
+	if (ipv4_is_local_multicast(iphdr->daddr))
+		*is_unsnoopable = true;
+	else
+		*is_routable = ETH_P_IP;
 
 	return 0;
 }
@@ -1040,6 +1039,7 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
+ * @is_routable: stores whether the destination is routable
  *
  * Checks whether the given IPv6 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1048,7 +1048,8 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
  */
 static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
-					     bool *is_unsnoopable)
+					     bool *is_unsnoopable,
+					     int *is_routable)
 {
 	struct ipv6hdr *ip6hdr;
 
@@ -1061,10 +1062,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 
 	ip6hdr = ipv6_hdr(skb);
 
-	/* TODO: Implement Multicast Router Discovery (RFC4286),
-	 * then allow scope > link local, too
-	 */
-	if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) != IPV6_ADDR_SCOPE_LINKLOCAL)
+	if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) < IPV6_ADDR_SCOPE_LINKLOCAL)
 		return -EINVAL;
 
 	/* link-local-all-nodes multicast listeners behind a bridge are
@@ -1072,6 +1070,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 	 */
 	if (ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr))
 		*is_unsnoopable = true;
+	else if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) > IPV6_ADDR_SCOPE_LINKLOCAL)
+		*is_routable = ETH_P_IPV6;
 
 	return 0;
 }
@@ -1081,6 +1081,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
+ * @is_routable: stores whether the destination is routable
  *
  * Checks whether the given multicast ethernet frame has the potential to be
  * forwarded with a mode more optimal than classic flooding.
@@ -1089,7 +1090,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  */
 static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
-					bool *is_unsnoopable)
+					bool *is_unsnoopable,
+					int *is_routable)
 {
 	struct ethhdr *ethhdr = eth_hdr(skb);
 
@@ -1099,13 +1101,15 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_IP:
 		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
-							 is_unsnoopable);
+							 is_unsnoopable,
+							 is_routable);
 	case ETH_P_IPV6:
 		if (!IS_ENABLED(CONFIG_IPV6))
 			return -EINVAL;
 
 		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
-							 is_unsnoopable);
+							 is_unsnoopable,
+							 is_routable);
 	default:
 		return -EINVAL;
 	}
@@ -1135,6 +1139,29 @@ static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_mcast_forw_rtr_count() - count nodes with a multicast router
+ * @bat_priv: the bat priv with all the soft interface information
+ * @protocol: the ethernet protocol type to count multicast routers for
+ *
+ * Return: the number of nodes which want all routable IPv4 multicast traffic
+ * if the protocol is ETH_P_IP or the number of nodes which want all routable
+ * IPv6 traffic if the protocol is ETH_P_IPV6. Otherwise returns 0.
+ */
+
+static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
+				       int protocol)
+{
+	switch (protocol) {
+	case ETH_P_IP:
+		return atomic_read(&bat_priv->mcast.num_want_all_rtr4);
+	case ETH_P_IPV6:
+		return atomic_read(&bat_priv->mcast.num_want_all_rtr6);
+	default:
+		return 0;
+	}
+}
+
 /**
  * batadv_mcast_forw_tt_node_get() - get a multicast tt node
  * @bat_priv: the bat priv with all the soft interface information
@@ -1256,6 +1283,84 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
 	return orig_node;
 }
 
+/**
+ * batadv_mcast_forw_rtr4_node_get() - get a node with an ipv4 mcast router flag
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: an orig_node which has the BATADV_MCAST_WANT_NO_RTR4 flag unset and
+ * increases its refcount.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_rtr4_node_get(struct batadv_priv *bat_priv)
+{
+	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_orig_node,
+				 &bat_priv->mcast.want_all_rtr4_list,
+				 mcast_want_all_rtr4_node) {
+		if (!kref_get_unless_zero(&tmp_orig_node->refcount))
+			continue;
+
+		orig_node = tmp_orig_node;
+		break;
+	}
+	rcu_read_unlock();
+
+	return orig_node;
+}
+
+/**
+ * batadv_mcast_forw_rtr6_node_get() - get a node with an ipv6 mcast router flag
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: an orig_node which has the BATADV_MCAST_WANT_NO_RTR6 flag unset
+ * and increases its refcount.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_rtr6_node_get(struct batadv_priv *bat_priv)
+{
+	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_orig_node,
+				 &bat_priv->mcast.want_all_rtr6_list,
+				 mcast_want_all_rtr6_node) {
+		if (!kref_get_unless_zero(&tmp_orig_node->refcount))
+			continue;
+
+		orig_node = tmp_orig_node;
+		break;
+	}
+	rcu_read_unlock();
+
+	return orig_node;
+}
+
+/**
+ * batadv_mcast_forw_rtr_node_get() - get a node with an ipv4/ipv6 router flag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ethhdr: an ethernet header to determine the protocol family from
+ *
+ * Return: an orig_node which has no BATADV_MCAST_WANT_NO_RTR4 or
+ * BATADV_MCAST_WANT_NO_RTR6 flag, depending on the provided ethhdr, set and
+ * increases its refcount.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_rtr_node_get(struct batadv_priv *bat_priv,
+			       struct ethhdr *ethhdr)
+{
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		return batadv_mcast_forw_rtr4_node_get(bat_priv);
+	case ETH_P_IPV6:
+		return batadv_mcast_forw_rtr6_node_get(bat_priv);
+	default:
+		/* we shouldn't be here... */
+		return NULL;
+	}
+}
+
 /**
  * batadv_mcast_forw_mode() - check on how to forward a multicast packet
  * @bat_priv: the bat priv with all the soft interface information
@@ -1274,8 +1379,11 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	bool is_unsnoopable = false;
 	unsigned int mcast_fanout;
 	struct ethhdr *ethhdr;
+	int is_routable = 0;
+	int rtr_count = 0;
 
-	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);
+	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable,
+					   &is_routable);
 	if (ret == -ENOMEM)
 		return BATADV_FORW_NONE;
 	else if (ret < 0)
@@ -1288,8 +1396,9 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	ip_count = batadv_mcast_forw_want_all_ip_count(bat_priv, ethhdr);
 	unsnoop_count = !is_unsnoopable ? 0 :
 			atomic_read(&bat_priv->mcast.num_want_all_unsnoopables);
+	rtr_count = batadv_mcast_forw_rtr_count(bat_priv, is_routable);
 
-	total_count = tt_count + ip_count + unsnoop_count;
+	total_count = tt_count + ip_count + unsnoop_count + rtr_count;
 
 	switch (total_count) {
 	case 1:
@@ -1299,6 +1408,9 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			*orig = batadv_mcast_forw_ip_node_get(bat_priv, ethhdr);
 		else if (unsnoop_count)
 			*orig = batadv_mcast_forw_unsnoop_node_get(bat_priv);
+		else if (rtr_count)
+			*orig = batadv_mcast_forw_rtr_node_get(bat_priv,
+							       ethhdr);
 
 		if (*orig)
 			return BATADV_FORW_SINGLE;
@@ -1469,6 +1581,111 @@ batadv_mcast_forw_want_all(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_mcast_forw_want_all_rtr4() - forward to nodes with want-all-rtr4
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node with a
+ * BATADV_MCAST_WANT_NO_RTR4 flag unset. A transmission is performed via a
+ * batman-adv unicast packet for each such destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure, NET_XMIT_SUCCESS
+ * otherwise.
+ */
+static int
+batadv_mcast_forw_want_all_rtr4(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, unsigned short vid)
+{
+	struct batadv_orig_node *orig_node;
+	int ret = NET_XMIT_SUCCESS;
+	struct sk_buff *newskb;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node,
+				 &bat_priv->mcast.want_all_rtr4_list,
+				 mcast_want_all_rtr4_node) {
+		newskb = skb_copy(skb, GFP_ATOMIC);
+		if (!newskb) {
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		batadv_send_skb_unicast(bat_priv, newskb, BATADV_UNICAST, 0,
+					orig_node, vid);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_want_all_rtr6() - forward to nodes with want-all-rtr6
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: The multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node with a
+ * BATADV_MCAST_WANT_NO_RTR6 flag unset. A transmission is performed via a
+ * batman-adv unicast packet for each such destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure, NET_XMIT_SUCCESS
+ * otherwise.
+ */
+static int
+batadv_mcast_forw_want_all_rtr6(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, unsigned short vid)
+{
+	struct batadv_orig_node *orig_node;
+	int ret = NET_XMIT_SUCCESS;
+	struct sk_buff *newskb;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node,
+				 &bat_priv->mcast.want_all_rtr6_list,
+				 mcast_want_all_rtr6_node) {
+		newskb = skb_copy(skb, GFP_ATOMIC);
+		if (!newskb) {
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		batadv_send_skb_unicast(bat_priv, newskb, BATADV_UNICAST, 0,
+					orig_node, vid);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_want_rtr() - forward packet to nodes in a want-all-rtr list
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node with a
+ * BATADV_MCAST_WANT_NO_RTR4 or BATADV_MCAST_WANT_NO_RTR6 flag unset. A
+ * transmission is performed via a batman-adv unicast packet for each such
+ * destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure or if the protocol family
+ * is neither IPv4 nor IPv6. NET_XMIT_SUCCESS otherwise.
+ */
+static int
+batadv_mcast_forw_want_rtr(struct batadv_priv *bat_priv,
+			   struct sk_buff *skb, unsigned short vid)
+{
+	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	case ETH_P_IP:
+		return batadv_mcast_forw_want_all_rtr4(bat_priv, skb, vid);
+	case ETH_P_IPV6:
+		return batadv_mcast_forw_want_all_rtr6(bat_priv, skb, vid);
+	default:
+		/* we shouldn't be here... */
+		return NET_XMIT_DROP;
+	}
+}
+
 /**
  * batadv_mcast_forw_send() - send packet to any detected multicast recpient
  * @bat_priv: the bat priv with all the soft interface information
@@ -1502,6 +1719,12 @@ int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		return ret;
 	}
 
+	ret = batadv_mcast_forw_want_rtr(bat_priv, skb, vid);
+	if (ret != NET_XMIT_SUCCESS) {
+		kfree_skb(skb);
+		return ret;
+	}
+
 	consume_skb(skb);
 	return ret;
 }
-- 
2.20.1

