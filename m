Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  8 May 2011 20:52:57 +0200
Message-Id: <1304880777-19702-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1304583702-23969-1-git-send-email-ordex@autistici.org>
References: <1304583702-23969-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: move
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Every time that find_router() is invoked, if_status has to be compared with
IF_ACTIVE. Moving this comparison inside find_router() will avoid to write it
each time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
In this version the reference counting of 'router' has been corrected.

 routing.c |    3 +++
 unicast.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/routing.c b/routing.c
index bb1c3ec..8c403ce 100644
--- a/routing.c
+++ b/routing.c
@@ -1240,6 +1240,9 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		router = find_ifalter_router(primary_orig_node, recv_if);
 
 return_router:
+	if (router && router->if_incoming->if_status != IF_ACTIVE)
+		goto err_unlock;
+
 	rcu_read_unlock();
 	return router;
 err_unlock:
diff --git a/unicast.c b/unicast.c
index 19c3daf..bab6076 100644
--- a/unicast.c
+++ b/unicast.c
@@ -314,9 +314,6 @@ find_router:
 	if (!neigh_node)
 		goto out;
 
-	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
-		goto out;
-
 	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto out;
 
-- 
1.7.3.4

