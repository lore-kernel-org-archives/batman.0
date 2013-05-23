Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 23 May 2013 13:07:42 +0200
Message-Id: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: forward late OGMs from best
	next hop
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

When a packet is received from another node first and later from the
best next hop, this packet is dropped. However the first OGM was sent
with the BATADV_NOT_BEST_NEXT_HOP flag and thus dropped by neighbors.
The late OGM from the best neighbor is then dropped because it is a
duplicate.

If this situation happens constantly, a node might end up not forwarding
the "valid" OGMs anymore, and nodes behind will starve from not getting
valid OGMs.

Fix this by refining the duplicate checking behaviour: The actions
should depend on whether it was a duplicate for a neighbor only or for
the originator. OGMs which are not duplicates for a specific neighbor
will now be considered in batadv_iv_ogm_forward(), but only actually
forwarded for the best next hop. Therefore, late OGMs from the best
next hop are forwarded now and not dropped as duplicates anymore.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>

---
Changes to PATCHv1:
 * use enum to distinguish different duplicate states
 * fix typo "is_simlar -> is_similar"
 * remove antonios sign off (the patch changed, feel free to add it if
   he is ok with it, it was his idea originally ...)
---
 bat_iv_ogm.c |   86 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8d87f87..2b94fdd 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -701,6 +701,21 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 		batadv_hardif_free_ref(primary_if);
 }
 
+/**
+ * batadv_dup_status - duplicate status
+ * @BATADV_NO_DUP: the packet is a duplicate
+ * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for the
+ *  neighbor)
+ * @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor
+ * @BATADV_PROTECTED: originator is currently protected (after reboot)
+ */
+enum batadv_dup_status {
+	BATADV_NO_DUP = 0,
+	BATADV_ORIG_DUP,
+	BATADV_NEIGH_DUP,
+	BATADV_PROTECTED,
+};
+
 static void
 batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
@@ -708,7 +723,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  const struct batadv_ogm_packet *batadv_ogm_packet,
 			  struct batadv_hard_iface *if_incoming,
 			  const unsigned char *tt_buff,
-			  int is_duplicate)
+			  enum batadv_dup_status dup_status)
 {
 	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
@@ -734,7 +749,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			continue;
 		}
 
-		if (is_duplicate)
+		if (dup_status != BATADV_NO_DUP)
 			continue;
 
 		spin_lock_bh(&tmp_neigh_node->lq_update_lock);
@@ -774,7 +789,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	neigh_node->tq_avg = batadv_ring_buffer_avg(neigh_node->tq_recv);
 	spin_unlock_bh(&neigh_node->lq_update_lock);
 
-	if (!is_duplicate) {
+	if (dup_status == BATADV_NO_DUP) {
 		orig_node->last_ttl = batadv_ogm_packet->header.ttl;
 		neigh_node->last_ttl = batadv_ogm_packet->header.ttl;
 	}
@@ -932,15 +947,16 @@ out:
 	return ret;
 }
 
-/* processes a batman packet for all interfaces, adjusts the sequence number and
- * finds out whether it is a duplicate.
+/**
+ * batadv_iv_ogm_update_seqnos -  processes a batman packet for all interfaces,
+ *  adjusts the sequence number and finds out whether it is a duplicate.
+ * @ethhdr: Ethernet header of the packet
+ * @batadv_ogm_packet: OGM packet to be considered
+ * @if_incoming: interface where the OGM packet was received
+ * Returns: duplicate status as enum batadv_dup_status
  * returns:
- *   1 the packet is a duplicate
- *   0 the packet has not yet been received
- *  -1 the packet is old and has been received while the seqno window
- *     was protected. Caller should drop it.
- */
-static int
+  */
+enum batadv_dup_status
 batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			    const struct batadv_ogm_packet *batadv_ogm_packet,
 			    const struct batadv_hard_iface *if_incoming)
@@ -948,17 +964,18 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *tmp_neigh_node;
-	int is_duplicate = 0;
+	int is_dup;
 	int32_t seq_diff;
 	int need_update = 0;
-	int set_mark, ret = -1;
+	int set_mark;
+	enum batadv_dup_status ret = BATADV_NO_DUP;
 	uint32_t seqno = ntohl(batadv_ogm_packet->seqno);
 	uint8_t *neigh_addr;
 	uint8_t packet_count;
 
 	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
-		return 0;
+		return BATADV_NO_DUP;
 
 	spin_lock_bh(&orig_node->ogm_cnt_lock);
 	seq_diff = seqno - orig_node->last_real_seqno;
@@ -966,22 +983,29 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	/* signalize caller that the packet is to be dropped. */
 	if (!hlist_empty(&orig_node->neigh_list) &&
 	    batadv_window_protected(bat_priv, seq_diff,
-				    &orig_node->batman_seqno_reset))
+				    &orig_node->batman_seqno_reset)) {
+		ret = BATADV_PROTECTED;
 		goto out;
+	}
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node,
 				 &orig_node->neigh_list, list) {
-		is_duplicate |= batadv_test_bit(tmp_neigh_node->real_bits,
-						orig_node->last_real_seqno,
-						seqno);
-
 		neigh_addr = tmp_neigh_node->addr;
+		is_dup = batadv_test_bit(tmp_neigh_node->real_bits,
+					 orig_node->last_real_seqno,
+					 seqno);
+
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
-		    tmp_neigh_node->if_incoming == if_incoming)
+		    tmp_neigh_node->if_incoming == if_incoming) {
 			set_mark = 1;
-		else
+			if (is_dup)
+				ret = BATADV_NEIGH_DUP;
+		} else {
 			set_mark = 0;
+			if (is_dup && (ret != BATADV_NEIGH_DUP))
+				ret = BATADV_ORIG_DUP;
+		}
 
 		/* if the window moved, set the update flag. */
 		need_update |= batadv_bit_get_packet(bat_priv,
@@ -1001,8 +1025,6 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		orig_node->last_real_seqno = seqno;
 	}
 
-	ret = is_duplicate;
-
 out:
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
 	batadv_orig_node_free_ref(orig_node);
@@ -1024,7 +1046,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	int is_bidirect;
 	bool is_single_hop_neigh = false;
 	bool is_from_best_next_hop = false;
-	int is_duplicate, sameseq, simlar_ttl;
+	int sameseq, similar_ttl;
+	enum batadv_dup_status dup_status;
 	uint32_t if_incoming_seqno;
 	uint8_t *prev_sender;
 
@@ -1149,10 +1172,10 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (!orig_node)
 		return;
 
-	is_duplicate = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
-						   if_incoming);
+	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
+						 if_incoming);
 
-	if (is_duplicate == -1) {
+	if (dup_status == BATADV_PROTECTED) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: packet within seqno protection time (sender: %pM)\n",
 			   ethhdr->h_source);
@@ -1224,11 +1247,12 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	 * seqno and similar ttl as the non-duplicate
 	 */
 	sameseq = orig_node->last_real_seqno == ntohl(batadv_ogm_packet->seqno);
-	simlar_ttl = orig_node->last_ttl - 3 <= batadv_ogm_packet->header.ttl;
-	if (is_bidirect && (!is_duplicate || (sameseq && simlar_ttl)))
+	similar_ttl = orig_node->last_ttl - 3 <= batadv_ogm_packet->header.ttl;
+	if (is_bidirect && ((dup_status == BATADV_NO_DUP) ||
+			    (sameseq && similar_ttl)))
 		batadv_iv_ogm_orig_update(bat_priv, orig_node, ethhdr,
 					  batadv_ogm_packet, if_incoming,
-					  tt_buff, is_duplicate);
+					  tt_buff, dup_status);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
@@ -1249,7 +1273,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		goto out_neigh;
 	}
 
-	if (is_duplicate) {
+	if (dup_status == BATADV_NEIGH_DUP) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: duplicate packet received\n");
 		goto out_neigh;
-- 
1.7.10.4

