Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Sun,  2 Jan 2022 12:31:36 +0100
Message-Id: <20220102113136.470299-4-mareklindner@neomailbox.ch>
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

The 'server status' call exports the 'mode' as well as interface
status via IPC. Both parameters can be modified at runtime via the
IPC and as such, the current configuration is dynamic and not
necessarily obvious.

The server status 'request' and 'reply' packet types are added
to allow the IPC client to initiate the status retrieval. The
server will respond with the 'reply' message.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 alfred.h     |  2 ++
 client.c     | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 main.c       |  9 +++++-
 man/alfred.8 |  3 ++
 packet.h     | 26 ++++++++++++++++
 unix_sock.c  | 50 ++++++++++++++++++++++++++++++
 6 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index 0fc6dc6..8ee7b21 100644
--- a/alfred.h
+++ b/alfred.h
@@ -90,6 +90,7 @@ enum clientmode {
 	CLIENT_MODESWITCH,
 	CLIENT_CHANGE_INTERFACE,
 	CLIENT_CHANGE_BAT_IFACE,
+	CLIENT_SERVER_STATUS,
 };
=20
 struct interface {
@@ -152,6 +153,7 @@ int alfred_client_set_data(struct globals *globals);
 int alfred_client_modeswitch(struct globals *globals);
 int alfred_client_change_interface(struct globals *globals);
 int alfred_client_change_bat_iface(struct globals *globals);
+int alfred_client_server_status(struct globals *globals);
 /* recv.c */
 int recv_alfred_packet(struct globals *globals, struct interface *interf=
ace,
 		       int recv_sock);
diff --git a/client.c b/client.c
index e1107bf..d540a9f 100644
--- a/client.c
+++ b/client.c
@@ -333,3 +333,90 @@ int alfred_client_change_bat_iface(struct globals *g=
lobals)
=20
 	return 0;
 }
+
+int alfred_client_server_status(struct globals *globals)
+{
+	unsigned char buf[MAX_PAYLOAD];
+	struct alfred_server_status_req_v0 *status_req;
+	struct alfred_server_status_rep_v0 *status_rep;
+	struct alfred_tlv *packet;
+	int ret, len, headsize, i;
+
+	if (unix_sock_open_client(globals))
+		return -1;
+
+	status_req =3D (struct alfred_server_status_req_v0 *)buf;
+	len =3D sizeof(*status_req);
+
+	status_req->header.type =3D ALFRED_SERVER_STATUS;
+	status_req->header.version =3D ALFRED_VERSION;
+	status_req->header.length =3D 0;
+
+	ret =3D write(globals->unix_sock, buf, len);
+	if (ret !=3D len)
+		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
+			__func__, ret, len, strerror(errno));
+
+	len =3D read(globals->unix_sock, buf, sizeof(buf));
+	if (len <=3D 0) {
+		perror("read from unix socket failed");
+		goto err;
+	}
+
+	ret =3D -1;
+
+	/* drop too small packets */
+	headsize =3D sizeof(*packet);
+	if (len < headsize) {
+		perror("unexpected header size received from unix socket");
+		goto err;
+	}
+
+	packet =3D (struct alfred_tlv *)buf;
+
+	if ((len - headsize) < ((int)ntohs(packet->length))) {
+		perror("unexpected packet size received from unix socket");
+		goto err;
+	}
+
+	if (packet->version !=3D ALFRED_VERSION) {
+		perror("alfred version mismatch");
+		goto err;
+	}
+
+	status_rep =3D (struct alfred_server_status_rep_v0 *)buf;
+	headsize =3D ntohs(status_rep->header.length);
+
+	if (headsize < (int)(sizeof(*status_rep) - sizeof(status_rep->header)))
+		goto err;
+
+	fprintf(stdout, "alfred status:\n");
+
+	switch (status_rep->mode) {
+	case ALFRED_MODESWITCH_SECONDARY:
+		fprintf(stdout, "- mode: secondary\n");
+		break;
+	case ALFRED_MODESWITCH_PRIMARY:
+		fprintf(stdout, "- mode: primary\n");
+		break;
+	default:
+		fprintf(stderr, "- mode: unknown\n");
+		break;
+	}
+
+	fprintf(stderr, "- interfaces:\n");
+
+	for (i =3D 0; i < 16; i++) {
+		if (strlen(status_rep->ifaces[i].name) =3D=3D 0)
+			continue;
+
+		fprintf(stderr, "\t- name: %s\n",
+			status_rep->ifaces[i].name);
+	}
+
+	fprintf(stdout, "- batman-adv interface: %s\n", status_rep->bat_iface);
+
+err:
+	unix_sock_close(globals);
+	return 0;
+}
diff --git a/main.c b/main.c
index 2cb6d44..e2ac576 100644
--- a/main.c
+++ b/main.c
@@ -38,6 +38,7 @@ static void alfred_usage(void)
 	printf("                   secondary          switch daemon to mode sec=
ondary\n");
 	printf("  -I, --change-interface [interface]  change to the specified i=
nterface(s)\n");
 	printf("  -B, --change-bat-iface [interface]  change to the specified b=
atman-adv interface\n");
+	printf("  -S, --server-status                 request server status inf=
o such as mode & interfaces\n");
 	printf("\n");
 	printf("server mode options:\n");
 	printf("  -i, --interface                     specify the interface (or=
 comma separated list of interfaces) to listen on\n");
@@ -162,6 +163,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 		{"modeswitch",		required_argument,	NULL,	'M'},
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"change-bat-iface",	required_argument,	NULL,	'B'},
+		{"server-status",	required_argument,	NULL,	'S'},
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"update-command",	required_argument,	NULL,	'c'},
 		{"version",		no_argument,		NULL,	'v'},
@@ -196,7 +198,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
=20
 	time_random_seed();
=20
-	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:B:u:dc:p:4:f"=
, long_options,
+	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:B:Su:dc:p:4:f=
", long_options,
 				  &opt_ind)) !=3D -1) {
 		switch (opt) {
 		case 'r':
@@ -258,6 +260,9 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 			globals->clientmode =3D CLIENT_CHANGE_BAT_IFACE;
 			globals->mesh_iface =3D strdup(optarg);
 			break;
+		case 'S':
+			globals->clientmode =3D CLIENT_SERVER_STATUS;
+			break;
 		case 'u':
 			globals->unix_path =3D optarg;
 			break;
@@ -321,6 +326,8 @@ int main(int argc, char *argv[])
 		return alfred_client_change_interface(globals);
 	case CLIENT_CHANGE_BAT_IFACE:
 		return alfred_client_change_bat_iface(globals);
+	case CLIENT_SERVER_STATUS:
+		return alfred_client_server_status(globals);
 	}
=20
 	return 0;
diff --git a/man/alfred.8 b/man/alfred.8
index 74814e0..cf0eafc 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -94,6 +94,9 @@ Change the alfred server to use the new \fBinterface\fP=
(s)
 .TP
 \fB\-B\fP, \fB\-\-change\-bat\-iface\fP \fIinterface\fP
 Change the alfred server to use the new \fBbatman-adv interface\fP
+.TP
+\fB\-S\fP, \fB\-\-server\-status\fP
+Request server status information such as mode & interfaces\fP
 .
 .SH SERVER OPTIONS
 .TP
diff --git a/packet.h b/packet.h
index 94c6a77..b9e1f2e 100644
--- a/packet.h
+++ b/packet.h
@@ -69,6 +69,7 @@ enum alfred_packet_type {
 	ALFRED_MODESWITCH =3D 5,
 	ALFRED_CHANGE_INTERFACE =3D 6,
 	ALFRED_CHANGE_BAT_IFACE =3D 7,
+	ALFRED_SERVER_STATUS =3D 8,
 };
=20
 /* packets */
@@ -159,6 +160,31 @@ struct alfred_change_interface_v0 {
 struct alfred_change_bat_iface_v0 {
 	struct alfred_tlv header;
 	char bat_iface[IFNAMSIZ];
+};
+
+/**
+ * struct alfred_server_status_req_v0 - server status request
+ * @header: TLV header describing the complete packet
+ *
+ * Sent to the daemon by client
+ */
+struct alfred_server_status_req_v0 {
+	struct alfred_tlv header;
+} __packed;
+
+/**
+ * struct alfred_server_status_req_v0 - server status reply
+ * @header: TLV header describing the complete packet
+ *
+ * Sent by the daemon to client in response to status request
+ */
+struct alfred_server_status_rep_v0 {
+	struct alfred_tlv header;
+	uint8_t mode;
+	struct {
+		char name[IFNAMSIZ];
+	} ifaces[16];
+	char bat_iface[IFNAMSIZ];
 } __packed;
=20
 /**
diff --git a/unix_sock.c b/unix_sock.c
index bc39199..22a6805 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -366,6 +366,53 @@ err:
 	return ret;
 }
=20
+static int unix_sock_server_status(struct globals *globals, int client_s=
ock)
+{
+	unsigned char buf[MAX_PAYLOAD];
+	struct alfred_server_status_rep_v0 *status_rep;
+	struct interface *interface;
+	int ret, len, iface_count;
+
+	status_rep =3D (struct alfred_server_status_rep_v0 *)buf;
+	len =3D sizeof(*status_rep);
+
+	status_rep->header.type =3D ALFRED_SERVER_STATUS;
+	status_rep->header.version =3D ALFRED_VERSION;
+	status_rep->header.length =3D htons(len - sizeof(status_rep->header));
+
+	switch (globals->opmode) {
+	case OPMODE_SECONDARY:
+		status_rep->mode =3D ALFRED_MODESWITCH_SECONDARY;
+		break;
+	case OPMODE_PRIMARY:
+		status_rep->mode =3D ALFRED_MODESWITCH_PRIMARY;
+		break;
+	default:
+		break;
+	}
+
+	iface_count =3D 0;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		strncpy(status_rep->ifaces[iface_count].name,
+			interface->interface,
+			sizeof(status_rep->ifaces[iface_count].name));
+
+		iface_count++;
+	}
+
+	strncpy(status_rep->bat_iface, globals->mesh_iface,
+		sizeof(status_rep->bat_iface));
+
+	ret =3D write(client_sock, buf, len);
+	if (ret =3D=3D len)
+		return 0;
+
+	fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
+		__func__, ret, len, strerror(errno));
+	return -1;
+}
+
 int unix_sock_read(struct globals *globals)
 {
 	int client_sock;
@@ -428,6 +475,9 @@ int unix_sock_read(struct globals *globals)
 						 (struct alfred_change_bat_iface_v0 *)packet,
 						 client_sock);
 		break;
+	case ALFRED_SERVER_STATUS:
+		ret =3D unix_sock_server_status(globals, client_sock);
+		break;
 	default:
 		/* unknown packet type */
 		ret =3D -1;
--=20
2.32.0.rc0
