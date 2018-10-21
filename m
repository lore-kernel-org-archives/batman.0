Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:19 +0200
Message-Id: <20181021225524.8155-34-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 33/38] batctl: Move isolation_mark setting to
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
 Makefile         |  1 +
 isolation_mark.c | 35 +++++++++++++++++++++++++++++++++++
 sys.c            |  9 ---------
 3 files changed, 36 insertions(+), 9 deletions(-)
 create mode 100644 isolation_mark.c

diff --git a/Makefile b/Makefile
index 7f82d44..9598065 100755
--- a/Makefile
+++ b/Makefile
@@ -51,6 +51,7 @@ OBJ += gw_mode.o
 OBJ += hash.o
 OBJ += icmp_helper.o
 OBJ += interface.o
+OBJ += isolation_mark.o
 OBJ += loglevel.o
 OBJ += log.o
 OBJ += main.o
diff --git a/isolation_mark.c b/isolation_mark.c
new file mode 100644
index 0000000..300bb02
--- /dev/null
+++ b/isolation_mark.c
@@ -0,0 +1,35 @@
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
+#include <stddef.h>
+
+#include "main.h"
+#include "sys.h"
+
+static struct settings_data batctl_settings_isolation_mark = {
+	.sysfs_name = "isolation_mark",
+	.params = NULL,
+};
+
+COMMAND_NAMED(SUBCOMMAND, isolation_mark, "mark", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_isolation_mark,
+	      "[mark]            \tdisplay or modify isolation_mark setting");
diff --git a/sys.c b/sys.c
index f81298b..355b801 100644
--- a/sys.c
+++ b/sys.c
@@ -155,15 +155,6 @@ COMMAND_NAMED(SUBCOMMAND, network_coding, "nc", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_network_coding,
 	      "[0|1]             \tdisplay or modify network_coding setting");
 
-static struct settings_data batctl_settings_isolation_mark = {
-	.sysfs_name = "isolation_mark",
-	.params = NULL,
-};
-
-COMMAND_NAMED(SUBCOMMAND, isolation_mark, "mark", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_isolation_mark,
-	      "[mark]            \tdisplay or modify isolation_mark setting");
-
 static struct settings_data batctl_settings_multicast_mode = {
 	.sysfs_name = SYS_MULTICAST_MODE,
 	.params = sysfs_param_enable,
-- 
2.19.1

