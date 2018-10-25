Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:26 +0200
Message-Id: <20181025162245.19389-24-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 23/42] batctl: Move nc_nodes debug table
 to own file
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

The other commands are stored in separate files and nc_nodes might also
receive a netlink implementation. The latter would increase the complexity
significantly and thus justify that the command is also added via an extra
file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile   |  1 +
 debug.c    |  8 --------
 nc_nodes.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)
 create mode 100644 nc_nodes.c

diff --git a/Makefile b/Makefile
index a725986..ac4824b 100755
--- a/Makefile
+++ b/Makefile
@@ -49,6 +49,7 @@ OBJ += loglevel.o
 OBJ += log.o
 OBJ += main.o
 OBJ += mcast_flags.o
+OBJ += nc_nodes.o
 OBJ += netlink.o
 OBJ += ping.o
 OBJ += routing_algo.o
diff --git a/debug.c b/debug.c
index 4b480a3..531c6aa 100644
--- a/debug.c
+++ b/debug.c
@@ -241,11 +241,3 @@ static struct debug_table_data batctl_debug_table_transglobal = {
 
 COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
-
-static struct debug_table_data batctl_debug_table_nc_nodes = {
-	.debugfs_name = DEBUG_NC_NODES,
-	.header_lines = 0,
-};
-
-COMMAND_NAMED(DEBUGTABLE, nc_nodes, "nn", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_nc_nodes, "");
diff --git a/nc_nodes.c b/nc_nodes.c
new file mode 100644
index 0000000..9cf437d
--- /dev/null
+++ b/nc_nodes.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include "debug.h"
+#include "main.h"
+
+static struct debug_table_data batctl_debug_table_nc_nodes = {
+	.debugfs_name = DEBUG_NC_NODES,
+	.header_lines = 0,
+};
+
+COMMAND_NAMED(DEBUGTABLE, nc_nodes, "nn", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_nc_nodes, "");
-- 
2.11.0

