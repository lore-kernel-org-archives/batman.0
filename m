Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:10 +0100
Message-Id: <20170122122113.29588-6-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batctl: Allow to read loglevel as normal
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

The loglevel sysfs file can be read by normal users. Only writing to this
file is restricted. Don't artificially restrict access to this file by
the batctl subcommand.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys.c b/sys.c
index 9dcb4f2..ac978bf 100644
--- a/sys.c
+++ b/sys.c
@@ -152,12 +152,12 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl loglevel");
-
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc != 1) {
+		check_root_or_die("batctl loglevel");
+
 		for (i = 1; i < argc; i++) {
 			if (strcmp(argv[i], "none") == 0) {
 				log_level = 0;
-- 
2.11.0

