Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:17 +0100
Message-Id: <1291761150-29818-7-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 07/20] batman-adv: Prepare and send own
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
 hash.h      |    4 +
 multicast.c |  469 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h |    3 +
 3 files changed, 476 insertions(+), 0 deletions(-)

diff --git a/hash.h b/hash.h
index 0b61c6e..d61c185 100644
--- a/hash.h
+++ b/hash.h
@@ -28,6 +28,10 @@
 		.index = 0, .walk = NULL, \
 		.safe = NULL}
 
+#define HASHIT_RESET(name) \
+		name.index = 0, name.walk = NULL; \
+		name.safe = NULL
+
 /* callback to a compare function.  should
  * compare 2 element datas for their keys,
  * return 0 if same and not 0 if not
diff --git a/multicast.c b/multicast.c
index 1ddd37b..bfb1410 100644
--- a/multicast.c
+++ b/multicast.c
@@ -21,6 +21,24 @@
 
 #include "main.h"
 #include "multicast.h"
+#include "hash.h"
+#include "send.h"
+#include "compat.h"
+
+#define tracker_packet_for_each_dest(mcast_entry, dest_entry, mcast_num, dest_num, tracker_packet) \
+	for (mcast_num = 0, mcast_entry = (struct mcast_entry *)(tracker_packet + 1), \
+	     dest_entry = (uint8_t *)(mcast_entry + 1); \
+	     mcast_num < tracker_packet->num_mcast_entries; mcast_num++, \
+	     mcast_entry = (struct mcast_entry *)dest_entry, \
+	     dest_entry = (uint8_t *)(mcast_entry + 1)) \
+		for (dest_num = 0; dest_num < mcast_entry->num_dest; dest_num++, \
+		     dest_entry += ETH_ALEN)
+
+struct dest_entries_list {
+	struct list_head list;
+	uint8_t dest[6];
+	struct batman_if *batman_if;
+};
 
 /* how long to wait until sending a multicast tracker packet */
 static int tracker_send_delay(struct bat_priv *bat_priv)
@@ -56,11 +74,462 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 	start_mcast_tracker(bat_priv);
 }
 
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
+static struct mcast_tracker_packet *mcast_proact_tracker_prepare(
+			struct bat_priv *bat_priv, int *tracker_packet_len)
+{
+	struct net_device *soft_iface = bat_priv->primary_if->soft_iface;
+	uint8_t *mc_addr_list;
+	MC_LIST *mc_entry;
+	struct element_t *bucket;
+	struct orig_node *orig_node;
+
+	/* one dest_entries_list per multicast group,
+	 * they'll collect dest_entries[x] */
+	int num_mcast_entries, used_mcast_entries = 0;
+	struct list_head *dest_entries_list;
+	struct dest_entries_list dest_entries[UINT8_MAX], *dest, *tmp;
+	int num_dest_entries, dest_entries_total = 0;
+
+	uint8_t *dest_entry;
+	int pos, mca_pos;
+	unsigned long flags;
+	struct mcast_tracker_packet *tracker_packet = NULL;
+	struct mcast_entry *mcast_entry;
+	HASHIT(hashit);
+
+	/* Make a copy so we don't have to rush because of locking */
+	MC_LIST_LOCK(soft_iface, flags);
+	num_mcast_entries = netdev_mc_count(soft_iface);
+	mc_addr_list = kmalloc(ETH_ALEN * num_mcast_entries, GFP_ATOMIC);
+	if (!mc_addr_list) {
+		MC_LIST_UNLOCK(soft_iface, flags);
+		goto out;
+	}
+	pos = 0;
+	netdev_for_each_mc_addr(mc_entry, soft_iface) {
+		memcpy(&mc_addr_list[pos * ETH_ALEN], mc_entry->MC_LIST_ADDR,
+		       ETH_ALEN);
+		pos++;
+	}
+	MC_LIST_UNLOCK(soft_iface, flags);
+
+	if (num_mcast_entries > UINT8_MAX)
+		num_mcast_entries = UINT8_MAX;
+	dest_entries_list = kmalloc(num_mcast_entries *
+					sizeof(struct list_head), GFP_ATOMIC);
+	if (!dest_entries_list)
+		goto free;
+
+	for (pos = 0; pos < num_mcast_entries; pos++)
+		INIT_LIST_HEAD(&dest_entries_list[pos]);
+
+	/* fill the lists and buffers */
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
+		if (!orig_node->num_mca)
+			continue;
+
+		num_dest_entries = 0;
+		for (mca_pos = 0; mca_pos < orig_node->num_mca && dest_entries_total != UINT8_MAX; mca_pos++) {
+			pos = find_mca_match(orig_node, mca_pos, mc_addr_list,
+					     num_mcast_entries);
+			if (pos > UINT8_MAX || pos < 0)
+				continue;
+			memcpy(dest_entries[dest_entries_total].dest, orig_node->orig, ETH_ALEN);
+			list_add(&dest_entries[dest_entries_total].list, &dest_entries_list[pos]);
+
+			num_dest_entries++;
+			dest_entries_total++;
+		}
+	}
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+
+	/* Any list left empty? */
+	for (pos = 0; pos < num_mcast_entries; pos++)
+		if (!list_empty(&dest_entries_list[pos]))
+			used_mcast_entries++;
+
+	if (!used_mcast_entries)
+		goto free_all;
+
+	/* prepare tracker packet, finally! */
+	*tracker_packet_len = sizeof(struct mcast_tracker_packet) +
+			     sizeof(struct mcast_entry) * used_mcast_entries +
+			     ETH_ALEN * dest_entries_total;
+	if (*tracker_packet_len > ETH_DATA_LEN) {
+		pr_warning("mcast tracker packet got too large (%i Bytes), "
+			   "forcing reduced size of %i Bytes\n",
+			   *tracker_packet_len, ETH_DATA_LEN);
+		*tracker_packet_len = ETH_DATA_LEN;
+	}
+	tracker_packet = kmalloc(*tracker_packet_len, GFP_ATOMIC);
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
+	/* append all collected entries */
+	mcast_entry = (struct mcast_entry *)(tracker_packet + 1);
+	for (pos = 0; pos < num_mcast_entries; pos++) {
+		if (list_empty(&dest_entries_list[pos]))
+			continue;
+
+		if ((char *)(mcast_entry + 1) <=
+		    (char *)tracker_packet + ETH_DATA_LEN) {
+			memcpy(mcast_entry->mcast_addr,
+			       &mc_addr_list[pos*ETH_ALEN], ETH_ALEN);
+			mcast_entry->num_dest = 0;
+		}
+
+		dest_entry = (uint8_t *)(mcast_entry + 1);
+		list_for_each_entry_safe(dest, tmp, &dest_entries_list[pos],
+					 list) {
+			/* still place for a dest_entry left?
+			 * watch out for overflow here, stop at UINT8_MAX */
+			if ((char *)dest_entry + ETH_ALEN <=
+			    (char *)tracker_packet + ETH_DATA_LEN &&
+			    mcast_entry->num_dest != UINT8_MAX) {
+				mcast_entry->num_dest++;
+				memcpy(dest_entry, dest->dest, ETH_ALEN);
+				dest_entry += ETH_ALEN;
+			}
+			list_del(&dest->list);
+		}
+		/* still space for another mcast_entry left? */
+		if ((char *)(mcast_entry + 1) <=
+		    (char *)tracker_packet + ETH_DATA_LEN)
+			mcast_entry = (struct mcast_entry*)dest_entry;
+	}
+
+
+	/* outstanding cleanup */
+free_all:
+	kfree(dest_entries_list);
+free:
+	kfree(mc_addr_list);
+out:
+
+	return tracker_packet;
+}
+
+/* Adds the router for the destination address to the next_hop list and its
+ * interface to the forw_if_list - but only if this router has not been
+ * added yet */
+static int add_router_of_dest(struct dest_entries_list *next_hops,
+			      uint8_t *dest, struct bat_priv *bat_priv)
+{
+	struct dest_entries_list *next_hop_tmp, *next_hop_entry;
+	unsigned long flags;
+	struct element_t *bucket;
+	struct orig_node *orig_node;
+	HASHIT(hashit);
+
+	next_hop_entry = kmalloc(sizeof(struct dest_entries_list), GFP_ATOMIC);
+	if (!next_hop_entry)
+		return 1;
+
+	next_hop_entry->batman_if = NULL;
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
+
+		if (memcmp(orig_node->orig, dest, ETH_ALEN))
+			continue;
+
+		if (!orig_node->router)
+			break;
+
+		memcpy(next_hop_entry->dest, orig_node->router->addr,
+		       ETH_ALEN);
+		next_hop_entry->batman_if = orig_node->router->if_incoming;
+		break;
+	}
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	if (!next_hop_entry->batman_if)
+		goto free;
+
+	list_for_each_entry(next_hop_tmp, &next_hops->list, list)
+		if (!memcmp(next_hop_tmp->dest, next_hop_entry->dest,
+								ETH_ALEN))
+			goto free;
+
+	list_add(&next_hop_entry->list, &next_hops->list);
+
+	return 0;
+
+free:
+	kfree(next_hop_entry);
+	return 1;
+}
+
+/* Collect nexthops for all dest entries specified in this tracker packet */
+static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
+			     struct dest_entries_list *next_hops,
+			     struct bat_priv *bat_priv)
+{
+	int num_next_hops = 0, mcast_num, dest_num, ret;
+	struct mcast_entry *mcast_entry;
+	uint8_t *dest_entry;
+
+	INIT_LIST_HEAD(&next_hops->list);
+
+	tracker_packet_for_each_dest(mcast_entry, dest_entry,
+				     mcast_num, dest_num, tracker_packet) {
+		ret = add_router_of_dest(next_hops, dest_entry,
+					 bat_priv);
+		if (!ret)
+			num_next_hops++;
+	}
+
+	return num_next_hops;
+}
+
+static void zero_tracker_packet(struct mcast_tracker_packet *tracker_packet,
+				uint8_t *next_hop, struct bat_priv *bat_priv)
+{
+	struct mcast_entry *mcast_entry;
+	uint8_t *dest_entry;
+	int mcast_num, dest_num;
+
+	unsigned long flags;
+	struct element_t *bucket;
+	struct orig_node *orig_node;
+	HASHIT(hashit);
+
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	tracker_packet_for_each_dest(mcast_entry, dest_entry,
+				     mcast_num, dest_num, tracker_packet) {
+		while (hash_iterate(bat_priv->orig_hash, &hashit)) {
+			bucket = hlist_entry(hashit.walk, struct element_t,
+					     hlist);
+			orig_node = bucket->data;
+
+			if (memcmp(orig_node->orig, dest_entry, ETH_ALEN))
+				continue;
+
+			/* is the next hop already our destination? */
+			if (!memcmp(orig_node->orig, next_hop, ETH_ALEN))
+				memset(dest_entry, '\0', ETH_ALEN);
+			else if (!orig_node->router)
+				memset(dest_entry, '\0', ETH_ALEN);
+			else if (!memcmp(orig_node->orig,
+				    orig_node->router->orig_node->primary_addr,
+				    ETH_ALEN))
+				memset(dest_entry, '\0', ETH_ALEN);
+			/* is this the wrong next hop for our destination? */
+			else if (memcmp(orig_node->router->addr,
+					next_hop, ETH_ALEN))
+				memset(dest_entry, '\0', ETH_ALEN);
+
+			break;
+		}
+		HASHIT_RESET(hashit);
+	}
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+}
+
+static int shrink_tracker_packet(struct mcast_tracker_packet *tracker_packet,
+				  int tracker_packet_len)
+{
+	struct mcast_entry *mcast_entry;
+	uint8_t *dest_entry;
+	uint8_t *tail = (uint8_t *)tracker_packet + tracker_packet_len;
+	int mcast_num, dest_num;
+	int new_tracker_packet_len = sizeof(struct mcast_tracker_packet);
+
+	tracker_packet_for_each_dest(mcast_entry, dest_entry,
+				     mcast_num, dest_num, tracker_packet) {
+		if (memcmp(dest_entry, "\0\0\0\0\0\0", ETH_ALEN)) {
+			new_tracker_packet_len += ETH_ALEN;
+			continue;
+		}
+
+		memmove(dest_entry, dest_entry + ETH_ALEN,
+			tail - dest_entry - ETH_ALEN);
+
+		mcast_entry->num_dest--;
+		tail -= ETH_ALEN;
+
+		if (mcast_entry->num_dest) {
+			dest_num--;
+			dest_entry -= ETH_ALEN;
+			continue;
+		}
+
+		/* = mcast_entry */
+		dest_entry -= sizeof(struct mcast_entry);
+
+		memmove(dest_entry, dest_entry + sizeof(struct mcast_entry),
+			tail - dest_entry - sizeof(struct mcast_entry));
+
+		tracker_packet->num_mcast_entries--;
+		tail -= sizeof(struct mcast_entry);
+
+		mcast_num--;
+
+		/* Avoid mcast_entry check of tracker_packet_for_each_dest's
+		 * inner loop */
+		break;
+	}
+
+	new_tracker_packet_len += sizeof(struct mcast_entry) *
+				  tracker_packet->num_mcast_entries;
+
+	return new_tracker_packet_len;
+}
+
+static struct sk_buff *build_tracker_packet_skb(
+		struct mcast_tracker_packet *tracker_packet,
+		int tracker_packet_len, uint8_t *dest)
+{
+	struct sk_buff *skb;
+	struct mcast_tracker_packet *skb_tracker_data;
+
+	skb = dev_alloc_skb(tracker_packet_len + sizeof(struct ethhdr));
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, sizeof(struct ethhdr));
+	skb_tracker_data = (struct mcast_tracker_packet *)
+				skb_put(skb, tracker_packet_len);
+
+	memcpy(skb_tracker_data, tracker_packet, tracker_packet_len);
+
+	return skb;
+}
+
+
+/**
+ * Sends (splitted parts of) a multicast tracker packet on the according
+ * interfaces.
+ *
+ * @tracker_packet: 	A compact multicast tracker packet with all groups and
+ * 			destinations attached.
+ */
+void route_mcast_tracker_packet(
+			struct mcast_tracker_packet *tracker_packet,
+			int tracker_packet_len, struct bat_priv *bat_priv)
+{
+	struct dest_entries_list next_hops, *tmp;
+	struct mcast_tracker_packet *next_hop_tracker_packets,
+				    *next_hop_tracker_packet;
+	struct dest_entries_list *next_hop;
+	struct sk_buff *skb;
+	int num_next_hops, i;
+	int *tracker_packet_lengths;
+
+	rcu_read_lock();
+	num_next_hops = tracker_next_hops(tracker_packet, &next_hops,
+					  bat_priv);
+	if (!num_next_hops)
+		goto out;
+	next_hop_tracker_packets = kmalloc(tracker_packet_len * num_next_hops,
+					   GFP_ATOMIC);
+	if (!next_hop_tracker_packets)
+		goto free;
+
+	tracker_packet_lengths = kmalloc(sizeof(int) * num_next_hops,
+					  GFP_ATOMIC);
+	if (!tracker_packet_lengths)
+		goto free2;
+
+	i = 0;
+	list_for_each_entry_safe(next_hop, tmp, &next_hops.list, list) {
+		next_hop_tracker_packet = (struct mcast_tracker_packet *)
+					  ((char *)next_hop_tracker_packets +
+					   i * tracker_packet_len);
+		memcpy(next_hop_tracker_packet, tracker_packet,
+		       tracker_packet_len);
+		zero_tracker_packet(next_hop_tracker_packet, next_hop->dest,
+				    bat_priv);
+		tracker_packet_lengths[i] = shrink_tracker_packet(
+				next_hop_tracker_packet, tracker_packet_len);
+		i++;
+	}
+
+	i = 0;
+	/* Add ethernet header, send 'em! */
+	list_for_each_entry_safe(next_hop, tmp, &next_hops.list, list) {
+		if (tracker_packet_lengths[i] ==
+		    sizeof(struct mcast_tracker_packet))
+			goto skip_send;
+
+		skb = build_tracker_packet_skb(&next_hop_tracker_packets[i],
+					       tracker_packet_lengths[i],
+					       next_hop->dest);
+		if (skb)
+			send_skb_packet(skb, next_hop->batman_if,
+					next_hop->dest);
+skip_send:
+		list_del(&next_hop->list);
+		kfree(next_hop);
+		i++;
+	}
+
+	kfree(tracker_packet_lengths);
+	kfree(next_hop_tracker_packets);
+	return;
+
+free2:
+	kfree(next_hop_tracker_packets);
+free:
+	list_for_each_entry_safe(next_hop, tmp, &next_hops.list, list) {
+		list_del(&next_hop->list);
+		kfree(next_hop);
+	}
+out:
+	rcu_read_unlock();
+}
+
 static void mcast_tracker_timer(struct work_struct *work)
 {
 	struct bat_priv *bat_priv = container_of(work, struct bat_priv,
 						 mcast_tracker_work.work);
+	struct mcast_tracker_packet *tracker_packet = NULL;
+	int tracker_packet_len = 0;
+
+	if (atomic_read(&bat_priv->mcast_mode) == MCAST_MODE_PROACT_TRACKING)
+		tracker_packet = mcast_proact_tracker_prepare(bat_priv,
+							&tracker_packet_len);
+
+	if (!tracker_packet)
+		goto out;
+
+	route_mcast_tracker_packet(tracker_packet, tracker_packet_len, bat_priv);
+	kfree(tracker_packet);
 
+out:
 	start_mcast_tracker(bat_priv);
 }
 
diff --git a/multicast.h b/multicast.h
index 26ce6d8..2711d8b 100644
--- a/multicast.h
+++ b/multicast.h
@@ -27,6 +27,9 @@ int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
 int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
 			       size_t count);
 void mcast_tracker_reset(struct bat_priv *bat_priv);
+void route_mcast_tracker_packet(
+			struct mcast_tracker_packet *tracker_packet,
+			int tracker_packet_len, struct bat_priv *bat_priv);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
 
-- 
1.7.1

