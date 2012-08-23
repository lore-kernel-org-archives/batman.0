Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu, 23 Aug 2012 15:41:58 +0200
Message-Id: <1345729318-12804-2-git-send-email-montik@autistici.org>
In-Reply-To: <1345729318-12804-1-git-send-email-montik@autistici.org>
References: <1345729318-12804-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: bandwidth meter implementation
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

The bandwith meter module is a simple, kernel-space replacement for bandwith
measurements tool like iperf and netper. It is intended to approximate TCP
behaviour.

It is invoked through batctl: the protocol is connection oriented, with
cumulative acknowledgment and sliding window. Sender keeps a timeout, which is
checked by a worker function regoularly invoked through the workqueue mechanism.
If the timeout is expired at the time worker is executed, the whole window is
re-transmitted.

Sequence number in packet header is 16 bit and is wrap around safe.
BATADV_BW_FIRST_SEQ is the sequence number of the first packet. It is set to
65530 to generate a wrap-around. *Both sides must agree on this value*.

The receiver maintains a bitmap of BATADV_BW_WINDOW_SIZE to account for received
packets not in order, so to avoid that they are unecessarly resent. Every time a
packet is received, if it is either in order or not, an ack with the seqno
equal to the last in order packet is sent back.

The test *can* be interrupted by batctl. A receiver side timeout avoids unlimited
waitings for sender packets: after one second of inactivity, the receiver abort
the ongoing test. The sender aborts the test after having resent
BATADV_BW_MAX_RETRY the same window.

When the test is over, the results are returned to batctl through a call to the
function batadv_socket_receive_packet(), before freeing struct batadv_bw_vars.
This function only accepts struct batadv_icmp_packet_rr, so that structure is
used and a cast is done to struct batadv_bw_result. The function basically sends
a particular icmp packet through the local socket. In case any error occured
during the test, this is also reported to batctl.

Signed-off-by: Edo Monticelli <montik@autistici.org>
---
 Makefile.kbuild |    1 +
 bw_meter.c      |  622 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bw_meter.h      |    7 +
 icmp_socket.c   |   18 ++
 main.c          |    2 +
 packet.h        |   38 +++-
 routing.c       |   15 ++-
 types.h         |   25 +++
 8 files changed, 722 insertions(+), 6 deletions(-)
 create mode 100644 bw_meter.c
 create mode 100644 bw_meter.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 8676d2b..8c08ff9 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -23,6 +23,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += debugfs.o
+batman-adv-y += bw_meter.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/bw_meter.c b/bw_meter.c
new file mode 100644
index 0000000..2bc0374
--- /dev/null
+++ b/bw_meter.c
@@ -0,0 +1,622 @@
+#include "main.h"
+#include "send.h"
+#include "hash.h"
+#include "originator.h"
+#include "hard-interface.h"
+#include "bw_meter.h"
+#include "icmp_socket.h"
+#include "types.h"
+#include "bw_meter.h"
+
+#define BATADV_BW_PACKET_LEN 1400
+#define BATADV_BW_WINDOW_SIZE 30
+#define BATADV_BW_CLEAN_RECEIVER_TIMEOUT 2000
+#define BATADV_BW_TIMEOUT 60
+#define BATADV_BW_WORKER_TIMEOUT 30
+#define BATADV_BW_RECV_TIMEOUT 1000
+#define BATADV_BW_TOTAL_TO_SEND 10000
+#define BATADV_BW_MAX_RETRY 3
+#define BATADV_BW_FIRST_SEQ 65530
+
+#define batadv_bw_batctl_error_notify(status, uid) \
+	batadv_bw_batctl_notify(status, uid, 0)
+
+static int batadv_bw_queue_sender_worker(struct batadv_bw_vars *bw_vars);
+static int batadv_bw_queue_receiver_worker(struct batadv_bw_vars *bw_vars);
+
+static void batadv_bw_vars_free(struct batadv_bw_vars *bw_vars)
+{
+	spin_lock_bh(&bw_vars->bat_priv->bw_list_lock);
+	list_del(&bw_vars->list);
+	spin_unlock_bh(&bw_vars->bat_priv->bw_list_lock);
+	kfree(bw_vars);
+}
+
+static int batadv_bw_icmp_send(struct batadv_priv *bat_priv,
+			       struct sk_buff *skb)
+{
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_icmp_packet *icmp_packet;
+	int ret = -1;
+
+	icmp_packet = (struct batadv_icmp_packet *)skb->data;
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter:batadv_bw_icmp_send: no primary if\n");
+		goto out;
+	}
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter:batadv_bw_icmp_send: mesh inactive\n");
+		goto dst_unreach;
+	}
+
+	orig_node = batadv_orig_hash_find(bat_priv,
+					  icmp_packet->dst);
+	if (!orig_node) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter:batadv_bw_icmp_send: no orig node\n");
+		goto dst_unreach;
+	}
+
+	neigh_node = batadv_orig_node_get_router(orig_node);
+	if (!neigh_node) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter:batadv_bw_icmp_send: no neigh node\n");
+		goto dst_unreach;
+	}
+
+	if (!neigh_node->if_incoming) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter:batadv_bw_icmp_send: no if incoming\n");
+		goto dst_unreach;
+	}
+
+	if (neigh_node->if_incoming->if_status != BATADV_IF_ACTIVE) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter:batadv_bw_icmp_send: status not IF_ACTIVE\n");
+		goto dst_unreach;
+	}
+
+	memcpy(icmp_packet->orig,
+	       primary_if->net_dev->dev_addr, ETH_ALEN);
+
+	batadv_send_skb_packet(skb, neigh_node->if_incoming,
+			       neigh_node->addr);
+	ret = 0;
+	goto out;
+
+dst_unreach:
+	batadv_bw_stop(bat_priv, icmp_packet->dst, BATADV_BW_DST_UNREACHABLE);
+
+out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	if (neigh_node)
+		batadv_neigh_node_free_ref(neigh_node);
+	if (orig_node)
+		batadv_orig_node_free_ref(orig_node);
+	return ret;
+}
+
+static struct batadv_bw_vars *batadv_bw_list_find(struct batadv_priv *bat_priv,
+						  void *dst)
+{
+	struct batadv_bw_vars *pos = NULL, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &bat_priv->bw_list, list) {
+		if (memcmp(&pos->other_end, dst, ETH_ALEN) == 0)
+			return pos;
+	}
+
+	return NULL;
+}
+
+static int batadv_bw_ack_send(struct batadv_socket_client *socket_client,
+			      struct batadv_icmp_packet *icmp_packet,
+			      uint16_t seq)
+{
+	struct sk_buff *skb;
+	struct batadv_icmp_packet *icmp_ack;
+	struct batadv_priv *bat_priv = socket_client->bat_priv;
+	int ret = -1;
+
+	bat_priv = socket_client->bat_priv;
+	skb = dev_alloc_skb(sizeof(*skb) + ETH_HLEN);
+	if (!skb) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: batadv_send_bw_ack cannot allocate skb\n");
+		goto out;
+	}
+
+	skb_reserve(skb, ETH_HLEN);
+	icmp_ack = (struct batadv_icmp_packet *)
+		   skb_put(skb, sizeof(*icmp_ack));
+	icmp_ack->header.packet_type = BATADV_ICMP;
+	icmp_ack->header.version = BATADV_COMPAT_VERSION;
+	icmp_ack->header.ttl = 50;
+	icmp_ack->seqno = htons(seq);
+	icmp_ack->msg_type = BATADV_BW_ACK;
+	memcpy(icmp_ack->dst, icmp_packet->orig, ETH_ALEN);
+	icmp_ack->uid = socket_client->index;
+
+	/* send the ack */
+	if (batadv_bw_icmp_send(bat_priv, skb) < 0) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: batadv_send_bw_ack cannot send_icmp_packet\n");
+		goto out;
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+/* Returns the next zero position, starting from bit_first. If the end of the
+ * bitmap is reached, another find_next is performed starting from the
+ * beginning of the bitmap
+ */
+static int batadv_bw_modular_next_zero_find(struct batadv_bw_vars *bw_vars)
+{
+	int ret;
+
+	ret = find_next_zero_bit(bw_vars->bw_bits,
+				 BATADV_BW_WINDOW_SIZE,
+				 (bw_vars->bit_first + 1) %
+				 BATADV_BW_WINDOW_SIZE);
+	if (ret != BATADV_BW_WINDOW_SIZE)
+		return ret;
+
+	ret = find_next_zero_bit(bw_vars->bw_bits,
+				 BATADV_BW_WINDOW_SIZE, 0);
+	return ret;
+}
+
+static void batadv_bw_bit_first_move(struct batadv_bw_vars *bw_vars,
+				     uint16_t new_pos)
+{
+	if (new_pos > BATADV_BW_WINDOW_SIZE) {
+		batadv_dbg(BATADV_DBG_BATMAN, bw_vars->bat_priv,
+			   "Meter: can't move bit first to inconsistent position\n");
+		return;
+	}
+
+	do {
+		bw_vars->bit_first = (bw_vars->bit_first + 1) %
+				     BATADV_BW_WINDOW_SIZE;
+		clear_bit(bw_vars->bit_first, bw_vars->bw_bits);
+	} while (bw_vars->bit_first != new_pos);
+}
+
+static void batadv_bw_window_slide(struct batadv_bw_vars *bw_vars,
+				   uint16_t seqno, uint16_t len)
+{
+	uint16_t window_first_16, diff, bit_seqno, new_position;
+
+	/* check if the packet belongs to window */
+	spin_lock_bh(&bw_vars->bw_vars_lock);
+	window_first_16 = (uint16_t) bw_vars->window_first;
+	diff = seqno - window_first_16;
+	bw_vars->last_sent_time = jiffies;
+
+	if (diff >= BATADV_BW_WINDOW_SIZE) {
+		spin_unlock_bh(&bw_vars->bw_vars_lock);
+		goto out;
+	}
+
+	/* check for the last packet */
+	if (len < BATADV_BW_PACKET_LEN &&
+	    bw_vars->status == BATADV_BW_RECEIVER) {
+		bit_seqno = (bw_vars->bit_first + diff) % BATADV_BW_WINDOW_SIZE;
+		bw_vars->total_to_send = (bit_seqno + 1) %
+					 BATADV_BW_WINDOW_SIZE;
+		bw_vars->status = BATADV_BW_LAST_WINDOW;
+	}
+
+	/* packet is in order */
+	if (diff == 0) {
+		new_position = batadv_bw_modular_next_zero_find(bw_vars);
+
+		/* update bw_vars->window_first */
+		if (new_position > bw_vars->bit_first)
+			bw_vars->window_first += new_position -
+						 bw_vars->bit_first;
+		else
+			bw_vars->window_first += new_position +
+						 BATADV_BW_WINDOW_SIZE -
+						 bw_vars->bit_first;
+
+		batadv_bw_bit_first_move(bw_vars, new_position);
+	}
+	/* hole in the window */
+	else {
+		bit_seqno = (bw_vars->bit_first + diff) % BATADV_BW_WINDOW_SIZE;
+		set_bit(bit_seqno, bw_vars->bw_bits);
+	}
+
+	if (bw_vars->status == BATADV_BW_LAST_WINDOW &&
+	    bw_vars->bit_first == bw_vars->total_to_send) {
+		bw_vars->status = BATADV_BW_COMPLETE;
+	}
+
+	spin_unlock_bh(&bw_vars->bw_vars_lock);
+out:
+	return;
+}
+
+
+void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
+{
+	struct batadv_bw_vars *bw_vars;
+	struct batadv_icmp_packet *icmp_packet;
+	struct batadv_socket_client *socket_client;
+	uint16_t seqno;
+
+	socket_client = container_of(&bat_priv,
+				     struct batadv_socket_client, bat_priv);
+	icmp_packet = (struct batadv_icmp_packet *)skb->data;
+
+	/* search/initialize bw_vars struct */
+	spin_lock_bh(&bat_priv->bw_list_lock);
+	seqno = ntohs(icmp_packet->seqno);
+	bw_vars = batadv_bw_list_find(bat_priv, &icmp_packet->orig);
+	if (!bw_vars) {
+		if (seqno != BATADV_BW_FIRST_SEQ) {
+			spin_unlock_bh(&bat_priv->bw_list_lock);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: seqno != BATADV_BW_FIRST_SEQ cannot initiate connection\n");
+			goto out;
+		}
+
+		bw_vars = kmalloc(sizeof(*bw_vars), GFP_ATOMIC);
+		if (!bw_vars) {
+			spin_unlock_bh(&bat_priv->bw_list_lock);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: meter_received cannot allocate bw_vars\n");
+			goto out;
+		}
+
+		memcpy(&bw_vars->other_end, &icmp_packet->orig, ETH_ALEN);
+		bw_vars->status = BATADV_BW_RECEIVER;
+		bw_vars->window_first = BATADV_BW_FIRST_SEQ;
+		bw_vars->bat_priv = bat_priv;
+		bw_vars->bw_bits = kmalloc(BITS_TO_LONGS(BATADV_BW_WINDOW_SIZE),
+					   GFP_ATOMIC);
+		if (!bw_vars->bw_bits) {
+			spin_unlock_bh(&bat_priv->bw_list_lock);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: meter_received cannot allocate window_bitmap\n");
+			goto out;
+		}
+
+		bw_vars->bit_first = 0;
+		bitmap_zero(bw_vars->bw_bits, BATADV_BW_WINDOW_SIZE);
+
+		spin_lock_init(&bw_vars->bw_vars_lock);
+		list_add(&bw_vars->list, &bat_priv->bw_list);
+
+		batadv_bw_queue_receiver_worker(bw_vars);
+	}
+
+	if (bw_vars->status != BATADV_BW_RECEIVER &&
+	    bw_vars->status != BATADV_BW_LAST_WINDOW) {
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: dropping packet: connection is not expecting any\n");
+		goto out;
+	}
+
+	spin_unlock_bh(&bat_priv->bw_list_lock);
+	batadv_bw_window_slide(bw_vars, seqno, skb->len);
+	batadv_bw_ack_send(socket_client,
+			   (struct batadv_icmp_packet *)icmp_packet,
+			   bw_vars->window_first - 1);
+out:
+	return;
+}
+
+/* Sends all packets that belongs to the window and have not been sent yet
+ * according to next_to_send and (window_first + BW_WINDOW_SIZE)
+ */
+static int batadv_bw_multiple_send(struct batadv_priv *bat_priv,
+				   struct batadv_bw_vars *bw_vars)
+{
+	struct sk_buff *skb;
+	struct batadv_icmp_packet *icmp_to_send;
+	struct batadv_socket_client *socket_client;
+	char *icmp_to_send_char;
+	int ret, bw_packet_len;
+	uint16_t window_end, next_to_send;
+
+	ret = -1;
+	socket_client = container_of(&bat_priv, struct batadv_socket_client,
+				     bat_priv);
+
+	if (!atomic_add_unless(&bw_vars->sending, 1, 1))
+		goto out;
+
+	while (1) {
+		spin_lock_bh(&bw_vars->bw_vars_lock);
+		window_end = min(bw_vars->window_first + BATADV_BW_WINDOW_SIZE,
+				 bw_vars->total_to_send);
+
+		if (!batadv_seq_before(bw_vars->next_to_send, window_end)) {
+			atomic_dec(&bw_vars->sending);
+			spin_unlock_bh(&bw_vars->bw_vars_lock);
+			break;
+		}
+
+		bw_packet_len = BATADV_BW_PACKET_LEN;
+		bw_vars->last_sent_time = jiffies;
+		next_to_send = bw_vars->next_to_send++;
+		spin_unlock_bh(&bw_vars->bw_vars_lock);
+
+		if ((bw_vars->window_first + BATADV_BW_WINDOW_SIZE >=
+		     bw_vars->total_to_send) &&
+		    bw_vars->next_to_send == (uint16_t)bw_vars->total_to_send) {
+			bw_packet_len -= 1;
+		}
+
+		skb = dev_alloc_skb(bw_packet_len + ETH_HLEN);
+		if (!skb) {
+			atomic_dec(&bw_vars->sending);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: batadv_bw_multiple_send() cannot allocate skb\n");
+			goto out;
+		}
+
+		/* TODO redefine BW_PACKET_LEN */
+		skb_reserve(skb, ETH_HLEN);
+		icmp_to_send_char = skb_put(skb, bw_packet_len);
+		icmp_to_send = (struct batadv_icmp_packet *)icmp_to_send_char;
+
+		/* fill the icmp header */
+		memcpy(&icmp_to_send->dst, &bw_vars->other_end, ETH_ALEN);
+		icmp_to_send->header.version = BATADV_COMPAT_VERSION;
+		icmp_to_send->header.packet_type = BATADV_ICMP;
+		icmp_to_send->msg_type = BATADV_BW_START;
+		icmp_to_send->seqno = htons(next_to_send);
+		icmp_to_send->uid = socket_client->index;
+
+		if (batadv_bw_icmp_send(bat_priv, skb) < 0) {
+			atomic_dec(&bw_vars->sending);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: batadv_bw_multiple_send() cannot send_icmp_packet\n");
+			goto out;
+		}
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+void batadv_bw_ack_received(struct batadv_priv *bat_priv,
+			    struct sk_buff *skb)
+{
+	struct batadv_icmp_packet *icmp_packet;
+	struct batadv_bw_vars *bw_vars;
+	uint16_t seqno, window_end, window_first_16;
+
+	icmp_packet = (struct batadv_icmp_packet *)skb->data;
+
+	/* find the bw_vars */
+	spin_lock_bh(&bat_priv->bw_list_lock);
+	bw_vars = batadv_bw_list_find(bat_priv, &icmp_packet->orig);
+	spin_unlock_bh(&bat_priv->bw_list_lock);
+
+	if (!bw_vars) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: received an ack not related to an open connection\n");
+		goto out;
+	}
+
+	/* slide and send fresh packets */
+	spin_lock_bh(&bw_vars->bw_vars_lock);
+	seqno = ntohs(icmp_packet->seqno);
+	window_first_16 = (uint16_t) bw_vars->window_first;
+	window_end = window_first_16 + BATADV_BW_WINDOW_SIZE;
+	if (!batadv_seq_after(window_first_16, seqno) &&
+	    batadv_seq_before(seqno, bw_vars->next_to_send)) {
+		bw_vars->window_first += (uint16_t) (seqno + 1 -
+						     window_first_16);
+	} else if (!batadv_bw_is_error(bw_vars->status)) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: received unespected ack\n");
+	}
+
+	spin_unlock_bh(&bw_vars->bw_vars_lock);
+	batadv_bw_multiple_send(bat_priv, bw_vars);
+out:
+	return;
+}
+
+static void batadv_bw_receiver_worker(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_bw_vars *bw_vars;
+	struct batadv_priv *bat_priv;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	bw_vars = container_of(delayed_work, struct batadv_bw_vars, bw_work);
+	bat_priv = bw_vars->bat_priv;
+
+	if (batadv_has_timed_out(bw_vars->last_sent_time,
+				 BATADV_BW_RECV_TIMEOUT)) {
+		if (bw_vars->status != BATADV_BW_COMPLETE) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: more than %dms of inactivity: test will be aborted!\n",
+				   BATADV_BW_RECV_TIMEOUT);
+		} else {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: succesfully completed test with node %02x:%02x:%02x:%02x:%02x:%02x\n",
+				   bw_vars->other_end[0], bw_vars->other_end[1],
+				   bw_vars->other_end[2], bw_vars->other_end[3],
+				   bw_vars->other_end[4],
+				   bw_vars->other_end[5]);
+		}
+
+		batadv_bw_vars_free(bw_vars);
+	} else {
+		batadv_bw_queue_receiver_worker(bw_vars);
+	}
+}
+
+static void batadv_bw_batctl_notify(uint8_t status, uint8_t uid,
+				    unsigned long int start_time)
+{
+	struct batadv_bw_result result;
+
+	result.icmp_packet.uid = uid;
+
+	if (!batadv_bw_is_error(status)) {
+		result.return_value = BATADV_BW_COMPLETE;
+		result.test_time = ((long)jiffies -
+				    (long)start_time);
+		result.total_bytes = BATADV_BW_TOTAL_TO_SEND *
+				      BATADV_BW_PACKET_LEN;
+	} else {
+		result.return_value = status;
+	}
+
+	batadv_socket_receive_packet((struct batadv_icmp_packet_rr *)&result,
+				     sizeof(result));
+}
+
+static void batadv_bw_sender_worker(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_bw_vars *bw_vars;
+	struct batadv_priv *bat_priv;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	bw_vars = container_of(delayed_work, struct batadv_bw_vars, bw_work);
+	bat_priv = bw_vars->bat_priv;
+
+	/* if timedout, resend whole window */
+	if (bw_vars->status == BATADV_BW_SENDER &&
+	    batadv_has_timed_out(bw_vars->last_sent_time, BATADV_BW_TIMEOUT)) {
+		/* increase resend counters */
+		if (bw_vars->window_first == bw_vars->last_resent_window) {
+			bw_vars->retry_number += 1;
+			if (bw_vars->retry_number > BATADV_BW_MAX_RETRY) {
+				bw_vars->window_first = bw_vars->total_to_send;
+				bw_vars->status = BATADV_BW_RESEND_LIMIT;
+			}
+		} else {
+			bw_vars->retry_number = 0;
+		}
+
+		bw_vars->last_resent_window = bw_vars->window_first;
+		bw_vars->next_to_send = bw_vars->window_first;
+		batadv_bw_multiple_send(bat_priv, bw_vars);
+	}
+
+	/* if not finished, re-enqueue worker */
+	if (bw_vars->window_first < bw_vars->total_to_send) {
+		if (batadv_bw_queue_sender_worker(bw_vars) == 0) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: batadv_bw_start work already enqueued\n");
+		}
+	} else {
+		batadv_bw_batctl_notify(bw_vars->status,
+					bw_vars->socket_client->index,
+					bw_vars->start_time);
+		batadv_bw_vars_free(bw_vars);
+	}
+}
+
+static int batadv_bw_queue_sender_worker(struct batadv_bw_vars *bw_vars)
+{
+	int ret;
+	INIT_DELAYED_WORK(&bw_vars->bw_work, batadv_bw_sender_worker);
+	ret = queue_delayed_work(batadv_event_workqueue, &bw_vars->bw_work,
+				 msecs_to_jiffies(BATADV_BW_WORKER_TIMEOUT));
+
+	return ret;
+}
+
+static int batadv_bw_queue_receiver_worker(struct batadv_bw_vars *bw_vars)
+{
+	int ret;
+	INIT_DELAYED_WORK(&bw_vars->bw_work, batadv_bw_receiver_worker);
+	ret = queue_delayed_work(batadv_event_workqueue, &bw_vars->bw_work,
+				 msecs_to_jiffies(BATADV_BW_RECV_TIMEOUT));
+
+	return ret;
+}
+
+void batadv_bw_stop(struct batadv_priv *bat_priv,
+		    uint8_t dst[], uint8_t error_status)
+{
+	struct batadv_bw_vars *bw_vars;
+	spin_lock_bh(&bat_priv->bw_list_lock);
+	bw_vars = batadv_bw_list_find(bat_priv, dst);
+	if (!bw_vars) {
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: trying to interrupt an already over connection\n");
+		return;
+	}
+	spin_unlock_bh(&bat_priv->bw_list_lock);
+	spin_lock_bh(&bw_vars->bw_vars_lock);
+	bw_vars->window_first = bw_vars->total_to_send;
+	bw_vars->status = error_status;
+	spin_unlock_bh(&bw_vars->bw_vars_lock);
+}
+
+void batadv_bw_start(struct batadv_socket_client *socket_client,
+		     struct batadv_icmp_packet *icmp_packet)
+{
+	struct batadv_priv *bat_priv = socket_client->bat_priv;
+	struct batadv_bw_vars *bw_vars;
+
+	/* find bw_vars */
+	spin_lock_bh(&bat_priv->bw_list_lock);
+	bw_vars = batadv_bw_list_find(bat_priv, &icmp_packet->dst);
+	if (bw_vars) {
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: test to or from the same node already ongoing, aborting\n");
+		batadv_bw_batctl_error_notify(BATADV_BW_ALREADY_ONGOING,
+					      socket_client->index);
+		goto out;
+	}
+
+	bw_vars = kmalloc(sizeof(*bw_vars), GFP_ATOMIC);
+	if (!bw_vars) {
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: batadv_bw_start cannot allocate list elements\n");
+		batadv_bw_batctl_error_notify(BATADV_BW_MEMORY_ERROR,
+					      socket_client->index);
+		goto out;
+	}
+
+	/* initialize bw_vars */
+	memcpy(&bw_vars->other_end, &icmp_packet->dst, ETH_ALEN);
+	bw_vars->total_to_send = BATADV_BW_TOTAL_TO_SEND + BATADV_BW_FIRST_SEQ;
+	bw_vars->window_first = BATADV_BW_FIRST_SEQ;
+	bw_vars->next_to_send = BATADV_BW_FIRST_SEQ;
+	bw_vars->status = BATADV_BW_SENDER;
+	bw_vars->last_resent_window = 0;
+	bw_vars->bat_priv = bat_priv;
+	bw_vars->socket_client = socket_client;
+	bw_vars->last_sent_time = jiffies;
+	bw_vars->start_time = jiffies;
+	atomic_set(&bw_vars->sending, 0);
+	spin_lock_init(&bw_vars->bw_vars_lock);
+	list_add(&bw_vars->list, &bat_priv->bw_list);
+	spin_unlock_bh(&bat_priv->bw_list_lock);
+
+	/* start worker */
+	if (batadv_bw_queue_sender_worker(bw_vars) == 0) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: batadv_bw_start work already enqueued\n");
+	}
+
+	batadv_bw_multiple_send(bat_priv, bw_vars);
+out:
+	return;
+}
diff --git a/bw_meter.h b/bw_meter.h
new file mode 100644
index 0000000..9999f7e
--- /dev/null
+++ b/bw_meter.h
@@ -0,0 +1,7 @@
+void batadv_bw_start(struct batadv_socket_client *socket_client,
+		     struct batadv_icmp_packet *icmp_packet_bw);
+void batadv_bw_stop(struct batadv_priv *bat_priv, uint8_t dst[],
+		    uint8_t return_value);
+void batadv_bw_meter_received(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb);
+void batadv_bw_ack_received(struct batadv_priv *bat_priv, struct sk_buff *skb);
diff --git a/icmp_socket.c b/icmp_socket.c
index bde3cf7..a48e9b5 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -20,11 +20,13 @@
 #include "main.h"
 #include <linux/debugfs.h>
 #include <linux/slab.h>
+
 #include "icmp_socket.h"
 #include "send.h"
 #include "hash.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "bw_meter.h"
 
 static struct batadv_socket_client *batadv_socket_client_hash[256];
 
@@ -152,6 +154,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct sk_buff *skb;
 	struct batadv_icmp_packet_rr *icmp_packet;
+	struct batadv_icmp_packet icmp_packet_bw;
 
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_neigh_node *neigh_node = NULL;
@@ -170,6 +173,21 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		goto out;
 	}
 
+	if (copy_from_user(&icmp_packet_bw, buff, sizeof(icmp_packet_bw))) {
+		len = -EFAULT;
+		goto out;
+	}
+
+	if (icmp_packet_bw.msg_type == BATADV_BW_START) {
+		batadv_bw_start(socket_client, &icmp_packet_bw);
+		goto out;
+	}
+
+	if (icmp_packet_bw.msg_type == BATADV_BW_STOP) {
+		batadv_bw_stop(bat_priv, icmp_packet_bw.dst, BATADV_BW_SIGINT);
+		goto out;
+	}
+
 	if (len >= sizeof(struct batadv_icmp_packet_rr))
 		packet_len = sizeof(struct batadv_icmp_packet_rr);
 
diff --git a/main.c b/main.c
index b4aa470..23a49e3 100644
--- a/main.c
+++ b/main.c
@@ -101,6 +101,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->gw.list_lock);
 	spin_lock_init(&bat_priv->vis.hash_lock);
 	spin_lock_init(&bat_priv->vis.list_lock);
+	spin_lock_init(&bat_priv->bw_list_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
@@ -108,6 +109,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt.req_list);
 	INIT_LIST_HEAD(&bat_priv->tt.roam_list);
+	INIT_LIST_HEAD(&bat_priv->bw_list);
 
 	ret = batadv_originator_init(bat_priv);
 	if (ret < 0)
diff --git a/packet.h b/packet.h
index 2d23a14..568025a 100644
--- a/packet.h
+++ b/packet.h
@@ -21,6 +21,7 @@
 #define _NET_BATMAN_ADV_PACKET_H_
 
 #define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
+#define batadv_bw_is_error(n) ((uint8_t)n > 127 ? 1 : 0)
 
 enum batadv_packettype {
 	BATADV_IV_OGM	    = 0x01,
@@ -44,12 +45,15 @@ enum batadv_iv_flags {
 };
 
 /* ICMP message types */
-enum batadv_icmp_packettype {
-	BATADV_ECHO_REPLY	       = 0,
+enum icmp_packettype {
+	BATADV_ECHO_REPLY		= 0,
 	BATADV_DESTINATION_UNREACHABLE = 3,
-	BATADV_ECHO_REQUEST	       = 8,
-	BATADV_TTL_EXCEEDED	       = 11,
-	BATADV_PARAMETER_PROBLEM       = 12,
+	BATADV_ECHO_REQUEST		= 8,
+	BATADV_TTL_EXCEEDED		= 11,
+	BATADV_PARAMETER_PROBLEM	= 12,
+	BATADV_BW_START			= 15,
+	BATADV_BW_ACK			= 16,
+	BATADV_BW_STOP			= 17,
 };
 
 /* vis defines */
@@ -155,6 +159,30 @@ struct batadv_icmp_packet_rr {
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 } __packed;
 
+enum batadv_bw_meter_status {
+	BATADV_BW_RECEIVER		= 1,
+	BATADV_BW_SENDER		= 2,
+	BATADV_BW_COMPLETE		= 3,
+	BATADV_BW_LAST_WINDOW		= 4,
+	/* error status >= 128 */
+	BATADV_BW_SIGINT		= 128,
+	BATADV_BW_DST_UNREACHABLE	= 129,
+	BATADV_BW_RESEND_LIMIT		= 130,
+	BATADV_BW_ALREADY_ONGOING	= 131,
+	BATADV_BW_MEMORY_ERROR		= 132,
+};
+
+/* structure returned to batctl */
+/* icmp_packet_rr used to keep socket_client's index,
+ * as function batadv_socket_receive_packet expects it
+ */
+struct batadv_bw_result {
+	struct batadv_icmp_packet icmp_packet;
+	uint32_t test_time;
+	uint32_t total_bytes;
+	uint8_t return_value;
+} __packed;
+
 struct batadv_unicast_packet {
 	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
diff --git a/routing.c b/routing.c
index 939fc01..f82751d 100644
--- a/routing.c
+++ b/routing.c
@@ -28,6 +28,7 @@
 #include "vis.h"
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
+#include "bw_meter.h"
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
@@ -290,6 +291,16 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
 
+	if (icmp_packet->msg_type == BATADV_BW_START) {
+		batadv_bw_meter_received(bat_priv, skb);
+		goto out;
+	}
+
+	if (icmp_packet->msg_type == BATADV_BW_ACK) {
+		batadv_bw_ack_received(bat_priv, skb);
+		goto out;
+	}
+
 	/* add data to device queue */
 	if (icmp_packet->msg_type != BATADV_ECHO_REQUEST) {
 		batadv_socket_receive_packet(icmp_packet, icmp_len);
@@ -427,7 +438,9 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 	/* add record route information if not full */
 	if ((hdr_size == sizeof(struct batadv_icmp_packet_rr)) &&
-	    (icmp_packet->rr_cur < BATADV_RR_LEN)) {
+	    (icmp_packet->rr_cur < BATADV_RR_LEN) &&
+	    (icmp_packet->msg_type != BATADV_BW_START) &&
+	    (icmp_packet->msg_type != BATADV_BW_ACK)) {
 		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
 		       ethhdr->h_dest, ETH_ALEN);
 		icmp_packet->rr_cur++;
diff --git a/types.h b/types.h
index 2ed82ca..fc7720f 100644
--- a/types.h
+++ b/types.h
@@ -226,6 +226,27 @@ struct batadv_priv_vis {
 	struct batadv_vis_info *my_info;
 };
 
+struct batadv_bw_vars {
+	struct list_head list;
+	struct delayed_work bw_work;
+	struct batadv_priv *bat_priv;
+	struct batadv_socket_client *socket_client;
+	unsigned long *bw_bits;		/* bitmap */
+	unsigned long start_time;
+	unsigned long last_sent_time;
+	uint32_t total_to_send;
+	uint32_t window_first;
+	uint32_t last_resent_window;
+	uint16_t next_to_send;
+	uint16_t bit_first;
+	uint8_t other_end[ETH_ALEN];
+	uint8_t status;			/* see bm_meter_status */
+	uint8_t retry_number;
+	uint8_t return_value;
+	atomic_t sending;		/* 1 if in multiple_send, 0 otherwise */
+	spinlock_t bw_vars_lock;	/* protects bw_vars */
+};
+
 struct batadv_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
@@ -251,12 +272,16 @@ struct batadv_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
+
+	struct list_head bw_list;
 	struct batadv_hashtable *orig_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
+	spinlock_t bw_list_lock;	/* protects bw_list */
 	struct delayed_work orig_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 	struct batadv_priv_bla bla;
 #endif
-- 
1.7.8.6

