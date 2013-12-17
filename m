Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Dec 2013 19:12:12 +0100
Message-Id: <1387303932-18445-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add build checks for packet sizes
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

With unrolling the batadv_header into the respective structures, the
offsetof checks are now useless. Instead, add build checks for all
packet types which go over the wire to avoid problems with wrong sizes
or compatibility issues on some architectures which don't use every day.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 main.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/main.c b/main.c
index 945e441..ad6aeed 100644
--- a/main.c
+++ b/main.c
@@ -419,13 +419,23 @@ static void batadv_recv_handler_init(void)
 	for (i = BATADV_UNICAST_MIN; i <= BATADV_UNICAST_MAX; i++)
 		batadv_rx_handler[i] = batadv_recv_unhandled_unicast_packet;
 
-	/* compile time checks for struct member offsets */
-	BUILD_BUG_ON(offsetof(struct batadv_unicast_4addr_packet, src) != 10);
-	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, dest) != 4);
-	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, dst) != 4);
-	BUILD_BUG_ON(offsetof(struct batadv_frag_packet, dest) != 4);
-	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, dst) != 4);
-	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, dst) != 4);
+	/* compile time checks for sizes */
+	BUILD_BUG_ON(sizeof(struct batadv_bla_claim_dst) != 6);
+	BUILD_BUG_ON(sizeof(struct batadv_ogm_packet) != 24);
+	BUILD_BUG_ON(sizeof(struct batadv_icmp_header) != 20);
+	BUILD_BUG_ON(sizeof(struct batadv_icmp_packet) != 20);
+	BUILD_BUG_ON(sizeof(struct batadv_icmp_packet_rr) != 116);
+	BUILD_BUG_ON(sizeof(struct batadv_unicast_packet) != 10);
+	BUILD_BUG_ON(sizeof(struct batadv_unicast_4addr_packet) != 18);
+	BUILD_BUG_ON(sizeof(struct batadv_frag_packet) != 20);
+	BUILD_BUG_ON(sizeof(struct batadv_bcast_packet) != 14);
+	BUILD_BUG_ON(sizeof(struct batadv_coded_packet) != 46);
+	BUILD_BUG_ON(sizeof(struct batadv_unicast_tvlv_packet) != 20);
+	BUILD_BUG_ON(sizeof(struct batadv_tvlv_hdr) != 4);
+	BUILD_BUG_ON(sizeof(struct batadv_tvlv_gateway_data) != 8);
+	BUILD_BUG_ON(sizeof(struct batadv_tvlv_tt_vlan_data) != 8);
+	BUILD_BUG_ON(sizeof(struct batadv_tvlv_tt_change) != 12);
+	BUILD_BUG_ON(sizeof(struct batadv_tvlv_roam_adv) != 8);
 
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
-- 
1.7.10.4

