Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 29 Jul 2013 16:50:33 +0200
Message-Id: <1375109433-10464-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: set skb priority according to
	content
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The skb priority field may help the wireless driver to choose the right
queue (e.g. WMM queues). This should be set in batman-adv, as this
information is only available here.

This patch adds support for IPv4/IPv6 DS fields and VLAN PCP. Note that
only VLAN PCP is used if a VLAN header is present. Also initially set
TC_PRIO_CONTROL only for self-generated packets, and keep the priority
set by higher layers.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c     |    1 +
 fragmentation.c  |    2 ++
 icmp_socket.c    |    1 +
 main.c           |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 main.h           |    1 +
 routing.c        |   20 ++++++++++++++++++-
 send.c           |    1 -
 soft-interface.c |    2 ++
 8 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 5ff1a6b..43bd0e0 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -478,6 +478,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 		kfree(forw_packet_aggr);
 		goto out;
 	}
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
 	skb_buff = skb_put(forw_packet_aggr->skb, packet_len);
diff --git a/fragmentation.c b/fragmentation.c
index ab85e75..271d321 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -393,6 +393,8 @@ static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 	if (!skb_fragment)
 		goto err;
 
+	skb->priority = TC_PRIO_CONTROL;
+
 	/* Eat the last mtu-bytes of the skb */
 	skb_reserve(skb_fragment, header_size + ETH_HLEN);
 	skb_split(skb, skb_fragment, skb->len - fragment_size);
diff --git a/icmp_socket.c b/icmp_socket.c
index 512efcc..82ac647 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -183,6 +183,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		goto out;
 	}
 
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb_put(skb, packet_len);
 
diff --git a/main.c b/main.c
index 58cd339..95e5f04 100644
--- a/main.c
+++ b/main.c
@@ -20,6 +20,9 @@
 #include <linux/crc32c.h>
 #include <linux/highmem.h>
 #include <linux/if_vlan.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/dsfield.h>
 #include "main.h"
 #include "sysfs.h"
 #include "debugfs.h"
@@ -277,6 +280,60 @@ int batadv_max_header_len(void)
 	return header_len;
 }
 
+/**
+ * batadv_skb_set_priority - sets skb priority according to packet content
+ * @skb: the packet to be sent
+ * @offset: offset to the packet content
+ *
+ * This function sets a value between 256 and 263 (802.1d priority), which
+ * can be interpreted by the cfg80211 or other drivers.
+ */
+void batadv_skb_set_priority(struct sk_buff *skb, int offset)
+{
+	struct iphdr ip_hdr_tmp, *ip_hdr;
+	struct ipv6hdr ip6_hdr_tmp, *ip6_hdr;
+	struct ethhdr ethhdr_tmp, *ethhdr;
+	struct vlan_ethhdr *vhdr, vhdr_tmp;
+	u32 prio;
+
+	/* already set, do nothing */
+	if (skb->priority >= 256 && skb->priority <= 263)
+		return;
+
+	ethhdr = skb_header_pointer(skb, offset, sizeof(*ethhdr), &ethhdr_tmp);
+	if (!ethhdr)
+		return;
+
+	switch (ethhdr->h_proto) {
+	case htons(ETH_P_8021Q):
+		vhdr = skb_header_pointer(skb, offset + sizeof(*vhdr),
+					  sizeof(*vhdr), &vhdr_tmp);
+		if (!vhdr)
+			return;
+		prio = htons(vhdr->h_vlan_TCI) & VLAN_PRIO_MASK;
+		prio = prio >> VLAN_PRIO_SHIFT;
+		break;
+	case htons(ETH_P_IP):
+		ip_hdr = skb_header_pointer(skb, offset + sizeof(*ethhdr),
+					    sizeof(*ip_hdr), &ip_hdr_tmp);
+		if (!ip_hdr)
+			return;
+		prio = (ipv4_get_dsfield(ip_hdr) & 0xfc) >> 5;
+		break;
+	case htons(ETH_P_IPV6):
+		ip6_hdr = skb_header_pointer(skb, offset + sizeof(*ethhdr),
+					     sizeof(*ip6_hdr), &ip6_hdr_tmp);
+		if (!ip6_hdr)
+			return;
+		prio = (ipv6_get_dsfield(ip6_hdr) & 0xfc) >> 5;
+		break;
+	default:
+		return;
+	}
+
+	skb->priority = prio + 256;
+}
+
 static int batadv_recv_unhandled_packet(struct sk_buff *skb,
 					struct batadv_hard_iface *recv_if)
 {
@@ -1057,6 +1114,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 	if (!skb)
 		goto out;
 
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
 	tvlv_buff = skb_put(skb, sizeof(*unicast_tvlv_packet) + tvlv_len);
 	unicast_tvlv_packet = (struct batadv_unicast_tvlv_packet *)tvlv_buff;
diff --git a/main.h b/main.h
index 7b68db9..e860f1e 100644
--- a/main.h
+++ b/main.h
@@ -187,6 +187,7 @@ int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq);
 int batadv_max_header_len(void);
+void batadv_skb_set_priority(struct sk_buff *skb, int offset);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev);
diff --git a/routing.c b/routing.c
index e63b05d..149ef57 100644
--- a/routing.c
+++ b/routing.c
@@ -659,7 +659,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = eth_hdr(skb);
-	int res, ret = NET_RX_DROP;
+	int res, hdr_len, ret = NET_RX_DROP;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
@@ -684,6 +684,22 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	unicast_packet->header.ttl--;
 
+	switch (unicast_packet->header.packet_type) {
+	case BATADV_UNICAST_4ADDR:
+		hdr_len = sizeof(struct batadv_unicast_4addr_packet);
+		break;
+	case BATADV_UNICAST:
+		hdr_len = sizeof(struct batadv_unicast_packet);
+		break;
+	default:
+		/* other packet types not supported - yet */
+		hdr_len = -1;
+		break;
+	}
+
+	if (hdr_len > 0)
+		batadv_skb_set_priority(skb, hdr_len);
+
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
 
 	/* translate transmit result into receive result */
@@ -1133,6 +1149,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_bla_check_bcast_duplist(bat_priv, skb))
 		goto out;
 
+	batadv_skb_set_priority(skb, sizeof(struct batadv_bcast_packet));
+
 	/* rebroadcast packet */
 	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
 
diff --git a/send.c b/send.c
index d2cc507..66d09a5 100644
--- a/send.c
+++ b/send.c
@@ -66,7 +66,6 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	ethhdr->h_proto = htons(ETH_P_BATMAN);
 
 	skb_set_network_header(skb, ETH_HLEN);
-	skb->priority = TC_PRIO_CONTROL;
 	skb->protocol = htons(ETH_P_BATMAN);
 
 	skb->dev = hard_iface->net_dev;
diff --git a/soft-interface.c b/soft-interface.c
index 25662d9..a377f4d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -235,6 +235,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
+	batadv_skb_set_priority(skb, 0);
+
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
-- 
1.7.10.4

