Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 14 Dec 2012 20:29:04 +0100
Message-Id: <1355513344-16066-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: postpone OGM preparation to
	sending time
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

OGMs are currently prepared 1 originator interval in advance
then the time they are used to be sent. This means that once
in the air they carry old information (like TT announcements
and possibly other flags).

To fix this, postpone the OGM creation to the same time of
sending, in this way the OGM is first created and then
immediately sent.

This patch also removes a "magic" -2 operation that was
introduced in the past to address the fact that batman-adv
was sending "delayed OGM" plus the fact that the OGM seqno
was increased right after having sent a new packet. Since
this change is removing both the behaviours, the "magic"
operation is not needed anymore.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c | 119 ++++++++++++++++++++++++++++++++++-------------------------
 types.h      |   1 +
 2 files changed, 70 insertions(+), 50 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 83dfcb4..9f890d5 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -54,39 +54,6 @@ out:
 	return neigh_node;
 }
 
-static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
-{
-	struct batadv_ogm_packet *batadv_ogm_packet;
-	unsigned char *ogm_buff;
-	uint32_t random_seqno;
-	int res = -ENOMEM;
-
-	/* randomize initial seqno to avoid collision */
-	get_random_bytes(&random_seqno, sizeof(random_seqno));
-	atomic_set(&hard_iface->bat_iv.ogm_seqno, random_seqno);
-
-	hard_iface->bat_iv.ogm_buff_len = BATADV_OGM_HLEN;
-	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff_len, GFP_ATOMIC);
-	if (!ogm_buff)
-		goto out;
-
-	hard_iface->bat_iv.ogm_buff = ogm_buff;
-
-	batadv_ogm_packet = (struct batadv_ogm_packet *)ogm_buff;
-	batadv_ogm_packet->header.packet_type = BATADV_IV_OGM;
-	batadv_ogm_packet->header.version = BATADV_COMPAT_VERSION;
-	batadv_ogm_packet->header.ttl = 2;
-	batadv_ogm_packet->flags = BATADV_NO_FLAGS;
-	batadv_ogm_packet->tq = BATADV_TQ_MAX_VALUE;
-	batadv_ogm_packet->tt_num_changes = 0;
-	batadv_ogm_packet->ttvn = 0;
-
-	res = 0;
-
-out:
-	return res;
-}
-
 static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
 	kfree(hard_iface->bat_iv.ogm_buff);
@@ -118,14 +85,14 @@ batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 
 /* when do we schedule our own ogm to be sent */
 static unsigned long
-batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
+batadv_iv_ogm_emit_wait_time(const struct batadv_priv *bat_priv)
 {
 	unsigned int msecs;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
 	msecs += (random32() % 2 * BATADV_JITTER);
 
-	return jiffies + msecs_to_jiffies(msecs);
+	return msecs_to_jiffies(msecs);
 }
 
 /* when do we schedule a ogm packet to be sent */
@@ -459,7 +426,8 @@ out:
 /* aggregate a new packet into the existing ogm packet */
 static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 				    const unsigned char *packet_buff,
-				    int packet_len, bool direct_link)
+				    int packet_len, bool direct_link,
+				    int own_packet)
 {
 	unsigned char *skb_buff;
 	unsigned long new_direct_link_flag;
@@ -468,6 +436,7 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 	memcpy(skb_buff, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
 	forw_packet_aggr->num_packets++;
+	forw_packet_aggr->own |= own_packet;
 
 	/* save packet direct link flag status */
 	if (direct_link) {
@@ -498,8 +467,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	/* own packets are not to be aggregated */
-	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
+	if ((atomic_read(&bat_priv->aggregated_ogms))) {
 		hlist_for_each_entry(forw_packet_pos, tmp_node,
 				     &bat_priv->forw_bat_list, list) {
 			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,
@@ -532,7 +500,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 					    if_incoming, own_packet);
 	} else {
 		batadv_iv_ogm_aggregate(forw_packet_aggr, packet_buff,
-					packet_len, direct_link);
+					packet_len, direct_link, own_packet);
 		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 	}
 }
@@ -593,13 +561,33 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	unsigned char **ogm_buff = &hard_iface->bat_iv.ogm_buff;
+
+	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_iv.work,
+			   batadv_iv_ogm_emit_wait_time(bat_priv));
+}
+
+static void batadv_iv_ogm_send(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_hard_iface_bat_iv *bat_iv;
+	struct batadv_hard_iface *primary_if, *hard_iface;
+	struct batadv_priv *bat_priv;
+	unsigned char **ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	struct batadv_hard_iface *primary_if;
-	int *ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
+	int *ogm_buff_len;
 	int vis_server, tt_num_changes = 0;
 	uint32_t seqno;
 	uint8_t bandwidth;
+	unsigned long send_time;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	bat_iv = container_of(delayed_work, struct batadv_hard_iface_bat_iv,
+			      work);
+	hard_iface = container_of(bat_iv, struct batadv_hard_iface, bat_iv);
+
+	bat_priv = netdev_priv(hard_iface->soft_iface);
+	ogm_buff = &hard_iface->bat_iv.ogm_buff;
+	ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
 
 	vis_server = atomic_read(&bat_priv->vis_mode);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -611,10 +599,9 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
 
+	seqno = (uint32_t)atomic_add_return(1, &hard_iface->bat_iv.ogm_seqno);
 	/* change sequence number to network order */
-	seqno = (uint32_t)atomic_read(&hard_iface->bat_iv.ogm_seqno);
 	batadv_ogm_packet->seqno = htonl(seqno);
-	atomic_inc(&hard_iface->bat_iv.ogm_seqno);
 
 	batadv_ogm_packet->ttvn = atomic_read(&bat_priv->tt.vn);
 	batadv_ogm_packet->tt_crc = htons(bat_priv->tt.local_crc);
@@ -635,14 +622,50 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	}
 
 	batadv_slide_own_bcast_window(hard_iface);
+	send_time = BATADV_MAX_AGGREGATION_MS + batadv_iv_ogm_fwd_send_time();
 	batadv_iv_ogm_queue_add(bat_priv, hard_iface->bat_iv.ogm_buff,
 				hard_iface->bat_iv.ogm_buff_len, hard_iface, 1,
-				batadv_iv_ogm_emit_send_time(bat_priv));
+				send_time);
 
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 }
 
+static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_ogm_packet *batadv_ogm_packet;
+	unsigned char *ogm_buff;
+	uint32_t random_seqno;
+	int res = -ENOMEM;
+
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&hard_iface->bat_iv.ogm_seqno, random_seqno);
+
+	hard_iface->bat_iv.ogm_buff_len = BATADV_OGM_HLEN;
+	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff_len, GFP_ATOMIC);
+	if (!ogm_buff)
+		goto out;
+
+	hard_iface->bat_iv.ogm_buff = ogm_buff;
+
+	batadv_ogm_packet = (struct batadv_ogm_packet *)ogm_buff;
+	batadv_ogm_packet->header.packet_type = BATADV_IV_OGM;
+	batadv_ogm_packet->header.version = BATADV_COMPAT_VERSION;
+	batadv_ogm_packet->header.ttl = 2;
+	batadv_ogm_packet->flags = BATADV_NO_FLAGS;
+	batadv_ogm_packet->tq = BATADV_TQ_MAX_VALUE;
+	batadv_ogm_packet->tt_num_changes = 0;
+	batadv_ogm_packet->ttvn = 0;
+
+	INIT_DELAYED_WORK(&hard_iface->bat_iv.work, batadv_iv_ogm_send);
+
+	res = 0;
+
+out:
+	return res;
+}
+
 static void
 batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
@@ -998,7 +1021,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	bool is_single_hop_neigh = false;
 	bool is_from_best_next_hop = false;
 	int is_duplicate, sameseq, simlar_ttl;
-	uint32_t if_incoming_seqno;
 	uint8_t *prev_sender;
 
 	/* Silently drop when the batman packet is actually not a
@@ -1016,9 +1038,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (batadv_ogm_packet->header.packet_type != BATADV_IV_OGM)
 		return;
 
-	/* could be changed by schedule_own_packet() */
-	if_incoming_seqno = atomic_read(&if_incoming->bat_iv.ogm_seqno);
-
 	if (batadv_ogm_packet->flags & BATADV_DIRECTLINK)
 		has_directlink_flag = 1;
 	else
@@ -1108,7 +1127,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 
 			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 			word = &(orig_neigh_node->bcast_own[offset]);
-			bit_pos = if_incoming_seqno - 2;
+			bit_pos = atomic_read(&if_incoming->bat_iv.ogm_seqno);
 			bit_pos -= ntohl(batadv_ogm_packet->seqno);
 			batadv_set_bit(word, bit_pos);
 			weight = &orig_neigh_node->bcast_own_sum[if_num];
diff --git a/types.h b/types.h
index 030ce41..978381a 100644
--- a/types.h
+++ b/types.h
@@ -49,6 +49,7 @@ struct batadv_hard_iface_bat_iv {
 	unsigned char *ogm_buff;
 	int ogm_buff_len;
 	atomic_t ogm_seqno;
+	struct delayed_work work;
 };
 
 struct batadv_hard_iface {
-- 
1.8.0.2

