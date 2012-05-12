Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:35 +0200
Message-Id: <1336781383-15649-15-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 15/23] batman-adv: Prefix ring_buffer
	non-static functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c  |   14 +++++++-------
 ring_buffer.c |    5 +++--
 ring_buffer.h |    5 +++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8589014..9afbe17 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -642,10 +642,10 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 			continue;
 
 		spin_lock_bh(&tmp_neigh_node->lq_update_lock);
-		ring_buffer_set(tmp_neigh_node->tq_recv,
-				&tmp_neigh_node->tq_index, 0);
+		batadv_ring_buffer_set(tmp_neigh_node->tq_recv,
+				       &tmp_neigh_node->tq_index, 0);
 		tmp_neigh_node->tq_avg =
-			ring_buffer_avg(tmp_neigh_node->tq_recv);
+			batadv_ring_buffer_avg(tmp_neigh_node->tq_recv);
 		spin_unlock_bh(&tmp_neigh_node->lq_update_lock);
 	}
 
@@ -673,10 +673,10 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 	neigh_node->last_seen = jiffies;
 
 	spin_lock_bh(&neigh_node->lq_update_lock);
-	ring_buffer_set(neigh_node->tq_recv,
-			&neigh_node->tq_index,
-			batman_ogm_packet->tq);
-	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
+	batadv_ring_buffer_set(neigh_node->tq_recv,
+			       &neigh_node->tq_index,
+			       batman_ogm_packet->tq);
+	neigh_node->tq_avg = batadv_ring_buffer_avg(neigh_node->tq_recv);
 	spin_unlock_bh(&neigh_node->lq_update_lock);
 
 	if (!is_duplicate) {
diff --git a/ring_buffer.c b/ring_buffer.c
index fd63951..db8f5ef 100644
--- a/ring_buffer.c
+++ b/ring_buffer.c
@@ -22,13 +22,14 @@
 #include "main.h"
 #include "ring_buffer.h"
 
-void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value)
+void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
+			    uint8_t value)
 {
 	lq_recv[*lq_index] = value;
 	*lq_index = (*lq_index + 1) % TQ_GLOBAL_WINDOW_SIZE;
 }
 
-uint8_t ring_buffer_avg(const uint8_t lq_recv[])
+uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 {
 	const uint8_t *ptr;
 	uint16_t count = 0, i = 0, sum = 0;
diff --git a/ring_buffer.h b/ring_buffer.h
index 8b58bd8..fbaf9d2 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -22,7 +22,8 @@
 #ifndef _NET_BATMAN_ADV_RING_BUFFER_H_
 #define _NET_BATMAN_ADV_RING_BUFFER_H_
 
-void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value);
-uint8_t ring_buffer_avg(const uint8_t lq_recv[]);
+void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
+			    uint8_t value);
+uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[]);
 
 #endif /* _NET_BATMAN_ADV_RING_BUFFER_H_ */
-- 
1.7.10

