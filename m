Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Mon, 27 Nov 2017 13:33:41 +0100
Message-Id: <20171127123341.11365-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] flow_dissector: Parse batman-adv unicast
 headers
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The batman-adv unicast packets contain a full layer 2 frame in encapsulated
form. The flow dissector must therefore be able to parse the batman-adv
unicast header to reach the layer 2+3 information to allow RPS to schedule
the flow to different cores.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---

I've played around with the RPS+XPS to better distribute traffic to
different cores on modern SoCs. It was observed that the batman-adv unicast
traffic stayed at one core and this limited the overall throughput.

The test was done between a modern PC which was running iperf over
batman-adv. Another PC was also running iperf was just transmitting the
traffic over ethernet. A QCA Dakota (IPQ4018) based device was in the
middle and received the ethernet traffic on one port, encapsulated it as
batman-adv unicast and transferred the resulting packet via ethernet to the
modern PC.

    $ iperf -c 192.168.23.2 -t 30 -i 1  -P16

It was observed that only the receive processing was affected. Adding this
relative simple patch allowed me to increase the ethernet throughput from
689 Mbits/sec (with one core doing the interrupt processing and 1 core
completely busy with the other processing) to 910 Mbits/sec (one core doing
the interrupt processing and the other 3 cores were sharing the load). In
theory, the device with the patch could have handled a lot more traffic
than 910 Mbit/sec - at least the RPS cores were not even near 100% load.

This should bring a lot more when testing with good 802.11ac WiFi links
because the wifi stack/driver are usually stressing the CPU a lot more than
normal ethernet drivers.

The change itself is not really invasive but could be a lot cleaner when
the packet header information would be available under include/... . And I
don't know yet whether it would make sense to add a new flow dissector key
with the batman-adv destination address. This is also the reason why I only
post this to the b.a.t.m.a.n@lists.open-mesh.org mailing list.

Anyway, maybe some other people ran into the same problem and want to test
it.
---
 net/core/flow_dissector.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0a977373d003..bbf894fff3fc 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -595,6 +595,39 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
 
 		break;
 	}
+	case htons(ETH_P_BATMAN): {
+		/* TODO provide struct in include/uapi/... header */
+		struct batadv_unicast_packet {
+			u8 packet_type;
+			u8 version;
+			u8 ttl;
+			u8 ttvn;
+			u8 dest[ETH_ALEN];
+		};
+
+		struct {
+			struct batadv_unicast_packet batadv_unicast;
+			struct ethhdr eth;
+		} *hdr, _hdr;
+
+		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen,
+					   &_hdr);
+		if (!hdr)
+			goto out_bad;
+
+		if (hdr->batadv_unicast.version != 15)
+			break;
+
+		if (hdr->batadv_unicast.packet_type != 0x40)
+			break;
+
+		/* TODO set batman-adv dest address as flow key? */
+
+		proto = hdr->eth.h_proto;
+		nhoff += sizeof(*hdr);
+
+		goto again;
+	}
 	case htons(ETH_P_8021AD):
 	case htons(ETH_P_8021Q): {
 		const struct vlan_hdr *vlan;
-- 
2.11.0

