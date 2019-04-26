Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 26 Apr 2019 19:12:31 +0200
Message-Id: <20190426171231.18156-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood" broadcast
 flood prevention option
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

With DAT DHCP snooping, the gateway feature and multicast optimizations
in place in some scenarios broadcast flooding might not be strictly
necessary anymore to be able to establish IPv4/IPv6 communication.
Therefore this patch adds an option to disable broadcast flooding.

Larger mesh networks typically filter a variety of multicast packets via
ebtables/netfilter to clamp on overhead. With this option such firewall
rules can be relaxed so that such multicast packets are only dropped
if they cannot be handled by multicast-to-unicast, for instance.

"noflood" comes in two flavours: If set to 1 then flood prevention is
enabled for all multicast/broadcast packets except ICMPv6 and IGMP
(cautious mode). Or, if set to 2 then flood prevention is enabled for
all multicast/broadcast packets (aggressive mode). If set to 0 then
flood prevention is disabled.

"noflood" is disabled by default as there are still some things to take
care of to avoid breaking things (especially for the "aggressive mode").

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---
The initial approach was a "noflood"-mark which worked similar to the
isolation mark. Which allowed more flexibility so that the user could
mark specific packets to be excluded from broadcast flooding via
ebtables/netfilter. However, in practice skb-marking is not that easy to
configure and if misconfigured will break a network horribly. Which was
also a downside noted and discussed at BattleMesh v11.

This version now is a less flexible but therefore also simpler to use
variant.

[0]: https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/noflood-mark
[1]: https://github.com/freifunk-gluon/gluon/pull/1357
---
 include/uapi/linux/batman_adv.h | 10 ++++
 net/batman-adv/netlink.c        | 10 ++++
 net/batman-adv/soft-interface.c | 85 +++++++++++++++++++++++++++++++++
 net/batman-adv/types.h          |  6 +++
 4 files changed, 111 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 67f46367..d68f8868 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -480,6 +480,16 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_NOFLOOD: defines if and how strictly flooding prevention
+	 * is configured. If the value is 0 then flood prevention is disabled.
+	 * If the value is 1 then flood prevention is enabled for all multicast
+	 * /broadcast packets excluding ICMPv6 and IGMP (cautious mode). If set
+	 * to 2 then flood prevention is enabled for all multicast/broadcast
+	 * packets (aggressive mode).
+	 */
+	BATADV_ATTR_NOFLOOD,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e7907308..940a9c37 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -358,6 +358,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			atomic_read(&bat_priv->orig_interval)))
 		goto nla_put_failure;
 
+	if (nla_put_u8(msg, BATADV_ATTR_NOFLOOD,
+		       atomic_read(&bat_priv->noflood)))
+		goto nla_put_failure;
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -614,6 +618,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->orig_interval, orig_interval);
 	}
 
+	if (info->attrs[BATADV_ATTR_NOFLOOD]) {
+		attr = info->attrs[BATADV_ATTR_NOFLOOD];
+
+		atomic_set(&bat_priv->noflood, nla_get_u8(attr));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a7677e1d..680e3b03 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -18,6 +18,11 @@
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/igmp.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -37,6 +42,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <net/addrconf.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -176,6 +182,81 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
+/**
+ * batadv_softif_noflood_is_igmp() - check if a packet is IGMP
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast/broadcast packet to check
+ *
+ * Return: True if the given skb is an IGMP packet, false otherwise.
+ */
+static bool batadv_softif_noflood_is_igmp(struct sk_buff *skb)
+{
+	int ret = ip_mc_check_igmp(skb);
+
+	if (ret == -ENOMEM || ret == -EINVAL)
+		return false;
+
+	/* ret == -ENOMSG => valid IPv6 header */
+	if (ret == -ENOMSG && ip_hdr(skb)->protocol != IPPROTO_IGMP)
+		return false;
+
+	/* it's IGMP */
+	return true;
+}
+
+/**
+ * batadv_softif_noflood_is_icmpv6() - check if a packet is ICMPv6
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast/broadcast packet to check
+ *
+ * Return: True if the given skb is an ICMPv6 packet, false otherwise.
+ */
+static bool batadv_softif_noflood_is_icmpv6(struct sk_buff *skb)
+{
+	int ret = ipv6_mc_check_mld(skb);
+
+	if (ret == -ENOMEM || ret == -EINVAL)
+		return false;
+
+	/* ret == -ENOMSG => valid IPv6 header */
+	if (ret == -ENOMSG && ipv6_hdr(skb)->nexthdr != IPPROTO_ICMPV6)
+		return false;
+
+	/* it's ICMPv6 */
+	return true;
+}
+
+/**
+ * batadv_softif_check_noflood() - check if flood-prevention is enabled
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast/broadcast packet to check
+ *
+ * Return: True if flood prevention is enabled for this packet type, false
+ * otherwise.
+ */
+static bool
+batadv_softif_check_noflood(struct batadv_priv *bat_priv, struct sk_buff *skb)
+{
+	int ret = atomic_read(&bat_priv->noflood);
+
+	/* disabled */
+	if (!ret)
+		return false;
+	/* aggressive mode */
+	else if (ret == 2)
+		return true;
+
+	/* exclude ICMPv6 and IGMP from "noflood" */
+	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	case ETH_P_IP:
+		return !batadv_softif_noflood_is_igmp(skb);
+	case ETH_P_IPV6:
+		return !batadv_softif_noflood_is_icmpv6(skb);
+	default:
+		return true;
+	}
+}
+
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *soft_iface)
 {
@@ -326,6 +407,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
+		if (batadv_softif_check_noflood(bat_priv, skb))
+			goto dropped;
+
 		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
@@ -823,6 +907,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->log_level, 0);
 #endif
 	atomic_set(&bat_priv->fragmentation, 1);
+	atomic_set(&bat_priv->noflood, 0);
 	atomic_set(&bat_priv->packet_size_max, ETH_DATA_LEN);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 357ca119..f3f96f02 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1575,6 +1575,12 @@ struct batadv_priv {
 	atomic_t log_level;
 #endif
 
+	/**
+	 * @noflood: option indicating whether to drop packets that would
+	 *  be flooded through the mesh otherwise
+	 */
+	atomic_t noflood;
+
 	/**
 	 * @isolation_mark: the skb->mark value used to match packets for AP
 	 *  isolation
-- 
2.20.1

