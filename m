Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Dec 2013 16:35:13 +0100
Message-Id: <1387294513-12541-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix NULL pointer deref in
	batadv_find_best_neighbor
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

If there is no best neighbor, don't dereference the NULL pointer.

Introduced by 9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv:
split tq information in neigh_node struct")

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 originator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/originator.c b/originator.c
index 2243003..9fcde58 100644
--- a/originator.c
+++ b/originator.c
@@ -789,7 +789,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 					best, if_outgoing) <= 0))
 			best = neigh;
 
-	if (!atomic_inc_not_zero(&best->refcount))
+	if (best && !atomic_inc_not_zero(&best->refcount))
 		best = NULL;
 	rcu_read_unlock();
 
-- 
1.7.10.4

