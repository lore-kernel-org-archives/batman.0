Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 12:25:31 +0100
Message-Id: <20161219112535.9446-3-linus.luessing@c0d3.blue>
In-Reply-To: <20161219112535.9446-1-linus.luessing@c0d3.blue>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH 2/6] batman-adv: aggregation packet
	reception
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

This patch implements the de-aggregation and reception of
broadcast aggregation packets, which areintroduced through
the new BATADV_BCAST_AGGR packet type.

It enables us to receive aggregation packets consisting of any
batman packet type with a broadcast ethernet destination.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile                        |   3 +
 gen-compat-autoconf.sh          |   1 +
 net/batman-adv/Makefile         |   1 +
 net/batman-adv/aggregation.c    | 194 ++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/aggregation.h    |  66 ++++++++++++++
 net/batman-adv/main.c           |   9 ++
 net/batman-adv/packet.h         |  18 ++++
 net/batman-adv/routing.c        |  63 +++++++++++++
 net/batman-adv/routing.h        |   2 +
 net/batman-adv/soft-interface.c |   6 ++
 net/batman-adv/tvlv.c           |  13 ++-
 net/batman-adv/types.h          |  38 ++++++++
 12 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 net/batman-adv/aggregation.c
 create mode 100644 net/batman-adv/aggregation.h

diff --git a/Makefile b/Makefile
index b852a17..5a34086 100644
--- a/Makefile
+++ b/Makefile
@@ -29,6 +29,8 @@ export CONFIG_BATMAN_ADV_DAT=y
 export CONFIG_BATMAN_ADV_NC=n
 # B.A.T.M.A.N. multicast optimizations:
 export CONFIG_BATMAN_ADV_MCAST=y
+# B.A.T.M.A.N. generic broadcast aggregation:
+export CONFIG_BATMAN_ADV_AGGR=y
 # B.A.T.M.A.N. V routing algorithm (experimental):
 export CONFIG_BATMAN_ADV_BATMAN_V=n
 
@@ -83,6 +85,7 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_DAT=$(CONFIG_BATMAN_ADV_DAT) \
 	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
 	CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
+	CONFIG_BATMAN_ADV_AGGR=$(CONFIG_BATMAN_ADV_AGGR) \
 	CONFIG_BATMAN_ADV_BATMAN_V=$(CONFIG_BATMAN_ADV_BATMAN_V) \
 	INSTALL_MOD_DIR=updates/
 
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index cf36e55..c835a6d 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -41,6 +41,7 @@ gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_AGGR' ${CONFIG_BATMAN_ADV_AGGR:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="n"} >> "${TMP}"
 
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index f724d3c..78ddf57 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -17,6 +17,7 @@
 #
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
+batman-adv-$(CONFIG_BATMAN_ADV_AGGR) += aggregation.o
 batman-adv-y += bat_algo.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v.o
diff --git a/net/batman-adv/aggregation.c b/net/batman-adv/aggregation.c
new file mode 100644
index 0000000..2ee4dae
--- /dev/null
+++ b/net/batman-adv/aggregation.c
@@ -0,0 +1,194 @@
+/* Copyright (C) 2016  B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "aggregation.h"
+#include "main.h"
+
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "tvlv.h"
+
+/**
+ * batadv_aggr_unpack_ctx - unpack context received with a TVLV handler call
+ * @ctx: handler specific context information
+ *  (here: recv_if, h_source and packet type of aggregate)
+ *
+ * This unpacks the context received within an aggregation TVLV handler, here
+ * the interface and source address of the neighbor this packet came from,
+ * as well as the packet type of the according aggregate.
+ *
+ * Return: An aggregation context regarding where the packet came from.
+ */
+static inline struct batadv_aggr_ctx *batadv_aggr_unpack_ctx(void *ctx)
+{
+	return (struct batadv_aggr_ctx *)ctx;
+}
+
+/**
+ * batadv_aggr_add_counter_rx - update aggregation rx statistics
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to count
+ *
+ * Updates statistics for received aggregation packets with the given skb.
+ */
+void batadv_aggr_add_counter_rx(struct batadv_priv *bat_priv,
+				struct sk_buff *skb)
+{
+	batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_AGGR_RX_BYTES,
+			   skb->len + ETH_HLEN);
+}
+
+/**
+ * batadv_aggr_put_ethhdr - append a mac header to skb
+ * @skb: the packet to append to
+ * @h_source: the ethernet source address to set
+ *
+ * Appends a mac header to the given skb with the ethernet source address
+ * set to the provided h_source and the ethernet destination address to
+ * a broadcast one. Furthermore, sets the ethernet type to ETH_P_BATMAN.
+ *
+ * Also sets the skb mac header pointer to the beginning of the appended mac
+ * header.
+ */
+static void batadv_aggr_put_ethhdr(struct sk_buff *skb, unsigned char *h_source)
+{
+	struct ethhdr *ethhdr;
+
+	skb_reset_mac_header(skb);
+
+	ethhdr = (struct ethhdr *)skb_put(skb, ETH_HLEN);
+	ethhdr->h_proto = htons(ETH_P_BATMAN);
+	ether_addr_copy(ethhdr->h_source, h_source);
+	ether_addr_copy(ethhdr->h_dest, batadv_broadcast_addr);
+}
+
+/**
+ * batadv_aggr_put_batadv - append batman header and data to skb
+ * @skb: the packet to append to
+ * @data: the data to append after the batman header
+ * @data_len: the length of the data to append
+ * @packet_type: the packet type to set in the batman header
+ *
+ * First appends a batman header consisting of the given packet type and the
+ * compatibility version to the given skb. Then copies the given data behind
+ * this minimal batman header in the skb.
+ *
+ * Also sets the skb network header pointer to the beginning of the batman
+ * header.
+ */
+static void batadv_aggr_put_batadv(struct sk_buff *skb, void *data,
+				   u16 data_len, u8 packet_type)
+{
+	u8 version = BATADV_COMPAT_VERSION;
+	u8 *pos;
+
+	skb_reset_network_header(skb);
+	skb_reset_mac_len(skb);
+
+	pos = (u8 *)skb_put(skb, sizeof(packet_type));
+	*pos = packet_type;
+	pos = (u8 *)skb_put(skb, sizeof(version));
+	*pos = version;
+
+	pos = (u8 *)skb_put(skb, data_len);
+	memcpy(pos, data, data_len);
+}
+
+/**
+ * batadv_aggr_tvlv_handler - process incoming aggregation tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tvlv_value: tvlv buffer containing an aggregated packet
+ * @tvlv_value_len: length of the aggregated packet
+ * @ctx: handler specific context information
+ *  (here: recv_if, h_source and packet type of aggregated packet)
+ *
+ * De-aggregates the given, specific broadcast packet and transparently
+ * forwards it for broadcast packet reception.
+ *
+ * Return: NET_RX_SUCCESS on success, NET_RX_DROP otherwise.
+ */
+static int batadv_aggr_tvlv_handler(struct batadv_priv *bat_priv,
+				    void *tvlv_value, u16 tvlv_value_len,
+				    void *ctx)
+{
+	struct batadv_aggr_ctx *aggr_ctx;
+	struct batadv_hard_iface *recv_if;
+	struct sk_buff *skb;
+	unsigned int size;
+	u8 version = BATADV_COMPAT_VERSION;
+	u8 packet_type;
+
+	aggr_ctx = batadv_aggr_unpack_ctx(ctx);
+	recv_if = aggr_ctx->recv_if;
+	packet_type = aggr_ctx->handler.tvlv_type;
+
+	/* disallow aggr-in-aggr-in-... to avoid stack overflows */
+	if (packet_type == BATADV_BCAST_AGGR)
+		return NET_RX_DROP;
+
+	size = NET_IP_ALIGN + ETH_HLEN;
+	size += sizeof(packet_type) + sizeof(version);
+	size += tvlv_value_len;
+
+	skb = dev_alloc_skb(size);
+	if (!skb)
+		return NET_RX_DROP;
+
+	skb_reserve(skb, NET_IP_ALIGN);
+	batadv_aggr_put_ethhdr(skb, aggr_ctx->h_source);
+	skb_pull(skb, ETH_HLEN);
+	batadv_aggr_put_batadv(skb, tvlv_value, tvlv_value_len, packet_type);
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_PARTS_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_AGGR_PARTS_RX_BYTES,
+			   skb->len + ETH_HLEN);
+
+	return batadv_batman_skb_recv(skb, recv_if->net_dev,
+				      &recv_if->batman_adv_ptype, NULL);
+}
+
+/**
+ * batadv_aggr_mesh_init - initialise the generic aggregation engine
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or a negative error code in case of failure
+ */
+int batadv_aggr_mesh_init(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_handler_register2(bat_priv, batadv_aggr_tvlv_handler,
+				      BATADV_BCAST_AGGR, BATADV_TVLV_ANY, 1,
+				      BATADV_TVLV_HANDLER_MORECTX);
+	batadv_tvlv_container_register(bat_priv, BATADV_TVLV_AGGR, 1, NULL, 0);
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_free - shutdown the generic aggregation engine
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_aggr_mesh_free(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_AGGR, 1);
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_BCAST_AGGR,
+					BATADV_TVLV_ANY, 1);
+}
diff --git a/net/batman-adv/aggregation.h b/net/batman-adv/aggregation.h
new file mode 100644
index 0000000..db3b06b
--- /dev/null
+++ b/net/batman-adv/aggregation.h
@@ -0,0 +1,66 @@
+/* Copyright (C) 2016  B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_AGGREGATION_H_
+#define _NET_BATMAN_ADV_AGGREGATION_H_
+
+#include "main.h"
+
+struct sk_buff;
+
+/**
+ * batadv_aggr_pack_ctx - pack context to be passed to aggregation TVLV handler
+ * @aggr_ctx: the data to pack (mandatory, may *not* be NULL!)
+ *
+ * This packs the context, here the interface and source address the packet came
+ * from, as well as the packet type of the according aggregate, so that it is
+ * later available to the to be called aggregation TVLV handler.
+ *
+ * Return: The wrapped context.
+ */
+static inline void *batadv_aggr_pack_ctx(struct batadv_aggr_ctx *aggr_ctx)
+{
+	return (void *)aggr_ctx;
+}
+
+#ifdef CONFIG_BATMAN_ADV_AGGR
+
+void batadv_aggr_add_counter_rx(struct batadv_priv *bat_priv,
+				struct sk_buff *skb);
+
+int batadv_aggr_mesh_init(struct batadv_priv *bat_priv);
+void batadv_aggr_mesh_free(struct batadv_priv *bat_priv);
+
+#else
+
+static inline void batadv_aggr_add_counter_rx(struct batadv_priv *bat_priv,
+					      struct sk_buff *skb)
+{
+}
+
+static inline int batadv_aggr_mesh_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline void batadv_aggr_mesh_free(struct batadv_priv *bat_priv)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_AGGR */
+
+#endif /* _NET_BATMAN_ADV_AGGREGATION_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 7aa384a..fe6b904 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -47,6 +47,7 @@
 #include <net/rtnetlink.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "aggregation.h"
 #include "bat_algo.h"
 #include "bat_iv_ogm.h"
 #include "bat_v.h"
@@ -180,6 +181,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->softif_vlan_list);
 	INIT_HLIST_HEAD(&bat_priv->tp_list);
 
+	ret = batadv_aggr_mesh_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	ret = batadv_v_mesh_init(bat_priv);
 	if (ret < 0)
 		goto err;
@@ -227,6 +232,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_gw_node_free(bat_priv);
 
+	batadv_aggr_mesh_free(bat_priv);
 	batadv_v_mesh_free(bat_priv);
 	batadv_nc_mesh_free(bat_priv);
 	batadv_dat_free(bat_priv);
@@ -508,6 +514,7 @@ static void batadv_recv_handler_init(void)
 	BUILD_BUG_ON(sizeof(struct batadv_unicast_packet) != 10);
 	BUILD_BUG_ON(sizeof(struct batadv_unicast_4addr_packet) != 18);
 	BUILD_BUG_ON(sizeof(struct batadv_frag_packet) != 20);
+	BUILD_BUG_ON(sizeof(struct batadv_aggr_packet) != 4);
 	BUILD_BUG_ON(sizeof(struct batadv_bcast_packet) != 14);
 	BUILD_BUG_ON(sizeof(struct batadv_coded_packet) != 46);
 	BUILD_BUG_ON(sizeof(struct batadv_unicast_tvlv_packet) != 20);
@@ -531,6 +538,8 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
 	/* Fragmented packets */
 	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_frag_packet;
+	/* Aggregation packets */
+	batadv_rx_handler[BATADV_BCAST_AGGR] = batadv_recv_aggr_packet;
 }
 
 int
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index a14547c..3492332 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -31,6 +31,7 @@
  * @BATADV_CODED: network coded packets
  * @BATADV_ELP: echo location packets for B.A.T.M.A.N. V
  * @BATADV_OGM2: originator messages for B.A.T.M.A.N. V
+ * @BATADV_AGGR: broadcast aggregation packets
  *
  * @BATADV_UNICAST: unicast packets carrying unicast payload traffic
  * @BATADV_UNICAST_FRAG: unicast packets carrying a fragment of the original
@@ -47,6 +48,7 @@ enum batadv_packettype {
 	BATADV_CODED            = 0x02,
 	BATADV_ELP		= 0x03,
 	BATADV_OGM2		= 0x04,
+	BATADV_BCAST_AGGR	= 0x05,
 	/* 0x40 - 0x7f: unicast */
 #define BATADV_UNICAST_MIN     0x40
 	BATADV_UNICAST          = 0x40,
@@ -154,6 +156,8 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
  * @BATADV_TVLV_MCAST: multicast capability tvlv
+ * @BATADV_TVLV_AGGR: generic broadcast aggregation capability tvlv
+ * @BATADV_ANYTYPE: internal place holder for TVLV handlers, not for the "wire"
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
@@ -162,6 +166,8 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_TT		= 0x04,
 	BATADV_TVLV_ROAM	= 0x05,
 	BATADV_TVLV_MCAST	= 0x06,
+	BATADV_TVLV_AGGR	= 0x07,
+	BATADV_TVLV_ANY		= 0xff,
 };
 
 /**
@@ -468,6 +474,18 @@ struct batadv_frag_packet {
 };
 
 /**
+ * struct batadv_aggr_packet - aggregation packet for broadcast packets
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the genereal header
+ * @tvlv_len: length of tvlv data following the aggregation header
+ */
+struct batadv_aggr_packet {
+	u8     packet_type;
+	u8     version;  /* batman version field */
+	__be16 tvlv_len;
+};
+
+/**
  * struct batadv_bcast_packet - broadcast packet for network payload
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6713bdf..ee5f3d0 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -34,6 +34,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 
+#include "aggregation.h"
 #include "bitarray.h"
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
@@ -1137,6 +1138,68 @@ free_skb:
 	return ret;
 }
 
+/**
+ * batadv_recv_aggr_get_tvlv_len - get tvlv_len of an aggregation packet
+ * @skb: the aggregation packet to parse
+ *
+ * Return: Length of the tvlv data of the given skb on success,
+ * -EINVAL otherwise (i.e. packet is too short).
+ */
+static int batadv_recv_aggr_get_tvlv_len(struct sk_buff *skb)
+{
+	unsigned int tvlv_len_offset;
+	__be16 *tvlv_len, tvlv_len_buff;
+
+	tvlv_len_offset = offsetof(struct batadv_aggr_packet, tvlv_len);
+	tvlv_len = skb_header_pointer(skb, tvlv_len_offset,
+				      sizeof(tvlv_len_buff), &tvlv_len_buff);
+
+	if (!tvlv_len)
+		return -EINVAL;
+
+	return ntohs(*tvlv_len);
+}
+
+/**
+ * batadv_recv_aggr_packet - process received aggregation packet
+ * @skb: the aggregation packet to process
+ * @recv_if: interface that the skb is received on
+ *
+ * This function de-aggregates broadcast packets from the given
+ * aggregation packet.
+ *
+ * Frees/consumes the provided skb.
+ *
+ * Return: NET_RX_SUCCESS on success, NET_RX_DROP otherwise.
+ */
+int batadv_recv_aggr_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_aggr_ctx aggr_ctx;
+	unsigned int tvlv_offset = sizeof(struct batadv_aggr_packet);
+	int tvlv_len, ret;
+	void *ctx;
+
+	aggr_ctx.recv_if = recv_if;
+	aggr_ctx.h_source = eth_hdr(skb)->h_source;
+	ctx = batadv_aggr_pack_ctx(&aggr_ctx);
+	tvlv_len = batadv_recv_aggr_get_tvlv_len(skb);
+
+	if (tvlv_len < 0) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+
+	batadv_aggr_add_counter_rx(bat_priv, skb);
+
+	ret = batadv_tvlv_containers_process2(bat_priv, skb, BATADV_BCAST_AGGR,
+					      tvlv_offset, tvlv_len, ctx);
+
+	consume_skb(skb);
+	return ret;
+}
+
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 05c3ff4..fcf3967 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -37,6 +37,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if);
 int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *iface);
+int batadv_recv_aggr_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_tt_query(struct sk_buff *skb,
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7b3494a..fce69b7 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1150,6 +1150,12 @@ static const struct {
 	{ "frag_rx_bytes" },
 	{ "frag_fwd" },
 	{ "frag_fwd_bytes" },
+#ifdef CONFIG_BATMAN_ADV_AGGR
+	{ "aggr_rx" },
+	{ "aggr_rx_bytes" },
+	{ "aggr_parts_rx" },
+	{ "aggr_parts_rx_bytes" },
+#endif
 	{ "tt_request_tx" },
 	{ "tt_request_rx" },
 	{ "tt_response_tx" },
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index c824d74..0d5be4b 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -88,10 +88,12 @@ batadv_tvlv_handler_get(struct batadv_priv *bat_priv, int packet_type,
 		if (tvlv_handler_tmp->packet_type != packet_type)
 			continue;
 
-		if (tvlv_handler_tmp->tvlv_type != tvlv_type)
+		if (tvlv_handler_tmp->tvlv_type != BATADV_TVLV_ANY &&
+		    tvlv_handler_tmp->tvlv_type != tvlv_type)
 			continue;
 
-		if (tvlv_handler_tmp->tvlv_version != tvlv_version)
+		if (tvlv_handler_tmp->tvlv_type != BATADV_TVLV_ANY &&
+		    tvlv_handler_tmp->tvlv_version != tvlv_version)
 			continue;
 
 		if (!kref_get_unless_zero(&tvlv_handler_tmp->refcount))
@@ -431,6 +433,7 @@ static int batadv_tvlv_call_handler2(struct batadv_priv *bat_priv,
 				     u8 tvlv_version, void *tvlv_value,
 				     u16 tvlv_value_len, void *ctx)
 {
+	struct batadv_tvlv_handler_ctx *handler_ctx;
 	struct batadv_tvlv_handler *tvlv_handler;
 	int ret;
 
@@ -439,6 +442,12 @@ static int batadv_tvlv_call_handler2(struct batadv_priv *bat_priv,
 	if (!tvlv_handler)
 		return NET_RX_DROP;
 
+	if (tvlv_handler->flags & BATADV_TVLV_HANDLER_MORECTX) {
+		handler_ctx = (struct batadv_tvlv_handler_ctx *)ctx;
+		handler_ctx->tvlv_type = tvlv_type;
+		handler_ctx->tvlv_version = tvlv_version;
+	}
+
 	ret = tvlv_handler->handler(bat_priv, tvlv_value, tvlv_value_len, ctx);
 	tvlv_handler->flags |= BATADV_TVLV_HANDLER_CALLED;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fc552a9..e2dbb5a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -575,6 +575,10 @@ struct batadv_bcast_duplist_entry {
  * @BATADV_CNT_FRAG_RX_BYTES: received fragment traffic bytes counter
  * @BATADV_CNT_FRAG_FWD: forwarded fragment traffic packet counter
  * @BATADV_CNT_FRAG_FWD_BYTES: forwarded fragment traffic bytes counter
+ * @BATADV_CNT_AGGR_RX: received aggregation traffic packet count
+ * @BATADV_CNT_AGGR_RX_BYTES: received aggregation traffic bytes counter
+ * @BATADV_CNT_AGGR_PARTS_RX: received aggregated traffic packet counter
+ * @BATADV_CNT_AGGR_PARTS_RX_BYTES: received aggregated bytes counter
  * @BATADV_CNT_TT_REQUEST_TX: transmitted tt req traffic packet counter
  * @BATADV_CNT_TT_REQUEST_RX: received tt req traffic packet counter
  * @BATADV_CNT_TT_RESPONSE_TX: transmitted tt resp traffic packet counter
@@ -618,6 +622,12 @@ enum batadv_counters {
 	BATADV_CNT_FRAG_RX_BYTES,
 	BATADV_CNT_FRAG_FWD,
 	BATADV_CNT_FRAG_FWD_BYTES,
+#ifdef CONFIG_BATMAN_ADV_AGGR
+	BATADV_CNT_AGGR_RX,
+	BATADV_CNT_AGGR_RX_BYTES,
+	BATADV_CNT_AGGR_PARTS_RX,
+	BATADV_CNT_AGGR_PARTS_RX_BYTES,
+#endif
 	BATADV_CNT_TT_REQUEST_TX,
 	BATADV_CNT_TT_REQUEST_RX,
 	BATADV_CNT_TT_RESPONSE_TX,
@@ -1648,16 +1658,44 @@ struct batadv_tvlv_handler {
 };
 
 /**
+ * struct batadv_tvlv_handler_ctx - handler meta information
+ * @tvlv_type: type of the processed tvlv
+ * @tvlv_version: version of the processed tvlv
+ *
+ * This structure is provided to a tvlv handler if the
+ * BATADV_TVLV_HANDLER_MORECTX flag was set during registration.
+ */
+struct batadv_tvlv_handler_ctx {
+	u8 tvlv_type;
+	u8 tvlv_version;
+};
+
+/**
+ * struct batadv_aggr_ctx - aggregation tvlv context
+ * @handler: information regarding the tvlv handler itself
+ * @recv_if: interface the packet was received from
+ * @h_source: ethernet address of the neighbor the packet was received from
+ */
+struct batadv_aggr_ctx {
+	struct batadv_tvlv_handler_ctx handler;
+	struct batadv_hard_iface *recv_if;
+	unsigned char *h_source;
+};
+
+/**
  * enum batadv_tvlv_handler_flags - tvlv handler flags definitions
  * @BATADV_TVLV_HANDLER_CIFNOTFND: tvlv processing function will call
  *  this handler even if its type was not found (with no data)
  * @BATADV_TVLV_HANDLER_CALLED: internal tvlv handling flag - the API marks
  *  a handler as being called, so it won't be called if the
  *  BATADV_TVLV_HANDLER_CIFNOTFND flag was set
+ * @BATADV_TVLV_HANDLER_MORECTX: tvlv processing function will be provided with
+ *  handler specific context (e.g. tvlv type and version)
  */
 enum batadv_tvlv_handler_flags {
 	BATADV_TVLV_HANDLER_CIFNOTFND = BIT(1),
 	BATADV_TVLV_HANDLER_CALLED = BIT(2),
+	BATADV_TVLV_HANDLER_MORECTX = BIT(3),
 };
 
 /**
-- 
2.1.4

