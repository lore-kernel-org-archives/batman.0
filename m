Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 01:43:35 +0200
Message-Id: <1341186226-10549-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1341186226-10549-1-git-send-email-ordex@autistici.org>
References: <1341186226-10549-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/16] batman-adv: Prefix main enum with
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
 net/batman-adv/bat_iv_ogm.c            |   48 ++++++++++++++++----------------
 net/batman-adv/bat_sysfs.c             |   12 ++++----
 net/batman-adv/bat_sysfs.h             |    4 +--
 net/batman-adv/bitarray.c              |    4 +--
 net/batman-adv/bridge_loop_avoidance.c |   46 +++++++++++++++---------------
 net/batman-adv/gateway_client.c        |   25 +++++++++--------
 net/batman-adv/icmp_socket.c           |    8 +++---
 net/batman-adv/main.c                  |   10 +++----
 net/batman-adv/main.h                  |   36 ++++++++++++------------
 net/batman-adv/originator.c            |   12 ++++----
 net/batman-adv/routing.c               |   18 ++++++------
 net/batman-adv/send.c                  |   11 ++++----
 net/batman-adv/soft-interface.c        |    6 ++--
 net/batman-adv/translation-table.c     |   35 ++++++++++++-----------
 14 files changed, 140 insertions(+), 135 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 58bbb20..f9981e6 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -188,7 +188,7 @@ static void batadv_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
 							    "Sending own" :
 							    "Forwarding"));
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "%s %spacket (originator %pM, seqno %u, TQ %d, TTL %d, IDF %s, ttvn %d) on interface %s [%pM]\n",
 			   fwd_str, (packet_num > 0 ? "aggregated " : ""),
 			   batman_ogm_packet->orig,
@@ -252,7 +252,7 @@ static void batadv_iv_ogm_emit(struct forw_packet *forw_packet)
 	    (forw_packet->own && (forw_packet->if_incoming != primary_if))) {
 
 		/* FIXME: what about aggregated packets ? */
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "%s packet (originator %pM, seqno %u, TTL %d) on interface %s [%pM]\n",
 			   (forw_packet->own ? "Sending own" : "Forwarding"),
 			   batman_ogm_packet->orig,
@@ -385,7 +385,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
-			batadv_dbg(DBG_BATMAN, bat_priv,
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 				   "batman packet queue full\n");
 			goto out;
 		}
@@ -535,7 +535,7 @@ static void batadv_iv_ogm_forward(struct orig_node *orig_node,
 	uint8_t tt_num_changes;
 
 	if (batman_ogm_packet->header.ttl <= 1) {
-		batadv_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "ttl exceeded\n");
 		return;
 	}
 
@@ -561,7 +561,7 @@ static void batadv_iv_ogm_forward(struct orig_node *orig_node,
 	batman_ogm_packet->tq = batadv_hop_penalty(batman_ogm_packet->tq,
 						   bat_priv);
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Forwarding packet: tq: %i, ttl: %i\n",
 		   batman_ogm_packet->tq, batman_ogm_packet->header.ttl);
 
@@ -642,7 +642,7 @@ batadv_iv_ogm_orig_update(struct bat_priv *bat_priv,
 	uint8_t bcast_own_sum_orig, bcast_own_sum_neigh;
 	uint8_t *neigh_addr;
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "update_originator(): Searching and updating originator entry of received packet\n");
 
 	rcu_read_lock();
@@ -685,7 +685,7 @@ batadv_iv_ogm_orig_update(struct bat_priv *bat_priv,
 		if (!neigh_node)
 			goto unlock;
 	} else
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Updating existing last-hop neighbor of originator\n");
 
 	rcu_read_unlock();
@@ -866,7 +866,7 @@ static int batadv_iv_ogm_calc_tq(struct orig_node *orig_node,
 	combined_tq /= BATADV_TQ_MAX_VALUE * BATADV_TQ_MAX_VALUE;
 	batman_ogm_packet->tq = combined_tq;
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
 		   orig_node->orig, orig_neigh_node->orig, total_count,
 		   neigh_rq_count, tq_own,
@@ -948,7 +948,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	rcu_read_unlock();
 
 	if (need_update) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "updating last_seqno: old %u, new %u\n",
 			   orig_node->last_real_seqno, seqno);
 		orig_node->last_real_seqno = seqno;
@@ -1007,7 +1007,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (batadv_compare_eth(ethhdr->h_source, batman_ogm_packet->orig))
 		is_single_hop_neigh = true;
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Received BATMAN packet via NB: %pM, IF: %s [%pM] (from OG: %pM, via prev OG: %pM, seqno %u, ttvn %u, crc %u, changes %u, td %d, TTL %d, V %d, IDF %d)\n",
 		   ethhdr->h_source, if_incoming->net_dev->name,
 		   if_incoming->net_dev->dev_addr, batman_ogm_packet->orig,
@@ -1044,21 +1044,21 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	rcu_read_unlock();
 
 	if (batman_ogm_packet->header.version != BATADV_COMPAT_VERSION) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: incompatible batman version (%i)\n",
 			   batman_ogm_packet->header.version);
 		return;
 	}
 
 	if (is_my_addr) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: received my own broadcast (sender: %pM)\n",
 			   ethhdr->h_source);
 		return;
 	}
 
 	if (is_broadcast) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n",
 			   ethhdr->h_source);
 		return;
@@ -1097,21 +1097,21 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
 		}
 
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: originator packet from myself (via neighbor)\n");
 		batadv_orig_node_free_ref(orig_neigh_node);
 		return;
 	}
 
 	if (is_my_oldorig) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: ignoring all rebroadcast echos (sender: %pM)\n",
 			   ethhdr->h_source);
 		return;
 	}
 
 	if (batman_ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: ignoring all packets not forwarded from the best next hop (sender: %pM)\n",
 			   ethhdr->h_source);
 		return;
@@ -1125,14 +1125,14 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 						   if_incoming);
 
 	if (is_duplicate == -1) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: packet within seqno protection time (sender: %pM)\n",
 			   ethhdr->h_source);
 		goto out;
 	}
 
 	if (batman_ogm_packet->tq == 0) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: originator packet with tq equal 0\n");
 		goto out;
 	}
@@ -1151,7 +1151,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	    (batadv_compare_eth(router->addr, prev_sender)) &&
 	    !(batadv_compare_eth(batman_ogm_packet->orig, prev_sender)) &&
 	    (batadv_compare_eth(router->addr, router_router->addr))) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n",
 			   ethhdr->h_source);
 		goto out;
@@ -1172,7 +1172,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	 * don't route towards it
 	 */
 	if (!is_single_hop_neigh && (!orig_neigh_router)) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: OGM via unknown neighbor!\n");
 		goto out_neigh;
 	}
@@ -1201,25 +1201,25 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 				      is_single_hop_neigh,
 				      is_from_best_next_hop, if_incoming);
 
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
 		goto out_neigh;
 	}
 
 	/* multihop originator */
 	if (!is_bidirect) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: not received via bidirectional link\n");
 		goto out_neigh;
 	}
 
 	if (is_duplicate) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: duplicate packet received\n");
 		goto out_neigh;
 	}
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Forwarding packet: rebroadcast originator packet\n");
 	batadv_iv_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
 			      is_single_hop_neigh, is_from_best_next_hop,
diff --git a/net/batman-adv/bat_sysfs.c b/net/batman-adv/bat_sysfs.c
index e27bfe3..c4794c6 100644
--- a/net/batman-adv/bat_sysfs.c
+++ b/net/batman-adv/bat_sysfs.c
@@ -485,7 +485,7 @@ BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, DBG_ALL, NULL);
+BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
 
 static struct bat_attribute *batadv_mesh_attrs[] = {
@@ -723,8 +723,8 @@ void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 	*hardif_obj = NULL;
 }
 
-int batadv_throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
-			enum uev_action action, const char *data)
+int batadv_throw_uevent(struct bat_priv *bat_priv, enum batadv_uev_type type,
+			enum batadv_uev_action action, const char *data)
 {
 	int ret = -ENOMEM;
 	struct hard_iface *primary_if = NULL;
@@ -756,7 +756,7 @@ int batadv_throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
 		batadv_uev_action_str[action]);
 
 	/* If the event is DEL, ignore the data field */
-	if (action != UEV_DEL) {
+	if (action != BATADV_UEV_DEL) {
 		uevent_env[2] = kmalloc(strlen(BATADV_UEV_DATA_VAR) +
 					strlen(data) + 1, GFP_ATOMIC);
 		if (!uevent_env[2])
@@ -775,10 +775,10 @@ out:
 		batadv_hardif_free_ref(primary_if);
 
 	if (ret)
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
 			   batadv_uev_type_str[type],
 			   batadv_uev_action_str[action],
-			   (action == UEV_DEL ? "NULL" : data), ret);
+			   (action == BATADV_UEV_DEL ? "NULL" : data), ret);
 	return ret;
 }
diff --git a/net/batman-adv/bat_sysfs.h b/net/batman-adv/bat_sysfs.h
index 23a8390..28c2948 100644
--- a/net/batman-adv/bat_sysfs.h
+++ b/net/batman-adv/bat_sysfs.h
@@ -36,7 +36,7 @@ void batadv_sysfs_del_meshif(struct net_device *dev);
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
 			    struct net_device *dev);
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj);
-int batadv_throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
-			enum uev_action action, const char *data);
+int batadv_throw_uevent(struct bat_priv *bat_priv, enum batadv_uev_type type,
+			enum batadv_uev_action action, const char *data);
 
 #endif /* _NET_BATMAN_ADV_SYSFS_H_ */
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 4a009b5..835d3b6 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -66,7 +66,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	/* sequence number is much newer, probably missed a lot of packets */
 	if (seq_num_diff >= BATADV_TQ_LOCAL_WINDOW_SIZE &&
 	    seq_num_diff < BATADV_EXPECTED_SEQNO_RANGE) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "We missed a lot of packets (%i) !\n",
 			   seq_num_diff - 1);
 		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
@@ -83,7 +83,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
 	    seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {
 
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Other host probably restarted!\n");
 
 		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index c375131..b463402 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -297,7 +297,7 @@ static void batadv_bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		 * set Ethernet SRC to the clients mac
 		 */
 		memcpy(ethhdr->h_source, mac, ETH_ALEN);
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): CLAIM %pM on vid %d\n", mac, vid);
 		break;
 	case BATADV_CLAIM_TYPE_DEL:
@@ -305,7 +305,7 @@ static void batadv_bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		 * set HW SRC to the clients mac
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): UNCLAIM %pM on vid %d\n", mac,
 			   vid);
 		break;
@@ -314,7 +314,7 @@ static void batadv_bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		 * set HW SRC to the special mac containg the crc
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): ANNOUNCE of %pM on vid %d\n",
 			   ethhdr->h_source, vid);
 		break;
@@ -324,7 +324,7 @@ static void batadv_bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
 		memcpy(ethhdr->h_dest, mac, ETH_ALEN);
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): REQUEST of %pM to %pMon vid %d\n",
 			   ethhdr->h_source, ethhdr->h_dest, vid);
 		break;
@@ -365,7 +365,7 @@ static struct backbone_gw *batadv_bla_get_backbone_gw(struct bat_priv *bat_priv,
 	if (entry)
 		return entry;
 
-	batadv_dbg(DBG_BLA, bat_priv,
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "bla_get_backbone_gw(): not found (%pM, %d), creating new entry\n",
 		   orig, vid);
 
@@ -439,7 +439,7 @@ static void batadv_bla_answer_request(struct bat_priv *bat_priv,
 	struct backbone_gw *backbone_gw;
 	int i;
 
-	batadv_dbg(DBG_BLA, bat_priv,
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "bla_answer_request(): received a claim request, send all of our own claims again\n");
 
 	backbone_gw = batadv_backbone_hash_find(bat_priv,
@@ -480,8 +480,8 @@ static void batadv_bla_send_request(struct backbone_gw *backbone_gw)
 	/* first, remove all old entries */
 	batadv_bla_del_backbone_claims(backbone_gw);
 
-	batadv_dbg(DBG_BLA, backbone_gw->bat_priv, "Sending REQUEST to %pM\n",
-		   backbone_gw->orig);
+	batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
+		   "Sending REQUEST to %pM\n", backbone_gw->orig);
 
 	/* send request */
 	batadv_bla_send_claim(backbone_gw->bat_priv, backbone_gw->orig,
@@ -546,7 +546,7 @@ static void batadv_bla_add_claim(struct bat_priv *bat_priv, const uint8_t *mac,
 		claim->backbone_gw = backbone_gw;
 
 		atomic_set(&claim->refcount, 2);
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, vid);
 		hash_added = batadv_hash_add(bat_priv->claim_hash,
@@ -565,7 +565,7 @@ static void batadv_bla_add_claim(struct bat_priv *bat_priv, const uint8_t *mac,
 			/* no need to register a new backbone */
 			goto claim_free_ref;
 
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
 			   mac, vid);
 
@@ -599,8 +599,8 @@ static void batadv_bla_del_claim(struct bat_priv *bat_priv, const uint8_t *mac,
 	if (!claim)
 		return;
 
-	batadv_dbg(DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n", mac,
-		   vid);
+	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n",
+		   mac, vid);
 
 	batadv_hash_remove(bat_priv->claim_hash, batadv_compare_claim,
 			   batadv_choose_claim, claim);
@@ -633,12 +633,12 @@ static int batadv_handle_announce(struct bat_priv *bat_priv,
 	backbone_gw->lasttime = jiffies;
 	crc = ntohs(*((__be16 *)(&an_addr[4])));
 
-	batadv_dbg(DBG_BLA, bat_priv,
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %04x\n",
 		   vid, backbone_gw->orig, crc);
 
 	if (backbone_gw->crc != crc) {
-		batadv_dbg(DBG_BLA, backbone_gw->bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "handle_announce(): CRC FAILED for %pM/%d (my = %04x, sent = %04x)\n",
 			   backbone_gw->orig, backbone_gw->vid,
 			   backbone_gw->crc, crc);
@@ -674,7 +674,7 @@ static int batadv_handle_request(struct bat_priv *bat_priv,
 	if (!batadv_compare_eth(ethhdr->h_dest, primary_if->net_dev->dev_addr))
 		return 1;
 
-	batadv_dbg(DBG_BLA, bat_priv,
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "handle_request(): REQUEST vid %d (sent by %pM)...\n",
 		   vid, ethhdr->h_source);
 
@@ -702,7 +702,7 @@ static int batadv_handle_unclaim(struct bat_priv *bat_priv,
 		return 1;
 
 	/* this must be an UNCLAIM frame */
-	batadv_dbg(DBG_BLA, bat_priv,
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "handle_unclaim(): UNCLAIM %pM on vid %d (sent by %pM)...\n",
 		   claim_addr, vid, backbone_gw->orig);
 
@@ -804,7 +804,7 @@ static int batadv_check_claim_group(struct bat_priv *bat_priv,
 
 	/* if our mesh friends mac is bigger, use it for ourselves. */
 	if (ntohs(bla_dst->group) > ntohs(bla_dst_own->group)) {
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "taking other backbones claim group: %04x\n",
 			   ntohs(bla_dst->group));
 		bla_dst_own->group = bla_dst->group;
@@ -882,7 +882,7 @@ static int batadv_bla_process_claim(struct bat_priv *bat_priv,
 	ret = batadv_check_claim_group(bat_priv, primary_if, hw_src, hw_dst,
 				       ethhdr);
 	if (ret == 1)
-		batadv_dbg(DBG_BLA, bat_priv,
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
 			   ethhdr->h_source, vid, hw_src, hw_dst);
 
@@ -917,7 +917,7 @@ static int batadv_bla_process_claim(struct bat_priv *bat_priv,
 		break;
 	}
 
-	batadv_dbg(DBG_BLA, bat_priv,
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "bla_process_claim(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
 		   ethhdr->h_source, vid, hw_src, hw_dst);
 	return 1;
@@ -952,7 +952,7 @@ static void batadv_bla_purge_backbone_gw(struct bat_priv *bat_priv, int now)
 						  BATADV_BLA_BACKBONE_TIMEOUT))
 				continue;
 
-			batadv_dbg(DBG_BLA, backbone_gw->bat_priv,
+			batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 				   "bla_purge_backbone_gw(): backbone gw %pM timed out\n",
 				   backbone_gw->orig);
 
@@ -1004,7 +1004,7 @@ static void batadv_bla_purge_claims(struct bat_priv *bat_priv,
 						  BATADV_BLA_CLAIM_TIMEOUT))
 				continue;
 
-			batadv_dbg(DBG_BLA, bat_priv,
+			batadv_dbg(BATADV_DBG_BLA, bat_priv,
 				   "bla_purge_claims(): %pM, vid %d, time out\n",
 				   claim->addr, claim->vid);
 
@@ -1146,7 +1146,7 @@ int batadv_bla_init(struct bat_priv *bat_priv)
 	uint8_t claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
 	struct hard_iface *primary_if;
 
-	batadv_dbg(DBG_BLA, bat_priv, "bla hash registering\n");
+	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hash registering\n");
 
 	/* setting claim destination address */
 	memcpy(&bat_priv->claim_dest.magic, claim_dest, 3);
@@ -1181,7 +1181,7 @@ int batadv_bla_init(struct bat_priv *bat_priv)
 	batadv_hash_set_lock_class(bat_priv->backbone_hash,
 				   &batadv_backbone_hash_lock_class_key);
 
-	batadv_dbg(DBG_BLA, bat_priv, "bla hashes initialized\n");
+	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hashes initialized\n");
 
 	batadv_bla_start_timer(bat_priv);
 	return 0;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 3b50c31..00273b9 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -218,21 +218,24 @@ void batadv_gw_election(struct bat_priv *bat_priv)
 	}
 
 	if ((curr_gw) && (!next_gw)) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Removing selected gateway - no gateway in range\n");
-		batadv_throw_uevent(bat_priv, UEV_GW, UEV_DEL, NULL);
+		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_DEL,
+				    NULL);
 	} else if ((!curr_gw) && (next_gw)) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
 			   next_gw->orig_node->orig,
 			   next_gw->orig_node->gw_flags, router->tq_avg);
-		batadv_throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
+		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
+				    gw_addr);
 	} else {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Changing route to gateway %pM (gw_flags: %i, tq: %i)\n",
 			   next_gw->orig_node->orig,
 			   next_gw->orig_node->gw_flags, router->tq_avg);
-		batadv_throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
+		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
+				    gw_addr);
 	}
 
 	batadv_gw_select(bat_priv, next_gw);
@@ -283,7 +286,7 @@ void batadv_gw_check_election(struct bat_priv *bat_priv,
 	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
 		goto out;
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i)\n",
 		   gw_tq_avg, orig_tq_avg);
 
@@ -320,7 +323,7 @@ static void batadv_gw_node_add(struct bat_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->gw_list_lock);
 
 	batadv_gw_bandwidth_to_kbit(new_gwflags, &down, &up);
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw_class: %i - %i%s/%i%s\n",
 		   orig_node->orig, new_gwflags,
 		   (down > 2048 ? down / 1024 : down),
@@ -347,7 +350,7 @@ void batadv_gw_node_update(struct bat_priv *bat_priv,
 		if (gw_node->orig_node != orig_node)
 			continue;
 
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Gateway class of originator %pM changed from %i to %i\n",
 			   orig_node->orig, gw_node->orig_node->gw_flags,
 			   new_gwflags);
@@ -356,7 +359,7 @@ void batadv_gw_node_update(struct bat_priv *bat_priv,
 
 		if (new_gwflags == BATADV_NO_FLAGS) {
 			gw_node->deleted = jiffies;
-			batadv_dbg(DBG_BATMAN, bat_priv,
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 				   "Gateway %pM removed from gateway list\n",
 				   orig_node->orig);
 
@@ -403,7 +406,7 @@ void batadv_gw_node_purge(struct bat_priv *bat_priv)
 				  &bat_priv->gw_list, list) {
 		if (((!gw_node->deleted) ||
 		     (time_before(jiffies, gw_node->deleted + timeout))) &&
-		    atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE)
+		    atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE)
 			continue;
 
 		if (curr_gw == gw_node)
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index a64cce2..61b52b3 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -158,7 +158,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	size_t packet_len = sizeof(struct icmp_packet);
 
 	if (len < sizeof(struct icmp_packet)) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: invalid packet size\n");
 		return -EINVAL;
 	}
@@ -188,14 +188,14 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	}
 
 	if (icmp_packet->header.packet_type != BATADV_ICMP) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
 		len = -EINVAL;
 		goto free_skb;
 	}
 
 	if (icmp_packet->msg_type != BATADV_ECHO_REQUEST) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
 		len = -EINVAL;
 		goto free_skb;
@@ -211,7 +211,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		goto free_skb;
 	}
 
-	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dst_unreach;
 
 	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->dst);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index b3f0a2e..24d651d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -132,7 +132,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 		goto err;
 
 	atomic_set(&bat_priv->gw_reselect, 0);
-	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
+	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
 	return 0;
 
@@ -145,7 +145,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 
-	atomic_set(&bat_priv->mesh_state, MESH_DEACTIVATING);
+	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 
@@ -160,7 +160,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	free_percpu(bat_priv->bat_counters);
 
-	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
+	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
 void batadv_inc_module_count(void)
@@ -230,7 +230,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto err_free;
 
 	/* discard frames on not active interfaces */
@@ -240,7 +240,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	batman_ogm_packet = (struct batman_ogm_packet *)skb->data;
 
 	if (batman_ogm_packet->header.version != BATADV_COMPAT_VERSION) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: incompatible batman version (%i)\n",
 			   batman_ogm_packet->header.version);
 		goto err_free;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 09660b4..68e13ac 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -95,23 +95,23 @@
 #define BATADV_RESET_PROTECTION_MS 30000
 #define BATADV_EXPECTED_SEQNO_RANGE	65536
 
-enum mesh_state {
-	MESH_INACTIVE,
-	MESH_ACTIVE,
-	MESH_DEACTIVATING
+enum batadv_mesh_state {
+	BATADV_MESH_INACTIVE,
+	BATADV_MESH_ACTIVE,
+	BATADV_MESH_DEACTIVATING,
 };
 
 #define BATADV_BCAST_QUEUE_LEN		256
 #define BATADV_BATMAN_QUEUE_LEN	256
 
-enum uev_action {
-	UEV_ADD = 0,
-	UEV_DEL,
-	UEV_CHANGE
+enum batadv_uev_action {
+	BATADV_UEV_ADD = 0,
+	BATADV_UEV_DEL,
+	BATADV_UEV_CHANGE,
 };
 
-enum uev_type {
-	UEV_GW = 0
+enum batadv_uev_type {
+	BATADV_UEV_GW = 0,
 };
 
 #define BATADV_GW_THRESHOLD	50
@@ -124,12 +124,12 @@ enum uev_type {
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 /* all messages related to routing / flooding / broadcasting / etc */
-enum dbg_level {
-	DBG_BATMAN = 1 << 0,
-	DBG_ROUTES = 1 << 1, /* route added / changed / deleted */
-	DBG_TT	   = 1 << 2, /* translation table operations */
-	DBG_BLA    = 1 << 3, /* bridge loop avoidance */
-	DBG_ALL    = 15
+enum batadv_dbg_level {
+	BATADV_DBG_BATMAN = 1 << 0,
+	BATADV_DBG_ROUTES = 1 << 1, /* route added / changed / deleted */
+	BATADV_DBG_TT	  = 1 << 2, /* translation table operations */
+	BATADV_DBG_BLA    = 1 << 3, /* bridge loop avoidance */
+	BATADV_DBG_ALL    = 15,
 };
 
 /* Kernel headers */
@@ -195,14 +195,14 @@ static inline void batadv_dbg(int type __always_unused,
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
 		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
-		batadv_dbg(DBG_ALL, _batpriv, fmt, ## arg);		\
+		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_info("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
 #define batadv_err(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
 		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
-		batadv_dbg(DBG_ALL, _batpriv, fmt, ## arg);		\
+		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_err("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 9e60cc0..4ddea31 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -102,7 +102,7 @@ struct neigh_node *batadv_neigh_node_new(struct hard_iface *hard_iface,
 	/* extra reference for return */
 	atomic_set(&neigh_node->refcount, 2);
 
-	batadv_dbg(DBG_BATMAN, bat_priv,
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Creating new neighbor %pM, initial seqno %d\n",
 		   neigh_addr, seqno);
 
@@ -200,8 +200,8 @@ struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
 	if (orig_node)
 		return orig_node;
 
-	batadv_dbg(DBG_BATMAN, bat_priv, "Creating new originator: %pM\n",
-		   addr);
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Creating new originator: %pM\n", addr);
 
 	orig_node = kzalloc(sizeof(*orig_node), GFP_ATOMIC);
 	if (!orig_node)
@@ -293,12 +293,12 @@ static bool batadv_purge_orig_neighbors(struct bat_priv *bat_priv,
 			if ((if_incoming->if_status == BATADV_IF_INACTIVE) ||
 			    (if_incoming->if_status == BATADV_IF_NOT_IN_USE) ||
 			    (if_incoming->if_status == BATADV_IF_TO_BE_REMOVED))
-				batadv_dbg(DBG_BATMAN, bat_priv,
+				batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 					   "neighbor purge: originator %pM, neighbor: %pM, iface: %s\n",
 					   orig_node->orig, neigh_node->addr,
 					   if_incoming->net_dev->name);
 			else
-				batadv_dbg(DBG_BATMAN, bat_priv,
+				batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 					   "neighbor timeout: originator %pM, neighbor: %pM, last_seen: %u\n",
 					   orig_node->orig, neigh_node->addr,
 					   jiffies_to_msecs(last_seen));
@@ -326,7 +326,7 @@ static bool batadv_purge_orig_node(struct bat_priv *bat_priv,
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Originator timeout: originator %pM, last_seen %u\n",
 			   orig_node->orig,
 			   jiffies_to_msecs(orig_node->last_seen));
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 8e43a95..b8c47dc 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -72,20 +72,20 @@ static void _batadv_update_route(struct bat_priv *bat_priv,
 
 	/* route deleted */
 	if ((curr_router) && (!neigh_node)) {
-		batadv_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
-			   orig_node->orig);
+		batadv_dbg(BATADV_DBG_ROUTES, bat_priv,
+			   "Deleting route towards: %pM\n", orig_node->orig);
 		batadv_tt_global_del_orig(bat_priv, orig_node,
 					  "Deleted route towards originator");
 
 	/* route added */
 	} else if ((!curr_router) && (neigh_node)) {
 
-		batadv_dbg(DBG_ROUTES, bat_priv,
+		batadv_dbg(BATADV_DBG_ROUTES, bat_priv,
 			   "Adding route towards: %pM (via %pM)\n",
 			   orig_node->orig, neigh_node->addr);
 	/* route changed */
 	} else if (neigh_node && curr_router) {
-		batadv_dbg(DBG_ROUTES, bat_priv,
+		batadv_dbg(BATADV_DBG_ROUTES, bat_priv,
 			   "Changing route towards: %pM (now via %pM - was via %pM)\n",
 			   orig_node->orig, neigh_node->addr,
 			   curr_router->addr);
@@ -240,7 +240,7 @@ int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 			return 1;
 
 		*last_reset = jiffies;
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "old packet received, start protection\n");
 	}
 
@@ -618,7 +618,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 			else
 				tt_flag = '.';
 
-			batadv_dbg(DBG_TT, bat_priv,
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Routing TT_REQUEST to %pM [%c]\n",
 				   tt_query->dst,
 				   tt_flag);
@@ -650,7 +650,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 				tt_flag =  'F';
 			else
 				tt_flag = '.';
-			batadv_dbg(DBG_TT, bat_priv,
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Routing TT_RESPONSE to %pM [%c]\n",
 				   tt_query->dst,
 				   tt_flag);
@@ -703,7 +703,7 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (!orig_node)
 		goto out;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received ROAMING_ADV from %pM (client %pM)\n",
 		   roam_adv_packet->src, roam_adv_packet->client);
 
@@ -992,7 +992,7 @@ static int batadv_check_unicast_ttvn(struct bat_priv *bat_priv,
 			batadv_orig_node_free_ref(orig_node);
 		}
 
-		batadv_dbg(DBG_ROUTES, bat_priv,
+		batadv_dbg(BATADV_DBG_ROUTES, bat_priv,
 			   "TTVN mismatch (old_ttvn %u new_ttvn %u)! Rerouting unicast packet (for %pM) to %pM\n",
 			   unicast_packet->ttvn, curr_ttvn, ethhdr->h_dest,
 			   unicast_packet->dest);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 8de6e25..aad9818 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -142,7 +142,8 @@ int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
 	struct sk_buff *newskb;
 
 	if (!batadv_atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
-		batadv_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "bcast packet queue full\n");
 		goto out;
 	}
 
@@ -199,7 +200,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
-	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	/* rebroadcast packet */
@@ -243,7 +244,7 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
-	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	bat_priv->bat_algo_ops->bat_ogm_emit(forw_packet);
@@ -271,11 +272,11 @@ void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
 	bool pending;
 
 	if (hard_iface)
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "purge_outstanding_packets(): %s\n",
 			   hard_iface->net_dev->name);
 	else
-		batadv_dbg(DBG_BATMAN, bat_priv,
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "purge_outstanding_packets()\n");
 
 	/* free bcast list */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 3aae91d..0a00324 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -105,7 +105,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 		return -EADDRNOTAVAIL;
 
 	/* only modify transtable if it has been initialized before */
-	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE) {
 		batadv_tt_local_remove(bat_priv, dev->dev_addr,
 				       "mac address changed", false);
 		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX);
@@ -143,7 +143,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	short vid __maybe_unused = -1;
 	bool do_bcast = false;
 
-	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
 	soft_iface->trans_start = jiffies;
@@ -398,7 +398,7 @@ struct net_device *batadv_softif_create(const char *name)
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
-	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
+	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->ttvn, 0);
 	atomic_set(&bat_priv->tt_local_changes, 0);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 309d691..6d03cb1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -252,7 +252,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new local tt entry: %pM (ttvn: %d)\n", addr,
 		   (uint8_t)atomic_read(&bat_priv->ttvn));
 
@@ -484,7 +484,7 @@ static void batadv_tt_local_set_pending(struct bat_priv *bat_priv,
 	 */
 	tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM) pending to be removed: %s\n",
 		   tt_local_entry->common.addr, message);
 }
@@ -726,7 +726,7 @@ int batadv_tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 							orig_node, ttvn);
 	}
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (via %pM)\n",
 		   tt_global_entry->common.addr, orig_node->orig);
 
@@ -856,7 +856,7 @@ batadv_tt_global_del_orig_entry(struct bat_priv *bat_priv,
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_safe(orig_entry, node, safe, head, list) {
 		if (orig_entry->orig_node == orig_node) {
-			batadv_dbg(DBG_TT, bat_priv,
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Deleting %pM from global tt entry %pM: %s\n",
 				   orig_node->orig,
 				   tt_global_entry->common.addr, message);
@@ -871,7 +871,8 @@ static void batadv_tt_global_del_struct(struct bat_priv *bat_priv,
 					struct tt_global_entry *tt_global_entry,
 					const char *message)
 {
-	batadv_dbg(DBG_TT, bat_priv, "Deleting global tt entry %pM: %s\n",
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Deleting global tt entry %pM: %s\n",
 		   tt_global_entry->common.addr, message);
 
 	batadv_hash_remove(bat_priv->tt_global_hash, batadv_compare_tt,
@@ -1006,7 +1007,7 @@ void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
 							orig_node, message);
 
 			if (hlist_empty(&global_entry->orig_list)) {
-				batadv_dbg(DBG_TT, bat_priv,
+				batadv_dbg(BATADV_DBG_TT, bat_priv,
 					   "Deleting global tt entry %pM: %s\n",
 					   global_entry->common.addr, message);
 				hlist_del_rcu(node);
@@ -1035,7 +1036,7 @@ static void batadv_tt_global_roam_purge_list(struct bat_priv *bat_priv,
 					  BATADV_TT_CLIENT_ROAM_TIMEOUT))
 			continue;
 
-		batadv_dbg(DBG_TT, bat_priv,
+		batadv_dbg(BATADV_DBG_TT, bat_priv,
 			   "Deleting global tt entry (%pM): Roaming timeout\n",
 			   tt_global_entry->common.addr);
 
@@ -1471,7 +1472,7 @@ static int batadv_send_tt_request(struct bat_priv *bat_priv,
 	if (!neigh_node)
 		goto out;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Sending TT_REQUEST to %pM via %pM [%c]\n",
 		   dst_orig_node->orig, neigh_node->addr,
 		   (full_table ? 'F' : '.'));
@@ -1511,7 +1512,7 @@ static bool batadv_send_other_tt_response(struct bat_priv *bat_priv,
 	struct sk_buff *skb = NULL;
 	struct tt_query_packet *tt_response;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (%pM) [%c]\n",
 		   tt_request->src, tt_request->ttvn, tt_request->dst,
 		   (tt_request->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
@@ -1599,7 +1600,7 @@ static bool batadv_send_other_tt_response(struct bat_priv *bat_priv,
 	if (full_table)
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Sending TT_RESPONSE %pM via %pM for %pM (ttvn: %u)\n",
 		   res_dst_orig_node->orig, neigh_node->addr,
 		   req_dst_orig_node->orig, req_ttvn);
@@ -1641,7 +1642,7 @@ static bool batadv_send_my_tt_response(struct bat_priv *bat_priv,
 	struct sk_buff *skb = NULL;
 	struct tt_query_packet *tt_response;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (me) [%c]\n",
 		   tt_request->src, tt_request->ttvn,
 		   (tt_request->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
@@ -1720,7 +1721,7 @@ static bool batadv_send_my_tt_response(struct bat_priv *bat_priv,
 	if (full_table)
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Sending TT_RESPONSE to %pM via %pM [%c]\n",
 		   orig_node->orig, neigh_node->addr,
 		   (tt_response->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
@@ -1860,7 +1861,7 @@ void batadv_handle_tt_response(struct bat_priv *bat_priv,
 	struct tt_req_node *node, *safe;
 	struct orig_node *orig_node = NULL;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
 		   tt_response->src, tt_response->ttvn,
 		   ntohs(tt_response->tt_data),
@@ -2039,7 +2040,7 @@ static void batadv_send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 	if (!neigh_node)
 		goto out;
 
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
 		   orig_node->orig, client, neigh_node->addr);
 
@@ -2146,7 +2147,7 @@ static void batadv_tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 			if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
 				continue;
 
-			batadv_dbg(DBG_TT, bat_priv,
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Deleting local tt entry (%pM): pending\n",
 				   tt_common->addr);
 
@@ -2181,7 +2182,7 @@ static int batadv_tt_commit_changes(struct bat_priv *bat_priv,
 
 	/* Increment the TTVN only once per OGM interval */
 	atomic_inc(&bat_priv->ttvn);
-	batadv_dbg(DBG_TT, bat_priv,
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local changes committed, updating to ttvn %u\n",
 		   (uint8_t)atomic_read(&bat_priv->ttvn));
 	bat_priv->tt_poss_change = false;
@@ -2306,7 +2307,7 @@ void batadv_tt_update_orig(struct bat_priv *bat_priv,
 		if (!orig_node->tt_initialised || ttvn != orig_ttvn ||
 		    orig_node->tt_crc != tt_crc) {
 request_table:
-			batadv_dbg(DBG_TT, bat_priv,
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "TT inconsistency for %pM. Need to retrieve the correct information (ttvn: %u last_ttvn: %u crc: %u last_crc: %u num_changes: %u)\n",
 				   orig_node->orig, ttvn, orig_ttvn, tt_crc,
 				   orig_node->tt_crc, tt_num_changes);
-- 
1.7.9.4

