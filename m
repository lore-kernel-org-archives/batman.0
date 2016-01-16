Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:39 +0100
Message-Id: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 01/20] batman-adv: Add compatibility code
	for kref_get_unless_zero
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v6:
 - removed patches which are now applied in the branch next
 - rebased remaining patches on the patch
   "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
   modified by Marek while he applied the patches (this unfortunately made
   some of the remaining patches "hard" to apply)
v5:
 - add hack which allows to compile against stable kernel like 3.2.44 which
   also added the kref_get_unless_zero function
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 compat-include/linux/kref.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 compat-include/linux/kref.h

diff --git a/compat-include/linux/kref.h b/compat-include/linux/kref.h
new file mode 100644
index 0000000..bb3442c
--- /dev/null
+++ b/compat-include/linux/kref.h
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
+
+#include <linux/version.h>
+#include_next <linux/kref.h>
+
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
+
+/* some stable versions like Linux 3.2.44 also introduced this function
+ * and would therefore break the build because they trigger a redefinition
+ * of this function. Instead rename this function to be in the batadv_*
+ * namespace
+ */
+#define kref_get_unless_zero(__kref) batadv_kref_get_unless_zero(__kref)
+
+static inline int __must_check batadv_kref_get_unless_zero(struct kref *kref)
+{
+	return atomic_add_unless(&kref->refcount, 1, 0);
+}
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_ */
-- 
2.7.0.rc3

