Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Aug 2018 23:36:16 +0200
Message-Id: <20180810213616.23794-3-sven@narfation.org>
In-Reply-To: <20180810213616.23794-1-sven@narfation.org>
References: <20180810213616.23794-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Provide debug messages as
 trace events
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

A private debug logging infrastructure is currently provided via
$debug_fs/batman_adv/*/log when CONFIG_BATMAN_ADV_DEBUG is enabled. This is
not well integrated in the rest of the tracing infrastructure of the
kernel.

Other components (like mac80211 or ath10k) allow to gather the debug
messages using generic trace events which are better integrated. This makes
it possible to interact with them using the existing userspace tools.

The tracepoint batadv:batadv_dbg will now be available when
CONFIG_BATMAN_ADV_DEBUG and CONFIG_BATMAN_ADV_TRACING is activated. The log
level mask is still used for filtering as usual.

A full system trace for offline parsing can be created (and read) using:

  $ batctl ll all
  $ trace-cmd record -e batadv:batadv_dbg
  $ trace-cmd report

The same can also be done without recording to a file

  $ batctl ll all
  $ trace-cmd stream -e batadv:batadv_dbg

The trace infrastructure is especially helpful when tracing processes:

  $ batctl ll all
  $ ./tools/perf/perf trace --event "batadv:*" batctl p 10.204.32.1
     0.000 batadv:batadv_dbg:batman_adv bat0 Parsing outgoing ARP REQUEST
     0.045 batadv:batadv_dbg:batman_adv bat0 ARP MSG = [src: a2:64:14:53:f8:22-10.204.32.185 dst: 00:00:00:00:00:00-10.204.32.1]
     0.067 batadv:batadv_dbg:batman_adv bat0 Entry updated: 10.204.32.185 a2:64:14:53:f8:22 (vid: -1)
     0.099 batadv:batadv_dbg:batman_adv bat0 batadv_dat_select_candidates(): IP=10.204.32.1 hash(IP)=48902
     0.757 batadv:batadv_dbg:batman_adv bat0 dat_select_candidates() 0: selected fe:2c:91:68:29:2b addr=48977 dist=65460
     1.178 batadv:batadv_dbg:batman_adv bat0 dat_select_candidates() 1: selected fe:81:ab:c5:e3:03 addr=49181 dist=65256
     1.809 batadv:batadv_dbg:batman_adv bat0 dat_select_candidates() 2: selected 66:25:a7:48:37:fb addr=49328 dist=65109
     1.828 batadv:batadv_dbg:batman_adv bat0 DHT_SEND for 10.204.32.1

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                |  3 ++
 README.external.rst     |  1 +
 gen-compat-autoconf.sh  |  1 +
 net/batman-adv/Kconfig  | 11 ++++++
 net/batman-adv/Makefile |  3 ++
 net/batman-adv/log.c    | 17 ++++++---
 net/batman-adv/trace.c  | 22 ++++++++++++
 net/batman-adv/trace.h  | 78 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 131 insertions(+), 5 deletions(-)
 create mode 100644 net/batman-adv/trace.c
 create mode 100644 net/batman-adv/trace.h

diff --git a/Makefile b/Makefile
index 7c6fa1e4..d665c0ba 100644
--- a/Makefile
+++ b/Makefile
@@ -29,6 +29,8 @@ export CONFIG_BATMAN_ADV_DAT=y
 export CONFIG_BATMAN_ADV_NC=n
 # B.A.T.M.A.N. multicast optimizations:
 export CONFIG_BATMAN_ADV_MCAST=y
+# B.A.T.M.A.N. tracing support:
+export CONFIG_BATMAN_ADV_TRACING=n
 # B.A.T.M.A.N. V routing algorithm (experimental):
 export CONFIG_BATMAN_ADV_BATMAN_V=y
 
@@ -75,6 +77,7 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_DAT=$(CONFIG_BATMAN_ADV_DAT) \
 	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
 	CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
+	CONFIG_BATMAN_ADV_TRACING=$(CONFIG_BATMAN_ADV_TRACING) \
 	CONFIG_BATMAN_ADV_BATMAN_V=$(CONFIG_BATMAN_ADV_BATMAN_V) \
 	INSTALL_MOD_DIR=updates/
 
diff --git a/README.external.rst b/README.external.rst
index 2faec155..3f6539ed 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -49,6 +49,7 @@ module).  Available  options  and  their    possible   values are
  * ``CONFIG_BATMAN_ADV_DAT=[y*|n]`` (B.A.T.M.A.N. Distributed ARP Table)
  * ``CONFIG_BATMAN_ADV_MCAST=[y*|n]`` (B.A.T.M.A.N. multicast optimizations)
  * ``CONFIG_BATMAN_ADV_NC=[y|n*]`` (B.A.T.M.A.N. Network Coding)
+ * ``CONFIG_BATMAN_ADV_TRACING=[y|n*]`` (B.A.T.M.A.N. tracing support)
  * ``CONFIG_BATMAN_ADV_BATMAN_V=[y*|n]`` (B.A.T.M.A.N. V routing algorithm)
 
 e.g., debugging can be enabled by::
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 5dcd875d..a4eb1136 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -58,6 +58,7 @@ gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_TRACING' ${CONFIG_BATMAN_ADV_TRACING:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 361116f7..f75816f5 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -106,3 +106,14 @@ config BATMAN_ADV_DEBUG
 	  say N here. This enables compilation of support for
 	  outputting debugging information to the kernel log. The
 	  output is controlled via the module parameter debug.
+
+config BATMAN_ADV_TRACING
+	bool "B.A.T.M.A.N. tracing support"
+	depends on BATMAN_ADV
+	depends on EVENT_TRACING
+	help
+	  This is an option for use by developers; most people should
+	  say N here. Select this option to gather traces like the debug
+	  messages using the generic tracing infrastructure of the kernel.
+	  BATMAN_ADV_DEBUG must also be selected to get trace events for
+	  batadv_dbg.
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index b97ba6fb..9b58160f 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -42,6 +42,9 @@ batman-adv-y += routing.o
 batman-adv-y += send.o
 batman-adv-y += soft-interface.o
 batman-adv-y += sysfs.o
+batman-adv-$(CONFIG_BATMAN_ADV_TRACING) += trace.o
 batman-adv-y += tp_meter.o
 batman-adv-y += translation-table.o
 batman-adv-y += tvlv.o
+
+CFLAGS_trace.o := -I$(src)
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 1032d84e..8a3d6910 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -41,6 +41,7 @@
 #include <stdarg.h>
 
 #include "debugfs.h"
+#include "trace.h"
 
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
 
@@ -100,13 +101,19 @@ static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
  */
 int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 {
+	struct va_format vaf;
 	va_list args;
-	char tmp_log_buf[256];
 
 	va_start(args, fmt);
-	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
-	batadv_fdebug_log(bat_priv->debug_log, "[%10u] %s",
-			  jiffies_to_msecs(jiffies), tmp_log_buf);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	batadv_fdebug_log(bat_priv->debug_log, "[%10u] %pV",
+			  jiffies_to_msecs(jiffies), &vaf);
+
+	trace_batadv_dbg(bat_priv, &vaf);
+
 	va_end(args);
 
 	return 0;
@@ -117,7 +124,7 @@ static int batadv_log_open(struct inode *inode, struct file *file)
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
 
-	batadv_debugfs_deprecated(file, "");
+	batadv_debugfs_deprecated(file, "Use tracepoint batadv:batadv_dbg instead\n");
 
 	nonseekable_open(inode, file);
 	file->private_data = inode->i_private;
diff --git a/net/batman-adv/trace.c b/net/batman-adv/trace.c
new file mode 100644
index 00000000..3d57f998
--- /dev/null
+++ b/net/batman-adv/trace.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+ *
+ * Sven Eckelmann
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
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
new file mode 100644
index 00000000..3acda26a
--- /dev/null
+++ b/net/batman-adv/trace.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+ *
+ * Sven Eckelmann
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
+#if !defined(_NET_BATMAN_ADV_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _NET_BATMAN_ADV_TRACE_H_
+
+#include "main.h"
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM batadv
+
+/* provide dummy function when tracing is disabled */
+#if !defined(CONFIG_BATMAN_ADV_TRACING)
+
+#undef TRACE_EVENT
+#define TRACE_EVENT(name, proto, ...) \
+	static inline void trace_ ## name(proto) {}
+
+#endif /* CONFIG_BATMAN_ADV_TRACING */
+
+#define BATADV_MAX_MSG_LEN	256
+
+TRACE_EVENT(batadv_dbg,
+
+	    TP_PROTO(struct batadv_priv *bat_priv,
+		     struct va_format *vaf),
+
+	    TP_ARGS(bat_priv, vaf),
+
+	    TP_STRUCT__entry(
+		    __string(device, bat_priv->soft_iface->name)
+		    __string(driver, KBUILD_MODNAME)
+		    __dynamic_array(char, msg, BATADV_MAX_MSG_LEN)
+	    ),
+
+	    TP_fast_assign(
+		    __assign_str(device, bat_priv->soft_iface->name);
+		    __assign_str(driver, KBUILD_MODNAME);
+		    WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg),
+					   BATADV_MAX_MSG_LEN,
+					   vaf->fmt,
+					   *vaf->va) >= BATADV_MAX_MSG_LEN);
+	    ),
+
+	    TP_printk(
+		    "%s %s %s",
+		    __get_str(driver),
+		    __get_str(device),
+		    __get_str(msg)
+	    )
+);
+
+#endif /* _NET_BATMAN_ADV_TRACE_H_ || TRACE_HEADER_MULTI_READ */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.18.0

