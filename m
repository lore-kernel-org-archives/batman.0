Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Mar 2012 09:07:46 +0100
Message-Id: <1331107673-8986-2-git-send-email-sven@narfation.org>
In-Reply-To: <1331107673-8986-1-git-send-email-sven@narfation.org>
References: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
	<1331107673-8986-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/8-next] batman-adv: Don't begin block
	comments with only a /* line
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
 bat_iv_ogm.c |    3 +--
 main.h       |   13 ++-----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 677997b..a6d5d63 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -779,8 +779,7 @@ static int bat_iv_ogm_calc_tq(struct orig_node *orig_node,
 		 * information */
 		tq_own = (TQ_MAX_VALUE * total_count) /	neigh_rq_count;
 
-	/*
-	 * 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
+	/* 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
 	 * affect the nearly-symmetric links only a little, but
 	 * punishes asymmetric links more.  This will give a value
 	 * between 0 and TQ_MAX_VALUE
diff --git a/main.h b/main.h
index 3b727dd..95cb2af 100644
--- a/main.h
+++ b/main.h
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

