Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:12 +0100
Message-Id: <1420730120-9844-8-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 07/15] batman-adv: checkpatch - else is not
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bitarray.h          | 3 +--
 net/batman-adv/fragmentation.h     | 3 +--
 net/batman-adv/network-coding.c    | 3 +--
 net/batman-adv/translation-table.c | 5 ++---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index cc24073..2acaafe 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -29,8 +29,7 @@ static inline int batadv_test_bit(const unsigned long *seq_bits,
 	diff = last_seqno - curr_seqno;
 	if (diff < 0 || diff >= BATADV_TQ_LOCAL_WINDOW_SIZE)
 		return 0;
-	else
-		return test_bit(diff, seq_bits) != 0;
+	return test_bit(diff, seq_bits) != 0;
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 5d7a0e6..d848cf6 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -41,8 +41,7 @@ batadv_frag_check_entry(struct batadv_frag_table_entry *frags_entry)
 	if (!hlist_empty(&frags_entry->head) &&
 	    batadv_has_timed_out(frags_entry->timestamp, BATADV_FRAG_TIMEOUT))
 		return true;
-	else
-		return false;
+	return false;
 }
 
 #endif /* _NET_BATMAN_ADV_FRAGMENTATION_H_ */
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index fab47f1..127cc4d 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1212,8 +1212,7 @@ static bool batadv_nc_skb_coding_possible(struct sk_buff *skb,
 {
 	if (BATADV_SKB_CB(skb)->decoded && !batadv_compare_eth(dst, src))
 		return false;
-	else
-		return true;
+	return true;
 }
 
 /**
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f59e7f..38a804e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
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
2.2.1

