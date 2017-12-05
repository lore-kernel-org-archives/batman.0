Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Tue,  5 Dec 2017 15:35:14 +0100
Message-Id: <20171205143514.4441-7-sven.eckelmann@openmesh.com>
In-Reply-To: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v2 6/6] flow_dissector: Parse batman-adv
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
Cc: "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@openmesh.com>

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
 net/core/flow_dissector.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 15ce30063765..784cc07fc58e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -24,6 +24,7 @@
 #include <linux/tcp.h>
 #include <net/flow_dissector.h>
 #include <scsi/fc/fc_fcoe.h>
+#include <uapi/linux/batadv.h>
 
 static void dissector_set_key(struct flow_dissector *flow_dissector,
 			      enum flow_dissector_key_id key_id)
@@ -696,6 +697,35 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
 
 		break;
 	}
+	case htons(ETH_P_BATMAN): {
+		struct {
+			struct batadv_unicast_packet batadv_unicast;
+			struct ethhdr eth;
+		} *hdr, _hdr;
+
+		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen,
+					   &_hdr);
+		if (!hdr) {
+			fdret = FLOW_DISSECT_RET_OUT_BAD;
+			break;
+		}
+
+		if (hdr->batadv_unicast.version != BATADV_COMPAT_VERSION) {
+			fdret = FLOW_DISSECT_RET_OUT_BAD;
+			break;
+		}
+
+		if (hdr->batadv_unicast.packet_type != BATADV_UNICAST) {
+			fdret = FLOW_DISSECT_RET_OUT_BAD;
+			break;
+		}
+
+		proto = hdr->eth.h_proto;
+		nhoff += sizeof(*hdr);
+
+		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
+		break;
+	}
 	case htons(ETH_P_8021AD):
 	case htons(ETH_P_8021Q): {
 		const struct vlan_hdr *vlan;
-- 
2.11.0

