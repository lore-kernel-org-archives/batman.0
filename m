Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Feb 2010 18:30:24 +0800
Message-Id: <1266316224-32338-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1266316224-32338-1-git-send-email-lindner_marek@yahoo.de>
References: <201002161829.19535.lindner_marek@yahoo.de>
	<1266316224-32338-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: record route for ICMP messages
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

batctl is extended to recognize the -R option for the ping subcommand.
The output should be the same as for the standard iputils ping program.
For this, the destination host is printed twice.

Signed-off-by: Daniel Seither <post@tiwoc.de>
---
 batctl/ping.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/batctl/ping.c b/batctl/ping.c
index c14141c..0352870 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
@@ -48,6 +48,7 @@ void ping_usage(void)
 	printf(" \t -h print this help\n");
 	printf(" \t -i interval in seconds\n");
 	printf(" \t -t timeout in seconds\n");
+	printf(" \t -R record route\n");
 }
 
 void sig_handler(int sig)
@@ -64,20 +65,22 @@ void sig_handler(int sig)
 
 int ping(int argc, char **argv)
 {
-	struct icmp_packet icmp_packet_out, icmp_packet_in;
+	struct icmp_packet_rr icmp_packet_out, icmp_packet_in;
 	struct timeval tv;
-	struct ether_addr *dst_mac = NULL;
-	struct bat_host *bat_host;
+	struct ether_addr *dst_mac = NULL, *rr_mac = NULL;
+	struct bat_host *bat_host, *rr_host;
 	ssize_t read_len;
 	fd_set read_socket;
 	int ret = EXIT_FAILURE, ping_fd = 0, res, optchar, found_args = 1;
-	int loop_count = -1, loop_interval = 1, timeout = 1;
+	int loop_count = -1, loop_interval = 1, timeout = 1, rr = 0, i;
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
-	char *dst_string, *mac_string;
+	char *dst_string, *mac_string, *rr_string;
 	double time_delta;
 	float min = 0.0, max = 0.0, avg = 0.0;
+	uint8_t last_rr_cur = 0, last_rr[BAT_RR_LEN][ETH_ALEN];
+	size_t packet_len;
 
-	while ((optchar = getopt(argc, argv, "hc:i:t:")) != -1) {
+	while ((optchar = getopt(argc, argv, "hc:i:t:R")) != -1) {
 		switch (optchar) {
 		case 'c':
 			loop_count = strtol(optarg, NULL , 10);
@@ -100,6 +103,10 @@ int ping(int argc, char **argv)
 				timeout = 1;
 			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
 			break;
+		case 'R':
+			rr = 1;
+			found_args++;
+			break;
 		default:
 			ping_usage();
 			return EXIT_FAILURE;
@@ -141,6 +148,8 @@ int ping(int argc, char **argv)
 		goto out;
 	}
 
+	packet_len = sizeof(struct icmp_packet);
+
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.packet_type = BAT_ICMP;
 	icmp_packet_out.version = COMPAT_VERSION;
@@ -148,8 +157,15 @@ int ping(int argc, char **argv)
 	icmp_packet_out.ttl = 50;
 	icmp_packet_out.seqno = 0;
 
+	if (rr) {
+		packet_len = sizeof(struct icmp_packet_rr);
+		icmp_packet_out.rr_cur = 1;
+		memset(&icmp_packet_out.rr, 0, BAT_RR_LEN * ETH_ALEN);
+		memset(last_rr, 0, BAT_RR_LEN * ETH_ALEN);
+	}
+
 	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
-		sizeof(icmp_packet_out), sizeof(icmp_packet_out) + 28);
+		packet_len, packet_len + 28);
 
 	while (!is_aborted) {
 		if (loop_count == 0)
@@ -160,7 +176,7 @@ int ping(int argc, char **argv)
 
 		icmp_packet_out.seqno = htons(++seq_counter);
 
-		if (write(ping_fd, (char *)&icmp_packet_out, sizeof(icmp_packet_out)) < 0) {
+		if (write(ping_fd, (char *)&icmp_packet_out, packet_len) < 0) {
 			printf("Error - can't write to batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
 			goto sleep;
 		}
@@ -188,26 +204,57 @@ int ping(int argc, char **argv)
 		if (res < 0)
 			goto sleep;
 
-		read_len = read(ping_fd, (char *)&icmp_packet_in, sizeof(icmp_packet_in));
+		read_len = read(ping_fd, (char *)&icmp_packet_in, packet_len);
 
 		if (read_len < 0) {
 			printf("Error - can't read from batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
 			goto sleep;
 		}
 
-		if ((size_t)read_len < sizeof(icmp_packet_in)) {
+		if ((size_t)read_len < packet_len) {
 			printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
-				sizeof(icmp_packet_in), read_len);
+				packet_len, read_len);
 			goto sleep;
 		}
 
 		switch (icmp_packet_in.msg_type) {
 		case ECHO_REPLY:
 			time_delta = end_timer();
-			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms\n",
+			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
 					icmp_packet_in.ttl, time_delta);
 
+			if (read_len == sizeof(struct icmp_packet_rr)) {
+				if (last_rr_cur == icmp_packet_in.rr_cur
+					&& !memcmp(last_rr, icmp_packet_in.rr, BAT_RR_LEN * ETH_ALEN)) {
+
+					printf("\t(same route)");
+
+				} else {
+					printf("\nRR: ");
+
+					for (i = 0; i < BAT_RR_LEN
+						&& i < icmp_packet_in.rr_cur; i++) {
+
+						rr_mac = (struct ether_addr *)&icmp_packet_in.rr[i];
+						rr_host = bat_hosts_find_by_mac((char *)rr_mac);
+						if (rr_host)
+							rr_string = rr_host->name;
+						else
+							rr_string = ether_ntoa_long(rr_mac);
+						printf("\t%s\n", rr_string);
+
+						if (memcmp(rr_mac, dst_mac, ETH_ALEN) == 0)
+							printf("\t%s\n", rr_string);
+					}
+
+					last_rr_cur = icmp_packet_in.rr_cur;
+					memcpy(last_rr, icmp_packet_in.rr, BAT_RR_LEN * ETH_ALEN);
+				}
+			}
+
+			printf("\n");
+
 			if ((time_delta < min) || (min == 0.0))
 				min = time_delta;
 			if (time_delta > max)
-- 
1.6.6.2

