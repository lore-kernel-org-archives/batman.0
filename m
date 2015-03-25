Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Mar 2015 19:51:07 +0100
Message-Id: <1427309467-31768-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Make sure only link-local EUI64 is
	used as source
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

The linux kernel automatically chooses the source address. This can make
problems when the metric prefers an address which is not the link-local EUI64
address. For example an user can add an additional address which also can be
used for link-local communication but has a higher value in the metric. This
can cause alfred to send UDP link-local packets with an address which cannot be
decoded by the receiver to get the MAC address of the device. The communication
with this device would then fail.

It is possible to define the source address when we directly bind to it. This
has the problem that this address cannot receive packets with a multicast
address as destination. The workaround is to create two sockets for one netsock
structure. One is the socket which can send all data and receives unicast
packets. The second one is receiving the multicast traffic like the
announcements from master alfred server processes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h  |   4 ++-
 netsock.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 recv.c    |   5 +--
 send.c    |   2 ++
 server.c  |   2 ++
 5 files changed, 103 insertions(+), 16 deletions(-)

diff --git a/alfred.h b/alfred.h
index 621805d..adf788c 100644
--- a/alfred.h
+++ b/alfred.h
@@ -102,6 +102,7 @@ struct interface {
 	uint32_t scope_id;
 	char *interface;
 	int netsock;
+	int netsock_mcast;
 
 	struct hashtable_t *server_hash;
 
@@ -151,7 +152,8 @@ int alfred_client_set_data(struct globals *globals);
 int alfred_client_modeswitch(struct globals *globals);
 int alfred_client_change_interface(struct globals *globals);
 /* recv.c */
-int recv_alfred_packet(struct globals *globals, struct interface *interface);
+int recv_alfred_packet(struct globals *globals, struct interface *interface,
+		       int recv_sock);
 struct transaction_head *
 transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id);
 struct transaction_head *
diff --git a/netsock.c b/netsock.c
index 592f3e3..6bf6016 100644
--- a/netsock.c
+++ b/netsock.c
@@ -84,6 +84,8 @@ void netsock_close_all(struct globals *globals)
 	list_for_each_entry_safe(interface, is, &globals->interfaces, list) {
 		if (interface->netsock >= 0)
 			close(interface->netsock);
+		if (interface->netsock_mcast >= 0)
+			close(interface->netsock_mcast);
 		list_del(&interface->list);
 		hash_delete(interface->server_hash, free);
 		free(interface->interface);
@@ -144,6 +146,7 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 		interface->scope_id = 0;
 		interface->interface = NULL;
 		interface->netsock = -1;
+		interface->netsock_mcast = -1;
 		interface->server_hash = NULL;
 
 		interface->interface = strdup(token);
@@ -210,11 +213,14 @@ out:
 static int netsock_open(struct interface *interface)
 {
 	int sock;
-	struct sockaddr_in6 sin6;
+	int sock_mc;
+	struct sockaddr_in6 sin6, sin6_mc;
+	struct ipv6_mreq mreq;
 	struct ifreq ifr;
 	int ret;
 
 	interface->netsock = -1;
+	interface->netsock_mcast = -1;
 
 	sock = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDP);
 	if (sock  < 0) {
@@ -222,6 +228,13 @@ static int netsock_open(struct interface *interface)
 		return -1;
 	}
 
+	sock_mc = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock_mc  < 0) {
+		close(sock);
+		perror("can't open socket");
+		return -1;
+	}
+
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, interface->interface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
@@ -232,12 +245,6 @@ static int netsock_open(struct interface *interface)
 
 	interface->scope_id = ifr.ifr_ifindex;
 
-	memset(&sin6, 0, sizeof(sin6));
-	sin6.sin6_port = htons(ALFRED_PORT);
-	sin6.sin6_family = AF_INET6;
-	sin6.sin6_addr = in6addr_any;
-	sin6.sin6_scope_id = ifr.ifr_ifindex;
-
 	if (ioctl(sock, SIOCGIFHWADDR, &ifr) == -1) {
 		perror("can't get MAC address");
 		goto err;
@@ -246,12 +253,32 @@ static int netsock_open(struct interface *interface)
 	memcpy(&interface->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
 	mac_to_ipv6(&interface->hwaddr, &interface->address);
 
+	memset(&sin6, 0, sizeof(sin6));
+	sin6.sin6_port = htons(ALFRED_PORT);
+	sin6.sin6_family = AF_INET6;
+	memcpy(&sin6.sin6_addr, &interface->address, sizeof(sin6.sin6_addr));
+	sin6.sin6_scope_id = interface->scope_id;
+
+	memset(&sin6_mc, 0, sizeof(sin6_mc));
+	sin6_mc.sin6_port = htons(ALFRED_PORT);
+	sin6_mc.sin6_family = AF_INET6;
+	memcpy(&sin6_mc.sin6_addr, &in6addr_localmcast,
+	       sizeof(sin6_mc.sin6_addr));
+	sin6_mc.sin6_scope_id = interface->scope_id;
+
 	enable_raw_bind_capability(1);
 	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, interface->interface,
 		       strlen(interface->interface) + 1)) {
 		perror("can't bind to device");
 		goto err;
 	}
+
+	if (setsockopt(sock_mc, SOL_SOCKET, SO_BINDTODEVICE,
+		       interface->interface,
+		       strlen(interface->interface) + 1)) {
+		perror("can't bind to device");
+		goto err;
+	}
 	enable_raw_bind_capability(0);
 
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
@@ -259,6 +286,21 @@ static int netsock_open(struct interface *interface)
 		goto err;
 	}
 
+	if (bind(sock_mc, (struct sockaddr *)&sin6_mc, sizeof(sin6_mc)) < 0) {
+		perror("can't bind");
+		goto err;
+	}
+
+	memcpy(&mreq.ipv6mr_multiaddr, &in6addr_localmcast,
+	       sizeof(mreq.ipv6mr_multiaddr));
+	mreq.ipv6mr_interface = interface->scope_id;
+
+	if (setsockopt(sock_mc, IPPROTO_IPV6, IPV6_ADD_MEMBERSHIP,
+		       &mreq, sizeof(mreq))) {
+		perror("can't add multicast membership");
+		goto err;
+	}
+
 	ret = fcntl(sock, F_GETFL, 0);
 	if (ret < 0) {
 		perror("failed to get file status flags");
@@ -271,11 +313,25 @@ static int netsock_open(struct interface *interface)
 		goto err;
 	}
 
+	ret = fcntl(sock_mc, F_GETFL, 0);
+	if (ret < 0) {
+		perror("failed to get file status flags");
+		goto err;
+	}
+
+	ret = fcntl(sock_mc, F_SETFL, ret | O_NONBLOCK);
+	if (ret < 0) {
+		perror("failed to set file status flags");
+		goto err;
+	}
+
 	interface->netsock = sock;
+	interface->netsock_mcast = sock_mc;
 
 	return 0;
 err:
 	close(sock);
+	close(sock_mc);
 	return -1;
 }
 
@@ -314,6 +370,12 @@ int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock)
 			if (maxsock < interface->netsock)
 				maxsock = interface->netsock;
 		}
+
+		if (interface->netsock_mcast >= 0) {
+			FD_SET(interface->netsock_mcast, fds);
+			if (maxsock < interface->netsock_mcast)
+				maxsock = interface->netsock_mcast;
+		}
 	}
 
 	return maxsock;
@@ -324,12 +386,22 @@ void netsock_check_error(struct globals *globals, fd_set *errfds)
 	struct interface *interface;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
-		if (interface->netsock >= 0 &&
-		    FD_ISSET(interface->netsock, errfds)) {
-			fprintf(stderr, "Error on netsock detected\n");
+		if ((interface->netsock < 0 ||
+		     !FD_ISSET(interface->netsock, errfds)) &&
+		    (interface->netsock_mcast < 0 ||
+		     !FD_ISSET(interface->netsock_mcast, errfds)))
+			continue;
+
+		fprintf(stderr, "Error on netsock detected\n");
+
+		if (interface->netsock >= 0)
 			close(interface->netsock);
-			interface->netsock = -1;
-		}
+
+		if (interface->netsock_mcast >= 0)
+			close(interface->netsock_mcast);
+
+		interface->netsock = -1;
+		interface->netsock_mcast = -1;
 	}
 }
 
@@ -341,7 +413,15 @@ int netsock_receive_packet(struct globals *globals, fd_set *fds)
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		if (interface->netsock >= 0 &&
 		    FD_ISSET(interface->netsock, fds)) {
-			recv_alfred_packet(globals, interface);
+			recv_alfred_packet(globals, interface,
+					   interface->netsock);
+			recvs++;
+		}
+
+		if (interface->netsock_mcast >= 0 &&
+		    FD_ISSET(interface->netsock_mcast, fds)) {
+			recv_alfred_packet(globals, interface,
+					   interface->netsock_mcast);
 			recvs++;
 		}
 	}
diff --git a/recv.c b/recv.c
index 59c69b4..16242bc 100644
--- a/recv.c
+++ b/recv.c
@@ -379,7 +379,8 @@ static int process_alfred_status_txend(struct globals *globals,
 	return 0;
 }
 
-int recv_alfred_packet(struct globals *globals, struct interface *interface)
+int recv_alfred_packet(struct globals *globals, struct interface *interface,
+		       int recv_sock)
 {
 	uint8_t buf[MAX_PAYLOAD];
 	ssize_t length;
@@ -391,7 +392,7 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface)
 		return -1;
 
 	sourcelen = sizeof(source);
-	length = recvfrom(interface->netsock, buf, sizeof(buf), 0,
+	length = recvfrom(recv_sock, buf, sizeof(buf), 0,
 			  (struct sockaddr *)&source, &sourcelen);
 	if (length <= 0) {
 		perror("read from network socket failed");
diff --git a/send.c b/send.c
index cc55489..8853970 100644
--- a/send.c
+++ b/send.c
@@ -182,7 +182,9 @@ ssize_t send_alfred_packet(struct interface *interface,
 	if (ret == -EPERM) {
 		perror("Error during sent");
 		close(interface->netsock);
+		close(interface->netsock_mcast);
 		interface->netsock = -1;
+		interface->netsock_mcast = -1;
 	}
 
 	return ret;
diff --git a/server.c b/server.c
index c9c77b9..ac253a9 100644
--- a/server.c
+++ b/server.c
@@ -262,7 +262,9 @@ static void check_if_socket(struct interface *interface)
 
 close:
 	close(interface->netsock);
+	close(interface->netsock_mcast);
 	interface->netsock = -1;
+	interface->netsock_mcast = -1;
 	close(sock);
 }
 
-- 
2.1.4

