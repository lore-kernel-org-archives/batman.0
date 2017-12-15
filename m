Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 15 Dec 2017 19:23:13 +0100
Message-Id: <20171215182313.15767-5-sven.eckelmann@openmesh.com>
In-Reply-To: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
References: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v3 4/4] flow_dissector: Parse batman-adv
 unicast headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Tom Herbert <tom@herbertland.com>, Sven Eckelmann <sven.eckelmann@openmesh.com>

The batman-adv unicast packets contain a full layer 2 frame in encapsulated
form. The flow dissector must therefore be able to parse the batman-adv
unicast header to reach the layer 2+3 information.

  +--------------------+
  | ip(v6)hdr          |
  +--------------------+
  | inner ethhdr       |
  +--------------------+
  | batadv unicast hdr |
  +--------------------+
  | outer ethhdr       |
  +--------------------+

The obtained information from the upper layer can then be used by RPS to
schedule the processing on separate cores. This allows better distribution
of multiple flows from the same neighbor to different cores.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 net/core/flow_dissector.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 15ce30063765..fa0a4879fb9d 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -24,6 +24,7 @@
 #include <linux/tcp.h>
 #include <net/flow_dissector.h>
 #include <scsi/fc/fc_fcoe.h>
+#include <uapi/linux/batadv_packet.h>
 
 static void dissector_set_key(struct flow_dissector *flow_dissector,
 			      enum flow_dissector_key_id key_id)
@@ -436,6 +437,57 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+/**
+ * __skb_flow_dissect_batadv() - dissect batman-adv header
+ * @skb: sk_buff to with the batman-adv header
+ * @key_control: flow dissectors control key
+ * @data: raw buffer pointer to the packet, if NULL use skb->data
+ * @p_proto: pointer used to update the protocol to process next
+ * @p_nhoff: pointer used to update inner network header offset
+ * @hlen: packet header length
+ * @flags: any combination of FLOW_DISSECTOR_F_*
+ *
+ * ETH_P_BATMAN packets are tried to be dissected. Only
+ * &struct batadv_unicast packets are actually processed because they contain an
+ * inner ethernet header and are usually followed by actual network header. This
+ * allows the flow dissector to continue processing the packet.
+ *
+ * Return: FLOW_DISSECT_RET_PROTO_AGAIN when &struct batadv_unicast was found,
+ *  FLOW_DISSECT_RET_OUT_GOOD when dissector should stop after encapsulation,
+ *  otherwise FLOW_DISSECT_RET_OUT_BAD
+ */
+static enum flow_dissect_ret
+__skb_flow_dissect_batadv(const struct sk_buff *skb,
+			  struct flow_dissector_key_control *key_control,
+			  void *data, __be16 *p_proto, int *p_nhoff, int hlen,
+			  unsigned int flags)
+{
+	struct {
+		struct batadv_unicast_packet batadv_unicast;
+		struct ethhdr eth;
+	} *hdr, _hdr;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (hdr->batadv_unicast.version != BATADV_COMPAT_VERSION)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (hdr->batadv_unicast.packet_type != BATADV_UNICAST)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	*p_proto = hdr->eth.h_proto;
+	*p_nhoff += sizeof(*hdr);
+
+	key_control->flags |= FLOW_DIS_ENCAPSULATION;
+	if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	return FLOW_DISSECT_RET_PROTO_AGAIN;
+}
+
 static void
 __skb_flow_dissect_tcp(const struct sk_buff *skb,
 		       struct flow_dissector *flow_dissector,
@@ -817,6 +869,11 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
 					       nhoff, hlen);
 		break;
 
+	case htons(ETH_P_BATMAN):
+		fdret = __skb_flow_dissect_batadv(skb, key_control, data,
+						  &proto, &nhoff, hlen, flags);
+		break;
+
 	default:
 		fdret = FLOW_DISSECT_RET_OUT_BAD;
 		break;
-- 
2.11.0

