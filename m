Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH v3] alfred: notify event listener via unix socket
Date: Thu, 19 May 2022 09:26:05 +0200
Message-Id: <20220519072605.214254-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

The alfred server instance accepts event notification registration
via the unix socket. These notification sockets only inform
registered parties of the availability of an alfred datatype change.
The actual data itself needs to be retrieved via the existing data
retrieval mechanisms.

Unlike the update-command this event monitor allows:

- multiple parallel listeners
- programmatic access to changes without requiring multiple processes

The alfred client allows to monitor events via the newly added '-E'
(event monitor) command line option. Serving as debugging tool and
example code at the same time.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---

v3:
- rebase on top of master
- convert to epoll
- add source MAC address to event details

v2:
- fix typ0s
- replace list_del_init() with list_del()
- remove unnecessary INIT_LIST_HEAD()
- change --event-monitor to not require an argument

 alfred.h     |  13 +++++
 client.c     |  58 ++++++++++++++++++++++
 main.c       |  10 +++-
 man/alfred.8 |   3 ++
 packet.h     |  27 ++++++++++
 recv.c       |   5 +-
 server.c     |   1 +
 unix_sock.c  | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 251 insertions(+), 2 deletions(-)

diff --git a/alfred.h b/alfred.h
index 8bea033..127b115 100644
--- a/alfred.h
+++ b/alfred.h
@@ -99,6 +99,7 @@ enum clientmode {
 	CLIENT_CHANGE_INTERFACE,
 	CLIENT_CHANGE_BAT_IFACE,
 	CLIENT_SERVER_STATUS,
+	CLIENT_EVENT_MONITOR,
 };
=20
 struct interface {
@@ -118,8 +119,16 @@ struct interface {
 	struct list_head list;
 };
=20
+struct event_listener {
+	int fd;
+	struct epoll_handle epoll;
+
+	struct list_head list;
+};
+
 struct globals {
 	struct list_head interfaces;
+	struct list_head event_listeners;
=20
 	char *net_iface;
 	struct server *best_server;	/* NULL if we are a server ourselves */
@@ -171,6 +180,7 @@ int alfred_client_modeswitch(struct globals *globals)=
;
 int alfred_client_change_interface(struct globals *globals);
 int alfred_client_change_bat_iface(struct globals *globals);
 int alfred_client_server_status(struct globals *globals);
+int alfred_client_event_monitor(struct globals *globals);
 /* recv.c */
 int recv_alfred_packet(struct globals *globals, struct interface *interf=
ace,
 		       int recv_sock);
@@ -199,6 +209,9 @@ int unix_sock_open_client(struct globals *globals);
 int unix_sock_close(struct globals *globals);
 int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head);
+void unix_sock_events_close_all(struct globals *globals);
+void unix_sock_event_notify(struct globals *globals, uint8_t type,\
+			    const uint8_t source[ETH_ALEN]);
 /* vis.c */
 int vis_update_data(struct globals *globals);
 /* netsock.c */
diff --git a/client.c b/client.c
index 81cdd7c..ace42b9 100644
--- a/client.c
+++ b/client.c
@@ -452,3 +452,61 @@ err:
 	unix_sock_close(globals);
 	return 0;
 }
+
+int alfred_client_event_monitor(struct globals *globals)
+{
+	struct alfred_event_register_v0 event_register;
+	struct alfred_event_notify_v0 event_notify;
+	int ret, len;
+
+	if (unix_sock_open_client(globals))
+		return -1;
+
+	len =3D sizeof(event_register);
+
+	event_register.header.type =3D ALFRED_EVENT_REGISTER;
+	event_register.header.version =3D ALFRED_VERSION;
+	event_register.header.length =3D 0;
+
+	ret =3D write(globals->unix_sock, &event_register, len);
+	if (ret !=3D len) {
+		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
+			__func__, ret, len, strerror(errno));
+		goto err;
+	}
+
+	while (true) {
+		len =3D read(globals->unix_sock, &event_notify, sizeof(event_notify));
+		if (len =3D=3D 0) {
+			fprintf(stdout, "Server closed the connection\n");
+			goto err;
+		}
+
+		if (len < 0) {
+			perror("read from unix socket failed");
+			goto err;
+		}
+
+		if (len !=3D sizeof(event_notify)) {
+			fprintf(stderr, "notify read bytes: %d (expected: %zu)\n",
+				len, sizeof(event_notify));
+				goto err;
+		}
+
+		if (event_notify.header.version !=3D ALFRED_VERSION)
+			continue;
+
+		if (event_notify.header.type !=3D ALFRED_EVENT_NOTIFY)
+			continue;
+
+		fprintf(stdout, "Event: type =3D %hhu, source =3D %02x:%02x:%02x:%02x:=
%02x:%02x\n",
+			event_notify.type,
+			event_notify.source[0], event_notify.source[1],
+			event_notify.source[2], event_notify.source[3],
+			event_notify.source[4], event_notify.source[5]);
+	}
+
+err:
+	unix_sock_close(globals);
+	return 0;
+}
diff --git a/main.c b/main.c
index 30e18a5..3fe7b42 100644
--- a/main.c
+++ b/main.c
@@ -39,6 +39,7 @@ static void alfred_usage(void)
 	printf("  -I, --change-interface [interface]  change to the specified i=
nterface(s)\n");
 	printf("  -B, --change-bat-iface [interface]  change to the specified b=
atman-adv interface\n");
 	printf("  -S, --server-status                 request server status inf=
o such as mode & interfaces\n");
+	printf("  -E, --event-monitor                 monitor alfred data recor=
d update events\n");
 	printf("\n");
 	printf("server mode options:\n");
 	printf("  -i, --interface                     specify the interface (or=
 comma separated list of interfaces) to listen on\n");
@@ -164,6 +165,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"change-bat-iface",	required_argument,	NULL,	'B'},
 		{"server-status",	no_argument,		NULL,	'S'},
+		{"event-monitor",	no_argument,		NULL,	'E'},
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"update-command",	required_argument,	NULL,	'c'},
 		{"version",		no_argument,		NULL,	'v'},
@@ -181,6 +183,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 	memset(globals, 0, sizeof(*globals));
=20
 	INIT_LIST_HEAD(&globals->interfaces);
+	INIT_LIST_HEAD(&globals->event_listeners);
 	globals->net_iface =3D NULL;
 	globals->opmode =3D OPMODE_SECONDARY;
 	globals->clientmode =3D CLIENT_NONE;
@@ -198,7 +201,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
=20
 	time_random_seed();
=20
-	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:B:Su:dc:p:4:f=
", long_options,
+	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:B:SEu:dc:p:4:=
f", long_options,
 				  &opt_ind)) !=3D -1) {
 		switch (opt) {
 		case 'r':
@@ -263,6 +266,9 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 		case 'S':
 			globals->clientmode =3D CLIENT_SERVER_STATUS;
 			break;
+		case 'E':
+			globals->clientmode =3D CLIENT_EVENT_MONITOR;
+			break;
 		case 'u':
 			globals->unix_path =3D optarg;
 			break;
@@ -328,6 +334,8 @@ int main(int argc, char *argv[])
 		return alfred_client_change_bat_iface(globals);
 	case CLIENT_SERVER_STATUS:
 		return alfred_client_server_status(globals);
+	case CLIENT_EVENT_MONITOR:
+		return alfred_client_event_monitor(globals);
 	}
=20
 	return 0;
diff --git a/man/alfred.8 b/man/alfred.8
index cf0eafc..ca83f02 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -97,6 +97,9 @@ Change the alfred server to use the new \fBbatman-adv i=
nterface\fP
 .TP
 \fB\-S\fP, \fB\-\-server\-status\fP
 Request server status information such as mode & interfaces\fP
+.TP
+\fB\-E\fP, \fB\-\-event\-monitor\fP
+Start alfred event monitor connecting to the alfred server and reporting=
 update events\fP
 .
 .SH SERVER OPTIONS
 .TP
diff --git a/packet.h b/packet.h
index 0c1a2eb..b8d528e 100644
--- a/packet.h
+++ b/packet.h
@@ -59,6 +59,8 @@ struct alfred_transaction_mgmt {
  * @ALFRED_STATUS_ERROR: Error was detected during the transaction
  * @ALFRED_MODESWITCH: Switch between different operation modes
  * @ALFRED_CHANGE_INTERFACE: Change the listening interface
+ * @ALFRED_EVENT_REGISTER: Request to be notified about alfred update ev=
ents
+ * @ALFRED_EVENT_NOTIFY: Data record update has been received
  */
 enum alfred_packet_type {
 	ALFRED_PUSH_DATA =3D 0,
@@ -70,6 +72,8 @@ enum alfred_packet_type {
 	ALFRED_CHANGE_INTERFACE =3D 6,
 	ALFRED_CHANGE_BAT_IFACE =3D 7,
 	ALFRED_SERVER_STATUS =3D 8,
+	ALFRED_EVENT_REGISTER =3D 9,
+	ALFRED_EVENT_NOTIFY =3D 10,
 };
=20
 /* packets */
@@ -229,6 +233,29 @@ struct alfred_server_status_rep_v0 {
 	struct alfred_tlv header;
 } __packed;
=20
+/**
+ * struct alfred_event_register_v0 - event registration message
+ * @header: TLV header describing the complete packet
+ *
+ * Sent by the client to daemon to register for data record updates
+ */
+struct alfred_event_register_v0 {
+	struct alfred_tlv header;
+} __packed;
+
+/**
+ * struct alfred_event_notify_v0 - event notification message
+ * @header: TLV header describing the complete packet
+ * @type: Type of the data triggering the event
+ *
+ * Sent by the daemon to client on data record update
+ */
+struct alfred_event_notify_v0 {
+	struct alfred_tlv header;
+	uint8_t type;
+	uint8_t source[ETH_ALEN];
+} __packed;
+
 /**
  * struct alfred_status_v0 - Status info of a transaction
  * @header: TLV header describing the complete packet
diff --git a/recv.c b/recv.c
index 8acad10..75e3faf 100644
--- a/recv.c
+++ b/recv.c
@@ -76,8 +76,11 @@ static int finish_alfred_push_data(struct globals *glo=
bals,
 		/* check that data was changed */
 		if (new_entry_created ||
 		    dataset->data.header.length !=3D data_len ||
-		    memcmp(dataset->buf, data->data, data_len) !=3D 0)
+		    memcmp(dataset->buf, data->data, data_len) !=3D 0) {
 			changed_data_type(globals, data->header.type);
+			unix_sock_event_notify(globals, data->header.type,
+					       data->source);
+		}
=20
 		/* free old buffer */
 		if (dataset->buf) {
diff --git a/server.c b/server.c
index 52cdbe7..0d792b0 100644
--- a/server.c
+++ b/server.c
@@ -518,5 +518,6 @@ int alfred_server(struct globals *globals)
=20
 	netsock_close_all(globals);
 	unix_sock_close(globals);
+	unix_sock_events_close_all(globals);
 	return 0;
 }
diff --git a/unix_sock.c b/unix_sock.c
index ef72aa0..ce08a51 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 #include <sys/time.h>
 #include <sys/un.h>
@@ -26,6 +27,8 @@
 static void unix_sock_read(struct globals *globals,
 			   struct epoll_handle *handle __unused,
 			   struct epoll_event *ev __unused);
+static int unix_sock_register_listener(struct globals *globals,
+				       int client_sock);
=20
 int unix_sock_open_daemon(struct globals *globals)
 {
@@ -99,6 +102,7 @@ static int unix_sock_add_data(struct globals *globals,
 			      struct alfred_push_data_v0 *push,
 			      int client_sock)
 {
+	bool new_entry_created =3D false;
 	struct alfred_data *data;
 	struct dataset *dataset;
 	int len, data_len, ret =3D -1;
@@ -153,10 +157,18 @@ static int unix_sock_add_data(struct globals *globa=
ls,
 			free(dataset);
 			goto err;
 		}
+		new_entry_created =3D true;
 	}
 	dataset->data_source =3D SOURCE_LOCAL;
 	clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);
=20
+	/* check that data was changed */
+	if (new_entry_created ||
+	    dataset->data.header.length !=3D data_len ||
+	    memcmp(dataset->buf, data->data, data_len) !=3D 0)
+		unix_sock_event_notify(globals, data->header.type,
+				       data->source);
+
 	/* free old buffer */
 	free(dataset->buf);
=20
@@ -554,6 +566,9 @@ static void unix_sock_read(struct globals *globals,
 	case ALFRED_SERVER_STATUS:
 		unix_sock_server_status(globals, client_sock);
 		break;
+	case ALFRED_EVENT_REGISTER:
+		unix_sock_register_listener(globals, client_sock);
+		break;
 	default:
 		/* unknown packet type */
 		goto err;
@@ -570,3 +585,124 @@ int unix_sock_close(struct globals *globals)
 	close(globals->unix_sock);
 	return 0;
 }
+
+static void unix_sock_event_listener_free(struct event_listener *listene=
r)
+{
+	list_del(&listener->list);
+	close(listener->fd);
+	free(listener);
+}
+
+static void unix_sock_event_listener_handle(struct globals *globals __un=
used,
+					    struct epoll_handle *handle,
+					    struct epoll_event *ev)
+{
+	struct event_listener *listener;
+	char buff[4];
+	int ret;
+
+	listener =3D container_of(handle, struct event_listener, epoll);
+
+	if (ev->events & EPOLLERR) {
+		fprintf(stderr, "Error on event listener detected: %d\n",
+			listener->fd);
+		unix_sock_event_listener_free(listener);
+		return;
+	}
+
+	if (ev->events & EPOLLIN) {
+		ret =3D recv(listener->fd, buff, sizeof(buff),
+			   MSG_PEEK | MSG_DONTWAIT);
+		/* listener has hung up */
+		if (ret =3D=3D 0)
+			unix_sock_event_listener_free(listener);
+		else if (ret > 0) {
+			fprintf(stderr, "Event listener has written to socket: %d - closing\n=
",
+				listener->fd);
+			unix_sock_event_listener_free(listener);
+		}
+	}
+}
+
+static int unix_sock_register_listener(struct globals *globals, int clie=
nt_sock)
+{
+	struct event_listener *listener;
+	struct epoll_event ev;
+	int ret;
+
+	ret =3D fcntl(client_sock, F_GETFL, 0);
+	if (ret < 0) {
+		perror("failed to get file status flags");
+		goto err;
+	}
+
+	ret =3D fcntl(client_sock, F_SETFL, ret | O_NONBLOCK);
+	if (ret < 0) {
+		perror("failed to set file status flags");
+		goto err;
+	}
+
+	listener =3D malloc(sizeof(*listener));
+	if (!listener)
+		goto err;
+
+	ev.events =3D EPOLLIN;
+	ev.data.ptr =3D &listener->epoll;
+	listener->epoll.handler =3D unix_sock_event_listener_handle;
+
+	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, client_sock,
+		      &ev) =3D=3D -1) {
+		perror("Failed to add epoll for event listener");
+		goto err;
+	}
+
+	listener->fd =3D client_sock;
+	list_add_tail(&listener->list, &globals->event_listeners);
+	return 0;
+
+err:
+	close(client_sock);
+	return -1;
+}
+
+static void unix_sock_event_notify_listener(struct event_listener *liste=
ner,
+					    uint8_t type,
+					    const uint8_t source[ETH_ALEN])
+{
+	struct alfred_event_notify_v0 notify;
+	int ret;
+
+	notify.header.type =3D ALFRED_EVENT_NOTIFY;
+	notify.header.version =3D ALFRED_VERSION;
+	notify.header.length =3D FIXED_TLV_LEN(notify);
+	notify.type =3D type;
+	memcpy(&notify.source, source, ETH_ALEN);
+
+	ret =3D write(listener->fd, &notify, sizeof(notify));
+	if (ret =3D=3D sizeof(notify))
+		return;
+
+	unix_sock_event_listener_free(listener);
+}
+
+void unix_sock_events_close_all(struct globals *globals)
+{
+	struct event_listener *listener, *tmp;
+
+	list_for_each_entry_safe(listener, tmp,
+				 &globals->event_listeners, list) {
+		unix_sock_event_listener_free(listener);
+	}
+}
+
+void unix_sock_event_notify(struct globals *globals, uint8_t type,
+			    const uint8_t source[ETH_ALEN])
+{
+	struct event_listener *listener, *tmp;
+
+	/* if event notify is unsuccessful, listener socket is closed */
+	list_for_each_entry_safe(listener, tmp,
+				 &globals->event_listeners, list) {
+		unix_sock_event_notify_listener(listener, type, source);
+	}
+}
--=20
2.32.0.rc0
