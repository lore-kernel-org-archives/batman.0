Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:12 +0100
Message-Id: <20170122122113.29588-8-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batctl: Allow to read sysfs settings as
	normal user
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

The sysfs files can be read by normal users. Only writing to these files is
restricted. Don't artificially restrict access to these files by the batctl
subcommands.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys.c b/sys.c
index a695c18..65b438c 100644
--- a/sys.c
+++ b/sys.c
@@ -253,8 +253,6 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl");
-
 	/* prepare the classic path */
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
@@ -272,6 +270,8 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		goto out;
 	}
 
+	check_root_or_die("batctl");
+
 	if (!batctl_settings[setting].params)
 		goto write_file;
 
-- 
2.11.0

