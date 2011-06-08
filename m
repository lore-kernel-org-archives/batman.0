Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  8 Jun 2011 22:59:33 +0200
Message-Id: <1307566773-19872-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix line over 80 characters
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

Regression was introduced in 4d30670880c84071dba4b220f595e64d6c01d1ba.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/routing.c b/routing.c
index 5e99188..7f458e9 100644
--- a/routing.c
+++ b/routing.c
@@ -728,7 +728,8 @@ void receive_bat_packet(const struct ethhdr *ethhdr,
 
 			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 			word = &(orig_neigh_node->bcast_own[offset]);
-			bit_mark(word, if_incoming_seqno - batman_packet->seqno - 2);
+			bit_mark(word,
+				 if_incoming_seqno - batman_packet->seqno - 2);
 			orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
 				bit_packet_count(word);
 			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
-- 
1.7.5.3

