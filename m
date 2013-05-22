Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 22 May 2013 20:46:17 +0200
Message-Id: <1369248377-16466-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: forward late OGMs from best next
	hop
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

From: Simon Wunderlich <simon@open-mesh.com>

When a packet is received from another node first and later from the
best next hop, this packet is dropped. However the first OGM was sent
with the BATADV_NOT_BEST_NEXT_HOP flag and thus dropped by neighbors.
The late OGM from the best neighbor is then dropped because it is a
duplicate.

If this situation happens constantly, a node might end up not forwarding
the "valid" OGMs anymore, and nodes behind will starve from not getting
valid OGMs.

Fix this by changing the is_duplicate behaviour: It will only mark
duplicates which are received for the same neighbor. OGMs which are not
from the best next hop will be dropped within batadv_iv_ogm_forward()
anyway. Therefore, late OGMs are forwarded now and not dropped as
duplicates.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8d87f87..bcd2527 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -948,7 +948,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *tmp_neigh_node;
-	int is_duplicate = 0;
+	int is_dup = 0;
 	int32_t seq_diff;
 	int need_update = 0;
 	int set_mark, ret = -1;
@@ -972,16 +972,16 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node,
 				 &orig_node->neigh_list, list) {
-		is_duplicate |= batadv_test_bit(tmp_neigh_node->real_bits,
-						orig_node->last_real_seqno,
-						seqno);
-
 		neigh_addr = tmp_neigh_node->addr;
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
-		    tmp_neigh_node->if_incoming == if_incoming)
+		    tmp_neigh_node->if_incoming == if_incoming) {
+			is_dup |= batadv_test_bit(tmp_neigh_node->real_bits,
+						  orig_node->last_real_seqno,
+						  seqno);
 			set_mark = 1;
-		else
+		} else {
 			set_mark = 0;
+		}
 
 		/* if the window moved, set the update flag. */
 		need_update |= batadv_bit_get_packet(bat_priv,
@@ -1001,7 +1001,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		orig_node->last_real_seqno = seqno;
 	}
 
-	ret = is_duplicate;
+	ret = is_dup;
 
 out:
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
-- 
1.7.10.4

