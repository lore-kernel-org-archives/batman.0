Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] alfred: Switch to epoll for socket handling
Date: Sun,  1 May 2022 14:28:30 +0200
Message-Id: <20220501122830.22344-2-sven@narfation.org>
In-Reply-To: <20220501122830.22344-1-sven@narfation.org>
References: <20220501122830.22344-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The select syscall has various problems when working with many sockets:

* only a fd less than FD_SETSIZE (usually 1024) is supported
* it is necessary to register all relevant fds manually before each select
  call
* when events are received, all the fds must be checked again the returned
  data

This can be solved by using epoll. File descriptors are only registered
once and only the relevant file descriptors are returned. And epoll will
also take care of walking in a round-robin fashion through all relevant
file descriptors in case a lot of file descriptors could be returned by the
kernel.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h         |  20 ++++--
 batadv_querynl.c |   4 --
 epoll_handle.h   |  25 +++++++
 netsock.c        | 171 ++++++++++++++++++++++++++---------------------
 server.c         | 127 ++++++++++++++++++++---------------
 unix_sock.c      |  59 ++++++++++------
 6 files changed, 243 insertions(+), 163 deletions(-)
 create mode 100644 epoll_handle.h

diff --git a/alfred.h b/alfred.h
index 2679515..4839c85 100644
--- a/alfred.h
+++ b/alfred.h
@@ -16,9 +16,10 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <time.h>
-#include <sys/select.h>
+#include <sys/epoll.h>
 #include <sys/types.h>
 #include "bitops.h"
+#include "epoll_handle.h"
 #include "list.h"
 #include "packet.h"
 
@@ -30,6 +31,10 @@
 #define ALFRED_SOCK_PATH_DEFAULT	"/var/run/alfred.sock"
 #define NO_FILTER			-1
 
+#ifndef __unused
+#define __unused __attribute__((unused))
+#endif
+
 #define FIXED_TLV_LEN(__tlv_type) \
 	htons(sizeof(__tlv_type) - sizeof((__tlv_type).header))
 
@@ -101,9 +106,12 @@ struct interface {
 	alfred_addr address;
 	uint32_t scope_id;
 	char *interface;
+
 	int netsock;
 	int netsock_mcast;
-	int netsock_arp;
+
+	struct epoll_handle netsock_epoll;
+	struct epoll_handle netsock_mcast_epoll;
 
 	struct hashtable_t *server_hash;
 
@@ -124,9 +132,13 @@ struct globals {
 	uint8_t ipv4mode:1;
 	uint8_t force:1;
 
+	int epollfd;
+
 	int check_timerfd;
+	struct epoll_handle check_epoll;
 
 	int unix_sock;
+	struct epoll_handle unix_epoll;
 	const char *unix_path;
 
 	const char *update_command;
@@ -182,7 +194,6 @@ int sync_data(struct globals *globals);
 ssize_t send_alfred_packet(struct globals *globals, struct interface *interface,
 			   const alfred_addr *dest, void *buf, int length);
 /* unix_sock.c */
-int unix_sock_read(struct globals *globals);
 int unix_sock_open_daemon(struct globals *globals);
 int unix_sock_open_client(struct globals *globals);
 int unix_sock_close(struct globals *globals);
@@ -197,9 +208,6 @@ void netsock_close_all(struct globals *globals);
 int netsock_set_interfaces(struct globals *globals, char *interfaces);
 struct interface *netsock_first_interface(struct globals *globals);
 void netsock_reopen(struct globals *globals);
-int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock);
-void netsock_check_error(struct globals *globals, fd_set *errfds);
-int netsock_receive_packet(struct globals *globals, fd_set *fds);
 int netsock_own_address(const struct globals *globals,
 			const alfred_addr *address);
 /* util.c */
diff --git a/batadv_querynl.c b/batadv_querynl.c
index 872cb85..7c1b115 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -26,10 +26,6 @@
 #include "batadv_query.h"
 #include "netlink.h"
 
-#ifndef __unused
-#define __unused __attribute__((unused))
-#endif
-
 static const int translate_mac_netlink_mandatory[] = {
 	BATADV_ATTR_TT_ADDRESS,
 	BATADV_ATTR_ORIG_ADDRESS,
diff --git a/epoll_handle.h b/epoll_handle.h
new file mode 100644
index 0000000..4ec69b9
--- /dev/null
+++ b/epoll_handle.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Sven Eckelmann
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#ifndef _ALFRED_EPOLL_HANDLE_H
+#define _ALFRED_EPOLL_HANDLE_H
+
+#include <sys/epoll.h>
+
+struct globals;
+struct epoll_handle;
+
+typedef void (*epoll_handler)(struct globals *globals,
+			      struct epoll_handle *handle,
+			      struct epoll_event *ev);
+
+struct epoll_handle {
+	epoll_handler handler;
+};
+
+#endif /* _ALFRED_EPOLL_HANDLE_H */
diff --git a/netsock.c b/netsock.c
index 128e768..feed21d 100644
--- a/netsock.c
+++ b/netsock.c
@@ -20,7 +20,7 @@
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
-#include <sys/select.h>
+#include <sys/epoll.h>
 #ifdef CONFIG_ALFRED_CAPABILITIES
 #include <sys/capability.h>
 #endif
@@ -203,12 +203,59 @@ out:
 	return ret;
 }
 
-static int netsock_open(struct interface *interface)
+static void netsock_close_error(struct interface *interface)
+{
+	fprintf(stderr, "Error on netsock detected\n");
+
+	if (interface->netsock >= 0)
+		close(interface->netsock);
+
+	if (interface->netsock_mcast >= 0)
+		close(interface->netsock_mcast);
+
+	interface->netsock = -1;
+	interface->netsock_mcast = -1;
+}
+
+static void netsock_handle_event(struct globals *globals,
+				 struct epoll_handle *handle,
+				 struct epoll_event *ev)
+{
+	struct interface *interface;
+
+	interface = container_of(handle, struct interface, netsock_epoll);
+
+	if (ev->events & EPOLLERR) {
+		netsock_close_error(interface);
+		return;
+	}
+
+	recv_alfred_packet(globals, interface, interface->netsock);
+}
+
+static void netsock_mcast_handle_event(struct globals *globals,
+				       struct epoll_handle *handle,
+				       struct epoll_event *ev)
+{
+	struct interface *interface;
+
+	interface = container_of(handle, struct interface, netsock_mcast_epoll);
+
+	if (ev->events & EPOLLERR) {
+		netsock_close_error(interface);
+		return;
+	}
+
+	recv_alfred_packet(globals, interface, interface->netsock_mcast);
+}
+
+static int netsock_open(struct globals *globals, struct interface *interface)
 {
 	int sock;
 	int sock_mc;
 	struct sockaddr_in6 sin6, sin6_mc;
 	struct ipv6_mreq mreq;
+	struct epoll_event ev;
 	struct ifreq ifr;
 	int ret;
 
@@ -318,6 +365,26 @@ static int netsock_open(struct interface *interface)
 		goto err;
 	}
 
+	ev.events = EPOLLIN;
+	ev.data.ptr = &interface->netsock_epoll;
+	interface->netsock_epoll.handler = netsock_handle_event;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, sock,
+		      &ev) == -1) {
+		perror("Failed to add epoll for netsock");
+		goto err;
+	}
+
+	ev.events = EPOLLIN;
+	ev.data.ptr = &interface->netsock_mcast_epoll;
+	interface->netsock_mcast_epoll.handler = netsock_mcast_handle_event;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, sock_mc,
+		      &ev) == -1) {
+		perror("Failed to add epoll for netsock_mcast");
+		goto err;
+	}
+
 	interface->netsock = sock;
 	interface->netsock_mcast = sock_mc;
 
@@ -328,11 +395,12 @@ err:
 	return -1;
 }
 
-static int netsock_open4(struct interface *interface)
+static int netsock_open4(struct globals *globals, struct interface *interface)
 {
 	int sock;
 	int sock_mc;
 	struct sockaddr_in sin4, sin_mc;
+	struct epoll_event ev;
 	struct ip_mreq mreq;
 	struct ifreq ifr;
 	int ret;
@@ -446,6 +514,26 @@ static int netsock_open4(struct interface *interface)
 		goto err;
 	}
 
+	ev.events = EPOLLIN;
+	ev.data.ptr = &interface->netsock_epoll;
+	interface->netsock_epoll.handler = netsock_handle_event;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, sock,
+		      &ev) == -1) {
+		perror("Failed to add epoll for netsock");
+		goto err;
+	}
+
+	ev.events = EPOLLIN;
+	ev.data.ptr = &interface->netsock_mcast_epoll;
+	interface->netsock_mcast_epoll.handler = netsock_mcast_handle_event;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, sock_mc,
+		      &ev) == -1) {
+		perror("Failed to add epoll for netsock_mcast");
+		goto err;
+	}
+
 	interface->netsock = sock;
 	interface->netsock_mcast = sock_mc;
 
@@ -464,9 +552,9 @@ int netsock_open_all(struct globals *globals)
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		if (globals->ipv4mode)
-			ret = netsock_open4(interface);
+			ret = netsock_open4(globals, interface);
 		else
-			ret = netsock_open(interface);
+			ret = netsock_open(globals, interface);
 
 		if (ret >= 0)
 			num_socks++;
@@ -493,82 +581,13 @@ void netsock_reopen(struct globals *globals)
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		if (interface->netsock < 0) {
 			if (globals->ipv4mode)
-				netsock_open4(interface);
+				netsock_open4(globals, interface);
 			else
-				netsock_open(interface);
+				netsock_open(globals, interface);
 		}
 	}
 }
 
-int netsock_prepare_select(struct globals *globals, fd_set *fds, int maxsock)
-{
-	struct interface *interface;
-
-	list_for_each_entry(interface, &globals->interfaces, list) {
-		if (interface->netsock >= 0) {
-			FD_SET(interface->netsock, fds);
-			if (maxsock < interface->netsock)
-				maxsock = interface->netsock;
-		}
-
-		if (interface->netsock_mcast >= 0) {
-			FD_SET(interface->netsock_mcast, fds);
-			if (maxsock < interface->netsock_mcast)
-				maxsock = interface->netsock_mcast;
-		}
-	}
-
-	return maxsock;
-}
-
-void netsock_check_error(struct globals *globals, fd_set *errfds)
-{
-	struct interface *interface;
-
-	list_for_each_entry(interface, &globals->interfaces, list) {
-		if ((interface->netsock < 0 ||
-		     !FD_ISSET(interface->netsock, errfds)) &&
-		    (interface->netsock_mcast < 0 ||
-		     !FD_ISSET(interface->netsock_mcast, errfds)))
-			continue;
-
-		fprintf(stderr, "Error on netsock detected\n");
-
-		if (interface->netsock >= 0)
-			close(interface->netsock);
-
-		if (interface->netsock_mcast >= 0)
-			close(interface->netsock_mcast);
-
-		interface->netsock = -1;
-		interface->netsock_mcast = -1;
-	}
-}
-
-int netsock_receive_packet(struct globals *globals, fd_set *fds)
-{
-	struct interface *interface;
-	int recvs = 0;
-
-	list_for_each_entry(interface, &globals->interfaces, list) {
-		if (interface->netsock >= 0 &&
-		    FD_ISSET(interface->netsock, fds)) {
-			recv_alfred_packet(globals, interface,
-					   interface->netsock);
-			recvs++;
-		}
-
-		if (interface->netsock_mcast >= 0 &&
-		    FD_ISSET(interface->netsock_mcast, fds)) {
-			recv_alfred_packet(globals, interface,
-					   interface->netsock_mcast);
-			recvs++;
-		}
-	}
-
-	return recvs;
-}
-
 int netsock_own_address(const struct globals *globals,
 			const alfred_addr *address)
 {
diff --git a/server.c b/server.c
index b5ec7b2..52cdbe7 100644
--- a/server.c
+++ b/server.c
@@ -16,7 +16,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/select.h>
+#include <sys/epoll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
@@ -367,9 +367,62 @@ static void execute_update_command(struct globals *globals)
 	free(command);
 }
 
+static void process_events(struct globals *globals)
+{
+	/* WARNING only processing one event because it could be that
+	 * netsock + their fds are getting deleted
+	 */
+	struct epoll_event events[1];
+	struct epoll_handle *handle;
+	int nfds;
+
+	nfds = epoll_wait(globals->epollfd, events,
+			  sizeof(events) / sizeof(*events),  -1);
+	if (nfds == -1) {
+		if (errno == EINTR)
+			return;
+
+		perror("main loop select failed ...");
+		return;
+	}
+
+	for (int i = 0; i < nfds; i++) {
+		handle = (struct epoll_handle *)events[i].data.ptr;
+		handle->handler(globals, handle, &events[i]);
+	}
+}
+
+static void sync_period_timer(struct globals *globals,
+			      struct epoll_handle *handle __unused,
+			      struct epoll_event *ev __unused)
+{
+	struct timespec now;
+	uint64_t timer_exp;
+
+	read(globals->check_timerfd, &timer_exp, sizeof(timer_exp));
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (globals->opmode == OPMODE_PRIMARY) {
+		/* we are a primary */
+		printf("[%ld.%09ld] announce primary ...\n",
+		       now.tv_sec, now.tv_nsec);
+		announce_primary(globals);
+		sync_data(globals);
+	} else {
+		/* send local data to server */
+		update_server_info(globals);
+		push_local_data(globals);
+	}
+
+	purge_data(globals);
+	check_if_sockets(globals);
+	execute_update_command(globals);
+}
+
 static int create_sync_period_timer(struct globals *globals)
 {
 	struct itimerspec sync_timer;
+	struct epoll_event ev;
 	int ret;
 
 	globals->check_timerfd = timerfd_create(CLOCK_MONOTONIC, TFD_CLOEXEC);
@@ -387,21 +440,34 @@ static int create_sync_period_timer(struct globals *globals)
 		return -1;
 	}
 
+	ev.events = EPOLLIN;
+	ev.data.ptr = &globals->check_epoll;
+	globals->check_epoll.handler = sync_period_timer;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, globals->check_timerfd,
+		      &ev) == -1) {
+		perror("Failed to add epoll for check_timer");
+		return -1;
+	}
+
 	return 0;
 }
 
 int alfred_server(struct globals *globals)
 {
-	int maxsock, ret, recvs;
-	struct timespec now;
-	fd_set fds, errfds;
 	size_t num_interfaces;
-	uint64_t timer_exp;
+	struct timespec now;
 	int num_socks;
 
 	if (create_hashes(globals))
 		return -1;
 
+	globals->epollfd = epoll_create1(0);
+	if (globals->epollfd == -1) {
+		perror("Could not create epoll for main thread");
+		return -1;
+	}
+
 	if (create_sync_period_timer(globals))
 		return -1;
 
@@ -447,56 +513,7 @@ int alfred_server(struct globals *globals)
 
 	while (1) {
 		netsock_reopen(globals);
-
-		FD_ZERO(&fds);
-		FD_ZERO(&errfds);
-		FD_SET(globals->unix_sock, &fds);
-		maxsock = globals->unix_sock;
-
-		FD_SET(globals->check_timerfd, &fds);
-		if (maxsock < globals->check_timerfd)
-			maxsock = globals->check_timerfd;
-
-		maxsock = netsock_prepare_select(globals, &fds, maxsock);
-		maxsock = netsock_prepare_select(globals, &errfds, maxsock);
-
-		ret = pselect(maxsock + 1, &fds, NULL, &errfds, NULL, NULL);
-
-		if (ret == -1) {
-			perror("main loop select failed ...");
-		} else if (ret) {
-			netsock_check_error(globals, &errfds);
-
-			if (FD_ISSET(globals->unix_sock, &fds)) {
-				unix_sock_read(globals);
-				continue;
-			} else {
-				recvs = netsock_receive_packet(globals, &fds);
-				if (recvs > 0)
-					continue;
-			}
-		}
-
-		if (FD_ISSET(globals->check_timerfd, &fds)) {
-			read(globals->check_timerfd, &timer_exp,
-			     sizeof(timer_exp));
-			clock_gettime(CLOCK_MONOTONIC, &now);
-
-			if (globals->opmode == OPMODE_PRIMARY) {
-				/* we are a primary */
-				printf("[%ld.%09ld] announce primary ...\n",
-				       now.tv_sec, now.tv_nsec);
-				announce_primary(globals);
-				sync_data(globals);
-			} else {
-				/* send local data to server */
-				update_server_info(globals);
-				push_local_data(globals);
-			}
-			purge_data(globals);
-			check_if_sockets(globals);
-			execute_update_command(globals);
-		}
+		process_events(globals);
 	}
 
 	netsock_close_all(globals);
diff --git a/unix_sock.c b/unix_sock.c
index 3894736..ef72aa0 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -23,9 +23,14 @@
 #include "hash.h"
 #include "packet.h"
 
+static void unix_sock_read(struct globals *globals,
+			   struct epoll_handle *handle __unused,
+			   struct epoll_event *ev __unused);
+
 int unix_sock_open_daemon(struct globals *globals)
 {
 	struct sockaddr_un addr;
+	struct epoll_event ev;
 
 	unlink(globals->unix_path);
 
@@ -51,6 +56,16 @@ int unix_sock_open_daemon(struct globals *globals)
 		return -1;
 	}
 
+	ev.events = EPOLLIN;
+	ev.data.ptr = &globals->unix_epoll;
+	globals->unix_epoll.handler = unix_sock_read;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, globals->unix_sock,
+		      &ev) == -1) {
+		perror("Failed to add epoll for check_timer");
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -472,20 +487,22 @@ err:
 	return ret;
 }
 
-int unix_sock_read(struct globals *globals)
+static void unix_sock_read(struct globals *globals,
+			   struct epoll_handle *handle __unused,
+			   struct epoll_event *ev __unused)
 {
 	int client_sock;
 	struct sockaddr_un sun_addr;
 	socklen_t sun_size = sizeof(sun_addr);
 	struct alfred_tlv *packet;
 	uint8_t buf[MAX_PAYLOAD];
-	int length, headsize, ret = -1;
+	int length, headsize;
 
 	client_sock = accept(globals->unix_sock, (struct sockaddr *)&sun_addr,
 			     &sun_size);
 	if (client_sock < 0) {
 		perror("can't accept unix connection");
-		return -1;
+		return;
 	}
 
 	/* we assume that we can instantly read here. */
@@ -510,44 +527,42 @@ int unix_sock_read(struct globals *globals)
 
 	switch (packet->type) {
 	case ALFRED_PUSH_DATA:
-		ret = unix_sock_add_data(globals,
-					 (struct alfred_push_data_v0 *)packet,
-					 client_sock);
+		unix_sock_add_data(globals,
+				   (struct alfred_push_data_v0 *)packet,
+				   client_sock);
 		break;
 	case ALFRED_REQUEST:
-		ret = unix_sock_req_data(globals,
-					 (struct alfred_request_v0 *)packet,
-					 client_sock);
+		unix_sock_req_data(globals,
+				   (struct alfred_request_v0 *)packet,
+				   client_sock);
 		break;
 	case ALFRED_MODESWITCH:
-		ret = unix_sock_modesw(globals,
-				       (struct alfred_modeswitch_v0 *)packet,
-				       client_sock);
+		unix_sock_modesw(globals,
+				 (struct alfred_modeswitch_v0 *)packet,
+				 client_sock);
 		break;
 	case ALFRED_CHANGE_INTERFACE:
-		ret = unix_sock_change_iface(globals,
-					     (struct alfred_change_interface_v0 *)packet,
-					     client_sock);
+		 unix_sock_change_iface(globals,
+					(struct alfred_change_interface_v0 *)packet,
+					client_sock);
 		break;
 	case ALFRED_CHANGE_BAT_IFACE:
-		ret = unix_sock_change_bat_iface(globals,
-						 (struct alfred_change_bat_iface_v0 *)packet,
-						 client_sock);
+		unix_sock_change_bat_iface(globals,
+					   (struct alfred_change_bat_iface_v0 *)packet,
+					   client_sock);
 		break;
 	case ALFRED_SERVER_STATUS:
-		ret = unix_sock_server_status(globals, client_sock);
+		unix_sock_server_status(globals, client_sock);
 		break;
 	default:
 		/* unknown packet type */
-		ret = -1;
 		goto err;
 	}
 
-	return ret;
+	return;
 
 err:
 	close(client_sock);
-	return ret;
 }
 
 int unix_sock_close(struct globals *globals)
-- 
2.30.2

