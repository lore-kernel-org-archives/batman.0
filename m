Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 25 Aug 2014 19:41:43 +0200
Message-Id: <1408988503-27906-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: support for changing interfaces
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

This patch adds support for changing the interface alfreds listens to on
the fly without restarting alfred.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 alfred.h     |  2 ++
 client.c     | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 main.c       | 66 +++++++++++++++++++++++++++++++++++-------------------------
 man/alfred.8 |  3 +++
 packet.h     | 17 ++++++++++++++++
 unix_sock.c  | 38 ++++++++++++++++++++++++++++++++++
 vis/vis.c    |  2 +-
 7 files changed, 154 insertions(+), 28 deletions(-)

diff --git a/alfred.h b/alfred.h
index 35ac4dd..f0989ea 100644
--- a/alfred.h
+++ b/alfred.h
@@ -86,6 +86,7 @@ enum clientmode {
 	CLIENT_REQUEST_DATA,
 	CLIENT_SET_DATA,
 	CLIENT_MODESWITCH,
+	CLIENT_CHANGE_INTERFACE,
 };
 
 struct globals {
@@ -125,6 +126,7 @@ int set_best_server(struct globals *globals);
 int alfred_client_request_data(struct globals *globals);
 int alfred_client_set_data(struct globals *globals);
 int alfred_client_modeswitch(struct globals *globals);
+int alfred_client_change_interface(struct globals *globals);
 /* recv.c */
 int recv_alfred_packet(struct globals *globals);
 struct transaction_head *
diff --git a/client.c b/client.c
index b868719..48313db 100644
--- a/client.c
+++ b/client.c
@@ -22,6 +22,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include <sys/ioctl.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
@@ -218,3 +219,56 @@ int alfred_client_modeswitch(struct globals *globals)
 	unix_sock_close(globals);
 	return 0;
 }
+
+int alfred_client_change_interface(struct globals *globals)
+{
+	unsigned char buf[MAX_PAYLOAD];
+	struct alfred_change_interface_v0 *change_interface;
+	struct ifreq ifr;
+	int ret, len;
+	int sock = -1;
+
+	if (unix_sock_open_client(globals))
+		return -1;
+
+	if (strlen(globals->interface) > IFNAMSIZ) {
+		fprintf(stderr, "%s: interface name too long, not changing\n",
+			__func__);
+		return 0;
+	}
+
+	sock = socket(PF_INET6, SOCK_DGRAM, 0);
+	if (sock < 0) {
+		perror("can't open socket");
+		return -1;
+	}
+
+	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
+	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
+		fprintf(stderr, "%s: can't find interface, not changing\n",
+			__func__);
+		close(sock);
+		return -1;
+	}
+
+	close(sock);
+
+	change_interface = (struct alfred_change_interface_v0 *)buf;
+	len = sizeof(*change_interface);
+
+	change_interface->header.type = ALFRED_CHANGE_INTERFACE;
+	change_interface->header.version = ALFRED_VERSION;
+	change_interface->header.length = htons(len - sizeof(change_interface->header));
+	memcpy(change_interface->iface, globals->interface,
+	       sizeof(change_interface->iface));
+
+	ret = write(globals->unix_sock, buf, len);
+	if (ret != len)
+		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
+			__func__, ret, len, strerror(errno));
+
+	unix_sock_close(globals);
+
+	return 0;
+}
diff --git a/main.c b/main.c
index 1add44e..5a4f1e6 100644
--- a/main.c
+++ b/main.c
@@ -33,25 +33,29 @@ static void alfred_usage(void)
 {
 	printf("Usage: alfred [options]\n");
 	printf("client mode options:\n");
-	printf("  -s, --set-data [data type]  sets new data to distribute from stdin\n");
-	printf("                              for the supplied data type (0-255)\n");
-	printf("  -r, --request [data type]   collect data from the network and prints\n");
-	printf("                              it on the network\n");
-	printf("  -V, --req-version           specify the data version set for -s\n");
-	printf("  -M, --modeswitch master     switch daemon to mode master\n");
-	printf("                   slave      switch daemon to mode slave\n");
+	printf("  -s, --set-data [data type]          sets new data to distribute from stdin\n");
+	printf("                                      for the supplied data type (0-255)\n");
+	printf("  -r, --request [data type]           collect data from the network and prints\n");
+	printf("                                      it on the network\n");
+	printf("  -V, --req-version                   specify the data version set for -s\n");
+	printf("  -M, --modeswitch master             switch daemon to mode master\n");
+	printf("                   slave              switch daemon to mode slave\n");
+	printf("  -I, --change-interface [interface]  change to the specified interface\n");
 	printf("\n");
 	printf("server mode options:\n");
-	printf("  -i, --interface             specify the interface to listen on\n");
-	printf("  -b                          specify the batman-adv interface configured on the system (default: bat0)\n");
-	printf("                              use 'none' to disable the batman-adv based best server selection\n");
-	printf("  -m, --master                start up the daemon in master mode, which\n");
-	printf("                              accepts data from slaves and synces it with\n");
-	printf("                              other masters\n");
+	printf("  -i, --interface                     specify the interface to listen on\n");
+	printf("  -b                                  specify the batman-adv interface\n");
+	printf("                                      configured on the system (default: bat0)\n");
+	printf("                                      use 'none' to disable the batman-adv\n");
+	printf("                                      based best server selection\n");
+	printf("  -m, --master                        start up the daemon in master mode, which\n");
+	printf("                                      accepts data from slaves and synces it with\n");
+	printf("                                      other masters\n");
 	printf("\n");
-	printf("  -u, --unix-path [path]      path to unix socket used for client-server communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
-	printf("  -v, --version               print the version\n");
-	printf("  -h, --help                  this help\n");
+	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
+	printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
+	printf("  -v, --version                       print the version\n");
+	printf("  -h, --help                          this help\n");
 	printf("\n");
 }
 
@@ -60,16 +64,17 @@ static struct globals *alfred_init(int argc, char *argv[])
 	int opt, opt_ind, i;
 	struct globals *globals;
 	struct option long_options[] = {
-		{"set-data",	required_argument,	NULL,	's'},
-		{"request",	required_argument,	NULL,	'r'},
-		{"interface",	required_argument,	NULL,	'i'},
-		{"master",	no_argument,		NULL,	'm'},
-		{"help",	no_argument,		NULL,	'h'},
-		{"req-version", required_argument,	NULL,	'V'},
-		{"modeswitch",  required_argument,	NULL,	'M'},
-		{"unix-path", 	required_argument,	NULL,	'u'},
-		{"version",	no_argument,		NULL,	'v'},
-		{NULL,		0,			NULL,	0},
+		{"set-data",		required_argument,	NULL,	's'},
+		{"request",		required_argument,	NULL,	'r'},
+		{"interface",		required_argument,	NULL,	'i'},
+		{"master",		no_argument,		NULL,	'm'},
+		{"help",		no_argument,		NULL,	'h'},
+		{"req-version", 	required_argument,	NULL,	'V'},
+		{"modeswitch",  	required_argument,	NULL,	'M'},
+		{"change-interface",	required_argument,	NULL,	'I'},
+		{"unix-path",		required_argument,	NULL,	'u'},
+		{"version",		no_argument,		NULL,	'v'},
+		{NULL,			0,			NULL,	0},
 	};
 
 	globals = &alfred_globals;
@@ -85,7 +90,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:u:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -135,6 +140,10 @@ static struct globals *alfred_init(int argc, char *argv[])
 			}
 			globals->clientmode = CLIENT_MODESWITCH;
 			break;
+		case 'I':
+			globals->clientmode = CLIENT_CHANGE_INTERFACE;
+			globals->interface = strdup(optarg);
+			break;
 		case 'u':
 			globals->unix_path = optarg;
 			break;
@@ -176,6 +185,9 @@ int main(int argc, char *argv[])
 	case CLIENT_MODESWITCH:
 		return alfred_client_modeswitch(globals);
 		break;
+	case CLIENT_CHANGE_INTERFACE:
+		return alfred_client_change_interface(globals);
+		break;
 	}
 
 	return 0;
diff --git a/man/alfred.8 b/man/alfred.8
index c90caa8..35dee45 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -80,6 +80,9 @@ to 0 ('\fB\-V\fP 0').
 \fBslave\fP
     Switch daemon to mode slave
 .fi
+.TP
+\fB\-I\fP, \fB\-\-change\-interface\fP \fIinterface\fP
+Change the alfred server to use the new \fBinterface\fP
 .
 .SH SERVER OPTIONS
 .TP
diff --git a/packet.h b/packet.h
index ba8c5f6..dc06d65 100644
--- a/packet.h
+++ b/packet.h
@@ -20,6 +20,8 @@
 #ifndef _ALFRED_PACKET_H
 #define _ALFRED_PACKET_H
 
+#include <net/if.h>	/* IFNAMSIZ */
+
 #define __packed __attribute__ ((packed))
 
 /* basic blocks */
@@ -67,6 +69,7 @@ struct alfred_transaction_mgmt {
  * @ALFRED_STATUS_TXEND: Transaction was finished by sender
  * @ALFRED_STATUS_ERROR: Error was detected during the transaction
  * @ALFRED_MODESWITCH: Switch between different operation modes
+ * @ALFRED_CHANGE_INTERFACE: Change the listening interface
  */
 enum alfred_packet_type {
 	ALFRED_PUSH_DATA = 0,
@@ -75,6 +78,7 @@ enum alfred_packet_type {
 	ALFRED_STATUS_TXEND = 3,
 	ALFRED_STATUS_ERROR = 4,
 	ALFRED_MODESWITCH = 5,
+	ALFRED_CHANGE_INTERFACE = 6,
 };
 
 /* packets */
@@ -143,6 +147,19 @@ struct alfred_modeswitch_v0 {
 } __packed;
 
 /**
+ * struct alfred_change_interface_v0 - Request to change the interface
+ * @header: TLV header describing the complete packet
+ * @iface: interface name to be changed to
+ *
+ * Sent to the daemon by client
+ */
+struct alfred_change_interface_v0 {
+	struct alfred_tlv header;
+	char iface[IFNAMSIZ];
+} __packed;
+
+
+/**
  * struct alfred_status_v0 - Status info of a transaction
  * @header: TLV header describing the complete packet
  * @tx: Transaction identificator and sequence number of packet
diff --git a/unix_sock.c b/unix_sock.c
index cc0d25c..516c0a5 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -298,6 +298,38 @@ err:
 	return ret;
 }
 
+static int
+unix_sock_change_iface(struct globals *globals,
+		       struct alfred_change_interface_v0 *change_iface,
+		       int client_sock)
+{
+	int len, ret = -1;
+	char *iface;
+
+	len = ntohs(change_iface->header.length);
+
+	if (len < (int)(sizeof(*change_iface) - sizeof(change_iface->header)))
+		goto err;
+
+	iface = malloc(IFNAMSIZ + 1);
+	if (!iface)
+		goto err;
+
+	memcpy(iface, change_iface->iface, IFNAMSIZ);
+	iface[IFNAMSIZ] = 0;
+
+	netsock_close(globals->netsock);
+
+	free(globals->interface);
+	globals->interface = iface;
+	netsock_open(globals);
+
+	ret = 0;
+err:
+	close(client_sock);
+	return ret;
+}
+
 int unix_sock_read(struct globals *globals)
 {
 	int client_sock;
@@ -350,6 +382,12 @@ int unix_sock_read(struct globals *globals)
 				       (struct alfred_modeswitch_v0 *)packet,
 					client_sock);
 		break;
+	case ALFRED_CHANGE_INTERFACE:
+		ret = unix_sock_change_iface(globals,
+					     (struct alfred_change_interface_v0 *)packet,
+					     client_sock);
+		break;
+
 	default:
 		/* unknown packet type */
 		ret = -1;
diff --git a/vis/vis.c b/vis/vis.c
index 00372ab..3dd5c8c 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -23,7 +23,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <getopt.h>
-#include <linux/if.h>
+#include <net/if.h>
 #include <netinet/in.h>
 #include <signal.h>
 #include <stdbool.h>
-- 
2.1.0

