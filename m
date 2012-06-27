Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 27 Jun 2012 22:28:17 +0200
Message-Id: <1340828898-12352-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Don't leak information through
	initialized packet fields
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The reserved fields in batman-adv packets are not set to a constant value. The
content of these memory regions is leaked unintentionally to the network.

This regression was introduced in ee319368e5d6385458345731e519640889c177c4

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c       |    2 ++
 traceroute.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/ping.c b/ping.c
index 9f64a8f..ce8f457 100644
--- a/ping.c
+++ b/ping.c
@@ -174,6 +174,8 @@ int ping(char *mesh_iface, int argc, char **argv)
 		icmp_packet_out.rr_cur = 1;
 		memset(&icmp_packet_out.rr, 0, BATADV_RR_LEN * ETH_ALEN);
 		memset(last_rr, 0, BATADV_RR_LEN * ETH_ALEN);
+	} else {
+		((struct batadv_icmp_packet *)&icmp_packet_out)->reserved = 0;
 	}
 
 	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
diff --git a/traceroute.c b/traceroute.c
index c1aaad8..75ff2b3 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -125,6 +125,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	icmp_packet_out.header.packet_type = BATADV_ICMP;
 	icmp_packet_out.msg_type = BATADV_ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
+	icmp_packet_out.reserved = 0;
 
 	printf("traceroute to %s (%s), %d hops max, %zu byte packets\n",
 		dst_string, mac_string, TTL_MAX, sizeof(icmp_packet_out));
-- 
1.7.10

