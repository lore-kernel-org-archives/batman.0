Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Mon,  9 May 2016 18:41:52 +0200
Message-Id: <1462812114-16577-2-git-send-email-sven@open-mesh.com>
In-Reply-To: <6307812.WAqRcEYAvX@bentobox>
References: <6307812.WAqRcEYAvX@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v7 2/4] batctl: Add basic infrastructure to
	integrate netlink
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

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Netlink can be used to add new communication functionality to the kernel
module. It can also be used to replace the old debugfs files. The binary
interface used for this will be defined in the added files.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Forwarded: https://patchwork.open-mesh.org/patch/16079/
---
 Makefile     | 12 ++++++++++++
 batman_adv.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c    | 28 ++++++++++++++++++++++++++++
 netlink.h    | 30 ++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 batman_adv.h
 create mode 100644 netlink.c
 create mode 100644 netlink.h

diff --git a/Makefile b/Makefile
index a037847..3fa21f4 100755
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,7 @@ OBJ += hash.o
 OBJ += ioctl.o
 OBJ += list-batman.o
 OBJ += main.o
+OBJ += netlink.o
 OBJ += ping.o
 OBJ += sys.o
 OBJ += tcpdump.o
@@ -73,6 +74,17 @@ endif
 CFLAGS += $(LIBNL_CFLAGS)
 LDLIBS += $(LIBNL_LDLIBS)
 
+ifeq ($(origin LIBNL_GENL_CFLAGS) $(origin LIBNL_GENL_LDLIBS), undefined undefined)
+  LIBNL_GENL_NAME ?= libnl-genl-3.0
+  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_GENL_NAME) 2>/dev/null),)
+    $(error No $(LIBNL_GENL_NAME) development libraries found!)
+  endif
+  LIBNL_GENL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_GENL_NAME))
+  LIBNL_GENL_LDLIBS += $(shell $(PKG_CONFIG) --libs $(LIBNL_GENL_NAME))
+endif
+CFLAGS += $(LIBNL_GENL_CFLAGS)
+LDLIBS += $(LIBNL_GENL_LDLIBS)
+
 # standard build tools
 ifeq ($(CONFIG_BATCTL_BISECT),y)
 OBJ += $(OBJ_BISECT)
diff --git a/batman_adv.h b/batman_adv.h
new file mode 100644
index 0000000..ba611a7
--- /dev/null
+++ b/batman_adv.h
@@ -0,0 +1,53 @@
+/* Copyright (C) 2016 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_LINUX_BATMAN_ADV_H_
+#define _UAPI_LINUX_BATMAN_ADV_H_
+
+#define BATADV_NL_NAME "batadv"
+
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
+	BATADV_ATTR_UNSPEC,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
+};
+
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
+	BATADV_CMD_UNSPEC,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
+};
+
+#endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/netlink.c b/netlink.c
new file mode 100644
index 0000000..409953a
--- /dev/null
+++ b/netlink.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
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
+ */
+
+#include "netlink.h"
+#include "main.h"
+
+#include "batman_adv.h"
+
+struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
+};
diff --git a/netlink.h b/netlink.h
new file mode 100644
index 0000000..0a4d3dd
--- /dev/null
+++ b/netlink.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
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
+ */
+
+#ifndef _BATCTL_NETLINK_H
+#define _BATCTL_NETLINK_H
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+
+extern struct nla_policy batadv_netlink_policy[];
+
+#endif /* _BATCTL_NETLINK_H */
-- 
2.8.1

