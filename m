Return-Path: <post@tiwoc.de>
Message-ID: <4B759F67.5090407@tiwoc.de>
Date: Fri, 12 Feb 2010 19:35:19 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Record route for ICMP messages
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

The standard layer 3 ping utility can use the record route option of IP
to collect route data for sent ping messages (ping -R). This patch
introduces comparable functionality for batman-adv ICMP messages.

The patch modifies the batman ICMP packet format such that up to 17 MAC
addresses can be recorded (sufficient for up to 8 hops per direction).
batctl is extended to recognize the -R option for the ping subcommand.
The output should be the same as for the standard iputils ping program.
For this, the destination host is printed two times.

In device.c, the sender's MAC address is inserted at the first position
when receiving a ping message from batctl and RR is enabled (rr_cur >
0). In routing.c, each forwarding node then appends its own MAC address.

This patch could be improved by dynamically growing the packet when a
MAC address is to be added to the recorded route instead of statically
allocating a buffer of fixed length.


Signed-off-by: Daniel Seither <post@tiwoc.de>
---
Index: batman-adv-kernelland/packet.h
===================================================================
--- batman-adv-kernelland/packet.h	(revision 1568)
+++ batman-adv-kernelland/packet.h	(working copy)
@@ -60,6 +60,8 @@

 #define BAT_PACKET_LEN sizeof(struct batman_packet)

+#define BAT_RR_LEN 96
+
 struct icmp_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
@@ -69,6 +71,8 @@
 	uint8_t  orig[6];
 	uint16_t seqno;
 	uint8_t  uid;
+	uint8_t  rr_cur;
+	uint8_t  rr[BAT_RR_LEN];
 } __attribute__((packed));

 struct unicast_packet {
Index: batman-adv-kernelland/device.c
===================================================================
--- batman-adv-kernelland/device.c	(revision 1568)
+++ batman-adv-kernelland/device.c	(working copy)
@@ -268,6 +268,12 @@
 	memcpy(icmp_packet.orig,
 	       batman_if->net_dev->dev_addr,
 	       ETH_ALEN);
+	
+	if (icmp_packet.rr_cur) {
+		memcpy(icmp_packet.rr,
+			   batman_if->net_dev->dev_addr,
+			   ETH_ALEN);
+	}

 	send_raw_packet((unsigned char *)&icmp_packet,
 			sizeof(struct icmp_packet),
Index: batman-adv-kernelland/routing.c
===================================================================
--- batman-adv-kernelland/routing.c	(revision 1568)
+++ batman-adv-kernelland/routing.c	(working copy)
@@ -862,6 +862,12 @@

 	icmp_packet = (struct icmp_packet *) skb->data;

+	/* add record route information if not full */
+	if (icmp_packet->rr_cur && icmp_packet->rr_cur < BAT_RR_LEN / ETH_ALEN) {
+		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur * ETH_ALEN]),
ethhdr->h_dest, ETH_ALEN);
+		icmp_packet->rr_cur++;
+	}
+
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
 		return recv_my_icmp_packet(skb);
Index: batctl/ping.c
===================================================================
--- batctl/ping.c	(revision 1568)
+++ batctl/ping.c	(working copy)
@@ -48,6 +48,7 @@
 	printf(" \t -h print this help\n");
 	printf(" \t -i interval in seconds\n");
 	printf(" \t -t timeout in seconds\n");
+	printf(" \t -R record route\n");
 }

 void sig_handler(int sig)
@@ -66,18 +67,19 @@
 {
 	struct icmp_packet icmp_packet_out, icmp_packet_in;
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
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0,
packets_loss;
-	char *dst_string, *mac_string;
+	char *dst_string, *mac_string, *rr_string;
 	double time_delta;
 	float min = 0.0, max = 0.0, avg = 0.0;
+	uint8_t last_rr_cur = 0, last_rr[BAT_RR_LEN];

-	while ((optchar = getopt(argc, argv, "hc:i:t:")) != -1) {
+	while ((optchar = getopt(argc, argv, "hc:i:t:R")) != -1) {
 		switch (optchar) {
 		case 'c':
 			loop_count = strtol(optarg, NULL , 10);
@@ -100,6 +102,10 @@
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
@@ -147,6 +153,8 @@
 	icmp_packet_out.msg_type = ECHO_REQUEST;
 	icmp_packet_out.ttl = 50;
 	icmp_packet_out.seqno = 0;
+	icmp_packet_out.rr_cur = (rr) ? 1 : 0;
+	memset(&icmp_packet_out.rr, 0, BAT_RR_LEN);

 	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
 		sizeof(icmp_packet_out), sizeof(icmp_packet_out) + 28);
@@ -204,10 +212,34 @@
 		switch (icmp_packet_in.msg_type) {
 		case ECHO_REPLY:
 			time_delta = end_timer();
-			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms\n",
+			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
 					icmp_packet_in.ttl, time_delta);

+			if (icmp_packet_in.rr_cur) {
+				if (last_rr_cur == icmp_packet_in.rr_cur && !memcmp(last_rr,
icmp_packet_in.rr, BAT_RR_LEN)) {
+					printf("\t(same route)\n");
+				} else {
+					printf("\nRR: ");
+					for (i = 0; i < BAT_RR_LEN/ETH_ALEN && i < icmp_packet_in.rr_cur;
i++) {
+						rr_mac = (struct ether_addr *)&icmp_packet_in.rr[i*ETH_ALEN];
+						rr_host = bat_hosts_find_by_mac((char *)rr_mac);
+						if (rr_host)
+							rr_string = rr_host->name;
+						else
+							rr_string = ether_ntoa_long(rr_mac);
+						printf("\t%s\n", rr_string);
+						if (memcmp(rr_mac, dst_mac, ETH_ALEN) == 0)
+							printf("\t%s\n", rr_string);
+					}
+					printf("\n");
+				
+					last_rr_cur = icmp_packet_in.rr_cur;
+					memcpy(last_rr, icmp_packet_in.rr, BAT_RR_LEN);
+				}
+			} else
+				printf("\n");
+
 			if ((time_delta < min) || (min == 0.0))
 				min = time_delta;
 			if (time_delta > max)
