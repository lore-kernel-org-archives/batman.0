Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 16 Oct 2012 23:01:26 +0200
Message-Id: <1350421286-30659-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add tool to translate
	mac/IPv4/bat_host to originator address
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

Users may want to get the originator which is responsible for a specific mac
address. These addresses can be specified using IPv4 address, ethernet address
or bat-host name.

For example, the output can be used to get the TQ value from the originator
table when only the client address is known and not the gateway address.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile     |    2 +-
 README       |   18 ++++++++++++++
 main.c       |    6 +++++
 man/batctl.8 |    5 ++++
 translate.c  |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 translate.h  |   24 ++++++++++++++++++
 6 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 translate.c
 create mode 100644 translate.h

diff --git a/Makefile b/Makefile
index 4379837..699a3ea 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o vis.o debugfs.o ioctl.o list-batman.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o vis.o debugfs.o ioctl.o list-batman.o translate.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/README b/README
index b9c6b23..efdd3cb 100644
--- a/README
+++ b/README
@@ -75,6 +75,24 @@ $ batctl statistics
         dat_reply_tx: 1
         dat_reply_rx: 0
 
+batctl translate
+================
+
+Translates a destination (hostname, IPv4, MAC, bat_host-name) to the originator
+mac address responsible for it.
+
+Usage: batctl translate mac|bat-host|host-name|IPv4-address
+
+Example:
+
+$ batctl translate www.google.de
+02:ca:fe:af:fe:01
+$ batctl translate 02:ca:fe:af:fe:01
+02:ca:fe:af:fe:01
+$ batctl translate 192.168.1.2
+02:ca:fe:af:fe:05
+$ batctl translate fe:fe:00:00:09:01
+02:ca:fe:af:fe:05
 
 batctl ping
 ============
diff --git a/main.c b/main.c
index 647818d..5d85d8b 100644
--- a/main.c
+++ b/main.c
@@ -32,6 +32,7 @@
 #include "sys.h"
 #include "debug.h"
 #include "ping.h"
+#include "translate.h"
 #include "traceroute.h"
 #include "tcpdump.h"
 #include "bisect_iv.h"
@@ -85,6 +86,7 @@ void print_usage(void)
 	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \ttranslate|t                <destination>     \ttranslate a destination to the originator responsible for it\n");
 #ifdef BATCTL_BISECT
 	printf(" \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
 #endif
@@ -174,6 +176,10 @@ int main(int argc, char **argv)
 
 		ret = ioctl_statistics_get(mesh_iface);
 
+	} else if ((strcmp(argv[1], "translate") == 0) || (strcmp(argv[1], "t") == 0)) {
+
+		ret = translate(mesh_iface, argc - 1, argv + 1);
+
 #ifdef BATCTL_BISECT
 	} else if ((strcmp(argv[1], "bisect_iv") == 0)) {
 
diff --git a/man/batctl.8 b/man/batctl.8
index feb1a17..3c8edce 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -200,6 +200,11 @@ List of debug tables:
 .RE
 .RE
 .br
+.IP "\fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
+
+Translates a destination (hostname, IPv4, MAC, bat_host-name) to the originator
+mac address responsible for it.
+.br
 .IP "\fBstatistics\fP|\fBs\fP"
 Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have been compiled
 into the kernel module.
diff --git a/translate.c b/translate.c
new file mode 100644
index 0000000..2d6ede9
--- /dev/null
+++ b/translate.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
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
+#include <netinet/in.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "main.h"
+#include "translate.h"
+#include "functions.h"
+#include "bat-hosts.h"
+
+
+static void translate_usage(void)
+{
+	printf("Usage: batctl [options] translate mac|bat-host|host_name|IPv4_address\n");
+}
+
+int translate(char *mesh_iface, int argc, char **argv)
+{
+	struct ether_addr *dst_mac = NULL;
+	struct bat_host *bat_host;
+	int ret = EXIT_FAILURE;
+	char *dst_string, *mac_string;
+
+	if (argc <= 1) {
+		fprintf(stderr, "Error - destination not specified\n");
+		translate_usage();
+		return EXIT_FAILURE;
+	}
+
+	dst_string = argv[1];
+	bat_hosts_init(0);
+	bat_host = bat_hosts_find_by_name(dst_string);
+
+	if (bat_host)
+		dst_mac = &bat_host->mac_addr;
+
+	if (!dst_mac) {
+		dst_mac = resolve_mac(dst_string);
+
+		if (!dst_mac) {
+			fprintf(stderr, "Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
+			goto out;
+		}
+	}
+
+	dst_mac = translate_mac(mesh_iface, dst_mac);
+	if (dst_mac) {
+		mac_string = ether_ntoa_long(dst_mac);
+		printf("%s\n", mac_string);
+		ret = EXIT_SUCCESS;
+	} else {
+		ret = EXIT_NOSUCCESS;
+	}
+
+out:
+	bat_hosts_free();
+	return ret;
+}
diff --git a/translate.h b/translate.h
new file mode 100644
index 0000000..eb0ef65
--- /dev/null
+++ b/translate.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
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
+
+int translate(char *mesh_iface, int argc, char **argv);
-- 
1.7.10.4

