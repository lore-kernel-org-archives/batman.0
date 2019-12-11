Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Replace FIELD_SIZEOF with sizeof_field
Date: Wed, 11 Dec 2019 09:52:17 +0100
Message-Id: <20191211085217.7878-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The prefered way of getting the size of a member of a struct is the common
macro sizeof_field from stddef.h and not the FIELD_SIZEOF (with multiple
definitions).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/stddef.h | 24 ++++++++++++++++++++++++
 net/batman-adv/main.c         |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 compat-include/linux/stddef.h

diff --git a/compat-include/linux/stddef.h b/compat-include/linux/stddef.h
new file mode 100644
index 00000000..dd18840e
--- /dev/null
+++ b/compat-include/linux/stddef.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_STDDEF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_STDDEF_H_
+
+#include <linux/version.h>
+#include_next <linux/stddef.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 16, 0)
+
+#ifndef sizeof_field
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
+#endif /* < KERNEL_VERSION(4, 16, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_STDDEF_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4a89177d..4811ec65 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -548,7 +548,7 @@ static void batadv_recv_handler_init(void)
 	BUILD_BUG_ON(sizeof(struct batadv_tvlv_tt_change) != 12);
 	BUILD_BUG_ON(sizeof(struct batadv_tvlv_roam_adv) != 8);
 
-	i = FIELD_SIZEOF(struct sk_buff, cb);
+	i = sizeof_field(struct sk_buff, cb);
 	BUILD_BUG_ON(sizeof(struct batadv_skb_cb) > i);
 
 	/* broadcast packet */
-- 
2.20.1

