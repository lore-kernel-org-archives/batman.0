Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 May 2012 10:55:38 +0200
Message-Id: <1337504138-8209-1-git-send-email-sven@narfation.org>
In-Reply-To: <1337413075-8853-1-git-send-email-sven@narfation.org>
References: <1337413075-8853-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Remove batadv_ vararg inline
	functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

gcc doesn't support the inlining of functions using vararg. Sparse fails to
build the source when having such functions marked using the keyword "inline".

This problem was introduced in 3b896e321c49e3cbbfd540f537c007db883c3900

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
I've decided that we should it revert for now and hope for a better solution in
the future. The old patch didn't worked at all for .._DEBUG=y all builds.

 bat_debugfs.c |    5 ++++-
 main.h        |   39 +++++++++++++--------------------------
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index c3f7e2f..87349f4 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -74,13 +74,16 @@ static int batadv_fdebug_log(struct debug_log *debug_log, const char *fmt, ...)
 	return 0;
 }
 
-int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, va_list args)
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
 {
+	va_list args;
 	char tmp_log_buf[256];
 
+	va_start(args, fmt);
 	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
 	batadv_fdebug_log(bat_priv->debug_log, "[%10u] %s",
 			  jiffies_to_msecs(jiffies), tmp_log_buf);
+	va_end(args);
 
 	return 0;
 }
diff --git a/main.h b/main.h
index 977de45..b850eeb 100644
--- a/main.h
+++ b/main.h
@@ -187,36 +187,23 @@ int batadv_algo_select(struct bat_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, va_list args);
-
-static inline void batadv_vdbg(int type, struct bat_priv *bat_priv,
-			       const char *fmt, va_list args)
-{
-	if (atomic_read(&bat_priv->log_level) & type)
-		batadv_debug_log(bat_priv, fmt, args);
-}
-
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+__printf(2, 3);
+
+#define batadv_dbg(type, bat_priv, fmt, arg...)			\
+	do {							\
+		if (atomic_read(&bat_priv->log_level) & type)	\
+			batadv_debug_log(bat_priv, fmt, ## arg);\
+	}							\
+	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
-
-static inline void batadv_vdbg(int type __always_unused,
-			       struct bat_priv *bat_priv __always_unused,
-			       const char *fmt __always_unused,
-			       va_list args __always_unused)
-{
-}
-
-#endif
-
 __printf(3, 4)
-static inline void batadv_dbg(int type, struct bat_priv *bat_priv,
-			       const char *fmt, ...)
+static inline void batadv_dbg(int type __always_unused,
+			      struct bat_priv *bat_priv __always_unused,
+			      const char *fmt __always_unused, ...)
 {
-	va_list args;
-
-	va_start(args, fmt);
-	batadv_vdbg(type, bat_priv, fmt, args);
-	va_end(args);
 }
+#endif
 
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
-- 
1.7.10

