Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  1 Sep 2014 14:37:25 +0200
Message-Id: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: checkpatch - else is not
	generally useful after a break or return
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
 bitarray.h          | 3 +--
 fragmentation.h     | 3 +--
 network-coding.c    | 3 +--
 translation-table.c | 5 ++---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/bitarray.h b/bitarray.h
index cc24073..2acaafe 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -29,8 +29,7 @@ static inline int batadv_test_bit(const unsigned long *seq_bits,
 	diff = last_seqno - curr_seqno;
 	if (diff < 0 || diff >= BATADV_TQ_LOCAL_WINDOW_SIZE)
 		return 0;
-	else
-		return test_bit(diff, seq_bits) != 0;
+	return test_bit(diff, seq_bits) != 0;
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
diff --git a/fragmentation.h b/fragmentation.h
index 5d7a0e6..d848cf6 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -41,8 +41,7 @@ batadv_frag_check_entry(struct batadv_frag_table_entry *frags_entry)
 	if (!hlist_empty(&frags_entry->head) &&
 	    batadv_has_timed_out(frags_entry->timestamp, BATADV_FRAG_TIMEOUT))
 		return true;
-	else
-		return false;
+	return false;
 }
 
 #endif /* _NET_BATMAN_ADV_FRAGMENTATION_H_ */
diff --git a/network-coding.c b/network-coding.c
index 8d04d17..bd33894 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1212,8 +1212,7 @@ static bool batadv_nc_skb_coding_possible(struct sk_buff *skb,
 {
 	if (BATADV_SKB_CB(skb)->decoded && !batadv_compare_eth(dst, src))
 		return false;
-	else
-		return true;
+	return true;
 }
 
 /**
diff --git a/translation-table.c b/translation-table.c
index 5f59e7f..38a804e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2769,9 +2769,8 @@ static bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 {
 	if (batadv_is_my_mac(bat_priv, req_dst))
 		return batadv_send_my_tt_response(bat_priv, tt_data, req_src);
-	else
-		return batadv_send_other_tt_response(bat_priv, tt_data,
-						     req_src, req_dst);
+	return batadv_send_other_tt_response(bat_priv, tt_data, req_src,
+					     req_dst);
 }
 
 static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
-- 
1.8.5.5

