Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 18 Feb 2016 18:26:54 +0100
Message-Id: <1455816416-24942-3-git-send-email-sven@open-mesh.com>
In-Reply-To: <1455816416-24942-1-git-send-email-sven@open-mesh.com>
References: <6595687.FqdJJADTWg@bentobox>
 <1455816416-24942-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [RFC 3/5] batman-adv: Add compatibility code for
	to_delayed_work
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
Cc: Edo Monticelli <montik@autistici.org>, Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 compat-include/linux/workqueue.h | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 compat-include/linux/workqueue.h

diff --git a/compat-include/linux/workqueue.h b/compat-include/linux/workqueue.h
new file mode 100644
index 0000000..85a41df
--- /dev/null
+++ b/compat-include/linux/workqueue.h
@@ -0,0 +1,46 @@
+/* Copyright (C) 2007-2016 B.A.T.M.A.N. contributors:
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
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_WORKQUEUE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_WORKQUEUE_H_
+
+#include <linux/version.h>
+#include_next <linux/workqueue.h>
+
+#include <linux/kernel.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
+
+/* some stable versions like Linux 3.2.44 also introduced this function
+ * and would therefore break the build because they trigger a redefinition
+ * of this function. Instead rename this function to be in the batadv_*
+ * namespace
+ */
+#define to_delayed_work(__work) batadv_to_delayed_work(__work)
+
+static inline struct delayed_work *
+batadv_to_delayed_work(struct work_struct *work)
+{
+	return container_of(work, struct delayed_work, work);
+}
+
+#endif /* < KERNEL_VERSION(2, 6, 30) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_WORKQUEUE_H_ */
-- 
2.7.0

