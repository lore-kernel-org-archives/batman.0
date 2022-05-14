Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2] alfred: notify event listener via unix socket
Date: Sat, 14 May 2022 11:51:38 +0200
Message-ID: <1727325.kRQH6uYu6r@sven-desktop>
In-Reply-To: <20220502114651.771309-1-mareklindner@neomailbox.ch>
References: <20220502114651.771309-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1907190.mxpl7Bh0yD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart1907190.mxpl7Bh0yD
Content-Type: multipart/mixed; boundary="nextPart11645218.M3HkLxOC8E"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH v2] alfred: notify event listener via unix socket
Date: Sat, 14 May 2022 11:51:38 +0200
Message-ID: <1727325.kRQH6uYu6r@sven-desktop>
In-Reply-To: <20220502114651.771309-1-mareklindner@neomailbox.ch>
References: <20220502114651.771309-1-mareklindner@neomailbox.ch>

This is a multi-part message in MIME format.

--nextPart11645218.M3HkLxOC8E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 2 May 2022 13:46:51 CEST Marek Lindner wrote:
> The alfred server instance accepts event notification registration
> via the unix socket. These notification sockets only inform
> registered parties of the availability of an alfred datatype change.
> The actual data itself needs to be retrieved via the existing data
> retrieval mechanisms.
> 
> Unlike the update-command this event monitor allows:
> 
> - multiple parallel listeners
> - programmatic access to changes without requiring multiple processes
> 
> The alfred client allows to monitor events via the newly added '-E'
> (event monitor) command line option. Serving as debugging tool and
> example code at the same time.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> 
> v2:
> - fix typ0s
> - replace list_del_init() with list_del()
> - remove unnecessary INIT_LIST_HEAD()
> - change --event-monitor to not require an argument

This version cannot be applied on top of the current master. I have attached 
the diff for the things which (afaik) need to be changed when you rebase the 
patch.

I have also attached the change to support the reporting of the source mac for 
the changed dataset.


Kind regards,
	Sven
--nextPart11645218.M3HkLxOC8E
Content-Disposition: attachment; filename="0001-fixup-rebase.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-fixup-rebase.patch"

diff --git a/alfred.h b/alfred.h
index 668e856..f00346d 100644
--- a/alfred.h
+++ b/alfred.h
@@ -121,6 +121,7 @@ struct interface {
 
 struct event_listener {
 	int fd;
+	struct epoll_handle epoll;
 
 	struct list_head list;
 };
@@ -208,10 +209,6 @@ int unix_sock_open_client(struct globals *globals);
 int unix_sock_close(struct globals *globals);
 int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head);
-int unix_sock_events_select_prepare(struct globals *globals, fd_set *fds,
-				    fd_set *errfds, int maxsock);
-void unix_sock_events_select_handle(struct globals *globals,
-				    fd_set *fds, fd_set *errfds);
 void unix_sock_events_close_all(struct globals *globals);
 void unix_sock_event_notify(struct globals *globals, uint8_t type);
 /* vis.c */
diff --git a/main.c b/main.c
index 885b950..3fe7b42 100644
--- a/main.c
+++ b/main.c
@@ -164,12 +164,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"modeswitch",		required_argument,	NULL,	'M'},
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"change-bat-iface",	required_argument,	NULL,	'B'},
-<<<<<<< HEAD
 		{"server-status",	no_argument,		NULL,	'S'},
-=======
-		{"server-status",	required_argument,	NULL,	'S'},
 		{"event-monitor",	no_argument,		NULL,	'E'},
->>>>>>> 08415c9 (alfred: notify event listener via unix socket)
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"update-command",	required_argument,	NULL,	'c'},
 		{"version",		no_argument,		NULL,	'v'},
diff --git a/server.c b/server.c
index 15b4d77..0d792b0 100644
--- a/server.c
+++ b/server.c
@@ -513,54 +513,7 @@ int alfred_server(struct globals *globals)
 
 	while (1) {
 		netsock_reopen(globals);
-<<<<<<< HEAD
 		process_events(globals);
-=======
-
-		FD_ZERO(&fds);
-		FD_ZERO(&errfds);
-		FD_SET(globals->unix_sock, &fds);
-		maxsock = globals->unix_sock;
-
-		maxsock = netsock_prepare_select(globals, &fds, maxsock);
-		maxsock = netsock_prepare_select(globals, &errfds, maxsock);
-		maxsock = unix_sock_events_select_prepare(globals, &fds,
-							  &errfds, maxsock);
-
-		ret = pselect(maxsock + 1, &fds, NULL, &errfds, &tv, NULL);
-
-		if (ret == -1) {
-			perror("main loop select failed ...");
-		} else if (ret) {
-			netsock_check_error(globals, &errfds);
-
-			unix_sock_events_select_handle(globals, &fds, &errfds);
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
-		clock_gettime(CLOCK_MONOTONIC, &last_check);
-
-		if (globals->opmode == OPMODE_PRIMARY) {
-			/* we are a primary */
-			printf("[%ld.%09ld] announce primary ...\n", last_check.tv_sec, last_check.tv_nsec);
-			announce_primary(globals);
-			sync_data(globals);
-		} else {
-			/* send local data to server */
-			update_server_info(globals);
-			push_local_data(globals);
-		}
-		purge_data(globals);
-		check_if_sockets(globals);
-		execute_update_command(globals);
->>>>>>> 08415c9 (alfred: notify event listener via unix socket)
 	}
 
 	netsock_close_all(globals);
diff --git a/unix_sock.c b/unix_sock.c
index 2d7fc2e..14d63dd 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -27,6 +27,9 @@
 static void unix_sock_read(struct globals *globals,
 			   struct epoll_handle *handle __unused,
 			   struct epoll_event *ev __unused);
+static void unix_sock_event_listener_handle(struct globals *globals __unused,
+					    struct epoll_handle *handle,
+					    struct epoll_event *ev);
 
 int unix_sock_open_daemon(struct globals *globals)
 {
@@ -496,14 +499,10 @@ err:
 	return ret;
 }
 
-<<<<<<< HEAD
-static void unix_sock_read(struct globals *globals,
-			   struct epoll_handle *handle __unused,
-			   struct epoll_event *ev __unused)
-=======
 static int unix_sock_register_listener(struct globals *globals, int client_sock)
 {
 	struct event_listener *listener;
+	struct epoll_event ev;
 	int ret;
 
 	ret = fcntl(client_sock, F_GETFL, 0);
@@ -522,6 +521,16 @@ static int unix_sock_register_listener(struct globals *globals, int client_sock)
 	if (!listener)
 		goto err;
 
+	ev.events = EPOLLIN;
+	ev.data.ptr = &listener->epoll;
+	listener->epoll.handler = unix_sock_event_listener_handle;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, client_sock,
+		      &ev) == -1) {
+		perror("Failed to add epoll for event listener");
+		goto err;
+	}
+
 	listener->fd = client_sock;
 	list_add_tail(&listener->list, &globals->event_listeners);
 	return 0;
@@ -531,8 +540,9 @@ err:
 	return -1;
 }
 
-int unix_sock_read(struct globals *globals)
->>>>>>> 08415c9 (alfred: notify event listener via unix socket)
+static void unix_sock_read(struct globals *globals,
+			   struct epoll_handle *handle __unused,
+			   struct epoll_event *ev __unused)
 {
 	int client_sock;
 	struct sockaddr_un sun_addr;
@@ -598,7 +608,7 @@ int unix_sock_read(struct globals *globals)
 		unix_sock_server_status(globals, client_sock);
 		break;
 	case ALFRED_EVENT_REGISTER:
-		ret = unix_sock_register_listener(globals, client_sock);
+		unix_sock_register_listener(globals, client_sock);
 		break;
 	default:
 		/* unknown packet type */
@@ -642,55 +652,33 @@ static void unix_sock_event_notify_listener(struct event_listener *listener,
 	unix_sock_event_listener_free(listener);
 }
 
-int unix_sock_events_select_prepare(struct globals *globals, fd_set *fds,
-				    fd_set *errfds, int maxsock)
+static void unix_sock_event_listener_handle(struct globals *globals __unused,
+					    struct epoll_handle *handle,
+					    struct epoll_event *ev)
 {
 	struct event_listener *listener;
-
-	list_for_each_entry(listener, &globals->event_listeners, list) {
-		if (listener->fd < 0)
-			continue;
-
-		FD_SET(listener->fd, fds);
-		FD_SET(listener->fd, errfds);
-
-		if (maxsock < listener->fd)
-			maxsock = listener->fd;
-	}
-
-	return maxsock;
-}
-
-void unix_sock_events_select_handle(struct globals *globals,
-				    fd_set *fds, fd_set *errfds)
-{
-	struct event_listener *listener, *tmp;
 	char buff[4];
 	int ret;
 
-	list_for_each_entry_safe(listener, tmp,
-				 &globals->event_listeners, list) {
-		if (FD_ISSET(listener->fd, fds)) {
-			ret = recv(listener->fd, buff, sizeof(buff),
-				   MSG_PEEK | MSG_DONTWAIT);
-			/* listener has hung up */
-			if (ret == 0)
-				unix_sock_event_listener_free(listener);
-			else if (ret > 0) {
-				fprintf(stderr, "Event listener has written to socket: %d - closing\n",
-					listener->fd);
-				unix_sock_event_listener_free(listener);
-			}
-
-			if (ret >= 0)
-				continue;
-		}
+	listener = container_of(handle, struct event_listener, epoll);
+
+	if (ev->events & EPOLLERR) {
+		fprintf(stderr, "Error on event listener detected: %d\n",
+			listener->fd);
+		unix_sock_event_listener_free(listener);
+		return;
+	}
 
-		if (FD_ISSET(listener->fd, errfds)) {
-			fprintf(stderr, "Error on event listener detected: %d\n",
+	if (ev->events & EPOLLIN) {
+		ret = recv(listener->fd, buff, sizeof(buff),
+			   MSG_PEEK | MSG_DONTWAIT);
+		/* listener has hung up */
+		if (ret == 0)
+			unix_sock_event_listener_free(listener);
+		else if (ret > 0) {
+			fprintf(stderr, "Event listener has written to socket: %d - closing\n",
 				listener->fd);
 			unix_sock_event_listener_free(listener);
-			continue;
 		}
 	}
 }

--nextPart11645218.M3HkLxOC8E
Content-Disposition: attachment; filename="0002-move-functions-to-same-place.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-move-functions-to-same-place.patch"

diff --git a/unix_sock.c b/unix_sock.c
index 14d63dd..fd487b9 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -27,9 +27,8 @@
 static void unix_sock_read(struct globals *globals,
 			   struct epoll_handle *handle __unused,
 			   struct epoll_event *ev __unused);
-static void unix_sock_event_listener_handle(struct globals *globals __unused,
-					    struct epoll_handle *handle,
-					    struct epoll_event *ev);
+static int unix_sock_register_listener(struct globals *globals,
+				       int client_sock);
 
 int unix_sock_open_daemon(struct globals *globals)
 {
@@ -499,47 +498,6 @@ err:
 	return ret;
 }
 
-static int unix_sock_register_listener(struct globals *globals, int client_sock)
-{
-	struct event_listener *listener;
-	struct epoll_event ev;
-	int ret;
-
-	ret = fcntl(client_sock, F_GETFL, 0);
-	if (ret < 0) {
-		perror("failed to get file status flags");
-		goto err;
-	}
-
-	ret = fcntl(client_sock, F_SETFL, ret | O_NONBLOCK);
-	if (ret < 0) {
-		perror("failed to set file status flags");
-		goto err;
-	}
-
-	listener = malloc(sizeof(*listener));
-	if (!listener)
-		goto err;
-
-	ev.events = EPOLLIN;
-	ev.data.ptr = &listener->epoll;
-	listener->epoll.handler = unix_sock_event_listener_handle;
-
-	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, client_sock,
-		      &ev) == -1) {
-		perror("Failed to add epoll for event listener");
-		goto err;
-	}
-
-	listener->fd = client_sock;
-	list_add_tail(&listener->list, &globals->event_listeners);
-	return 0;
-
-err:
-	close(client_sock);
-	return -1;
-}
-
 static void unix_sock_read(struct globals *globals,
 			   struct epoll_handle *handle __unused,
 			   struct epoll_event *ev __unused)
@@ -634,24 +592,6 @@ static void unix_sock_event_listener_free(struct event_listener *listener)
 	free(listener);
 }
 
-static void unix_sock_event_notify_listener(struct event_listener *listener,
-					    uint8_t type)
-{
-	struct alfred_event_notify_v0 notify;
-	int ret;
-
-	notify.header.type = ALFRED_EVENT_NOTIFY;
-	notify.header.version = ALFRED_VERSION;
-	notify.header.length = FIXED_TLV_LEN(notify);
-	notify.type = type;
-
-	ret = write(listener->fd, &notify, sizeof(notify));
-	if (ret == sizeof(notify))
-		return;
-
-	unix_sock_event_listener_free(listener);
-}
-
 static void unix_sock_event_listener_handle(struct globals *globals __unused,
 					    struct epoll_handle *handle,
 					    struct epoll_event *ev)
@@ -683,6 +623,65 @@ static void unix_sock_event_listener_handle(struct globals *globals __unused,
 	}
 }
 
+static int unix_sock_register_listener(struct globals *globals, int client_sock)
+{
+	struct event_listener *listener;
+	struct epoll_event ev;
+	int ret;
+
+	ret = fcntl(client_sock, F_GETFL, 0);
+	if (ret < 0) {
+		perror("failed to get file status flags");
+		goto err;
+	}
+
+	ret = fcntl(client_sock, F_SETFL, ret | O_NONBLOCK);
+	if (ret < 0) {
+		perror("failed to set file status flags");
+		goto err;
+	}
+
+	listener = malloc(sizeof(*listener));
+	if (!listener)
+		goto err;
+
+	ev.events = EPOLLIN;
+	ev.data.ptr = &listener->epoll;
+	listener->epoll.handler = unix_sock_event_listener_handle;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, client_sock,
+		      &ev) == -1) {
+		perror("Failed to add epoll for event listener");
+		goto err;
+	}
+
+	listener->fd = client_sock;
+	list_add_tail(&listener->list, &globals->event_listeners);
+	return 0;
+
+err:
+	close(client_sock);
+	return -1;
+}
+
+static void unix_sock_event_notify_listener(struct event_listener *listener,
+					    uint8_t type)
+{
+	struct alfred_event_notify_v0 notify;
+	int ret;
+
+	notify.header.type = ALFRED_EVENT_NOTIFY;
+	notify.header.version = ALFRED_VERSION;
+	notify.header.length = FIXED_TLV_LEN(notify);
+	notify.type = type;
+
+	ret = write(listener->fd, &notify, sizeof(notify));
+	if (ret == sizeof(notify))
+		return;
+
+	unix_sock_event_listener_free(listener);
+}
+
 void unix_sock_events_close_all(struct globals *globals)
 {
 	struct event_listener *listener, *tmp;

--nextPart11645218.M3HkLxOC8E
Content-Disposition: attachment; filename="0003-support-source-in-event.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-support-source-in-event.patch"

diff --git a/alfred.h b/alfred.h
index f00346d..127b115 100644
--- a/alfred.h
+++ b/alfred.h
@@ -210,7 +210,8 @@ int unix_sock_close(struct globals *globals);
 int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head);
 void unix_sock_events_close_all(struct globals *globals);
-void unix_sock_event_notify(struct globals *globals, uint8_t type);
+void unix_sock_event_notify(struct globals *globals, uint8_t type,\
+			    const uint8_t source[ETH_ALEN]);
 /* vis.c */
 int vis_update_data(struct globals *globals);
 /* netsock.c */
diff --git a/client.c b/client.c
index d86d23c..ace42b9 100644
--- a/client.c
+++ b/client.c
@@ -499,7 +499,11 @@ int alfred_client_event_monitor(struct globals *globals)
 		if (event_notify.header.type != ALFRED_EVENT_NOTIFY)
 			continue;
 
-		fprintf(stdout, "Event: type = %hhu\n", event_notify.type);
+		fprintf(stdout, "Event: type = %hhu, source = %02x:%02x:%02x:%02x:%02x:%02x\n",
+			event_notify.type,
+			event_notify.source[0], event_notify.source[1],
+			event_notify.source[2], event_notify.source[3],
+			event_notify.source[4], event_notify.source[5]);
 	}
 
 err:
diff --git a/packet.h b/packet.h
index 84b027f..b8d528e 100644
--- a/packet.h
+++ b/packet.h
@@ -253,6 +253,7 @@ struct alfred_event_register_v0 {
 struct alfred_event_notify_v0 {
 	struct alfred_tlv header;
 	uint8_t type;
+	uint8_t source[ETH_ALEN];
 } __packed;
 
 /**
diff --git a/recv.c b/recv.c
index 36b3a49..75e3faf 100644
--- a/recv.c
+++ b/recv.c
@@ -78,7 +78,8 @@ static int finish_alfred_push_data(struct globals *globals,
 		    dataset->data.header.length != data_len ||
 		    memcmp(dataset->buf, data->data, data_len) != 0) {
 			changed_data_type(globals, data->header.type);
-			unix_sock_event_notify(globals, data->header.type);
+			unix_sock_event_notify(globals, data->header.type,
+					       data->source);
 		}
 
 		/* free old buffer */
diff --git a/unix_sock.c b/unix_sock.c
index fd487b9..ce08a51 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -166,7 +166,8 @@ static int unix_sock_add_data(struct globals *globals,
 	if (new_entry_created ||
 	    dataset->data.header.length != data_len ||
 	    memcmp(dataset->buf, data->data, data_len) != 0)
-		unix_sock_event_notify(globals, data->header.type);
+		unix_sock_event_notify(globals, data->header.type,
+				       data->source);
 
 	/* free old buffer */
 	free(dataset->buf);
@@ -665,7 +666,8 @@ err:
 }
 
 static void unix_sock_event_notify_listener(struct event_listener *listener,
-					    uint8_t type)
+					    uint8_t type,
+					    const uint8_t source[ETH_ALEN])
 {
 	struct alfred_event_notify_v0 notify;
 	int ret;
@@ -674,6 +676,7 @@ static void unix_sock_event_notify_listener(struct event_listener *listener,
 	notify.header.version = ALFRED_VERSION;
 	notify.header.length = FIXED_TLV_LEN(notify);
 	notify.type = type;
+	memcpy(&notify.source, source, ETH_ALEN);
 
 	ret = write(listener->fd, &notify, sizeof(notify));
 	if (ret == sizeof(notify))
@@ -692,13 +695,14 @@ void unix_sock_events_close_all(struct globals *globals)
 	}
 }
 
-void unix_sock_event_notify(struct globals *globals, uint8_t type)
+void unix_sock_event_notify(struct globals *globals, uint8_t type,
+			    const uint8_t source[ETH_ALEN])
 {
 	struct event_listener *listener, *tmp;
 
 	/* if event notify is unsuccessful, listener socket is closed */
 	list_for_each_entry_safe(listener, tmp,
 				 &globals->event_listeners, list) {
-		unix_sock_event_notify_listener(listener, type);
+		unix_sock_event_notify_listener(listener, type, source);
 	}
 }

--nextPart11645218.M3HkLxOC8E--

--nextPart1907190.mxpl7Bh0yD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmJ/e6oACgkQXYcKB8Em
e0YRSA/9EQHjsS8UqosIwh6hXnJ7O0P1uIo3UogImtljFk08Yoe1TLcwW/jbXL4Y
fpsKUxC0t7N8BwuZ7CAJvx6ApD5VGeLUfyF8huyNF6Uw/Y+wHuvOb/1Gz7RGf4jF
Md5nkJl5xWYSFOQmLu7RLEwe/zPs+rpY5J7ddJu43uDU3UK/q046uGfQAAmD0//H
6KE24Wd32P/vd5CIYSzeWoUtRY9ezAivyGGKU9XhKhJJdl2noHWc6V3N5W8AMWVd
Zewac1knc+hqDrqBEBXsmw1yfBqjUdezKIME8DC76qiEK0rJZbzeYGraOxXf5VFZ
Ztewo4VQ1g6Zb5KUuFo7iRldwR9KPDYaoqm77OAE75TQ6kBZ87A22+H57CxrQNIr
0UPyAxXZK13aQ1z8YkFlwazzvR61W5VUZ2MS56T6FRpckhL2x7dR8hICLcqB+7Bj
Yh4989ZEhiPq68Ag4dG8gzWLTdnWJCuxTcCn9vAUvHog9RoQjysAR3o3nN1ODTkJ
nyuBFYxpdgjUPQBZQbDc+eDXVPN4RlEBZnmPREZILwnObRPjaArSGKGWTOIvlh7j
skgSq+U26mTc2nrMTHHcelk96yKe6Hy9FTOn2M9X7FcVOYlkd7C3w+73RP8/UcNt
Wz8X4NCmI7BCQEfH5D0ZsD8027idzfrNuf4Zcw9b+03E9E+UaVI=
=2DLC
-----END PGP SIGNATURE-----

--nextPart1907190.mxpl7Bh0yD--


