Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Nov 2016 13:12:13 +0100
Message-Id: <20161101121213.15607-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Don't check for debugfs on startup
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

debugfs is deprecated and netlink is used by the modern batman-adv module.
Thus it can easily happen that debugfs was not enabled during the build of
batman-adv. Also netns may not have access to debugfs.

So drop the check for transtable_global and originators for the specified
mesh interface.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c | 30 ------------------------------
 batadv_query.h |  1 -
 server.c       |  4 ----
 3 files changed, 35 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index a671b79..8815745 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -136,36 +136,6 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 	return 0;
 }
 
-int batadv_interface_check(const char *mesh_iface)
-{
-	char full_path[MAX_PATH + 1];
-	FILE *f;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
-			  mesh_iface, full_path, sizeof(full_path));
-	f = fopen(full_path, "r");
-	if (!f) {
-		fprintf(stderr,
-			"Could not find %s for interface %s. Make sure it is a valid batman-adv soft-interface\n",
-			DEBUG_TRANSTABLE_GLOBAL, mesh_iface);
-		return -1;
-	}
-	fclose(f);
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_ORIGINATORS,
-			  mesh_iface, full_path, sizeof(full_path));
-	f = fopen(full_path, "r");
-	if (!f) {
-		fprintf(stderr,
-			"Could not find %s for interface %s. Make sure it is a valid batman-adv soft-interface\n",
-			DEBUG_ORIGINATORS, mesh_iface);
-		return -1;
-	}
-	fclose(f);
-
-	return 0;
-}
-
 static int translate_mac_debugfs(const char *mesh_iface,
 				 const struct ether_addr *mac,
 				 struct ether_addr *mac_out)
diff --git a/batadv_query.h b/batadv_query.h
index 320203b..907ed07 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -27,7 +27,6 @@
 struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac);
 uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac);
-int batadv_interface_check(const char *mesh_iface);
 int mac_to_ipv6(const struct ether_addr *mac, struct in6_addr *addr);
 int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac);
 int is_ipv6_eui64(const struct in6_addr *addr);
diff --git a/server.c b/server.c
index 3a0ad8d..445e076 100644
--- a/server.c
+++ b/server.c
@@ -352,10 +352,6 @@ int alfred_server(struct globals *globals)
 		return -1;
 	}
 
-	if (strcmp(globals->mesh_iface, "none") != 0 &&
-	    batadv_interface_check(globals->mesh_iface) < 0)
-		return -1;
-
 	num_socks = netsock_open_all(globals);
 	if (num_socks <= 0) {
 		fprintf(stderr, "Failed to open interfaces\n");
-- 
2.10.1

