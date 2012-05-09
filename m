Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed,  9 May 2012 18:32:42 +0800
Message-Id: <1336559562-29914-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add statistic retrieval component
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
 Makefile     |    2 +-
 README       |   42 ++++++++++++++
 ioctl.c      |  175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ioctl.h      |   23 ++++++++
 main.c       |    6 ++
 man/batctl.8 |   19 ++++++
 6 files changed, 266 insertions(+), 1 deletions(-)
 create mode 100644 ioctl.c
 create mode 100644 ioctl.h

diff --git a/Makefile b/Makefile
index c85dbaa..72cecde 100755
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect.o ioctl.o
 MANPAGE = man/batctl.8
 
 # batctl flags and options
diff --git a/README b/README
index 24dc4cf..44e1ac7 100644
--- a/README
+++ b/README
@@ -34,6 +34,48 @@ address to your provided host name. Host names are much easier to remember than
 MAC addresses.  ;)
 
 
+batctl statistics
+=================
+
+The batman-adv kernel module maintains a number of traffic counters which are exported
+to user space. With batctl these counters can be easily retrieved. The output may vary
+depending on which features have been compiled into the kernel module. For example, if
+the distributed arp table (short: dat) wasn't selected as an option at compile time
+its counters won't be shown.
+Each module subsystem has its own counters which are indicated by their prefixes:
+ * mgmt - mesh protocol counters
+ * tt - translation table counters
+ * dat - distributed arp table counters
+All counters without a prefix concern payload (pure user data) traffic.
+
+Usage: batctl statistics
+
+Example:
+
+$ batctl statistics
+        tx: 14
+        tx_bytes: 1316
+        tx_errors: 0
+        rx: 14
+        rx_bytes: 1316
+        forward: 0
+        forward_bytes: 0
+        mgmt_tx: 18
+        mgmt_tx_bytes: 762
+        mgmt_rx: 17
+        mgmt_rx_bytes: 1020
+        tt_request_tx: 0
+        tt_request_rx: 0
+        tt_response_tx: 0
+        tt_response_rx: 0
+        tt_roam_adv_tx: 0
+        tt_roam_adv_rx: 0
+        dat_request_tx: 0
+        dat_request_rx: 0
+        dat_reply_tx: 1
+        dat_reply_rx: 0
+
+
 batctl ping
 ============
 
diff --git a/ioctl.c b/ioctl.c
new file mode 100644
index 0000000..92ffdb3
--- /dev/null
+++ b/ioctl.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2012 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <lindner_marek@yahoo.de>
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
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <linux/if.h>
+#include <linux/sockios.h>
+#include <linux/ethtool.h>
+
+#include "main.h"
+#include "ioctl.h"
+#include "debugfs.h"
+
+typedef unsigned long long u64;
+
+const char proc_net_dev_path[] = "/proc/net/dev";
+
+static int statistics_common_get(char *mesh_iface)
+{
+	FILE *fp;
+	char iface[IFNAMSIZ + 1], *line_ptr = NULL;;
+	unsigned long long rx_bytes, rx_packets, tx_bytes, tx_packets;
+	unsigned long tx_errors;
+	size_t len = 0;
+	int res, ret = EXIT_FAILURE;
+
+	rx_bytes = rx_packets = tx_bytes = tx_packets = tx_errors = 0;
+
+	fp = fopen(proc_net_dev_path, "r");
+	if (!fp) {
+		printf("Error - can't open '%s' for read: %s\n",
+		       proc_net_dev_path, strerror(errno));
+		goto out;
+	}
+
+	while (getline(&line_ptr, &len, fp) != -1) {
+		res = sscanf(line_ptr, " %" STR(IFNAMSIZ) "[^: \t]: %llu %llu %*d %*d %*d %*d %*d %*d %llu %llu %lu\n",
+			     iface, &rx_bytes, &rx_packets, &tx_bytes, &tx_packets, &tx_errors);
+
+		if (res != 6)
+			continue;
+
+		if (strcmp(iface, mesh_iface) != 0)
+			continue;
+
+		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "tx", tx_packets);
+		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "tx_bytes", tx_bytes);
+		printf("\t%.*s: %lu\n", ETH_GSTRING_LEN, "tx_errors", tx_errors);
+		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "rx", rx_packets);
+		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "rx_bytes", rx_bytes);
+		ret = EXIT_SUCCESS;
+		goto out;
+	}
+
+	printf("Error - interface '%s' not found\n", mesh_iface);
+
+out:
+	fclose(fp);
+	free(line_ptr);
+	return ret;
+}
+
+/* code borrowed from ethtool */
+static int statistics_custom_get(int fd, struct ifreq *ifr)
+{
+	struct ethtool_drvinfo drvinfo;
+	struct ethtool_gstrings *strings = NULL;
+	struct ethtool_stats *stats = NULL;
+	unsigned int n_stats, sz_str, sz_stats, i;
+	int err, ret = EXIT_FAILURE;
+
+	drvinfo.cmd = ETHTOOL_GDRVINFO;
+	ifr->ifr_data = (caddr_t)&drvinfo;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
+	if (err < 0) {
+		printf("Error - can't open driver information: %s\n", strerror(errno));
+		goto out;
+	}
+
+	n_stats = drvinfo.n_stats;
+	if (n_stats < 1)
+		goto success;
+
+	sz_str = n_stats * ETH_GSTRING_LEN;
+	sz_stats = n_stats * sizeof(u64);
+
+	strings = calloc(1, sz_str + sizeof(struct ethtool_gstrings));
+	stats = calloc(1, sz_stats + sizeof(struct ethtool_stats));
+	if (!strings || !stats) {
+		printf("Error - out of memory\n");
+		goto out;
+	}
+
+	strings->cmd = ETHTOOL_GSTRINGS;
+	strings->string_set = ETH_SS_STATS;
+	strings->len = n_stats;
+	ifr->ifr_data = (caddr_t)strings;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
+	if (err < 0) {
+		printf("Error - can't get stats strings information: %s\n", strerror(errno));
+		goto out;
+	}
+
+	stats->cmd = ETHTOOL_GSTATS;
+	stats->n_stats = n_stats;
+	ifr->ifr_data = (caddr_t) stats;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
+	if (err < 0) {
+		printf("Error - can't get stats information: %s\n", strerror(errno));
+		goto out;
+	}
+
+	for (i = 0; i < n_stats; i++) {
+		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN,
+		       &strings->data[i * ETH_GSTRING_LEN], stats->data[i]);
+	}
+
+success:
+	ret = EXIT_SUCCESS;
+
+out:
+	free(strings);
+	free(stats);
+	return ret;
+}
+
+int ioctl_statistics_get(char *mesh_iface)
+{
+	struct ifreq ifr;
+	int fd = -1, ret = EXIT_FAILURE;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strcpy(ifr.ifr_name, mesh_iface);
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		printf("Error - can't open socket: %s\n", strerror(errno));
+		goto out;
+	}
+
+	ret = statistics_common_get(mesh_iface);
+	if (ret != EXIT_SUCCESS)
+		goto out;
+
+	ret = statistics_custom_get(fd, &ifr);
+
+out:
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
diff --git a/ioctl.h b/ioctl.h
new file mode 100644
index 0000000..0a6a7d6
--- /dev/null
+++ b/ioctl.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <lindner_marek@yahoo.de>
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
+
+int ioctl_statistics_get(char *mesh_iface);
diff --git a/main.c b/main.c
index 86e2078..1c3af02 100644
--- a/main.c
+++ b/main.c
@@ -36,6 +36,7 @@
 #include "tcpdump.h"
 #include "bisect.h"
 #include "vis.h"
+#include "ioctl.h"
 #include "functions.h"
 #include <err.h>
 
@@ -63,6 +64,7 @@ void print_usage(void) {
 	printf(" \tfragmentation|f            [0|1]             \tdisplay or modify the fragmentation mode setting\n");
 	printf(" \tap_isolation|ap            [0|1]             \tdisplay or modify the ap isolation mode setting\n");
 	printf("\n");
+	printf(" \tstatistics|stat                              \tprint mesh statistics\n");
 	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
@@ -213,6 +215,10 @@ int main(int argc, char **argv)
 		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
 					 SYS_AP_ISOLA, ap_isolation_usage, sysfs_param_enable);
 
+	} else if ((strcmp(argv[1], "statistics") == 0) || (strcmp(argv[1], "stat") == 0)) {
+
+		ret = ioctl_statistics_get(mesh_iface);
+
 	} else if ((strcmp(argv[1], "bisect") == 0)) {
 
 		ret = bisect(argc - 1, argv + 1);
diff --git a/man/batctl.8 b/man/batctl.8
index 7b159d0..a37b718 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -158,6 +158,25 @@ If no parameter is given the current fragmentation mode setting is displayed. Ot
 .IP "\fBap_isolation\fP|\fBap\fP   [\fB1\fP|\fB0\fP]"
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or disable ap isolation.
 .br
+.IP "\fBstatistics\fP|\fBstat\fP"
+Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have
+been compiled into the kernel module. For example, if the distributed arp table (short: dat) wasn't selected
+as an option at compile time its counters won't be shown.
+.br
+Each module subsystem has its own counters which are indicated by their prefixes:
+.RS 15
+mgmt - mesh protocol counters
+.RE
+.RS 17
+tt - translation table counters
+.RE
+.RS 16
+dat - distributed arp table counters
+.RE
+.RS 7
+All counters without a prefix concern payload (pure user data) traffic.
+.RE
+.br
 .IP "\fBping\fP|\fBp\fP           [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to
 find the bat\-host name if the given parameter was not a MAC
-- 
1.7.9.1

