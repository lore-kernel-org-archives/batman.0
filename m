Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:09 +0100
Message-Id: <20171215114320.13645-10-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/20] batman-adv: include build_bug.h for
 BUILD_BUG_ON define
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

commit bc6245e5efd7 ("bug: split BUILD_BUG stuff out into
<linux/build_bug.h>") added a new header for BUILD_BUG_ON. It should
therefore be included instead of linux/bug.h

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 compat-include/linux/build_bug.h   | 34 ++++++++++++++++++++++++++++++++++
 net/batman-adv/main.c              |  2 +-
 net/batman-adv/tp_meter.c          |  2 +-
 net/batman-adv/translation-table.c |  2 +-
 4 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 compat-include/linux/build_bug.h

diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/build_bug.h
new file mode 100644
index 000000000000..d1ebfa71e2b6
--- /dev/null
+++ b/compat-include/linux/build_bug.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 13, 0)
+#include_next <linux/build_bug.h>
+#else
+#include <linux/bug.h>
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 45f0f4ff8a08..107b50e5ecc2 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -21,7 +21,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/crc32c.h>
 #include <linux/errno.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 45e7a77e5127..6f3dca80d74f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -22,7 +22,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 66092c6b2f6a..db7a67ee9599 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -23,7 +23,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
-- 
2.11.0

