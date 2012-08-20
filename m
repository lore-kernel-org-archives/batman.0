Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 20 Aug 2012 13:48:10 +0200
Message-Id: <1345463292-19712-4-git-send-email-martin@hundeboll.net>
In-Reply-To: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
References: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 3/5] batman-adv: Receive fragmented packets and
	merge
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Fragments arriving at their destination are buffered for later merge.
Merged packets are passed to the main receive function as had they never
been fragmented.

Fragments are forwarded without merging if the MTU of the outgoing
interface is smaller than the size of the merged packet.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 Makefile.kbuild  |   1 +
 fragmentation.c  | 372 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fragmentation.h  |  31 +++++
 main.c           |   3 +
 main.h           |   3 +
 originator.c     |  12 +-
 packet.h         |  29 +++++
 routing.c        |  59 +++++++++
 routing.h        |   2 +
 soft-interface.c |   4 +
 types.h          |  33 +++++
 11 files changed, 548 insertions(+), 1 deletion(-)
 create mode 100644 fragmentation.c
 create mode 100644 fragmentation.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 9d622ad..49d9b49 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -23,6 +23,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += debugfs.o
+batman-adv-y += fragmentation.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/fragmentation.c b/fragmentation.c
new file mode 100644
index 0000000..839bb54
--- /dev/null
+++ b/fragmentation.c
@@ -0,0 +1,372 @@
+/* Copyright (C) 2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll <martin@hundeboll.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ */
+
+#include "main.h"
+#include "fragmentation.h"
+#include "send.h"
+#include "originator.h"
+#include "routing.h"
+#include "hard-interface.h"
+#include "soft-interface.h"
+
+
+/**
+ * batadv_frag_clear_list() - Delete entries in the fragment buffer list.
+ * @head: head of list with entries.
+ *
+ * Frees fragments in the passed hlist. Should be called with appropriate lock.
+ */
+static void batadv_frag_clear_list(struct hlist_head *head)
+{
+	struct batadv_frag_list_entry *entry;
+	struct hlist_node *node, *node_tmp;
+
+	hlist_for_each_entry_safe(entry, node, node_tmp, head, list) {
+		hlist_del(node);
+		kfree_skb(entry->skb);
+		kfree(entry);
+	}
+}
+
+/**
+ * batadv_frag_clear_orig() - Free fragments associated to an orig.
+ * @orig_node: Originator to free fragments from.
+ */
+void batadv_frag_clear_orig(struct batadv_orig_node *orig_node)
+{
+	uint8_t i;
+
+	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
+		spin_lock_bh(&orig_node->fragments[i].lock);
+		batadv_frag_clear_list(&orig_node->fragments[i].head);
+		orig_node->fragments[i].size = 0;
+		spin_unlock_bh(&orig_node->fragments[i].lock);
+	}
+}
+
+/**
+ * batadv_frag_check_orig() - Free timed out fragments from an orig.
+ * @orig_node: originator to check fragments from.
+ *
+ * Check timestamp of every hlist in fragment table and delete all entries if
+ * timed out.
+ */
+void batadv_frag_check_orig(struct batadv_orig_node *orig_node)
+{
+	struct batadv_frag_table_entry *frags;
+	uint8_t i;
+
+	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
+		frags = &orig_node->fragments[i];
+		spin_lock_bh(&frags->lock);
+
+		if (!hlist_empty(&frags->head) &&
+		    batadv_has_timed_out(frags->timestamp, BATADV_FRAG_TIMEOUT))
+			batadv_frag_clear_list(&frags->head);
+
+		spin_unlock_bh(&frags->lock);
+	}
+}
+
+/**
+ * batadv_frag_size_limit() - Maximum possible size of fragmented packet.
+ */
+static inline int batadv_frag_size_limit(void)
+{
+	int limit = BATADV_FRAG_MAX_FRAG_SIZE;
+	limit -= sizeof(struct batadv_frag_packet);
+	limit *= BATADV_FRAG_MAX_FRAGMENTS;
+	return limit;
+}
+
+/**
+ * batadv_frag_init_list() - Check and prepare fragment buffer for new fragment.
+ * @frags: Entry in fragments table to init.
+ * @seqno: Sequence number of the received fragment.
+ *
+ * Make list ready for a fragment with sequence number "seqno". Delete existing
+ * entries if they have a "old" sequence number.
+ *
+ * Returns true if list is empty and caller can just insert the new fragment
+ * without searching for the right position.
+ *
+ * Caller must hold frags->lock.
+ */
+static bool batadv_frag_init_list(struct batadv_frag_table_entry *frags,
+				  uint16_t seqno)
+{
+	if (frags->seqno == seqno)
+		return false;
+
+	if (!hlist_empty(&frags->head))
+		batadv_frag_clear_list(&frags->head);
+
+	frags->size = 0;
+	frags->seqno = seqno;
+
+	return true;
+}
+
+/**
+ * batadv_frag_insert_packet() - Insert a fragment into an fragment buffer.
+ * @orig_node: Originator that the fragment was received from.
+ * @skb: skb to insert.
+ * @head: head to attach complete lists of fragments to.
+ *
+ * Insert a new fragment into the reverse ordered list in the right table entry.
+ * The hash table entry is cleared if "old" fragments exist in it.
+ *
+ * Returns true if skb is buffered, false on error. If the list has all the
+ * fragments needed to merge the packet, the list is moved to the passed head.
+ */
+static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
+				      struct sk_buff *skb,
+				      struct hlist_head *head)
+{
+	struct batadv_frag_table_entry *frags;
+	struct batadv_frag_list_entry *new = NULL, *curr = NULL;
+	struct batadv_frag_packet *packet;
+	struct hlist_node *node;
+	uint8_t bucket;
+	uint16_t seqno, hdr_size = sizeof(struct batadv_frag_packet);
+
+	if (skb_linearize(skb) < 0)
+		goto err;
+
+	packet = (struct batadv_frag_packet *)skb->data;
+	seqno = ntohs(packet->seqno);
+	bucket = seqno % BATADV_FRAG_BUFFER_COUNT;
+
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	if (!new)
+		goto err;
+
+	new->skb = skb;
+	new->no = packet->no;
+
+	/* Select entry in the "fragment table" and delete any prior fragments
+	 * with another sequence number. batadv_frag_init_list() returns true,
+	 * if the list is empty at return.
+	 */
+	frags = &orig_node->fragments[bucket];
+	spin_lock_bh(&frags->lock);
+	if (batadv_frag_init_list(frags, seqno)) {
+		hlist_add_head(&new->list, &frags->head);
+		frags->size = skb->len - hdr_size;
+		frags->timestamp = jiffies;
+		goto out;
+	}
+
+	/* Find the position for the new fragment. */
+	hlist_for_each_entry(curr, node, &frags->head, list) {
+		/* Drop packet if fragment already exists. */
+		if (curr->no == new->no)
+			goto err_unlock;
+
+		/* Order fragments from highest to lowest. */
+		if (curr->no < new->no) {
+			hlist_add_before(&new->list, &curr->list);
+			frags->size += skb->len - hdr_size;
+			frags->timestamp = jiffies;
+			goto out;
+		}
+	}
+
+	/* We reached the end of the list, so insert after 'curr'. */
+	if (likely(curr)) {
+		hlist_add_after(&curr->list, &new->list);
+		frags->size += skb->len - hdr_size;
+		frags->timestamp = jiffies;
+	}
+
+out:
+	if (frags->size > batadv_frag_size_limit() ||
+	    ntohs(packet->total_size) > batadv_frag_size_limit()) {
+		/* Clear list if total size of either the list or the packet exceeds
+		 * the maximum size of one merged packet.
+		 */
+		batadv_frag_clear_list(&frags->head);
+		frags->size = 0;
+	} else if (ntohs(packet->total_size) == frags->size) {
+		/* All fragments received. Hand over list to caller. */
+		hlist_move_list(&frags->head, head);
+		frags->size = 0;
+	}
+
+	spin_unlock_bh(&frags->lock);
+	return true;
+
+err_unlock:
+	spin_unlock_bh(&frags->lock);
+	kfree(new);
+err:
+	return false;
+}
+
+/**
+ * batadv_frag_merge_packets() - Merge a list of fragments.
+ * @head: head if list with fragments.
+ * @skb: Packet with total size of skb after merging.
+ *
+ * Expands the first skb in the list and copies the content of the remaining
+ * skb's into the expanded one. After doing so, it clears the list.
+ *
+ * Returns NULL on error.
+ */
+static struct sk_buff *
+batadv_frag_merge_packets(struct hlist_head *head, struct sk_buff *skb)
+{
+	struct batadv_frag_packet *packet;
+	struct batadv_frag_list_entry *entry;
+	struct hlist_node *node;
+	struct sk_buff *skb_out = NULL;
+	int size, hdr_size = sizeof(struct batadv_frag_packet);
+
+	/* Make sure incoming skb has non-bogus data. */
+	packet = (struct batadv_frag_packet *)skb->data;
+	size = ntohs(packet->total_size);
+	if (size > batadv_frag_size_limit())
+		goto free;
+
+	/* Remove first entry, as this is the destination for the rest of the
+	 * fragments.
+	 */
+	entry = hlist_entry(head->first, struct batadv_frag_list_entry, list);
+	hlist_del(&entry->list);
+	skb_out = entry->skb;
+	kfree(entry);
+
+	/* Make room for the rest of the fragments. */
+	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
+		kfree_skb(skb_out);
+		goto free;
+	}
+
+	/* Move the existing MAC header to just before the payload. (Override
+	 * the fragment header.)
+	 */
+	skb_pull_rcsum(skb_out, hdr_size);
+	memmove(skb_out->data - ETH_HLEN, skb_mac_header(skb_out), ETH_HLEN);
+	skb_set_mac_header(skb_out, -ETH_HLEN);
+	skb_reset_network_header(skb_out);
+	skb_reset_transport_header(skb_out);
+
+	/* Copy the payload of the each fragment into the last skb */
+	hlist_for_each_entry(entry, node, head, list) {
+		size = entry->skb->len - hdr_size;
+		memcpy(skb_put(skb_out, size), entry->skb->data + hdr_size, size);
+	}
+
+free:
+	/* Locking is not needed, because 'head' is not part of any orig. */
+	batadv_frag_clear_list(head);
+	return skb_out;
+}
+
+/**
+ * batadv_frag_skb_buffer() - Buffer fragment for later merge.
+ * @skb: skb to buffer.
+ * @orig_node_src: Originator that the skb is received from.
+ *
+ * Add fragment to buffer and merge fragments if possible.
+ *
+ * There are three possible outcomes: 1) Packet is merged: Return true and
+ * set *skb to merged packet; 2) Packet is buffered: Return true and set *skb
+ * to NULL; 3) Error: Return false and leave skb as is.
+ */
+bool batadv_frag_skb_buffer(struct sk_buff **skb,
+			    struct batadv_orig_node *orig_node_src)
+{
+	struct sk_buff *skb_out = NULL;
+	struct hlist_head head = HLIST_HEAD_INIT;
+	bool ret = false;
+
+	/* Add packet to buffer and table entry if merge is possible. */
+	if (!batadv_frag_insert_packet(orig_node_src, *skb, &head))
+		goto out_err;
+
+	/* Leave if more fragments are needed to merge. */
+	if (hlist_empty(&head))
+		goto out;
+
+	skb_out = batadv_frag_merge_packets(&head, *skb);
+	if (!skb_out)
+		goto out_err;
+
+out:
+	*skb = skb_out;
+	ret = true;
+out_err:
+	return ret;
+}
+
+/**
+ * batadv_frag_skb_fwd() - Forward fragments that would exceed MTU when merged.
+ * @skb: skb to forward.
+ * @recv_if: Interface that the skb is received on.
+ * @orig_node_src: Originator that the skb is received from.
+ *
+ * Look up the next-hop of the fragments payload and check if the merged packet
+ * will exceed the MTU towards the next-hop. If so, the fragment is forwarded
+ * without merging it.
+ *
+ * Returns true if the fragment is consumed/forwarded, false otherwise.
+ */
+bool batadv_frag_skb_fwd(struct sk_buff *skb,
+			 struct batadv_hard_iface *recv_if,
+			 struct batadv_orig_node *orig_node_src)
+{
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_orig_node *orig_node_dst = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_frag_packet *packet;
+	uint16_t total_size;
+	bool ret = false;
+
+	packet = (struct batadv_frag_packet *)skb->data;
+	orig_node_dst = batadv_orig_hash_find(bat_priv, packet->dest);
+	if (!orig_node_dst)
+		goto out;
+
+	neigh_node = batadv_find_router(bat_priv, orig_node_dst, recv_if);
+	if (!neigh_node)
+		goto out;
+
+	/* Forward the fragment, if the merged packet would be too big to
+	 * be assembled.
+	 */
+	total_size = ntohs(packet->total_size) + ETH_HLEN;
+	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
+		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
+				   skb->len + ETH_HLEN);
+
+		packet->header.ttl--;
+		batadv_send_skb_packet(skb, neigh_node->if_incoming,
+				       neigh_node->addr);
+		ret = true;
+	}
+
+out:
+	if (orig_node_dst)
+		batadv_orig_node_free_ref(orig_node_dst);
+	if (neigh_node)
+		batadv_neigh_node_free_ref(neigh_node);
+	return ret;
+}
diff --git a/fragmentation.h b/fragmentation.h
new file mode 100644
index 0000000..16d1a62
--- /dev/null
+++ b/fragmentation.h
@@ -0,0 +1,31 @@
+/* Copyright (C) 2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll <martin@hundeboll.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ */
+
+#ifndef _NET_BATMAN_ADV_FRAGMENTATION_H_
+#define _NET_BATMAN_ADV_FRAGMENTATION_H_
+
+void batadv_frag_clear_orig(struct batadv_orig_node *orig);
+void batadv_frag_check_orig(struct batadv_orig_node *orig);
+bool batadv_frag_skb_fwd(struct sk_buff *skb,
+			 struct batadv_hard_iface *recv_if,
+			 struct batadv_orig_node *orig_node_src);
+bool batadv_frag_skb_buffer(struct sk_buff **skb,
+			    struct batadv_orig_node *orig_node);
+
+#endif /* _NET_BATMAN_ADV_FRAGMENTATION_H_ */
diff --git a/main.c b/main.c
index a93328f..b633de1 100644
--- a/main.c
+++ b/main.c
@@ -32,6 +32,7 @@
 #include "vis.h"
 #include "hash.h"
 #include "bat_algo.h"
+#include "fragmentation.h"
 
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
@@ -280,6 +281,8 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
 	/* vis packet */
 	batadv_rx_handler[BATADV_VIS] = batadv_recv_vis_packet;
+	/* Fragmented packets */
+	batadv_rx_handler[BATADV_FRAG] = batadv_recv_frag_packet;
 	/* Translation table query (request or response) */
 	batadv_rx_handler[BATADV_TT_QUERY] = batadv_recv_tt_query;
 	/* Roaming advertisement */
diff --git a/main.h b/main.h
index f9a3115..d55200d 100644
--- a/main.h
+++ b/main.h
@@ -116,6 +116,9 @@ enum batadv_uev_type {
 };
 
 #define BATADV_GW_THRESHOLD	50
+#define BATADV_FRAG_BUFFER_COUNT 8
+#define BATADV_FRAG_MAX_FRAGMENTS 16
+#define BATADV_FRAG_TIMEOUT 10000
 
 /* Debug Messages */
 #ifdef pr_fmt
diff --git a/originator.c b/originator.c
index 6ebf771..f3463a5 100644
--- a/originator.c
+++ b/originator.c
@@ -26,6 +26,7 @@
 #include "hard-interface.h"
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
+#include "fragmentation.h"
 
 static void batadv_purge_orig(struct work_struct *work);
 
@@ -137,6 +138,7 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	batadv_frag_clear_orig(orig_node);
 	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
 				  "originator timed out");
 
@@ -192,7 +194,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr)
 {
 	struct batadv_orig_node *orig_node;
-	int size;
+	int size, i;
 	int hash_added;
 	unsigned long reset_time;
 
@@ -242,6 +244,12 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
 
+	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
+		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
+		spin_lock_init(&orig_node->fragments[i].lock);
+		orig_node->fragments[i].size = 0;
+	}
+
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
@@ -367,6 +375,8 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 				batadv_orig_node_free_ref(orig_node);
 				continue;
 			}
+
+			batadv_frag_check_orig(orig_node);
 		}
 		spin_unlock_bh(list_lock);
 	}
diff --git a/packet.h b/packet.h
index ce6e502..5f7ea63 100644
--- a/packet.h
+++ b/packet.h
@@ -58,6 +58,15 @@ enum batadv_vis_packettype {
 	BATADV_VIS_TYPE_CLIENT_UPDATE = 1,
 };
 
+/**
+ * enum batadv_frag_flags - flags for fragments.
+ * @BATADV_FRAG_NO_FLAGS: No flags are set.
+ * @BATADV_FRAG_LAST: Last fragment in a set of fragments.
+ */
+enum batadv_frag_flags {
+	BATADV_FRAG_LAST = BIT(0),
+};
+
 /* TT_QUERY subtypes */
 #define BATADV_TT_QUERY_TYPE_MASK 0x3
 
@@ -155,6 +164,26 @@ struct batadv_unicast_packet {
 	uint8_t  dest[ETH_ALEN];
 } __packed;
 
+/**
+ * struct batadv_frag_packet - Network structure for fragments.
+ * @header: Common batman-adv header with type, compatibility version, and ttl.
+ * @dest: Final destination used when routing fragments.
+ * @orig: Originator of the fragment used when merging the packet.
+ * @no: Fragment number within this sequence.
+ * @reserved: Unused
+ * @seqno: Sequence identification.
+ * @total_size: Size of the merged packet.
+ */
+struct batadv_frag_packet {
+	struct  batadv_header header;
+	uint8_t dest[ETH_ALEN];
+	uint8_t orig[ETH_ALEN];
+	uint8_t no:4;
+	uint8_t reserved:4;
+	__be16  seqno;
+	__be16  total_size;
+} __packed;
+
 struct batadv_bcast_packet {
 	struct batadv_header header;
 	uint8_t  reserved;
diff --git a/routing.c b/routing.c
index ca4847e..42d980b 100644
--- a/routing.c
+++ b/routing.c
@@ -27,6 +27,7 @@
 #include "originator.h"
 #include "vis.h"
 #include "bridge_loop_avoidance.h"
+#include "fragmentation.h"
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
@@ -960,6 +961,64 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	return batadv_route_unicast_packet(skb, recv_if);
 }
 
+/**
+ * batadv_recv_frag_packet() - Process received fragment.
+ * @skb:     The received fragment.
+ * @recv_if: Interface that the skb is received on.
+ *
+ * This function does one of the three following things: 1) Forward fragment, if
+ * the assembled packet will exceed our MTU; 2) Buffer fragment, if we till
+ * lack further fragments; 3) Merge fragments, if we have all needed parts.
+ *
+ * Returns NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ */
+int batadv_recv_frag_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_orig_node *orig_node_src = NULL;
+	struct batadv_frag_packet *packet;
+	int ret = NET_RX_DROP;
+
+	if (batadv_check_unicast_packet(skb, sizeof(*packet)) < 0)
+		goto out;
+
+	packet = (struct batadv_frag_packet *)skb->data;
+	orig_node_src = batadv_orig_hash_find(bat_priv, packet->orig);
+	if (!orig_node_src)
+		goto out;
+
+	/* Route the fragment if it is not for us and too big to be merged. */
+	if (!batadv_is_my_mac(packet->dest) &&
+	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
+		ret = NET_RX_SUCCESS;
+		goto out;
+	}
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_RX_BYTES,
+			   skb->len + ETH_HLEN);
+
+	/* Add fragment to buffer and merge if possible. */
+	if (!batadv_frag_skb_buffer(&skb, orig_node_src))
+		goto out;
+
+	/* Deliver merged packet to the appropriate handler, if it was
+	 * merged
+	 */
+	if (skb)
+		batadv_batman_skb_recv(skb, recv_if->net_dev,
+				       &recv_if->batman_adv_ptype, NULL);
+
+	ret = NET_RX_SUCCESS;
+
+out:
+	if (orig_node_src)
+		batadv_orig_node_free_ref(orig_node_src);
+
+	return ret;
+}
+
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
diff --git a/routing.h b/routing.h
index 9262279..2eb1578 100644
--- a/routing.h
+++ b/routing.h
@@ -33,6 +33,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if);
 int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 				  struct batadv_hard_iface *recv_if);
+int batadv_recv_frag_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_vis_packet(struct sk_buff *skb,
diff --git a/soft-interface.c b/soft-interface.c
index fbec8a4..df0bedc 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -546,6 +546,10 @@ static const struct {
 	{ "mgmt_tx_bytes" },
 	{ "mgmt_rx" },
 	{ "mgmt_rx_bytes" },
+	{ "frag_rx" },
+	{ "frag_rx_bytes" },
+	{ "frag_fwd" },
+	{ "frag_fwd_bytes" },
 	{ "tt_request_tx" },
 	{ "tt_request_rx" },
 	{ "tt_response_tx" },
diff --git a/types.h b/types.h
index 2ed82ca..477f87a 100644
--- a/types.h
+++ b/types.h
@@ -45,6 +45,34 @@ struct batadv_hard_iface {
 };
 
 /**
+ * struct batadv_frag_table_entry - Head in the fragment buffer table.
+ * @head: Head of list with fragments.
+ * @lock: Lock to protect the list of fragments.
+ * @timestamp: Time (jiffie) of last received fragment.
+ * @seqno: Sequence number of the fragments in the list.
+ * @size: Accumulated size of packets in list.
+ */
+struct batadv_frag_table_entry {
+	struct hlist_head head;
+	spinlock_t lock; /* Protects head */
+	unsigned long timestamp;
+	uint16_t seqno;
+	uint16_t size;
+};
+
+/**
+ * struct batadv_frag_list_entry - Entry in a list of fragments.
+ * @list: List node information
+ * @skb: Fragment
+ * @no: Fragment number in the set.
+ */
+struct batadv_frag_list_entry {
+	struct hlist_node list;
+	struct sk_buff *skb;
+	uint8_t no;
+};
+
+/**
  *	struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
  *	@last_seen: when last packet from this node was received
@@ -105,6 +133,7 @@ struct batadv_orig_node {
 	spinlock_t tt_list_lock; /* protects tt_list */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
+	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
 };
 
 struct batadv_gw_node {
@@ -156,6 +185,10 @@ enum batadv_counters {
 	BATADV_CNT_MGMT_TX_BYTES,
 	BATADV_CNT_MGMT_RX,
 	BATADV_CNT_MGMT_RX_BYTES,
+	BATADV_CNT_FRAG_RX,
+	BATADV_CNT_FRAG_RX_BYTES,
+	BATADV_CNT_FRAG_FWD,
+	BATADV_CNT_FRAG_FWD_BYTES,
 	BATADV_CNT_TT_REQUEST_TX,
 	BATADV_CNT_TT_REQUEST_RX,
 	BATADV_CNT_TT_RESPONSE_TX,
-- 
1.7.11.5

