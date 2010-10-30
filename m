Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 17:00:54 +0200
Message-Id: <1288450858-14753-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batctl: Don't print uninitialised
	traceroute times
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

The time_delta array is only initialised when no error occurs or only
the select fails. This means that we may print uninitialised or output
from previous ttl levels.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/traceroute.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index 0dc796a..f80ca4d 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -135,6 +135,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 
 		for (i = 0; i < NUM_PACKETS; i++) {
 			icmp_packet_out.seqno = htons(++seq_counter);
+			time_delta[i] = 0.0;
 
 			if (write(trace_fd, (char *)&icmp_packet_out, sizeof(icmp_packet_out)) < 0) {
 				printf("Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
@@ -151,10 +152,8 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 
 			res = select(trace_fd + 1, &read_socket, NULL, NULL, &tv);
 
-			if (res <= 0) {
-				time_delta[i] = 0.0;
+			if (res <= 0)
 				continue;
-			}
 
 			read_len = read(trace_fd, (char *)&icmp_packet_in, sizeof(icmp_packet_in));
 
-- 
1.7.2.3

