Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2011 11:22:37 +0200
Message-Id: <1305019357-27050-3-git-send-email-sven@narfation.org>
In-Reply-To: <1305019357-27050-1-git-send-email-sven@narfation.org>
References: <1305019357-27050-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Ensure that we really have
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
To: b.a.t.m.a.n@lists.open-mesh.org

The debug output of update_route has tests for "route deleted" and "route
added". All other situations are handled as "route changed". This is not
true because neigh_node and curr_router could be both NULL.

The function is not called in this situation, but the code might be
interpreted wrong when reading it without this test.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/routing.c b/routing.c
index 8c403ce..3f8355c 100644
--- a/routing.c
+++ b/routing.c
@@ -109,7 +109,7 @@ static void update_route(struct bat_priv *bat_priv,
 				    tt_buff, tt_buff_len);
 
 	/* route changed */
-	} else {
+	} else if (neigh_node && curr_router) {
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Changing route towards: %pM "
 			"(now via %pM - was via %pM)\n",
-- 
1.7.5.1

