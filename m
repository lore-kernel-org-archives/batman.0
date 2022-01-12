Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 2/3] alfred: Allow operating without any interface specified
Date: Wed, 12 Jan 2022 22:05:05 +0100
Message-Id: <20220112210506.3488775-2-mareklindner@neomailbox.ch>
In-Reply-To: <20220112210506.3488775-1-mareklindner@neomailbox.ch>
References: <10410848.OOsao9LFFs@rousseau>
 <20220112210506.3488775-1-mareklindner@neomailbox.ch>
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

The '-i' commandline parameter to specify interface names
no longer is mandatory. Specifying interface 'none' or
sending a 'none' interface string within the
ALFRED_CHANGE_INTERFACE unix socket command disables
all interfaces operations at runtime.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 README.rst   |  6 +++++-
 alfred.h     |  2 +-
 client.c     |  8 ++++----
 main.c       |  6 +++---
 man/alfred.8 |  6 +++++-
 netsock.c    |  4 ++++
 server.c     | 39 ++++++++++++++++++++++++---------------
 7 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/README.rst b/README.rst
index 33200e4..7f44db6 100644
--- a/README.rst
+++ b/README.rst
@@ -82,7 +82,8 @@ documentation how to configure alfred in this case. In =
any event, you can
 still run alfred from the command line. The relevant options are (for a =
full
 list of options, run alfred -h):
=20
-  -i, --interface             specify the interface to listen on
+  -i, --interface             specify the interface to listen on. use 'n=
one'
+                              to disable interface operations
   -b                          specify the batman-adv interface configure=
d on
                               the system (default: bat0). use 'none' to =
disable
                               the batman-adv based best server selection
@@ -90,6 +91,9 @@ list of options, run alfred -h):
                               accepts data from secondaries and syncs it=
 with
                               other primaries
=20
+The interface option '-i' is optional. If interface 'none' is specified,=
 the
+alfred daemon will not communicate with other alfred instances on the
+network unless the interface list is modified at runtime via the unix so=
cket.
 The -b option is optional, and only needed if you run alfred on a batman=
-adv
 interface not called bat0, or if you don't use batman-adv at all
 (use '-b none'). In this case, alfred will still work but will not be ab=
le to
diff --git a/alfred.h b/alfred.h
index c595b06..9ab92a2 100644
--- a/alfred.h
+++ b/alfred.h
@@ -112,7 +112,7 @@ struct interface {
 struct globals {
 	struct list_head interfaces;
=20
-	char *change_interface;
+	char *net_iface;
 	struct server *best_server;	/* NULL if we are a server ourselves */
 	char *mesh_iface;
 	enum opmode opmode;
diff --git a/client.c b/client.c
index d0d19fb..b5d8943 100644
--- a/client.c
+++ b/client.c
@@ -252,7 +252,7 @@ int alfred_client_change_interface(struct globals *gl=
obals)
 	if (unix_sock_open_client(globals))
 		return -1;
=20
-	interface_len =3D strlen(globals->change_interface);
+	interface_len =3D strlen(globals->net_iface);
 	if (interface_len > sizeof(change_interface.ifaces)) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
@@ -264,15 +264,15 @@ int alfred_client_change_interface(struct globals *=
globals)
 	change_interface.header.type =3D ALFRED_CHANGE_INTERFACE;
 	change_interface.header.version =3D ALFRED_VERSION;
 	change_interface.header.length =3D FIXED_TLV_LEN(change_interface);
-	strncpy(change_interface.ifaces, globals->change_interface,
+	strncpy(change_interface.ifaces, globals->net_iface,
 		sizeof(change_interface.ifaces));
 	change_interface.ifaces[sizeof(change_interface.ifaces) - 1] =3D '\0';
=20
 	/* test it before sending
-	 * globals->change_interface is now saved in change_interface.ifaces
+	 * globals->net_iface is now saved in change_interface.ifaces
 	 * and can be modified by strtok_r
 	 */
-	input =3D globals->change_interface;
+	input =3D globals->net_iface;
 	while ((token =3D strtok_r(input, ",", &saveptr))) {
 		input =3D NULL;
=20
diff --git a/main.c b/main.c
index 2cb6d44..d40a0cc 100644
--- a/main.c
+++ b/main.c
@@ -179,7 +179,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 	memset(globals, 0, sizeof(*globals));
=20
 	INIT_LIST_HEAD(&globals->interfaces);
-	globals->change_interface =3D NULL;
+	globals->net_iface =3D NULL;
 	globals->opmode =3D OPMODE_SECONDARY;
 	globals->clientmode =3D CLIENT_NONE;
 	globals->best_server =3D NULL;
@@ -224,7 +224,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 			globals->opmode =3D OPMODE_PRIMARY;
 			break;
 		case 'i':
-			netsock_set_interfaces(globals, optarg);
+			globals->net_iface =3D strdup(optarg);
 			break;
 		case 'b':
 			globals->mesh_iface =3D strdup(optarg);
@@ -252,7 +252,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
 			break;
 		case 'I':
 			globals->clientmode =3D CLIENT_CHANGE_INTERFACE;
-			globals->change_interface =3D strdup(optarg);
+			globals->net_iface =3D strdup(optarg);
 			break;
 		case 'B':
 			globals->clientmode =3D CLIENT_CHANGE_BAT_IFACE;
diff --git a/man/alfred.8 b/man/alfred.8
index 4e002f0..74814e0 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -98,12 +98,16 @@ Change the alfred server to use the new \fBbatman-adv=
 interface\fP
 .SH SERVER OPTIONS
 .TP
 \fB\-i\fP, \fB\-\-interface\fP \fIiface\fP
-Specify the interface (or comma separated list of interfaces) to listen =
on
+Specify the interface (or comma separated list of interfaces) to listen =
on.
+Use 'none' to disable interface operations.
 .TP
 \fB\-b\fP \fIbatmanif\fP
 Specify the batman-adv interface configured on the system (default: bat0=
).
 Use 'none' to disable the batman-adv based best server selection.
=20
+The interface option \fB\-i\fP is optional. If interface 'none' is speci=
fied, the
+alfred daemon will not communicate with other alfred instances on the
+network unless the interface list is modified at runtime via the unix so=
cket.
 The \fB\-b\fP option is optional, and only needed if you run alfred on a
 batman-adv interface not called bat0, or if you don't use batman-adv at =
all
 (use '\fB\-b\fP none'). In this case, alfred will still work but will no=
t be
diff --git a/netsock.c b/netsock.c
index 84b0ec3..128e768 100644
--- a/netsock.c
+++ b/netsock.c
@@ -116,6 +116,10 @@ int netsock_set_interfaces(struct globals *globals, =
char *interfaces)
=20
 	netsock_close_all(globals);
=20
+	/* interface 'none' disables all interface operations */
+	if (is_iface_disabled(interfaces))
+		return 0;
+
 	input =3D interfaces;
 	while ((token =3D strtok_r(input, ",", &saveptr))) {
 		input =3D NULL;
diff --git a/server.c b/server.c
index 1efc211..bfc37bc 100644
--- a/server.c
+++ b/server.c
@@ -380,9 +380,30 @@ int alfred_server(struct globals *globals)
 	if (unix_sock_open_daemon(globals))
 		return -1;
=20
-	if (list_empty(&globals->interfaces)) {
-		fprintf(stderr, "Can't start server: interface missing\n");
-		return -1;
+	if (!is_iface_disabled(globals->net_iface)) {
+		if (!globals->net_iface) {
+			fprintf(stderr, "Can't start server: interface missing\n");
+			return -1;
+		}
+
+		netsock_set_interfaces(globals, globals->net_iface);
+
+		if (list_empty(&globals->interfaces) && !globals->force) {
+			fprintf(stderr, "Can't start server: valid interface missing\n");
+			return -1;
+		}
+
+		num_socks =3D netsock_open_all(globals);
+		if (num_socks <=3D 0 && !globals->force) {
+			fprintf(stderr, "Failed to open interfaces\n");
+			return -1;
+		}
+
+		num_interfaces =3D netsocket_count_interfaces(globals);
+		if (num_interfaces > 1 && globals->opmode =3D=3D OPMODE_SECONDARY) {
+			fprintf(stderr, "More than one interface specified in secondary mode\=
n");
+			return -1;
+		}
 	}
=20
 	if (!is_iface_disabled(globals->mesh_iface) &&
@@ -393,18 +414,6 @@ int alfred_server(struct globals *globals)
 		return -1;
 	}
=20
-	num_socks =3D netsock_open_all(globals);
-	if (num_socks <=3D 0 && !globals->force) {
-		fprintf(stderr, "Failed to open interfaces\n");
-		return -1;
-	}
-
-	num_interfaces =3D netsocket_count_interfaces(globals);
-	if (num_interfaces > 1 && globals->opmode =3D=3D OPMODE_SECONDARY) {
-		fprintf(stderr, "More than one interface specified in secondary mode\n=
");
-		return -1;
-	}
-
 	clock_gettime(CLOCK_MONOTONIC, &last_check);
 	globals->if_check =3D last_check;
=20
--=20
2.32.0.rc0
