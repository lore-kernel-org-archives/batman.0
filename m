Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:33 +0100
Message-Id: <1295659302-7171-11-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 10/19] batman-adv: Add/refresh entries to/in
	mcast forwarding table
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

On reception of a multicast tracker packet (both locally generated or
received over an interface), a node now memorizes its forwarding state
for a tuple of multicast-group, originator, and next-hops (+ their
according outgoing interface).

The first two elements are necessary to determine, whether a node shall
forward a multicast data packet on reception later. The next-hop and
according interface information is necessary to quickly determine, if a
multicast data packet shall be forwarded via unicast to each single next
hop or via broadcast.

This commit does not yet purge multicast forwarding table entries after
the set tracker timeout yet.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c |  277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 types.h     |    2 +
 2 files changed, 276 insertions(+), 3 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index c06035f..bef3972 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -25,6 +25,10 @@
 #include "send.h"
 #include "compat.h"
 
+/* If auto mode for tracker timeout has been selected,
+ * how many times of tracker_interval to wait */
+#define TRACKER_TIMEOUT_AUTO_X 5
+
 struct tracker_packet_state {
 	int mcast_num, dest_num;
 	struct mcast_entry *mcast_entry;
@@ -92,6 +96,34 @@ struct dest_entries_list {
 	struct batman_if *batman_if;
 };
 
+
+struct mcast_forw_nexthop_entry {
+	struct list_head list;
+	uint8_t neigh_addr[6];
+	unsigned long timeout;	/* old jiffies value */
+};
+
+struct mcast_forw_if_entry {
+	struct list_head list;
+	int16_t if_num;
+	int num_nexthops;
+	struct list_head mcast_nexthop_list;
+};
+
+struct mcast_forw_orig_entry {
+	struct list_head list;
+	uint8_t orig[6];
+	uint32_t last_mcast_seqno;
+	unsigned long mcast_bits[NUM_WORDS];
+	struct list_head mcast_if_list;
+};
+
+struct mcast_forw_table_entry {
+	struct list_head list;
+	uint8_t mcast_addr[6];
+	struct list_head mcast_orig_list;
+};
+
 /* how long to wait until sending a multicast tracker packet */
 static int tracker_send_delay(struct bat_priv *bat_priv)
 {
@@ -126,6 +158,217 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 	start_mcast_tracker(bat_priv);
 }
 
+static void prepare_forw_if_entry(struct list_head *forw_if_list,
+				  int16_t if_num, uint8_t *neigh_addr)
+{
+	struct mcast_forw_if_entry *forw_if_entry;
+	struct mcast_forw_nexthop_entry *forw_nexthop_entry;
+
+	list_for_each_entry(forw_if_entry, forw_if_list, list)
+		if (forw_if_entry->if_num == if_num)
+			goto skip_create_if;
+
+	forw_if_entry = kmalloc(sizeof(struct mcast_forw_if_entry),
+				GFP_ATOMIC);
+	if (!forw_if_entry)
+		return;
+
+	forw_if_entry->if_num = if_num;
+	forw_if_entry->num_nexthops = 0;
+	INIT_LIST_HEAD(&forw_if_entry->mcast_nexthop_list);
+	list_add(&forw_if_entry->list, forw_if_list);
+
+skip_create_if:
+	list_for_each_entry(forw_nexthop_entry,
+			     &forw_if_entry->mcast_nexthop_list, list) {
+		if (!memcmp(forw_nexthop_entry->neigh_addr,
+			    neigh_addr, ETH_ALEN))
+			return;
+	}
+
+	forw_nexthop_entry = kmalloc(sizeof(struct mcast_forw_nexthop_entry),
+				     GFP_ATOMIC);
+	if (!forw_nexthop_entry && forw_if_entry->num_nexthops)
+		return;
+	else if (!forw_nexthop_entry)
+		goto free;
+
+	memcpy(forw_nexthop_entry->neigh_addr, neigh_addr, ETH_ALEN);
+	forw_if_entry->num_nexthops++;
+	if (forw_if_entry->num_nexthops < 0) {
+		kfree(forw_nexthop_entry);
+		goto free;
+	}
+
+	list_add(&forw_nexthop_entry->list,
+		 &forw_if_entry->mcast_nexthop_list);
+	return;
+free:
+	list_del(&forw_if_entry->list);
+	kfree(forw_if_entry);
+}
+
+static struct list_head *prepare_forw_table_entry(
+				struct mcast_forw_table_entry *forw_table,
+				uint8_t *mcast_addr, uint8_t *orig)
+{
+	struct mcast_forw_table_entry *forw_table_entry;
+	struct mcast_forw_orig_entry *orig_entry;
+
+	forw_table_entry = kmalloc(sizeof(struct mcast_forw_table_entry),
+				   GFP_ATOMIC);
+	if (!forw_table_entry)
+		return NULL;
+
+	memcpy(forw_table_entry->mcast_addr, mcast_addr, ETH_ALEN);
+	list_add(&forw_table_entry->list, &forw_table->list);
+
+	INIT_LIST_HEAD(&forw_table_entry->mcast_orig_list);
+	orig_entry = kmalloc(sizeof(struct mcast_forw_orig_entry), GFP_ATOMIC);
+	if (!orig_entry)
+		goto free;
+
+	memcpy(orig_entry->orig, orig, ETH_ALEN);
+	INIT_LIST_HEAD(&orig_entry->mcast_if_list);
+	list_add(&orig_entry->list, &forw_table_entry->mcast_orig_list);
+
+	return &orig_entry->mcast_if_list;
+
+free:
+	list_del(&forw_table_entry->list);
+	kfree(forw_table_entry);
+	return NULL;
+}
+
+static int sync_nexthop(struct mcast_forw_nexthop_entry *sync_nexthop_entry,
+			 struct list_head *nexthop_list)
+{
+	struct mcast_forw_nexthop_entry *nexthop_entry;
+	int synced = 0;
+
+	list_for_each_entry(nexthop_entry, nexthop_list, list) {
+		if (memcmp(sync_nexthop_entry->neigh_addr,
+			   nexthop_entry->neigh_addr, ETH_ALEN))
+			continue;
+
+		nexthop_entry->timeout = jiffies;
+		list_del(&sync_nexthop_entry->list);
+		kfree(sync_nexthop_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced) {
+		sync_nexthop_entry->timeout = jiffies;
+		list_move(&sync_nexthop_entry->list, nexthop_list);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void sync_if(struct mcast_forw_if_entry *sync_if_entry,
+		    struct list_head *if_list)
+{
+	struct mcast_forw_if_entry *if_entry;
+	struct mcast_forw_nexthop_entry *sync_nexthop_entry, *tmp;
+	int synced = 0;
+
+	list_for_each_entry(if_entry, if_list, list) {
+		if (sync_if_entry->if_num != if_entry->if_num)
+			continue;
+
+		list_for_each_entry_safe(sync_nexthop_entry, tmp,
+				&sync_if_entry->mcast_nexthop_list, list)
+			if (sync_nexthop(sync_nexthop_entry,
+					 &if_entry->mcast_nexthop_list))
+				if_entry->num_nexthops++;
+
+		list_del(&sync_if_entry->list);
+		kfree(sync_if_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced)
+		list_move(&sync_if_entry->list, if_list);
+}
+
+/* syncs all multicast entries of sync_table_entry to forw_table */
+static void sync_orig(struct mcast_forw_orig_entry *sync_orig_entry,
+		      struct list_head *orig_list)
+{
+	struct mcast_forw_orig_entry *orig_entry;
+	struct mcast_forw_if_entry *sync_if_entry, *tmp;
+	int synced = 0;
+
+	list_for_each_entry(orig_entry, orig_list, list) {
+		if (memcmp(sync_orig_entry->orig,
+			    orig_entry->orig, ETH_ALEN))
+			continue;
+
+		list_for_each_entry_safe(sync_if_entry, tmp,
+				&sync_orig_entry->mcast_if_list, list)
+			sync_if(sync_if_entry, &orig_entry->mcast_if_list);
+
+		list_del(&sync_orig_entry->list);
+		kfree(sync_orig_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced)
+		list_move(&sync_orig_entry->list, orig_list);
+}
+
+
+/* syncs all multicast entries of sync_table_entry to forw_table */
+static void sync_table(struct mcast_forw_table_entry *sync_table_entry,
+		       struct list_head *forw_table)
+{
+	struct mcast_forw_table_entry *table_entry;
+	struct mcast_forw_orig_entry *sync_orig_entry, *tmp;
+	int synced = 0;
+
+	list_for_each_entry(table_entry, forw_table, list) {
+		if (memcmp(sync_table_entry->mcast_addr,
+			   table_entry->mcast_addr, ETH_ALEN))
+			continue;
+
+		list_for_each_entry_safe(sync_orig_entry, tmp,
+				&sync_table_entry->mcast_orig_list, list)
+			sync_orig(sync_orig_entry,
+				  &table_entry->mcast_orig_list);
+
+		list_del(&sync_table_entry->list);
+		kfree(sync_table_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced)
+		list_move(&sync_table_entry->list, forw_table);
+}
+
+/* Updates the old multicast forwarding table with the information gained
+ * from the generated/received tracker packet. It also frees the generated
+ * table for syncing (*forw_table). */
+static void update_mcast_forw_table(struct mcast_forw_table_entry *forw_table,
+				    struct bat_priv *bat_priv)
+{
+	struct mcast_forw_table_entry *sync_table_entry, *tmp;
+
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
+	list_for_each_entry_safe(sync_table_entry, tmp, &forw_table->list,
+				 list)
+		sync_table(sync_table_entry, &bat_priv->mcast_forw_table);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+}
+
 static inline int find_mca_match(struct orig_node *orig_node,
 		int mca_pos, uint8_t *mc_addr_list, int num_mcast_entries)
 {
@@ -310,9 +553,12 @@ out:
  * interface to the forw_if_list - but only if this router has not been
  * added yet */
 static int add_router_of_dest(struct dest_entries_list *next_hops,
-			      uint8_t *dest, struct bat_priv *bat_priv)
+			      uint8_t *dest,
+			      struct list_head *forw_if_list,
+			      struct bat_priv *bat_priv)
 {
 	struct dest_entries_list *next_hop_tmp, *next_hop_entry;
+	int16_t if_num;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct hashtable_t *hash = bat_priv->orig_hash;
@@ -344,6 +590,7 @@ static int add_router_of_dest(struct dest_entries_list *next_hops,
 			       ETH_ALEN);
 			next_hop_entry->batman_if =
 						orig_node->router->if_incoming;
+			if_num = next_hop_entry->batman_if->if_num;
 			i = hash->size;
 			break;
 		}
@@ -352,6 +599,10 @@ static int add_router_of_dest(struct dest_entries_list *next_hops,
 	if (!next_hop_entry->batman_if)
 		goto free;
 
+	if (forw_if_list)
+		prepare_forw_if_entry(forw_if_list, if_num,
+				      next_hop_entry->dest);
+
 	list_for_each_entry(next_hop_tmp, &next_hops->list, list)
 		if (!memcmp(next_hop_tmp->dest, next_hop_entry->dest,
 								ETH_ALEN))
@@ -373,13 +624,16 @@ free:
 static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
 			     int tracker_packet_len,
 			     struct dest_entries_list *next_hops,
+			     struct mcast_forw_table_entry *forw_table,
 			     struct bat_priv *bat_priv)
 {
 	int num_next_hops = 0, ret;
 	struct tracker_packet_state state;
 	uint8_t *tail = (uint8_t *)tracker_packet + tracker_packet_len;
+	struct list_head *forw_table_if = NULL;
 
 	INIT_LIST_HEAD(&next_hops->list);
+	INIT_LIST_HEAD(&forw_table->list);
 
 	tracker_packet_for_each_dest(&state, tracker_packet) {
 		/* avoid writing outside of unallocated memory later */
@@ -398,8 +652,15 @@ static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
 			break;
 		}
 
+		if (state.dest_num)
+			goto skip;
+
+		forw_table_if = prepare_forw_table_entry(forw_table,
+						 state.mcast_entry->mcast_addr,
+						 tracker_packet->orig);
+skip:
 		ret = add_router_of_dest(next_hops, state.dest_entry,
-					 bat_priv);
+					 forw_table_if, bat_priv);
 		if (!ret)
 			num_next_hops++;
 	}
@@ -407,6 +668,8 @@ static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
 	return num_next_hops;
 }
 
+/* Zero destination entries not destined for the specified next hop in the
+ * tracker packet */
 static void zero_tracker_packet(struct mcast_tracker_packet *tracker_packet,
 				uint8_t *next_hop, struct bat_priv *bat_priv)
 {
@@ -459,6 +722,8 @@ static void zero_tracker_packet(struct mcast_tracker_packet *tracker_packet,
 	}
 }
 
+/* Remove zeroed destination entries and empty multicast entries in tracker
+ * packet */
 static int shrink_tracker_packet(struct mcast_tracker_packet *tracker_packet,
 				  int tracker_packet_len)
 {
@@ -544,15 +809,19 @@ void route_mcast_tracker_packet(
 	struct mcast_tracker_packet *next_hop_tracker_packets,
 				    *next_hop_tracker_packet;
 	struct dest_entries_list *next_hop;
+	struct mcast_forw_table_entry forw_table;
 	struct sk_buff *skb;
 	int num_next_hops, i;
 	int *tracker_packet_lengths;
 
 	rcu_read_lock();
 	num_next_hops = tracker_next_hops(tracker_packet, tracker_packet_len,
-					  &next_hops, bat_priv);
+					  &next_hops, &forw_table, bat_priv);
 	if (!num_next_hops)
 		goto out;
+
+	update_mcast_forw_table(&forw_table, bat_priv);
+
 	next_hop_tracker_packets = kmalloc(tracker_packet_len * num_next_hops,
 					   GFP_ATOMIC);
 	if (!next_hop_tracker_packets)
@@ -736,6 +1005,8 @@ ok:
 int mcast_init(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->mcast_tracker_work, mcast_tracker_timer);
+	INIT_LIST_HEAD(&bat_priv->mcast_forw_table);
+
 	start_mcast_tracker(bat_priv);
 
 	return 1;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 675a50f..75adec9 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -158,6 +158,7 @@ struct bat_priv {
 	struct hlist_head forw_bcast_list;
 	struct hlist_head gw_list;
 	struct list_head vis_send_list;
+	struct list_head mcast_forw_table;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *hna_local_hash;
 	struct hashtable_t *hna_global_hash;
@@ -170,6 +171,7 @@ struct bat_priv {
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
+	spinlock_t mcast_forw_table_lock; /* protects mcast_forw_table */
 	int16_t num_local_hna;
 	atomic_t hna_local_changed;
 	struct delayed_work hna_work;
-- 
1.7.2.3

