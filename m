Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  1 Sep 2014 14:37:29 +0200
Message-Id: <1409575049-32726-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
References: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: checkpatch - remove
	unnecessary parentheses
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 4dd7c40..00e00e0 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -878,7 +878,7 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
-			word = &(orig_node->bat_iv.bcast_own[word_index]);
+			word = &orig_node->bat_iv.bcast_own[word_index];
 
 			batadv_bit_get_packet(bat_priv, word, 1, 0);
 			if_num = hard_iface->if_num;
@@ -1663,7 +1663,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 			offset = if_num * BATADV_NUM_WORDS;
 
 			spin_lock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
-			word = &(orig_neigh_node->bat_iv.bcast_own[offset]);
+			word = &orig_neigh_node->bat_iv.bcast_own[offset];
 			bit_pos = if_incoming_seqno - 2;
 			bit_pos -= ntohl(ogm_packet->seqno);
 			batadv_set_bit(word, bit_pos);
-- 
1.8.5.5

