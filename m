Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 3/3] batman-adv: forward broadcast packets via unicast
 transmissions
Date: Tue, 14 May 2019 09:38:59 +0200
Message-Id: <20190514073859.2053-4-linus.luessing@c0d3.blue>
In-Reply-To: <20190514073859.2053-1-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
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

With the high bitrates of modern wireless devices these days multiple
unicast transmissions are usually less costly than a broadcast
transmission on a low bitrate.

Furthermore unicast transmissions come with the advantage of being
acknowledged and potentially retried automatically, hence with a better
reliability.

The compromise so far was to (re-)transmit a broadcast packet three
times in batman-adv and advise the user to set a higher multicast rate.
However the multicast still needs to be chosen somewhat conservatively
(typically something between 12MBit/s and 24MBit/s are chosen) to ensure
robustness. Which might be too low for some applications.

With this patch a broadcast packet is forwarded on a link via individual
unicast transmissions as long as the number of receivers is smaller or
equal to the configurable multicast fanout (default: 16).

Unicasts are only send to neighboring nodes which are direct
neighbors. So a neighbor node which we see on a link but which has a
better reachability via a multi-hop path will not receive a unicast
transmission.

Furthermore, the broadcast avoidance checks still apply (no echo to
previous sender, no echo to initial originator) to further reduce
unicast transmissions.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/hard-interface.c |   1 +
 net/batman-adv/routing.c        |  38 ++++++++
 net/batman-adv/send.c           | 156 ++++++++++++++++++++++++++++++++
 net/batman-adv/types.h          |   8 ++
 4 files changed, 203 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index b71d8efc..11864f77 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -937,6 +937,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	batadv_v_hardif_init(hard_iface);
 	atomic_set(&hard_iface->num_bcast_no_urcv, 0);
+	atomic_set(&hard_iface->num_direct_orig, 0);
 
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 03b4e609..99a138ae 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -42,6 +42,40 @@
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
+/**
+ * batadv_route_update_direct_neigh_count() - update the direct neighbor counter
+ * @oldrouter: the previously selected router
+ * @newrouter: the newly selected router
+ * @orig: the originator (MAC) the router is updated for
+ *
+ * Updates to direct neighbor originator counter of the hard interface the old
+ * and new router belongs to.
+ */
+static void
+batadv_route_update_direct_neigh_count(struct batadv_neigh_node *oldrouter,
+				       struct batadv_neigh_node *newrouter,
+				       u8 *orig)
+{
+	bool oldrouter_is_direct = false;
+	bool newrouter_is_direct = false;
+	u8 *neigh_orig;
+
+	if (oldrouter) {
+		neigh_orig = oldrouter->hardif_neigh->orig;
+		oldrouter_is_direct = batadv_compare_eth(neigh_orig, orig);
+	}
+
+	if (newrouter) {
+		neigh_orig = newrouter->hardif_neigh->orig;
+		newrouter_is_direct = batadv_compare_eth(neigh_orig, orig);
+	}
+
+	if (oldrouter_is_direct && !newrouter_is_direct)
+		atomic_dec(&oldrouter->if_incoming->num_direct_orig);
+	else if (!oldrouter_is_direct && newrouter_is_direct)
+		atomic_inc(&newrouter->if_incoming->num_direct_orig);
+}
+
 /**
  * _batadv_update_route() - set the router for this originator
  * @bat_priv: the bat priv with all the soft interface information
@@ -77,6 +111,10 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	if (neigh_node)
 		kref_get(&neigh_node->refcount);
 
+	if (recv_if == BATADV_IF_DEFAULT)
+		batadv_route_update_direct_neigh_count(curr_router, neigh_node,
+						       orig_node->orig);
+
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 	batadv_orig_ifinfo_put(orig_ifinfo);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 1341b9ac..c83f14b2 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -905,6 +905,146 @@ static bool batadv_send_no_broadcast(struct batadv_priv *bat_priv,
 	return true;
 }
 
+/**
+ * batadv_forw_bcast_may_ucast() - check if a broadcast packet can be unicasted
+ * @bat_priv: the bat priv with all the soft interface information
+ * @if_out: the outgoing interface to check for
+ *
+ * Return: True if the number of 1-hop, direct neighbor originators on the given
+ * interface is smaller than or equal to the configured multicast fanout limit
+ * and all neighbor nodes support the reception of batman-adv broadcast
+ * packets with a unicast ethernet frame destination. Otherwise returns false.
+ */
+static bool batadv_forw_bcast_may_ucast(struct batadv_priv *bat_priv,
+					struct batadv_hard_iface *if_out)
+{
+	unsigned long num_direct_orig;
+	unsigned long num_bcast_no_urcv;
+
+	num_direct_orig = atomic_read(&if_out->num_direct_orig);
+	num_bcast_no_urcv = atomic_read(&if_out->num_bcast_no_urcv);
+
+	return !num_bcast_no_urcv &&
+	       (num_direct_orig <= atomic_read(&bat_priv->multicast_fanout));
+}
+
+/**
+ * batadv_forw_bcasts_via_ucasts_check() - check if a neighbor needs a unicast
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to check
+ * @if_out: the outgoing interface to check for
+ * @if_neigh: the neighbor node to check for
+ * @own_packet: true if it is a self-generated broadcast packet
+ *
+ * Return: True if a packet needs to be transmitted to the given neighbor,
+ * false otherwise.
+ */
+static bool
+batadv_forw_bcasts_via_ucasts_check(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb,
+				    struct batadv_hard_iface *if_out,
+				    struct batadv_hardif_neigh_node *if_neigh,
+				    bool own_packet)
+{
+	u8 *bcast_orig = ((struct batadv_bcast_packet *)skb->data)->orig;
+	struct batadv_hardif_neigh_node *neigh_node = NULL;
+	struct batadv_neigh_node *router = NULL;
+	struct batadv_orig_node *orig_node;
+	bool ret = false;
+	u8 *router_addr;
+	u8 *neigh_addr;
+	u8 *orig_neigh;
+
+	if (!own_packet) {
+		neigh_addr = eth_hdr(skb)->h_source;
+		neigh_node = batadv_hardif_neigh_get(if_out,
+						     neigh_addr);
+	}
+
+	orig_neigh = neigh_node ? neigh_node->orig : NULL;
+
+	orig_node = batadv_orig_hash_find(bat_priv, if_neigh->orig);
+	if (orig_node) {
+		router = batadv_orig_router_get(orig_node, BATADV_IF_DEFAULT);
+		router_addr = router ? router->addr : NULL;
+	}
+
+	/* is the originator -> no rebroadcast */
+	if (batadv_compare_eth(if_neigh->orig, bcast_orig)) {
+		goto out;
+	/* is the one we received from -> no rebroadcast */
+	} else if (orig_neigh &&
+		   batadv_compare_eth(if_neigh->orig, orig_neigh)) {
+		goto out;
+	/* only 1-hop, direct neighbor originators */
+	} else if (router && !batadv_compare_eth(router_addr, if_neigh->addr)) {
+		goto out;
+	}
+
+	ret = true;
+out:
+	if (router)
+		batadv_neigh_node_put(router);
+	if (orig_node)
+		batadv_orig_node_put(orig_node);
+	if (neigh_node)
+		batadv_hardif_neigh_put(neigh_node);
+
+	return ret;
+}
+
+/**
+ * batadv_forw_bcast_packet_via_ucasts() - unicast a broadcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to send
+ * @own_packet: true if it is a self-generated broadcast packet
+ * @if_out: the outgoing interface to forward to
+ *
+ * Forwards a broadcast packet on the specified interface via unicast
+ * transmissions.
+ *
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the original skb might not be
+ * modifiable anymore.
+ *
+ * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
+ */
+static int batadv_forw_bcast_via_ucasts(struct batadv_priv *bat_priv,
+					struct sk_buff *skb,
+					bool own_packet,
+					struct batadv_hard_iface *if_out)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct sk_buff *newskb;
+	int ret = NETDEV_TX_OK;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(hardif_neigh, &if_out->neigh_list, list) {
+		if (!kref_get_unless_zero(&hardif_neigh->refcount))
+			continue;
+
+		if (!batadv_forw_bcasts_via_ucasts_check(bat_priv, skb, if_out,
+							 hardif_neigh,
+							 own_packet)) {
+			batadv_hardif_neigh_put(hardif_neigh);
+			continue;
+		}
+
+		newskb = skb_clone(skb, GFP_ATOMIC);
+		if (!newskb) {
+			batadv_hardif_neigh_put(hardif_neigh);
+			ret = NETDEV_TX_BUSY;
+			break;
+		}
+
+		batadv_send_skb_packet(newskb, if_out, hardif_neigh->addr);
+		batadv_hardif_neigh_put(hardif_neigh);
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /**
  * __batadv_forw_bcast_packet() - forward and queue a broadcast packet
  * @bat_priv: the bat priv with all the soft interface information
@@ -949,6 +1089,22 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 			continue;
 		}
 
+		/* try individual unicasts first */
+		if (!delay && batadv_forw_bcast_may_ucast(bat_priv,
+							  hard_iface)) {
+			ret = batadv_forw_bcast_via_ucasts(bat_priv, skb,
+							   own_packet,
+							   hard_iface);
+
+			if (ret == NETDEV_TX_BUSY) {
+				batadv_hardif_put(hard_iface);
+				break;
+			}
+
+			batadv_hardif_put(hard_iface);
+			continue;
+		} /* else: transmit via broadcast */
+
 		ret = batadv_forw_bcast_packet_if(bat_priv, skb, delay,
 						  own_packet, primary_if,
 						  hard_iface);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 877a2762..52a51861 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -200,6 +200,14 @@ struct batadv_hard_iface {
 	 */
 	atomic_t num_bcast_no_urcv;
 
+	/**
+	 * @num_direct_orig: number of neighboring originators on this
+	 * interface which have a direct, 1-hop path (which is equivalent
+	 * to the number of neighbor nodes on this interface which are a
+	 * selected router)
+	 */
+	atomic_t num_direct_orig;
+
 	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;
 
-- 
2.20.1

