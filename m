Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 3/4] alfred: introduce 'change batman-adv interface' IPC call
Date: Sun,  2 Jan 2022 12:31:35 +0100
Message-Id: <20220102113136.470299-3-mareklindner@neomailbox.ch>
In-Reply-To: <20220102113136.470299-1-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau>
 <20220102113136.470299-1-mareklindner@neomailbox.ch>
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

The batman-adv interface used by alfred can be changed at
runtime by sending the CHANGE_BAT_IFACE command via unix
socket.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 alfred.h     |  4 +++-
 client.c     | 37 +++++++++++++++++++++++++++++++++++++
 main.c       | 10 +++++++++-
 man/alfred.8 |  3 +++
 packet.h     | 14 ++++++++++++++
 unix_sock.c  | 27 ++++++++++++++++++++++++++-
 6 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/alfred.h b/alfred.h
index 57d7daf..0fc6dc6 100644
--- a/alfred.h
+++ b/alfred.h
@@ -89,6 +89,7 @@ enum clientmode {
 	CLIENT_SET_DATA,
 	CLIENT_MODESWITCH,
 	CLIENT_CHANGE_INTERFACE,
+	CLIENT_CHANGE_BAT_IFACE,
 };
=20
 struct interface {
@@ -110,7 +111,7 @@ struct globals {
=20
 	char *change_interface;
 	struct server *best_server;	/* NULL if we are a server ourselves */
-	const char *mesh_iface;
+	char *mesh_iface;
 	enum opmode opmode;
 	enum clientmode clientmode;
 	int clientmode_arg;
@@ -150,6 +151,7 @@ int alfred_client_request_data(struct globals *global=
s);
 int alfred_client_set_data(struct globals *globals);
 int alfred_client_modeswitch(struct globals *globals);
 int alfred_client_change_interface(struct globals *globals);
+int alfred_client_change_bat_iface(struct globals *globals);
 /* recv.c */
 int recv_alfred_packet(struct globals *globals, struct interface *interf=
ace,
 		       int recv_sock);
diff --git a/client.c b/client.c
index dc643f3..e1107bf 100644
--- a/client.c
+++ b/client.c
@@ -296,3 +296,40 @@ int alfred_client_change_interface(struct globals *g=
lobals)
=20
 	return 0;
 }
+
+int alfred_client_change_bat_iface(struct globals *globals)
+{
+	unsigned char buf[MAX_PAYLOAD];
+	struct alfred_change_bat_iface_v0 *change_bat_iface;
+	int ret, len;
+	size_t interface_len;
+
+	if (unix_sock_open_client(globals))
+		return -1;
+
+	interface_len =3D strlen(globals->mesh_iface);
+	if (interface_len > sizeof(change_bat_iface->bat_iface)) {
+		fprintf(stderr, "%s: batman-adv interface name list too long, not chan=
ging\n",
+			__func__);
+		return 0;
+	}
+
+	change_bat_iface =3D (struct alfred_change_bat_iface_v0 *)buf;
+	len =3D sizeof(*change_bat_iface);
+
+	change_bat_iface->header.type =3D ALFRED_CHANGE_BAT_IFACE;
+	change_bat_iface->header.version =3D ALFRED_VERSION;
+	change_bat_iface->header.length =3D htons(len - sizeof(change_bat_iface=
->header));
+	strncpy(change_bat_iface->bat_iface, globals->mesh_iface,
+		sizeof(change_bat_iface->bat_iface));
+	change_bat_iface->bat_iface[sizeof(change_bat_iface->bat_iface) - 1] =3D=
 '\0';
+
+	ret =3D write(globals->unix_sock, buf, len);
+	if (ret !=3D len)
+		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
+			__func__, ret, len, strerror(errno));
+
+	unix_sock_close(globals);
+
+	return 0;
+}
diff --git a/main.c b/main.c
index ad317cf..2cb6d44 100644
--- a/main.c
+++ b/main.c
@@ -37,6 +37,7 @@ static void alfred_usage(void)
 	printf("  -M, --modeswitch primary            switch daemon to mode pri=
mary\n");
 	printf("                   secondary          switch daemon to mode sec=
ondary\n");
 	printf("  -I, --change-interface [interface]  change to the specified i=
nterface(s)\n");
+	printf("  -B, --change-bat-iface [interface]  change to the specified b=
atman-adv interface\n");
 	printf("\n");
 	printf("server mode options:\n");
 	printf("  -i, --interface                     specify the interface (or=
 comma separated list of interfaces) to listen on\n");
@@ -160,6 +161,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 		{"req-version",		required_argument,	NULL,	'V'},
 		{"modeswitch",		required_argument,	NULL,	'M'},
 		{"change-interface",	required_argument,	NULL,	'I'},
+		{"change-bat-iface",	required_argument,	NULL,	'B'},
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"update-command",	required_argument,	NULL,	'c'},
 		{"version",		no_argument,		NULL,	'v'},
@@ -194,7 +196,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
=20
 	time_random_seed();
=20
-	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:p:4:f", =
long_options,
+	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:B:u:dc:p:4:f"=
, long_options,
 				  &opt_ind)) !=3D -1) {
 		switch (opt) {
 		case 'r':
@@ -252,6 +254,10 @@ static struct globals *alfred_init(int argc, char *a=
rgv[])
 			globals->clientmode =3D CLIENT_CHANGE_INTERFACE;
 			globals->change_interface =3D strdup(optarg);
 			break;
+		case 'B':
+			globals->clientmode =3D CLIENT_CHANGE_BAT_IFACE;
+			globals->mesh_iface =3D strdup(optarg);
+			break;
 		case 'u':
 			globals->unix_path =3D optarg;
 			break;
@@ -313,6 +319,8 @@ int main(int argc, char *argv[])
 		return alfred_client_modeswitch(globals);
 	case CLIENT_CHANGE_INTERFACE:
 		return alfred_client_change_interface(globals);
+	case CLIENT_CHANGE_BAT_IFACE:
+		return alfred_client_change_bat_iface(globals);
 	}
=20
 	return 0;
diff --git a/man/alfred.8 b/man/alfred.8
index ff9b315..74814e0 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -91,6 +91,9 @@ to 0 ('\fB\-V\fP 0').
 .TP
 \fB\-I\fP, \fB\-\-change\-interface\fP \fIinterface\fP
 Change the alfred server to use the new \fBinterface\fP(s)
+.TP
+\fB\-B\fP, \fB\-\-change\-bat\-iface\fP \fIinterface\fP
+Change the alfred server to use the new \fBbatman-adv interface\fP
 .
 .SH SERVER OPTIONS
 .TP
diff --git a/packet.h b/packet.h
index 678f939..94c6a77 100644
--- a/packet.h
+++ b/packet.h
@@ -68,6 +68,7 @@ enum alfred_packet_type {
 	ALFRED_STATUS_ERROR =3D 4,
 	ALFRED_MODESWITCH =3D 5,
 	ALFRED_CHANGE_INTERFACE =3D 6,
+	ALFRED_CHANGE_BAT_IFACE =3D 7,
 };
=20
 /* packets */
@@ -147,6 +148,19 @@ struct alfred_change_interface_v0 {
 	char ifaces[IFNAMSIZ * 16];
 } __packed;
=20
+/**
+ * struct alfred_change_bat_iface_v0 - Request to change the
+ * batman-adv interface
+ * @header: TLV header describing the complete packet
+ * @bat_iface: interface to be changed to
+ *
+ * Sent to the daemon by client
+ */
+struct alfred_change_bat_iface_v0 {
+	struct alfred_tlv header;
+	char bat_iface[IFNAMSIZ];
+} __packed;
+
 /**
  * struct alfred_status_v0 - Status info of a transaction
  * @header: TLV header describing the complete packet
diff --git a/unix_sock.c b/unix_sock.c
index d9ad07b..bc39199 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -345,6 +345,27 @@ err:
 	return ret;
 }
=20
+static int
+unix_sock_change_bat_iface(struct globals *globals,
+			   struct alfred_change_bat_iface_v0 *change_bat_iface,
+			   int client_sock)
+{
+	int len, ret =3D -1;
+
+	len =3D ntohs(change_bat_iface->header.length);
+
+	if (len < (int)(sizeof(*change_bat_iface) - sizeof(change_bat_iface->he=
ader)))
+		goto err;
+
+	free(globals->mesh_iface);
+	globals->mesh_iface =3D strdup(change_bat_iface->bat_iface);
+
+	ret =3D 0;
+err:
+	close(client_sock);
+	return ret;
+}
+
 int unix_sock_read(struct globals *globals)
 {
 	int client_sock;
@@ -402,7 +423,11 @@ int unix_sock_read(struct globals *globals)
 					     (struct alfred_change_interface_v0 *)packet,
 					     client_sock);
 		break;
-
+	case ALFRED_CHANGE_BAT_IFACE:
+		ret =3D unix_sock_change_bat_iface(globals,
+						 (struct alfred_change_bat_iface_v0 *)packet,
+						 client_sock);
+		break;
 	default:
 		/* unknown packet type */
 		ret =3D -1;
--=20
2.32.0.rc0
