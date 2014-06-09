Return-Path: <gaul@web-yard.de>
From: =?UTF-8?q?Andr=C3=A9=20Gaul?= <gaul@web-yard.de>
Date: Mon,  9 Jun 2014 19:14:19 +0200
Message-Id: <1402334059-28681-1-git-send-email-gaul@web-yard.de>
In-Reply-To: <53957653.5000406@meshcoding.com>
References: <53957653.5000406@meshcoding.com>
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
 main.h    | 20 ++++++++++++++------
 routing.c | 18 +++++++++---------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/main.h b/main.h
index 87e7196..4bb500b 100644
--- a/main.h
+++ b/main.h
@@ -239,21 +239,29 @@ enum batadv_dbg_level {
 int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 __printf(2, 3);
 
-#define batadv_dbg(type, bat_priv, fmt, arg...)			\
+/* possibly ratelimited debug output */
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)	\
 	do {							\
-		if (atomic_read(&bat_priv->log_level) & type)	\
+		if (atomic_read(&bat_priv->log_level) & type && \
+		    (!ratelimited || net_ratelimit()))		\
 			batadv_debug_log(bat_priv, fmt, ## arg);\
 	}							\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
-__printf(3, 4)
-static inline void batadv_dbg(int type __always_unused,
-			      struct batadv_priv *bat_priv __always_unused,
-			      const char *fmt __always_unused, ...)
+__printf(4, 5)
+static inline void _batadv_dbg(int type __always_unused,
+			       struct batadv_priv *bat_priv __always_unused,
+			       int ratelimited __always_unused,
+			       const char *fmt __always_unused, ...)
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
index 3514153..35f76f2 100644
--- a/routing.c
+++ b/routing.c
@@ -706,11 +706,11 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid)) {
 		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
 						  ethhdr->h_dest, vid))
-			net_ratelimited_function(batadv_dbg, BATADV_DBG_TT,
-						 bat_priv,
-						 "Rerouting unicast packet to %pM (dst=%pM): Local Roaming\n",
-						 unicast_packet->dest,
-						 ethhdr->h_dest);
+			batadv_dbg_ratelimited(BATADV_DBG_TT,
+					       bat_priv,
+					       "Rerouting unicast packet to %pM (dst=%pM): Local Roaming\n",
+					       unicast_packet->dest,
+					       ethhdr->h_dest);
 		/* at this point the mesh destination should have been
 		 * substituted with the originator address found in the global
 		 * table. If not, let the packet go untouched anyway because
@@ -752,10 +752,10 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 */
 	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
 					  ethhdr->h_dest, vid)) {
-		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
-					 "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
-					 unicast_packet->dest, ethhdr->h_dest,
-					 old_ttvn, curr_ttvn);
+		batadv_dbg_ratelimited(BATADV_DBG_TT, bat_priv,
+				       "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
+				       unicast_packet->dest, ethhdr->h_dest,
+				       old_ttvn, curr_ttvn);
 		return 1;
 	}
 
-- 
1.9.1

