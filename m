Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:22 +0200
Message-Id: <20181021225524.8155-37-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 36/38] batctl: Move orig_interval setting to
 own file
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

The sysfs settings are planned to get also be implemented in netlink. To
avoid cluttering up netlink.c again, it should be stored in a separate
file. This also allows to order the usage lines using the Makefile.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 1 +
 sys.c    | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 8582bf6..a6971d8 100755
--- a/Makefile
+++ b/Makefile
@@ -63,6 +63,7 @@ OBJ += netlink.o
 OBJ += network_coding.o
 OBJ += ping.o
 OBJ += originators.o
+OBJ += orig_interval.o
 OBJ += routing_algo.o
 OBJ += statistics.o
 OBJ += sys.o
diff --git a/sys.c b/sys.c
index 932a7e8..6b98ac4 100644
--- a/sys.c
+++ b/sys.c
@@ -136,12 +136,3 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 	free(base_dev);
 	return res;
 }
-
-static struct settings_data batctl_settings_orig_interval = {
-	.sysfs_name = "orig_interval",
-	.params = NULL,
-};
-
-COMMAND_NAMED(SUBCOMMAND, orig_interval, "it", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_orig_interval,
-	      "[interval]        \tdisplay or modify orig_interval setting");
-- 
2.19.1

