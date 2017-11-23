Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:37 +0100
Message-Id: <20171123140444.17119-4-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 03/10] batctl: Handle allocation error for
 path_buff
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

Fixes: 5a1af99276b0 ("batctl: adapt batctl to new sysfs interface handling")
Fixes: 306fcb4480c9 ("batctl: support for multiple mesh clouds")
Fixes: af115c9acf44 ("batctl: support new gateway sysfs API")
Fixes: 2c2cb260ad2e ("batctl: list supported and configured routing algorithms")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 sys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sys.c b/sys.c
index 65b438c..c49b428 100644
--- a/sys.c
+++ b/sys.c
@@ -153,6 +153,11 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	}
 
 	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc != 1) {
@@ -255,6 +260,11 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 
 	/* prepare the classic path */
 	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	/* if the specified interface is a VLAN then change the path to point
@@ -329,6 +339,11 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 	}
 
 	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc == 1) {
-- 
2.11.0

