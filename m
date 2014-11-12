Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Wed, 12 Nov 2014 14:54:29 +0100
Message-Id: <1415800470-10114-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Add support for multiple
	interfaces per master
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
Cc: Sven Eckelmann <sven@open-mesh.com>

It may required in some situations that all alfred master servers are
potentially connected to the same backbone network but cannot see each other
through the mesh. The data may still be exchanged and thus a master instance
must listen for requests on the mesh and synchronize data over the backbone
network.

The limitation that data can only be synchronized over one master hop and not
more still holds true. Also alfred servers in slave mode are not allowed to
operate on multiple interfaces. This is especially important when switching
from master to slave mode because this can fail now when multiple interfaces
are configured.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h     |  40 +++++++++----
 client.c     |  58 ++++++++++++++-----
 main.c       |  12 ++--
 man/alfred.8 |   4 +-
 netsock.c    | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 packet.h     |   4 +-
 recv.c       |  16 +++---
 send.c       |  65 ++++++++++++---------
 server.c     |  97 ++++++++++++++++---------------
 unix_sock.c  |  38 ++++++++-----
 10 files changed, 377 insertions(+), 140 deletions(-)

diff --git a/alfred.h b/alfred.h
index c83f7f0..cf94af4 100644
--- a/alfred.h
+++ b/alfred.h
@@ -27,6 +27,8 @@
 #include <netinet/in.h>
 #include <stdint.h>
 #include <time.h>
+#include <sys/select.h>
+#include <sys/types.h>
 #include "list.h"
 #include "packet.h"
 
@@ -89,19 +91,27 @@ enum clientmode {
 	CLIENT_CHANGE_INTERFACE,
 };
 
-struct globals {
+struct interface {
 	struct ether_addr hwaddr;
 	struct in6_addr address;
 	uint32_t scope_id;
-	struct server *best_server;	/* NULL if we are a server ourselves */
 	char *interface;
+	int netsock;
+
+	struct list_head list;
+};
+
+struct globals {
+	struct list_head interfaces;
+
+	char *change_interface;
+	struct server *best_server;	/* NULL if we are a server ourselves */
 	const char *mesh_iface;
 	enum opmode opmode;
 	enum clientmode clientmode;
 	int clientmode_arg;
 	int clientmode_version;
 
-	int netsock;
 	int unix_sock;
 	const char *unix_path;
 
@@ -128,7 +138,7 @@ int alfred_client_set_data(struct globals *globals);
 int alfred_client_modeswitch(struct globals *globals);
 int alfred_client_change_interface(struct globals *globals);
 /* recv.c */
-int recv_alfred_packet(struct globals *globals);
+int recv_alfred_packet(struct globals *globals, struct interface *interface);
 struct transaction_head *
 transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id);
 struct transaction_head *
@@ -137,14 +147,14 @@ transaction_clean_hash(struct globals *globals,
 struct transaction_head *transaction_clean(struct globals *globals,
 					   struct transaction_head *head);
 /* send.c */
-int push_data(struct globals *globals, struct in6_addr *destination,
-	      enum data_source max_source_level, int type_filter,
-	      uint16_t tx_id);
+int push_data(struct globals *globals, struct interface *interface,
+	      struct in6_addr *destination, enum data_source max_source_level,
+	      int type_filter, uint16_t tx_id);
 int announce_master(struct globals *globals);
 int push_local_data(struct globals *globals);
 int sync_data(struct globals *globals);
-ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
-			   void *buf, int length);
+ssize_t send_alfred_packet(struct interface *interface,
+			   const struct in6_addr *dest, void *buf, int length);
 /* unix_sock.c */
 int unix_sock_read(struct globals *globals);
 int unix_sock_open_daemon(struct globals *globals);
@@ -155,8 +165,16 @@ int unix_sock_req_data_finish(struct globals *globals,
 /* vis.c */
 int vis_update_data(struct globals *globals);
 /* netsock.c */
-int netsock_open(struct globals *globals);
-int netsock_close(int sock);
+int netsock_open_all(struct globals *globals);
+void netsock_close_all(struct globals *globals);
+int netsock_set_interfaces(struct globals *globals, char *interfaces);
+struct interface *netsock_first_interface(struct globals *globals);
+void netsock_reopen(struct globals *globals);
+int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock);
+void netsock_check_error(struct globals *globals, fd_set *errfds);
+int netsock_receive_packet(struct globals *globals, fd_set *fds);
+int netsock_own_address(const struct globals *globals,
+			const struct in6_addr *address);
 /* util.c */
 int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff);
diff --git a/client.c b/client.c
index 48313db..cff5270 100644
--- a/client.c
+++ b/client.c
@@ -27,6 +27,9 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <net/if.h>
+#include <stddef.h>
+#include <sys/socket.h>
 #include "alfred.h"
 #include "packet.h"
 
@@ -220,21 +223,15 @@ int alfred_client_modeswitch(struct globals *globals)
 	return 0;
 }
 
-int alfred_client_change_interface(struct globals *globals)
+static int check_interface(const char *iface)
 {
-	unsigned char buf[MAX_PAYLOAD];
-	struct alfred_change_interface_v0 *change_interface;
-	struct ifreq ifr;
-	int ret, len;
 	int sock = -1;
+	struct ifreq ifr;
 
-	if (unix_sock_open_client(globals))
-		return -1;
-
-	if (strlen(globals->interface) > IFNAMSIZ) {
-		fprintf(stderr, "%s: interface name too long, not changing\n",
+	if (strlen(iface) > IFNAMSIZ) {
+		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
-		return 0;
+		return -1;
 	}
 
 	sock = socket(PF_INET6, SOCK_DGRAM, 0);
@@ -243,7 +240,7 @@ int alfred_client_change_interface(struct globals *globals)
 		return -1;
 	}
 
-	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	strncpy(ifr.ifr_name, iface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
 		fprintf(stderr, "%s: can't find interface, not changing\n",
@@ -254,14 +251,47 @@ int alfred_client_change_interface(struct globals *globals)
 
 	close(sock);
 
+	return 0;
+}
+
+int alfred_client_change_interface(struct globals *globals)
+{
+	unsigned char buf[MAX_PAYLOAD];
+	struct alfred_change_interface_v0 *change_interface;
+	int ret, len;
+	char *input, *token, *saveptr;
+
+	if (unix_sock_open_client(globals))
+		return -1;
+
+	if (strlen(globals->change_interface) > sizeof(change_interface->ifaces)) {
+		fprintf(stderr, "%s: interface name list too long, not changing\n",
+			__func__);
+		return 0;
+	}
+
 	change_interface = (struct alfred_change_interface_v0 *)buf;
 	len = sizeof(*change_interface);
 
 	change_interface->header.type = ALFRED_CHANGE_INTERFACE;
 	change_interface->header.version = ALFRED_VERSION;
 	change_interface->header.length = htons(len - sizeof(change_interface->header));
-	memcpy(change_interface->iface, globals->interface,
-	       sizeof(change_interface->iface));
+	strncpy(change_interface->ifaces, globals->change_interface,
+		sizeof(change_interface->ifaces));
+	change_interface->ifaces[sizeof(change_interface->ifaces) - 1] = '\0';
+
+	/* test it before sending
+	 * globals->change_interface is now saved in change_interface->ifaces
+	 * and can be modified by strtok_r
+	 */
+	input = globals->change_interface;
+	while ((token = strtok_r(input, ",", &saveptr))) {
+		input = NULL;
+
+		ret = check_interface(token);
+		if (ret < 0)
+			return 0;
+	}
 
 	ret = write(globals->unix_sock, buf, len);
 	if (ret != len)
diff --git a/main.c b/main.c
index 5a4f1e6..7eb8baa 100644
--- a/main.c
+++ b/main.c
@@ -26,6 +26,7 @@
 #include <string.h>
 #include "alfred.h"
 #include "packet.h"
+#include "list.h"
 
 static struct globals alfred_globals;
 
@@ -40,10 +41,10 @@ static void alfred_usage(void)
 	printf("  -V, --req-version                   specify the data version set for -s\n");
 	printf("  -M, --modeswitch master             switch daemon to mode master\n");
 	printf("                   slave              switch daemon to mode slave\n");
-	printf("  -I, --change-interface [interface]  change to the specified interface\n");
+	printf("  -I, --change-interface [interface]  change to the specified interface(s)\n");
 	printf("\n");
 	printf("server mode options:\n");
-	printf("  -i, --interface                     specify the interface to listen on\n");
+	printf("  -i, --interface                     specify the interface (or comma separated list of interfaes) to listen on\n");
 	printf("  -b                                  specify the batman-adv interface\n");
 	printf("                                      configured on the system (default: bat0)\n");
 	printf("                                      use 'none' to disable the batman-adv\n");
@@ -80,9 +81,10 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals = &alfred_globals;
 	memset(globals, 0, sizeof(*globals));
 
+	INIT_LIST_HEAD(&globals->interfaces);
+	globals->change_interface = NULL;
 	globals->opmode = OPMODE_SLAVE;
 	globals->clientmode = CLIENT_NONE;
-	globals->interface = NULL;
 	globals->best_server = NULL;
 	globals->clientmode_version = 0;
 	globals->mesh_iface = "bat0";
@@ -116,7 +118,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 			globals->opmode = OPMODE_MASTER;
 			break;
 		case 'i':
-			globals->interface = strdup(optarg);
+			netsock_set_interfaces(globals, optarg);
 			break;
 		case 'b':
 			globals->mesh_iface = strdup(optarg);
@@ -142,7 +144,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 			break;
 		case 'I':
 			globals->clientmode = CLIENT_CHANGE_INTERFACE;
-			globals->interface = strdup(optarg);
+			globals->change_interface = strdup(optarg);
 			break;
 		case 'u':
 			globals->unix_path = optarg;
diff --git a/man/alfred.8 b/man/alfred.8
index 35dee45..0449189 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -82,12 +82,12 @@ to 0 ('\fB\-V\fP 0').
 .fi
 .TP
 \fB\-I\fP, \fB\-\-change\-interface\fP \fIinterface\fP
-Change the alfred server to use the new \fBinterface\fP
+Change the alfred server to use the new \fBinterface\fP(s)
 .
 .SH SERVER OPTIONS
 .TP
 \fB\-i\fP, \fB\-\-interface\fP \fiface\fP
-Specify the interface to listen on
+Specify the interface (or comma separated list of interfaes) to listen on
 .TP
 \fB\-b\fP \fIbatmanif\fP
 Specify the batman-adv interface configured on the system (default: bat0).
diff --git a/netsock.c b/netsock.c
index b59b7b7..703334f 100644
--- a/netsock.c
+++ b/netsock.c
@@ -22,6 +22,7 @@
 #include <sys/socket.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <net/ethernet.h>
 #include <net/if.h>
 #include <netinet/in.h>
 #include <stdio.h>
@@ -29,28 +30,104 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <unistd.h>
+#include <stdlib.h>
+#include <sys/select.h>
 #include "alfred.h"
 #include "batadv_query.h"
 #include "packet.h"
+#include "list.h"
 
 const struct in6_addr in6addr_localmcast = {{{ 0xff, 0x02, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x01 } } };
 
-int netsock_close(int sock)
+void netsock_close_all(struct globals *globals)
 {
-	return close(sock);
+	struct interface *interface, *is;
+
+	list_for_each_entry_safe(interface, is, &globals->interfaces, list) {
+		if (interface->netsock >= 0)
+			close(interface->netsock);
+		list_del(&interface->list);
+		free(interface->interface);
+		free(interface);
+	}
 }
 
-int netsock_open(struct globals *globals)
+struct interface *netsock_first_interface(struct globals *globals)
+{
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (interface->netsock >= 0)
+			return interface;
+	}
+
+	return NULL;
+}
+
+static struct interface *netsock_find_interface(struct globals *globals,
+						const char *name)
+{
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (strcmp(name, interface->interface) == 0)
+			return interface;
+	}
+
+	return NULL;
+}
+
+int netsock_set_interfaces(struct globals *globals, char *interfaces)
+{
+	char *input, *saveptr, *token;
+	struct interface *interface;
+
+	netsock_close_all(globals);
+
+	input = interfaces;
+	while ((token = strtok_r(input, ",", &saveptr))) {
+		input = NULL;
+
+		interface = netsock_find_interface(globals, token);
+		if (interface)
+			continue;
+
+		interface = malloc(sizeof(*interface));
+		if (!interface) {
+			netsock_close_all(globals);
+			return -ENOMEM;
+		}
+
+		memset(&interface->hwaddr, 0, sizeof(interface->hwaddr));
+		memset(&interface->address, 0, sizeof(interface->address));
+		interface->scope_id = 0;
+		interface->interface = NULL;
+		interface->netsock = -1;
+
+		interface->interface = strdup(token);
+		if (!interface->interface) {
+			free(interface);
+			netsock_close_all(globals);
+			return -ENOMEM;
+		}
+
+		list_add(&interface->list, &globals->interfaces);
+	}
+
+	return 0;
+}
+
+static int netsock_open(struct interface *interface)
 {
 	int sock;
 	struct sockaddr_in6 sin6;
 	struct ifreq ifr;
 	int ret;
 
-	globals->netsock = -1;
+	interface->netsock = -1;
 
 	sock = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDP);
 	if (sock  < 0) {
@@ -59,14 +136,14 @@ int netsock_open(struct globals *globals)
 	}
 
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	strncpy(ifr.ifr_name, interface->interface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
 		perror("can't get interface");
 		goto err;
 	}
 
-	globals->scope_id = ifr.ifr_ifindex;
+	interface->scope_id = ifr.ifr_ifindex;
 
 	memset(&sin6, 0, sizeof(sin6));
 	sin6.sin6_port = htons(ALFRED_PORT);
@@ -79,11 +156,11 @@ int netsock_open(struct globals *globals)
 		goto err;
 	}
 
-	memcpy(&globals->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
-	mac_to_ipv6(&globals->hwaddr, &globals->address);
+	memcpy(&interface->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
+	mac_to_ipv6(&interface->hwaddr, &interface->address);
 
-	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE,
-		       globals->interface, strlen(globals->interface) + 1)) {
+	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, interface->interface,
+		       strlen(interface->interface) + 1)) {
 		perror("can't bind to device");
 		goto err;
 	}
@@ -105,10 +182,94 @@ int netsock_open(struct globals *globals)
 		goto err;
 	}
 
-	globals->netsock = sock;
+	interface->netsock = sock;
 
 	return 0;
 err:
 	close(sock);
 	return -1;
 }
+
+int netsock_open_all(struct globals *globals)
+{
+	int num_socks = 0;
+	int ret;
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		ret = netsock_open(interface);
+		if (ret >= 0)
+			num_socks++;
+	}
+
+	return num_socks;
+}
+
+void netsock_reopen(struct globals *globals)
+{
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (interface->netsock < 0)
+			netsock_open(interface);
+	}
+}
+
+int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock)
+{
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (interface->netsock >= 0) {
+			FD_SET(interface->netsock, fds);
+			if (maxsock < interface->netsock)
+				maxsock = interface->netsock;
+		}
+	}
+
+	return maxsock;
+}
+
+void netsock_check_error(struct globals *globals, fd_set *errfds)
+{
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (interface->netsock >= 0 &&
+		    FD_ISSET(interface->netsock, errfds)) {
+			fprintf(stderr, "Error on netsock detected\n");
+			close(interface->netsock);
+			interface->netsock = -1;
+		}
+	}
+}
+
+int netsock_receive_packet(struct globals *globals, fd_set *fds)
+{
+	struct interface *interface;
+	int recvs = 0;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (interface->netsock >= 0 &&
+		    FD_ISSET(interface->netsock, fds)) {
+			recv_alfred_packet(globals, interface);
+			recvs++;
+		}
+	}
+
+	return recvs;
+}
+
+int netsock_own_address(const struct globals *globals,
+			const struct in6_addr *address)
+{
+	struct interface *interface;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		if (0 == memcmp(address, &interface->address,
+				sizeof(*address)))
+			return 1;
+	}
+
+	return 0;
+}
diff --git a/packet.h b/packet.h
index dc06d65..87ad263 100644
--- a/packet.h
+++ b/packet.h
@@ -149,13 +149,13 @@ struct alfred_modeswitch_v0 {
 /**
  * struct alfred_change_interface_v0 - Request to change the interface
  * @header: TLV header describing the complete packet
- * @iface: interface name to be changed to
+ * @ifaces: interface list (comma separated) to be changed to
  *
  * Sent to the daemon by client
  */
 struct alfred_change_interface_v0 {
 	struct alfred_tlv header;
-	char iface[IFNAMSIZ];
+	char ifaces[IFNAMSIZ * 16];
 } __packed;
 
 
diff --git a/recv.c b/recv.c
index 2948547..6a257d7 100644
--- a/recv.c
+++ b/recv.c
@@ -287,6 +287,7 @@ process_alfred_announce_master(struct globals *globals,
 
 
 static int process_alfred_request(struct globals *globals,
+				  struct interface *interface,
 				  struct in6_addr *source,
 				  struct alfred_request_v0 *request)
 {
@@ -300,8 +301,8 @@ static int process_alfred_request(struct globals *globals,
 	if (len != (sizeof(*request) - sizeof(request->header)))
 		return -1;
 
-	push_data(globals, source, SOURCE_SYNCED, request->requested_type,
-		  request->tx_id);
+	push_data(globals, interface, source, SOURCE_SYNCED,
+		  request->requested_type, request->tx_id);
 
 	return 0;
 }
@@ -370,7 +371,7 @@ static int process_alfred_status_txend(struct globals *globals,
 }
 
 
-int recv_alfred_packet(struct globals *globals)
+int recv_alfred_packet(struct globals *globals, struct interface *interface)
 {
 	uint8_t buf[MAX_PAYLOAD];
 	ssize_t length;
@@ -378,11 +379,11 @@ int recv_alfred_packet(struct globals *globals)
 	struct sockaddr_in6 source;
 	socklen_t sourcelen;
 
-	if (globals->netsock < 0)
+	if (interface->netsock < 0)
 		return -1;
 
 	sourcelen = sizeof(source);
-	length = recvfrom(globals->netsock, buf, sizeof(buf), 0,
+	length = recvfrom(interface->netsock, buf, sizeof(buf), 0,
 			  (struct sockaddr *)&source, &sourcelen);
 	if (length <= 0) {
 		perror("read from network socket failed");
@@ -396,8 +397,7 @@ int recv_alfred_packet(struct globals *globals)
 		return -1;
 
 	/* drop packets from ourselves */
-	if (0 == memcmp(&source.sin6_addr, &globals->address,
-			sizeof(source.sin6_addr)))
+	if (netsock_own_address(globals, &source.sin6_addr))
 		return -1;
 
 	/* drop truncated packets */
@@ -418,7 +418,7 @@ int recv_alfred_packet(struct globals *globals)
 					       (struct alfred_announce_master_v0 *)packet);
 		break;
 	case ALFRED_REQUEST:
-		process_alfred_request(globals, &source.sin6_addr,
+		process_alfred_request(globals, interface, &source.sin6_addr,
 				       (struct alfred_request_v0 *)packet);
 		break;
 	case ALFRED_STATUS_TXEND:
diff --git a/send.c b/send.c
index 32b7cbb..c1379bd 100644
--- a/send.c
+++ b/send.c
@@ -26,30 +26,32 @@
 #include <sys/socket.h>
 #include <errno.h>
 #include <stdio.h>
+#include <unistd.h>
 #include "alfred.h"
 #include "hash.h"
 #include "packet.h"
+#include "list.h"
 
 int announce_master(struct globals *globals)
 {
 	struct alfred_announce_master_v0 announcement;
+	struct interface *interface;
 
-	if (globals->netsock < 0)
-		return -1;
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		announcement.header.type = ALFRED_ANNOUNCE_MASTER;
+		announcement.header.version = ALFRED_VERSION;
+		announcement.header.length = htons(0);
 
-	announcement.header.type = ALFRED_ANNOUNCE_MASTER;
-	announcement.header.version = ALFRED_VERSION;
-	announcement.header.length = htons(0);
-
-	send_alfred_packet(globals, &in6addr_localmcast, &announcement,
-			   sizeof(announcement));
+		send_alfred_packet(interface, &in6addr_localmcast,
+				   &announcement, sizeof(announcement));
+	}
 
 	return 0;
 }
 
-int push_data(struct globals *globals, struct in6_addr *destination,
-	      enum data_source max_source_level, int type_filter,
-	      uint16_t tx_id)
+int push_data(struct globals *globals, struct interface *interface,
+	      struct in6_addr *destination, enum data_source max_source_level,
+	      int type_filter, uint16_t tx_id)
 {
 	struct hash_it_t *hashit = NULL;
 	uint8_t buf[MAX_PAYLOAD];
@@ -84,7 +86,7 @@ int push_data(struct globals *globals, struct in6_addr *destination,
 			tlv_length += sizeof(*push) - sizeof(push->header);
 			push->header.length = htons(tlv_length);
 			push->tx.seqno = htons(seqno++);
-			send_alfred_packet(globals, destination, push,
+			send_alfred_packet(interface, destination, push,
 					   sizeof(*push) + total_length);
 			total_length = 0;
 		}
@@ -103,7 +105,7 @@ int push_data(struct globals *globals, struct in6_addr *destination,
 		tlv_length += sizeof(*push) - sizeof(push->header);
 		push->header.length = htons(tlv_length);
 		push->tx.seqno = htons(seqno++);
-		send_alfred_packet(globals, destination, push,
+		send_alfred_packet(interface, destination, push,
 				   sizeof(*push) + total_length);
 	}
 
@@ -117,7 +119,7 @@ int push_data(struct globals *globals, struct in6_addr *destination,
 		status_end.tx.id = tx_id;
 		status_end.tx.seqno = htons(seqno);
 
-		send_alfred_packet(globals, destination, &status_end,
+		send_alfred_packet(interface, destination, &status_end,
 				sizeof(status_end));
 	}
 
@@ -128,31 +130,40 @@ int push_data(struct globals *globals, struct in6_addr *destination,
 int sync_data(struct globals *globals)
 {
 	struct hash_it_t *hashit = NULL;
+	struct interface *interface;
 
 	/* send local data and data from our clients to (all) other servers */
-	while (NULL != (hashit = hash_iterate(globals->server_hash, hashit))) {
-		struct server *server = hashit->bucket->data;
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		while (NULL != (hashit = hash_iterate(globals->server_hash,
+						      hashit))) {
+			struct server *server = hashit->bucket->data;
 
-		push_data(globals, &server->address, SOURCE_FIRST_HAND,
-			  NO_FILTER, get_random_id());
+			push_data(globals, interface, &server->address,
+				  SOURCE_FIRST_HAND, NO_FILTER,
+				  get_random_id());
+		}
 	}
 	return 0;
 }
 
 int push_local_data(struct globals *globals)
 {
+	struct interface *interface;
+
 	/* no server - yet */
 	if (!globals->best_server)
 		return -1;
 
-	push_data(globals, &globals->best_server->address, SOURCE_LOCAL,
-		  NO_FILTER, get_random_id());
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		push_data(globals, interface, &globals->best_server->address,
+			  SOURCE_LOCAL, NO_FILTER, get_random_id());
+	}
 
 	return 0;
 }
 
-ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
-			   void *buf, int length)
+ssize_t send_alfred_packet(struct interface *interface,
+			   const struct in6_addr *dest, void *buf, int length)
 {
 	ssize_t ret;
 	struct sockaddr_in6 dest_addr;
@@ -160,19 +171,19 @@ ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
 	memset(&dest_addr, 0, sizeof(dest_addr));
 	dest_addr.sin6_family = AF_INET6;
 	dest_addr.sin6_port = htons(ALFRED_PORT);
-	dest_addr.sin6_scope_id = globals->scope_id;
+	dest_addr.sin6_scope_id = interface->scope_id;
 	memcpy(&dest_addr.sin6_addr, dest, sizeof(*dest));
 
-	if (globals->netsock < 0)
+	if (interface->netsock < 0)
 		return 0;
 
-	ret = sendto(globals->netsock, buf, length, 0,
+	ret = sendto(interface->netsock, buf, length, 0,
 		     (struct sockaddr *)&dest_addr,
 		     sizeof(struct sockaddr_in6));
 	if (ret == -EPERM) {
 		perror("Error during sent");
-		netsock_close(globals->netsock);
-		globals->netsock = -1;
+		close(interface->netsock);
+		interface->netsock = -1;
 	}
 
 	return ret;
diff --git a/server.c b/server.c
index 94e6145..e45bc8a 100644
--- a/server.c
+++ b/server.c
@@ -32,11 +32,13 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
+#include <sys/types.h>
 #include <unistd.h>
 #include <time.h>
 #include "alfred.h"
 #include "batadv_query.h"
 #include "hash.h"
+#include "list.h"
 
 static int server_compare(void *d1, void *d2)
 {
@@ -217,21 +219,12 @@ static int purge_data(struct globals *globals)
 	return 0;
 }
 
-static void check_if_socket(struct globals *globals)
+static void check_if_socket(struct interface *interface)
 {
-	struct timespec now, diff;
 	int sock;
 	struct ifreq ifr;
 
-	clock_gettime(CLOCK_MONOTONIC, &now);
-	time_diff(&now, &globals->if_check, &diff);
-
-	if (diff.tv_sec < ALFRED_IF_CHECK_INTERVAL)
-		return;
-
-	globals->if_check = now;
-
-	if (globals->netsock < 0)
+	if (interface->netsock < 0)
 		return;
 
 	sock = socket(PF_INET6, SOCK_DGRAM, 0);
@@ -241,17 +234,17 @@ static void check_if_socket(struct globals *globals)
 	}
 
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	strncpy(ifr.ifr_name, interface->interface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
 		perror("can't get interface, closing netsock");
 		goto close;
 	}
 
-	if (globals->scope_id != (uint32_t)ifr.ifr_ifindex) {
+	if (interface->scope_id != (uint32_t)ifr.ifr_ifindex) {
 		fprintf(stderr,
 			"iface index changed from %"PRIu32" to %d, closing netsock\n",
-			globals->scope_id, ifr.ifr_ifindex);
+			interface->scope_id, ifr.ifr_ifindex);
 		goto close;
 	}
 
@@ -260,7 +253,7 @@ static void check_if_socket(struct globals *globals)
 		goto close;
 	}
 
-	if (memcmp(&globals->hwaddr, &ifr.ifr_hwaddr.sa_data, 6) != 0) {
+	if (memcmp(&interface->hwaddr, &ifr.ifr_hwaddr.sa_data, 6) != 0) {
 		fprintf(stderr, "iface mac changed, closing netsock\n");
 		goto close;
 	}
@@ -269,16 +262,34 @@ static void check_if_socket(struct globals *globals)
 	return;
 
 close:
-	netsock_close(globals->netsock);
-	globals->netsock = -1;
+	close(interface->netsock);
+	interface->netsock = -1;
 	close(sock);
 }
 
+static void check_if_sockets(struct globals *globals)
+{
+	struct timespec now, diff;
+	struct interface *interface;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	time_diff(&now, &globals->if_check, &diff);
+
+	if (diff.tv_sec < ALFRED_IF_CHECK_INTERVAL)
+		return;
+
+	globals->if_check = now;
+
+	list_for_each_entry(interface, &globals->interfaces, list)
+		check_if_socket(interface);
+}
+
 int alfred_server(struct globals *globals)
 {
-	int maxsock, ret;
+	int maxsock, ret, recvs;
 	struct timespec last_check, now, tv;
 	fd_set fds, errfds;
+	int num_socks;
 
 	if (create_hashes(globals))
 		return -1;
@@ -286,7 +297,7 @@ int alfred_server(struct globals *globals)
 	if (unix_sock_open_daemon(globals))
 		return -1;
 
-	if (!globals->interface) {
+	if (list_empty(&globals->interfaces)) {
 		fprintf(stderr, "Can't start server: interface missing\n");
 		return -1;
 	}
@@ -295,8 +306,16 @@ int alfred_server(struct globals *globals)
 	    batadv_interface_check(globals->mesh_iface) < 0)
 		return -1;
 
-	if (netsock_open(globals))
+	num_socks = netsock_open_all(globals);
+	if (num_socks <= 0) {
+		fprintf(stderr, "Failed to open interfaces\n");
 		return -1;
+	}
+
+	if (num_socks > 1 && globals->opmode == OPMODE_SLAVE) {
+		fprintf(stderr, "More than one interface specified in slave mode\n");
+		return -1;
+	}
 
 	clock_gettime(CLOCK_MONOTONIC, &last_check);
 	globals->if_check = last_check;
@@ -309,42 +328,31 @@ int alfred_server(struct globals *globals)
 			tv.tv_nsec = 0;
 		}
 
-		if (globals->netsock < 0)
-			netsock_open(globals);
-
-		maxsock = -1;
-		if (globals->netsock > maxsock)
-			maxsock = globals->netsock;
-		if (globals->unix_sock > maxsock)
-			maxsock = globals->unix_sock;
+		netsock_reopen(globals);
 
 		FD_ZERO(&fds);
 		FD_ZERO(&errfds);
 		FD_SET(globals->unix_sock, &fds);
-		if (globals->netsock >= 0) {
-			FD_SET(globals->netsock, &fds);
-			FD_SET(globals->netsock, &errfds);
-		}
+		maxsock = globals->unix_sock;
+
+		maxsock = netsock_prepare_select(globals, &fds, maxsock);
+		maxsock = netsock_prepare_select(globals, &errfds, maxsock);
+
 		ret = pselect(maxsock + 1, &fds, NULL, &errfds, &tv, NULL);
 
 		if (ret == -1) {
 			perror("main loop select failed ...");
 		} else if (ret) {
-			if (globals->netsock >= 0 &&
-			    FD_ISSET(globals->netsock, &errfds)) {
-				fprintf(stderr, "Error on netsock detected\n");
-				netsock_close(globals->netsock);
-				globals->netsock = -1;
-			}
+			netsock_check_error(globals, &errfds);
 
 			if (FD_ISSET(globals->unix_sock, &fds)) {
 				printf("read unix socket\n");
 				unix_sock_read(globals);
 				continue;
-			} else if (globals->netsock >= 0 &&
-				   FD_ISSET(globals->netsock, &fds)) {
-				recv_alfred_packet(globals);
-				continue;
+			} else {
+				recvs = netsock_receive_packet(globals, &fds);
+				if (recvs > 0)
+					continue;
 			}
 		}
 		clock_gettime(CLOCK_MONOTONIC, &last_check);
@@ -359,11 +367,10 @@ int alfred_server(struct globals *globals)
 			push_local_data(globals);
 		}
 		purge_data(globals);
-		check_if_socket(globals);
+		check_if_sockets(globals);
 	}
 
-	if (globals->netsock >= 0)
-		netsock_close(globals->netsock);
+	netsock_close_all(globals);
 	unix_sock_close(globals);
 	return 0;
 }
diff --git a/unix_sock.c b/unix_sock.c
index 516c0a5..8a99327 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -31,6 +31,7 @@
 #include <sys/un.h>
 #include <time.h>
 #include <unistd.h>
+#include <errno.h>
 #include "alfred.h"
 #include "hash.h"
 #include "packet.h"
@@ -98,6 +99,11 @@ static int unix_sock_add_data(struct globals *globals,
 	struct alfred_data *data;
 	struct dataset *dataset;
 	int len, data_len, ret = -1;
+	struct interface *interface;
+
+	interface = netsock_first_interface(globals);
+	if (!interface)
+		goto err;
 
 	len = ntohs(push->header.length);
 
@@ -112,7 +118,7 @@ static int unix_sock_add_data(struct globals *globals,
 
 	data = push->data;
 	data_len = ntohs(data->header.length);
-	memcpy(data->source, &globals->hwaddr, sizeof(globals->hwaddr));
+	memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
 
 	if ((int)(data_len + sizeof(*data)) > len)
 		goto err;
@@ -204,6 +210,7 @@ static int unix_sock_req_data(struct globals *globals,
 	int len;
 	uint16_t id;
 	struct transaction_head *head = NULL;
+	struct interface *interface;
 
 	len = ntohs(request->header.length);
 
@@ -212,8 +219,10 @@ static int unix_sock_req_data(struct globals *globals,
 
 	id = ntohs(request->tx_id);
 
+	interface = netsock_first_interface(globals);
+
 	/* no server to send the request to, only give back what we have now. */
-	if (!globals->best_server)
+	if (!globals->best_server || !interface)
 		return unix_sock_req_data_reply(globals, client_sock, id,
 						request->requested_type);
 
@@ -229,7 +238,7 @@ static int unix_sock_req_data(struct globals *globals,
 	head->client_socket = client_sock;
 	head->requested_type = request->requested_type;
 
-	send_alfred_packet(globals, &globals->best_server->address,
+	send_alfred_packet(interface, &globals->best_server->address,
 			   request, sizeof(*request));
 
 	return 0;
@@ -283,6 +292,9 @@ static int unix_sock_modesw(struct globals *globals,
 
 	switch (modeswitch->mode) {
 	case ALFRED_MODESWITCH_SLAVE:
+		if (!list_is_singular(&globals->interfaces))
+			goto err;
+
 		globals->opmode = OPMODE_SLAVE;
 		break;
 	case ALFRED_MODESWITCH_MASTER:
@@ -304,25 +316,21 @@ unix_sock_change_iface(struct globals *globals,
 		       int client_sock)
 {
 	int len, ret = -1;
-	char *iface;
 
 	len = ntohs(change_iface->header.length);
 
 	if (len < (int)(sizeof(*change_iface) - sizeof(change_iface->header)))
 		goto err;
 
-	iface = malloc(IFNAMSIZ + 1);
-	if (!iface)
-		goto err;
+	if (globals->opmode == OPMODE_SLAVE) {
+		if (strstr(change_iface->ifaces, ",") != NULL) {
+			ret = -EINVAL;
+			fprintf(stderr, "Tried to set multiple interfaces in slave mode\n");
+			goto err;
+		}
+	}
 
-	memcpy(iface, change_iface->iface, IFNAMSIZ);
-	iface[IFNAMSIZ] = 0;
-
-	netsock_close(globals->netsock);
-
-	free(globals->interface);
-	globals->interface = iface;
-	netsock_open(globals);
+	netsock_set_interfaces(globals, change_iface->ifaces);
 
 	ret = 0;
 err:
-- 
2.1.3

