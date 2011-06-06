Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  7 Jun 2011 00:10:13 +0200
Message-Id: <1307398213-8528-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: added ap_isolation support
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

This patch introduces the possibility of enabling/disabling the
ap_isolation feature in batman-adv

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c |    6 ++++++
 sys.c  |    7 +++++++
 sys.h  |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/main.c b/main.c
index eb67737..059c00f 100644
--- a/main.c
+++ b/main.c
@@ -58,6 +58,7 @@ void print_usage(void) {
 	printf(" \taggregation|ag  [0|1]             \tdisplay or modify the packet aggregation setting\n");
 	printf(" \tbonding|b       [0|1]             \tdisplay or modify the bonding mode setting\n");
 	printf(" \tfragmentation|f [0|1]             \tdisplay or modify the fragmentation mode setting\n");
+	printf(" \tap_isolation|ap [0|1]             \tdisplay or modify the ap isolation mode setting\n");
 	printf("\n");
 	printf(" \tping|p          <destination>     \tping another batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr   <destination>     \ttraceroute another batman adv host via layer 2\n");
@@ -188,6 +189,11 @@ int main(int argc, char **argv)
 		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
 					 SYS_FRAG, fragmentation_usage, sysfs_param_enable);
 
+	} else if ((strcmp(argv[1], "ap_isolation") == 0) || (strcmp(argv[1], "ap") == 0)) {
+
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_AP_ISOLA, ap_isolation_usage, sysfs_param_enable);
+
 	} else if ((strcmp(argv[1], "bisect") == 0)) {
 
 		ret = bisect(argc - 1, argv + 1);
diff --git a/sys.c b/sys.c
index dbf5383..4f2b2c5 100644
--- a/sys.c
+++ b/sys.c
@@ -270,6 +270,13 @@ void fragmentation_usage(void)
 	printf(" \t -h print this help\n");
 }
 
+void ap_isolation_usage(void)
+{
+	printf("Usage: batctl [options] ap_isolation [0|1]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void setting_usage(void),
 		       const char *sysfs_param[])
diff --git a/sys.h b/sys.h
index 2c47550..2df846c 100644
--- a/sys.h
+++ b/sys.h
@@ -34,6 +34,7 @@
 #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_FRAG "fragmentation"
+#define SYS_AP_ISOLA "ap_isolation"
 
 enum gw_modes {
 	GW_MODE_OFF,
@@ -47,6 +48,7 @@ extern const char *sysfs_param_server[];
 void aggregation_usage(void);
 void bonding_usage(void);
 void fragmentation_usage(void);
+void ap_isolation_usage(void);
 void gw_mode_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
-- 
1.7.3.4

