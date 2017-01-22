Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:11 +0100
Message-Id: <20170122122113.29588-7-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 7/9] batctl: Allow to read gw_mode as normal
	user
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

The gw_mode sysfs file can be read by normal users. Only writing to this
file is restricted. Don't artificially restrict access to this file by the
batctl subcommand.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys.c b/sys.c
index ac978bf..a695c18 100644
--- a/sys.c
+++ b/sys.c
@@ -328,8 +328,6 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl gw_mode");
-
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
@@ -386,6 +384,8 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 		goto out;
 	}
 
+	check_root_or_die("batctl gw_mode");
+
 	if (strcmp(argv[1], "client") == 0)
 		gw_mode = GW_MODE_CLIENT;
 	else if (strcmp(argv[1], "server") == 0)
-- 
2.11.0

