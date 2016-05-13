Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 May 2016 18:47:48 +0200
Message-Id: <1463158069-966-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Include main.h in all files
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

main.h includes statements which (re)define preprocessor variables which
influence the compiled code. This makes it necessary to include it in all
files. For example, it redefines pr_fmt used to the module as prefix for
each pr_* message.

Reported-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_algo.h  | 2 +-
 net/batman-adv/bat_v_ogm.h | 4 ++--
 net/batman-adv/netlink.h   | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 03dafd3..b727762 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -18,7 +18,7 @@
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
 #define _NET_BATMAN_ADV_BAT_ALGO_H_
 
-struct batadv_priv;
+#include "main.h"
 
 int batadv_iv_init(void);
 
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
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index fa152a8..39044cc 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -18,6 +18,8 @@
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
 #define _NET_BATMAN_ADV_NETLINK_H_
 
+#include "main.h"
+
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 
-- 
2.8.1

