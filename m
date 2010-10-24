Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 24 Oct 2010 21:58:17 +0200
Message-Id: <1287950297-7983-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix crash on mesh cleanup in
	bridge loop avoidance code
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/soft-interface.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index a13276b..5ae26e8 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -114,7 +114,6 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
 		hlist_del_rcu(&softif_neigh->list);
 
 		if (bat_priv->softif_neigh == softif_neigh) {
-			bat_priv->softif_neigh = NULL;
 			bat_dbg(DBG_ROUTES, bat_priv,
 				 "Current mesh exit point '%pM' vanished "
 				 "(vid: %d).\n",
-- 
1.7.1

