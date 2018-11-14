Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:53 +0100
Message-Id: <20181114140804.18381-6-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/16] batman-adv: Allow to use
 BATMAN_ADV_DEBUG without BATMAN_ADV_DEBUGFS
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

The BATMAN_ADV_DEBUGFS portion of batman-adv is marked as deprecated. Thus
all required functionality should be available without it. The debug log
was already modified to also output via the kernel tracing function but
still retained its BATMAN_ADV_DEBUGFS functionality.

Separate the entry point for the debug log from the debugfs portions to
make it possible to build with BATMAN_ADV_DEBUG and without
BATMAN_ADV_DEBUGFS.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig |  2 +-
 net/batman-adv/log.c   | 60 +++++++++++++++++++++++++++-----------------------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f75816f58107..7b0e1fcddfa7 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -100,7 +100,7 @@ config BATMAN_ADV_DEBUGFS
 
 config BATMAN_ADV_DEBUG
 	bool "B.A.T.M.A.N. debugging"
-	depends on BATMAN_ADV_DEBUGFS
+	depends on BATMAN_ADV
 	help
 	  This is an option for use by developers; most people should
 	  say N here. This enables compilation of support for
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 6beb5f067810..02e55b78132f 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -43,6 +43,8 @@
 #include "debugfs.h"
 #include "trace.h"
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
+
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
 
 static const int batadv_log_buff_len = BATADV_LOG_BUF_LEN;
@@ -92,33 +94,6 @@ static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
 	return 0;
 }
 
-/**
- * batadv_debug_log() - Add debug log entry
- * @bat_priv: the bat priv with all the soft interface information
- * @fmt: format string
- *
- * Return: 0 on success or negative error number in case of failure
- */
-int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	batadv_fdebug_log(bat_priv->debug_log, "[%10u] %pV",
-			  jiffies_to_msecs(jiffies), &vaf);
-
-	trace_batadv_dbg(bat_priv, &vaf);
-
-	va_end(args);
-
-	return 0;
-}
-
 static int batadv_log_open(struct inode *inode, struct file *file)
 {
 	if (!try_module_get(THIS_MODULE))
@@ -259,3 +234,34 @@ void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 	kfree(bat_priv->debug_log);
 	bat_priv->debug_log = NULL;
 }
+
+#endif /* CONFIG_BATMAN_ADV_DEBUGFS */
+
+/**
+ * batadv_debug_log() - Add debug log entry
+ * @bat_priv: the bat priv with all the soft interface information
+ * @fmt: format string
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
+	batadv_fdebug_log(bat_priv->debug_log, "[%10u] %pV",
+			  jiffies_to_msecs(jiffies), &vaf);
+#endif
+
+	trace_batadv_dbg(bat_priv, &vaf);
+
+	va_end(args);
+
+	return 0;
+}
-- 
2.11.0

