Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Mon, 20 Jun 2011 20:55:28 +0200
Message-Id: <1308596128-8962-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid TQ monotonicity violation
	that can cause loops
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

This patch avoids the broadcast of TQ greater than the average TQ of
the current best neighbour. This behaviour could cause loops due to
the violation of routing metric monotonicity property.

The TQ value for non-received OGM is not set to 0, instead it is set to
the average TQ calculated on the global TQ window using 0 as last TQ
only for computation.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 routing.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/routing.c b/routing.c
index 0ce090c..1487bd3 100644
--- a/routing.c
+++ b/routing.c
@@ -408,8 +408,14 @@ static void update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			continue;
 
 		spin_lock_bh(&tmp_neigh_node->tq_lock);
+		/* set last tq to 0 only for computing average */
 		ring_buffer_set(tmp_neigh_node->tq_recv,
 				&tmp_neigh_node->tq_index, 0);
+		/* set last tq to tq_global_window avg */
+		ring_buffer_set(tmp_neigh_node->tq_recv,
+				&tmp_neigh_node->tq_index, 
+				ring_buffer_avg(tmp_neigh_node->tq_recv));
+		/* update tq_avg for this neighbour */
 		tmp_neigh_node->tq_avg =
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 		spin_unlock_bh(&tmp_neigh_node->tq_lock);
-- 
1.7.1

