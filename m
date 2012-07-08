Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  8 Jul 2012 16:32:10 +0200
Message-Id: <1341757930-15040-2-git-send-email-sven@narfation.org>
In-Reply-To: <1341757930-15040-1-git-send-email-sven@narfation.org>
References: <1341757930-15040-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Use BIT(x) macro to calculate
	bit positions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h   |    1 +
 packet.h |   30 +++++++++++++++---------------
 sys.c    |    8 ++++----
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/main.h b/main.h
index 4c8b60b..34ac4f5 100644
--- a/main.h
+++ b/main.h
@@ -34,5 +34,6 @@
 #define SETTINGS_PATH_MAX_LEN 25
 
 #define __packed __attribute((packed))   /* linux kernel compat */
+#define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
 
 extern char module_ver_path[];
diff --git a/packet.h b/packet.h
index 65d66e4..eb45934 100644
--- a/packet.h
+++ b/packet.h
@@ -37,10 +37,10 @@ enum batadv_packettype {
 #define BATADV_COMPAT_VERSION 14
 
 enum batadv_iv_flags {
-	BATADV_NOT_BEST_NEXT_HOP   = 1 << 3,
-	BATADV_PRIMARIES_FIRST_HOP = 1 << 4,
-	BATADV_VIS_SERVER	   = 1 << 5,
-	BATADV_DIRECTLINK	   = 1 << 6,
+	BATADV_NOT_BEST_NEXT_HOP   = BIT(3),
+	BATADV_PRIMARIES_FIRST_HOP = BIT(4),
+	BATADV_VIS_SERVER	   = BIT(5),
+	BATADV_DIRECTLINK	   = BIT(6),
 };
 
 /* ICMP message types */
@@ -60,8 +60,8 @@ enum batadv_vis_packettype {
 
 /* fragmentation defines */
 enum batadv_unicast_frag_flags {
-	BATADV_UNI_FRAG_HEAD	  = 1 << 0,
-	BATADV_UNI_FRAG_LARGETAIL = 1 << 1,
+	BATADV_UNI_FRAG_HEAD	  = BIT(0),
+	BATADV_UNI_FRAG_LARGETAIL = BIT(1),
 };
 
 /* TT_QUERY subtypes */
@@ -74,20 +74,20 @@ enum batadv_tt_query_packettype {
 
 /* TT_QUERY flags */
 enum batadv_tt_query_flags {
-	BATADV_TT_FULL_TABLE = 1 << 2,
+	BATADV_TT_FULL_TABLE = BIT(2),
 };
 
 /* BATADV_TT_CLIENT flags.
- * Flags from 1 to 1 << 7 are sent on the wire, while flags from 1 << 8 to
- * 1 << 15 are used for local computation only
+ * Flags from BIT(0) to BIT(7) are sent on the wire, while flags from BIT(8) to
+ * BIT(15) are used for local computation only
  */
 enum batadv_tt_client_flags {
-	BATADV_TT_CLIENT_DEL     = 1 << 0,
-	BATADV_TT_CLIENT_ROAM    = 1 << 1,
-	BATADV_TT_CLIENT_WIFI    = 1 << 2,
-	BATADV_TT_CLIENT_NOPURGE = 1 << 8,
-	BATADV_TT_CLIENT_NEW     = 1 << 9,
-	BATADV_TT_CLIENT_PENDING = 1 << 10,
+	BATADV_TT_CLIENT_DEL     = BIT(0),
+	BATADV_TT_CLIENT_ROAM    = BIT(1),
+	BATADV_TT_CLIENT_WIFI    = BIT(2),
+	BATADV_TT_CLIENT_NOPURGE = BIT(8),
+	BATADV_TT_CLIENT_NEW     = BIT(9),
+	BATADV_TT_CLIENT_PENDING = BIT(10),
 };
 
 /* claim frame types for the bridge loop avoidance */
diff --git a/sys.c b/sys.c
index 9787875..e40ddcd 100644
--- a/sys.c
+++ b/sys.c
@@ -291,13 +291,13 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 15;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
-				log_level |= (1 << 0);
+				log_level |= BIT(0);
 			else if (strcmp(argv[i], "routes") == 0)
-				log_level |= (1 << 1);
+				log_level |= BIT(1);
 			else if (strcmp(argv[i], "tt") == 0)
-				log_level |= (1 << 2);
+				log_level |= BIT(2);
 			else if (strcmp(argv[i], "bla") == 0)
-				log_level |= (1 << 3);
+				log_level |= BIT(3);
 			else {
 				log_level_usage();
 				goto out;
-- 
1.7.10.4

