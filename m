Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:40 +0200
Message-Id: <20181025162245.19389-38-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 37/42] batctl: Move orig_interval setting
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

The sysfs settings are planned to get also be implemented in netlink. To
avoid cluttering up netlink.c again, it should be stored in a separate
file. This also allows to order the usage lines using the Makefile.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile        |  1 +
 orig_interval.c | 35 +++++++++++++++++++++++++++++++++++
 sys.c           |  9 ---------
 3 files changed, 36 insertions(+), 9 deletions(-)
 create mode 100644 orig_interval.c

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
diff --git a/orig_interval.c b/orig_interval.c
new file mode 100644
index 0000000..d308ea2
--- /dev/null
+++ b/orig_interval.c
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
+static struct settings_data batctl_settings_orig_interval = {
+	.sysfs_name = "orig_interval",
+	.params = NULL,
+};
+
+COMMAND_NAMED(SUBCOMMAND, orig_interval, "it", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_orig_interval,
+	      "[interval]        \tdisplay or modify orig_interval setting");
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
2.11.0

