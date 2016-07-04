Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  4 Jul 2016 15:02:49 +0200
Message-Id: <1467637379-6089-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467637379-6089-1-git-send-email-sw@simonwunderlich.de>
References: <1467637379-6089-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/11] batman-adv: Include main.h in
	bat_v_ogm.h
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

main.h includes statements which (re)define preprocessor variables which
influence the compiled code. This makes it necessary to include it in all
files. For example, it redefines pr_fmt used to the module as prefix for
each pr_* message.

Reported-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index d849c75..4c4d45c 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -18,10 +18,10 @@
 #ifndef _BATMAN_ADV_BATADV_V_OGM_H_
 #define _BATMAN_ADV_BATADV_V_OGM_H_
 
+#include "main.h"
+
 #include <linux/types.h>
 
-struct batadv_hard_iface;
-struct batadv_priv;
 struct sk_buff;
 
 int batadv_v_ogm_init(struct batadv_priv *bat_priv);
-- 
2.8.1

