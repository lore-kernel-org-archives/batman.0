Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  7 Nov 2009 16:15:11 +0100
Message-Id: <1257606911-24933-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Prevent division by zero when no
	packets were send
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

We will try to print a statistic even when we receive a sigterm or
sigint before we send any data or started to count the send data. This
means that the we try to calculate the data loss by dividing through
zero as it is the number of send packets. This is not possible and we
must check for that corner case.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/ping.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/batctl/ping.c b/batctl/ping.c
index 684a84d..ca1fbf0 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -72,7 +72,7 @@ int ping(int argc, char **argv)
 	fd_set read_socket;
 	int ret = EXIT_FAILURE, ping_fd = 0, res, optchar, found_args = 1;
 	int loop_count = -1, loop_interval = 1, timeout = 1;
-	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0;
+	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
 	char *dst_string, *mac_string;
 	double time_delta;
 	float min = 0.0, max = 0.0, avg = 0.0;
@@ -237,9 +237,14 @@ sleep:
 
 	}
 
+	if (packets_out == 0)
+		packets_loss = 0;
+	else
+		packets_loss = ((packets_out - packets_in) * 100) / packets_out;
+
 	printf("--- %s ping statistics ---\n", dst_string);
 	printf("%d packets transmitted, %d received, %d%% packet loss\n",
-		packets_out, packets_in, (((packets_out - packets_in) * 100) / packets_out));
+		packets_out, packets_in, packets_loss);
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
 		min, (packets_in ? (avg / packets_in) : 0.000), max, (max - min));
 
-- 
1.6.5.2

