Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:26 +0200
Message-Id: <20170406140741.30745-5-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 04/19] batman-adv: Fix possible side-effects
	in _batadv_dbg
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

An argument of a macro should not be evaluated multiple times. Otherwise
embedded operations in these arguments will be executed multiple times.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/log.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 7a2b9f4da078..65ce97efa6b5 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -73,9 +73,10 @@ __printf(2, 3);
 /* possibly ratelimited debug output */
 #define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
 	do {								\
-		if (atomic_read(&(bat_priv)->log_level) & (type) &&	\
+		struct batadv_priv *__batpriv = (bat_priv);		\
+		if (atomic_read(&__batpriv->log_level) & (type) &&	\
 		    (!(ratelimited) || net_ratelimit()))		\
-			batadv_debug_log(bat_priv, fmt, ## arg);	\
+			batadv_debug_log(__batpriv, fmt, ## arg);	\
 	}								\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
-- 
2.11.0

