Return-Path: <hwhilse@gmail.com>
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Sun, 27 Mar 2016 20:26:55 +0200
Message-Id: <1459103215-22444-1-git-send-email-hwhilse@gmail.com>
In-Reply-To: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC v2] alfred: implement TCP support for
	server-to-server communication
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
Cc: Hans-Werner Hilse <hwhilse@gmail.com>

This implements support for using TCP instead of UDP for
server-to-server communication for slave-to-master requests and
for master-to-master synchronization.

Both these scenarios potentially exchange large chunks of data.
Alfred distributes this data over multiple UDP packets. However,
it - sensibly - uses 64kByte as the maximum UDP packet size.
This makes sense since the data stored might well exceed the
small sizes of typical network layer packages (like 1280 or 1500
Bytes).

Large UDP packets will then get fragmented by the Kernel on the
IPv6 layer. For busy links and for exchange over very heterogenous
network architectures, this lead to the loss of fragments (some
or all of them). That makes proper communication a matter of luck
for some users.

In all these cases, reliable communication is preferred. Instead
of implementing our own handling for this upon UDP, using TCP will
provide everything what's needed.

Implementation overview:

The interface struct is extended by a list of TCP sockets. Sockets
in this list will get cleaned up when the interface goes away.
The sockets in this list will be monitored for incoming data (or
for them to get closed on the other side). Incoming data is
handled more or less the same way as incoming UDP data is, with
the added speciality that packets are accumulated since it is not
arriving in self-contained datagrams like when using UDP.
The packet data is stored along the socket information. When a
full packet is received, it is handled just like a packet received
as a UDP datagram.

A REQUEST is answered on the same socket as it was received on,
since TCP allows bidirectional communication.

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
Changes in v2:
   - non-blocking sending over TCP sockets

 alfred.h    |  44 ++++++++++-
 main.c      |   8 +-
 netsock.c   | 239 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 recv.c      |  90 ++++++++++++++++++++++-
 send.c      | 204 +++++++++++++++++++++++++++++++++++++++++++++++----
 server.c    |  30 +++++++-
 unix_sock.c |  14 ++++
 7 files changed, 607 insertions(+), 22 deletions(-)

diff --git a/alfred.h b/alfred.h
index 7e5db16..2de1955 100644
--- a/alfred.h
+++ b/alfred.h
@@ -89,6 +89,11 @@ enum opmode {
 	OPMODE_MASTER,
 };
 
+enum requestproto {
+	REQPROTO_UDP,
+	REQPROTO_TCP
+};
+
 enum clientmode {
 	CLIENT_NONE,
 	CLIENT_REQUEST_DATA,
@@ -97,6 +102,27 @@ enum clientmode {
 	CLIENT_CHANGE_INTERFACE,
 };
 
+enum tcp_close {
+	CLOSE_WHEN_READ,
+	CLOSE_WHEN_WRITTEN,
+	CLOSED_FOR_READING,
+};
+
+struct tcp_connection {
+	int netsock;
+	struct in6_addr address;
+
+	struct alfred_tlv *packet;
+	uint16_t read;
+
+	uint8_t *send_packet;
+	uint32_t send_length;
+	uint32_t written;
+
+	enum tcp_close close;
+	struct list_head list;
+};
+
 struct interface {
 	struct ether_addr hwaddr;
 	struct in6_addr address;
@@ -104,6 +130,9 @@ struct interface {
 	char *interface;
 	int netsock;
 	int netsock_mcast;
+	int netsock_tcp;
+
+	struct list_head tcp_connections;
 
 	struct hashtable_t *server_hash;
 
@@ -117,6 +146,7 @@ struct globals {
 	struct server *best_server;	/* NULL if we are a server ourselves */
 	const char *mesh_iface;
 	enum opmode opmode;
+	enum requestproto requestproto;
 	enum clientmode clientmode;
 	int clientmode_arg;
 	int clientmode_version;
@@ -139,6 +169,7 @@ struct globals {
 #define debugFree(ptr, num)	free(ptr)
 
 #define MAX_PAYLOAD ((1 << 16) - 1 - sizeof(struct udphdr))
+#define MAX_UDP_ANSWER 1280 - 40 - sizeof(struct udphdr)
 
 extern const struct in6_addr in6addr_localmcast;
 
@@ -155,6 +186,9 @@ int alfred_client_change_interface(struct globals *globals);
 /* recv.c */
 int recv_alfred_packet(struct globals *globals, struct interface *interface,
 		       int recv_sock);
+int recv_alfred_stream(struct globals *globals,
+		       struct interface *interface,
+		       struct tcp_connection *tcp_connection);
 struct transaction_head *
 transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id);
 struct transaction_head *
@@ -165,12 +199,17 @@ struct transaction_head *transaction_clean(struct globals *globals,
 /* send.c */
 int push_data(struct globals *globals, struct interface *interface,
 	      struct in6_addr *destination, enum data_source max_source_level,
-	      int type_filter, uint16_t tx_id);
+	      int type_filter, uint16_t tx_id,
+	      struct tcp_connection *tcp_connection);
 int announce_master(struct globals *globals);
 int push_local_data(struct globals *globals);
 int sync_data(struct globals *globals);
 ssize_t send_alfred_packet(struct interface *interface,
 			   const struct in6_addr *dest, void *buf, int length);
+ssize_t open_alfred_stream(struct interface *interface,
+			   const struct in6_addr *dest, void *buf, int length,
+			   enum tcp_close close_mode);
+ssize_t send_alfred_stream(struct tcp_connection *tcp_client);
 /* unix_sock.c */
 int unix_sock_read(struct globals *globals);
 int unix_sock_open_daemon(struct globals *globals);
@@ -187,8 +226,11 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces);
 struct interface *netsock_first_interface(struct globals *globals);
 void netsock_reopen(struct globals *globals);
 int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock);
+int netsock_prepare_write_select(struct globals *globals, fd_set *fds,
+				 int maxsock);
 void netsock_check_error(struct globals *globals, fd_set *errfds);
 int netsock_receive_packet(struct globals *globals, fd_set *fds);
+int netsock_send(struct globals *globals, fd_set *fds);
 int netsock_own_address(const struct globals *globals,
 			const struct in6_addr *address);
 /* util.c */
diff --git a/main.c b/main.c
index 9610398..667e86b 100644
--- a/main.c
+++ b/main.c
@@ -58,6 +58,7 @@ static void alfred_usage(void)
 	printf("  -m, --master                        start up the daemon in master mode, which\n");
 	printf("                                      accepts data from slaves and syncs it with\n");
 	printf("                                      other masters\n");
+	printf("  -t, --tcp                           use TCP protocol for server-to-server communication\n");
 	printf("\n");
 	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
 	printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
@@ -149,6 +150,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"request",		required_argument,	NULL,	'r'},
 		{"interface",		required_argument,	NULL,	'i'},
 		{"master",		no_argument,		NULL,	'm'},
+		{"tcp",			no_argument,		NULL,	't'},
 		{"help",		no_argument,		NULL,	'h'},
 		{"req-version",		required_argument,	NULL,	'V'},
 		{"modeswitch",		required_argument,	NULL,	'M'},
@@ -170,6 +172,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 	INIT_LIST_HEAD(&globals->interfaces);
 	globals->change_interface = NULL;
 	globals->opmode = OPMODE_SLAVE;
+	globals->requestproto = REQPROTO_UDP;
 	globals->clientmode = CLIENT_NONE;
 	globals->best_server = NULL;
 	globals->clientmode_version = 0;
@@ -182,7 +185,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", long_options,
+	while ((opt = getopt_long(argc, argv, "mts:r:hi:b:vV:M:I:u:dc:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -207,6 +210,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'm':
 			globals->opmode = OPMODE_MASTER;
 			break;
+		case 't':
+			globals->requestproto = REQPROTO_TCP;
+			break;
 		case 'i':
 			netsock_set_interfaces(globals, optarg);
 			break;
diff --git a/netsock.c b/netsock.c
index d72541e..068b294 100644
--- a/netsock.c
+++ b/netsock.c
@@ -80,12 +80,26 @@ static int server_choose(void *d1, int size)
 void netsock_close_all(struct globals *globals)
 {
 	struct interface *interface, *is;
+	struct tcp_connection *tcp_connection, *tc;
 
 	list_for_each_entry_safe(interface, is, &globals->interfaces, list) {
+		list_for_each_entry_safe(tcp_connection, tc,
+					 &interface->tcp_connections, list) {
+			shutdown(tcp_connection->netsock, SHUT_RDWR);
+			close(tcp_connection->netsock);
+			list_del(&tcp_connection->list);
+			if(tcp_connection->packet)
+				free(tcp_connection->packet);
+			if(tcp_connection->send_packet)
+				free(tcp_connection->send_packet);
+			free(tcp_connection);
+		}
 		if (interface->netsock >= 0)
 			close(interface->netsock);
 		if (interface->netsock_mcast >= 0)
 			close(interface->netsock_mcast);
+		if (interface->netsock_tcp >= 0)
+			close(interface->netsock_tcp);
 		list_del(&interface->list);
 		hash_delete(interface->server_hash, free);
 		free(interface->interface);
@@ -147,6 +161,7 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 		interface->interface = NULL;
 		interface->netsock = -1;
 		interface->netsock_mcast = -1;
+		interface->netsock_tcp = -1;
 		interface->server_hash = NULL;
 
 		interface->interface = strdup(token);
@@ -165,6 +180,8 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 			return -ENOMEM;
 		}
 
+		INIT_LIST_HEAD(&interface->tcp_connections);
+
 		list_add(&interface->list, &globals->interfaces);
 	}
 
@@ -214,13 +231,16 @@ static int netsock_open(struct interface *interface)
 {
 	int sock;
 	int sock_mc;
+	int sock_tcp;
 	struct sockaddr_in6 sin6, sin6_mc;
 	struct ipv6_mreq mreq;
 	struct ifreq ifr;
 	int ret;
+	int yes;
 
 	interface->netsock = -1;
 	interface->netsock_mcast = -1;
+	interface->netsock_tcp = -1;
 
 	sock = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDP);
 	if (sock  < 0) {
@@ -235,6 +255,14 @@ static int netsock_open(struct interface *interface)
 		return -1;
 	}
 
+	sock_tcp = socket(PF_INET6, SOCK_STREAM, IPPROTO_TCP);
+	if (sock_tcp < 0) {
+		close(sock);
+		close(sock_mc);
+		perror("can't open socket");
+		return -1;
+	}
+
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, interface->interface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
@@ -286,6 +314,23 @@ static int netsock_open(struct interface *interface)
 		goto err;
 	}
 
+	yes = 1;
+	if (setsockopt(sock_tcp, SOL_SOCKET, SO_REUSEADDR,
+		&yes, sizeof(yes)) == -1) {
+		perror("setsockopt: SO_REUSEADDR");
+		goto err;
+	}
+
+	if (bind(sock_tcp, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
+		perror("can't bind");
+		goto err;
+	}
+
+	if (listen(sock_tcp, 10) < 0) {
+		perror("can't listen on tcp socket");
+		goto err;
+	}
+
 	if (bind(sock_mc, (struct sockaddr *)&sin6_mc, sizeof(sin6_mc)) < 0) {
 		perror("can't bind");
 		goto err;
@@ -327,11 +372,13 @@ static int netsock_open(struct interface *interface)
 
 	interface->netsock = sock;
 	interface->netsock_mcast = sock_mc;
+	interface->netsock_tcp = sock_tcp;
 
 	return 0;
 err:
 	close(sock);
 	close(sock_mc);
+	close(sock_tcp);
 	return -1;
 }
 
@@ -363,6 +410,7 @@ void netsock_reopen(struct globals *globals)
 int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock)
 {
 	struct interface *interface;
+	struct tcp_connection *tcp_connection;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		if (interface->netsock >= 0) {
@@ -376,6 +424,57 @@ int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock)
 			if (maxsock < interface->netsock_mcast)
 				maxsock = interface->netsock_mcast;
 		}
+
+		if (interface->netsock_tcp >= 0) {
+			FD_SET(interface->netsock_tcp, fds);
+			if (maxsock < interface->netsock_tcp)
+				maxsock = interface->netsock_tcp;
+		}
+
+		list_for_each_entry(tcp_connection,
+				    &interface->tcp_connections, list) {
+			if (tcp_connection->close != CLOSED_FOR_READING) {
+				FD_SET(tcp_connection->netsock, fds);
+				if (maxsock < tcp_connection->netsock)
+					maxsock = tcp_connection->netsock;
+			}
+		}
+	}
+
+	return maxsock;
+}
+
+int netsock_prepare_write_select(struct globals *globals, fd_set *fds,
+				 int maxsock)
+{
+	struct interface *interface;
+	struct tcp_connection *tcp_connection;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		list_for_each_entry(tcp_connection,
+				    &interface->tcp_connections, list) {
+			if (tcp_connection->send_length) {
+				/* monitor fd only if we actually have
+				 * data we'd like to send
+				 */
+				FD_SET(tcp_connection->netsock, fds);
+				if (maxsock < tcp_connection->netsock)
+					maxsock = tcp_connection->netsock;
+			} else if (tcp_connection->close == CLOSE_WHEN_WRITTEN) {
+				/* we have a TCP connection that should be
+				 * closed when everything is written and it
+				 * seems that is the case now
+				 */
+				shutdown(tcp_connection->netsock, SHUT_RDWR);
+				close(tcp_connection->netsock);
+				list_del(&tcp_connection->list);
+				if (tcp_connection->packet)
+					free(tcp_connection->packet);
+				if (tcp_connection->send_packet)
+					free(tcp_connection->send_packet);
+				free(tcp_connection);
+			}
+		}
 	}
 
 	return maxsock;
@@ -384,12 +483,29 @@ int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock)
 void netsock_check_error(struct globals *globals, fd_set *errfds)
 {
 	struct interface *interface;
+	struct tcp_connection *tcp_connection, *tc;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
+		list_for_each_entry_safe(tcp_connection, tc,
+					 &interface->tcp_connections, list) {
+			if (FD_ISSET(tcp_connection->netsock, errfds)) {
+				shutdown(tcp_connection->netsock, SHUT_RDWR);
+				close(tcp_connection->netsock);
+				list_del(&tcp_connection->list);
+				if (tcp_connection->packet)
+					free(tcp_connection->packet);
+				if (tcp_connection->send_packet)
+					free(tcp_connection->send_packet);
+				free(tcp_connection);
+			}
+		}
+
 		if ((interface->netsock < 0 ||
 		     !FD_ISSET(interface->netsock, errfds)) &&
 		    (interface->netsock_mcast < 0 ||
-		     !FD_ISSET(interface->netsock_mcast, errfds)))
+		     !FD_ISSET(interface->netsock_mcast, errfds)) &&
+		    (interface->netsock_tcp < 0 ||
+		     !FD_ISSET(interface->netsock_tcp, errfds)))
 			continue;
 
 		fprintf(stderr, "Error on netsock detected\n");
@@ -400,15 +516,23 @@ void netsock_check_error(struct globals *globals, fd_set *errfds)
 		if (interface->netsock_mcast >= 0)
 			close(interface->netsock_mcast);
 
+		if (interface->netsock_tcp >= 0)
+			close(interface->netsock_tcp);
+
 		interface->netsock = -1;
 		interface->netsock_mcast = -1;
+		interface->netsock_tcp = -1;
 	}
 }
 
 int netsock_receive_packet(struct globals *globals, fd_set *fds)
 {
 	struct interface *interface;
+	struct tcp_connection *tcp_connection, *tc;
+	struct sockaddr_in6 sin6;
+	socklen_t sin6_len = sizeof(sin6);
 	int recvs = 0;
+	int sock_client;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		if (interface->netsock >= 0 &&
@@ -424,6 +548,119 @@ int netsock_receive_packet(struct globals *globals, fd_set *fds)
 					   interface->netsock_mcast);
 			recvs++;
 		}
+
+		list_for_each_entry_safe(tcp_connection, tc,
+					 &interface->tcp_connections, list) {
+			if (FD_ISSET(tcp_connection->netsock, fds)) {
+				if (recv_alfred_stream(globals, interface,
+							 tcp_connection) < 0) {
+					if(tcp_connection->close == CLOSE_WHEN_READ) {
+						shutdown(tcp_connection->netsock,
+							 SHUT_RDWR);
+						close(tcp_connection->netsock);
+						list_del(&tcp_connection->list);
+						if (tcp_connection->packet)
+							free(tcp_connection->packet);
+						if (tcp_connection->send_packet)
+							free(tcp_connection->send_packet);
+						free(tcp_connection);
+					} else {
+						tcp_connection->close =
+							CLOSED_FOR_READING;
+					}
+				}
+				recvs++;
+			}
+		}
+
+		if (interface->netsock_tcp >= 0 &&
+		    FD_ISSET(interface->netsock_tcp, fds)) {
+			sock_client = accept(interface->netsock_tcp,
+					     (struct sockaddr *)&sin6,
+					     &sin6_len);
+			if (sock_client < 0) {
+				perror("can't accept TCP connection");
+				goto tcp_done;
+			}
+
+			/* drop packets not sent over link-local ipv6 */
+			if (!is_ipv6_eui64(&sin6.sin6_addr)) {
+				fprintf(stderr, "not handling TCP connection "
+						"from non-link-local address"
+						"\n");
+				goto tcp_drop;
+			}
+
+			/* drop packets from ourselves */
+			if (netsock_own_address(globals, &sin6.sin6_addr)) {
+				fprintf(stderr, "not handling TCP connection "
+						"from ourselves\n");
+				goto tcp_drop;
+			}
+
+			tcp_connection = calloc(1, sizeof(*tcp_connection));
+			if (!tcp_connection) {
+				fprintf(stderr, "out of memory, cannot handle "
+						"TCP client connection\n");
+				goto tcp_drop;
+			}
+
+			tcp_connection->packet =
+				calloc(1, sizeof(struct alfred_tlv));
+			if (!tcp_connection->packet) {
+				fprintf(stderr, "out of memory, cannot handle "
+						"TCP client connection\n");
+				free(tcp_connection);
+				goto tcp_drop;
+			}
+
+			tcp_connection->netsock = sock_client;
+			tcp_connection->close = CLOSE_WHEN_READ;
+
+			memcpy(&tcp_connection->address, &sin6.sin6_addr,
+			       sizeof(tcp_connection->address));
+			list_add(&tcp_connection->list,
+				 &interface->tcp_connections);
+			goto tcp_done;
+tcp_drop:
+			shutdown(sock_client, SHUT_RDWR);
+			close(sock_client);
+tcp_done:
+			recvs++;
+		}
+	}
+
+	return recvs;
+}
+
+int netsock_send(struct globals *globals, fd_set *fds)
+{
+	struct interface *interface;
+	struct tcp_connection *tcp_connection, *tc;
+	int recvs = 0;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		list_for_each_entry_safe(tcp_connection, tc,
+					 &interface->tcp_connections, list) {
+			if (FD_ISSET(tcp_connection->netsock, fds)) {
+				if(tcp_connection->send_length
+				   && send_alfred_stream(tcp_connection) < 0
+				   && (tcp_connection->close == CLOSE_WHEN_WRITTEN
+				       || tcp_connection->close == CLOSED_FOR_READING)
+				   ) {
+					shutdown(tcp_connection->netsock,
+						 SHUT_RDWR);
+					close(tcp_connection->netsock);
+					list_del(&tcp_connection->list);
+					if (tcp_connection->packet)
+						free(tcp_connection->packet);
+					if (tcp_connection->send_packet)
+						free(tcp_connection->send_packet);
+					free(tcp_connection);
+				}
+				recvs++;
+			}
+		}
 	}
 
 	return recvs;
diff --git a/recv.c b/recv.c
index 98539cb..563a0d1 100644
--- a/recv.c
+++ b/recv.c
@@ -302,7 +302,8 @@ process_alfred_announce_master(struct globals *globals,
 static int process_alfred_request(struct globals *globals,
 				  struct interface *interface,
 				  struct in6_addr *source,
-				  struct alfred_request_v0 *request)
+				  struct alfred_request_v0 *request,
+				  struct tcp_connection *tcp_connection)
 {
 	int len;
 
@@ -315,7 +316,7 @@ static int process_alfred_request(struct globals *globals,
 		return -1;
 
 	push_data(globals, interface, source, SOURCE_SYNCED,
-		  request->requested_type, request->tx_id);
+		  request->requested_type, request->tx_id, tcp_connection);
 
 	return 0;
 }
@@ -432,7 +433,7 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 		break;
 	case ALFRED_REQUEST:
 		process_alfred_request(globals, interface, &source.sin6_addr,
-				       (struct alfred_request_v0 *)packet);
+				       (struct alfred_request_v0 *)packet, -1);
 		break;
 	case ALFRED_STATUS_TXEND:
 		process_alfred_status_txend(globals, &source.sin6_addr,
@@ -445,3 +446,86 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 
 	return 0;
 }
+
+int recv_alfred_stream(struct globals *globals, struct interface *interface,
+		       struct tcp_connection *tcp_connection)
+{
+	size_t to_read;
+	int res;
+	const size_t header_len = sizeof(struct alfred_tlv);
+	void *mem;
+
+	/* determine how many bytes we're still expecting */
+	if (tcp_connection->read < header_len) {
+		/* TLV header still incomplete */
+		to_read = header_len - tcp_connection->read;
+	} else {
+		/* payload still incomplete */
+		to_read = header_len
+			  + ntohs(tcp_connection->packet->length)
+			  - tcp_connection->read;
+	}
+
+	res = recv(tcp_connection->netsock,
+		(uint8_t*)tcp_connection->packet + tcp_connection->read,
+		to_read, MSG_DONTWAIT);
+
+	if (res < 0) {
+		return (errno == EAGAIN || errno == EWOULDBLOCK) ? 0 : -1;
+	} else if (res == 0) {
+		/* end of stream */
+		return -1;
+	}
+
+	tcp_connection->read += res;
+
+	if (tcp_connection->read == header_len
+	    && tcp_connection->packet->length > 0) {
+		/* there's payload, so adjust buffer size */
+		mem = realloc(tcp_connection->packet,
+			      header_len + ntohs(tcp_connection->packet->length));
+		if (!mem) {
+			fprintf(stderr, "out of memory when reading from TCP "
+					"client\n");
+			return -1;
+		}
+		tcp_connection->packet = (struct alfred_tlv *)mem;
+	}
+
+	if (tcp_connection->read ==
+	    header_len + ntohs(tcp_connection->packet->length)) {
+		/* packet is complete */
+		switch(tcp_connection->packet->type) {
+		case ALFRED_REQUEST:
+			tcp_connection->close = CLOSE_WHEN_WRITTEN;
+			process_alfred_request(globals, interface,
+					       &tcp_connection->address,
+					       (struct alfred_request_v0 *)tcp_connection->packet,
+					       tcp_connection);
+			return 0;
+		case ALFRED_PUSH_DATA:
+			process_alfred_push_data(globals, &tcp_connection->address,
+						 (struct alfred_push_data_v0 *)tcp_connection->packet);
+
+			/* do not close connection, but expect more packets */
+			mem = realloc(tcp_connection->packet, header_len);
+			if (!mem) {
+				fprintf(stderr, "out of memory when reading "
+						"from TCP client\n");
+				return -1;
+			}
+			memset(mem, 0, header_len);
+			tcp_connection->packet = (struct alfred_tlv *)mem;
+			tcp_connection->read = 0;
+			return 0;
+		case ALFRED_STATUS_TXEND:
+			process_alfred_status_txend(globals, &tcp_connection->address,
+						    (struct alfred_status_v0 *)tcp_connection->packet);
+			break;
+		}
+		/* close connection */
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/send.c b/send.c
index 70f694c..e657216 100644
--- a/send.c
+++ b/send.c
@@ -27,6 +27,8 @@
 #include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
 #include "alfred.h"
 #include "hash.h"
 #include "packet.h"
@@ -49,18 +51,21 @@ int announce_master(struct globals *globals)
 	return 0;
 }
 
-int push_data(struct globals *globals, struct interface *interface,
-	      struct in6_addr *destination, enum data_source max_source_level,
-	      int type_filter, uint16_t tx_id)
+int push_data_handler(struct globals *globals,
+	      enum data_source max_source_level,
+	      int type_filter, uint16_t tx_id,
+	      void (*send_func)(void *state, void *destination,
+				void *data, int length),
+	      void *state, void *destination)
 {
 	struct hash_it_t *hashit = NULL;
 	uint8_t buf[MAX_PAYLOAD];
 	struct alfred_push_data_v0 *push;
 	struct alfred_data *data;
 	uint16_t total_length = 0;
+	int overall_length = 0;
 	size_t tlv_length;
 	uint16_t seqno = 0;
-	uint16_t length;
 	struct alfred_status_v0 status_end;
 
 	push = (struct alfred_push_data_v0 *)buf;
@@ -90,8 +95,12 @@ int push_data(struct globals *globals, struct interface *interface,
 			tlv_length += sizeof(*push) - sizeof(push->header);
 			push->header.length = htons(tlv_length);
 			push->tx.seqno = htons(seqno++);
-			send_alfred_packet(interface, destination, push,
-					   sizeof(*push) + total_length);
+			if (send_func) {
+				send_func(state, destination, push,
+					  sizeof(*push) + total_length);
+			} else {
+				overall_length += sizeof(*push) + total_length;
+			}
 			total_length = 0;
 		}
 
@@ -114,24 +123,93 @@ int push_data(struct globals *globals, struct interface *interface,
 		tlv_length += sizeof(*push) - sizeof(push->header);
 		push->header.length = htons(tlv_length);
 		push->tx.seqno = htons(seqno++);
-		send_alfred_packet(interface, destination, push,
-				   sizeof(*push) + total_length);
+		if (send_func) {
+			send_func(state, destination, push,
+				  sizeof(*push) + total_length);
+		} else {
+			overall_length += sizeof(*push) + total_length;
+		}
 	}
 
 	/* send transaction txend packet */
 	if (seqno > 0 || type_filter != NO_FILTER) {
 		status_end.header.type = ALFRED_STATUS_TXEND;
 		status_end.header.version = ALFRED_VERSION;
-		length = sizeof(status_end) - sizeof(status_end.header);
-		status_end.header.length = htons(length);
+		total_length = sizeof(status_end) - sizeof(status_end.header);
+		status_end.header.length = htons(total_length);
 
 		status_end.tx.id = tx_id;
 		status_end.tx.seqno = htons(seqno);
 
-		send_alfred_packet(interface, destination, &status_end,
-				   sizeof(status_end));
+		if (send_func) {
+			send_func(state, destination, &status_end,
+				  sizeof(status_end));
+		} else {
+			overall_length += sizeof(status_end);
+		}
+	}
+
+	return overall_length;
+}
+
+void send_func_udp(void *state, void *destination, void *data, int length)
+{
+	send_alfred_packet((struct interface *)state,
+			   (struct in6_addr *)destination, data, length);
+}
+
+void send_func_buf(void *state, void *destination, void *data, int length)
+{
+	int *pos = (int *)state;
+	uint8_t *buf = (uint8_t *)destination;
+	memcpy(buf + *pos, data, length);
+	*pos += length;
+}
+
+int push_data(struct globals *globals, struct interface *interface,
+	      struct in6_addr *destination, enum data_source max_source_level,
+	      int type_filter, uint16_t tx_id,
+	      struct tcp_connection *tcp_connection)
+{
+	uint32_t length;
+	int written = 0;
+	void *buf;
+
+	length = push_data_handler(globals, max_source_level,
+				   type_filter, tx_id,
+				   NULL, NULL, NULL);
+	if (tcp_connection) {
+		/* request via TCP, send answer via this socket */
+		buf = malloc(length);
+		if (!buf)
+			return -1;
+
+		push_data_handler(globals, max_source_level, type_filter, tx_id,
+				  send_func_buf, &written, buf);
+
+		tcp_connection->send_length = length;
+		tcp_connection->send_packet = buf;
+		return 0;
 	}
 
+	/* request not via an established TCP socket. */
+	if (globals->requestproto == REQPROTO_TCP && length > MAX_UDP_ANSWER) {
+		/* Depending on response payload size, decide if we
+		 * gonna send the response via TCP nevertheless
+		 */
+		buf = malloc(length);
+		if (buf) {
+			push_data_handler(globals, max_source_level,
+					  type_filter, tx_id,
+					  send_func_buf, &written, buf);
+			if (open_alfred_stream(interface, destination, buf,
+					       length, CLOSE_WHEN_WRITTEN) >= 0)
+				return 0;
+		}
+	}
+	/* fallback / default case: answer via UDP */
+	push_data_handler(globals, max_source_level, type_filter,
+			  tx_id, send_func_udp, interface, destination);
 	return 0;
 }
 
@@ -148,7 +226,7 @@ int sync_data(struct globals *globals)
 
 			push_data(globals, interface, &server->address,
 				  SOURCE_FIRST_HAND, NO_FILTER,
-				  get_random_id());
+				  get_random_id(), NULL);
 		}
 	}
 	return 0;
@@ -164,7 +242,7 @@ int push_local_data(struct globals *globals)
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		push_data(globals, interface, &globals->best_server->address,
-			  SOURCE_LOCAL, NO_FILTER, get_random_id());
+			  SOURCE_LOCAL, NO_FILTER, get_random_id(), NULL);
 	}
 
 	return 0;
@@ -198,3 +276,101 @@ ssize_t send_alfred_packet(struct interface *interface,
 
 	return ret;
 }
+
+ssize_t open_alfred_stream(struct interface *interface,
+			   const struct in6_addr *dest, void *buf, int length,
+			   enum tcp_close close_mode)
+{
+	struct tcp_connection *tcp_connection;
+	struct sockaddr_in6 dest_addr;
+	int sock;
+	int flags;
+
+	list_for_each_entry(tcp_connection, &interface->tcp_connections, list) {
+		/* when there is already a connection in progress,
+		 * no not open a new one - also, don't report an error either.
+		 */
+		if (0 == memcmp(dest, &tcp_connection->address, sizeof(*dest)))
+			return 0;
+	}
+
+	memset(&dest_addr, 0, sizeof(dest_addr));
+	dest_addr.sin6_family = AF_INET6;
+	dest_addr.sin6_port = htons(ALFRED_PORT);
+	dest_addr.sin6_scope_id = interface->scope_id;
+	memcpy(&dest_addr.sin6_addr, dest, sizeof(*dest));
+
+	sock = socket(PF_INET6, SOCK_STREAM, IPPROTO_TCP);
+	if (sock < 0)
+		return -1;
+
+	flags = fcntl(sock, F_GETFL, 0);
+	if (flags < 0) {
+		close(sock);
+		return -1;
+	}
+	flags |= O_NONBLOCK;
+	if (fcntl(sock, F_SETFL, flags) < 0) {
+		close(sock);
+		return -1;
+	}
+	if (connect(sock, (struct sockaddr *)&dest_addr,
+		    sizeof(struct sockaddr_in6)) < 0
+	    && errno != EINPROGRESS) {
+		close(sock);
+		return -1;
+	}
+
+	/* put socket on the interface's tcp client list for writing */
+	tcp_connection = calloc(1, sizeof(*tcp_connection));
+	if (!tcp_connection) {
+		shutdown(sock, SHUT_RDWR);
+		close(sock);
+		return -1;
+	}
+
+	memcpy(&tcp_connection->address, dest, sizeof(tcp_connection->address));
+
+	tcp_connection->close = close_mode;
+	tcp_connection->netsock = sock;
+	tcp_connection->send_length = length;
+	tcp_connection->send_packet = buf;
+
+	tcp_connection->packet = calloc(1, sizeof(struct alfred_tlv));
+	if (!tcp_connection->packet) {
+		close(sock);
+		free(tcp_connection->send_packet);
+		free(tcp_connection);
+		return -1;
+	}
+
+	list_add(&tcp_connection->list, &interface->tcp_connections);
+
+	return 0;
+}
+
+ssize_t send_alfred_stream(struct tcp_connection *tcp_connection)
+{
+	ssize_t ret;
+	ret = send(tcp_connection->netsock,
+		   (uint8_t*) tcp_connection->send_packet
+		   + tcp_connection->written,
+		   tcp_connection->send_length,
+		   MSG_NOSIGNAL);
+
+	if (ret < 0) {
+		if (errno == EAGAIN || errno == EWOULDBLOCK)
+			return 0;
+		/* another error: do not try to send again */
+		tcp_connection->send_length = 0;
+		return -1;
+	}
+
+	tcp_connection->written += ret;
+	tcp_connection->send_length -= ret;
+
+	if (tcp_connection->send_length == 0)
+		return -1;
+
+	return 0;
+}
diff --git a/server.c b/server.c
index 47aee4f..5be7516 100644
--- a/server.c
+++ b/server.c
@@ -222,6 +222,7 @@ static void check_if_socket(struct interface *interface)
 {
 	int sock;
 	struct ifreq ifr;
+	struct tcp_connection *tcp_connection, *tc;
 
 	if (interface->netsock < 0)
 		return;
@@ -261,10 +262,23 @@ static void check_if_socket(struct interface *interface)
 	return;
 
 close:
+	list_for_each_entry_safe(tcp_connection, tc,
+			         &interface->tcp_connections, list) {
+		shutdown(tcp_connection->netsock, SHUT_RDWR);
+		close(tcp_connection->netsock);
+		list_del(&tcp_connection->list);
+		if (tcp_connection->packet)
+			free(tcp_connection->packet);
+		if (tcp_connection->send_packet)
+			free(tcp_connection->send_packet);
+		free(tcp_connection);
+	}
 	close(interface->netsock);
 	close(interface->netsock_mcast);
+	close(interface->netsock_tcp);
 	interface->netsock = -1;
 	interface->netsock_mcast = -1;
+	interface->netsock_tcp = -1;
 	close(sock);
 }
 
@@ -338,7 +352,7 @@ int alfred_server(struct globals *globals)
 {
 	int maxsock, ret, recvs;
 	struct timespec last_check, now, tv;
-	fd_set fds, errfds;
+	fd_set fds, wrfds, errfds;
 	int num_socks;
 
 	if (create_hashes(globals))
@@ -381,14 +395,23 @@ int alfred_server(struct globals *globals)
 		netsock_reopen(globals);
 
 		FD_ZERO(&fds);
+		FD_ZERO(&wrfds);
 		FD_ZERO(&errfds);
 		FD_SET(globals->unix_sock, &fds);
 		maxsock = globals->unix_sock;
 
+		/* testing write sockets might clean up socket list,
+		 * so this has to be done before proceeding to the
+		 * list of sockets tested for reading
+		 */
+		maxsock = netsock_prepare_write_select(globals, &wrfds,
+						       maxsock);
+		maxsock = netsock_prepare_write_select(globals, &errfds,
+						       maxsock);
 		maxsock = netsock_prepare_select(globals, &fds, maxsock);
 		maxsock = netsock_prepare_select(globals, &errfds, maxsock);
 
-		ret = pselect(maxsock + 1, &fds, NULL, &errfds, &tv, NULL);
+		ret = pselect(maxsock + 1, &fds, &wrfds, &errfds, &tv, NULL);
 
 		if (ret == -1) {
 			perror("main loop select failed ...");
@@ -404,6 +427,9 @@ int alfred_server(struct globals *globals)
 				if (recvs > 0)
 					continue;
 			}
+
+			if (netsock_send(globals, &wrfds) > 0)
+				continue;
 		}
 		clock_gettime(CLOCK_MONOTONIC, &last_check);
 
diff --git a/unix_sock.c b/unix_sock.c
index a0ccc13..d00569b 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -222,6 +222,7 @@ static int unix_sock_req_data(struct globals *globals,
 {
 	int len;
 	uint16_t id;
+	uint8_t *buf;
 	struct transaction_head *head = NULL;
 	struct interface *interface;
 
@@ -251,6 +252,19 @@ static int unix_sock_req_data(struct globals *globals,
 	head->client_socket = client_sock;
 	head->requested_type = request->requested_type;
 
+	if (globals->requestproto == REQPROTO_TCP) {
+		buf = malloc(sizeof(*request));
+		if (buf) {
+			memcpy(buf, request, sizeof(*request));
+			if (!open_alfred_stream(interface,
+						&globals->best_server->address,
+						buf, sizeof(*request),
+						CLOSE_WHEN_READ))
+				return 0;
+		}
+	}
+
+	/* default and fallback case: UDP */
 	send_alfred_packet(interface, &globals->best_server->address,
 			   request, sizeof(*request));
 
-- 
2.7.3

