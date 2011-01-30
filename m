Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:16 +0100
Message-Id: <1296362366-3852-9-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 08/18] batman-adv: Add/refresh entries to/in
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
 main.c      |    1 +
 multicast.c |  278 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 types.h     |    2 +
 3 files changed, 278 insertions(+), 3 deletions(-)

diff --git a/batman-adv/main.c b/batman-adv/main.c
index 4233c7b..b2f3e62 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -83,6 +83,7 @@ int mesh_init(struct net_device *soft_iface)
 
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
+	spin_lock_init(&bat_priv->mcast_forw_table_lock);
 	spin_lock_init(&bat_priv->hna_lhash_lock);
 	spin_lock_init(&bat_priv->hna_ghash_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index ffeb800..b1718c6 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -27,6 +27,10 @@
 #include "originator.h"
 #include "compat.h"
 
+/* If auto mode for tracker timeout has been selected,
+ * how many times of tracker_interval to wait */
+#define TRACKER_TIMEOUT_AUTO_X 5
+
 struct tracker_packet_state {
 	int mcast_num, dest_num;
 	struct mcast_entry *mcast_entry;
@@ -98,6 +102,34 @@ struct dest_entries_list {
 	struct batman_if *batman_if;
 };
 
+
+struct mcast_forw_nexthop_entry {
+	struct hlist_node list;
+	uint8_t neigh_addr[6];
+	unsigned long timeout;	/* old jiffies value */
+};
+
+struct mcast_forw_if_entry {
+	struct hlist_node list;
+	int16_t if_num;
+	int num_nexthops;
+	struct hlist_head mcast_nexthop_list;
+};
+
+struct mcast_forw_orig_entry {
+	struct hlist_node list;
+	uint8_t orig[6];
+	uint32_t last_mcast_seqno;
+	unsigned long mcast_bits[NUM_WORDS];
+	struct hlist_head mcast_if_list;
+};
+
+struct mcast_forw_table_entry {
+	struct hlist_node list;
+	uint8_t mcast_addr[6];
+	struct hlist_head mcast_orig_list;
+};
+
 /* how long to wait until sending a multicast tracker packet */
 static int tracker_send_delay(struct bat_priv *bat_priv)
 {
@@ -132,6 +164,222 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 	start_mcast_tracker(bat_priv);
 }
 
+static void prepare_forw_if_entry(struct hlist_head *forw_if_list,
+				  int16_t if_num, uint8_t *neigh_addr)
+{
+	struct mcast_forw_if_entry *forw_if_entry;
+	struct mcast_forw_nexthop_entry *forw_nexthop_entry;
+	struct hlist_node *node;
+
+	hlist_for_each_entry(forw_if_entry, node, forw_if_list, list)
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
+	INIT_HLIST_HEAD(&forw_if_entry->mcast_nexthop_list);
+	hlist_add_head(&forw_if_entry->list, forw_if_list);
+
+skip_create_if:
+	hlist_for_each_entry(forw_nexthop_entry, node,
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
+	hlist_add_head(&forw_nexthop_entry->list,
+		 &forw_if_entry->mcast_nexthop_list);
+	return;
+free:
+	hlist_del(&forw_if_entry->list);
+	kfree(forw_if_entry);
+}
+
+static struct hlist_head *prepare_forw_table_entry(
+				struct hlist_head *forw_table,
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
+	hlist_add_head(&forw_table_entry->list, forw_table);
+
+	INIT_HLIST_HEAD(&forw_table_entry->mcast_orig_list);
+	orig_entry = kmalloc(sizeof(struct mcast_forw_orig_entry), GFP_ATOMIC);
+	if (!orig_entry)
+		goto free;
+
+	memcpy(orig_entry->orig, orig, ETH_ALEN);
+	INIT_HLIST_HEAD(&orig_entry->mcast_if_list);
+	hlist_add_head(&orig_entry->list, &forw_table_entry->mcast_orig_list);
+
+	return &orig_entry->mcast_if_list;
+
+free:
+	hlist_del(&forw_table_entry->list);
+	kfree(forw_table_entry);
+	return NULL;
+}
+
+static int sync_nexthop(struct mcast_forw_nexthop_entry *sync_nexthop_entry,
+			 struct hlist_head *nexthop_list)
+{
+	struct mcast_forw_nexthop_entry *nexthop_entry;
+	struct hlist_node *node;
+	int synced = 0;
+
+	hlist_for_each_entry(nexthop_entry, node, nexthop_list, list) {
+		if (memcmp(sync_nexthop_entry->neigh_addr,
+			   nexthop_entry->neigh_addr, ETH_ALEN))
+			continue;
+
+		nexthop_entry->timeout = jiffies;
+		hlist_del(&sync_nexthop_entry->list);
+		kfree(sync_nexthop_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced) {
+		sync_nexthop_entry->timeout = jiffies;
+		hlist_add_head(&sync_nexthop_entry->list, nexthop_list);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void sync_if(struct mcast_forw_if_entry *sync_if_entry,
+		    struct hlist_head *if_list)
+{
+	struct mcast_forw_if_entry *if_entry;
+	struct mcast_forw_nexthop_entry *sync_nexthop_entry;
+	struct hlist_node *node, *node2, *node_tmp;
+	int synced = 0;
+
+	hlist_for_each_entry(if_entry, node, if_list, list) {
+		if (sync_if_entry->if_num != if_entry->if_num)
+			continue;
+
+		hlist_for_each_entry_safe(sync_nexthop_entry, node2, node_tmp,
+				&sync_if_entry->mcast_nexthop_list, list)
+			if (sync_nexthop(sync_nexthop_entry,
+					 &if_entry->mcast_nexthop_list))
+				if_entry->num_nexthops++;
+
+		hlist_del(&sync_if_entry->list);
+		kfree(sync_if_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced)
+		hlist_add_head(&sync_if_entry->list, if_list);
+}
+
+static void sync_orig(struct mcast_forw_orig_entry *sync_orig_entry,
+		      struct hlist_head *orig_list)
+{
+	struct mcast_forw_orig_entry *orig_entry;
+	struct mcast_forw_if_entry *sync_if_entry;
+	struct hlist_node *node, *node2, *node_tmp;
+	int synced = 0;
+
+	hlist_for_each_entry(orig_entry, node, orig_list, list) {
+		if (memcmp(sync_orig_entry->orig,
+			    orig_entry->orig, ETH_ALEN))
+			continue;
+
+		hlist_for_each_entry_safe(sync_if_entry, node2, node_tmp,
+				&sync_orig_entry->mcast_if_list, list)
+			sync_if(sync_if_entry, &orig_entry->mcast_if_list);
+
+		hlist_del(&sync_orig_entry->list);
+		kfree(sync_orig_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced)
+		hlist_add_head(&sync_orig_entry->list, orig_list);
+}
+
+
+/* syncs all multicast entries of sync_table_entry to forw_table */
+static void sync_table(struct mcast_forw_table_entry *sync_table_entry,
+		       struct hlist_head *forw_table)
+{
+	struct mcast_forw_table_entry *table_entry;
+	struct mcast_forw_orig_entry *sync_orig_entry;
+	struct hlist_node *node, *node2, *node_tmp;
+	int synced = 0;
+
+	hlist_for_each_entry(table_entry, node, forw_table, list) {
+		if (memcmp(sync_table_entry->mcast_addr,
+			   table_entry->mcast_addr, ETH_ALEN))
+			continue;
+
+		hlist_for_each_entry_safe(sync_orig_entry, node2, node_tmp,
+				&sync_table_entry->mcast_orig_list, list)
+			sync_orig(sync_orig_entry,
+				  &table_entry->mcast_orig_list);
+
+		hlist_del(&sync_table_entry->list);
+		kfree(sync_table_entry);
+
+		synced = 1;
+		break;
+	}
+
+	if (!synced)
+		hlist_add_head(&sync_table_entry->list, forw_table);
+}
+
+/* Updates the old multicast forwarding table with the information gained
+ * from the generated/received tracker packet. It also frees the generated
+ * table for syncing (*forw_table). */
+static void update_mcast_forw_table(struct hlist_head *forw_table,
+				    struct bat_priv *bat_priv)
+{
+	struct mcast_forw_table_entry *sync_table_entry;
+	struct hlist_node *node, *node_tmp;
+
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
+	hlist_for_each_entry_safe(sync_table_entry, node, node_tmp, forw_table,
+				  list)
+		sync_table(sync_table_entry, &bat_priv->mcast_forw_table);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+}
+
 /**
  * Searches if a certain multicast address of another originator is also
  * one of ours.
@@ -359,9 +607,12 @@ out:
  * interface to the forw_if_list - but only if this router has not been
  * added yet */
 static int add_router_of_dest(struct dest_entries_list *next_hops,
-			      uint8_t *dest, struct bat_priv *bat_priv)
+			      uint8_t *dest,
+			      struct hlist_head *forw_if_list,
+			      struct bat_priv *bat_priv)
 {
 	struct dest_entries_list *next_hop_tmp, *next_hop_entry;
+	int16_t if_num;
 	struct orig_node *orig_node;
 	int ret = 1;
 
@@ -382,9 +633,14 @@ static int add_router_of_dest(struct dest_entries_list *next_hops,
 	memcpy(next_hop_entry->dest, orig_node->router->addr,
 	       ETH_ALEN);
 	next_hop_entry->batman_if = orig_node->router->if_incoming;
+	if_num = next_hop_entry->batman_if->if_num;
 	kref_get(&next_hop_entry->batman_if->refcount);
 	rcu_read_unlock();
 
+	if (forw_if_list)
+		prepare_forw_if_entry(forw_if_list, if_num,
+				      next_hop_entry->dest);
+
 	list_for_each_entry(next_hop_tmp, &next_hops->list, list)
 		if (!memcmp(next_hop_tmp->dest, next_hop_entry->dest,
 								ETH_ALEN))
@@ -410,13 +666,16 @@ out:
 static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
 			     int tracker_packet_len,
 			     struct dest_entries_list *next_hops,
+			     struct hlist_head *forw_table,
 			     struct bat_priv *bat_priv)
 {
 	int num_next_hops = 0, ret;
 	struct tracker_packet_state state;
 	uint8_t *tail = (uint8_t *)tracker_packet + tracker_packet_len;
+	struct hlist_head *forw_table_if = NULL;
 
 	INIT_LIST_HEAD(&next_hops->list);
+	INIT_HLIST_HEAD(forw_table);
 
 	tracker_packet_for_each_dest(&state, tracker_packet) {
 		/* avoid writing outside of unallocated memory later */
@@ -435,8 +694,15 @@ static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
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
@@ -538,14 +804,18 @@ void route_mcast_tracker_packet(struct sk_buff *skb,
 {
 	struct dest_entries_list next_hops, *tmp;
 	struct dest_entries_list *next_hop;
+	struct hlist_head forw_table;
 	struct sk_buff *skb_tmp;
 	int num_next_hops;
 
 	num_next_hops = tracker_next_hops((struct mcast_tracker_packet*)
-				skb->data, skb->len, &next_hops, bat_priv);
+					  skb->data, skb->len, &next_hops,
+					  &forw_table, bat_priv);
 	if (!num_next_hops)
 		return;
 
+	update_mcast_forw_table(&forw_table, bat_priv);
+
 	list_for_each_entry(next_hop, &next_hops.list, list) {
 		skb_tmp = skb_copy(skb, GFP_ATOMIC);
 		if (!skb_tmp)
@@ -694,6 +964,8 @@ ok:
 int mcast_init(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->mcast_tracker_work, mcast_tracker_timer);
+	INIT_HLIST_HEAD(&bat_priv->mcast_forw_table);
+
 	start_mcast_tracker(bat_priv);
 
 	return 1;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index f24798e..0acfd2e 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -160,6 +160,7 @@ struct bat_priv {
 	struct hlist_head forw_bcast_list;
 	struct hlist_head gw_list;
 	struct list_head vis_send_list;
+	struct hlist_head mcast_forw_table;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *hna_local_hash;
 	struct hashtable_t *hna_global_hash;
@@ -172,6 +173,7 @@ struct bat_priv {
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
+	spinlock_t mcast_forw_table_lock; /* protects mcast_forw_table */
 	int16_t num_local_hna;
 	atomic_t hna_local_changed;
 	struct delayed_work hna_work;
-- 
1.7.2.3

