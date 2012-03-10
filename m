Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Mar 2012 06:44:49 +0800
Message-Id: <1331419491-21333-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331419491-21333-1-git-send-email-lindner_marek@yahoo.de>
References: <1331419491-21333-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Don't begin block comments
	with only a /* line
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/bat_iv_ogm.c |    3 +--
 net/batman-adv/main.h       |   13 ++-----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 677997b..a6d5d63 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -779,8 +779,7 @@ static int bat_iv_ogm_calc_tq(struct orig_node *orig_node,
 		 * information */
 		tq_own = (TQ_MAX_VALUE * total_count) /	neigh_rq_count;
 
-	/*
-	 * 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
+	/* 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
 	 * affect the nearly-symmetric links only a little, but
 	 * punishes asymmetric links more.  This will give a value
 	 * between 0 and TQ_MAX_VALUE
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 1468788..94fa1c2 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -107,9 +107,7 @@ enum uev_type {
 
 #define GW_THRESHOLD	50
 
-/*
- * Debug Messages
- */
+/* Debug Messages */
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
@@ -124,14 +122,7 @@ enum dbg_level {
 	DBG_ALL    = 7
 };
 
-
-/*
- *  Vis
- */
-
-/*
- * Kernel headers
- */
+/* Kernel headers */
 
 #include <linux/mutex.h>	/* mutex */
 #include <linux/module.h>	/* needed by all modules */
-- 
1.7.9.1

