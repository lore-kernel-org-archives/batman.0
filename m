Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:27 +0200
Message-Id: <1340876067-28333-19-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 18/18] batman-adv: Prefix main defines with
	BATADV_
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_debugfs.c           |    2 +-
 net/batman-adv/bat_iv_ogm.c            |  101 +++++++++++++++++++-------------
 net/batman-adv/bat_sysfs.c             |    7 ++-
 net/batman-adv/bitarray.c              |   20 +++----
 net/batman-adv/bitarray.h              |    4 +-
 net/batman-adv/bridge_loop_avoidance.c |   20 ++++---
 net/batman-adv/gateway_client.c        |   18 +++---
 net/batman-adv/hard-interface.c        |    2 +-
 net/batman-adv/main.c                  |   13 ++--
 net/batman-adv/main.h                  |   81 ++++++++++++-------------
 net/batman-adv/originator.c            |   32 +++++-----
 net/batman-adv/ring_buffer.c           |    4 +-
 net/batman-adv/routing.c               |   20 ++++---
 net/batman-adv/soft-interface.c        |   10 ++--
 net/batman-adv/translation-table.c     |   89 ++++++++++++++++------------
 net/batman-adv/types.h                 |   10 ++--
 net/batman-adv/unicast.c               |    2 +-
 net/batman-adv/vis.c                   |   11 ++--
 18 files changed, 244 insertions(+), 202 deletions(-)

diff --git a/net/batman-adv/bat_debugfs.c b/net/batman-adv/bat_debugfs.c
index f9af65e..4dcda43 100644
--- a/net/batman-adv/bat_debugfs.c
+++ b/net/batman-adv/bat_debugfs.c
@@ -38,7 +38,7 @@ static struct dentry *batadv_debugfs;
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
 #define BATADV_LOG_BUFF(idx) (debug_log->log_buff[(idx) & BATADV_LOG_BUFF_MASK])
 
-static int batadv_log_buff_len = LOG_BUF_LEN;
+static int batadv_log_buff_len = BATADV_LOG_BUF_LEN;
 
 static void batadv_emit_log_char(struct debug_log *debug_log, char c)
 {
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 245bb2d..bbe0f12 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -74,8 +74,8 @@ static int batadv_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 	batman_ogm_packet->header.packet_type = BAT_IV_OGM;
 	batman_ogm_packet->header.version = BATADV_COMPAT_VERSION;
 	batman_ogm_packet->header.ttl = 2;
-	batman_ogm_packet->flags = NO_FLAGS;
-	batman_ogm_packet->tq = TQ_MAX_VALUE;
+	batman_ogm_packet->flags = BATADV_NO_FLAGS;
+	batman_ogm_packet->tq = BATADV_TQ_MAX_VALUE;
 	batman_ogm_packet->tt_num_changes = 0;
 	batman_ogm_packet->ttvn = 0;
 
@@ -108,29 +108,37 @@ static void batadv_iv_ogm_primary_iface_set(struct hard_iface *hard_iface)
 
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
 	batman_ogm_packet->flags = PRIMARIES_FIRST_HOP;
-	batman_ogm_packet->header.ttl = TTL;
+	batman_ogm_packet->header.ttl = BATADV_TTL;
 }
 
 /* when do we schedule our own ogm to be sent */
 static unsigned long
 batadv_iv_ogm_emit_send_time(const struct bat_priv *bat_priv)
 {
-	return jiffies + msecs_to_jiffies(
-		   atomic_read(&bat_priv->orig_interval) -
-		   JITTER + (random32() % 2*JITTER));
+	unsigned int msecs;
+
+	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
+	msecs += (random32() % 2 * BATADV_JITTER);
+
+	return jiffies + msecs_to_jiffies(msecs);
 }
 
 /* when do we schedule a ogm packet to be sent */
 static unsigned long batadv_iv_ogm_fwd_send_time(void)
 {
-	return jiffies + msecs_to_jiffies(random32() % (JITTER/2));
+	return jiffies + msecs_to_jiffies(random32() % (BATADV_JITTER / 2));
 }
 
 /* apply hop penalty for a normal link */
 static uint8_t batadv_hop_penalty(uint8_t tq, const struct bat_priv *bat_priv)
 {
 	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
-	return (tq * (TQ_MAX_VALUE - hop_penalty)) / (TQ_MAX_VALUE);
+	int new_tq;
+
+	new_tq = tq * (BATADV_TQ_MAX_VALUE - hop_penalty);
+	new_tq /= BATADV_TQ_MAX_VALUE;
+
+	return new_tq;
 }
 
 /* is there another aggregated packet here? */
@@ -143,7 +151,7 @@ static int batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	next_buff_pos += batadv_tt_len(tt_num_changes);
 
 	return (next_buff_pos <= packet_len) &&
-		(next_buff_pos <= MAX_AGGREGATION_BYTES);
+	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
 }
 
 /* send a batman ogm to a given interface */
@@ -290,8 +298,11 @@ batadv_iv_ogm_can_aggregate(const struct batman_ogm_packet *new_bat_ogm_packet,
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct hard_iface *primary_if = NULL;
 	bool res = false;
+	unsigned long aggregation_end_time;
 
 	batman_ogm_packet = (struct batman_ogm_packet *)forw_packet->skb->data;
+	aggregation_end_time = send_time;
+	aggregation_end_time += msecs_to_jiffies(BATADV_MAX_AGGREGATION_MS);
 
 	/* we can aggregate the current packet to this aggregated packet
 	 * if:
@@ -301,9 +312,8 @@ batadv_iv_ogm_can_aggregate(const struct batman_ogm_packet *new_bat_ogm_packet,
 	 *   MAX_AGGREGATION_BYTES
 	 */
 	if (time_before(send_time, forw_packet->send_time) &&
-	    time_after_eq(send_time + msecs_to_jiffies(MAX_AGGREGATION_MS),
-					forw_packet->send_time) &&
-	    (aggregated_bytes <= MAX_AGGREGATION_BYTES)) {
+	    time_after_eq(aggregation_end_time, forw_packet->send_time) &&
+	    (aggregated_bytes <= BATADV_MAX_AGGREGATION_BYTES)) {
 
 		/* check aggregation compatibility
 		 * -> direct link packets are broadcasted on
@@ -367,6 +377,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct forw_packet *forw_packet_aggr;
 	unsigned char *skb_buff;
+	unsigned int skb_size;
 
 	if (!atomic_inc_not_zero(&if_incoming->refcount))
 		return;
@@ -388,12 +399,12 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	}
 
 	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
-	    (packet_len < MAX_AGGREGATION_BYTES))
-		forw_packet_aggr->skb = dev_alloc_skb(MAX_AGGREGATION_BYTES +
-						      ETH_HLEN);
+	    (packet_len < BATADV_MAX_AGGREGATION_BYTES))
+		skb_size = BATADV_MAX_AGGREGATION_BYTES + ETH_HLEN;
 	else
-		forw_packet_aggr->skb = dev_alloc_skb(packet_len + ETH_HLEN);
+		skb_size = packet_len + ETH_HLEN;
 
+	forw_packet_aggr->skb = dev_alloc_skb(skb_size);
 	if (!forw_packet_aggr->skb) {
 		if (!own_packet)
 			atomic_inc(&bat_priv->batman_queue_left);
@@ -411,7 +422,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
 	forw_packet_aggr->num_packets = 0;
-	forw_packet_aggr->direct_link_flags = NO_FLAGS;
+	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
 
 	/* save packet direct link flag status */
@@ -466,9 +477,11 @@ static void batadv_iv_ogm_queue_add(struct bat_priv *bat_priv,
 	struct hlist_node *tmp_node;
 	struct batman_ogm_packet *batman_ogm_packet;
 	bool direct_link;
+	unsigned long max_aggregation_jiffies;
 
 	batman_ogm_packet = (struct batman_ogm_packet *)packet_buff;
 	direct_link = batman_ogm_packet->flags & DIRECTLINK ? 1 : 0;
+	max_aggregation_jiffies = msecs_to_jiffies(BATADV_MAX_AGGREGATION_MS);
 
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
@@ -498,9 +511,8 @@ static void batadv_iv_ogm_queue_add(struct bat_priv *bat_priv,
 		 * we hold it back for a while, so that it might be aggregated
 		 * later on
 		 */
-		if ((!own_packet) &&
-		    (atomic_read(&bat_priv->aggregated_ogms)))
-			send_time += msecs_to_jiffies(MAX_AGGREGATION_MS);
+		if (!own_packet && atomic_read(&bat_priv->aggregated_ogms))
+			send_time += max_aggregation_jiffies;
 
 		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
 					    send_time, direct_link,
@@ -603,7 +615,7 @@ static void batadv_iv_ogm_schedule(struct hard_iface *hard_iface)
 		batman_ogm_packet->gw_flags =
 				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
 	else
-		batman_ogm_packet->gw_flags = NO_FLAGS;
+		batman_ogm_packet->gw_flags = BATADV_NO_FLAGS;
 
 	batadv_slide_own_bcast_window(hard_iface);
 	batadv_iv_ogm_queue_add(bat_priv, hard_iface->packet_buff,
@@ -772,8 +784,10 @@ static int batadv_iv_ogm_calc_tq(struct orig_node *orig_node,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node;
 	struct hlist_node *node;
 	uint8_t total_count;
-	uint8_t orig_eq_count, neigh_rq_count, tq_own;
-	int tq_asym_penalty, ret = 0;
+	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
+	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
+	int tq_asym_penalty, inv_asym_penalty, ret = 0;
+	unsigned int combined_tq;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();
@@ -824,32 +838,33 @@ static int batadv_iv_ogm_calc_tq(struct orig_node *orig_node,
 	/* if we have too few packets (too less data) we set tq_own to zero
 	 * if we receive too few packets it is not considered bidirectional
 	 */
-	if ((total_count < TQ_LOCAL_BIDRECT_SEND_MINIMUM) ||
-	    (neigh_rq_count < TQ_LOCAL_BIDRECT_RECV_MINIMUM))
+	if (total_count < BATADV_TQ_LOCAL_BIDRECT_SEND_MINIMUM ||
+	    neigh_rq_count < BATADV_TQ_LOCAL_BIDRECT_RECV_MINIMUM)
 		tq_own = 0;
 	else
 		/* neigh_node->real_packet_count is never zero as we
 		 * only purge old information when getting new
 		 * information
 		 */
-		tq_own = (TQ_MAX_VALUE * total_count) /	neigh_rq_count;
+		tq_own = (BATADV_TQ_MAX_VALUE * total_count) /	neigh_rq_count;
 
 	/* 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
 	 * affect the nearly-symmetric links only a little, but
 	 * punishes asymmetric links more.  This will give a value
 	 * between 0 and TQ_MAX_VALUE
 	 */
-	tq_asym_penalty = TQ_MAX_VALUE - (TQ_MAX_VALUE *
-				(TQ_LOCAL_WINDOW_SIZE - neigh_rq_count) *
-				(TQ_LOCAL_WINDOW_SIZE - neigh_rq_count) *
-				(TQ_LOCAL_WINDOW_SIZE - neigh_rq_count)) /
-					(TQ_LOCAL_WINDOW_SIZE *
-					 TQ_LOCAL_WINDOW_SIZE *
-					 TQ_LOCAL_WINDOW_SIZE);
+	neigh_rq_inv = BATADV_TQ_LOCAL_WINDOW_SIZE - neigh_rq_count;
+	neigh_rq_inv_cube = neigh_rq_inv * neigh_rq_inv * neigh_rq_inv;
+	neigh_rq_max_cube = BATADV_TQ_LOCAL_WINDOW_SIZE *
+			    BATADV_TQ_LOCAL_WINDOW_SIZE *
+			    BATADV_TQ_LOCAL_WINDOW_SIZE;
+	inv_asym_penalty = BATADV_TQ_MAX_VALUE * neigh_rq_inv_cube;
+	inv_asym_penalty /= neigh_rq_max_cube;
+	tq_asym_penalty = BATADV_TQ_MAX_VALUE - inv_asym_penalty;
 
-	batman_ogm_packet->tq = ((batman_ogm_packet->tq * tq_own
-							* tq_asym_penalty) /
-						(TQ_MAX_VALUE * TQ_MAX_VALUE));
+	combined_tq = batman_ogm_packet->tq * tq_own * tq_asym_penalty;
+	combined_tq /= BATADV_TQ_MAX_VALUE * BATADV_TQ_MAX_VALUE;
+	batman_ogm_packet->tq = combined_tq;
 
 	batadv_dbg(DBG_BATMAN, bat_priv,
 		   "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
@@ -860,7 +875,7 @@ static int batadv_iv_ogm_calc_tq(struct orig_node *orig_node,
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional
 	 */
-	if (batman_ogm_packet->tq >= TQ_TOTAL_BIDRECT_LIMIT)
+	if (batman_ogm_packet->tq >= BATADV_TQ_TOTAL_BIDRECT_LIMIT)
 		ret = 1;
 
 out:
@@ -928,7 +943,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 		tmp_neigh_node->real_packet_count =
 			bitmap_weight(tmp_neigh_node->real_bits,
-				      TQ_LOCAL_WINDOW_SIZE);
+				      BATADV_TQ_LOCAL_WINDOW_SIZE);
 	}
 	rcu_read_unlock();
 
@@ -1050,6 +1065,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		unsigned long *word;
 		int offset;
 		int32_t bit_pos;
+		int16_t if_num;
+		uint8_t *weight;
 
 		orig_neigh_node = batadv_get_orig_node(bat_priv,
 						       ethhdr->h_source);
@@ -1063,15 +1080,17 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		if (has_directlink_flag &&
 		    batadv_compare_eth(if_incoming->net_dev->dev_addr,
 				       batman_ogm_packet->orig)) {
-			offset = if_incoming->if_num * NUM_WORDS;
+			if_num = if_incoming->if_num;
+			offset = if_num * BATADV_NUM_WORDS;
 
 			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 			word = &(orig_neigh_node->bcast_own[offset]);
 			bit_pos = if_incoming_seqno - 2;
 			bit_pos -= ntohl(batman_ogm_packet->seqno);
 			batadv_set_bit(word, bit_pos);
-			orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
-				bitmap_weight(word, TQ_LOCAL_WINDOW_SIZE);
+			weight = &orig_neigh_node->bcast_own_sum[if_num];
+			*weight = bitmap_weight(word,
+						BATADV_TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
 		}
 
diff --git a/net/batman-adv/bat_sysfs.c b/net/batman-adv/bat_sysfs.c
index a6c27f0..95d80d1 100644
--- a/net/batman-adv/bat_sysfs.c
+++ b/net/batman-adv/bat_sysfs.c
@@ -470,10 +470,11 @@ static BATADV_ATTR(vis_mode, S_IRUGO | S_IWUSR, batadv_show_vis_mode,
 static BATADV_ATTR(routing_algo, S_IRUGO, batadv_show_bat_algo, NULL);
 static BATADV_ATTR(gw_mode, S_IRUGO | S_IWUSR, batadv_show_gw_mode,
 		   batadv_store_gw_mode);
-BATADV_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX,
+BATADV_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * BATADV_JITTER,
+		     INT_MAX, NULL);
+BATADV_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, BATADV_TQ_MAX_VALUE,
 		     NULL);
-BATADV_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
-BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
+BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
 		     batadv_post_gw_deselect);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index e195b9e..4a009b5 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -25,10 +25,10 @@
 /* shift the packet array by n places. */
 static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
 {
-	if (n <= 0 || n >= TQ_LOCAL_WINDOW_SIZE)
+	if (n <= 0 || n >= BATADV_TQ_LOCAL_WINDOW_SIZE)
 		return;
 
-	bitmap_shift_left(seq_bits, seq_bits, n, TQ_LOCAL_WINDOW_SIZE);
+	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZE);
 }
 
 
@@ -46,7 +46,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	/* sequence number is slightly older. We already got a sequence number
 	 * higher than this one, so we just mark it.
 	 */
-	if ((seq_num_diff <= 0) && (seq_num_diff > -TQ_LOCAL_WINDOW_SIZE)) {
+	if (seq_num_diff <= 0 && seq_num_diff > -BATADV_TQ_LOCAL_WINDOW_SIZE) {
 		if (set_mark)
 			batadv_set_bit(seq_bits, -seq_num_diff);
 		return 0;
@@ -55,7 +55,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	/* sequence number is slightly newer, so we shift the window and
 	 * set the mark if required
 	 */
-	if ((seq_num_diff > 0) && (seq_num_diff < TQ_LOCAL_WINDOW_SIZE)) {
+	if (seq_num_diff > 0 && seq_num_diff < BATADV_TQ_LOCAL_WINDOW_SIZE) {
 		batadv_bitmap_shift_left(seq_bits, seq_num_diff);
 
 		if (set_mark)
@@ -64,12 +64,12 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	}
 
 	/* sequence number is much newer, probably missed a lot of packets */
-	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE) &&
-	    (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
+	if (seq_num_diff >= BATADV_TQ_LOCAL_WINDOW_SIZE &&
+	    seq_num_diff < BATADV_EXPECTED_SEQNO_RANGE) {
 		batadv_dbg(DBG_BATMAN, bat_priv,
 			   "We missed a lot of packets (%i) !\n",
 			   seq_num_diff - 1);
-		bitmap_zero(seq_bits, TQ_LOCAL_WINDOW_SIZE);
+		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 		if (set_mark)
 			batadv_set_bit(seq_bits, 0);
 		return 1;
@@ -80,13 +80,13 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	 * packet should be dropped without calling this function if the
 	 * seqno window is protected.
 	 */
-	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE) ||
-	    (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
+	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
+	    seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {
 
 		batadv_dbg(DBG_BATMAN, bat_priv,
 			   "Other host probably restarted!\n");
 
-		bitmap_zero(seq_bits, TQ_LOCAL_WINDOW_SIZE);
+		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 		if (set_mark)
 			batadv_set_bit(seq_bits, 0);
 
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 7954ba8..a081ce1 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -29,7 +29,7 @@ static inline int batadv_test_bit(const unsigned long *seq_bits,
 	int32_t diff;
 
 	diff = last_seqno - curr_seqno;
-	if (diff < 0 || diff >= TQ_LOCAL_WINDOW_SIZE)
+	if (diff < 0 || diff >= BATADV_TQ_LOCAL_WINDOW_SIZE)
 		return 0;
 	else
 		return  test_bit(diff, seq_bits);
@@ -39,7 +39,7 @@ static inline int batadv_test_bit(const unsigned long *seq_bits,
 static inline void batadv_set_bit(unsigned long *seq_bits, int32_t n)
 {
 	/* if too old, just drop it */
-	if (n < 0 || n >= TQ_LOCAL_WINDOW_SIZE)
+	if (n < 0 || n >= BATADV_TQ_LOCAL_WINDOW_SIZE)
 		return;
 
 	set_bit(n, seq_bits); /* turn the position on */
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 42b8a20..db20b68 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -949,7 +949,7 @@ static void batadv_bla_purge_backbone_gw(struct bat_priv *bat_priv, int now)
 			if (now)
 				goto purge_now;
 			if (!batadv_has_timed_out(backbone_gw->lasttime,
-						  BLA_BACKBONE_TIMEOUT))
+						  BATADV_BLA_BACKBONE_TIMEOUT))
 				continue;
 
 			batadv_dbg(DBG_BLA, backbone_gw->bat_priv,
@@ -1001,7 +1001,7 @@ static void batadv_bla_purge_claims(struct bat_priv *bat_priv,
 						primary_if->net_dev->dev_addr))
 				continue;
 			if (!batadv_has_timed_out(claim->lasttime,
-						  BLA_CLAIM_TIMEOUT))
+						  BATADV_BLA_CLAIM_TIMEOUT))
 				continue;
 
 			batadv_dbg(DBG_BLA, bat_priv,
@@ -1075,7 +1075,7 @@ static void batadv_bla_start_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->bla_work, batadv_bla_periodic_work);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bla_work,
-			   msecs_to_jiffies(BLA_PERIOD_LENGTH));
+			   msecs_to_jiffies(BATADV_BLA_PERIOD_LENGTH));
 }
 
 /* periodic work to do:
@@ -1162,9 +1162,9 @@ int batadv_bla_init(struct bat_priv *bat_priv)
 	}
 
 	/* initialize the duplicate list */
-	for (i = 0; i < DUPLIST_SIZE; i++)
+	for (i = 0; i < BATADV_DUPLIST_SIZE; i++)
 		bat_priv->bcast_duplist[i].entrytime =
-			jiffies - msecs_to_jiffies(DUPLIST_TIMEOUT);
+			jiffies - msecs_to_jiffies(BATADV_DUPLIST_TIMEOUT);
 	bat_priv->bcast_duplist_curr = 0;
 
 	if (bat_priv->claim_hash)
@@ -1216,14 +1216,15 @@ int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
 	/* calculate the crc ... */
 	crc = crc16(0, content, length);
 
-	for (i = 0 ; i < DUPLIST_SIZE; i++) {
-		curr = (bat_priv->bcast_duplist_curr + i) % DUPLIST_SIZE;
+	for (i = 0; i < BATADV_DUPLIST_SIZE; i++) {
+		curr = (bat_priv->bcast_duplist_curr + i) % BATADV_DUPLIST_SIZE;
 		entry = &bat_priv->bcast_duplist[curr];
 
 		/* we can stop searching if the entry is too old ;
 		 * later entries will be even older
 		 */
-		if (batadv_has_timed_out(entry->entrytime, DUPLIST_TIMEOUT))
+		if (batadv_has_timed_out(entry->entrytime,
+					 BATADV_DUPLIST_TIMEOUT))
 			break;
 
 		if (entry->crc != crc)
@@ -1238,7 +1239,8 @@ int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
 		return 1;
 	}
 	/* not found, add a new entry (overwrite the oldest entry) */
-	curr = (bat_priv->bcast_duplist_curr + DUPLIST_SIZE - 1) % DUPLIST_SIZE;
+	curr = (bat_priv->bcast_duplist_curr + BATADV_DUPLIST_SIZE - 1);
+	curr %= BATADV_DUPLIST_SIZE;
 	entry = &bat_priv->bcast_duplist[curr];
 	entry->crc = crc;
 	entry->entrytime = jiffies;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 3916e90..5fc162c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -138,8 +138,8 @@ static struct gw_node *batadv_gw_get_best_gw_node(struct bat_priv *bat_priv)
 
 			tmp_gw_factor = (router->tq_avg * router->tq_avg *
 					 down * 100 * 100) /
-					 (TQ_LOCAL_WINDOW_SIZE *
-					 TQ_LOCAL_WINDOW_SIZE * 64);
+					 (BATADV_TQ_LOCAL_WINDOW_SIZE *
+					  BATADV_TQ_LOCAL_WINDOW_SIZE * 64);
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
@@ -354,7 +354,7 @@ void batadv_gw_node_update(struct bat_priv *bat_priv,
 
 		gw_node->deleted = 0;
 
-		if (new_gwflags == NO_FLAGS) {
+		if (new_gwflags == BATADV_NO_FLAGS) {
 			gw_node->deleted = jiffies;
 			batadv_dbg(DBG_BATMAN, bat_priv,
 				   "Gateway %pM removed from gateway list\n",
@@ -367,7 +367,7 @@ void batadv_gw_node_update(struct bat_priv *bat_priv,
 		goto unlock;
 	}
 
-	if (new_gwflags == NO_FLAGS)
+	if (new_gwflags == BATADV_NO_FLAGS)
 		goto unlock;
 
 	batadv_gw_node_add(bat_priv, orig_node, new_gwflags);
@@ -392,7 +392,7 @@ void batadv_gw_node_purge(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node, *curr_gw;
 	struct hlist_node *node, *node_tmp;
-	unsigned long timeout = msecs_to_jiffies(2 * PURGE_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(2 * BATADV_PURGE_TIMEOUT);
 	int do_deselect = 0;
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -484,8 +484,8 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 
 	seq_printf(seq,
 		   "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
-		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
-		   SOURCE_VERSION, primary_if->net_dev->name,
+		   "Gateway", "#", BATADV_TQ_MAX_VALUE, "Nexthop", "outgoingIF",
+		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name);
 
 	rcu_read_lock();
@@ -667,7 +667,7 @@ bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
 		 */
-		curr_tq_avg = TQ_MAX_VALUE;
+		curr_tq_avg = BATADV_TQ_MAX_VALUE;
 		break;
 	case GW_MODE_CLIENT:
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -698,7 +698,7 @@ bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
 	if (!neigh_old)
 		goto out;
 
-	if (curr_tq_avg - neigh_old->tq_avg > GW_THRESHOLD)
+	if (curr_tq_avg - neigh_old->tq_avg > BATADV_GW_THRESHOLD)
 		out_of_range = true;
 
 out:
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 9b1cb23..e7eba9c 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -548,7 +548,7 @@ bool batadv_is_wifi_iface(int ifindex)
 	struct net_device *net_device = NULL;
 	bool ret = false;
 
-	if (ifindex == NULL_IFINDEX)
+	if (ifindex == BATADV_NULL_IFINDEX)
 		goto out;
 
 	net_device = dev_get_by_index(&init_net, ifindex);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 986be72..df7335c 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -72,7 +72,7 @@ static int __init batadv_init(void)
 	register_netdevice_notifier(&batadv_hard_if_notifier);
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-		SOURCE_VERSION, BATADV_COMPAT_VERSION);
+		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
 
 	return 0;
 }
@@ -120,7 +120,8 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
-	batadv_tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
+	batadv_tt_local_add(soft_iface, soft_iface->dev_addr,
+			    BATADV_NULL_IFINDEX);
 
 	ret = batadv_vis_init(bat_priv);
 	if (ret < 0)
@@ -420,7 +421,7 @@ module_exit(batadv_exit);
 
 MODULE_LICENSE("GPL");
 
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_SUPPORTED_DEVICE(DRIVER_DEVICE);
-MODULE_VERSION(SOURCE_VERSION);
+MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
+MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
+MODULE_SUPPORTED_DEVICE(BATADV_DRIVER_DEVICE);
+MODULE_VERSION(BATADV_SOURCE_VERSION);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index b7b9817..09660b4 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -20,79 +20,80 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
-#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
-		      "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
-#define DRIVER_DESC   "B.A.T.M.A.N. advanced"
-#define DRIVER_DEVICE "batman-adv"
+#define BATADV_DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
+			     "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
+#define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
+#define BATADV_DRIVER_DEVICE "batman-adv"
 
-#ifndef SOURCE_VERSION
-#define SOURCE_VERSION "2012.3.0"
+#ifndef BATADV_SOURCE_VERSION
+#define BATADV_SOURCE_VERSION "2012.3.0"
 #endif
 
 /* B.A.T.M.A.N. parameters */
 
-#define TQ_MAX_VALUE 255
-#define JITTER 20
+#define BATADV_TQ_MAX_VALUE 255
+#define BATADV_JITTER 20
 
 /* Time To Live of broadcast messages */
-#define TTL 50
+#define BATADV_TTL 50
 
 /* purge originators after time in seconds if no valid packet comes in
- * -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE
+ * -> TODO: check influence on BATADV_TQ_LOCAL_WINDOW_SIZE
  */
-#define PURGE_TIMEOUT 200000 /* 200 seconds */
-#define TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
-#define TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
+#define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
+#define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
+#define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
-#define TQ_LOCAL_WINDOW_SIZE 64
+#define BATADV_TQ_LOCAL_WINDOW_SIZE 64
 /* miliseconds we have to keep pending tt_req */
-#define TT_REQUEST_TIMEOUT 3000
+#define BATADV_TT_REQUEST_TIMEOUT 3000
 
-#define TQ_GLOBAL_WINDOW_SIZE 5
-#define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
-#define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
-#define TQ_TOTAL_BIDRECT_LIMIT 1
+#define BATADV_TQ_GLOBAL_WINDOW_SIZE 5
+#define BATADV_TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
+#define BATADV_TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
+#define BATADV_TQ_TOTAL_BIDRECT_LIMIT 1
 
-#define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
+/* number of OGMs sent with the last tt diff */
+#define BATADV_TT_OGM_APPEND_MAX 3
 
 /* Time in which a client can roam at most ROAMING_MAX_COUNT times in
  * miliseconds
  */
-#define ROAMING_MAX_TIME 20000
-#define ROAMING_MAX_COUNT 5
+#define BATADV_ROAMING_MAX_TIME 20000
+#define BATADV_ROAMING_MAX_COUNT 5
 
-#define NO_FLAGS 0
+#define BATADV_NO_FLAGS 0
 
-#define NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
+#define BATADV_NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
 
-#define NUM_WORDS BITS_TO_LONGS(TQ_LOCAL_WINDOW_SIZE)
+#define BATADV_NUM_WORDS BITS_TO_LONGS(BATADV_TQ_LOCAL_WINDOW_SIZE)
 
-#define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
+#define BATADV_LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
-#define VIS_INTERVAL 5000	/* 5 seconds */
+#define BATADV_VIS_INTERVAL 5000	/* 5 seconds */
 
 /* how much worse secondary interfaces may be to be considered as bonding
  * candidates
  */
-#define BONDING_TQ_THRESHOLD	50
+#define BATADV_BONDING_TQ_THRESHOLD	50
 
 /* should not be bigger than 512 bytes or change the size of
  * forw_packet->direct_link_flags
  */
-#define MAX_AGGREGATION_BYTES 512
-#define MAX_AGGREGATION_MS 100
+#define BATADV_MAX_AGGREGATION_BYTES 512
+#define BATADV_MAX_AGGREGATION_MS 100
 
-#define BLA_PERIOD_LENGTH	10000	/* 10 seconds */
-#define BLA_BACKBONE_TIMEOUT	(BLA_PERIOD_LENGTH * 3)
-#define BLA_CLAIM_TIMEOUT	(BLA_PERIOD_LENGTH * 10)
+#define BATADV_BLA_PERIOD_LENGTH	10000	/* 10 seconds */
+#define BATADV_BLA_BACKBONE_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 3)
+#define BATADV_BLA_CLAIM_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 10)
 
-#define DUPLIST_SIZE		16
-#define DUPLIST_TIMEOUT		500	/* 500 ms */
+#define BATADV_DUPLIST_SIZE		16
+#define BATADV_DUPLIST_TIMEOUT		500	/* 500 ms */
 /* don't reset again within 30 seconds */
-#define RESET_PROTECTION_MS 30000
-#define EXPECTED_SEQNO_RANGE	65536
+#define BATADV_RESET_PROTECTION_MS 30000
+#define BATADV_EXPECTED_SEQNO_RANGE	65536
 
 enum mesh_state {
 	MESH_INACTIVE,
@@ -100,8 +101,8 @@ enum mesh_state {
 	MESH_DEACTIVATING
 };
 
-#define BCAST_QUEUE_LEN		256
-#define BATMAN_QUEUE_LEN	256
+#define BATADV_BCAST_QUEUE_LEN		256
+#define BATADV_BATMAN_QUEUE_LEN	256
 
 enum uev_action {
 	UEV_ADD = 0,
@@ -113,7 +114,7 @@ enum uev_type {
 	UEV_GW = 0
 };
 
-#define GW_THRESHOLD	50
+#define BATADV_GW_THRESHOLD	50
 
 /* Debug Messages */
 #ifdef pr_fmt
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1980696..f04f591 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -194,6 +194,7 @@ struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
 	struct orig_node *orig_node;
 	int size;
 	int hash_added;
+	unsigned long reset_time;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
@@ -226,14 +227,13 @@ struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
 	atomic_set(&orig_node->tt_size, 0);
-	orig_node->bcast_seqno_reset = jiffies - 1
-					- msecs_to_jiffies(RESET_PROTECTION_MS);
-	orig_node->batman_seqno_reset = jiffies - 1
-					- msecs_to_jiffies(RESET_PROTECTION_MS);
+	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
+	orig_node->bcast_seqno_reset = reset_time;
+	orig_node->batman_seqno_reset = reset_time;
 
 	atomic_set(&orig_node->bond_candidates, 0);
 
-	size = bat_priv->num_ifaces * sizeof(unsigned long) * NUM_WORDS;
+	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
 
 	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
 	if (!orig_node->bcast_own)
@@ -285,7 +285,7 @@ static bool batadv_purge_orig_neighbors(struct bat_priv *bat_priv,
 		last_seen = neigh_node->last_seen;
 		if_incoming = neigh_node->if_incoming;
 
-		if ((batadv_has_timed_out(last_seen, PURGE_TIMEOUT)) ||
+		if ((batadv_has_timed_out(last_seen, BATADV_PURGE_TIMEOUT)) ||
 		    (if_incoming->if_status == IF_INACTIVE) ||
 		    (if_incoming->if_status == IF_NOT_IN_USE) ||
 		    (if_incoming->if_status == IF_TO_BE_REMOVED)) {
@@ -324,7 +324,8 @@ static bool batadv_purge_orig_node(struct bat_priv *bat_priv,
 {
 	struct neigh_node *best_neigh_node;
 
-	if (batadv_has_timed_out(orig_node->last_seen, 2 * PURGE_TIMEOUT)) {
+	if (batadv_has_timed_out(orig_node->last_seen,
+				 2 * BATADV_PURGE_TIMEOUT)) {
 		batadv_dbg(DBG_BATMAN, bat_priv,
 			   "Originator timeout: originator %pM, last_seen %u\n",
 			   orig_node->orig,
@@ -429,11 +430,11 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
-		   SOURCE_VERSION, primary_if->net_dev->name,
+		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name);
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
-		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
-		   "outgoingIF", "Potential nexthops");
+		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
+		   "Nexthop", "outgoingIF", "Potential nexthops");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -486,14 +487,15 @@ out:
 static int batadv_orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 {
 	void *data_ptr;
+	size_t data_size, old_size;
 
-	data_ptr = kmalloc(max_if_num * sizeof(unsigned long) * NUM_WORDS,
-			   GFP_ATOMIC);
+	data_size = max_if_num * sizeof(unsigned long) * BATADV_NUM_WORDS;
+	old_size = (max_if_num - 1) * sizeof(unsigned long) * BATADV_NUM_WORDS;
+	data_ptr = kmalloc(data_size, GFP_ATOMIC);
 	if (!data_ptr)
 		return -ENOMEM;
 
-	memcpy(data_ptr, orig_node->bcast_own,
-	       (max_if_num - 1) * sizeof(unsigned long) * NUM_WORDS);
+	memcpy(data_ptr, orig_node->bcast_own, old_size);
 	kfree(orig_node->bcast_own);
 	orig_node->bcast_own = data_ptr;
 
@@ -554,7 +556,7 @@ static int batadv_orig_node_del_if(struct orig_node *orig_node,
 	if (max_if_num == 0)
 		goto free_bcast_own;
 
-	chunk_size = sizeof(unsigned long) * NUM_WORDS;
+	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr)
 		return -ENOMEM;
diff --git a/net/batman-adv/ring_buffer.c b/net/batman-adv/ring_buffer.c
index aff1ca2..c8f61e3 100644
--- a/net/batman-adv/ring_buffer.c
+++ b/net/batman-adv/ring_buffer.c
@@ -24,7 +24,7 @@ void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
 			    uint8_t value)
 {
 	lq_recv[*lq_index] = value;
-	*lq_index = (*lq_index + 1) % TQ_GLOBAL_WINDOW_SIZE;
+	*lq_index = (*lq_index + 1) % BATADV_TQ_GLOBAL_WINDOW_SIZE;
 }
 
 uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
@@ -34,7 +34,7 @@ uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 
 	ptr = lq_recv;
 
-	while (i < TQ_GLOBAL_WINDOW_SIZE) {
+	while (i < BATADV_TQ_GLOBAL_WINDOW_SIZE) {
 		if (*ptr != 0) {
 			count++;
 			sum += *ptr;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c8fee74..b3fd61c 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -42,6 +42,7 @@ void batadv_slide_own_bcast_window(struct hard_iface *hard_iface)
 	unsigned long *word;
 	uint32_t i;
 	size_t word_index;
+	uint8_t *w;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -49,12 +50,12 @@ void batadv_slide_own_bcast_window(struct hard_iface *hard_iface)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
 			spin_lock_bh(&orig_node->ogm_cnt_lock);
-			word_index = hard_iface->if_num * NUM_WORDS;
+			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
 			word = &(orig_node->bcast_own[word_index]);
 
 			batadv_bit_get_packet(bat_priv, word, 1, 0);
-			orig_node->bcast_own_sum[hard_iface->if_num] =
-				bitmap_weight(word, TQ_LOCAL_WINDOW_SIZE);
+			w = &orig_node->bcast_own_sum[hard_iface->if_num];
+			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 		}
 		rcu_read_unlock();
@@ -160,7 +161,7 @@ void batadv_bonding_candidate_add(struct orig_node *orig_node,
 		goto candidate_del;
 
 	/* ... and is good enough to be considered */
-	if (neigh_node->tq_avg < router->tq_avg - BONDING_TQ_THRESHOLD)
+	if (neigh_node->tq_avg < router->tq_avg - BATADV_BONDING_TQ_THRESHOLD)
 		goto candidate_del;
 
 	/* check if we have another candidate with the same mac address or
@@ -232,9 +233,10 @@ batadv_bonding_save_primary(const struct orig_node *orig_node,
 int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 			    unsigned long *last_reset)
 {
-	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE) ||
-	    (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
-		if (!batadv_has_timed_out(*last_reset, RESET_PROTECTION_MS))
+	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
+	    seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {
+		if (!batadv_has_timed_out(*last_reset,
+					  BATADV_RESET_PROTECTION_MS))
 			return 1;
 
 		*last_reset = jiffies;
@@ -316,7 +318,7 @@ static int batadv_recv_my_icmp_packet(struct bat_priv *bat_priv,
 	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 	memcpy(icmp_packet->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
 	icmp_packet->msg_type = ECHO_REPLY;
-	icmp_packet->header.ttl = TTL;
+	icmp_packet->header.ttl = BATADV_TTL;
 
 	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
@@ -371,7 +373,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 	memcpy(icmp_packet->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
 	icmp_packet->msg_type = TTL_EXCEEDED;
-	icmp_packet->header.ttl = TTL;
+	icmp_packet->header.ttl = BATADV_TTL;
 
 	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index bbbc9a9..c1b2ab2 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -108,7 +108,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		batadv_tt_local_remove(bat_priv, dev->dev_addr,
 				       "mac address changed", false);
-		batadv_tt_local_add(dev, addr->sa_data, NULL_IFINDEX);
+		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX);
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
@@ -210,7 +210,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 		bcast_packet = (struct bcast_packet *)skb->data;
 		bcast_packet->header.version = BATADV_COMPAT_VERSION;
-		bcast_packet->header.ttl = TTL;
+		bcast_packet->header.ttl = BATADV_TTL;
 
 		/* batman packet type: broadcast */
 		bcast_packet->header.packet_type = BAT_BCAST;
@@ -394,8 +394,8 @@ struct net_device *batadv_softif_create(const char *name)
 	atomic_set(&bat_priv->hop_penalty, 30);
 	atomic_set(&bat_priv->log_level, 0);
 	atomic_set(&bat_priv->fragmentation, 1);
-	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
-	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
+	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
+	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
@@ -487,7 +487,7 @@ static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
 	strcpy(info->driver, "B.A.T.M.A.N. advanced");
-	strcpy(info->version, SOURCE_VERSION);
+	strcpy(info->version, BATADV_SOURCE_VERSION);
 	strcpy(info->fw_version, "N/A");
 	strcpy(info->bus_info, "batman");
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 79cd3f7..a0487e9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -257,7 +257,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		   (uint8_t)atomic_read(&bat_priv->ttvn));
 
 	memcpy(tt_local_entry->common.addr, addr, ETH_ALEN);
-	tt_local_entry->common.flags = NO_FLAGS;
+	tt_local_entry->common.flags = BATADV_NO_FLAGS;
 	if (batadv_is_wifi_iface(ifindex))
 		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
@@ -493,14 +493,17 @@ void batadv_tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 			    const char *message, bool roaming)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
+	uint16_t flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
 	if (!tt_local_entry)
 		goto out;
 
-	batadv_tt_local_set_pending(bat_priv, tt_local_entry, TT_CLIENT_DEL |
-				    (roaming ? TT_CLIENT_ROAM : NO_FLAGS),
-				    message);
+	flags = TT_CLIENT_DEL;
+	if (roaming)
+		flags |= TT_CLIENT_ROAM;
+
+	batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags, message);
 out:
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
@@ -534,7 +537,7 @@ static void batadv_tt_local_purge(struct bat_priv *bat_priv)
 				continue;
 
 			if (!batadv_has_timed_out(tt_local_entry->last_seen,
-						  TT_LOCAL_TIMEOUT))
+						  BATADV_TT_LOCAL_TIMEOUT))
 				continue;
 
 			batadv_tt_local_set_pending(bat_priv, tt_local_entry,
@@ -1008,12 +1011,35 @@ void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
 	orig_node->tt_initialised = false;
 }
 
+static void batadv_tt_global_roam_purge_list(struct bat_priv *bat_priv,
+					     struct hlist_head *head)
+{
+	struct tt_common_entry *tt_common_entry;
+	struct tt_global_entry *tt_global_entry;
+	struct hlist_node *node, *node_tmp;
+
+	hlist_for_each_entry_safe(tt_common_entry, node, node_tmp, head,
+				  hash_entry) {
+		tt_global_entry = container_of(tt_common_entry,
+					       struct tt_global_entry, common);
+		if (!(tt_global_entry->common.flags & TT_CLIENT_ROAM))
+			continue;
+		if (!batadv_has_timed_out(tt_global_entry->roam_at,
+					  BATADV_TT_CLIENT_ROAM_TIMEOUT))
+			continue;
+
+		batadv_dbg(DBG_TT, bat_priv,
+			   "Deleting global tt entry (%pM): Roaming timeout\n",
+			   tt_global_entry->common.addr);
+
+		hlist_del_rcu(node);
+		batadv_tt_global_entry_free_ref(tt_global_entry);
+	}
+}
+
 static void batadv_tt_global_roam_purge(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
-	struct tt_common_entry *tt_common_entry;
-	struct tt_global_entry *tt_global_entry;
-	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
@@ -1023,24 +1049,7 @@ static void batadv_tt_global_roam_purge(struct bat_priv *bat_priv)
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
-					  head, hash_entry) {
-			tt_global_entry = container_of(tt_common_entry,
-						       struct tt_global_entry,
-						       common);
-			if (!(tt_global_entry->common.flags & TT_CLIENT_ROAM))
-				continue;
-			if (!batadv_has_timed_out(tt_global_entry->roam_at,
-						  TT_CLIENT_ROAM_TIMEOUT))
-				continue;
-
-			batadv_dbg(DBG_TT, bat_priv,
-				   "Deleting global tt entry (%pM): Roaming timeout\n",
-				   tt_global_entry->common.addr);
-
-			hlist_del_rcu(node);
-			batadv_tt_global_entry_free_ref(tt_global_entry);
-		}
+		batadv_tt_global_roam_purge_list(bat_priv, head);
 		spin_unlock_bh(list_lock);
 	}
 
@@ -1278,7 +1287,8 @@ static void batadv_tt_req_purge(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
-		if (batadv_has_timed_out(node->issued_at, TT_REQUEST_TIMEOUT)) {
+		if (batadv_has_timed_out(node->issued_at,
+					 BATADV_TT_REQUEST_TIMEOUT)) {
 			list_del(&node->list);
 			kfree(node);
 		}
@@ -1298,7 +1308,7 @@ static struct tt_req_node *batadv_new_tt_req_node(struct bat_priv *bat_priv,
 	list_for_each_entry(tt_req_node_tmp, &bat_priv->tt_req_list, list) {
 		if (batadv_compare_eth(tt_req_node_tmp, orig_node) &&
 		    !batadv_has_timed_out(tt_req_node_tmp->issued_at,
-					  TT_REQUEST_TIMEOUT))
+					  BATADV_TT_REQUEST_TIMEOUT))
 			goto unlock;
 	}
 
@@ -1391,7 +1401,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 
 			memcpy(tt_change->addr, tt_common_entry->addr,
 			       ETH_ALEN);
-			tt_change->flags = NO_FLAGS;
+			tt_change->flags = BATADV_NO_FLAGS;
 
 			tt_count++;
 			tt_change++;
@@ -1444,7 +1454,7 @@ static int batadv_send_tt_request(struct bat_priv *bat_priv,
 	tt_request->header.version = BATADV_COMPAT_VERSION;
 	memcpy(tt_request->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_request->dst, dst_orig_node->orig, ETH_ALEN);
-	tt_request->header.ttl = TTL;
+	tt_request->header.ttl = BATADV_TTL;
 	tt_request->ttvn = ttvn;
 	tt_request->tt_data = htons(tt_crc);
 	tt_request->flags = TT_REQUEST;
@@ -1576,7 +1586,7 @@ static bool batadv_send_other_tt_response(struct bat_priv *bat_priv,
 
 	tt_response->header.packet_type = BAT_TT_QUERY;
 	tt_response->header.version = BATADV_COMPAT_VERSION;
-	tt_response->header.ttl = TTL;
+	tt_response->header.ttl = BATADV_TTL;
 	memcpy(tt_response->src, req_dst_orig_node->orig, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
 	tt_response->flags = TT_RESPONSE;
@@ -1697,7 +1707,7 @@ static bool batadv_send_my_tt_response(struct bat_priv *bat_priv,
 
 	tt_response->header.packet_type = BAT_TT_QUERY;
 	tt_response->header.version = BATADV_COMPAT_VERSION;
-	tt_response->header.ttl = TTL;
+	tt_response->header.ttl = BATADV_TTL;
 	memcpy(tt_response->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
 	tt_response->flags = TT_RESPONSE;
@@ -1925,7 +1935,8 @@ static void batadv_tt_roam_purge(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt_roam_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_roam_list, list) {
-		if (!batadv_has_timed_out(node->first_time, ROAMING_MAX_TIME))
+		if (!batadv_has_timed_out(node->first_time,
+					  BATADV_ROAMING_MAX_TIME))
 			continue;
 
 		list_del(&node->list);
@@ -1955,7 +1966,7 @@ static bool batadv_tt_check_roam_count(struct bat_priv *bat_priv,
 			continue;
 
 		if (batadv_has_timed_out(tt_roam_node->first_time,
-					 ROAMING_MAX_TIME))
+					 BATADV_ROAMING_MAX_TIME))
 			continue;
 
 		if (!batadv_atomic_dec_not_zero(&tt_roam_node->counter))
@@ -1971,7 +1982,8 @@ static bool batadv_tt_check_roam_count(struct bat_priv *bat_priv,
 			goto unlock;
 
 		tt_roam_node->first_time = jiffies;
-		atomic_set(&tt_roam_node->counter, ROAMING_MAX_COUNT - 1);
+		atomic_set(&tt_roam_node->counter,
+			   BATADV_ROAMING_MAX_COUNT - 1);
 		memcpy(tt_roam_node->addr, client, ETH_ALEN);
 
 		list_add(&tt_roam_node->list, &bat_priv->tt_roam_list);
@@ -2009,7 +2021,7 @@ static void batadv_send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 
 	roam_adv_packet->header.packet_type = BAT_ROAM_ADV;
 	roam_adv_packet->header.version = BATADV_COMPAT_VERSION;
-	roam_adv_packet->header.ttl = TTL;
+	roam_adv_packet->header.ttl = BATADV_TTL;
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
@@ -2170,7 +2182,7 @@ static int batadv_tt_commit_changes(struct bat_priv *bat_priv,
 	bat_priv->tt_poss_change = false;
 
 	/* reset the sending counter */
-	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
+	atomic_set(&bat_priv->tt_ogm_append_cnt, BATADV_TT_OGM_APPEND_MAX);
 
 	return batadv_tt_changes_fill_buff(bat_priv, packet_buff,
 					   packet_buff_len, packet_min_len);
@@ -2248,7 +2260,8 @@ void batadv_tt_update_orig(struct bat_priv *bat_priv,
 	if ((!orig_node->tt_initialised && ttvn == 1) ||
 	    ttvn - orig_ttvn == 1) {
 		/* the OGM could not contain the changes due to their size or
-		 * because they have already been sent TT_OGM_APPEND_MAX times.
+		 * because they have already been sent BATADV_TT_OGM_APPEND_MAX
+		 * times.
 		 * In this case send a tt request
 		 */
 		if (!tt_num_changes) {
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 1d5d21e..fd538ea 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -85,7 +85,7 @@ struct orig_node {
 	bool tt_poss_change;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
-	DECLARE_BITMAP(bcast_bits, TQ_LOCAL_WINDOW_SIZE);
+	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
@@ -121,13 +121,13 @@ struct neigh_node {
 	struct hlist_node list;
 	uint8_t addr[ETH_ALEN];
 	uint8_t real_packet_count;
-	uint8_t tq_recv[TQ_GLOBAL_WINDOW_SIZE];
+	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
 	struct list_head bonding_list;
 	unsigned long last_seen;
-	DECLARE_BITMAP(real_bits, TQ_LOCAL_WINDOW_SIZE);
+	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct orig_node *orig_node;
@@ -209,7 +209,7 @@ struct bat_priv {
 	struct list_head tt_roam_list;
 	struct hashtable_t *vis_hash;
 #ifdef CONFIG_BATMAN_ADV_BLA
-	struct bcast_duplist_entry bcast_duplist[DUPLIST_SIZE];
+	struct bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	struct bla_claim_dst claim_dest;
 #endif
@@ -348,7 +348,7 @@ struct if_list_entry {
 };
 
 struct debug_log {
-	char log_buff[LOG_BUF_LEN];
+	char log_buff[BATADV_LOG_BUF_LEN];
 	unsigned long log_start;
 	unsigned long log_end;
 	spinlock_t lock; /* protects log_buff, log_start and log_end */
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 8098320..8454d91 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -323,7 +323,7 @@ find_router:
 	/* batman packet type: unicast */
 	unicast_packet->header.packet_type = BAT_UNICAST;
 	/* set unicast ttl */
-	unicast_packet->header.ttl = TTL;
+	unicast_packet->header.ttl = BATADV_TTL;
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 	/* set the destination tt version number */
diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index a439ed6..7418169 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -575,7 +575,7 @@ static int batadv_generate_vis_packet(struct bat_priv *bat_priv)
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
 
 	memcpy(packet->target_orig, batadv_broadcast_addr, ETH_ALEN);
-	packet->header.ttl = TTL;
+	packet->header.ttl = BATADV_TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
 	packet->entries = 0;
 	skb_trim(info->skb_packet, sizeof(*packet));
@@ -841,6 +841,7 @@ int batadv_vis_init(struct bat_priv *bat_priv)
 	struct vis_packet *packet;
 	int hash_added;
 	unsigned int len;
+	unsigned long first_seen;
 
 	if (bat_priv->vis_hash)
 		return 0;
@@ -867,15 +868,15 @@ int batadv_vis_init(struct bat_priv *bat_priv)
 					      sizeof(*packet));
 
 	/* prefill the vis info */
-	bat_priv->my_vis_info->first_seen = jiffies -
-						msecs_to_jiffies(VIS_INTERVAL);
+	first_seen = jiffies - msecs_to_jiffies(BATADV_VIS_INTERVAL);
+	bat_priv->my_vis_info->first_seen = first_seen;
 	INIT_LIST_HEAD(&bat_priv->my_vis_info->recv_list);
 	INIT_LIST_HEAD(&bat_priv->my_vis_info->send_list);
 	kref_init(&bat_priv->my_vis_info->refcount);
 	bat_priv->my_vis_info->bat_priv = bat_priv;
 	packet->header.version = BATADV_COMPAT_VERSION;
 	packet->header.packet_type = BAT_VIS;
-	packet->header.ttl = TTL;
+	packet->header.ttl = BATADV_TTL;
 	packet->seqno = 0;
 	packet->entries = 0;
 
@@ -936,5 +937,5 @@ static void batadv_start_vis_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->vis_work, batadv_send_vis_packets);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->vis_work,
-			   msecs_to_jiffies(VIS_INTERVAL));
+			   msecs_to_jiffies(BATADV_VIS_INTERVAL));
 }
-- 
1.7.9.4

