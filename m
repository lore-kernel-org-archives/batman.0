Return-Path: <post@tiwoc.de>
Message-ID: <4B79BDF7.7000204@tiwoc.de>
Date: Mon, 15 Feb 2010 22:34:47 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Record route for ICMP messages
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

The standard layer 3 ping utility can use the record route (RR) option
of IP to collect route data for sent ping messages (ping -R). This
patch introduces comparable functionality for batman-adv ICMP messages.

The patch adds a second batman ICMP packet format (icmp_packet_rr) such
that up to 17 MAC addresses can be recorded (sufficient for up to 8
hops per direction). When no RR is wanted, the old icmp_packet without
the RR overhead can be sent.

batctl is extended to recognize the -R option for the ping subcommand.
The output should be the same as for the standard iputils ping program.
For this, the destination host is printed two times.


Signed-off-by: Daniel Seither <post@tiwoc.de>
---
Index: batman-adv-kernelland/types.h
===================================================================
--- batman-adv-kernelland/types.h	(revision 1573)
+++ batman-adv-kernelland/types.h	(working copy)
@@ -106,7 +106,7 @@

 struct device_packet {
 	struct list_head list;
-	struct icmp_packet icmp_packet;
+	struct icmp_packet_rr icmp_packet;
 };

 struct hna_local_entry {
Index: batman-adv-kernelland/packet.h
===================================================================
--- batman-adv-kernelland/packet.h	(revision 1573)
+++ batman-adv-kernelland/packet.h	(working copy)
@@ -26,6 +26,7 @@
 #define BAT_UNICAST   0x03
 #define BAT_BCAST     0x04
 #define BAT_VIS       0x05
+#define BAT_ICMP_RR   0x06

 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 9
@@ -71,6 +72,23 @@
 	uint8_t  uid;
 } __attribute__((packed));

+#define BAT_RR_LEN 16
+
+/* icmp_packet_rr must start with all fields from imcp_packet
+   as this is assumed by code that handles ICMP packets */
+struct icmp_packet_rr {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  msg_type; /* see ICMP message types above */
+	uint8_t  ttl;
+	uint8_t  dst[6];
+	uint8_t  orig[6];
+	uint16_t seqno;
+	uint8_t  uid;
+	uint8_t  rr_cur;
+	uint8_t  rr[BAT_RR_LEN][ETH_ALEN];
+} __attribute__((packed));
+
 struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
Index: batman-adv-kernelland/device.c
===================================================================
--- batman-adv-kernelland/device.c	(revision 1573)
+++ batman-adv-kernelland/device.c	(working copy)
@@ -165,6 +165,7 @@
 	struct device_packet *device_packet;
 	int error;
 	unsigned long flags;
+	size_t packet_len = sizeof(struct icmp_packet);

 	if ((file->f_flags & O_NONBLOCK) && (device_client->queue_len == 0))
 		return -EAGAIN;
@@ -190,15 +191,18 @@

 	spin_unlock_irqrestore(&device_client->lock, flags);

+	if (device_packet->icmp_packet.packet_type == BAT_ICMP_RR)
+		packet_len = sizeof(struct icmp_packet_rr);
+
 	error = __copy_to_user(buf, &device_packet->icmp_packet,
-			       sizeof(struct icmp_packet));
+			       packet_len);

 	kfree(device_packet);

 	if (error)
 		return error;

-	return sizeof(struct icmp_packet);
+	return packet_len;
 }

 ssize_t bat_device_write(struct file *file, const char __user *buff,
@@ -206,28 +210,42 @@
 {
 	struct device_client *device_client =
 		(struct device_client *)file->private_data;
-	struct icmp_packet icmp_packet;
+	struct icmp_packet_rr icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 	unsigned long flags;
+	size_t packet_len = sizeof(struct icmp_packet);
+	int with_rr = 0;

 	if (len < sizeof(struct icmp_packet)) {
 		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
 		return -EINVAL;
 	}

-	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
+	if (len >= sizeof(struct icmp_packet_rr)) {
+		with_rr = 1;
+		packet_len = sizeof(struct icmp_packet_rr);
+	}
+
+	if (!access_ok(VERIFY_READ, buff, packet_len))
 		return -EFAULT;

-	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet)))
+	if (__copy_from_user(&icmp_packet, buff, packet_len))
 		return -EFAULT;

-	if (icmp_packet.packet_type != BAT_ICMP) {
-		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
+	if (icmp_packet.packet_type != BAT_ICMP
+		&& icmp_packet.packet_type != BAT_ICMP_RR) {
+		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP or BAT_ICMP_RR)\n");
 		return -EINVAL;
 	}

+	if (!with_rr && icmp_packet.packet_type == BAT_ICMP_RR) {
+		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from "
+			"char device: invalid packet size for BAT_ICMP_RR\n");
+		return -EINVAL;
+	}
+
 	if (icmp_packet.msg_type != ECHO_REQUEST) {
 		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
 		return -EINVAL;
@@ -269,8 +287,14 @@
 	       batman_if->net_dev->dev_addr,
 	       ETH_ALEN);

+	if (with_rr) {
+		memcpy(icmp_packet.rr,
+			   batman_if->net_dev->dev_addr,
+			   ETH_ALEN);
+	}
+
 	send_raw_packet((unsigned char *)&icmp_packet,
-			sizeof(struct icmp_packet),
+			packet_len,
 			batman_if, dstaddr);

 	goto out;
@@ -298,11 +322,15 @@
 }

 void bat_device_add_packet(struct device_client *device_client,
-			   struct icmp_packet *icmp_packet)
+			   struct icmp_packet_rr *icmp_packet)
 {
 	struct device_packet *device_packet;
 	unsigned long flags;
+	size_t packet_len = sizeof(struct icmp_packet);

+	if (icmp_packet->packet_type == BAT_ICMP_RR)
+		packet_len = sizeof(struct icmp_packet_rr);
+
 	device_packet = kmalloc(sizeof(struct device_packet), GFP_KERNEL);

 	if (!device_packet)
@@ -310,7 +338,7 @@

 	INIT_LIST_HEAD(&device_packet->list);
 	memcpy(&device_packet->icmp_packet, icmp_packet,
-	       sizeof(struct icmp_packet));
+	       packet_len);

 	spin_lock_irqsave(&device_client->lock, flags);

@@ -339,7 +367,7 @@
 	wake_up(&device_client->queue_wait);
 }

-void bat_device_receive_packet(struct icmp_packet *icmp_packet)
+void bat_device_receive_packet(struct icmp_packet_rr *icmp_packet)
 {
 	struct device_client *hash = device_client_hash[icmp_packet->uid];

Index: batman-adv-kernelland/device.h
===================================================================
--- batman-adv-kernelland/device.h	(revision 1573)
+++ batman-adv-kernelland/device.h	(working copy)
@@ -32,5 +32,5 @@
 			 size_t len, loff_t *off);
 unsigned int bat_device_poll(struct file *file, poll_table *wait);
 void bat_device_add_packet(struct device_client *device_client,
-			   struct icmp_packet *icmp_packet);
-void bat_device_receive_packet(struct icmp_packet *icmp_packet);
+			   struct icmp_packet_rr *icmp_packet);
+void bat_device_receive_packet(struct icmp_packet_rr *icmp_packet);
Index: batman-adv-kernelland/hard-interface.c
===================================================================
--- batman-adv-kernelland/hard-interface.c	(revision 1573)
+++ batman-adv-kernelland/hard-interface.c	(working copy)
@@ -479,6 +479,7 @@

 		/* batman icmp packet */
 	case BAT_ICMP:
+	case BAT_ICMP_RR:
 		ret = recv_icmp_packet(skb);
 		break;

Index: batman-adv-kernelland/routing.c
===================================================================
--- batman-adv-kernelland/routing.c	(revision 1573)
+++ batman-adv-kernelland/routing.c	(working copy)
@@ -709,15 +709,16 @@
 static int recv_my_icmp_packet(struct sk_buff *skb)
 {
 	struct orig_node *orig_node;
-	struct icmp_packet *icmp_packet;
+	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct sk_buff *skb_old;
 	struct batman_if *batman_if;
 	int ret;
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
+	int packet_len = sizeof(struct icmp_packet);

-	icmp_packet = (struct icmp_packet *) skb->data;
+	icmp_packet = (struct icmp_packet_rr *) skb->data;
 	ethhdr = (struct ethhdr *) skb_mac_header(skb);

 	/* add data to device queue */
@@ -726,6 +727,9 @@
 		return NET_RX_DROP;
 	}

+	if (icmp_packet->packet_type == BAT_ICMP_RR)
+		packet_len = sizeof(struct icmp_packet_rr);
+
 	/* answer echo request (ping) */
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
@@ -745,12 +749,12 @@

 		/* create a copy of the skb, if needed, to modify it. */
 		skb_old = NULL;
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, packet_len)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
+			icmp_packet = (struct icmp_packet_rr *) skb->data;
 			kfree_skb(skb_old);
 		}

@@ -778,6 +782,7 @@
 	int ret;
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
+	int len = sizeof(struct icmp_packet);

 	icmp_packet = (struct icmp_packet *)skb->data;
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -789,6 +794,9 @@
 		return NET_RX_DROP;
 	}

+	if (icmp_packet->packet_type == BAT_ICMP_RR)
+		len = sizeof(struct icmp_packet_rr);
+
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
@@ -806,7 +814,7 @@
 		spin_unlock_irqrestore(&orig_hash_lock, flags);

 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, len)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
@@ -832,7 +840,7 @@

 int recv_icmp_packet(struct sk_buff *skb)
 {
-	struct icmp_packet *icmp_packet;
+	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct orig_node *orig_node;
 	struct sk_buff *skb_old;
@@ -860,8 +868,23 @@
 	if (!is_my_mac(ethhdr->h_dest))
 		return NET_RX_DROP;

-	icmp_packet = (struct icmp_packet *) skb->data;
+	icmp_packet = (struct icmp_packet_rr *) skb->data;

+	if (icmp_packet->packet_type == BAT_ICMP_RR) {
+		hdr_size = sizeof(struct icmp_packet_rr);
+
+		/* drop packet if it has not necessary minimum size */
+		if (skb_headlen(skb) < hdr_size)
+			return NET_RX_DROP;
+
+		/* add record route information if not full */
+		if (icmp_packet->rr_cur < BAT_RR_LEN) {
+			memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
+				ethhdr->h_dest, ETH_ALEN);
+			icmp_packet->rr_cur++;
+		}
+	}
+
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
 		return recv_my_icmp_packet(skb);
@@ -888,12 +911,12 @@
 		spin_unlock_irqrestore(&orig_hash_lock, flags);

 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, hdr_size)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
+			icmp_packet = (struct icmp_packet_rr *) skb->data;
 			kfree_skb(skb_old);
 		}

Index: batctl/ping.c
===================================================================
--- batctl/ping.c	(revision 1573)
+++ batctl/ping.c	(working copy)
@@ -48,6 +48,7 @@
 	printf(" \t -h print this help\n");
 	printf(" \t -i interval in seconds\n");
 	printf(" \t -t timeout in seconds\n");
+	printf(" \t -R record route\n");
 }

 void sig_handler(int sig)
@@ -64,20 +65,22 @@

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
@@ -100,6 +103,10 @@
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
@@ -141,6 +148,8 @@
 		goto out;
 	}

+	packet_len = sizeof(struct icmp_packet);
+
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.packet_type = BAT_ICMP;
 	icmp_packet_out.version = COMPAT_VERSION;
@@ -148,8 +157,15 @@
 	icmp_packet_out.ttl = 50;
 	icmp_packet_out.seqno = 0;

+	if (rr) {
+		icmp_packet_out.packet_type = BAT_ICMP_RR;
+		packet_len = sizeof(struct icmp_packet_rr);
+		icmp_packet_out.rr_cur = 1;
+		memset(&icmp_packet_out.rr, 0, BAT_RR_LEN * ETH_ALEN);
+	}
+
 	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
-		sizeof(icmp_packet_out), sizeof(icmp_packet_out) + 28);
+		packet_len, packet_len + 28);

 	while (!is_aborted) {
 		if (loop_count == 0)
@@ -160,7 +176,7 @@

 		icmp_packet_out.seqno = htons(++seq_counter);

-		if (write(ping_fd, (char *)&icmp_packet_out, sizeof(icmp_packet_out)) < 0) {
+		if (write(ping_fd, (char *)&icmp_packet_out, packet_len) < 0) {
 			printf("Error - can't write to batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
 			goto sleep;
 		}
@@ -188,26 +204,55 @@
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

+			if (icmp_packet_in.packet_type == BAT_ICMP_RR) {
+				if (last_rr_cur == icmp_packet_in.rr_cur
+					&& !memcmp(last_rr, icmp_packet_in.rr, BAT_RR_LEN * ETH_ALEN)) {
+
+					printf("\t(same route)\n");
+
+				} else {
+					printf("\nRR: ");
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
+						if (memcmp(rr_mac, dst_mac, ETH_ALEN) == 0)
+							printf("\t%s\n", rr_string);
+					}
+					printf("\n");
+
+					last_rr_cur = icmp_packet_in.rr_cur;
+					memcpy(last_rr, icmp_packet_in.rr, BAT_RR_LEN * ETH_ALEN);
+				}
+			} else
+				printf("\n");
+
 			if ((time_delta < min) || (min == 0.0))
 				min = time_delta;
 			if (time_delta > max)
