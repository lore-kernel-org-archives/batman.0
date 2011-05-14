Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 May 2011 23:14:46 +0200
Message-Id: <1305407694-16789-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Annotate functions with
	format strings
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_debugfs.c |    1 +
 main.h        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index abaeec5..4577d3f 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -50,6 +50,7 @@ static void emit_log_char(struct debug_log *debug_log, char c)
 		debug_log->log_start = debug_log->log_end - log_buff_len;
 }
 
+__printf(2, 3)
 static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
 {
 	va_list args;
diff --git a/main.h b/main.h
index 3ca3941..f80954b 100644
--- a/main.h
+++ b/main.h
@@ -138,7 +138,7 @@ void dec_module_count(void);
 int is_my_mac(uint8_t *addr);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
+int debug_log(struct bat_priv *bat_priv, char *fmt, ...) __printf(2, 3);
 
 #define bat_dbg(type, bat_priv, fmt, arg...)			\
 	do {							\
@@ -147,6 +147,7 @@ int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
 	}							\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
+__printf(3, 4)
 static inline void bat_dbg(char type __always_unused,
 			   struct bat_priv *bat_priv __always_unused,
 			   char *fmt __always_unused, ...)
-- 
1.7.5.1

