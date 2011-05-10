Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2011 11:22:36 +0200
Message-Id: <1305019357-27050-2-git-send-email-sven@narfation.org>
In-Reply-To: <1305019357-27050-1-git-send-email-sven@narfation.org>
References: <1305019357-27050-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unreachable code from
	gw_election
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

One of the first actions of gw_election is to check whether curr_gw is
not NULL. In that case it will jumps to out. The rest of the code
(before out) can now assume that gw_node is NULL. Therefore the router
is only changed when curr_gw_tmp. This makes some printks in this block
unnecessary which handle the case that curr_gw_tmp is NULL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateway_client.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 65f3953..939fbfd 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -185,29 +185,15 @@ void gw_election(struct bat_priv *bat_priv)
 		neigh_node_free_ref(router);
 	}
 
-	if (curr_gw != curr_gw_tmp) {
+	if (curr_gw_tmp) {
 		router = orig_node_get_router(curr_gw_tmp->orig_node);
 		if (!router)
 			goto unlock;
 
-		if ((curr_gw) && (!curr_gw_tmp))
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Removing selected gateway - "
-				"no gateway in range\n");
-		else if ((!curr_gw) && (curr_gw_tmp))
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Adding route to gateway %pM "
-				"(gw_flags: %i, tq: %i)\n",
-				curr_gw_tmp->orig_node->orig,
-				curr_gw_tmp->orig_node->gw_flags,
-				router->tq_avg);
-		else
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Changing route to gateway %pM "
-				"(gw_flags: %i, tq: %i)\n",
-				curr_gw_tmp->orig_node->orig,
-				curr_gw_tmp->orig_node->gw_flags,
-				router->tq_avg);
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
+			curr_gw_tmp->orig_node->orig,
+			curr_gw_tmp->orig_node->gw_flags, router->tq_avg);
 
 		neigh_node_free_ref(router);
 		gw_select(bat_priv, curr_gw_tmp);
-- 
1.7.5.1

