Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 1/3] alfred: move interface check into helper function
Date: Wed, 12 Jan 2022 22:05:04 +0100
Message-Id: <20220112210506.3488775-1-mareklindner@neomailbox.ch>
In-Reply-To: <10410848.OOsao9LFFs@rousseau>
References: <10410848.OOsao9LFFs@rousseau>
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

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 alfred.h |  1 +
 server.c |  4 ++--
 util.c   | 11 +++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/alfred.h b/alfred.h
index 0e4dd26..c595b06 100644
--- a/alfred.h
+++ b/alfred.h
@@ -204,5 +204,6 @@ int time_diff(struct timespec *tv1, struct timespec *=
tv2,
 void time_random_seed(void);
 uint16_t get_random_id(void);
 bool is_valid_ether_addr(uint8_t *addr);
+bool is_iface_disabled(char *iface);
 int ipv4_arp_request(struct interface *interface, const alfred_addr *add=
r,
 		     struct ether_addr *mac);
diff --git a/server.c b/server.c
index 85bf453..1efc211 100644
--- a/server.c
+++ b/server.c
@@ -205,7 +205,7 @@ static void update_server_info(struct globals *global=
s)
 	if (globals->opmode =3D=3D OPMODE_PRIMARY)
 		return;
=20
-	if (strcmp(globals->mesh_iface, "none") !=3D 0) {
+	if (!is_iface_disabled(globals->mesh_iface)) {
 		tg_hash =3D tg_hash_new(globals->mesh_iface);
 		if (!tg_hash) {
 			fprintf(stderr, "Failed to create translation hash\n");
@@ -385,7 +385,7 @@ int alfred_server(struct globals *globals)
 		return -1;
 	}
=20
-	if (strcmp(globals->mesh_iface, "none") !=3D 0 &&
+	if (!is_iface_disabled(globals->mesh_iface) &&
 	    batadv_interface_check(globals->mesh_iface) < 0 &&
 	    !globals->force) {
 		fprintf(stderr, "Can't start server: batman-adv interface %s not found=
\n",
diff --git a/util.c b/util.c
index 42a625a..eabef57 100644
--- a/util.c
+++ b/util.c
@@ -67,6 +67,17 @@ bool is_valid_ether_addr(uint8_t addr[ETH_ALEN])
 	return true;
 }
=20
+bool is_iface_disabled(char *iface)
+{
+	if (!iface)
+		return false;
+
+	if (strcmp(iface, "none") !=3D 0)
+		return false;
+
+	return true;
+}
+
 static void ipv4_request_mac_resolve(const alfred_addr *addr)
 {
 	const struct sockaddr *sockaddr;
--=20
2.32.0.rc0
