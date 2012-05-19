Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 May 2012 09:37:55 +0200
Message-Id: <1337413075-8853-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid gcc inline problems with
	vararg functions
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
 main.h |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/main.h b/main.h
index 977de45..4721c86 100644
--- a/main.h
+++ b/main.h
@@ -196,6 +196,17 @@ static inline void batadv_vdbg(int type, struct bat_priv *bat_priv,
 		batadv_debug_log(bat_priv, fmt, args);
 }
 
+__printf(3, 4)
+static inline void batadv_dbg(int type, struct bat_priv *bat_priv,
+			       const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	batadv_vdbg(type, bat_priv, fmt, args);
+	va_end(args);
+}
+
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
 
 static inline void batadv_vdbg(int type __always_unused,
@@ -205,19 +216,14 @@ static inline void batadv_vdbg(int type __always_unused,
 {
 }
 
-#endif
-
 __printf(3, 4)
 static inline void batadv_dbg(int type, struct bat_priv *bat_priv,
 			       const char *fmt, ...)
 {
-	va_list args;
-
-	va_start(args, fmt);
-	batadv_vdbg(type, bat_priv, fmt, args);
-	va_end(args);
 }
 
+#endif
+
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
-- 
1.7.10

