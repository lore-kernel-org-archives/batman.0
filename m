Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 21 May 2013 12:48:18 +0200
Message-Id: <1369133299-8325-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Receive fragmented packets
	and merge
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

v2:
update copyright years
remove () and uppercase beginnings from kernel doc
use hlist_for_entry_safe() in batadv_frag_clear_list()
merge batadv_frag_clear_orig() and batadv_frag_check_orig()
update some kernel doc with return values
remove "inline" from static function in .c file
rename lists of fragments to "chain"
remove type in kernel doc
remove initialization from "curr" and "new" in insert_packet()
rename "curr" and "new" to "frag_entry_{curr,new}"
rename packet to frag_packet
change return description in kernel doc for batadv_frag_merge_packets()
fix return value on failure in pskb_expand_head() in merge_packets()
add kernel doc for counters in types.h

v3:
added blank lines to int batadv_frag_size_limit()
added comment to explain linearization of received fragments
removed ETH_HLEN in counters for received fragments

 Makefile.kbuild  |   1 +
 fragmentation.c  | 366 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fragmentation.h  |  47 +++++++
 main.c           |   4 +
 main.h           |   9 ++
 originator.c     |  14 ++-
 packet.h         |  27 ++++
 routing.c        |  59 +++++++++
 routing.h        |   2 +
 soft-interface.c |   4 +
 types.h          |  38 ++++++
 11 files changed, 570 insertions(+), 1 deletion(-)
 create mode 100644 fragmentation.c
 create mode 100644 fragmentation.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index f9b465b..4f4aabb 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -24,6 +24,7 @@ batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += debugfs.o
 batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
+batman-adv-y += fragmentation.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/fragmentation.c b/fragmentation.c
new file mode 100644
index 0000000..8f47af7
--- /dev/null
+++ b/fragmentation.c
@@ -0,0 +1,366 @@
+/* Copyright (C) 2013 B.A.T.M.A.N. contributors:
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
+ * batadv_frag_clear_chain - delete entries in the fragment buffer chain.
+ * @head: head of chain with entries.
+ *
+ * Frees fragments in the passed hlist. Should be called with appropriate lock.
+ */
+static void batadv_frag_clear_chain(struct hlist_head *head)
+{
+	struct batadv_frag_list_entry *entry;
+	struct hlist_node *node;
+
+	hlist_for_each_entry_safe(entry, node, head, list) {
+		hlist_del(&entry->list);
+		kfree_skb(entry->skb);
+		kfree(entry);
+	}
+}
+
+/**
+ * batadv_frag_purge_orig - free fragments associated to an orig.
+ * @orig_node: Originator to free fragments from.
+ * @check_cb: Optional function to tell if an entry should be purged.
+ */
+void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
+			    bool (*check_cb)(struct batadv_frag_table_entry *))
+{
+	struct batadv_frag_table_entry *chain;
+	uint8_t i;
+
+	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
+		chain = &orig_node->fragments[i];
+		spin_lock_bh(&orig_node->fragments[i].lock);
+
+		if (!check_cb || check_cb(chain)) {
+			batadv_frag_clear_chain(&orig_node->fragments[i].head);
+			orig_node->fragments[i].size = 0;
+		}
+
+		spin_unlock_bh(&orig_node->fragments[i].lock);
+	}
+}
+
+/**
+ * batadv_frag_size_limit - maximum possible size of packet to be fragmented.
+ *
+ * Returns the maximum size of payload that can be fragmented.
+ */
+static int batadv_frag_size_limit(void)
+{
+	int limit = BATADV_FRAG_MAX_FRAG_SIZE;
+
+	limit -= sizeof(struct batadv_frag_packet);
+	limit *= BATADV_FRAG_MAX_FRAGMENTS;
+
+	return limit;
+}
+
+/**
+ * batadv_frag_init_chain - check and prepare fragment chain for new fragment.
+ * @chain: Chain in fragments table to init.
+ * @seqno: Sequence number of the received fragment.
+ *
+ * Make chain ready for a fragment with sequence number "seqno". Delete existing
+ * entries if they have an "old" sequence number.
+ *
+ * Returns true if chain is empty and caller can just insert the new fragment
+ * without searching for the right position.
+ *
+ * Caller must hold chain->lock.
+ */
+static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
+				   uint16_t seqno)
+{
+	if (chain->seqno == seqno)
+		return false;
+
+	if (!hlist_empty(&chain->head))
+		batadv_frag_clear_chain(&chain->head);
+
+	chain->size = 0;
+	chain->seqno = seqno;
+
+	return true;
+}
+
+/**
+ * batadv_frag_insert_packet - insert a fragment into a fragment chain.
+ * @orig_node: Originator that the fragment was received from.
+ * @skb: skb to insert.
+ * @head: head to attach complete chains of fragments to.
+ *
+ * Insert a new fragment into the reverse ordered chain in the right table
+ * entry. The hash table entry is cleared if "old" fragments exist in it.
+ *
+ * Returns true if skb is buffered, false on error. If the chain has all the
+ * fragments needed to merge the packet, the chain is moved to the passed head
+ * to avoid locking the chain in the table.
+ */
+static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
+				      struct sk_buff *skb,
+				      struct hlist_head *chain_out)
+{
+	struct batadv_frag_table_entry *chain;
+	struct batadv_frag_list_entry *frag_entry_new, *frag_entry_curr;
+	struct batadv_frag_packet *frag_packet;
+	uint8_t bucket;
+	uint16_t seqno, hdr_size = sizeof(struct batadv_frag_packet);
+
+	/* Linearize packet to avoid linearizing 16 packets in a row when doing
+	 * the later merge. Non-linear merge should be added to remove this
+	 * linearization.
+	 */
+	if (skb_linearize(skb) < 0)
+		goto err;
+
+	frag_packet = (struct batadv_frag_packet *)skb->data;
+	seqno = ntohs(frag_packet->seqno);
+	bucket = seqno % BATADV_FRAG_BUFFER_COUNT;
+
+	frag_entry_new = kmalloc(sizeof(*frag_entry_new), GFP_ATOMIC);
+	if (!frag_entry_new)
+		goto err;
+
+	frag_entry_new->skb = skb;
+	frag_entry_new->no = frag_packet->no;
+
+	/* Select entry in the "chain table" and delete any prior fragments
+	 * with another sequence number. batadv_frag_init_chain() returns true,
+	 * if the list is empty at return.
+	 */
+	chain = &orig_node->fragments[bucket];
+	spin_lock_bh(&chain->lock);
+	if (batadv_frag_init_chain(chain, seqno)) {
+		hlist_add_head(&frag_entry_new->list, &chain->head);
+		chain->size = skb->len - hdr_size;
+		chain->timestamp = jiffies;
+		goto out;
+	}
+
+	/* Find the position for the new fragment. */
+	hlist_for_each_entry(frag_entry_curr, &chain->head, list) {
+		/* Drop packet if fragment already exists. */
+		if (frag_entry_curr->no == frag_entry_new->no)
+			goto err_unlock;
+
+		/* Order fragments from highest to lowest. */
+		if (frag_entry_curr->no < frag_entry_new->no) {
+			hlist_add_before(&frag_entry_new->list,
+					 &frag_entry_curr->list);
+			chain->size += skb->len - hdr_size;
+			chain->timestamp = jiffies;
+			goto out;
+		}
+	}
+
+	/* We reached the end of the list, so insert after 'frag_entry_curr'. */
+	if (likely(frag_entry_curr)) {
+		hlist_add_after(&frag_entry_curr->list, &frag_entry_new->list);
+		chain->size += skb->len - hdr_size;
+		chain->timestamp = jiffies;
+	}
+
+out:
+	if (chain->size > batadv_frag_size_limit() ||
+	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
+		/* Clear chain if total size of either the list or the packet
+		 * exceeds the maximum size of one merged packet.
+		 */
+		batadv_frag_clear_chain(&chain->head);
+		chain->size = 0;
+	} else if (ntohs(frag_packet->total_size) == chain->size) {
+		/* All fragments received. Hand over chain to caller. */
+		hlist_move_list(&chain->head, chain_out);
+		chain->size = 0;
+	}
+
+	spin_unlock_bh(&chain->lock);
+	return true;
+
+err_unlock:
+	spin_unlock_bh(&chain->lock);
+	kfree(frag_entry_new);
+err:
+	return false;
+}
+
+/**
+ * batadv_frag_merge_packets - merge a chain of fragments.
+ * @head: head of chain with fragments.
+ * @skb: Packet with total size of skb after merging.
+ *
+ * Expands the first skb in the chain and copies the content of the remaining
+ * skb's into the expanded one. After doing so, it clears the chain.
+ *
+ * Returns the merged skb or NULL on error.
+ */
+static struct sk_buff *
+batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
+{
+	struct batadv_frag_packet *packet;
+	struct batadv_frag_list_entry *entry;
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
+	entry = hlist_entry(chain->first, struct batadv_frag_list_entry, list);
+	hlist_del(&entry->list);
+	skb_out = entry->skb;
+	kfree(entry);
+
+	/* Make room for the rest of the fragments. */
+	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
+		kfree_skb(skb_out);
+		skb_out = NULL;
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
+	hlist_for_each_entry(entry, chain, list) {
+		size = entry->skb->len - hdr_size;
+		memcpy(skb_put(skb_out, size), entry->skb->data + hdr_size,
+		       size);
+	}
+
+free:
+	/* Locking is not needed, because 'chain' is not part of any orig. */
+	batadv_frag_clear_chain(chain);
+	return skb_out;
+}
+
+/**
+ * batadv_frag_skb_buffer - buffer fragment for later merge.
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
+ * batadv_frag_skb_fwd - forward fragments that would exceed MTU when merged.
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
index 0000000..2af5df5
--- /dev/null
+++ b/fragmentation.h
@@ -0,0 +1,47 @@
+/* Copyright (C) 2013 B.A.T.M.A.N. contributors:
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
+void batadv_frag_purge_orig(struct batadv_orig_node *orig,
+			    bool (*check_cb)(struct batadv_frag_table_entry *));
+bool batadv_frag_skb_fwd(struct sk_buff *skb,
+			 struct batadv_hard_iface *recv_if,
+			 struct batadv_orig_node *orig_node_src);
+bool batadv_frag_skb_buffer(struct sk_buff **skb,
+			    struct batadv_orig_node *orig_node);
+
+/**
+ * batadv_frag_check_entry - check if a list of fragments has timed out.
+ * @frags_entry: table entry to check
+ *
+ * Returns true if the frags entry has timed out; false otherwise
+ */
+static inline bool
+batadv_frag_check_entry(struct batadv_frag_table_entry *frags_entry)
+{
+	if (!hlist_empty(&frags_entry->head) &&
+	    batadv_has_timed_out(frags_entry->timestamp, BATADV_FRAG_TIMEOUT))
+		return true;
+	else
+		return false;
+}
+
+#endif /* _NET_BATMAN_ADV_FRAGMENTATION_H_ */
diff --git a/main.c b/main.c
index 3b5f78f..7188beb 100644
--- a/main.c
+++ b/main.c
@@ -36,6 +36,7 @@
 #include "hash.h"
 #include "bat_algo.h"
 #include "network-coding.h"
+#include "fragmentation.h"
 
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
@@ -342,6 +343,7 @@ static void batadv_recv_handler_init(void)
 	BUILD_BUG_ON(offsetof(struct batadv_unicast_4addr_packet, src) != 10);
 	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, dest) != 4);
 	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, dst) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_frag_packet, dest) != 4);
 	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, dst) != 4);
 	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, dst) != 4);
 
@@ -357,6 +359,8 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_UNICAST_TVLV] = batadv_recv_unicast_tvlv;
 	/* batman icmp packet */
 	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
+	/* Fragmented packets */
+	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_frag_packet;
 }
 
 int
diff --git a/main.h b/main.h
index 71440df..3db6c2e 100644
--- a/main.h
+++ b/main.h
@@ -131,6 +131,15 @@ enum batadv_uev_type {
 
 #define BATADV_GW_THRESHOLD	50
 
+/* Number of fragment chains for each orig_node */
+#define BATADV_FRAG_BUFFER_COUNT 8
+/* Maximum number of fragments for one packet */
+#define BATADV_FRAG_MAX_FRAGMENTS 16
+/* Maxumim size of each fragment */
+#define BATADV_FRAG_MAX_FRAG_SIZE 1400
+/* Time to keep fragments while waiting for rest of the fragments */
+#define BATADV_FRAG_TIMEOUT 10000
+
 #define BATADV_DAT_CANDIDATE_NOT_FOUND	0
 #define BATADV_DAT_CANDIDATE_ORIG	1
 
diff --git a/originator.c b/originator.c
index 898b0ce..a591dc5 100644
--- a/originator.c
+++ b/originator.c
@@ -28,6 +28,7 @@
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
+#include "fragmentation.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
@@ -145,6 +146,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
+	batadv_frag_purge_orig(orig_node, NULL);
+
 	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
 				  "originator timed out");
 
@@ -215,7 +218,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr)
 {
 	struct batadv_orig_node *orig_node;
-	int size;
+	int size, i;
 	int hash_added;
 	unsigned long reset_time;
 
@@ -267,6 +270,12 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
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
 
@@ -388,6 +397,9 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 				batadv_orig_node_free_ref(orig_node);
 				continue;
 			}
+
+			batadv_frag_purge_orig(orig_node,
+					       batadv_frag_check_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
diff --git a/packet.h b/packet.h
index 96b8e57..ae38769 100644
--- a/packet.h
+++ b/packet.h
@@ -249,6 +249,33 @@ struct batadv_unicast_4addr_packet {
 	 */
 };
 
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
+#if defined(__BIG_ENDIAN_BITFIELD)
+	uint8_t no:4;
+	uint8_t reserved:4;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	uint8_t reserved:4;
+	uint8_t no:4;
+#else
+#error "unknown bitfield endianess"
+#endif
+	uint8_t dest[ETH_ALEN];
+	uint8_t orig[ETH_ALEN];
+	__be16  seqno;
+	__be16  total_size;
+};
+
 struct batadv_bcast_packet {
 	struct batadv_header header;
 	uint8_t  reserved;
diff --git a/routing.c b/routing.c
index a099d32..3acbc76 100644
--- a/routing.c
+++ b/routing.c
@@ -28,6 +28,7 @@
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "network-coding.h"
+#include "fragmentation.h"
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
@@ -997,6 +998,64 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 	return ret;
 }
 
+/*
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
+	struct batadv_frag_packet *frag_packet;
+	int ret = NET_RX_DROP;
+
+	if (batadv_check_unicast_packet(bat_priv, skb,
+					sizeof(*frag_packet)) < 0)
+		goto out;
+
+	frag_packet = (struct batadv_frag_packet *)skb->data;
+	orig_node_src = batadv_orig_hash_find(bat_priv, frag_packet->orig);
+	if (!orig_node_src)
+		goto out;
+
+	/* Route the fragment if it is not for us and too big to be merged. */
+	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
+	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
+		ret = NET_RX_SUCCESS;
+		goto out;
+	}
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_RX_BYTES, skb->len);
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
index efab583..55d637a 100644
--- a/routing.h
+++ b/routing.h
@@ -30,6 +30,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if);
 int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if);
+int batadv_recv_frag_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_tt_query(struct sk_buff *skb,
diff --git a/soft-interface.c b/soft-interface.c
index 2f3810d..481642e 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -747,6 +747,10 @@ static const struct {
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
index 6cde9c9..dd3f505 100644
--- a/types.h
+++ b/types.h
@@ -86,6 +86,34 @@ struct batadv_hard_iface {
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
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
@@ -128,6 +156,7 @@ struct batadv_hard_iface {
  * @out_coding_list: list of nodes that can hear this orig
  * @in_coding_list_lock: protects in_coding_list
  * @out_coding_list_lock: protects out_coding_list
+ * @fragments: array with heads for fragment chains
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
@@ -174,6 +203,7 @@ struct batadv_orig_node {
 	spinlock_t in_coding_list_lock; /* Protects in_coding_list */
 	spinlock_t out_coding_list_lock; /* Protects out_coding_list */
 #endif
+	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
 };
 
 /**
@@ -270,6 +300,10 @@ struct batadv_bcast_duplist_entry {
  * @BATADV_CNT_MGMT_TX_BYTES: transmitted routing protocol traffic bytes counter
  * @BATADV_CNT_MGMT_RX: received routing protocol traffic packet counter
  * @BATADV_CNT_MGMT_RX_BYTES: received routing protocol traffic bytes counter
+ * @BATADV_CNT_FRAG_RX: received fragment traffic packet counter
+ * @BATADV_CNT_FRAG_RX_BYTES: received fragment traffic bytes counter
+ * @BATADV_CNT_FRAG_FWD: forwarded fragment traffic packet counter
+ * @BATADV_CNT_FRAG_FWD_BYTES: forwarded fragment traffic bytes counter
  * @BATADV_CNT_TT_REQUEST_TX: transmitted tt req traffic packet counter
  * @BATADV_CNT_TT_REQUEST_RX: received tt req traffic packet counter
  * @BATADV_CNT_TT_RESPONSE_TX: transmitted tt resp traffic packet counter
@@ -307,6 +341,10 @@ enum batadv_counters {
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
1.8.2.3

