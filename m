Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: tracing: Use the new __vstring() helper
Date: Sun, 24 Jul 2022 23:27:19 +0200
Message-Id: <20220724212719.92570-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of open coding a __dynamic_array() with a fixed length (which
defeats the purpose of the dynamic array in the first place). Use the new
__vstring() helper that will use a va_list and only write enough of the
string into the ring buffer that is needed.

Link: https://lkml.kernel.org/r/20220705224751.080390002@goodmis.org

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[sven@narfation.org: add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Already added to
https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/c=
ommit/?h=3Dfor-next&id=3D013cfbccb0cb3bbac478666aed78e4f5f7e39dd6

 compat-include/linux/tracepoint.h | 24 ++++++++++++++++++++++++
 net/batman-adv/trace.h            |  7 ++-----
 2 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100644 compat-include/linux/tracepoint.h

diff --git a/compat-include/linux/tracepoint.h b/compat-include/linux/tra=
cepoint.h
new file mode 100644
index 00000000..61df01a3
--- /dev/null
+++ b/compat-include/linux/tracepoint.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older ve=
rsions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_TRACEPOINT_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_TRACEPOINT_H_
+
+#include <linux/version.h>
+#include_next <linux/tracepoint.h>
+
+#if LINUX_VERSION_IS_LESS(5, 19, 0)
+
+#define __vstring(item, fmt, ap) __dynamic_array(char, item, 256)
+#define __assign_vstr(dst, fmt, va) \
+	WARN_ON_ONCE(vsnprintf(__get_dynamic_array(dst), 256, fmt, *va) >=3D 25=
6)
+
+#endif /* LINUX_VERSION_IS_LESS(5, 19, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_TRACEPOINT_H_ */
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index d673ebdd..67d2a8a0 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -40,16 +40,13 @@ TRACE_EVENT(batadv_dbg,
 	    TP_STRUCT__entry(
 		    __string(device, bat_priv->soft_iface->name)
 		    __string(driver, KBUILD_MODNAME)
-		    __dynamic_array(char, msg, BATADV_MAX_MSG_LEN)
+		    __vstring(msg, vaf->fmt, vaf->va)
 	    ),
=20
 	    TP_fast_assign(
 		    __assign_str(device, bat_priv->soft_iface->name);
 		    __assign_str(driver, KBUILD_MODNAME);
-		    WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg),
-					   BATADV_MAX_MSG_LEN,
-					   vaf->fmt,
-					   *vaf->va) >=3D BATADV_MAX_MSG_LEN);
+		    __assign_vstr(msg, vaf->fmt, vaf->va);
 	    ),
=20
 	    TP_printk(
--=20
2.30.2
