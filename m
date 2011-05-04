Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 21:14:58 +0200
Message-Id: <1304536498-22584-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix rcu_lock imbalance in
	softif_neigh_get
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

Fix extra rcu_read_unlock after an failed softif_neigh_vid_get in
softif_neigh_get introduced by 0281a6aab718965d7c0ef45c4ba22e305f6aefe7

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 1827734..8023c4e 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -175,12 +175,12 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
 			continue;
 
 		softif_neigh->last_seen = jiffies;
-		goto out;
+		goto unlock;
 	}
 
 	softif_neigh = kzalloc(sizeof(struct softif_neigh), GFP_ATOMIC);
 	if (!softif_neigh)
-		goto out;
+		goto unlock;
 
 	memcpy(softif_neigh->addr, addr, ETH_ALEN);
 	softif_neigh->last_seen = jiffies;
@@ -193,8 +193,9 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
 			   &softif_neigh_vid->softif_neigh_list);
 	spin_unlock_bh(&bat_priv->softif_neigh_lock);
 
-out:
+unlock:
 	rcu_read_unlock();
+out:
 	if (softif_neigh_vid)
 		softif_neigh_vid_free_ref(softif_neigh_vid);
 	return softif_neigh;
-- 
1.7.4.4

