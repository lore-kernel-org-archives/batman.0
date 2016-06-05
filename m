Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:03 +0200
Message-Id: <1465152428-17299-5-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/10] alfred: Split translate_mac from
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

The debugfs tables cannot be used by the alfred in network namespaces.
These have to use netlink. Thus the translate_mac should be less tightly
linked to the debugfs tables to implement optional netlink support.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c | 45 ++++++++++++++++++++++++++++++++++-----------
 batadv_query.h |  2 +-
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index d917242..b0679fc 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -125,7 +125,9 @@ int batadv_interface_check(const char *mesh_iface)
 	return 0;
 }
 
-struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
+static int translate_mac_debugfs(const char *mesh_iface,
+				 const struct ether_addr *mac,
+				 struct ether_addr *mac_out)
 {
 	enum {
 		tg_start,
@@ -133,24 +135,21 @@ struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
 		tg_via,
 		tg_originator,
 	} pos;
-	char full_path[MAX_PATH + 1];
-	static struct ether_addr in_mac;
-	struct ether_addr *mac_result, *mac_tmp;
+	char full_path[MAX_PATH+1];
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
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
 			  mesh_iface, full_path, sizeof(full_path));
 
 	f = fopen(full_path, "r");
 	if (!f)
-		goto out;
+		return -EOPNOTSUPP;
 
 	while (getline(&line, &len, f) != -1) {
 		line_invalid = 0;
@@ -169,8 +168,8 @@ struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
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
@@ -184,7 +183,8 @@ struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
 				if (!mac_tmp) {
 					line_invalid = 1;
 				} else {
-					mac_result = mac_tmp;
+					memcpy(mac_out, mac_tmp, ETH_ALEN);
+					found = true;
 					goto out;
 				}
 				break;
@@ -199,6 +199,29 @@ out:
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
 
diff --git a/batadv_query.h b/batadv_query.h
index d9660bc..320203b 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -25,7 +25,7 @@
 #include <netinet/in.h>
 
 struct ether_addr *translate_mac(const char *mesh_iface,
-				 struct ether_addr *mac);
+				 const struct ether_addr *mac);
 uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac);
 int batadv_interface_check(const char *mesh_iface);
 int mac_to_ipv6(const struct ether_addr *mac, struct in6_addr *addr);
-- 
2.8.1

