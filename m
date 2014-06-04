Return-Path: <gaul@web-yard.de>
From: =?UTF-8?q?Andr=C3=A9=20Gaul?= <gaul@web-yard.de>
Date: Wed,  4 Jun 2014 21:53:36 +0200
Message-Id: <1401911616-18318-1-git-send-email-gaul@web-yard.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] remove unnecessary logspam
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: =?UTF-8?q?Andr=C3=A9=20Gaul?= <gaul@web-yard.de>

This patch removes unnecessary logspam which resulted from superfluous
calls to net_ratelimit(). With the supplied patch, net_ratelimit() is
called after the loglevel has been checked.

Signed-off-by: André Gaul <gaul@web-yard.de>
---
 main.h    | 16 ++++++++++++----
 routing.c |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/main.h b/main.h
index 87e7196..df57639 100644
--- a/main.h
+++ b/main.h
@@ -239,21 +239,29 @@ enum batadv_dbg_level {
 int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 __printf(2, 3);
 
-#define batadv_dbg(type, bat_priv, fmt, arg...)			\
+/* possibly ratelimited debug output */
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)			\
 	do {							\
-		if (atomic_read(&bat_priv->log_level) & type)	\
+		if (atomic_read(&bat_priv->log_level) & type && \
+		    (!ratelimited || net_ratelimit()))	\
 			batadv_debug_log(bat_priv, fmt, ## arg);\
 	}							\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
-__printf(3, 4)
-static inline void batadv_dbg(int type __always_unused,
+__printf(4, 5)
+static inline void _batadv_dbg(int type __always_unused,
 			      struct batadv_priv *bat_priv __always_unused,
+			      int ratelimited __always_unused,
 			      const char *fmt __always_unused, ...)
 {
 }
 #endif
 
+#define batadv_dbg(type, bat_priv, arg...) \
+	_batadv_dbg(type, bat_priv, 0, ## arg)
+#define batadv_dbg_ratelimited(type, bat_priv, arg...) \
+	_batadv_dbg(type, bat_priv, 1, ## arg)
+
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
diff --git a/routing.c b/routing.c
index 3514153..c679c6f 100644
--- a/routing.c
+++ b/routing.c
@@ -706,7 +706,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid)) {
 		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
 						  ethhdr->h_dest, vid))
-			net_ratelimited_function(batadv_dbg, BATADV_DBG_TT,
+			batadv_dbg_ratelimited(BATADV_DBG_TT,
 						 bat_priv,
 						 "Rerouting unicast packet to %pM (dst=%pM): Local Roaming\n",
 						 unicast_packet->dest,
@@ -752,7 +752,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 */
 	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
 					  ethhdr->h_dest, vid)) {
-		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
+		batadv_dbg_ratelimited(BATADV_DBG_TT, bat_priv,
 					 "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
 					 unicast_packet->dest, ethhdr->h_dest,
 					 old_ttvn, curr_ttvn);
-- 
1.9.1

