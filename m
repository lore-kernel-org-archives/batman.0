Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 22:01:22 +0100
Message-Id: <20181030210130.18152-2-sven@narfation.org>
In-Reply-To: <20181030210130.18152-1-sven@narfation.org>
References: <20181030210130.18152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Add compat for
 genl_dump_check_consistent
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

The commit 0a833c29d896 ("genetlink: fix genlmsg_nlhdr()") removed the
family parameter for genl_dump_check_consistent. It is actually not needed
because batman-adv doesn't use userspace headers and a dummy family with
hdrsize 0 can be used for these kernel versions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/net/genetlink.h | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 compat-include/net/genetlink.h

diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
new file mode 100644
index 00000000..026500c3
--- /dev/null
+++ b/compat-include/net/genetlink.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
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
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+
+#include <linux/version.h>
+#include_next <net/genetlink.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+
+static inline
+void batadv_genl_dump_check_consistent(struct netlink_callback *cb,
+				       void *user_hdr)
+{
+	struct genl_family genl_family = {
+		.hdrsize = 0,
+	};
+
+	genl_dump_check_consistent(cb, user_hdr, &genl_family);
+}
+
+#define genl_dump_check_consistent batadv_genl_dump_check_consistent
+
+#endif /* < KERNEL_VERSION(4, 15, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */
-- 
2.19.1

