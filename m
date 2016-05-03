Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue,  3 May 2016 11:01:30 +0200
Message-Id: <1462266090-13609-1-git-send-email-sven@open-mesh.com>
In-Reply-To: <1894217.a7ufKNXfSr@bentobox>
References: <1894217.a7ufKNXfSr@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3] batctl: introduce throughput meter support
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>, Antonio Quartulli <antonio.quartulli@open-mesh.com>

From: Antonio Quartulli <antonio.quartulli@open-mesh.com>

Add command to launch the throughput meter test. The throughput meter is a
batman kernelspace tool for throughput measurements. The syntax is:

    batctl tp <MAC>

The test is interruptible with SIGINT or SIGTERM; if the test succeeds with
no error the throughput and the elapsed time are printed to stdout,
otherwise occurred an error message is displayed (on stdout) accordingly.

Based on a prototype from Edo Monticelli <montik@autistici.org>

Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v3:
 - Rebase on current master version
 - check test_time for non-0 to avoid floating point exception during
   division
v2:
 - Rebase on current master version
---
 Makefile     |   2 +-
 main.c       |   6 ++
 main.h       |   1 +
 man/batctl.8 |  24 +++++-
 packet.h     | 120 ++++++++++++++++++++++++++++++
 tcpdump.c    |  14 +++-
 tp_meter.c   | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tp_meter.h   |  22 ++++++
 8 files changed, 421 insertions(+), 4 deletions(-)
 create mode 100644 tp_meter.c
 create mode 100644 tp_meter.h

diff --git a/Makefile b/Makefile
index b82c0c6..7cfe851 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o tp_meter.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/main.c b/main.c
index a2cda5b..5e1ecc7 100644
--- a/main.c
+++ b/main.c
@@ -33,6 +33,7 @@
 #include "translate.h"
 #include "traceroute.h"
 #include "tcpdump.h"
+#include "tp_meter.h"
 #include "bisect_iv.h"
 #include "ioctl.h"
 #include "functions.h"
@@ -82,6 +83,7 @@ static void print_usage(void)
 	fprintf(stderr, " \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	fprintf(stderr, " \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	fprintf(stderr, " \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \tthroughputmeter|tp         <destination>     \tstart a throughput measurement\n");
 	fprintf(stderr, " \ttranslate|t                <destination>     \ttranslate a destination to the originator responsible for it\n");
 #ifdef BATCTL_BISECT
 	fprintf(stderr, " \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
@@ -162,6 +164,10 @@ int main(int argc, char **argv)
 
 		ret = ping(mesh_iface, argc - 1, argv + 1);
 
+	} else if ((strcmp(argv[1], "throughputmeter") == 0) || (strcmp(argv[1], "tp") == 0)) {
+
+		ret = tp_meter (mesh_iface, argc -1, argv + 1);
+
 	} else if ((strcmp(argv[1], "traceroute") == 0) || (strcmp(argv[1], "tr") == 0)) {
 
 		ret = traceroute(mesh_iface, argc - 1, argv + 1);
diff --git a/main.h b/main.h
index e94fc33..36e28cd 100644
--- a/main.h
+++ b/main.h
@@ -51,6 +51,7 @@
 
 typedef uint8_t u8; /* linux kernel compat */
 typedef uint16_t u16; /* linux kernel compat */
+typedef uint32_t u32; /* linux kernel compat */
 
 extern char module_ver_path[];
 
diff --git a/man/batctl.8 b/man/batctl.8
index e804a08..69a2537 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -36,9 +36,11 @@ B.A.T.M.A.N. advanced operates on layer 2. Thus all hosts participating in the v
 connected together for all protocols above layer 2. Therefore the common diagnosis tools do not work as expected. To
 overcome these problems batctl contains the commands \fBping\fP, \fBtraceroute\fP, \fBtcpdump\fP which provide similar
 functionality to the normal \fBping\fP(1), \fBtraceroute\fP(1), \fBtcpdump\fP(1) commands, but modified to layer 2
-behaviour or using the B.A.T.M.A.N. advanced protocol.
-.PP
+behaviour or using the B.A.T.M.A.N. advanced protocol. For similar reasons, \fBthroughputmeter\fP, a command to test network
+performances, is also included.
+
 .PP
+.Pp
 .SH OPTIONS
 .TP
 .I \fBoptions:
@@ -319,6 +321,24 @@ for routing loops. Use "\-t" to trace OGMs of a host throughout the network. Use
 nodes. The option "\-s" can be used to limit the output to a range of sequence numbers, between min and max, or to one
 specific sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is
 given batctl will not replace the MAC addresses with bat\-host names in the output.
+.RE
+.br
+.IP "\fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP"
+This command starts a throughput test entirely controlled by batman module in
+kernel space: the computational resources needed to align memory and copy data
+between user and kernel space that are required by other user space tools may
+represent a bootleneck on some low profile device.
+
+The test consist of the transfer of 14 MB of data between the two nodes. The
+protocol used to transfer the data is somehow similar to TCP, but simpler: some
+TCP features are still missing, thus protocol performances could be worst. Since
+a fixed amount of data is transferred the experiment duration depends on the
+network conditions. The experiment can be interrupted with CTRL + C. At the end
+of a succesful experiment the throughput in KBytes per second is returned,
+togheter with the experiment duration in millisecond and the amount of bytes
+transferred. If too many packets are lost or the specified MAC address is not
+reachable, a message notifing the error is returned instead of the result.
+.RE
 .br
 .SH FILES
 .TP
diff --git a/packet.h b/packet.h
index 372128d..ed3224c 100644
--- a/packet.h
+++ b/packet.h
@@ -21,6 +21,8 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 
+#define batadv_tp_is_error(n) ((u8)n > 127 ? 1 : 0)
+
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
  * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
@@ -93,6 +95,7 @@ enum batadv_icmp_packettype {
 	BATADV_ECHO_REQUEST	       = 8,
 	BATADV_TTL_EXCEEDED	       = 11,
 	BATADV_PARAMETER_PROBLEM       = 12,
+	BATADV_TP		       = 15,
 };
 
 /**
@@ -285,6 +288,31 @@ struct batadv_elp_packet {
 #define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
 
 /**
+ * struct batadv_icmp_user_packet - used to start an ICMP operation from
+ *  userspace
+ * @dst: destination node
+ * @version: compat version used by userspace
+ * @cmd_type: the command to start
+ * @arg1: possible argument for the command
+ */
+struct batadv_icmp_user_packet {
+	u8 dst[ETH_ALEN];
+	u8 version;
+	u8 cmd_type;
+	u32 arg1;
+};
+
+/**
+ * enum batadv_icmp_user_cmd_type - types for batman-adv icmp cmd modes
+ * @BATADV_TP_START: start a throughput meter run
+ * @BATADV_TP_STOP: stop a throughput meter run
+ */
+enum batadv_icmp_user_cmd_type {
+	BATADV_TP_START		= 0,
+	BATADV_TP_STOP		= 2,
+};
+
+/**
  * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
@@ -334,6 +362,98 @@ struct batadv_icmp_packet {
 	__be16 seqno;
 };
 
+/**
+ * struct batadv_icmp_tp_packet - ICMP TP Meter packet
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the genereal header
+ * @ttl: time to live for this packet, part of the genereal header
+ * @msg_type: ICMP packet type
+ * @dst: address of the destination node
+ * @orig: address of the source node
+ * @uid: local ICMP socket identifier
+ * @subtype: TP packet subtype (see batadv_icmp_tp_subtype)
+ * @session: TP session identifier
+ * @seqno: the TP sequence number
+ * @timestamp: time when the packet has been sent. This value is filled in a
+ *  TP_MSG and echoed back in the next TP_ACK so that the sender can compute the
+ *  RTT. Since it is read only by the host which wrote it, there is no need to
+ *  store it using network order
+ */
+struct batadv_icmp_tp_packet {
+	u8  packet_type;
+	u8  version;
+	u8  ttl;
+	u8  msg_type; /* see ICMP message types above */
+	u8  dst[ETH_ALEN];
+	u8  orig[ETH_ALEN];
+	u8  uid;
+	u8  subtype;
+	u8  session[2];
+	__be32 seqno;
+	__be32 timestamp;
+};
+
+/**
+ * enum batadv_icmp_tp_subtype - ICMP TP Meter packet subtypes
+ * @BATADV_TP_MSG: Msg from sender to receiver
+ * @BATADV_TP_ACK: acknowledgment from receiver to sender
+ */
+enum batadv_icmp_tp_subtype {
+	BATADV_TP_MSG	= 0,
+	BATADV_TP_ACK,
+};
+
+/**
+ * struct batadv_icmp_tp_result_packet - tp response returned to batctl
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the genereal header
+ * @ttl: time to live for this packet, part of the genereal header
+ * @msg_type: ICMP packet type
+ * @dst: address of the destination node
+ * @orig: address of the source node
+ * @uid: local ICMP socket identifier
+ * @reserved: not used - useful for alignment
+ * @return_value: result of run (see batadv_tp_meter_status)
+ * @test_time: time (msec) the run took
+ * @total_bytes: amount of acked bytes during run
+ */
+struct batadv_icmp_tp_result_packet {
+	u8  packet_type;
+	u8  version;
+	u8  ttl;
+	u8  msg_type; /* see ICMP message types above */
+	u8  dst[ETH_ALEN];
+	u8  orig[ETH_ALEN];
+	u8  uid;
+	u8  reserved[2];
+	u8  return_value;
+	u32 test_time;
+	u32 total_bytes;
+};
+
+/**
+ * enum batadv_tp_meter_reason - reason of a a tp meter test run stop
+ * @BATADV_TP_COMPLETE: sender finished tp run
+ * @BATADV_TP_SIGINT: sender was stopped during run
+ * @BATADV_TP_DST_UNREACHABLE: receiver could not be reached or didn't answer
+ * @BATADV_TP_RESEND_LIMIT: (unused) sender retry reached limit
+ * @BATADV_TP_ALREADY_ONGOING: test to or from the same node already ongoing
+ * @BATADV_TP_MEMORY_ERROR: test was stopped due to low memory
+ * @BATADV_TP_CANT_SEND: failed to send via outgoing interface
+ * @BATADV_TP_TOO_MANY: too many ongoing sessions
+ */
+enum batadv_tp_meter_reason {
+	BATADV_TP_COMPLETE		= 3,
+	BATADV_TP_SIGINT		= 4,
+	/* error status >= 128 */
+	BATADV_TP_DST_UNREACHABLE	= 128,
+	BATADV_TP_RESEND_LIMIT		= 129,
+	BATADV_TP_ALREADY_ONGOING	= 130,
+	BATADV_TP_MEMORY_ERROR		= 131,
+	BATADV_TP_CANT_SEND		= 132,
+	BATADV_TP_TOO_MANY		= 133,
+};
+
 #define BATADV_RR_LEN 16
 
 /**
diff --git a/tcpdump.c b/tcpdump.c
index 363e9e4..be0c4f0 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -808,11 +808,14 @@ static void dump_batman_elp(unsigned char *packet_buff, ssize_t buff_len,
 static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct batadv_icmp_packet *icmp_packet;
+	struct batadv_icmp_tp_packet *tp;
+
 	char *name;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_icmp_packet), "BAT ICMP");
 
 	icmp_packet = (struct batadv_icmp_packet *)(packet_buff + sizeof(struct ether_header));
+	tp = (struct batadv_icmp_tp_packet *)icmp_packet;
 
 	if (!time_printed)
 		print_time();
@@ -820,7 +823,8 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)icmp_packet->orig, read_opt));
 
-	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst, read_opt);
+	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst,
+				    read_opt);
 
 	switch (icmp_packet->msg_type) {
 	case BATADV_ECHO_REPLY:
@@ -841,6 +845,14 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 			icmp_packet->ttl, icmp_packet->version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
+	case BATADV_TP:
+		printf("%s: ICMP TP type %s (%hhu), id %hhu, seq %u, ttl %2d, v %d, length %zu\n",
+		       name, tp->subtype == BATADV_TP_MSG ? "MSG" :
+			     tp->subtype == BATADV_TP_ACK ? "ACK" : "N/A",
+		       tp->subtype, tp->uid, ntohl(tp->seqno), tp->ttl,
+		       tp->version,
+		       (size_t)buff_len - sizeof(struct ether_header));
+		break;
 	default:
 		printf("%s: ICMP type %hhu, length %zu\n",
 			name, icmp_packet->msg_type,
diff --git a/tp_meter.c b/tp_meter.c
new file mode 100644
index 0000000..9b3d861
--- /dev/null
+++ b/tp_meter.c
@@ -0,0 +1,236 @@
+/*
+ * Copyright (C) 2013-2016 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli <a@unstable.cc>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include <netinet/ether.h>
+#include <netinet/in.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "main.h"
+#include "functions.h"
+#include "packet.h"
+#include "bat-hosts.h"
+#include "debugfs.h"
+
+struct ether_addr *dst_mac;
+int tp_fd = -1;
+
+void tp_sig_handler(int sig)
+{
+	int write_bytes;
+	struct batadv_icmp_user_packet icmp;
+
+	switch (sig) {
+	case SIGINT:
+	case SIGTERM:
+		fflush(stdout);
+		memcpy(&icmp.dst, dst_mac, ETH_ALEN);
+		icmp.version = BATADV_COMPAT_VERSION;
+		icmp.cmd_type = BATADV_TP_STOP;
+
+		write_bytes = write(tp_fd, &icmp, sizeof(icmp));
+		if (write_bytes < 0) {
+			printf("sig_handler can't write to fd for %d, %s\n",
+			       write_bytes, strerror(write_bytes));
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void tp_meter_usage(void)
+{
+	fprintf(stderr, "Usage: batctl tp [parameters] <MAC>\n");
+	fprintf(stderr, "Parameters:\n");
+	fprintf(stderr, "\t -t <time> test length in milliseconds\n");
+	fprintf(stderr, "\t -n don't convert addresses to bat-host names\n");
+}
+
+int tp_meter(char *mesh_iface, int argc, char **argv)
+{
+	struct batadv_icmp_user_packet icmp;
+	struct batadv_icmp_tp_result_packet result;
+	struct bat_host *bat_host;
+	fd_set read_socket;
+	unsigned long int throughput;
+	char *dst_string;
+	int ret = EXIT_FAILURE;
+	int write_error;
+	int found_args = 1, read_opt = USE_BAT_HOSTS;
+	char optchar, *debugfs_mnt;
+	char icmp_socket[MAX_PATH+1];
+	uint32_t time = 0;
+
+	while ((optchar = getopt(argc, argv, "t:n")) != -1) {
+		switch (optchar) {
+		case 't':
+			found_args += 2;
+			time = strtoul(optarg, NULL, 10);
+			break;
+		case 'n':
+			read_opt &= ~USE_BAT_HOSTS;
+			found_args += 1;
+			break;
+		default:
+			tp_meter_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (argc <= found_args) {
+		tp_meter_usage();
+		return EXIT_FAILURE;
+	}
+
+	signal(SIGINT, tp_sig_handler);
+	signal(SIGTERM, tp_sig_handler);
+
+	dst_string = argv[found_args];
+	bat_hosts_init(read_opt);
+	bat_host = bat_hosts_find_by_name(dst_string);
+
+	if (bat_host)
+		dst_mac = &bat_host->mac_addr;
+
+	if (!dst_mac) {
+		dst_mac = ether_aton(dst_string);
+
+		if (!dst_mac) {
+			printf("Error - the tp meter destination is not a mac address or bat-host name: %s\n",
+			       dst_string);
+			goto out;
+		}
+	}
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		printf("Error - can't mount or find debugfs\n");
+		goto out;
+	}
+
+	debugfs_make_path(SOCKET_PATH_FMT, mesh_iface, icmp_socket,
+			  sizeof(icmp_socket));
+
+	tp_fd = open(icmp_socket, O_RDWR);
+
+	if (tp_fd < 0) {
+		printf("Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
+		       icmp_socket, strerror(errno));
+		printf("Check whether the module is loaded and active.\n");
+		goto out;
+	}
+
+	memcpy(&icmp.dst, dst_mac, ETH_ALEN);
+	icmp.version = BATADV_COMPAT_VERSION;
+	icmp.cmd_type = BATADV_TP_START;
+	icmp.arg1 = time;
+
+	if (bat_host && (read_opt & USE_BAT_HOSTS))
+		dst_string = bat_host->name;
+	else
+		dst_string = ether_ntoa_long(dst_mac);
+
+	printf("Throughput meter called towards %s\n", dst_string);
+
+	write_error = write(tp_fd, &icmp, sizeof(icmp));
+	if (write_error < 0) {
+		printf("Can't write to fd for %s. %d, %s\n", icmp_socket,
+		       write_error, strerror(write_error));
+		goto out;
+	}
+
+	FD_ZERO(&read_socket);
+	FD_SET(tp_fd, &read_socket);
+
+	select(tp_fd + 1, &read_socket, NULL, NULL, NULL);
+	/* a size icmp_packet_rr is read, because that is written
+	 * kernel function only handles such structure
+	  */
+	if (read(tp_fd, &result, sizeof(result))) {
+		switch (result.return_value) {
+		case BATADV_TP_DST_UNREACHABLE:
+			fprintf(stderr, "Destination unreachable\n");
+			break;
+		case BATADV_TP_RESEND_LIMIT:
+			fprintf(stderr,
+				"The number of retry for the same window exceeds the limit, test aborted\n");
+			break;
+		case BATADV_TP_ALREADY_ONGOING:
+			fprintf(stderr,
+				"Cannot run two test towards the same node\n");
+			break;
+		case BATADV_TP_MEMORY_ERROR:
+			fprintf(stderr,
+				"Kernel cannot allocate memory, aborted\n");
+			break;
+		case BATADV_TP_TOO_MANY:
+			fprintf(stderr, "Too many ongoing sessions\n");
+			break;
+		case BATADV_TP_SIGINT:
+			printf("SIGINT received: test aborted\n");
+			/* fall through and print the partial result */
+		case BATADV_TP_COMPLETE:
+			if (result.test_time > 0) {
+				throughput = result.total_bytes * 1000;
+				throughput /= result.test_time;
+			} else {
+				throughput = ULLONG_MAX;
+			}
+
+			printf("Test duration %ums.\n", result.test_time);
+			printf("Sent %u Bytes.\n", result.total_bytes);
+			printf("Throughput: ");
+			if (throughput == ULLONG_MAX)
+				printf("inf\n");
+			else if (throughput > (1UL<<30))
+				printf("%.2f GB/s (%2.f Gbps)\n",
+				       (float)throughput / (1<<30),
+				       (float)throughput * 8 / 1000000000);
+			else if (throughput > (1UL<<20))
+				printf("%.2f MB/s (%.2f Mbps)\n",
+				       (float)throughput / (1<<20),
+				       (float)throughput * 8 / 1000000);
+			else if (throughput > (1UL<<10))
+				printf("%.2f KB/s (%.2f Kbps)\n",
+				       (float)throughput / (1<<10),
+				       (float)throughput * 8 / 1000);
+			else
+				printf("%lu Bytes/s (%lu Bps)\n",
+				       throughput, throughput * 8);
+			break;
+		default:
+			printf("Unrecognized return value %d\n", result.return_value);
+		}
+	}
+out:
+	bat_hosts_free();
+	if (tp_fd)
+		close(tp_fd);
+	return ret;
+}
diff --git a/tp_meter.h b/tp_meter.h
new file mode 100644
index 0000000..59bca07
--- /dev/null
+++ b/tp_meter.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2013-2016 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli <a@unstable.cc>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+int tp_meter(char *mesh_iface, int argc, char **argv);
-- 
2.8.1

