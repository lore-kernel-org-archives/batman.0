Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:13 +0100
Message-Id: <1296362366-3852-6-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 05/18] batman-adv: Prepare and send own
	multicast tracker packets
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

This commit introduces batman multicast tracker packets. Their job is,
to mark nodes responsible for forwarding multicast data later (so a
multicast receiver will not be marked, only the forwarding nodes).

When having activated the proact_tracking multicast mode, a path between
all multicast _receivers_ of a group will be marked - in fact, in this
mode BATMAN will assume, that a multicast receiver is also a multicast
sender, therefore a multicast sender should also join the same multicast
group.

The advantage of this is less complexity and the paths are marked in
advance before an actual data packet has been sent, decreasing delays.
The disadvantage is higher protocol overhead.

One large tracker packet will be created on a generating node first,
which then gets split for every necessary next hop destination.

This commit does not add forwarding of tracker packets but just local
generation and local sending of them.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c |  506 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h |    2 +
 packet.h    |   29 +++-
 3 files changed, 531 insertions(+), 6 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index cc83937..f414394 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -21,6 +21,82 @@
 
 #include "main.h"
 #include "multicast.h"
+#include "hash.h"
+#include "send.h"
+#include "hard-interface.h"
+#include "originator.h"
+#include "compat.h"
+
+struct tracker_packet_state {
+	int mcast_num, dest_num;
+	struct mcast_entry *mcast_entry;
+	uint8_t *dest_entry;
+	int break_flag;
+};
+
+static void init_state_mcast_entry(struct tracker_packet_state *state,
+				   struct mcast_tracker_packet *tracker_packet)
+{
+	state->mcast_num = 0;
+	state->mcast_entry = (struct mcast_entry *)(tracker_packet + 1);
+	state->dest_entry = (uint8_t *)(state->mcast_entry + 1);
+	state->break_flag = 0;
+}
+
+static int check_state_mcast_entry(struct tracker_packet_state *state,
+				   struct mcast_tracker_packet *tracker_packet)
+{
+	if (state->mcast_num < tracker_packet->num_mcast_entries &&
+	    !state->break_flag)
+		return 1;
+
+	return 0;
+}
+
+static void inc_state_mcast_entry(struct tracker_packet_state *state)
+{
+	if (state->break_flag)
+		return;
+
+	state->mcast_num++;
+	state->mcast_entry = (struct mcast_entry *)state->dest_entry;
+	state->dest_entry = (uint8_t *)(state->mcast_entry + 1);
+}
+
+static void init_state_dest_entry(struct tracker_packet_state *state)
+{
+	state->dest_num = 0;
+	state->break_flag = 1;
+}
+
+static int check_state_dest_entry(struct tracker_packet_state *state)
+{
+	if (state->dest_num < state->mcast_entry->num_dest)
+		return 1;
+
+	state->break_flag = 0;
+	return 0;
+}
+
+static void inc_state_dest_entry(struct tracker_packet_state *state)
+{
+	state->dest_num++;
+	state->dest_entry += ETH_ALEN;
+}
+
+#define tracker_packet_for_each_dest(state, tracker_packet)		 \
+	for (init_state_mcast_entry(state, tracker_packet);		 \
+	     check_state_mcast_entry(state, tracker_packet);		 \
+	     inc_state_mcast_entry(state))				 \
+		for (init_state_dest_entry(state);			 \
+		     check_state_dest_entry(state);			 \
+		     inc_state_dest_entry(state))
+
+struct dest_entries_list {
+	struct list_head list;
+	uint8_t dest[6];
+	struct batman_if *batman_if;
+};
 
 /* how long to wait until sending a multicast tracker packet */
 static int tracker_send_delay(struct bat_priv *bat_priv)
@@ -56,11 +132,441 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 	start_mcast_tracker(bat_priv);
 }
 
+/**
+ * Searches if a certain multicast address of another originator is also
+ * one of ours.
+ *
+ * Returns -1 if no match could be found. Otherwise returns the number of
+ * the element in our mc_addr_list which matches.
+ *
+ * @orig_node:		the originator we are refering to
+ * @mca_pos:		refers to the specific multicast address in orig_node's
+ *			mca buffer which we are trying to find a match for
+ * @mc_addr_list:	a list of our own multicast addresses
+ * @num_mcast_entries:	the number of our own multicast addresses
+ */
+static inline int find_mca_match(struct orig_node *orig_node,
+		int mca_pos, uint8_t *mc_addr_list, int num_mcast_entries)
+{
+	int pos;
+
+	for (pos = 0; pos < num_mcast_entries; pos++)
+		if (!memcmp(&mc_addr_list[pos*ETH_ALEN],
+			    &orig_node->mca_buff[ETH_ALEN*mca_pos], ETH_ALEN))
+			return pos;
+	return -1;
+}
+
+static struct sk_buff *build_tracker_packet_skb(int tracker_packet_len,
+						int used_mcast_entries,
+						struct bat_priv *bat_priv)
+{
+	struct sk_buff *skb;
+	struct mcast_tracker_packet *tracker_packet;
+
+	skb = dev_alloc_skb(tracker_packet_len + sizeof(struct ethhdr));
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, sizeof(struct ethhdr));
+	tracker_packet = (struct mcast_tracker_packet*) skb_put(skb, tracker_packet_len);
+
+	tracker_packet->packet_type = BAT_MCAST_TRACKER;
+	tracker_packet->version = COMPAT_VERSION;
+	memcpy(tracker_packet->orig, bat_priv->primary_if->net_dev->dev_addr,
+		ETH_ALEN);
+	tracker_packet->ttl = TTL;
+	tracker_packet->num_mcast_entries = (used_mcast_entries > UINT8_MAX) ?
+						UINT8_MAX : used_mcast_entries;
+	memset(tracker_packet->align, 0, sizeof(tracker_packet->align));
+
+	return skb;
+}
+
+/**
+ * Prepares a multicast tracker packet on a multicast member with all its
+ * groups and their members attached. Note, that the proactive tracking
+ * mode does not differentiate between multicast senders and receivers,
+ * resulting in tracker packets between each node.
+ *
+ * Returns NULL if this node is not a member of any group or if there are
+ * no other members in its groups.
+ *
+ * @bat_priv:		bat_priv for the mesh we are preparing this packet
+ */
+static struct sk_buff *mcast_proact_tracker_prepare(struct bat_priv *bat_priv)
+{
+	struct net_device *soft_iface = bat_priv->primary_if->soft_iface;
+	uint8_t *mc_addr_list;
+	struct netdev_hw_addr *mc_entry;
+	struct element_t *bucket;
+	struct orig_node *orig_node;
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
+	int i, tracker_packet_len;
+
+	/* one dest_entries_buckets[x] per multicast group,
+	 * they'll collect dest_entries[y] items */
+	int num_mcast_entries, used_mcast_entries = 0;
+	struct list_head *dest_entries_buckets;
+	struct dest_entries_list *dest_entries, *dest, *tmp;
+	int dest_entries_total = 0;
+
+	uint8_t *dest_entry;
+	int pos, mca_pos;
+	struct sk_buff *skb;
+	struct mcast_entry *mcast_entry;
+
+	if (!hash)
+		goto out;
+
+	dest_entries = kmalloc(sizeof(struct dest_entries_list) * UINT8_MAX,
+			       GFP_ATOMIC);
+	if (!dest_entries)
+		goto out;
+
+	/* Make a copy so we don't have to rush because of locking */
+	netif_addr_lock_bh(soft_iface);
+	num_mcast_entries = netdev_mc_count(soft_iface);
+	mc_addr_list = kmalloc(ETH_ALEN * num_mcast_entries, GFP_ATOMIC);
+	if (!mc_addr_list) {
+		netif_addr_unlock_bh(soft_iface);
+		goto free;
+	}
+	pos = 0;
+	netdev_for_each_mc_addr(mc_entry, soft_iface) {
+		memcpy(&mc_addr_list[pos * ETH_ALEN], mc_entry->addr,
+		       ETH_ALEN);
+		pos++;
+	}
+	netif_addr_unlock_bh(soft_iface);
+
+	if (num_mcast_entries > UINT8_MAX)
+		num_mcast_entries = UINT8_MAX;
+	dest_entries_buckets = kmalloc(num_mcast_entries *
+					sizeof(struct list_head), GFP_ATOMIC);
+	if (!dest_entries_buckets)
+		goto free2;
+
+	for (pos = 0; pos < num_mcast_entries; pos++)
+		INIT_LIST_HEAD(&dest_entries_buckets[pos]);
+
+	/* Collect items from every orig_node's mca buffer if matching one of
+	 * our own multicast groups' address in a dest_entries[x] and throw
+	 * them in the according multicast group buckets
+	 * (dest_entries_buckets[y]) */
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			if (!orig_node->num_mca)
+				continue;
+
+			for (mca_pos = 0; mca_pos < orig_node->num_mca &&
+			     dest_entries_total != UINT8_MAX; mca_pos++) {
+				pos = find_mca_match(orig_node, mca_pos,
+					mc_addr_list, num_mcast_entries);
+				if (pos > num_mcast_entries || pos < 0)
+					continue;
+				memcpy(dest_entries[dest_entries_total].dest,
+				       orig_node->orig, ETH_ALEN);
+				list_add(
+					&dest_entries[dest_entries_total].list,
+					&dest_entries_buckets[pos]);
+
+				dest_entries_total++;
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	/* Any list left empty? */
+	for (pos = 0; pos < num_mcast_entries; pos++)
+		if (!list_empty(&dest_entries_buckets[pos]))
+			used_mcast_entries++;
+
+	if (!used_mcast_entries)
+		goto free_all;
+
+	/* prepare tracker packet, finally! */
+	tracker_packet_len = sizeof(struct mcast_tracker_packet) +
+			     used_mcast_entries * sizeof(struct mcast_entry) +
+			     ETH_ALEN * dest_entries_total;
+	if (tracker_packet_len > ETH_DATA_LEN) {
+		pr_warning("mcast tracker packet got too large (%i Bytes), "
+			   "forcing reduced size of %i Bytes\n",
+			   tracker_packet_len, ETH_DATA_LEN);
+		tracker_packet_len = ETH_DATA_LEN;
+	}
+
+	skb = build_tracker_packet_skb(tracker_packet_len, used_mcast_entries,
+				       bat_priv);
+	if (!skb)
+		goto free_all;
+
+	/* append all collected entries */
+	mcast_entry = (struct mcast_entry *)
+			(skb->data + sizeof(struct mcast_tracker_packet));
+	for (pos = 0; pos < num_mcast_entries; pos++) {
+		if (list_empty(&dest_entries_buckets[pos]))
+			continue;
+
+		if ((unsigned char *)(mcast_entry + 1) <=
+		    skb_tail_pointer(skb)) {
+			memcpy(mcast_entry->mcast_addr,
+			       &mc_addr_list[pos*ETH_ALEN], ETH_ALEN);
+			mcast_entry->num_dest = 0;
+			mcast_entry->align = 0;
+		}
+
+		dest_entry = (uint8_t *)(mcast_entry + 1);
+		list_for_each_entry_safe(dest, tmp, &dest_entries_buckets[pos],
+					 list) {
+			/* still place for a dest_entry left?
+			 * watch out for overflow here, stop at UINT8_MAX */
+			if ((unsigned char *)dest_entry + ETH_ALEN <=
+			    skb_tail_pointer(skb) &&
+			    mcast_entry->num_dest != UINT8_MAX) {
+				mcast_entry->num_dest++;
+				memcpy(dest_entry, dest->dest, ETH_ALEN);
+				dest_entry += ETH_ALEN;
+			}
+			list_del(&dest->list);
+		}
+		/* still space for another mcast_entry left? */
+		if ((unsigned char *)(mcast_entry + 1) <=
+		    skb_tail_pointer(skb))
+			mcast_entry = (struct mcast_entry *)dest_entry;
+	}
+
+
+	/* outstanding cleanup */
+free_all:
+	kfree(dest_entries_buckets);
+free2:
+	kfree(mc_addr_list);
+free:
+	kfree(dest_entries);
+out:
+
+	return skb;
+}
+
+/* Adds the router for the destination address to the next_hop list and its
+ * interface to the forw_if_list - but only if this router has not been
+ * added yet */
+static int add_router_of_dest(struct dest_entries_list *next_hops,
+			      uint8_t *dest, struct bat_priv *bat_priv)
+{
+	struct dest_entries_list *next_hop_tmp, *next_hop_entry;
+	struct orig_node *orig_node;
+	int ret = 1;
+
+
+	next_hop_entry = kmalloc(sizeof(struct dest_entries_list), GFP_ATOMIC);
+	if (!next_hop_entry)
+		goto out;
+
+	rcu_read_lock();
+	orig_node = hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
+			      dest);
+	if (!orig_node || !orig_node->router ||
+	    !orig_node->router->if_incoming) {
+		rcu_read_unlock();
+		goto free;
+	}
+
+	memcpy(next_hop_entry->dest, orig_node->router->addr,
+	       ETH_ALEN);
+	next_hop_entry->batman_if = orig_node->router->if_incoming;
+	kref_get(&next_hop_entry->batman_if->refcount);
+	rcu_read_unlock();
+
+	list_for_each_entry(next_hop_tmp, &next_hops->list, list)
+		if (!memcmp(next_hop_tmp->dest, next_hop_entry->dest,
+								ETH_ALEN))
+			goto kref_free;
+
+	list_add(&next_hop_entry->list, &next_hops->list);
+
+	ret = 0;
+	goto out;
+
+kref_free:
+	kref_put(&next_hop_entry->batman_if->refcount, hardif_free_ref);
+free:
+	kfree(next_hop_entry);
+out:
+	return ret;
+}
+
+/* Collect nexthops for all dest entries specified in this tracker packet */
+static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
+			     struct dest_entries_list *next_hops,
+			     struct bat_priv *bat_priv)
+{
+	int num_next_hops = 0, ret;
+	struct tracker_packet_state state;
+
+	INIT_LIST_HEAD(&next_hops->list);
+
+	tracker_packet_for_each_dest(&state, tracker_packet) {
+		ret = add_router_of_dest(next_hops, state.dest_entry,
+					 bat_priv);
+		if (!ret)
+			num_next_hops++;
+	}
+
+	return num_next_hops;
+}
+
+/* Zero destination entries not destined for the specified next hop in the
+ * tracker packet */
+static void zero_tracker_packet(struct mcast_tracker_packet *tracker_packet,
+				uint8_t *next_hop, struct bat_priv *bat_priv)
+{
+	struct tracker_packet_state state;
+	struct orig_node *orig_node;
+
+	tracker_packet_for_each_dest(&state, tracker_packet) {
+		rcu_read_lock();
+		orig_node = hash_find(bat_priv->orig_hash, compare_orig,
+				      choose_orig, state.dest_entry);
+
+		/* we don't know this destination */
+		if (!orig_node ||
+		    /* is the next hop already our destination? */
+		    !memcmp(orig_node->orig, next_hop, ETH_ALEN) ||
+		    !orig_node->router ||
+		    !memcmp(orig_node->router->orig_node->primary_addr,
+			    orig_node->orig, ETH_ALEN) ||
+		    /* is this the wrong next hop for our
+		     * destination? */
+		    memcmp(orig_node->router->addr, next_hop, ETH_ALEN))
+			memset(state.dest_entry, '\0', ETH_ALEN);
+
+		rcu_read_unlock();
+	}
+}
+
+/* Remove zeroed destination entries and empty multicast entries in tracker
+ * packet */
+static void shrink_tracker_packet(struct sk_buff *skb)
+{
+	struct mcast_tracker_packet *tracker_packet =
+				(struct mcast_tracker_packet*)skb->data;
+	struct tracker_packet_state state;
+	unsigned char *tail = skb_tail_pointer(skb);
+	int new_tracker_packet_len = sizeof(struct mcast_tracker_packet);
+
+	tracker_packet_for_each_dest(&state, tracker_packet) {
+		if (memcmp(state.dest_entry, "\0\0\0\0\0\0", ETH_ALEN)) {
+			new_tracker_packet_len += ETH_ALEN;
+			continue;
+		}
+
+		memmove(state.dest_entry, state.dest_entry + ETH_ALEN,
+			tail - state.dest_entry - ETH_ALEN);
+
+		state.mcast_entry->num_dest--;
+		tail -= ETH_ALEN;
+
+		if (state.mcast_entry->num_dest) {
+			state.dest_num--;
+			state.dest_entry -= ETH_ALEN;
+			continue;
+		}
+
+		/* = mcast_entry */
+		state.dest_entry -= sizeof(struct mcast_entry);
+
+		memmove(state.dest_entry, state.dest_entry +
+			sizeof(struct mcast_entry),
+			tail - state.dest_entry - sizeof(struct mcast_entry));
+
+		tracker_packet->num_mcast_entries--;
+		tail -= sizeof(struct mcast_entry);
+
+		state.mcast_num--;
+
+		/* Avoid mcast_entry check of tracker_packet_for_each_dest's
+		 * inner loop */
+		state.break_flag = 0;
+		break;
+	}
+
+	new_tracker_packet_len += sizeof(struct mcast_entry) *
+				  tracker_packet->num_mcast_entries;
+
+	skb_trim(skb, new_tracker_packet_len);
+}
+
+
+/**
+ * Sends (splitted parts of) a multicast tracker packet on the according
+ * interfaces.
+ *
+ * @tracker_packet:	A compact multicast tracker packet with all groups and
+ *			destinations attached.
+ */
+void route_mcast_tracker_packet(struct sk_buff *skb,
+				struct bat_priv *bat_priv)
+{
+	struct dest_entries_list next_hops, *tmp;
+	struct dest_entries_list *next_hop;
+	struct sk_buff *skb_tmp;
+	int num_next_hops;
+
+	num_next_hops = tracker_next_hops((struct mcast_tracker_packet*)
+				skb->data, &next_hops, bat_priv);
+	if (!num_next_hops)
+		return;
+
+	list_for_each_entry(next_hop, &next_hops.list, list) {
+		skb_tmp = skb_copy(skb, GFP_ATOMIC);
+		if (!skb_tmp)
+			goto free;
+
+		/* cut the tracker packets for the according destinations */
+		zero_tracker_packet((struct mcast_tracker_packet*)
+				skb_tmp->data, next_hop->dest, bat_priv);
+		shrink_tracker_packet(skb_tmp);
+		if (skb_tmp->len == sizeof(struct mcast_tracker_packet)) {
+			dev_kfree_skb(skb_tmp);
+			continue;
+		}
+
+		/* Send 'em! */
+		send_skb_packet(skb_tmp, next_hop->batman_if, next_hop->dest);
+	}
+
+free:
+	list_for_each_entry_safe(next_hop, tmp, &next_hops.list, list) {
+		kref_put(&next_hop->batman_if->refcount, hardif_free_ref);
+		list_del(&next_hop->list);
+		kfree(next_hop);
+	}
+}
+
 static void mcast_tracker_timer(struct work_struct *work)
 {
 	struct bat_priv *bat_priv = container_of(work, struct bat_priv,
 						 mcast_tracker_work.work);
+	struct sk_buff *tracker_packet = NULL;
 
+	if (atomic_read(&bat_priv->mcast_mode) == MCAST_MODE_PROACT_TRACKING)
+		tracker_packet = mcast_proact_tracker_prepare(bat_priv);
+
+	if (!tracker_packet)
+		goto out;
+
+	route_mcast_tracker_packet(tracker_packet, bat_priv);
+	dev_kfree_skb(tracker_packet);
+
+out:
 	start_mcast_tracker(bat_priv);
 }
 
diff --git a/batman-adv/multicast.h b/batman-adv/multicast.h
index 26ce6d8..d1a3e83 100644
--- a/batman-adv/multicast.h
+++ b/batman-adv/multicast.h
@@ -27,6 +27,8 @@ int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
 int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
 			       size_t count);
 void mcast_tracker_reset(struct bat_priv *bat_priv);
+void route_mcast_tracker_packet(struct sk_buff *tracker_packet,
+				struct bat_priv *bat_priv);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
 
diff --git a/batman-adv/packet.h b/batman-adv/packet.h
index d77af90..6f42a2f 100644
--- a/batman-adv/packet.h
+++ b/batman-adv/packet.h
@@ -24,12 +24,13 @@
 
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
-#define BAT_PACKET       0x01
-#define BAT_ICMP         0x02
-#define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
-#define BAT_VIS          0x05
-#define BAT_UNICAST_FRAG 0x06
+#define BAT_PACKET        0x01
+#define BAT_ICMP          0x02
+#define BAT_UNICAST       0x03
+#define BAT_BCAST         0x04
+#define BAT_VIS           0x05
+#define BAT_UNICAST_FRAG  0x06
+#define BAT_MCAST_TRACKER 0x07
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 14
@@ -125,6 +126,22 @@ struct bcast_packet {
 	uint32_t seqno;
 } __packed;
 
+/* marks the path for multicast streams */
+struct mcast_tracker_packet {
+        uint8_t  packet_type;    /* BAT_MCAST_TRACKER */
+        uint8_t  version;        /* batman version field */
+        uint8_t  orig[6];
+        uint8_t  ttl;
+        uint8_t  num_mcast_entries;
+        uint8_t  align[2];
+} __packed;
+
+struct mcast_entry {
+        uint8_t  mcast_addr[6];
+        uint8_t  num_dest;       /* number of multicast data receivers */
+        uint8_t  align;
+} __packed;
+
 struct vis_packet {
 	uint8_t  packet_type;
 	uint8_t  version;        /* batman version field */
-- 
1.7.2.3

