Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu, 23 Aug 2012 15:42:50 +0200
Message-Id: <1345729370-13614-2-git-send-email-montik@autistici.org>
In-Reply-To: <1345729370-13614-1-git-send-email-montik@autistici.org>
References: <1345729370-13614-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: introduced support for bandwidth
	meter
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

From: montik <montik@autistici.org>

Added the possibility to launch the bandwidth meter test. Bandwidth meter is a
batman kernel space tool for bandwidth measurements. The syntax is:

batctl bw <MAC>

The test is interruptable with SIGINT or SIGTERM; once the test is over in case
of success the throughput is printed to stdout, if a problem occured an error
message is displayed (on stdout) accordingly.

Signed-off-by: Edo Monticelli <montik@autistici.org>
---
 Makefile     |    2 +-
 bw_meter.c   |  168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bw_meter.h   |    1 +
 main.c       |    6 ++
 man/batctl.8 |   24 ++++++++-
 packet.h     |   38 +++++++++++--
 6 files changed, 231 insertions(+), 8 deletions(-)
 create mode 100644 bw_meter.c
 create mode 100644 bw_meter.h

diff --git a/Makefile b/Makefile
index 72cecde..059efc2 100755
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect.o ioctl.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect.o ioctl.o bw_meter.o
 MANPAGE = man/batctl.8
 
 # batctl flags and options
diff --git a/bw_meter.c b/bw_meter.c
new file mode 100644
index 0000000..1d166c1
--- /dev/null
+++ b/bw_meter.c
@@ -0,0 +1,168 @@
+#include <netinet/in.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+
+#include "main.h"
+#include "functions.h"
+#include "packet.h"
+#include "bat-hosts.h"
+#include "debugfs.h"
+
+struct ether_addr *dst_mac;
+int bw_fd = -1;
+
+void bw_sig_handler(int sig)
+{
+	int write_bytes;
+	struct batadv_icmp_packet icmp_packet_out;
+
+	switch (sig) {
+	case SIGINT:
+	case SIGTERM:
+		fflush(stdout);
+		memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
+		icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
+		icmp_packet_out.header.packet_type = BATADV_ICMP;
+		icmp_packet_out.msg_type = BATADV_BW_STOP;
+		icmp_packet_out.seqno = 0;
+
+		write_bytes = write(bw_fd, (char *)&icmp_packet_out,
+				    sizeof(struct batadv_icmp_packet));
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
+int bw_meter(char *mesh_iface, int argc, char **argv)
+{
+	struct batadv_icmp_packet icmp_packet_out;
+	struct batadv_icmp_packet_rr icmp_packet_rr;
+	struct batadv_bw_result *result;
+	struct bat_host *bat_host;
+	fd_set read_socket;
+	unsigned long int throughput;
+	char *dst_string, *mac_string;
+	int ret = EXIT_FAILURE;
+	int write_error;
+	int found_args = 1, read_opt = USE_BAT_HOSTS;
+	char *debugfs_mnt;
+	char icmp_socket[MAX_PATH+1];
+
+	if (argc <= found_args) {
+		printf("Error - target mac address or bat-host name not specified\n");
+		return EXIT_FAILURE;
+	}
+
+	signal(SIGINT, bw_sig_handler);
+	signal(SIGTERM, bw_sig_handler);
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
+			printf("Error - the bwmeter destination is not a mac address or bat-host name: %s\n",
+			       dst_string);
+			goto out;
+		}
+	}
+
+	mac_string = ether_ntoa_long(dst_mac);
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
+	bw_fd = open(icmp_socket, O_RDWR);
+
+	if (bw_fd < 0) {
+		printf("Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
+		       icmp_socket, strerror(errno));
+		printf("Check whether the module is loaded and active.\n");
+		goto out;
+	}
+
+	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
+	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
+	icmp_packet_out.header.packet_type = BATADV_ICMP;
+	icmp_packet_out.msg_type = BATADV_BW_START;
+	icmp_packet_out.seqno = 0;
+
+	printf("Bandwidth meter called towards %s\n", mac_string);
+
+	write_error = write(bw_fd, (char *)&icmp_packet_out,
+			    sizeof(struct batadv_icmp_packet));
+	if (write_error < 0) {
+		printf("Can't write to fd for %s. %d, %s\n", icmp_socket,
+		       write_error, strerror(write_error));
+		goto out;
+	}
+
+	FD_ZERO(&read_socket);
+	FD_SET(bw_fd, &read_socket);
+
+	select(bw_fd + 1, &read_socket, NULL, NULL, NULL);
+	/* a size icmp_packet_rr is read, because that is written
+	 * kernel function only handles such structure
+	  */
+	if (read(bw_fd, (char *)&icmp_packet_rr, sizeof(icmp_packet_rr))) {
+		result = (struct batadv_bw_result *)&icmp_packet_rr;
+
+		switch (result->return_value) {
+		case BATADV_BW_DST_UNREACHABLE:
+			printf("Destination unreachable\n");
+			goto out;
+
+		case BATADV_BW_SIGINT:
+			printf("SIGINT received: test aborted\n");
+			goto out;
+
+		case BATADV_BW_RESEND_LIMIT:
+			printf("The number of retry for the same window exceeds the limit, test aborted\n");
+			goto out;
+
+		case BATADV_BW_ALREADY_ONGOING:
+			printf("Cannot run two test towards the same node\n");
+			goto out;
+
+		case BATADV_BW_MEMORY_ERROR:
+			printf("Kernel cannot allocate memory, aborted\n");
+			goto out;
+
+		case BATADV_BW_COMPLETE:
+			throughput = result->total_bytes / result->test_time
+				     * 1000;
+			printf("Test over in %u ms.\n\t sent %u bytes.\nThroughput %lu Byte/s\n",
+			       result->test_time, result->total_bytes,
+			       throughput);
+			goto out;
+		}
+		printf("Unrecognized return value %d\n", result->return_value);
+	}
+out:
+	bat_hosts_free();
+	if (bw_fd)
+		close(bw_fd);
+	return ret;
+}
diff --git a/bw_meter.h b/bw_meter.h
new file mode 100644
index 0000000..44269f6
--- /dev/null
+++ b/bw_meter.h
@@ -0,0 +1 @@
+int bw_meter(char *mesh_iface, int argc, char **argv);
diff --git a/main.c b/main.c
index 1086f8e..3664958 100644
--- a/main.c
+++ b/main.c
@@ -32,6 +32,7 @@
 #include "sys.h"
 #include "debug.h"
 #include "ping.h"
+#include "bw_meter.h"
 #include "traceroute.h"
 #include "tcpdump.h"
 #include "bisect.h"
@@ -85,6 +86,7 @@ void print_usage(void)
 	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \tbandwidthmeter|bw          <destination>     \tstart a bandwith measurement\n");
 	printf(" \tbisect                     <file1> .. <fileN>\tanalyze given log files for routing stability\n");
 }
 
@@ -140,6 +142,10 @@ int main(int argc, char **argv)
 
 		ret = ping(mesh_iface, argc - 1, argv + 1);
 
+	} else if ((strcmp(argv[1], "bandwidthmeter") == 0) || (strcmp(argv[1], "bw") == 0)) {
+
+		ret = bw_meter (mesh_iface, argc -1, argv + 1);
+
 	} else if ((strcmp(argv[1], "traceroute") == 0) || (strcmp(argv[1], "tr") == 0)) {
 
 		ret = traceroute(mesh_iface, argc - 1, argv + 1);
diff --git a/man/batctl.8 b/man/batctl.8
index 1a11508..ee47dea 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -30,13 +30,16 @@ batctl offers a convenient way to configure the batman\-adv kernel module as wel
 such as originator tables, translation tables and the debug log. In combination with a bat\-hosts file batctl allows
 the use of host names instead of MAC addresses.
 .PP
+
 B.A.T.M.A.N. advanced operates on layer 2. Thus all hosts participating in the virtual switched network are transparently
 connected together for all protocols above layer 2. Therefore the common diagnosis tools do not work as expected. To
 overcome these problems batctl contains the commands \fBping\fP, \fBtraceroute\fP, \fBtcpdump\fP which provide similar
 functionality to the normal \fBping\fP(1), \fBtraceroute\fP(1), \fBtcpdump\fP(1) commands, but modified to layer 2
-behaviour or using the B.A.T.M.A.N. advanced protocol.
-.PP
+behaviour or using the B.A.T.M.A.N. advanced protocol. For similar reasons, \fBbandwidth\fP, a command to test network 
+performances, is also included.
+
 .PP
+.Pp
 .SH OPTIONS
 .TP
 .I \fBoptions:
@@ -254,6 +257,23 @@ except specified). The following packet types are available:
 Example: batctl td <interface> -p 129 \-> only display batman ogm packets and non batman packets
 .RE
 .br
+.IP "\fBbandwidth\fP|\fBbw\fP \fBMAC\fP"
+This command starts a bandwidth test entirely controlled by batman module in
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
+.br
 .IP "\fBbisect\fP [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
 Analyses the logfiles to build a small internal database of all sent sequence numbers and routing table changes. This
 database can then be analyzed in a number of different ways. With "\-l" the database can be used to search for routing
diff --git a/packet.h b/packet.h
index 2d23a14..568025a 100644
--- a/packet.h
+++ b/packet.h
@@ -21,6 +21,7 @@
 #define _NET_BATMAN_ADV_PACKET_H_
 
 #define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
+#define batadv_bw_is_error(n) ((uint8_t)n > 127 ? 1 : 0)
 
 enum batadv_packettype {
 	BATADV_IV_OGM	    = 0x01,
@@ -44,12 +45,15 @@ enum batadv_iv_flags {
 };
 
 /* ICMP message types */
-enum batadv_icmp_packettype {
-	BATADV_ECHO_REPLY	       = 0,
+enum icmp_packettype {
+	BATADV_ECHO_REPLY		= 0,
 	BATADV_DESTINATION_UNREACHABLE = 3,
-	BATADV_ECHO_REQUEST	       = 8,
-	BATADV_TTL_EXCEEDED	       = 11,
-	BATADV_PARAMETER_PROBLEM       = 12,
+	BATADV_ECHO_REQUEST		= 8,
+	BATADV_TTL_EXCEEDED		= 11,
+	BATADV_PARAMETER_PROBLEM	= 12,
+	BATADV_BW_START			= 15,
+	BATADV_BW_ACK			= 16,
+	BATADV_BW_STOP			= 17,
 };
 
 /* vis defines */
@@ -155,6 +159,30 @@ struct batadv_icmp_packet_rr {
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 } __packed;
 
+enum batadv_bw_meter_status {
+	BATADV_BW_RECEIVER		= 1,
+	BATADV_BW_SENDER		= 2,
+	BATADV_BW_COMPLETE		= 3,
+	BATADV_BW_LAST_WINDOW		= 4,
+	/* error status >= 128 */
+	BATADV_BW_SIGINT		= 128,
+	BATADV_BW_DST_UNREACHABLE	= 129,
+	BATADV_BW_RESEND_LIMIT		= 130,
+	BATADV_BW_ALREADY_ONGOING	= 131,
+	BATADV_BW_MEMORY_ERROR		= 132,
+};
+
+/* structure returned to batctl */
+/* icmp_packet_rr used to keep socket_client's index,
+ * as function batadv_socket_receive_packet expects it
+ */
+struct batadv_bw_result {
+	struct batadv_icmp_packet icmp_packet;
+	uint32_t test_time;
+	uint32_t total_bytes;
+	uint8_t return_value;
+} __packed;
+
 struct batadv_unicast_packet {
 	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
-- 
1.7.8.6

