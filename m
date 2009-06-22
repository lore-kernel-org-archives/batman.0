Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 14:04:14 +0200
Message-Id: <1245672254-32531-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Use length modifier for size_t
	types in printf
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/ping.c       |   10 +++++-----
 batctl/traceroute.c |    8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/batctl/ping.c b/batctl/ping.c
index b56867b..f051fe9 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -147,7 +147,7 @@ int ping(int argc, char **argv)
 	icmp_packet_out.ttl = 50;
 	icmp_packet_out.seqno = 0;
 
-	printf("PING %s (%s) %i(%i) bytes of data\n", dst_string, mac_string,
+	printf("PING %s (%s) %zi(%zi) bytes of data\n", dst_string, mac_string,
 		sizeof(icmp_packet_out), sizeof(icmp_packet_out) + 28);
 
 	while (!is_aborted) {
@@ -194,8 +194,8 @@ int ping(int argc, char **argv)
 			goto sleep;
 		}
 
-		if ((unsigned int)read_len < sizeof(icmp_packet_in)) {
-			printf("Warning - dropping received packet as it is smaller than expected (%d): %d\n",
+		if ((size_t)read_len < sizeof(icmp_packet_in)) {
+			printf("Warning - dropping received packet as it is smaller than expected (%zd): %zd\n",
 				sizeof(icmp_packet_in), read_len);
 			goto sleep;
 		}
@@ -204,7 +204,7 @@ int ping(int argc, char **argv)
 		case ECHO_REPLY:
 			gettimeofday(&end, (struct timezone*)0);
 			time_delta = time_diff(&start, &end);
-			printf("%d bytes from %s icmp_seq=%u ttl=%d time=%.2f ms\n",
+			printf("%zd bytes from %s icmp_seq=%u ttl=%d time=%.2f ms\n",
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
 					icmp_packet_in.ttl, time_delta);
 
@@ -227,7 +227,7 @@ int ping(int argc, char **argv)
 			printf("Please make sure to compatible versions!\n");
 			goto out;
 		default:
-			printf("Unknown message type %d len %d received\n", icmp_packet_in.msg_type, read_len);
+			printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
 			break;
 		}
 
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index 2d16ff4..cdc2b8c 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -108,7 +108,7 @@ int traceroute(int argc, char **argv)
 	icmp_packet_out.msg_type = ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
 
-	printf("traceroute to %s (%s), %d hops max, %d byte packets\n",
+	printf("traceroute to %s (%s), %d hops max, %zd byte packets\n",
 		dst_string, mac_string, TTL_MAX, sizeof(icmp_packet_out));
 
 	for (icmp_packet_out.ttl = 0; !dst_reached && icmp_packet_out.ttl < TTL_MAX; icmp_packet_out.ttl++) {
@@ -143,8 +143,8 @@ int traceroute(int argc, char **argv)
 				continue;
 			}
 
-			if ((unsigned int)read_len < sizeof(icmp_packet_in)) {
-				printf("Warning - dropping received packet as it is smaller than expected (%d): %d\n",
+			if ((size_t)read_len < sizeof(icmp_packet_in)) {
+				printf("Warning - dropping received packet as it is smaller than expected (%zd): %zd\n",
 					sizeof(icmp_packet_in), read_len);
 				continue;
 			}
@@ -182,7 +182,7 @@ int traceroute(int argc, char **argv)
 				printf("Please make sure to compatible versions!\n");
 				goto out;
 			default:
-				printf("Unknown message type %d len %d received\n", icmp_packet_in.msg_type, read_len);
+				printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
 				break;
 			}
 		}
-- 
1.6.3.1

