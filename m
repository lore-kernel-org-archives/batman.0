Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Thu, 19 Jan 2017 21:01:04 -0700
Message-ID: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
	support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

Enabled via -4 expert option where multicast group address is specified.
This option will disable IPv6 communication and is intended for use in
networks which do not support IPv6 addressing.

When this option is enabled, all IPv6 communication is disabled. Combining
IPv4 and IPv6 alfred nodes is unsupported.

Hardware address handling done by submitting queries to the local ARP
cache rather than forcing an ARP request.

Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
---
 README         |   4 +-
 alfred.h       |  23 ++++++---
 batadv_query.c |  50 +++++++++++-------
 batadv_query.h |   6 ++-
 client.c       |   2 +-
 main.c         |  14 ++++--
 man/alfred.8   |   5 ++
 netsock.c      | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 recv.c         |  63 ++++++++++++++++-------
 send.c         |  48 +++++++++++-------
 server.c       |   8 +--
 unix_sock.c    |   2 +-
 util.c         |  30 +++++++++++
 13 files changed, 328 insertions(+), 83 deletions(-)

diff --git a/README b/README
index bc1c3bc..28f3dc9 100644
--- a/README
+++ b/README
@@ -20,7 +20,9 @@ programs to communicate with alfred (done via unix sockets). alfred then takes
 care of distributing the local information to other alfred servers on other
 nodes. This is done via IPv6 link-local multicast, and does not require any
 configuration. A user can request data from alfred, and will receive the
-information available from all alfred servers in the network.
+information available from all alfred servers in the network. Alternatively,
+alfred can be configured to distribute the local information via IPv4 multicast.
+This is configured by setting the IPv4 multicast group address in the -4 option.
 
 Compilation
 -----------
diff --git a/alfred.h b/alfred.h
index 2e8db1e..6bdaac7 100644
--- a/alfred.h
+++ b/alfred.h
@@ -48,6 +48,11 @@ enum data_source {
 	SOURCE_SYNCED = 2,
 };
 
+typedef union {
+	struct in_addr ipv4;
+	struct in6_addr ipv6;
+} alfred_addr;
+
 struct dataset {
 	struct alfred_data data;
 	unsigned char *buf;
@@ -80,7 +85,7 @@ struct transaction_head {
 
 struct server {
 	struct ether_addr hwaddr;
-	struct in6_addr address;
+	alfred_addr address;
 	struct timespec last_seen;
 	uint8_t tq;
 };
@@ -100,11 +105,12 @@ enum clientmode {
 
 struct interface {
 	struct ether_addr hwaddr;
-	struct in6_addr address;
+	alfred_addr address;
 	uint32_t scope_id;
 	char *interface;
 	int netsock;
 	int netsock_mcast;
+	int netsock_arp;
 
 	struct hashtable_t *server_hash;
 
@@ -122,6 +128,7 @@ struct globals {
 	int clientmode_arg;
 	int clientmode_version;
 	int verbose;
+	int ipv4mode;
 
 	int unix_sock;
 	const char *unix_path;
@@ -142,7 +149,7 @@ struct globals {
 
 #define MAX_PAYLOAD ((1 << 16) - 1 - sizeof(struct udphdr))
 
-extern const struct in6_addr in6addr_localmcast;
+extern alfred_addr alfred_mcast;
 
 /* server.c */
 int alfred_server(struct globals *globals);
@@ -169,13 +176,13 @@ static inline bool transaction_finished(struct transaction_head *head)
 
 /* send.c */
 int push_data(struct globals *globals, struct interface *interface,
-	      struct in6_addr *destination, enum data_source max_source_level,
+	      alfred_addr *destination, enum data_source max_source_level,
 	      int type_filter, uint16_t tx_id);
 int announce_master(struct globals *globals);
 int push_local_data(struct globals *globals);
 int sync_data(struct globals *globals);
-ssize_t send_alfred_packet(struct interface *interface,
-			   const struct in6_addr *dest, void *buf, int length);
+ssize_t send_alfred_packet(struct globals *globals, struct interface *interface,
+			   const alfred_addr *dest, void *buf, int length);
 /* unix_sock.c */
 int unix_sock_read(struct globals *globals);
 int unix_sock_open_daemon(struct globals *globals);
@@ -195,10 +202,12 @@ int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock);
 void netsock_check_error(struct globals *globals, fd_set *errfds);
 int netsock_receive_packet(struct globals *globals, fd_set *fds);
 int netsock_own_address(const struct globals *globals,
-			const struct in6_addr *address);
+			const alfred_addr *address);
 /* util.c */
 int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff);
 void time_random_seed(void);
 uint16_t get_random_id(void);
 bool is_valid_ether_addr(uint8_t *addr);
+int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
+		     struct ether_addr *mac);
diff --git a/batadv_query.c b/batadv_query.c
index ac45b9b..6ec086b 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -80,22 +80,22 @@ out:
 	return ret;
 }
 
-int mac_to_ipv6(const struct ether_addr *mac, struct in6_addr *addr)
+int mac_to_ipv6(const struct ether_addr *mac, alfred_addr *addr)
 {
 	memset(addr, 0, sizeof(*addr));
-	addr->s6_addr[0] = 0xfe;
-	addr->s6_addr[1] = 0x80;
+	addr->ipv6.s6_addr[0] = 0xfe;
+	addr->ipv6.s6_addr[1] = 0x80;
 
-	addr->s6_addr[8] = mac->ether_addr_octet[0] ^ 0x02;
-	addr->s6_addr[9] = mac->ether_addr_octet[1];
-	addr->s6_addr[10] = mac->ether_addr_octet[2];
+	addr->ipv6.s6_addr[8] = mac->ether_addr_octet[0] ^ 0x02;
+	addr->ipv6.s6_addr[9] = mac->ether_addr_octet[1];
+	addr->ipv6.s6_addr[10] = mac->ether_addr_octet[2];
 
-	addr->s6_addr[11] = 0xff;
-	addr->s6_addr[12] = 0xfe;
+	addr->ipv6.s6_addr[11] = 0xff;
+	addr->ipv6.s6_addr[12] = 0xfe;
 
-	addr->s6_addr[13] = mac->ether_addr_octet[3];
-	addr->s6_addr[14] = mac->ether_addr_octet[4];
-	addr->s6_addr[15] = mac->ether_addr_octet[5];
+	addr->ipv6.s6_addr[13] = mac->ether_addr_octet[3];
+	addr->ipv6.s6_addr[14] = mac->ether_addr_octet[4];
+	addr->ipv6.s6_addr[15] = mac->ether_addr_octet[5];
 
 	return 0;
 }
@@ -118,17 +118,29 @@ int is_ipv6_eui64(const struct in6_addr *addr)
 	return 1;
 }
 
-int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
+int ipv6_to_mac(const alfred_addr *addr, struct ether_addr *mac)
 {
-	if (!is_ipv6_eui64(addr))
+	if (!is_ipv6_eui64(&addr->ipv6))
 		return -EINVAL;
 
-	mac->ether_addr_octet[0] = addr->s6_addr[8] ^ 0x02;
-	mac->ether_addr_octet[1] = addr->s6_addr[9];
-	mac->ether_addr_octet[2] = addr->s6_addr[10];
-	mac->ether_addr_octet[3] = addr->s6_addr[13];
-	mac->ether_addr_octet[4] = addr->s6_addr[14];
-	mac->ether_addr_octet[5] = addr->s6_addr[15];
+	mac->ether_addr_octet[0] = addr->ipv6.s6_addr[8] ^ 0x02;
+	mac->ether_addr_octet[1] = addr->ipv6.s6_addr[9];
+	mac->ether_addr_octet[2] = addr->ipv6.s6_addr[10];
+	mac->ether_addr_octet[3] = addr->ipv6.s6_addr[13];
+	mac->ether_addr_octet[4] = addr->ipv6.s6_addr[14];
+	mac->ether_addr_octet[5] = addr->ipv6.s6_addr[15];
+
+	if (!is_valid_ether_addr(mac->ether_addr_octet))
+		return -EINVAL;
+
+	return 0;
+}
+
+int ipv4_to_mac(struct interface *interface,
+		const alfred_addr *addr, struct ether_addr *mac)
+{
+	if (ipv4_arp_request(interface, addr, mac) < 0)
+		return -EINVAL;
 
 	if (!is_valid_ether_addr(mac->ether_addr_octet))
 		return -EINVAL;
diff --git a/batadv_query.h b/batadv_query.h
index 0df8a35..9aa4f0e 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -28,8 +28,10 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac);
 uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac);
 int batadv_interface_check(const char *mesh_iface);
-int mac_to_ipv6(const struct ether_addr *mac, struct in6_addr *addr);
-int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac);
+int mac_to_ipv6(const struct ether_addr *mac, alfred_addr *addr);
+int ipv6_to_mac(const alfred_addr *addr, struct ether_addr *mac);
+int ipv4_to_mac(struct interface *interface,
+		const alfred_addr *addr, struct ether_addr *mac);
 int is_ipv6_eui64(const struct in6_addr *addr);
 
 #endif
diff --git a/client.c b/client.c
index 357fdb9..4102046 100644
--- a/client.c
+++ b/client.c
@@ -239,7 +239,7 @@ static int check_interface(const char *iface)
 		return -1;
 	}
 
-	sock = socket(PF_INET6, SOCK_DGRAM, 0);
+	sock = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sock < 0) {
 		perror("can't open socket");
 		return -1;
diff --git a/main.c b/main.c
index 0d30ea4..446eecf 100644
--- a/main.c
+++ b/main.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <arpa/inet.h>
 #include <getopt.h>
 #include <signal.h>
 #include <stdio.h>
@@ -61,6 +62,7 @@ static void alfred_usage(void)
 	printf("                                      other masters\n");
 	printf("  -p, --sync-period [period]          set synchronization period, in seconds\n");
 	printf("                                      fractional seconds are supported (i.e. 0.2 = 5 Hz)\n");
+	printf("  -4 [group-address]                  specify IPv4 multicast address and operate in IPv4 mode");
 	printf("\n");
 	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
 	printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
@@ -196,6 +198,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->mesh_iface = "bat0";
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 	globals->verbose = 0;
+	globals->ipv4mode = 0;
 	globals->update_command = NULL;
 	globals->sync_period.tv_sec = ALFRED_INTERVAL;
 	globals->sync_period.tv_nsec = 0;
@@ -204,7 +207,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:p:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:p:4:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -273,10 +276,15 @@ static struct globals *alfred_init(int argc, char *argv[])
 			return NULL;
 		case 'p':
 			sync_period = strtod(optarg, NULL);
-			globals->sync_period.tv_sec = (int) sync_period;
-			globals->sync_period.tv_nsec = (double) (sync_period - (int) sync_period) * 1e9;
+			globals->sync_period.tv_sec = (int)sync_period;
+			globals->sync_period.tv_nsec = (double)(sync_period - (int)sync_period) * 1e9;
 			printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
 			break;
+		case '4':
+			globals->ipv4mode = 1;
+			inet_pton(AF_INET, optarg, &alfred_mcast.ipv4);
+			printf(" ** IPv4 Multicast Mode: %x\n", alfred_mcast.ipv4.s_addr);
+			break;
 		case 'h':
 		default:
 			alfred_usage();
diff --git a/man/alfred.8 b/man/alfred.8
index 5936e64..a2c3d4c 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -123,6 +123,11 @@ as arguments.
 Specify alfred synchronization period, in seconds. If not specified, the default
 ALFRED_INTERVAL setting of 10 seconds will be used. Fractional seconds are
 supported.
+.TP
+\fB\-4 \fIgroup-address\fP \fP
+Specify the IPv4 multicast group address and enable IPv4 data-sharing (disabling
+IPv6 communication). This option is required on systems that do not support IPv6
+addressing.
 .
 .SH EXAMPLES
 Start an alfred server listening on bridge br0 (assuming that this bridge
diff --git a/netsock.c b/netsock.c
index 86db8a6..3ddde69 100644
--- a/netsock.c
+++ b/netsock.c
@@ -43,10 +43,12 @@
 #include "list.h"
 #include "hash.h"
 
-const struct in6_addr in6addr_localmcast = {{{ 0xff, 0x02, 0x00, 0x00,
-					       0x00, 0x00, 0x00, 0x00,
-					       0x00, 0x00, 0x00, 0x00,
-					       0x00, 0x00, 0x00, 0x01 } } };
+alfred_addr alfred_mcast = {
+		.ipv6 = {{{ 0xff, 0x02, 0x00, 0x00,
+			    0x00, 0x00, 0x00, 0x00,
+			    0x00, 0x00, 0x00, 0x00,
+			    0x00, 0x00, 0x00, 0x01 } } }
+};
 
 static int server_compare(void *d1, void *d2)
 {
@@ -262,7 +264,7 @@ static int netsock_open(struct interface *interface)
 	memset(&sin6_mc, 0, sizeof(sin6_mc));
 	sin6_mc.sin6_port = htons(ALFRED_PORT);
 	sin6_mc.sin6_family = AF_INET6;
-	memcpy(&sin6_mc.sin6_addr, &in6addr_localmcast,
+	memcpy(&sin6_mc.sin6_addr, &alfred_mcast,
 	       sizeof(sin6_mc.sin6_addr));
 	sin6_mc.sin6_scope_id = interface->scope_id;
 
@@ -291,7 +293,7 @@ static int netsock_open(struct interface *interface)
 		goto err;
 	}
 
-	memcpy(&mreq.ipv6mr_multiaddr, &in6addr_localmcast,
+	memcpy(&mreq.ipv6mr_multiaddr, &alfred_mcast,
 	       sizeof(mreq.ipv6mr_multiaddr));
 	mreq.ipv6mr_interface = interface->scope_id;
 
@@ -335,6 +337,132 @@ err:
 	return -1;
 }
 
+static int netsock_open4(struct interface *interface)
+{
+	int sock;
+	int sock_mc;
+	struct sockaddr_in sin4, sin_mc;
+	struct ip_mreq mreq;
+	struct ifreq ifr;
+	int ret;
+
+	interface->netsock = -1;
+	interface->netsock_mcast = -1;
+
+	sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock  < 0) {
+		perror("ipv4: can't open socket");
+		return -1;
+	}
+
+	sock_mc = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock_mc  < 0) {
+		perror("ipv4: can't open mc socket");
+		return -1;
+	}
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, interface->interface, IFNAMSIZ);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
+	if (ioctl(sock_mc, SIOCGIFHWADDR, &ifr) == -1) {
+		perror("ipv4: can't get MAC address");
+		goto err4;
+	}
+	memcpy(&interface->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
+
+	memset(&sin4, 0, sizeof(sin4));
+	sin4.sin_port = htons(ALFRED_PORT);
+	sin4.sin_family = AF_INET;
+	sin4.sin_addr.s_addr = INADDR_ANY;
+
+	memset(&sin_mc, 0, sizeof(sin_mc));
+	sin_mc.sin_port = htons(ALFRED_PORT);
+	sin_mc.sin_family = AF_INET;
+	memcpy(&sin_mc.sin_addr, &alfred_mcast, sizeof(sin_mc.sin_addr));
+
+	enable_raw_bind_capability(1);
+	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, interface->interface,
+		       strlen(interface->interface) + 1)) {
+		perror("ipv4: can't bind to device");
+		goto err4;
+	}
+
+	if (setsockopt(sock_mc, SOL_SOCKET, SO_BINDTODEVICE,
+		       interface->interface, strlen(interface->interface) + 1)) {
+		perror("ipv4: can't bind to device");
+		goto err4;
+	}
+	enable_raw_bind_capability(0);
+
+	ret = 1;
+	if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &ret, sizeof(ret)) < 0) {
+		perror("ipv4: can't set reuse flag");
+		goto err4;
+	}
+	if (setsockopt(sock_mc, SOL_SOCKET, SO_REUSEADDR, &ret, sizeof(ret)) < 0) {
+		perror("ipv4: can't set mc reuse flag");
+		goto err4;
+	}
+
+	if (bind(sock, (struct sockaddr *)&sin4, sizeof(sin4)) < 0) {
+		perror("ipv4: can't bind");
+		goto err4;
+	}
+
+	if (bind(sock_mc, (struct sockaddr *)&sin_mc, sizeof(sin_mc)) < 0) {
+		perror("ipv4: can't bind mc");
+		goto err4;
+	}
+
+	memcpy(&mreq.imr_multiaddr, &alfred_mcast.ipv4, sizeof(mreq.imr_multiaddr));
+
+	if (ioctl(sock_mc, SIOCGIFADDR, &ifr) < 0) {
+		perror("ipv4: can't get IP address");
+		goto err4;
+	}
+	mreq.imr_interface = ((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr;
+	memcpy(&interface->address.ipv4,
+	       &((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr,
+	       sizeof(struct in_addr));
+
+	if (setsockopt(sock_mc, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq))) {
+		perror("ipv4: can't add multicast membership");
+		goto err4;
+	}
+
+	ret = fcntl(sock, F_GETFL, 0);
+	if (ret < 0) {
+		perror("failed to get file status flags");
+		goto err4;
+	}
+
+	ret = fcntl(sock, F_SETFL, ret | O_NONBLOCK);
+	if (ret < 0) {
+		perror("failed to set file status flags");
+		goto err4;
+	}
+
+	ret = fcntl(sock_mc, F_GETFL, 0);
+	if (ret < 0) {
+		perror("ipv4: failed to get file status flags");
+		goto err4;
+	}
+
+	ret = fcntl(sock_mc, F_SETFL, ret | O_NONBLOCK);
+	if (ret < 0) {
+		perror("ipv4: failed to set file status flags");
+		goto err4;
+	}
+
+	interface->netsock = sock;
+	interface->netsock_mcast = sock_mc;
+
+	return 0;
+err4:
+	close(sock_mc);
+	return -1;
+}
+
 int netsock_open_all(struct globals *globals)
 {
 	int num_socks = 0;
@@ -342,7 +470,11 @@ int netsock_open_all(struct globals *globals)
 	struct interface *interface;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
-		ret = netsock_open(interface);
+		if (globals->ipv4mode)
+			ret = netsock_open4(interface);
+		else
+			ret = netsock_open(interface);
+
 		if (ret >= 0)
 			num_socks++;
 	}
@@ -355,8 +487,12 @@ void netsock_reopen(struct globals *globals)
 	struct interface *interface;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
-		if (interface->netsock < 0)
-			netsock_open(interface);
+		if (interface->netsock < 0) {
+			if (globals->ipv4mode)
+				netsock_open4(interface);
+			else
+				netsock_open(interface);
+		}
 	}
 }
 
@@ -430,7 +566,7 @@ int netsock_receive_packet(struct globals *globals, fd_set *fds)
 }
 
 int netsock_own_address(const struct globals *globals,
-			const struct in6_addr *address)
+			const alfred_addr *address)
 {
 	struct interface *interface;
 
diff --git a/recv.c b/recv.c
index bb8cc05..3fd964d 100644
--- a/recv.c
+++ b/recv.c
@@ -190,7 +190,8 @@ static int finish_alfred_transaction(struct globals *globals,
 }
 
 static int process_alfred_push_data(struct globals *globals,
-				    struct in6_addr *source,
+				    struct interface *interface,
+				    alfred_addr *source,
 				    struct alfred_push_data_v0 *push)
 {
 	int len;
@@ -200,7 +201,10 @@ static int process_alfred_push_data(struct globals *globals,
 	struct transaction_packet *transaction_packet;
 	int found;
 
-	ret = ipv6_to_mac(source, &mac);
+	if (globals->ipv4mode)
+		ret = ipv4_to_mac(interface, source, &mac);
+	else
+		ret = ipv6_to_mac(source, &mac);
 	if (ret < 0)
 		goto err;
 
@@ -260,7 +264,7 @@ err:
 static int
 process_alfred_announce_master(struct globals *globals,
 			       struct interface *interface,
-			       struct in6_addr *source,
+			       alfred_addr *source,
 			       struct alfred_announce_master_v0 *announce)
 {
 	struct server *server;
@@ -271,7 +275,10 @@ process_alfred_announce_master(struct globals *globals,
 
 	len = ntohs(announce->header.length);
 
-	ret = ipv6_to_mac(source, &mac);
+	if (globals->ipv4mode)
+		ret = ipv4_to_mac(interface, source, &mac);
+	else
+		ret = ipv6_to_mac(source, &mac);
 	if (ret < 0)
 		return -1;
 
@@ -316,7 +323,7 @@ process_alfred_announce_master(struct globals *globals,
 
 static int process_alfred_request(struct globals *globals,
 				  struct interface *interface,
-				  struct in6_addr *source,
+				  alfred_addr *source,
 				  struct alfred_request_v0 *request)
 {
 	int len;
@@ -336,7 +343,8 @@ static int process_alfred_request(struct globals *globals,
 }
 
 static int process_alfred_status_txend(struct globals *globals,
-				       struct in6_addr *source,
+				       struct interface *interface,
+				       alfred_addr *source,
 				       struct alfred_status_v0 *request)
 {
 	struct transaction_head search, *head;
@@ -351,7 +359,10 @@ static int process_alfred_status_txend(struct globals *globals,
 	if (len != (sizeof(*request) - sizeof(request->header)))
 		return -1;
 
-	ret = ipv6_to_mac(source, &mac);
+	if (globals->ipv4mode)
+		ret = ipv4_to_mac(interface, source, &mac);
+	else
+		ret = ipv6_to_mac(source, &mac);
 	if (ret < 0)
 		return -1;
 
@@ -389,15 +400,25 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 	uint8_t buf[MAX_PAYLOAD];
 	ssize_t length;
 	struct alfred_tlv *packet;
-	struct sockaddr_in6 source;
+	struct sockaddr_in *source;
+	struct sockaddr_in source4;
+	struct sockaddr_in6 source6;
 	socklen_t sourcelen;
+	alfred_addr alfred_source;
 
 	if (interface->netsock < 0)
 		return -1;
 
-	sourcelen = sizeof(source);
+	if (globals->ipv4mode) {
+		source = (struct sockaddr_in *)&source4;
+		sourcelen = sizeof(source4);
+	} else {
+		source = (struct sockaddr_in *)&source6;
+		sourcelen = sizeof(source6);
+	}
+
 	length = recvfrom(recv_sock, buf, sizeof(buf), 0,
-			  (struct sockaddr *)&source, &sourcelen);
+			  (struct sockaddr *)source, &sourcelen);
 	if (length <= 0) {
 		perror("read from network socket failed");
 		return -1;
@@ -405,12 +426,18 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 
 	packet = (struct alfred_tlv *)buf;
 
-	/* drop packets not sent over link-local ipv6 */
-	if (!is_ipv6_eui64(&source.sin6_addr))
-		return -1;
+	if (globals->ipv4mode) {
+		memcpy(&alfred_source, &source4.sin_addr, sizeof(source4.sin_addr));
+	} else {
+		memcpy(&alfred_source, &source6.sin6_addr, sizeof(source6.sin6_addr));
+
+		/* drop packets not sent over link-local ipv6 */
+		if (!is_ipv6_eui64(&alfred_source.ipv6))
+			return -1;
+	}
 
 	/* drop packets from ourselves */
-	if (netsock_own_address(globals, &source.sin6_addr))
+	if (netsock_own_address(globals, &alfred_source))
 		return -1;
 
 	/* drop truncated packets */
@@ -424,20 +451,20 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 
 	switch (packet->type) {
 	case ALFRED_PUSH_DATA:
-		process_alfred_push_data(globals, &source.sin6_addr,
+		process_alfred_push_data(globals, interface, &alfred_source,
 					 (struct alfred_push_data_v0 *)packet);
 		break;
 	case ALFRED_ANNOUNCE_MASTER:
 		process_alfred_announce_master(globals, interface,
-					       &source.sin6_addr,
+					       &alfred_source,
 					       (struct alfred_announce_master_v0 *)packet);
 		break;
 	case ALFRED_REQUEST:
-		process_alfred_request(globals, interface, &source.sin6_addr,
+		process_alfred_request(globals, interface, &alfred_source,
 				       (struct alfred_request_v0 *)packet);
 		break;
 	case ALFRED_STATUS_TXEND:
-		process_alfred_status_txend(globals, &source.sin6_addr,
+		process_alfred_status_txend(globals, interface, &alfred_source,
 					    (struct alfred_status_v0 *)packet);
 		break;
 	default:
diff --git a/send.c b/send.c
index c7a2af2..b566503 100644
--- a/send.c
+++ b/send.c
@@ -42,7 +42,7 @@ int announce_master(struct globals *globals)
 		announcement.header.version = ALFRED_VERSION;
 		announcement.header.length = htons(0);
 
-		send_alfred_packet(interface, &in6addr_localmcast,
+		send_alfred_packet(globals, interface, &alfred_mcast,
 				   &announcement, sizeof(announcement));
 	}
 
@@ -50,7 +50,7 @@ int announce_master(struct globals *globals)
 }
 
 int push_data(struct globals *globals, struct interface *interface,
-	      struct in6_addr *destination, enum data_source max_source_level,
+	      alfred_addr *destination, enum data_source max_source_level,
 	      int type_filter, uint16_t tx_id)
 {
 	struct hash_it_t *hashit = NULL;
@@ -90,7 +90,7 @@ int push_data(struct globals *globals, struct interface *interface,
 			tlv_length += sizeof(*push) - sizeof(push->header);
 			push->header.length = htons(tlv_length);
 			push->tx.seqno = htons(seqno++);
-			send_alfred_packet(interface, destination, push,
+			send_alfred_packet(globals, interface, destination, push,
 					   sizeof(*push) + total_length);
 			total_length = 0;
 		}
@@ -114,7 +114,7 @@ int push_data(struct globals *globals, struct interface *interface,
 		tlv_length += sizeof(*push) - sizeof(push->header);
 		push->header.length = htons(tlv_length);
 		push->tx.seqno = htons(seqno++);
-		send_alfred_packet(interface, destination, push,
+		send_alfred_packet(globals, interface, destination, push,
 				   sizeof(*push) + total_length);
 	}
 
@@ -128,7 +128,7 @@ int push_data(struct globals *globals, struct interface *interface,
 		status_end.tx.id = tx_id;
 		status_end.tx.seqno = htons(seqno);
 
-		send_alfred_packet(interface, destination, &status_end,
+		send_alfred_packet(globals, interface, destination, &status_end,
 				   sizeof(status_end));
 	}
 
@@ -170,24 +170,38 @@ int push_local_data(struct globals *globals)
 	return 0;
 }
 
-ssize_t send_alfred_packet(struct interface *interface,
-			   const struct in6_addr *dest, void *buf, int length)
+ssize_t send_alfred_packet(struct globals *globals, struct interface *interface,
+			   const alfred_addr *dest, void *buf, int length)
 {
 	ssize_t ret;
-	struct sockaddr_in6 dest_addr;
-
-	memset(&dest_addr, 0, sizeof(dest_addr));
-	dest_addr.sin6_family = AF_INET6;
-	dest_addr.sin6_port = htons(ALFRED_PORT);
-	dest_addr.sin6_scope_id = interface->scope_id;
-	memcpy(&dest_addr.sin6_addr, dest, sizeof(*dest));
+	struct sockaddr *dest_addr;
+	struct sockaddr_in6 dest_addr6;
+	struct sockaddr_in dest_addr4;
+	socklen_t slen;
+
+	if (globals->ipv4mode) {
+		memset(&dest_addr4, 0, sizeof(dest_addr4));
+		dest_addr4.sin_family = AF_INET;
+		dest_addr4.sin_port = htons(ALFRED_PORT);
+		memcpy(&dest_addr4.sin_addr, &dest->ipv4, sizeof(dest->ipv4));
+
+		slen = sizeof(struct sockaddr_in);
+		dest_addr = (struct sockaddr *)&dest_addr4;
+	} else {
+		memset(&dest_addr6, 0, sizeof(dest_addr6));
+		dest_addr6.sin6_family = AF_INET6;
+		dest_addr6.sin6_port = htons(ALFRED_PORT);
+		dest_addr6.sin6_scope_id = interface->scope_id;
+		memcpy(&dest_addr6.sin6_addr, &dest->ipv6, sizeof(dest->ipv6));
+
+		slen = sizeof(struct sockaddr_in6);
+		dest_addr = (struct sockaddr *)&dest_addr6;
+	}
 
 	if (interface->netsock < 0)
 		return 0;
 
-	ret = sendto(interface->netsock, buf, length, 0,
-		     (struct sockaddr *)&dest_addr,
-		     sizeof(struct sockaddr_in6));
+	ret = sendto(interface->netsock, buf, length, 0, dest_addr, slen);
 	if (ret == -EPERM) {
 		perror("Error during sent");
 		close(interface->netsock);
diff --git a/server.c b/server.c
index f6e0c8a..2c4042a 100644
--- a/server.c
+++ b/server.c
@@ -218,7 +218,7 @@ static int purge_data(struct globals *globals)
 	return 0;
 }
 
-static void check_if_socket(struct interface *interface)
+static void check_if_socket(struct interface *interface, struct globals *globals)
 {
 	int sock;
 	struct ifreq ifr;
@@ -226,7 +226,7 @@ static void check_if_socket(struct interface *interface)
 	if (interface->netsock < 0)
 		return;
 
-	sock = socket(PF_INET6, SOCK_DGRAM, 0);
+	sock = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sock < 0) {
 		perror("can't open socket");
 		return;
@@ -240,7 +240,7 @@ static void check_if_socket(struct interface *interface)
 		goto close;
 	}
 
-	if (interface->scope_id != (uint32_t)ifr.ifr_ifindex) {
+	if (!globals->ipv4mode && (interface->scope_id != (uint32_t)ifr.ifr_ifindex)) {
 		fprintf(stderr,
 			"iface index changed from %"PRIu32" to %d, closing netsock\n",
 			interface->scope_id, ifr.ifr_ifindex);
@@ -282,7 +282,7 @@ static void check_if_sockets(struct globals *globals)
 	globals->if_check = now;
 
 	list_for_each_entry(interface, &globals->interfaces, list)
-		check_if_socket(interface);
+		check_if_socket(interface, globals);
 }
 
 static void execute_update_command(struct globals *globals)
diff --git a/unix_sock.c b/unix_sock.c
index 0a819a2..4a8c6e0 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -258,7 +258,7 @@ static int unix_sock_req_data(struct globals *globals,
 	head->client_socket = client_sock;
 	head->requested_type = request->requested_type;
 
-	send_alfred_packet(interface, &globals->best_server->address,
+	send_alfred_packet(globals, interface, &globals->best_server->address,
 			   request, sizeof(*request));
 
 	return 0;
diff --git a/util.c b/util.c
index ea75643..84ab3af 100644
--- a/util.c
+++ b/util.c
@@ -23,7 +23,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
 #include <sys/time.h>
 #include <time.h>
 #include "alfred.h"
@@ -75,3 +78,30 @@ bool is_valid_ether_addr(uint8_t addr[ETH_ALEN])
 
 	return true;
 }
+
+int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
+		     struct ether_addr *mac)
+{
+	struct arpreq arpreq;
+	struct sockaddr_in *sin;
+
+	memset(&arpreq, 0, sizeof(arpreq));
+	memset(mac, 0, ETH_ALEN);
+
+	sin = (struct sockaddr_in *)&arpreq.arp_pa;
+	sin->sin_family = AF_INET;
+	sin->sin_addr.s_addr = addr->ipv4.s_addr;
+
+	strcpy(arpreq.arp_dev, interface->interface);
+	if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
+		return -1;
+
+	if (arpreq.arp_flags & ATF_COM) {
+		memcpy(mac, arpreq.arp_ha.sa_data, sizeof(*mac));
+	} else {
+		perror("arp: incomplete");
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.7.4

