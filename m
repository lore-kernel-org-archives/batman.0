Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:05 +0200
Message-Id: <1465152428-17299-7-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/10] alfred: Split get_tq from debugfs
	backend
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
These have to use netlink. Thus the get_tq should be less tightly linked to
the debugfs tables to implement optional netlink support.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index 9082576..a893995 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -272,7 +272,8 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	return mac_result;
 }
 
-uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
+static int get_tq_debugfs(const char *mesh_iface, struct ether_addr *mac,
+			  uint8_t *tq)
 {
 	enum {
 		orig_mac,
@@ -288,7 +289,7 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 	char *line = NULL;
 	char *input, *saveptr, *token;
 	int line_invalid;
-	uint8_t tq = 0;
+	bool found = false;
 
 	memcpy(&in_mac, mac, sizeof(in_mac));
 
@@ -297,7 +298,7 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 
 	f = fopen(full_path, "r");
 	if (!f)
-		goto out;
+		return -EOPNOTSUPP;
 
 	while (getline(&line, &len, f) != -1) {
 		line_invalid = 0;
@@ -338,7 +339,8 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 					line_invalid = 1;
 				} else {
 					token[strlen(token) - 1] = '\0';
-					tq = strtol(token, NULL, 10);
+					*tq = strtol(token, NULL, 10);
+					found = true;
 					goto out;
 				}
 				break;
@@ -353,5 +355,24 @@ out:
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
+uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
+{
+	struct ether_addr in_mac;
+	uint8_t tq = 0;
+
+	/* input mac has to be copied because it could be in the shared
+	 * ether_aton buffer
+	 */
+	memcpy(&in_mac, mac, sizeof(in_mac));
+
+	get_tq_debugfs(mesh_iface, &in_mac, &tq);
+
 	return tq;
 }
-- 
2.8.1

