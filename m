Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:29 +0100
Message-Id: <1299328122-21468-16-git-send-email-sven@narfation.org>
In-Reply-To: <1299328122-21468-1-git-send-email-sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 15/28] batman-adv: protect bit operations to
	count OGMs with spinlock
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Linus Lüssing <linus.luessing@saxnet.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/routing.c |   61 ++++++++++++++++++++++-----------------------
 net/batman-adv/types.h   |    6 ++--
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 9185666..29a689a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -155,7 +155,8 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct hlist_node *node;
 	unsigned char total_count;
-	int ret = 0;
+	uint8_t orig_eq_count, neigh_rq_count, tq_own;
+	int tq_asym_penalty, ret = 0;
 
 	if (orig_node == orig_neigh_node) {
 		rcu_read_lock();
@@ -216,23 +217,25 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 
 	orig_node->last_valid = jiffies;
 
+	spin_lock_bh(&orig_node->ogm_cnt_lock);
+	orig_eq_count = orig_neigh_node->bcast_own_sum[if_incoming->if_num];
+	neigh_rq_count = neigh_node->real_packet_count;
+	spin_unlock_bh(&orig_node->ogm_cnt_lock);
+
 	/* pay attention to not get a value bigger than 100 % */
-	total_count = (orig_neigh_node->bcast_own_sum[if_incoming->if_num] >
-		       neigh_node->real_packet_count ?
-		       neigh_node->real_packet_count :
-		       orig_neigh_node->bcast_own_sum[if_incoming->if_num]);
+	total_count = (orig_eq_count > neigh_rq_count ?
+		       neigh_rq_count : orig_eq_count);
 
 	/* if we have too few packets (too less data) we set tq_own to zero */
 	/* if we receive too few packets it is not considered bidirectional */
 	if ((total_count < TQ_LOCAL_BIDRECT_SEND_MINIMUM) ||
-	    (neigh_node->real_packet_count < TQ_LOCAL_BIDRECT_RECV_MINIMUM))
-		orig_neigh_node->tq_own = 0;
+	    (neigh_rq_count < TQ_LOCAL_BIDRECT_RECV_MINIMUM))
+		tq_own = 0;
 	else
 		/* neigh_node->real_packet_count is never zero as we
 		 * only purge old information when getting new
 		 * information */
-		orig_neigh_node->tq_own = (TQ_MAX_VALUE * total_count) /
-			neigh_node->real_packet_count;
+		tq_own = (TQ_MAX_VALUE * total_count) /	neigh_rq_count;
 
 	/*
 	 * 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
@@ -240,20 +243,16 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	 * punishes asymmetric links more.  This will give a value
 	 * between 0 and TQ_MAX_VALUE
 	 */
-	orig_neigh_node->tq_asym_penalty =
-		TQ_MAX_VALUE -
-		(TQ_MAX_VALUE *
-		 (TQ_LOCAL_WINDOW_SIZE - neigh_node->real_packet_count) *
-		 (TQ_LOCAL_WINDOW_SIZE - neigh_node->real_packet_count) *
-		 (TQ_LOCAL_WINDOW_SIZE - neigh_node->real_packet_count)) /
-		(TQ_LOCAL_WINDOW_SIZE *
-		 TQ_LOCAL_WINDOW_SIZE *
-		 TQ_LOCAL_WINDOW_SIZE);
-
-	batman_packet->tq = ((batman_packet->tq *
-			      orig_neigh_node->tq_own *
-			      orig_neigh_node->tq_asym_penalty) /
-			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
+	tq_asym_penalty = TQ_MAX_VALUE - (TQ_MAX_VALUE *
+				(TQ_LOCAL_WINDOW_SIZE - neigh_rq_count) *
+				(TQ_LOCAL_WINDOW_SIZE - neigh_rq_count) *
+				(TQ_LOCAL_WINDOW_SIZE - neigh_rq_count)) /
+					(TQ_LOCAL_WINDOW_SIZE *
+					 TQ_LOCAL_WINDOW_SIZE *
+					 TQ_LOCAL_WINDOW_SIZE);
+
+	batman_packet->tq = ((batman_packet->tq * tq_own * tq_asym_penalty) /
+						(TQ_MAX_VALUE * TQ_MAX_VALUE));
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"bidirectional: "
@@ -261,8 +260,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		"real recv = %2i, local tq: %3i, asym_penalty: %3i, "
 		"total tq: %3i\n",
 		orig_node->orig, orig_neigh_node->orig, total_count,
-		neigh_node->real_packet_count, orig_neigh_node->tq_own,
-		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
+		neigh_rq_count, tq_own,	tq_asym_penalty, batman_packet->tq);
 
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional */
@@ -559,18 +557,19 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	char is_duplicate = 0;
 	int32_t seq_diff;
 	int need_update = 0;
-	int set_mark;
+	int set_mark, ret = -1;
 
 	orig_node = get_orig_node(bat_priv, batman_packet->orig);
 	if (!orig_node)
 		return 0;
 
+	spin_lock_bh(&orig_node->ogm_cnt_lock);
 	seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->batman_seqno_reset))
-		goto err;
+		goto out;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
@@ -603,12 +602,12 @@ static char count_real_packets(struct ethhdr *ethhdr,
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
 
-	kref_put(&orig_node->refcount, orig_node_free_ref);
-	return is_duplicate;
+	ret = is_duplicate;
 
-err:
+out:
+	spin_unlock_bh(&orig_node->ogm_cnt_lock);
 	kref_put(&orig_node->refcount, orig_node_free_ref);
-	return -1;
+	return ret;
 }
 
 void receive_bat_packet(struct ethhdr *ethhdr,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e0140c6..9a14276 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -70,8 +70,6 @@ struct orig_node {
 	struct neigh_node *router;
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
-	uint8_t tq_own;
-	int tq_asym_penalty;
 	unsigned long last_valid;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
@@ -89,7 +87,9 @@ struct orig_node {
 	struct kref refcount;
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
-	spinlock_t ogm_cnt_lock; /* protects ogm counter */
+	spinlock_t ogm_cnt_lock; /* protects: bcast_own, bcast_own_sum,
+				  * neigh_node->real_bits,
+				  * neigh_node->real_packet_count */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
-- 
1.7.2.3

