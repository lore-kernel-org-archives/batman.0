Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 12:12:05 +0200
Message-Id: <1468836728-21890-8-git-send-email-sven@narfation.org>
In-Reply-To: <6098496.c9QsHxvAun@sven-edge>
References: <6098496.c9QsHxvAun@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v11 08/11] batctl: Split translate_mac from
	debugfs backend
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

The debugfs tables cannot be used by the batctl in network namespaces.
These have to use netlink. Thus the translate_mac should be less tightly
linked to the debugfs tables to implement optional netlink support.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 46 +++++++++++++++++++++++++++++++++++-----------
 functions.h |  3 ++-
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/functions.c b/functions.c
index 5b76062..f994ced 100644
--- a/functions.c
+++ b/functions.c
@@ -26,6 +26,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -371,7 +372,9 @@ out:
 	return res;
 }
 
-struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac)
+static int translate_mac_debugfs(const char *mesh_iface,
+				 const struct ether_addr *mac,
+				 struct ether_addr *mac_out)
 {
 	enum {
 		tg_start,
@@ -381,26 +384,23 @@ struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac)
 	} pos;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
-	static struct ether_addr in_mac;
-	struct ether_addr *mac_result, *mac_tmp;
+	struct ether_addr *mac_tmp;
 	FILE *f = NULL;
 	size_t len = 0;
 	char *line = NULL;
 	char *input, *saveptr, *token;
 	int line_invalid;
-
-	memcpy(&in_mac, mac, sizeof(in_mac));
-	mac_result = &in_mac;
+	bool found = false;
 
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt)
-		goto out;
+		return -EOPNOTSUPP;
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL, mesh_iface, full_path, sizeof(full_path));
 
 	f = fopen(full_path, "r");
 	if (!f)
-		goto out;
+		return -EOPNOTSUPP;
 
 	while (getline(&line, &len, f) != -1) {
 		line_invalid = 0;
@@ -419,8 +419,8 @@ struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac)
 				break;
 			case tg_mac:
 				mac_tmp = ether_aton(token);
-				if (!mac_tmp || memcmp(mac_tmp, &in_mac,
-						       sizeof(in_mac)) != 0)
+				if (!mac_tmp || memcmp(mac_tmp, mac,
+						       ETH_ALEN) != 0)
 					line_invalid = 1;
 				else
 					pos = tg_via;
@@ -434,7 +434,8 @@ struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac)
 				if (!mac_tmp) {
 					line_invalid = 1;
 				} else {
-					mac_result = mac_tmp;
+					memcpy(mac_out, mac_tmp, ETH_ALEN);
+					found = true;
 					goto out;
 				}
 				break;
@@ -449,6 +450,29 @@ out:
 	if (f)
 		fclose(f);
 	free(line);
+
+	if (found)
+		return 0;
+	else
+		return -ENOENT;
+}
+
+struct ether_addr *translate_mac(const char *mesh_iface,
+				 const struct ether_addr *mac)
+{
+	struct ether_addr in_mac;
+	static struct ether_addr out_mac;
+	struct ether_addr *mac_result;
+
+	/* input mac has to be copied because it could be in the shared
+	 * ether_aton buffer
+	 */
+	memcpy(&in_mac, mac, sizeof(in_mac));
+	memcpy(&out_mac, mac, sizeof(out_mac));
+	mac_result = &out_mac;
+
+	translate_mac_debugfs(mesh_iface, &in_mac, mac_result);
+
 	return mac_result;
 }
 
diff --git a/functions.h b/functions.h
index 2d29d52..1f311ca 100644
--- a/functions.h
+++ b/functions.h
@@ -40,7 +40,8 @@ int read_file(const char *dir, const char *path, int read_opt,
 	      float orig_timeout, float watch_interval, size_t header_lines);
 int write_file(const char *dir, const char *fname, const char *arg1,
 	       const char *arg2);
-struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
+struct ether_addr *translate_mac(const char *mesh_iface,
+				 const struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
 int vlan_get_link(const char *ifname, char **parent);
 
-- 
2.8.1

