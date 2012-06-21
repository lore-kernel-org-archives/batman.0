Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 21 Jun 2012 18:57:37 +0200
Message-Id: <1340297876-29923-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1340297876-29923-1-git-send-email-ordex@autistici.org>
References: <1340297876-29923-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/20] batman-adv: Prefix bat_algo non-static
	functions with batadv_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_algo.h   |    2 +-
 net/batman-adv/bat_iv_ogm.c |    2 +-
 net/batman-adv/main.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 9852a68..a14336a 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -22,6 +22,6 @@
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
 #define _NET_BATMAN_ADV_BAT_ALGO_H_
 
-int bat_iv_init(void);
+int batadv_iv_init(void);
 
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6e0859f..b445739 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1248,7 +1248,7 @@ static struct bat_algo_ops batman_iv __read_mostly = {
 	.bat_ogm_emit = bat_iv_ogm_emit,
 };
 
-int __init bat_iv_init(void)
+int __init batadv_iv_init(void)
 {
 	int ret;
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 46ba302..1f064d4 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -56,7 +56,7 @@ static int __init batman_init(void)
 
 	recv_handler_init();
 
-	bat_iv_init();
+	batadv_iv_init();
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
-- 
1.7.9.4

