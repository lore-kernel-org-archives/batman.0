Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] alfred: Avoid large send buffer for fixed size IPC
 commands
Date: Tue,  4 Jan 2022 10:11:02 +0100
Message-Id: <20220104091103.162365-1-sven@narfation.org>
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

For data related IPC commands, a buffer of 65527 bytes is necessary to send
or receive a complete command. But for non-data related IPC commands
usually have a fixed size. It is therefore enough to allocate exactly the
minimum required amount of bytes on the stack for non-data related IPC
commands.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 client.c | 83 ++++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/client.c b/client.c
index e1107bf..b5faf3b 100644
--- a/client.c
+++ b/client.c
@@ -23,7 +23,7 @@
 int alfred_client_request_data(struct globals *globals)
 {
 	unsigned char buf[MAX_PAYLOAD], *pos;
-	struct alfred_request_v0 *request;
+	struct alfred_request_v0 request;
 	struct alfred_push_data_v0 *push;
 	struct alfred_status_v0 *status;
 	struct alfred_tlv *tlv;
@@ -34,17 +34,16 @@ int alfred_client_request_data(struct globals *globals)
 	if (unix_sock_open_client(globals))
 		return -1;
 
-	request = (struct alfred_request_v0 *)buf;
-	len = sizeof(*request);
+	len = sizeof(request);
 
-	request->header.type = ALFRED_REQUEST;
-	request->header.version = ALFRED_VERSION;
-	request->header.length = sizeof(*request) - sizeof(request->header);
-	request->header.length = htons(request->header.length);
-	request->requested_type = globals->clientmode_arg;
-	request->tx_id = get_random_id();
+	request.header.type = ALFRED_REQUEST;
+	request.header.version = ALFRED_VERSION;
+	request.header.length = sizeof(request) - sizeof(request.header);
+	request.header.length = htons(request.header.length);
+	request.requested_type = globals->clientmode_arg;
+	request.tx_id = get_random_id();
 
-	ret = write(globals->unix_sock, buf, len);
+	ret = write(globals->unix_sock, &request, len);
 	if (ret != len)
 		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
 			__func__, ret, len, strerror(errno));
@@ -179,26 +178,24 @@ int alfred_client_set_data(struct globals *globals)
 
 int alfred_client_modeswitch(struct globals *globals)
 {
-	unsigned char buf[MAX_PAYLOAD];
-	struct alfred_modeswitch_v0 *modeswitch;
+	struct alfred_modeswitch_v0 modeswitch;
 	int ret, len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
 
-	modeswitch = (struct alfred_modeswitch_v0 *)buf;
-	len = sizeof(*modeswitch);
+	len = sizeof(modeswitch);
 
-	modeswitch->header.type = ALFRED_MODESWITCH;
-	modeswitch->header.version = ALFRED_VERSION;
-	modeswitch->header.length = htons(len - sizeof(modeswitch->header));
+	modeswitch.header.type = ALFRED_MODESWITCH;
+	modeswitch.header.version = ALFRED_VERSION;
+	modeswitch.header.length = htons(len - sizeof(modeswitch.header));
 
 	switch (globals->opmode) {
 	case OPMODE_SECONDARY:
-		modeswitch->mode = ALFRED_MODESWITCH_SECONDARY;
+		modeswitch.mode = ALFRED_MODESWITCH_SECONDARY;
 		break;
 	case OPMODE_PRIMARY:
-		modeswitch->mode = ALFRED_MODESWITCH_PRIMARY;
+		modeswitch.mode = ALFRED_MODESWITCH_PRIMARY;
 		break;
 	default:
 		fprintf(stderr, "%s: unknown opmode %u in modeswitch\n",
@@ -206,7 +203,7 @@ int alfred_client_modeswitch(struct globals *globals)
 		return -1;
 	}
 
-	ret = write(globals->unix_sock, buf, len);
+	ret = write(globals->unix_sock, &modeswitch, len);
 	if (ret != len)
 		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
 			__func__, ret, len, strerror(errno));
@@ -248,8 +245,7 @@ static int check_interface(const char *iface)
 
 int alfred_client_change_interface(struct globals *globals)
 {
-	unsigned char buf[MAX_PAYLOAD];
-	struct alfred_change_interface_v0 *change_interface;
+	struct alfred_change_interface_v0 change_interface;
 	int ret, len;
 	char *input, *token, *saveptr;
 	size_t interface_len;
@@ -258,24 +254,23 @@ int alfred_client_change_interface(struct globals *globals)
 		return -1;
 
 	interface_len = strlen(globals->change_interface);
-	if (interface_len > sizeof(change_interface->ifaces)) {
+	if (interface_len > sizeof(change_interface.ifaces)) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
 		return 0;
 	}
 
-	change_interface = (struct alfred_change_interface_v0 *)buf;
-	len = sizeof(*change_interface);
+	len = sizeof(change_interface);
 
-	change_interface->header.type = ALFRED_CHANGE_INTERFACE;
-	change_interface->header.version = ALFRED_VERSION;
-	change_interface->header.length = htons(len - sizeof(change_interface->header));
-	strncpy(change_interface->ifaces, globals->change_interface,
-		sizeof(change_interface->ifaces));
-	change_interface->ifaces[sizeof(change_interface->ifaces) - 1] = '\0';
+	change_interface.header.type = ALFRED_CHANGE_INTERFACE;
+	change_interface.header.version = ALFRED_VERSION;
+	change_interface.header.length = htons(len - sizeof(change_interface.header));
+	strncpy(change_interface.ifaces, globals->change_interface,
+		sizeof(change_interface.ifaces));
+	change_interface.ifaces[sizeof(change_interface.ifaces) - 1] = '\0';
 
 	/* test it before sending
-	 * globals->change_interface is now saved in change_interface->ifaces
+	 * globals->change_interface is now saved in change_interface.ifaces
 	 * and can be modified by strtok_r
 	 */
 	input = globals->change_interface;
@@ -287,7 +282,7 @@ int alfred_client_change_interface(struct globals *globals)
 			return 0;
 	}
 
-	ret = write(globals->unix_sock, buf, len);
+	ret = write(globals->unix_sock, &change_interface, len);
 	if (ret != len)
 		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
 			__func__, ret, len, strerror(errno));
@@ -299,8 +294,7 @@ int alfred_client_change_interface(struct globals *globals)
 
 int alfred_client_change_bat_iface(struct globals *globals)
 {
-	unsigned char buf[MAX_PAYLOAD];
-	struct alfred_change_bat_iface_v0 *change_bat_iface;
+	struct alfred_change_bat_iface_v0 change_bat_iface;
 	int ret, len;
 	size_t interface_len;
 
@@ -308,23 +302,22 @@ int alfred_client_change_bat_iface(struct globals *globals)
 		return -1;
 
 	interface_len = strlen(globals->mesh_iface);
-	if (interface_len > sizeof(change_bat_iface->bat_iface)) {
+	if (interface_len > sizeof(change_bat_iface.bat_iface)) {
 		fprintf(stderr, "%s: batman-adv interface name list too long, not changing\n",
 			__func__);
 		return 0;
 	}
 
-	change_bat_iface = (struct alfred_change_bat_iface_v0 *)buf;
-	len = sizeof(*change_bat_iface);
+	len = sizeof(change_bat_iface);
 
-	change_bat_iface->header.type = ALFRED_CHANGE_BAT_IFACE;
-	change_bat_iface->header.version = ALFRED_VERSION;
-	change_bat_iface->header.length = htons(len - sizeof(change_bat_iface->header));
-	strncpy(change_bat_iface->bat_iface, globals->mesh_iface,
-		sizeof(change_bat_iface->bat_iface));
-	change_bat_iface->bat_iface[sizeof(change_bat_iface->bat_iface) - 1] = '\0';
+	change_bat_iface.header.type = ALFRED_CHANGE_BAT_IFACE;
+	change_bat_iface.header.version = ALFRED_VERSION;
+	change_bat_iface.header.length = htons(len - sizeof(change_bat_iface.header));
+	strncpy(change_bat_iface.bat_iface, globals->mesh_iface,
+		sizeof(change_bat_iface.bat_iface));
+	change_bat_iface.bat_iface[sizeof(change_bat_iface.bat_iface) - 1] = '\0';
 
-	ret = write(globals->unix_sock, buf, len);
+	ret = write(globals->unix_sock, &change_bat_iface, len);
 	if (ret != len)
 		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
 			__func__, ret, len, strerror(errno));
-- 
2.30.2

