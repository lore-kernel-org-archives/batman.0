Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 30 May 2011 09:22:46 +0200
Message-Id: <1306740182-2665-2-git-send-email-sven@narfation.org>
In-Reply-To: <1306740182-2665-1-git-send-email-sven@narfation.org>
References: <1306740182-2665-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/17] batman-adv: move
	neigh_node->if_incoming->if_status check in find_router()
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

From: Antonio Quartulli <ordex@autistici.org>

Every time that find_router() is invoked, if_status has to be compared with
IF_ACTIVE. Moving this comparison inside find_router() will avoid to write it
each time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c |    3 +++
 net/batman-adv/unicast.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bb1c3ec..8c403ce 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1240,6 +1240,9 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		router = find_ifalter_router(primary_orig_node, recv_if);
 
 return_router:
+	if (router && router->if_incoming->if_status != IF_ACTIVE)
+		goto err_unlock;
+
 	rcu_read_unlock();
 	return router;
 err_unlock:
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 19c3daf..bab6076 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -314,9 +314,6 @@ find_router:
 	if (!neigh_node)
 		goto out;
 
-	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
-		goto out;
-
 	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto out;
 
-- 
1.7.5.3

