Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon,  9 Sep 2013 17:46:03 +0200
Message-Id: <1378741567-25152-3-git-send-email-sven@open-mesh.com>
In-Reply-To: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] alfred: Fix warning about assigning
	const to non-const
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h       | 8 ++++----
 batadv_query.c | 6 +++---
 batadv_query.h | 6 +++---
 debugfs.c      | 3 ++-
 debugfs.h      | 2 +-
 unix_sock.c    | 4 ++--
 vis/vis.h      | 2 +-
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/alfred.h b/alfred.h
index a244c64..e44919c 100644
--- a/alfred.h
+++ b/alfred.h
@@ -91,8 +91,8 @@ struct globals {
 	struct in6_addr address;
 	uint32_t scope_id;
 	struct server *best_server;	/* NULL if we are a server ourselves */
-	char *interface;
-	char *mesh_iface;
+	const char *interface;
+	const char *mesh_iface;
 	enum opmode opmode;
 	enum clientmode clientmode;
 	int clientmode_arg;
@@ -139,8 +139,8 @@ int send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
 		       void *buf, int length);
 /* unix_sock.c */
 int unix_sock_read(struct globals *globals);
-int unix_sock_open_daemon(struct globals *globals, char *path);
-int unix_sock_open_client(struct globals *globals, char *path);
+int unix_sock_open_daemon(struct globals *globals, const char *path);
+int unix_sock_open_client(struct globals *globals, const char *path);
 int unix_sock_close(struct globals *globals);
 int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head);
diff --git a/batadv_query.c b/batadv_query.c
index 83083a1..f1e3f24 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -88,7 +88,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 	return 0;
 }
 
-int batadv_interface_check(char *mesh_iface)
+int batadv_interface_check(const char *mesh_iface)
 {
 	char *debugfs_mnt;
 	char full_path[MAX_PATH+1];
@@ -125,7 +125,7 @@ int batadv_interface_check(char *mesh_iface)
 	return 0;
 }
 
-struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac)
+struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
 {
 	enum {
 		tg_start,
@@ -207,7 +207,7 @@ out:
 	return mac_result;
 }
 
-uint8_t get_tq(char *mesh_iface, struct ether_addr *mac)
+uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 {
 	enum {
 		orig_mac,
diff --git a/batadv_query.h b/batadv_query.h
index 7dca319..5ab6f3e 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -24,9 +24,9 @@
 #include <stdint.h>
 #include <netinet/in.h>
 
-struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
-uint8_t get_tq(char *mesh_iface, struct ether_addr *mac);
-int batadv_interface_check(char *mesh_iface);
+struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac);
+uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac);
+int batadv_interface_check(const char *mesh_iface);
 int mac_to_ipv6(const struct ether_addr *mac, struct in6_addr *addr);
 int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac);
 int is_ipv6_eui64(const struct in6_addr *addr);
diff --git a/debugfs.c b/debugfs.c
index e62978b..1e9418d 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -43,7 +43,8 @@ static const char *debugfs_known_mountpoints[] = {
 };
 
 /* construct a full path to a debugfs element */
-int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
+int debugfs_make_path(const char *fmt, const char *mesh_iface, char *buffer,
+		      int size)
 {
 	int len;
 
diff --git a/debugfs.h b/debugfs.h
index 6307a9b..b4dc6bb 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -32,7 +32,7 @@
 
 extern int debugfs_valid_entry(const char *path);
 extern char *debugfs_mount(const char *mountpoint);
-extern int debugfs_make_path(const char *fmt, char *mesh_iface,
+extern int debugfs_make_path(const char *fmt, const char *mesh_iface,
 			     char *buffer, int size);
 
 #endif /* __DEBUGFS_H__ */
diff --git a/unix_sock.c b/unix_sock.c
index 8bff2e1..6b80f38 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -35,7 +35,7 @@
 #include "hash.h"
 #include "packet.h"
 
-int unix_sock_open_daemon(struct globals *globals, char *path)
+int unix_sock_open_daemon(struct globals *globals, const char *path)
 {
 	struct sockaddr_un addr;
 
@@ -68,7 +68,7 @@ int unix_sock_open_daemon(struct globals *globals, char *path)
 	return 0;
 }
 
-int unix_sock_open_client(struct globals *globals, char *path)
+int unix_sock_open_client(struct globals *globals, const char *path)
 {
 	struct sockaddr_un addr;
 
diff --git a/vis/vis.h b/vis/vis.h
index d4a49d0..6ba70c6 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -89,7 +89,7 @@ struct vis_list_entry {
 	 		   + (vis_data)->entries_n * sizeof(struct vis_entry))
 
 struct globals {
-	char *interface;
+	const char *interface;
 	enum opmode opmode;
 	enum vis_format vis_format;
 	uint8_t buf[65536];
-- 
1.8.4.rc3

