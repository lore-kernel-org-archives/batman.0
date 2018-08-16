Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 16 Aug 2018 16:54:45 +0200
Message-Id: <20180816145445.27289-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Move OGM rebroadcast stats to
 orig_ifinfo
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

B.A.T.M.A.N. IV requires the number of rebroadcast from a neighboring
originator. These statistics are gathered per interface which transmitted
the OGM (and then received it again). Since an originator is not interface
specific, a resizable array was used in each originator.

This resizable array had an entry for each interface and had to be resizes
(for all OGMs) when the number of active interface was modified. This could
cause problems when a large number of interface is added and not enough
continuous memory is available to allocate the array.

There is already a per interface originator structure "batadv_orig_ifinfo"
which can be used to store this information.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     | 330 ++++++++++----------------------
 net/batman-adv/hard-interface.c |  47 +++--
 net/batman-adv/originator.c     | 107 -----------
 net/batman-adv/originator.h     |   4 -
 net/batman-adv/soft-interface.c |   1 -
 net/batman-adv/types.h          |  62 ++----
 6 files changed, 145 insertions(+), 406 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 73bf6a93..d2227091 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -137,169 +137,6 @@ static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
 	return (u8)(sum / count);
 }
 
-/**
- * batadv_iv_ogm_orig_free() - free the private resources allocated for this
- *  orig_node
- * @orig_node: the orig_node for which the resources have to be free'd
- */
-static void batadv_iv_ogm_orig_free(struct batadv_orig_node *orig_node)
-{
-	kfree(orig_node->bat_iv.bcast_own);
-	kfree(orig_node->bat_iv.bcast_own_sum);
-}
-
-/**
- * batadv_iv_ogm_orig_add_if() - change the private structures of the orig_node
- *  to include the new hard-interface
- * @orig_node: the orig_node that has to be changed
- * @max_if_num: the current amount of interfaces
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
-				     unsigned int max_if_num)
-{
-	void *data_ptr;
-	size_t old_size;
-	int ret = -ENOMEM;
-
-	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-
-	old_size = (max_if_num - 1) * sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc_array(max_if_num,
-				 BATADV_NUM_WORDS * sizeof(unsigned long),
-				 GFP_ATOMIC);
-	if (!data_ptr)
-		goto unlock;
-
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own, old_size);
-	kfree(orig_node->bat_iv.bcast_own);
-	orig_node->bat_iv.bcast_own = data_ptr;
-
-	data_ptr = kmalloc_array(max_if_num, sizeof(u8), GFP_ATOMIC);
-	if (!data_ptr)
-		goto unlock;
-
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
-	       (max_if_num - 1) * sizeof(u8));
-	kfree(orig_node->bat_iv.bcast_own_sum);
-	orig_node->bat_iv.bcast_own_sum = data_ptr;
-
-	ret = 0;
-
-unlock:
-	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-
-	return ret;
-}
-
-/**
- * batadv_iv_ogm_drop_bcast_own_entry() - drop section of bcast_own
- * @orig_node: the orig_node that has to be changed
- * @max_if_num: the current amount of interfaces
- * @del_if_num: the index of the interface being removed
- */
-static void
-batadv_iv_ogm_drop_bcast_own_entry(struct batadv_orig_node *orig_node,
-				   unsigned int max_if_num,
-				   unsigned int del_if_num)
-{
-	size_t chunk_size;
-	size_t if_offset;
-	void *data_ptr;
-
-	lockdep_assert_held(&orig_node->bat_iv.ogm_cnt_lock);
-
-	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc_array(max_if_num, chunk_size, GFP_ATOMIC);
-	if (!data_ptr)
-		/* use old buffer when new one could not be allocated */
-		data_ptr = orig_node->bat_iv.bcast_own;
-
-	/* copy first part */
-	memmove(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
-
-	/* copy second part */
-	if_offset = (del_if_num + 1) * chunk_size;
-	memmove((char *)data_ptr + del_if_num * chunk_size,
-		(uint8_t *)orig_node->bat_iv.bcast_own + if_offset,
-		(max_if_num - del_if_num) * chunk_size);
-
-	/* bcast_own was shrunk down in new buffer; free old one */
-	if (orig_node->bat_iv.bcast_own != data_ptr) {
-		kfree(orig_node->bat_iv.bcast_own);
-		orig_node->bat_iv.bcast_own = data_ptr;
-	}
-}
-
-/**
- * batadv_iv_ogm_drop_bcast_own_sum_entry() - drop section of bcast_own_sum
- * @orig_node: the orig_node that has to be changed
- * @max_if_num: the current amount of interfaces
- * @del_if_num: the index of the interface being removed
- */
-static void
-batadv_iv_ogm_drop_bcast_own_sum_entry(struct batadv_orig_node *orig_node,
-				       unsigned int max_if_num,
-				       unsigned int del_if_num)
-{
-	size_t if_offset;
-	void *data_ptr;
-
-	lockdep_assert_held(&orig_node->bat_iv.ogm_cnt_lock);
-
-	data_ptr = kmalloc_array(max_if_num, sizeof(u8), GFP_ATOMIC);
-	if (!data_ptr)
-		/* use old buffer when new one could not be allocated */
-		data_ptr = orig_node->bat_iv.bcast_own_sum;
-
-	memmove(data_ptr, orig_node->bat_iv.bcast_own_sum,
-		del_if_num * sizeof(u8));
-
-	if_offset = (del_if_num + 1) * sizeof(u8);
-	memmove((char *)data_ptr + del_if_num * sizeof(u8),
-		orig_node->bat_iv.bcast_own_sum + if_offset,
-		(max_if_num - del_if_num) * sizeof(u8));
-
-	/* bcast_own_sum was shrunk down in new buffer; free old one */
-	if (orig_node->bat_iv.bcast_own_sum != data_ptr) {
-		kfree(orig_node->bat_iv.bcast_own_sum);
-		orig_node->bat_iv.bcast_own_sum = data_ptr;
-	}
-}
-
-/**
- * batadv_iv_ogm_orig_del_if() - change the private structures of the orig_node
- *  to exclude the removed interface
- * @orig_node: the orig_node that has to be changed
- * @max_if_num: the current amount of interfaces
- * @del_if_num: the index of the interface being removed
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
-				     unsigned int max_if_num,
-				     unsigned int del_if_num)
-{
-	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-
-	if (max_if_num == 0) {
-		kfree(orig_node->bat_iv.bcast_own);
-		kfree(orig_node->bat_iv.bcast_own_sum);
-		orig_node->bat_iv.bcast_own = NULL;
-		orig_node->bat_iv.bcast_own_sum = NULL;
-	} else {
-		batadv_iv_ogm_drop_bcast_own_entry(orig_node, max_if_num,
-						   del_if_num);
-		batadv_iv_ogm_drop_bcast_own_sum_entry(orig_node, max_if_num,
-						       del_if_num);
-	}
-
-	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-
-	return 0;
-}
-
 /**
  * batadv_iv_ogm_orig_get() - retrieve or create (if does not exist) an
  *  originator
@@ -315,7 +152,6 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
 	int hash_added;
-	size_t size;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
@@ -327,16 +163,6 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 
 	spin_lock_init(&orig_node->bat_iv.ogm_cnt_lock);
 
-	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
-	orig_node->bat_iv.bcast_own = kzalloc(size, GFP_ATOMIC);
-	if (!orig_node->bat_iv.bcast_own)
-		goto free_orig_node;
-
-	size = bat_priv->num_ifaces * sizeof(u8);
-	orig_node->bat_iv.bcast_own_sum = kzalloc(size, GFP_ATOMIC);
-	if (!orig_node->bat_iv.bcast_own_sum)
-		goto free_orig_node;
-
 	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
@@ -347,8 +173,9 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 	return orig_node;
 
 free_orig_node_hash:
+	/* reference for batadv_hash_add */
 	batadv_orig_node_put(orig_node);
-free_orig_node:
+	/* reference from batadv_orig_node_new */
 	batadv_orig_node_put(orig_node);
 
 	return NULL;
@@ -893,26 +720,30 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
+	struct batadv_orig_ifinfo *orig_ifinfo;
 	unsigned long *word;
 	u32 i;
-	size_t word_index;
 	u8 *w;
-	unsigned int if_num;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
-			word = &orig_node->bat_iv.bcast_own[word_index];
-
-			batadv_bit_get_packet(bat_priv, word, 1, 0);
-			if_num = hard_iface->if_num;
-			w = &orig_node->bat_iv.bcast_own_sum[if_num];
-			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+			hlist_for_each_entry_rcu(orig_ifinfo,
+						 &orig_node->ifinfo_list,
+						 list) {
+				if (orig_ifinfo->if_outgoing != hard_iface)
+					continue;
+
+				spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+				word = orig_ifinfo->bat_iv.bcast_own;
+				batadv_bit_get_packet(bat_priv, word, 1, 0);
+				w = &orig_ifinfo->bat_iv.bcast_own_sum;
+				*w = bitmap_weight(word,
+						   BATADV_TQ_LOCAL_WINDOW_SIZE);
+				spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+			}
 		}
 		rcu_read_unlock();
 	}
@@ -999,6 +830,35 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 		batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_iv_orig_ifinfo_sum() - Get bcast_own sum for originator over iterface
+ * @orig_node: originator which reproadcasted the OGMs directly
+ * @if_outgoing: interface which transmitted the original OGM and received the
+ *  direct rebroadcast
+ *
+ * Return: Number of replied (rebroadcasted) OGMs which were transmitted by
+ *  an originator and directly (without intermediate hop) received by a specific
+ *  interface
+ */
+static u8 batadv_iv_orig_ifinfo_sum(struct batadv_orig_node *orig_node,
+				    struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_orig_ifinfo *orig_ifinfo;
+	u8 sum;
+
+	orig_ifinfo = batadv_orig_ifinfo_get(orig_node, if_outgoing);
+	if (!orig_ifinfo)
+		return 0;
+
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+	sum = orig_ifinfo->bat_iv.bcast_own_sum;
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+
+	batadv_orig_ifinfo_put(orig_ifinfo);
+
+	return sum;
+}
+
 /**
  * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
@@ -1026,8 +886,6 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_neigh_node *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
-	struct batadv_orig_node *orig_node_tmp;
-	unsigned int if_num;
 	u8 sum_orig, sum_neigh;
 	u8 *neigh_addr;
 	u8 tq_avg;
@@ -1132,18 +990,10 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	 */
 	if (router_ifinfo &&
 	    neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg) {
-		orig_node_tmp = router->orig_node;
-		spin_lock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
-		if_num = router->if_incoming->if_num;
-		sum_orig = orig_node_tmp->bat_iv.bcast_own_sum[if_num];
-		spin_unlock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
-
-		orig_node_tmp = neigh_node->orig_node;
-		spin_lock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
-		if_num = neigh_node->if_incoming->if_num;
-		sum_neigh = orig_node_tmp->bat_iv.bcast_own_sum[if_num];
-		spin_unlock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
-
+		sum_orig = batadv_iv_orig_ifinfo_sum(router->orig_node,
+						     router->if_incoming);
+		sum_neigh = batadv_iv_orig_ifinfo_sum(neigh_node->orig_node,
+						      neigh_node->if_incoming);
 		if (sum_orig >= sum_neigh)
 			goto out;
 	}
@@ -1186,7 +1036,6 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	unsigned int if_num;
 	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
 	unsigned int tq_iface_penalty;
@@ -1227,9 +1076,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	orig_node->last_seen = jiffies;
 
 	/* find packet count of corresponding one hop neighbor */
-	spin_lock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
-	if_num = if_incoming->if_num;
-	orig_eq_count = orig_neigh_node->bat_iv.bcast_own_sum[if_num];
+	orig_eq_count = batadv_iv_orig_ifinfo_sum(orig_neigh_node, if_incoming);
 	neigh_ifinfo = batadv_neigh_ifinfo_new(neigh_node, if_outgoing);
 	if (neigh_ifinfo) {
 		neigh_rq_count = neigh_ifinfo->bat_iv.real_packet_count;
@@ -1237,7 +1084,6 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	} else {
 		neigh_rq_count = 0;
 	}
-	spin_unlock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
 
 	/* pay attention to not get a value bigger than 100 % */
 	if (orig_eq_count > neigh_rq_count)
@@ -1621,6 +1467,49 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 	consume_skb(skb_priv);
 }
 
+/**
+ * batadv_iv_ogm_process_reply() - Check OGM for direct reply and process it
+ * @ogm_packet: rebroadcast OGM packet to process
+ * @if_incoming: the interface where this packet was received
+ * @orig_node: originator which reproadcasted the OGMs
+ * @if_incoming_seqno: OGM sequence number when rebroadcast was received
+ */
+static void batadv_iv_ogm_process_reply(struct batadv_ogm_packet *ogm_packet,
+					struct batadv_hard_iface *if_incoming,
+					struct batadv_orig_node *orig_node,
+					u32 if_incoming_seqno)
+{
+	struct batadv_orig_ifinfo *orig_ifinfo;
+	s32 bit_pos;
+	u8 *weight;
+
+	/* neighbor has to indicate direct link and it has to
+	 * come via the corresponding interface
+	 */
+	if (!(ogm_packet->flags & BATADV_DIRECTLINK))
+		return;
+
+	if (!batadv_compare_eth(if_incoming->net_dev->dev_addr,
+				ogm_packet->orig))
+		return;
+
+	orig_ifinfo = batadv_orig_ifinfo_get(orig_node, if_incoming);
+	if (!orig_ifinfo)
+		return;
+
+	/* save packet seqno for bidirectional check */
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+	bit_pos = if_incoming_seqno - 2;
+	bit_pos -= ntohl(ogm_packet->seqno);
+	batadv_set_bit(orig_ifinfo->bat_iv.bcast_own, bit_pos);
+	weight = &orig_ifinfo->bat_iv.bcast_own_sum;
+	*weight = bitmap_weight(orig_ifinfo->bat_iv.bcast_own,
+				BATADV_TQ_LOCAL_WINDOW_SIZE);
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+
+	batadv_orig_ifinfo_put(orig_ifinfo);
+}
+
 /**
  * batadv_iv_ogm_process() - process an incoming batman iv OGM
  * @skb: the skb containing the OGM
@@ -1705,37 +1594,13 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	}
 
 	if (is_my_orig) {
-		unsigned long *word;
-		size_t offset;
-		s32 bit_pos;
-		unsigned int if_num;
-		u8 *weight;
-
 		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
 							 ethhdr->h_source);
 		if (!orig_neigh_node)
 			return;
 
-		/* neighbor has to indicate direct link and it has to
-		 * come via the corresponding interface
-		 * save packet seqno for bidirectional check
-		 */
-		if (has_directlink_flag &&
-		    batadv_compare_eth(if_incoming->net_dev->dev_addr,
-				       ogm_packet->orig)) {
-			if_num = if_incoming->if_num;
-			offset = if_num * BATADV_NUM_WORDS;
-
-			spin_lock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
-			word = &orig_neigh_node->bat_iv.bcast_own[offset];
-			bit_pos = if_incoming_seqno - 2;
-			bit_pos -= ntohl(ogm_packet->seqno);
-			batadv_set_bit(word, bit_pos);
-			weight = &orig_neigh_node->bat_iv.bcast_own_sum[if_num];
-			*weight = bitmap_weight(word,
-						BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
-		}
+		batadv_iv_ogm_process_reply(ogm_packet, if_incoming,
+					    orig_neigh_node, if_incoming_seqno);
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: originator packet from myself (via neighbor)\n");
@@ -2844,9 +2709,6 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 		.print = batadv_iv_ogm_orig_print,
 #endif
 		.dump = batadv_iv_ogm_orig_dump,
-		.free = batadv_iv_ogm_orig_free,
-		.add_if = batadv_iv_ogm_orig_add_if,
-		.del_if = batadv_iv_ogm_orig_del_if,
 	},
 	.gw = {
 		.init_sel_class = batadv_iv_init_sel_class,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 2f0d42f2..781c5b6e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -763,11 +763,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (bat_priv->num_ifaces >= UINT_MAX) {
-		ret = -ENOSPC;
-		goto err_dev;
-	}
-
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   soft_iface, NULL, NULL, NULL);
 	if (ret)
@@ -777,16 +772,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (ret < 0)
 		goto err_upper;
 
-	hard_iface->if_num = bat_priv->num_ifaces;
-	bat_priv->num_ifaces++;
 	hard_iface->if_status = BATADV_IF_INACTIVE;
-	ret = batadv_orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
-	if (ret < 0) {
-		bat_priv->algo_ops->iface.disable(hard_iface);
-		bat_priv->num_ifaces--;
-		hard_iface->if_status = BATADV_IF_NOT_IN_USE;
-		goto err_upper;
-	}
 
 	kref_get(&hard_iface->refcount);
 	hard_iface->batman_adv_ptype.type = ethertype;
@@ -833,6 +819,33 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	return ret;
 }
 
+/**
+ * batadv_hardif_cnt() - get number of interfaces enslaved to soft interface
+ * @soft_iface: soft interface to check
+ *
+ * This function is only using RCU for locking - the result can therefore be
+ * off when another functions is modifying the list at the same time. The
+ * caller can use the rtnl_lock to make sure that the count is accurate.
+ *
+ * Return: number of connected/enslaved hard interfaces
+ */
+static size_t batadv_hardif_cnt(const struct net_device *soft_iface)
+{
+	struct batadv_hard_iface *hard_iface;
+	size_t count = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != soft_iface)
+			continue;
+
+		count++;
+	}
+	rcu_read_unlock();
+
+	return count;
+}
+
 /**
  * batadv_hardif_disable_interface() - Remove hard interface from soft interface
  * @hard_iface: hard interface to be removed
@@ -855,9 +868,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
 	batadv_hardif_put(hard_iface);
 
-	bat_priv->num_ifaces--;
-	batadv_orig_hash_del_if(hard_iface, bat_priv->num_ifaces);
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (hard_iface == primary_if) {
 		struct batadv_hard_iface *new_if;
@@ -881,7 +891,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	batadv_hardif_recalc_extra_skbroom(hard_iface->soft_iface);
 
 	/* nobody uses this interface anymore */
-	if (bat_priv->num_ifaces == 0) {
+	if (batadv_hardif_cnt(hard_iface->soft_iface) <= 1) {
 		batadv_gw_check_client_stop(bat_priv);
 
 		if (autodel == BATADV_IF_CLEANUP_AUTO)
@@ -917,7 +927,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (ret)
 		goto free_if;
 
-	hard_iface->if_num = 0;
 	hard_iface->net_dev = net_dev;
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1d295da3..56a981af 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -904,9 +904,6 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	batadv_frag_purge_orig(orig_node, NULL);
 
-	if (orig_node->bat_priv->algo_ops->orig.free)
-		orig_node->bat_priv->algo_ops->orig.free(orig_node);
-
 	kfree(orig_node->tt_buff);
 	kfree(orig_node);
 }
@@ -1555,107 +1552,3 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
 	return ret;
 }
-
-/**
- * batadv_orig_hash_add_if() - Add interface to originators in orig_hash
- * @hard_iface: hard interface to add (already slave of the soft interface)
- * @max_if_num: new number of interfaces
- *
- * Return: 0 on success or negative error number in case of failure
- */
-int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
-			    unsigned int max_if_num)
-{
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_algo_ops *bao = bat_priv->algo_ops;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_orig_node *orig_node;
-	u32 i;
-	int ret;
-
-	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
-	 * if_num
-	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			ret = 0;
-			if (bao->orig.add_if)
-				ret = bao->orig.add_if(orig_node, max_if_num);
-			if (ret == -ENOMEM)
-				goto err;
-		}
-		rcu_read_unlock();
-	}
-
-	return 0;
-
-err:
-	rcu_read_unlock();
-	return -ENOMEM;
-}
-
-/**
- * batadv_orig_hash_del_if() - Remove interface from originators in orig_hash
- * @hard_iface: hard interface to remove (still slave of the soft interface)
- * @max_if_num: new number of interfaces
- *
- * Return: 0 on success or negative error number in case of failure
- */
-int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
-			    unsigned int max_if_num)
-{
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_hard_iface *hard_iface_tmp;
-	struct batadv_orig_node *orig_node;
-	struct batadv_algo_ops *bao = bat_priv->algo_ops;
-	u32 i;
-	int ret;
-
-	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
-	 * if_num
-	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			ret = 0;
-			if (bao->orig.del_if)
-				ret = bao->orig.del_if(orig_node, max_if_num,
-						       hard_iface->if_num);
-			if (ret == -ENOMEM)
-				goto err;
-		}
-		rcu_read_unlock();
-	}
-
-	/* renumber remaining batman interfaces _inside_ of orig_hash_lock */
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
-		if (hard_iface_tmp->if_status == BATADV_IF_NOT_IN_USE)
-			continue;
-
-		if (hard_iface == hard_iface_tmp)
-			continue;
-
-		if (hard_iface->soft_iface != hard_iface_tmp->soft_iface)
-			continue;
-
-		if (hard_iface_tmp->if_num > hard_iface->if_num)
-			hard_iface_tmp->if_num--;
-	}
-	rcu_read_unlock();
-
-	hard_iface->if_num = -1;
-	return 0;
-
-err:
-	rcu_read_unlock();
-	return -ENOMEM;
-}
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 3b3f59b8..a8b4c7b6 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -72,10 +72,6 @@ void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo);
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
-int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
-			    unsigned int max_if_num);
-int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
-			    unsigned int max_if_num);
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1485263a..e121c59f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -833,7 +833,6 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->frag_seqno, random_seqno);
 
 	bat_priv->primary_if = NULL;
-	bat_priv->num_ifaces = 0;
 
 	batadv_nc_init_bat_priv(bat_priv);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 343d3048..45b5592d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -167,9 +167,6 @@ struct batadv_hard_iface {
 	/** @list: list node for batadv_hardif_list */
 	struct list_head list;
 
-	/** @if_num: identificator of the interface */
-	unsigned int if_num;
-
 	/** @if_status: status of the interface for batman-adv */
 	char if_status;
 
@@ -232,6 +229,20 @@ struct batadv_hard_iface {
 	spinlock_t neigh_list_lock;
 };
 
+/**
+ * struct batadv_orig_ifinfo - B.A.T.M.A.N. IV private orig_ifinfo members
+ */
+struct batadv_orig_ifinfo_bat_iv {
+	/**
+	 * @bcast_own: bitfield which counts the number of our OGMs this
+	 * orig_node rebroadcasted "back" to us  (relative to last_real_seqno)
+	 */
+	DECLARE_BITMAP(bcast_own, BATADV_TQ_LOCAL_WINDOW_SIZE);
+
+	/** @bcast_own_sum: sum of bcast_own */
+	u8 bcast_own_sum;
+};
+
 /**
  * struct batadv_orig_ifinfo - originator info per outgoing interface
  */
@@ -257,6 +268,9 @@ struct batadv_orig_ifinfo {
 	/** @batman_seqno_reset: time when the batman seqno window was reset */
 	unsigned long batman_seqno_reset;
 
+	/** @bat_iv: B.A.T.M.A.N. IV private structure */
+	struct batadv_orig_ifinfo_bat_iv bat_iv;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 
@@ -339,19 +353,10 @@ struct batadv_orig_node_vlan {
  */
 struct batadv_orig_bat_iv {
 	/**
-	 * @bcast_own: set of bitfields (one per hard-interface) where each one
-	 * counts the number of our OGMs this orig_node rebroadcasted "back" to
-	 * us  (relative to last_real_seqno). Every bitfield is
-	 * BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
-	 */
-	unsigned long *bcast_own;
-
-	/** @bcast_own_sum: sum of bcast_own */
-	u8 *bcast_own_sum;
-
-	/**
-	 * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
-	 * neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
+	 * @ogm_cnt_lock: lock protecting &batadv_orig_ifinfo_bat_iv.bcast_own,
+	 * &batadv_orig_ifinfo_bat_iv.bcast_own_sum,
+	 * &batadv_neigh_ifinfo_bat_iv.bat_iv.real_bits and
+	 * &batadv_neigh_ifinfo_bat_iv.real_packet_count
 	 */
 	spinlock_t ogm_cnt_lock;
 };
@@ -1597,9 +1602,6 @@ struct batadv_priv {
 	/** @batman_queue_left: number of remaining OGM packet slots */
 	atomic_t batman_queue_left;
 
-	/** @num_ifaces: number of interfaces assigned to this mesh interface */
-	unsigned int num_ifaces;
-
 	/** @mesh_obj: kobject for sysfs mesh subdirectory */
 	struct kobject *mesh_obj;
 
@@ -2179,28 +2181,6 @@ struct batadv_algo_neigh_ops {
  * struct batadv_algo_orig_ops - mesh algorithm callbacks (originator specific)
  */
 struct batadv_algo_orig_ops {
-	/**
-	 * @free: free the resources allocated by the routing algorithm for an
-	 *  orig_node object (optional)
-	 */
-	void (*free)(struct batadv_orig_node *orig_node);
-
-	/**
-	 * @add_if: ask the routing algorithm to apply the needed changes to the
-	 *  orig_node due to a new hard-interface being added into the mesh
-	 *  (optional)
-	 */
-	int (*add_if)(struct batadv_orig_node *orig_node,
-		      unsigned int max_if_num);
-
-	/**
-	 * @del_if: ask the routing algorithm to apply the needed changes to the
-	 *  orig_node due to an hard-interface being removed from the mesh
-	 *  (optional)
-	 */
-	int (*del_if)(struct batadv_orig_node *orig_node,
-		      unsigned int max_if_num, unsigned int del_if_num);
-
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	/** @print: print the originator table (optional) */
 	void (*print)(struct batadv_priv *priv, struct seq_file *seq,
-- 
2.18.0

