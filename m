Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 10:03:28 +0200
Message-Id: <20161029080328.26584-3-sven@narfation.org>
In-Reply-To: <20161029080328.26584-1-sven@narfation.org>
References: <20161029080328.26584-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: genetlink: mark families as
	__ro_after_init
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

From: Johannes Berg <johannes.berg@intel.com>

Now genl_register_family() is the only thing (other than the
users themselves, perhaps, but I didn't find any doing that)
writing to the family struct.

In all families that I found, genl_register_family() is only
called from __init functions (some indirectly, in which case
I've add __init annotations to clarifly things), so all can
actually be marked __ro_after_init.

This protects the data structure from accidental corruption.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch already in net-next

 compat-include/linux/cache.h | 35 +++++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.c     |  2 +-
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 compat-include/linux/cache.h

diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
new file mode 100644
index 0000000..93dff58
--- /dev/null
+++ b/compat-include/linux/cache.h
@@ -0,0 +1,35 @@
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_CACHE_H
+#define _NET_BATMAN_ADV_COMPAT_LINUX_CACHE_H
+
+#include <linux/version.h>
+#include_next <linux/cache.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
+
+#ifndef __ro_after_init
+#define __ro_after_init
+#endif
+
+#endif /* < KERNEL_VERSION(4, 6, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_CACHE_H */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5dfc5c4..5d38c77 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -603,7 +603,7 @@ static const struct genl_ops batadv_netlink_ops[] = {
 
 };
 
-struct genl_family batadv_netlink_family = {
+struct genl_family batadv_netlink_family __ro_after_init = {
 	.hdrsize = 0,
 	.name = BATADV_NL_NAME,
 	.version = 1,
-- 
2.10.1

