Date: Wed, 24 Sep 2008 23:58:53 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080924215853.GA9253@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Backport gateway module to 2.6.18
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

kernel_bind and other kernel socket api functions were defined by linux
v2.6.18-310-gac5a488 and ip_hdr first appeared in linux v2.6.21-122-geddc9ec.
To provide these functions a new compatibility header file with the name
compat26.h was added to provide an easy way to support older kernels. Other
"#if LINUX_VERSION_CODE" should be copied into this file.
---
 batman/linux/modules/compat26.h |   42 +++++++++++++++++++++++++++++++++++++++
 batman/linux/modules/gateway.c  |    1 +
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 batman/linux/modules/compat26.h

diff --git a/batman/linux/modules/compat26.h b/batman/linux/modules/compat26.h
new file mode 100644
index 0000000..a95b229
--- /dev/null
+++ b/batman/linux/modules/compat26.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2008 BATMAN contributors:
+ * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner, Andreas Langer
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
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#include <linux/version.h>	/* LINUX_VERSION_CODE */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 22)
+
+#define skb_network_header(_skb) \
+	((_skb)->nh.raw)
+
+static inline struct iphdr *ip_hdr(const struct sk_buff *skb)
+{
+	return (struct iphdr *)skb_network_header(skb);
+}
+#endif /* KERNEL_VERSION(2, 6, 22) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 19)
+
+static inline int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
+{
+	return sock->ops->bind(sock, addr, addrlen);
+}
+#endif /* KERNEL_VERSION(2, 6, 19) */
diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 7272c50..965f87b 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -19,6 +19,7 @@
 
 #include "gateway.h"
 #include "hash.h"
+#include "compat26.h"
 
 
 static struct class *batman_class;
-- 
1.6.0.1


