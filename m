Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 30 May 2011 09:23:02 +0200
Message-Id: <1306740182-2665-18-git-send-email-sven@narfation.org>
In-Reply-To: <1306740182-2665-1-git-send-email-sven@narfation.org>
References: <1306740182-2665-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 17/17] batman-adv: Ensure that we really have
	route changes in update_route
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

The debug output of update_route has tests for "route deleted" and "route
added". All other situations are handled as "route changed". This is not
true because neigh_node and curr_router could be both NULL.

The function is not called in this situation, but the code might be
interpreted wrong when reading it without this test.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 90ae6f0..368ceeb 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -108,7 +108,7 @@ static void update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
 				    tt_buff, tt_buff_len);
 
 	/* route changed */
-	} else {
+	} else if (neigh_node && curr_router) {
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Changing route towards: %pM "
 			"(now via %pM - was via %pM)\n",
-- 
1.7.5.3

