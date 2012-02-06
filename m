Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  6 Feb 2012 22:04:17 +0800
Message-Id: <1328537057-19373-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tr / ping - ignore packets with
	wrong sequence number
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 ping.c       |    5 +++++
 traceroute.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/ping.c b/ping.c
index dff0f33..791cfb7 100644
--- a/ping.c
+++ b/ping.c
@@ -196,6 +196,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 			goto sleep;
 		}
 
+read_packet:
 		start_timer();
 
 		FD_ZERO(&read_socket);
@@ -229,6 +230,10 @@ int ping(char *mesh_iface, int argc, char **argv)
 			goto sleep;
 		}
 
+		/* after receiving an unexpected seqno we keep waiting for our answer */
+		if (htons(seq_counter) != icmp_packet_in.seqno)
+			goto read_packet;
+
 		switch (icmp_packet_in.msg_type) {
 		case ECHO_REPLY:
 			time_delta = end_timer();
diff --git a/traceroute.c b/traceroute.c
index f9e62cd..fdc9e4a 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -142,6 +142,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 				continue;
 			}
 
+read_packet:
 			start_timer();
 
 			tv.tv_sec = 2;
@@ -168,6 +169,10 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 				continue;
 			}
 
+			/* after receiving an unexpected seqno we keep waiting for our answer */
+			if (htons(seq_counter) != icmp_packet_in.seqno)
+				goto read_packet;
+
 			switch (icmp_packet_in.msg_type) {
 			case ECHO_REPLY:
 				dst_reached = 1;
-- 
1.7.5.4

