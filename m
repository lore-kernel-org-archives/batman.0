Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri,  7 Aug 2015 23:56:05 +0800
Message-Id: <1438962965-30034-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add neighbor table support
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 debug.c      | 6 ++++++
 debug.h      | 1 +
 man/batctl.8 | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/debug.c b/debug.c
index a050345..3fbe587 100644
--- a/debug.c
+++ b/debug.c
@@ -31,6 +31,12 @@
 
 const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 	{
+		.opt_long = "neighbors",
+		.opt_short = "n",
+		.debugfs_name = "neighbors",
+		.header_lines = 2,
+	},
+	{
 		.opt_long = "originators",
 		.opt_short = "o",
 		.debugfs_name = "originators",
diff --git a/debug.h b/debug.h
index 2bc0ff9..c9397e1 100644
--- a/debug.h
+++ b/debug.h
@@ -30,6 +30,7 @@
 #define DEBUG_LOG "log"
 
 enum batctl_debug_tables {
+	BATCTL_TABLE_NEIGHBORS,
 	BATCTL_TABLE_ORIGINATORS,
 	BATCTL_TABLE_GATEWAYS,
 	BATCTL_TABLE_TRANSLOCAL,
diff --git a/man/batctl.8 b/man/batctl.8
index bc190c0..3720256 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -204,6 +204,9 @@ The local and global translation tables also support the "\-u" and "\-m" option
 
 List of debug tables:
 .RS 10
+\- neighbors|n
+.RE
+.RS 10
 \- originators|o
 .RE
 .RS 10
-- 
2.5.0

