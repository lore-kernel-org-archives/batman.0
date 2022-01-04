Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] alfred: Simplify calculation of fixed size IPC TLV length
Date: Tue,  4 Jan 2022 10:11:03 +0100
Message-Id: <20220104091103.162365-2-sven@narfation.org>
In-Reply-To: <20220104091103.162365-1-sven@narfation.org>
References: <20220104091103.162365-1-sven@narfation.org>
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

Instead of copying the same code to calculate the length of fixed size
TLVs, just use a common macro.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h | 3 +++
 client.c | 9 ++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/alfred.h b/alfred.h
index 26eb157..0e4dd26 100644
--- a/alfred.h
+++ b/alfred.h
@@ -30,6 +30,9 @@
 #define ALFRED_SOCK_PATH_DEFAULT	"/var/run/alfred.sock"
 #define NO_FILTER			-1
 
+#define FIXED_TLV_LEN(__tlv_type) \
+	htons(sizeof(__tlv_type) - sizeof(__tlv_type.header))
+
 enum data_source {
 	SOURCE_LOCAL = 0,
 	SOURCE_FIRST_HAND = 1,
diff --git a/client.c b/client.c
index b5faf3b..d0d19fb 100644
--- a/client.c
+++ b/client.c
@@ -38,8 +38,7 @@ int alfred_client_request_data(struct globals *globals)
 
 	request.header.type = ALFRED_REQUEST;
 	request.header.version = ALFRED_VERSION;
-	request.header.length = sizeof(request) - sizeof(request.header);
-	request.header.length = htons(request.header.length);
+	request.header.length = FIXED_TLV_LEN(request);
 	request.requested_type = globals->clientmode_arg;
 	request.tx_id = get_random_id();
 
@@ -188,7 +187,7 @@ int alfred_client_modeswitch(struct globals *globals)
 
 	modeswitch.header.type = ALFRED_MODESWITCH;
 	modeswitch.header.version = ALFRED_VERSION;
-	modeswitch.header.length = htons(len - sizeof(modeswitch.header));
+	modeswitch.header.length = FIXED_TLV_LEN(modeswitch);
 
 	switch (globals->opmode) {
 	case OPMODE_SECONDARY:
@@ -264,7 +263,7 @@ int alfred_client_change_interface(struct globals *globals)
 
 	change_interface.header.type = ALFRED_CHANGE_INTERFACE;
 	change_interface.header.version = ALFRED_VERSION;
-	change_interface.header.length = htons(len - sizeof(change_interface.header));
+	change_interface.header.length = FIXED_TLV_LEN(change_interface);
 	strncpy(change_interface.ifaces, globals->change_interface,
 		sizeof(change_interface.ifaces));
 	change_interface.ifaces[sizeof(change_interface.ifaces) - 1] = '\0';
@@ -312,7 +311,7 @@ int alfred_client_change_bat_iface(struct globals *globals)
 
 	change_bat_iface.header.type = ALFRED_CHANGE_BAT_IFACE;
 	change_bat_iface.header.version = ALFRED_VERSION;
-	change_bat_iface.header.length = htons(len - sizeof(change_bat_iface.header));
+	change_bat_iface.header.length = FIXED_TLV_LEN(change_bat_iface);
 	strncpy(change_bat_iface.bat_iface, globals->mesh_iface,
 		sizeof(change_bat_iface.bat_iface));
 	change_bat_iface.bat_iface[sizeof(change_bat_iface.bat_iface) - 1] = '\0';
-- 
2.30.2

