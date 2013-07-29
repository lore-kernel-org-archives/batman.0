Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 29 Jul 2013 17:56:44 +0200
Message-Id: <1375113404-10811-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH-next] batman-adv: set skb priority according
	to content
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
Changes to PATCH:
 * add compat code
 * base on next instead of master
---
 bat_iv_ogm.c        |    1 +
 compat.h            |    3 +++
 icmp_socket.c       |    1 +
 main.c              |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 main.h              |    1 +
 routing.c           |   20 +++++++++++++++++-
 send.c              |    1 -
 soft-interface.c    |    2 ++
 translation-table.c |    5 +++++
 unicast.c           |    2 ++
 vis.c               |    2 ++
 11 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2031071..0a8a80c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -479,6 +479,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 		kfree(forw_packet_aggr);
 		goto out;
 	}
+	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
 	skb_buff = skb_put(forw_packet_aggr->skb, packet_len);
diff --git a/compat.h b/compat.h
index 17ef089..0847d49 100644
--- a/compat.h
+++ b/compat.h
@@ -84,6 +84,9 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 	return skb;
 }
 
+#define VLAN_PRIO_MASK          0xe000 /* Priority Code Point */
+#define VLAN_PRIO_SHIFT         13
+
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
 
diff --git a/icmp_socket.c b/icmp_socket.c
index b27508b..5a99bb4 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -183,6 +183,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		goto out;
 	}
 
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb_put(skb, packet_len);
 
diff --git a/main.c b/main.c
index 51aafd6..ed97382 100644
--- a/main.c
+++ b/main.c
@@ -19,6 +19,10 @@
 
 #include <linux/crc32c.h>
 #include <linux/highmem.h>
+#include <linux/if_vlan.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/dsfield.h>
 #include "main.h"
 #include "sysfs.h"
 #include "debugfs.h"
@@ -249,6 +253,60 @@ out:
 	return primary_if;
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
diff --git a/main.h b/main.h
index 2c0c14d..70474ff 100644
--- a/main.h
+++ b/main.h
@@ -186,6 +186,7 @@ void batadv_mesh_free(struct net_device *soft_iface);
 int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq);
+void batadv_skb_set_priority(struct sk_buff *skb, int offset);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev);
diff --git a/routing.c b/routing.c
index 2f0bd3f..0439395 100644
--- a/routing.c
+++ b/routing.c
@@ -775,7 +775,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = eth_hdr(skb);
-	int res, ret = NET_RX_DROP;
+	int res, hdr_len, ret = NET_RX_DROP;
 	struct sk_buff *new_skb;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
@@ -835,6 +835,22 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	/* decrement ttl */
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
@@ -1193,6 +1209,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_bla_check_bcast_duplist(bat_priv, skb))
 		goto out;
 
+	batadv_skb_set_priority(skb, sizeof(struct batadv_bcast_packet));
+
 	/* rebroadcast packet */
 	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
 
diff --git a/send.c b/send.c
index e9ff8d8..0266edd 100644
--- a/send.c
+++ b/send.c
@@ -67,7 +67,6 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	ethhdr->h_proto = __constant_htons(ETH_P_BATMAN);
 
 	skb_set_network_header(skb, ETH_HLEN);
-	skb->priority = TC_PRIO_CONTROL;
 	skb->protocol = __constant_htons(ETH_P_BATMAN);
 
 	skb->dev = hard_iface->net_dev;
diff --git a/soft-interface.c b/soft-interface.c
index 700d0b4..9779801 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -222,6 +222,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
+	batadv_skb_set_priority(skb, 0);
+
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/translation-table.c b/translation-table.c
index 429aeef..34510f3 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1626,6 +1626,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	if (!skb)
 		goto out;
 
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
 	tt_response = (struct batadv_tt_query_packet *)skb_put(skb, len);
 	tt_response->ttvn = ttvn;
@@ -1691,6 +1692,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!skb)
 		goto out;
 
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
 
 	tt_req_len = sizeof(*tt_request);
@@ -1788,6 +1790,7 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		if (!skb)
 			goto unlock;
 
+		skb->priority = TC_PRIO_CONTROL;
 		skb_reserve(skb, ETH_HLEN);
 		packet_pos = skb_put(skb, len);
 		tt_response = (struct batadv_tt_query_packet *)packet_pos;
@@ -1906,6 +1909,7 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		if (!skb)
 			goto unlock;
 
+		skb->priority = TC_PRIO_CONTROL;
 		skb_reserve(skb, ETH_HLEN);
 		packet_pos = skb_put(skb, len);
 		tt_response = (struct batadv_tt_query_packet *)packet_pos;
@@ -2240,6 +2244,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	if (!skb)
 		goto out;
 
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
 
 	roam_adv_packet = (struct batadv_roam_adv_packet *)skb_put(skb, len);
diff --git a/unicast.c b/unicast.c
index dc8b5d4..869fcdb 100644
--- a/unicast.c
+++ b/unicast.c
@@ -242,6 +242,8 @@ int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
 	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
 	if (!frag_skb)
 		goto dropped;
+
+	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(frag_skb, ucf_hdr_len);
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
diff --git a/vis.c b/vis.c
index 4983340..d8ea31a 100644
--- a/vis.c
+++ b/vis.c
@@ -397,6 +397,7 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 		kfree(info);
 		return NULL;
 	}
+	info->skb_packet->priority = TC_PRIO_CONTROL;
 	skb_reserve(info->skb_packet, ETH_HLEN);
 	packet = (struct batadv_vis_packet *)skb_put(info->skb_packet, len);
 
@@ -861,6 +862,7 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->vis.my_info->skb_packet)
 		goto free_info;
 
+	bat_priv->vis.my_info->skb_packet->priority = TC_PRIO_CONTROL;
 	skb_reserve(bat_priv->vis.my_info->skb_packet, ETH_HLEN);
 	tmp_skb = bat_priv->vis.my_info->skb_packet;
 	packet = (struct batadv_vis_packet *)skb_put(tmp_skb, sizeof(*packet));
-- 
1.7.10.4

