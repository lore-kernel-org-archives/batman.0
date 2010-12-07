Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:30 +0100
Message-Id: <1291761150-29818-20-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 20/20] batman-adv: Do not disable irqs for
	spinlocks in multicast specific code
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

We are never going to be using those spinlocks for the multicast
specific code in hardware interrupt context, therefore just disabling
bottom halves is enough.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 compat.h    |   16 ++++++++--------
 multicast.c |   48 ++++++++++++++++++++----------------------------
 routing.c   |   15 +++++++--------
 send.c      |   10 ++++------
 4 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/compat.h b/compat.h
index bbb1dad..8836fff 100644
--- a/compat.h
+++ b/compat.h
@@ -297,19 +297,19 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
  */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
 
-#define MC_LIST_LOCK(soft_iface, flags) \
-		spin_lock_irqsave(&soft_iface->_xmit_lock, flags)
-#define MC_LIST_UNLOCK(soft_iface, flags) \
-		spin_unlock_irqrestore(&soft_iface->_xmit_lock, flags)
+#define MC_LIST_LOCK(soft_iface) \
+		netif_tx_lock_bh(soft_iface)
+#define MC_LIST_UNLOCK(soft_iface) \
+		netif_tx_unlock_bh(soft_iface)
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27) */
 
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 26)
 
-#define MC_LIST_LOCK(soft_iface, flags) \
-		spin_lock_irqsave(&soft_iface->addr_list_lock, flags)
-#define MC_LIST_UNLOCK(soft_iface, flags) \
-		spin_unlock_irqrestore(&soft_iface->addr_list_lock, flags)
+#define MC_LIST_LOCK(soft_iface) \
+		netif_addr_lock_bh(soft_iface)
+#define MC_LIST_UNLOCK(soft_iface) \
+		netif_addr_unlock_bh(soft_iface)
 
 #endif /* > KERNEL_VERSION(2, 6, 26) */
 
diff --git a/multicast.c b/multicast.c
index 1f84f7c..4681046 100644
--- a/multicast.c
+++ b/multicast.c
@@ -109,7 +109,6 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 
 inline int mcast_may_optimize(uint8_t *dest, struct net_device *soft_iface) {
 	MC_LIST *mc_entry;
-	unsigned long flags;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	int mcast_mode = atomic_read(&bat_priv->mcast_mode);
 
@@ -119,15 +118,15 @@ inline int mcast_may_optimize(uint8_t *dest, struct net_device *soft_iface) {
 	/* Still allow flooding of multicast packets of protocols where it is
 	 * not easily possible for a multicast sender to be a multicast
 	 * receiver of the same group (for instance IPv6 NDP) */
-	MC_LIST_LOCK(soft_iface, flags);
+	MC_LIST_LOCK(soft_iface);
 	netdev_for_each_mc_addr(mc_entry, soft_iface) {
 		if (memcmp(dest, mc_entry->MC_LIST_ADDR, ETH_ALEN))
 			continue;
 
-		MC_LIST_UNLOCK(soft_iface, flags);
+		MC_LIST_UNLOCK(soft_iface);
 		return 1;
 	}
-	MC_LIST_UNLOCK(soft_iface, flags);
+	MC_LIST_UNLOCK(soft_iface);
 
 	return 0;
 }
@@ -353,13 +352,12 @@ static void update_mcast_forw_table(struct mcast_forw_table_entry *forw_table,
 				    struct bat_priv *bat_priv)
 {
 	struct mcast_forw_table_entry *sync_table_entry, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
 	list_for_each_entry_safe(sync_table_entry, tmp, &forw_table->list,
 				 list)
 		sync_table(sync_table_entry, &bat_priv->mcast_forw_table);
-	spin_unlock_irqrestore(&bat_priv->mcast_forw_table_lock, flags);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
 }
 
 static inline int find_mca_match(struct orig_node *orig_node,
@@ -403,17 +401,16 @@ static struct mcast_tracker_packet *mcast_proact_tracker_prepare(
 
 	uint8_t *dest_entry;
 	int pos, mca_pos;
-	unsigned long flags;
 	struct mcast_tracker_packet *tracker_packet = NULL;
 	struct mcast_entry *mcast_entry;
 	HASHIT(hashit);
 
 	/* Make a copy so we don't have to rush because of locking */
-	MC_LIST_LOCK(soft_iface, flags);
+	MC_LIST_LOCK(soft_iface);
 	num_mcast_entries = netdev_mc_count(soft_iface);
 	mc_addr_list = kmalloc(ETH_ALEN * num_mcast_entries, GFP_ATOMIC);
 	if (!mc_addr_list) {
-		MC_LIST_UNLOCK(soft_iface, flags);
+		MC_LIST_UNLOCK(soft_iface);
 		goto out;
 	}
 	pos = 0;
@@ -422,7 +419,7 @@ static struct mcast_tracker_packet *mcast_proact_tracker_prepare(
 		       ETH_ALEN);
 		pos++;
 	}
-	MC_LIST_UNLOCK(soft_iface, flags);
+	MC_LIST_UNLOCK(soft_iface);
 
 	if (num_mcast_entries > UINT8_MAX)
 		num_mcast_entries = UINT8_MAX;
@@ -435,7 +432,7 @@ static struct mcast_tracker_packet *mcast_proact_tracker_prepare(
 		INIT_LIST_HEAD(&dest_entries_list[pos]);
 
 	/* fill the lists and buffers */
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
 		orig_node = bucket->data;
@@ -455,7 +452,7 @@ static struct mcast_tracker_packet *mcast_proact_tracker_prepare(
 			dest_entries_total++;
 		}
 	}
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	/* Any list left empty? */
 	for (pos = 0; pos < num_mcast_entries; pos++)
@@ -539,7 +536,6 @@ static int add_router_of_dest(struct dest_entries_list *next_hops,
 			      struct bat_priv *bat_priv)
 {
 	struct dest_entries_list *next_hop_tmp, *next_hop_entry;
-	unsigned long flags;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	HASHIT(hashit);
@@ -550,7 +546,7 @@ static int add_router_of_dest(struct dest_entries_list *next_hops,
 		return 1;
 
 	next_hop_entry->batman_if = NULL;
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
 		orig_node = bucket->data;
@@ -567,7 +563,7 @@ static int add_router_of_dest(struct dest_entries_list *next_hops,
 		if_num = next_hop_entry->batman_if->if_num;
 		break;
 	}
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	if (!next_hop_entry->batman_if)
 		goto free;
 
@@ -651,12 +647,11 @@ static void zero_tracker_packet(struct mcast_tracker_packet *tracker_packet,
 	uint8_t *dest_entry;
 	int mcast_num, dest_num;
 
-	unsigned long flags;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	HASHIT(hashit);
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	tracker_packet_for_each_dest(mcast_entry, dest_entry,
 				     mcast_num, dest_num, tracker_packet) {
 		while (hash_iterate(bat_priv->orig_hash, &hashit)) {
@@ -685,7 +680,7 @@ static void zero_tracker_packet(struct mcast_tracker_packet *tracker_packet,
 		}
 		HASHIT_RESET(hashit);
 	}
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 /* Remove zeroed destination entries and empty multicast entries in tracker
@@ -849,13 +844,12 @@ out:
 
 void purge_mcast_forw_table(struct bat_priv *bat_priv)
 {
-	unsigned long flags;
 	struct mcast_forw_table_entry *table_entry, *tmp_table_entry;
 	struct mcast_forw_orig_entry *orig_entry, *tmp_orig_entry;
 	struct mcast_forw_if_entry *if_entry, *tmp_if_entry;
 	struct mcast_forw_nexthop_entry *nexthop_entry, *tmp_nexthop_entry;
 
-	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
 	list_for_each_entry_safe(table_entry, tmp_table_entry,
 				 &bat_priv->mcast_forw_table, list) {
 		list_for_each_entry_safe(orig_entry, tmp_orig_entry,
@@ -895,7 +889,7 @@ void purge_mcast_forw_table(struct bat_priv *bat_priv)
 		list_del(&table_entry->list);
 		kfree(table_entry);
 	}
-	spin_unlock_irqrestore(&bat_priv->mcast_forw_table_lock, flags);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
 }
 
 static void mcast_tracker_timer(struct work_struct *work)
@@ -1034,7 +1028,6 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	unsigned long flags;
 	struct batman_if *batman_if;
 	struct mcast_forw_table_entry *table_entry;
 	struct mcast_forw_orig_entry *orig_entry;
@@ -1049,7 +1042,7 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
 			"Outgoing interface\tNexthop - timeout in msecs\n");
 
 	rcu_read_lock();
-	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
 	list_for_each_entry(table_entry, &bat_priv->mcast_forw_table, list) {
 		seq_printf(seq, "%pM\n", table_entry->mcast_addr);
 
@@ -1078,7 +1071,7 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
 			}
 		}
 	}
-	spin_unlock_irqrestore(&bat_priv->mcast_forw_table_lock, flags);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
 	rcu_read_unlock();
 
 	return 0;
@@ -1090,7 +1083,6 @@ void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
 	struct mcast_packet *mcast_packet;
 	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
-	unsigned long flags;
 	struct mcast_forw_table_entry *table_entry;
 	struct mcast_forw_orig_entry *orig_entry;
 	struct mcast_forw_if_entry *if_entry;
@@ -1107,7 +1099,7 @@ void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
 	mcast_packet->ttl--;
 
 	rcu_read_lock();
-	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
 	list_for_each_entry(table_entry, &bat_priv->mcast_forw_table, list) {
 		if (memcmp(ethhdr->h_dest, table_entry->mcast_addr, ETH_ALEN))
 			continue;
@@ -1160,7 +1152,7 @@ void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
 		}
 		break;
 	}
-	spin_unlock_irqrestore(&bat_priv->mcast_forw_table_lock, flags);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
 
 	list_for_each_entry_safe (dest_entry, tmp, &dest_list.list, list) {
 		if (is_broadcast_ether_addr(dest_entry->dest)) {
diff --git a/routing.c b/routing.c
index 19f045a..4f99134 100644
--- a/routing.c
+++ b/routing.c
@@ -1396,7 +1396,6 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct ethhdr *ethhdr;
 	MC_LIST *mc_entry;
 	int32_t seq_diff;
-	unsigned long flags;
 	int ret = 1;
 	int hdr_size = sizeof(struct mcast_packet);
 
@@ -1414,13 +1413,13 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (mcast_packet->ttl < 2)
 		return NET_RX_DROP;
 
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	spin_lock_bh(&bat_priv->orig_hash_lock);
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       mcast_packet->orig));
 
 	if (orig_node == NULL) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1428,7 +1427,7 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (get_bit_status(orig_node->mcast_bits,
 			   orig_node->last_mcast_seqno,
 			   ntohl(mcast_packet->seqno))) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1437,7 +1436,7 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->mcast_seqno_reset)) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
 		return NET_RX_DROP;
 	}
 
@@ -1446,7 +1445,7 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (bit_get_packet(bat_priv, orig_node->mcast_bits, seq_diff, 1))
 		orig_node->last_mcast_seqno = ntohl(mcast_packet->seqno);
 
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	/* forward multicast packet if necessary */
 	route_mcast_packet(skb, bat_priv);
@@ -1454,13 +1453,13 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ethhdr = (struct ethhdr *)(mcast_packet + 1);
 
 	/* multicast for me? */
-	MC_LIST_LOCK(recv_if->soft_iface, flags);
+	MC_LIST_LOCK(recv_if->soft_iface);
 	netdev_for_each_mc_addr(mc_entry, recv_if->soft_iface) {
 		ret = memcmp(mc_entry->MC_LIST_ADDR, ethhdr->h_dest, ETH_ALEN);
 		if (!ret)
 			break;
 	}
-	MC_LIST_UNLOCK(recv_if->soft_iface, flags);
+	MC_LIST_UNLOCK(recv_if->soft_iface);
 
 	if (!ret)
 		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
diff --git a/send.c b/send.c
index 26a6c99..eef95bc 100644
--- a/send.c
+++ b/send.c
@@ -220,7 +220,6 @@ static void add_own_MCA(struct batman_packet *batman_packet, int num_mca,
 {
 	MC_LIST *mc_list_entry;
 	int num_mca_done = 0;
-	unsigned long flags;
 	char *mca_entry = (char *)(batman_packet + 1);
 
 	if (num_mca == 0)
@@ -234,7 +233,7 @@ static void add_own_MCA(struct batman_packet *batman_packet, int num_mca,
 
 	mca_entry = mca_entry + batman_packet->num_hna * ETH_ALEN;
 
-	MC_LIST_LOCK(soft_iface, flags);
+	MC_LIST_LOCK(soft_iface);
 	netdev_for_each_mc_addr(mc_list_entry, soft_iface) {
 		memcpy(mca_entry, &mc_list_entry->MC_LIST_ADDR, ETH_ALEN);
 		mca_entry += ETH_ALEN;
@@ -244,7 +243,7 @@ static void add_own_MCA(struct batman_packet *batman_packet, int num_mca,
 		if(++num_mca_done == num_mca)
 			break;
 	}
-	MC_LIST_UNLOCK(soft_iface, flags);
+	MC_LIST_UNLOCK(soft_iface);
 
 out:
 	batman_packet->num_mca = num_mca_done;
@@ -254,7 +253,6 @@ static void rebuild_batman_packet(struct bat_priv *bat_priv,
 				  struct batman_if *batman_if)
 {
 	int new_len, mcast_mode, num_mca = 0;
-	unsigned long flags;
 	unsigned char *new_buff = NULL;
 	struct batman_packet *batman_packet;
 
@@ -263,9 +261,9 @@ static void rebuild_batman_packet(struct bat_priv *bat_priv,
 
 	/* Avoid attaching MCAs, if multicast optimization is disabled */
 	if (mcast_mode == MCAST_MODE_PROACT_TRACKING) {
-		MC_LIST_LOCK(batman_if->soft_iface, flags);
+		MC_LIST_LOCK(batman_if->soft_iface);
 		num_mca = netdev_mc_count(batman_if->soft_iface);
-		MC_LIST_UNLOCK(batman_if->soft_iface, flags);
+		MC_LIST_UNLOCK(batman_if->soft_iface);
 	}
 
 	if (atomic_read(&bat_priv->hna_local_changed) ||
-- 
1.7.1

