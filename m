Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Tue,  7 Jun 2011 00:45:55 +0200
Message-Id: <1307400355-11624-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark as received also old
	rebroadcast
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

This patch avoid local TQ drop in case of heavy load. In this case,
rebroadcast can be delayed more than orig_interval causing the receiver
to incorrectly drop old packets without marking them as received.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 routing.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/routing.c b/routing.c
index c620d4f..5e99188 100644
--- a/routing.c
+++ b/routing.c
@@ -720,17 +720,15 @@ void receive_bat_packet(const struct ethhdr *ethhdr,
 
 		/* neighbor has to indicate direct link and it has to
 		 * come via the corresponding interface */
-		/* if received seqno equals last send seqno save new
-		 * seqno for bidirectional check */
+		/* save packet seqno for bidirectional check */
 		if (has_directlink_flag &&
 		    compare_eth(if_incoming->net_dev->dev_addr,
-				batman_packet->orig) &&
-		    (batman_packet->seqno - if_incoming_seqno + 2 == 0)) {
+				batman_packet->orig)) {
 			offset = if_incoming->if_num * NUM_WORDS;
 
 			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 			word = &(orig_neigh_node->bcast_own[offset]);
-			bit_mark(word, 0);
+			bit_mark(word, if_incoming_seqno - batman_packet->seqno - 2);
 			orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
 				bit_packet_count(word);
 			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
-- 
1.7.1

