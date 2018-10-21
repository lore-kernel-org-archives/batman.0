Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:16 +0200
Message-Id: <20181021225524.8155-31-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 30/38] batctl: Move bridge_loop_avoidance
 setting to own file
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
 Makefile                |  1 +
 bridge_loop_avoidance.c | 33 +++++++++++++++++++++++++++++++++
 sys.c                   |  9 ---------
 3 files changed, 34 insertions(+), 9 deletions(-)
 create mode 100644 bridge_loop_avoidance.c

diff --git a/Makefile b/Makefile
index c1b8484..6664aa0 100755
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,7 @@ ifeq ($(CONFIG_BATCTL_BISECT),y)
 OBJ += $(OBJ_BISECT)
 endif
 OBJ += bonding.o
+OBJ += bridge_loop_avoidance.o
 OBJ += claimtable.o
 OBJ += dat_cache.o
 OBJ += debugfs.o
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
new file mode 100644
index 0000000..bf57576
--- /dev/null
+++ b/bridge_loop_avoidance.c
@@ -0,0 +1,33 @@
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
+#include "main.h"
+#include "sys.h"
+
+static struct settings_data batctl_settings_bridge_loop_avoidance = {
+	.sysfs_name = SYS_BLA,
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, bridge_loop_avoidance, "bl", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bridge_loop_avoidance,
+	      "[0|1]             \tdisplay or modify bridge_loop_avoidance setting");
diff --git a/sys.c b/sys.c
index 8ad925e..e08738d 100644
--- a/sys.c
+++ b/sys.c
@@ -146,15 +146,6 @@ COMMAND_NAMED(SUBCOMMAND, orig_interval, "it", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_orig_interval,
 	      "[interval]        \tdisplay or modify orig_interval setting");
 
-static struct settings_data batctl_settings_bridge_loop_avoidance = {
-	.sysfs_name = SYS_BLA,
-	.params = sysfs_param_enable,
-};
-
-COMMAND_NAMED(SUBCOMMAND, bridge_loop_avoidance, "bl", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bridge_loop_avoidance,
-	      "[0|1]             \tdisplay or modify bridge_loop_avoidance setting");
-
 static struct settings_data batctl_settings_distributed_arp_table = {
 	.sysfs_name = SYS_DAT,
 	.params = sysfs_param_enable,
-- 
2.19.1

