Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu,  9 Aug 2012 14:15:24 +0200
Message-Id: <1344514526-30256-2-git-send-email-montik@autistici.org>
In-Reply-To: <1344514526-30256-1-git-send-email-montik@autistici.org>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 1/3] batman-adv: bandwidth meter implementation
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

It is invoked through ``batctl bw": the protocol is connection oriented, with
cumulative acknowledgment and sliding window. Sender keeps a timeout, which is
checked by a worker function regoularly invoked through the workqueue mechanism.
If the timeout is expired at the time worker is executed, the whole window is
re-transmitted.

Struct bw_vars, one for each connection, are collected into a linked list. Thus
access to them is protected with a spinlock.

Another spinlock prevents more than one instance of multiple_send to run
concurrently. Ack code is mutually exclusive (two ack handler cannot run at the
same time for differnent acks), but they are not mutually exclusive with
send_remaining_window, that is to say the ack handler shifts the window ``while"
send_remaining_window is running. Maybe some atomic variable (window_first) is
needed to avoid problems.

When the test is over, the results are returned to batctl through a call to the
function batadv_socket_receive_packet(), before freeing struct batadv_bw_vars.

The function only accepts struct batadv_icmp_packet_rr, so that structure is used
and a cast is done to struct batadv_bw_result.

The test interruptable with CTRL-C. A receiver side timeout avoids
unlimited waitings for sender packets: after one second of inactivity, the
receiver abort the ongoing test.

Signed-off-by: Edo Monticelli <montik@autistici.org>
---
 Makefile         |    2 +-
 Makefile.kbuild  |    1 +
 bw_meter.c       |  513 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bw_meter.h       |    7 +
 icmp_socket.c    |   18 ++
 main.c           |    2 +
 packet.h         |   22 ++-
 routing.c        |   15 ++-
 soft-interface.c |    5 +
 types.h          |   36 ++++
 10 files changed, 614 insertions(+), 7 deletions(-)
 create mode 100644 bw_meter.c
 create mode 100644 bw_meter.h

diff --git a/Makefile b/Makefile
index bd8d30c..12aebe5 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@
 
 # changing the CONFIG_* line to 'y' enables the related feature
 # B.A.T.M.A.N. debugging:
-export CONFIG_BATMAN_ADV_DEBUG=n
+export CONFIG_BATMAN_ADV_DEBUG=y
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
 
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
index 0000000..b5a67d3
--- /dev/null
+++ b/bw_meter.c
@@ -0,0 +1,513 @@
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
+#define BATADV_BW_TOTAL_TO_SEND 5000
+#define BATADV_BW_MAX_RETRY 3
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
+	/* TODO not in .h
+	icmp_to_send->msg_type = DESTINATION_UNREACHABLE;
+	batadv_socket_add_packet(socket_client, icmp_to_send, packet_len);
+	 */
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
+void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
+{
+	struct batadv_bw_vars *bw_vars;
+	struct batadv_icmp_packet *icmp_packet;
+	struct batadv_socket_client *socket_client;
+	uint16_t seqno;
+	socket_client = container_of(&bat_priv,
+				     struct batadv_socket_client, bat_priv);
+
+	icmp_packet = (struct batadv_icmp_packet *)skb->data;
+
+	/* search/initialize bw_vars struct */
+	spin_lock_bh(&bat_priv->bw_list_lock);
+	seqno = ntohs(icmp_packet->seqno);
+	bw_vars = batadv_bw_list_find(bat_priv, &icmp_packet->dst);
+	if (!bw_vars) {
+		if (seqno != 0) {
+			spin_unlock_bh(&bat_priv->bw_list_lock);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: seq != 0 cannot initiate connection\n");
+			goto out;
+		}
+		bw_vars = kmalloc(sizeof(*bw_vars), GFP_ATOMIC);
+		if (!bw_vars) {
+			spin_unlock_bh(&bat_priv->bw_list_lock);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: meter_received cannot allocate bw_vars\n");
+			goto out;
+		}
+		memcpy(&bw_vars->other_end, &icmp_packet->dst, ETH_ALEN);
+		bw_vars->status = RECEIVER;
+		bw_vars->window_first = 0;
+		bw_vars->bat_priv = bat_priv;
+		spin_lock_init(&bw_vars->bw_vars_lock);
+		list_add(&bw_vars->list, &bat_priv->bw_list);
+
+		batadv_bw_queue_receiver_worker(bw_vars);
+
+	}
+
+	if (bw_vars->status != RECEIVER) {
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: dropping packet: connection is not expecting any\n");
+		goto out;
+	}
+	spin_unlock_bh(&bat_priv->bw_list_lock);
+
+	/* check if the packet belongs to window */
+	spin_lock_bh(&bw_vars->bw_vars_lock);
+	if (seqno < bw_vars->window_first) {
+		spin_unlock_bh(&bw_vars->bw_vars_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: %d < window_first\n", icmp_packet->seqno);
+		goto out; /* TODO send an ack! */
+	}
+
+	if (seqno > bw_vars->window_first + BATADV_BW_WINDOW_SIZE) {
+		spin_unlock_bh(&bw_vars->bw_vars_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: unexpected packet received\n");
+		goto out; /* TODO ?? */
+	}
+
+	/* packet does belong to the window */
+	if (seqno == bw_vars->window_first) {
+		bw_vars->window_first++;
+		bw_vars->last_sent_time = jiffies;
+		spin_unlock_bh(&bw_vars->bw_vars_lock);
+
+		batadv_bw_ack_send(socket_client,
+				   (struct batadv_icmp_packet *)icmp_packet,
+				   seqno);
+
+		/* check for the last packet */
+		if (skb->len < BATADV_BW_PACKET_LEN) {
+			bw_vars->status = COMPLETED;
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: succesfully completed test with node %02x:%02x:%02x:%02x:%02x:%02x\n",
+				   icmp_packet->orig[0], icmp_packet->orig[1],
+				   icmp_packet->orig[2], icmp_packet->orig[3],
+				   icmp_packet->orig[4], icmp_packet->orig[5]);
+		}
+	} else {
+		spin_unlock_bh(&bw_vars->bw_vars_lock);
+	}
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
+	int ret, bw_packet_len;
+	uint16_t window_default_end, window_end, next_to_send;
+
+	ret = -1;
+	bw_packet_len = BATADV_BW_PACKET_LEN;
+	socket_client = container_of(&bat_priv, struct batadv_socket_client,
+				     bat_priv);
+
+	if (!spin_trylock_bh(&bw_vars->bw_send_lock))
+		goto out;
+
+	while (1) {
+		spin_lock_bh(&bw_vars->bw_window_first_lock);
+		window_default_end = bw_vars->window_first +
+				     BATADV_BW_WINDOW_SIZE;
+		window_end = min(window_default_end, bw_vars->total_to_send);
+
+		if (!batadv_seq_before(bw_vars->next_to_send, window_end)) {
+			spin_unlock_bh(&bw_vars->bw_send_lock);
+			spin_unlock_bh(&bw_vars->bw_window_first_lock);
+			break;
+		}
+
+		next_to_send = bw_vars->next_to_send++;
+		bw_vars->last_sent_time = jiffies;
+		spin_unlock_bh(&bw_vars->bw_window_first_lock);
+
+		if (bw_vars->next_to_send == bw_vars->total_to_send)
+			bw_packet_len -= 1;
+
+		skb = dev_alloc_skb(bw_packet_len + ETH_HLEN);
+		if (!skb) {
+			spin_unlock_bh(&bw_vars->bw_send_lock);
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: batadv_bw_multiple_send() cannot allocate skb\n");
+			goto out;
+		}
+
+		/* TODO redefine BW_PACKET_LEN */
+		skb_reserve(skb, ETH_HLEN);
+		icmp_to_send = (struct batadv_icmp_packet *)
+					skb_put(skb, bw_packet_len);
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
+			spin_unlock_bh(&bw_vars->bw_send_lock);
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
+	uint16_t window_end, seqno;
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
+	spin_lock_bh(&bw_vars->bw_window_first_lock);
+	seqno = ntohs(icmp_packet->seqno);
+	window_end = bw_vars->window_first + BATADV_BW_WINDOW_SIZE;
+	if (!batadv_seq_after(bw_vars->window_first, seqno) &&
+	    batadv_seq_before(seqno, bw_vars->next_to_send)) {
+		bw_vars->window_first = seqno + 1;
+	} else if (bw_vars->status != ABORTING) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: received unespected ack\n");
+	}
+
+	spin_unlock_bh(&bw_vars->bw_window_first_lock);
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
+		if (bw_vars->status != COMPLETED) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: more than %dms of inactivity: test will be aborted!\n",
+				   BATADV_BW_RECV_TIMEOUT);
+		}
+		batadv_bw_vars_free(bw_vars);
+	} else {
+		batadv_bw_queue_receiver_worker(bw_vars);
+	}
+}
+static void batadv_bw_sender_worker(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_bw_vars *bw_vars;
+	struct batadv_priv *bat_priv;
+	struct batadv_bw_result *result;
+	struct batadv_icmp_packet_rr *icmp_packet_rr;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	bw_vars = container_of(delayed_work, struct batadv_bw_vars, bw_work);
+	bat_priv = bw_vars->bat_priv;
+
+	/* if timedout, resend whole window */
+	if (batadv_has_timed_out(bw_vars->last_sent_time, BATADV_BW_TIMEOUT)) {
+		pr_info("RESENDING WHOLE WINDOW %d\n", bw_vars->window_first);
+		bw_vars->next_to_send = bw_vars->window_first;
+		batadv_bw_multiple_send(bat_priv, bw_vars);
+	}
+
+	if (bw_vars->window_first < bw_vars->total_to_send) {
+		/* if not finished, re-enqueue worker */
+		if (batadv_bw_queue_sender_worker(bw_vars) == 0) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Meter: batadv_bw_start work already enqueued\n");
+		}
+
+	} else {
+		/* send the answer to batctl */
+		icmp_packet_rr = kmalloc(sizeof(*icmp_packet_rr), GFP_ATOMIC);
+		icmp_packet_rr->uid = bw_vars->socket_client->index;
+		result = (struct batadv_bw_result *)icmp_packet_rr;
+		if (bw_vars->status == ABORTING) {
+			result->test_time = 0;
+			result->total_bytes = 0;
+		} else {
+			result->test_time = ((long)jiffies -
+					     (long)bw_vars->start_time) *
+					    (1000/HZ);
+			result->total_bytes = bw_vars->total_to_send *
+					      BATADV_BW_PACKET_LEN;
+		}
+		batadv_socket_receive_packet(icmp_packet_rr,
+					     sizeof(*icmp_packet_rr));
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
+		    struct batadv_icmp_packet *icmp_packet)
+{
+	struct batadv_bw_vars *bw_vars;
+	spin_lock_bh(&bat_priv->bw_list_lock);
+	bw_vars = batadv_bw_list_find(bat_priv, &icmp_packet->dst);
+	if (!bw_vars) {
+		/* TODO notify batctl */
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: trying to interrupt an already over connection\n");
+		return;
+	}
+	spin_unlock_bh(&bat_priv->bw_list_lock);
+	spin_lock_bh(&bw_vars->bw_window_first_lock);
+	bw_vars->window_first = BATADV_BW_TOTAL_TO_SEND;
+	bw_vars->status = ABORTING;
+	spin_unlock_bh(&bw_vars->bw_window_first_lock);
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
+		/* TODO notify batctl */
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: test to or from the same node already ongoing, aborting\n");
+		goto out;
+	}
+
+	bw_vars = kmalloc(sizeof(*bw_vars), GFP_ATOMIC);
+	if (!bw_vars) {
+		spin_unlock_bh(&bat_priv->bw_list_lock);
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Meter: batadv_bw_start cannot allocate list elements\n");
+		goto out;
+	}
+
+	/* initialize bw_vars */
+	memcpy(&bw_vars->other_end, &icmp_packet->dst, ETH_ALEN);
+	bw_vars->total_to_send = BATADV_BW_TOTAL_TO_SEND;
+	bw_vars->next_to_send = 0;
+	bw_vars->window_first = 0;
+	bw_vars->bat_priv = bat_priv;
+	bw_vars->socket_client = socket_client;
+	bw_vars->last_sent_time = jiffies;
+	bw_vars->start_time = jiffies;
+	spin_lock_init(&bw_vars->bw_window_first_lock);
+	spin_lock_init(&bw_vars->bw_send_lock);
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
index 0000000..3c04521
--- /dev/null
+++ b/bw_meter.h
@@ -0,0 +1,7 @@
+void batadv_bw_start(struct batadv_socket_client *socket_client,
+		     struct batadv_icmp_packet *icmp_packet_bw);
+void batadv_bw_stop(struct batadv_priv *bat_priv,
+		    struct batadv_icmp_packet *icmp_packet);
+void batadv_bw_meter_received(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb);
+void batadv_bw_ack_received(struct batadv_priv *bat_priv, struct sk_buff *skb);
diff --git a/icmp_socket.c b/icmp_socket.c
index bde3cf7..f9f6435 100644
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
+		batadv_bw_stop(bat_priv, &icmp_packet_bw);
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
index 2d23a14..1fd4e7f 100644
--- a/packet.h
+++ b/packet.h
@@ -44,12 +44,15 @@ enum batadv_iv_flags {
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
@@ -155,6 +158,15 @@ struct batadv_icmp_packet_rr {
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 } __packed;
 
+/* structure returned to batctl */
+/* icmp_packet_rr used to keep socket_client's index,
+ * as function batadv_socket_receive_packet expects it
+ */
+struct batadv_bw_result {
+	unsigned long int test_time;
+	unsigned long int total_bytes;
+};
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
diff --git a/soft-interface.c b/soft-interface.c
index 1aee7db..15077ac 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -438,6 +438,11 @@ struct net_device *batadv_softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
+	bat_priv->bat_counters = __alloc_percpu(sizeof(uint64_t) * BATADV_CNT_NUM,
+						__alignof__(uint64_t));
+	if (!bat_priv->bat_counters)
+		goto unreg_soft_iface;
+
 	ret = batadv_algo_select(bat_priv, batadv_routing_algo);
 	if (ret < 0)
 		goto unreg_soft_iface;
diff --git a/types.h b/types.h
index 2ed82ca..813914c 100644
--- a/types.h
+++ b/types.h
@@ -226,6 +226,35 @@ struct batadv_priv_vis {
 	struct batadv_vis_info *my_info;
 };
 
+enum bw_meter_status {
+	RECEIVER,
+	SENDER,
+	ABORTING,
+	COMPLETED,
+};
+
+struct batadv_bw_vars {
+	struct list_head list;
+	struct delayed_work bw_work;
+	struct batadv_priv *bat_priv;
+	struct batadv_socket_client *socket_client;
+	/* lock used in receiver */
+	spinlock_t bw_vars_lock;
+	/* locks used in sender */
+	spinlock_t bw_window_first_lock;
+	/* protects multiple_send calls */
+	spinlock_t bw_send_lock;
+	/* total data to send OR window data received */
+	uint16_t total_to_send;
+	/* offset of the first window packet */
+	uint16_t next_to_send;
+	uint16_t window_first;
+	uint8_t other_end[ETH_ALEN];
+	uint8_t status; /* see bm_meter_status */
+	unsigned long start_time;
+	unsigned long last_sent_time;
+};
+
 struct batadv_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
@@ -251,18 +280,25 @@ struct batadv_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
+
+	struct list_head bw_list;
 	struct batadv_hashtable *orig_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	struct delayed_work orig_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 	struct batadv_priv_bla bla;
 #endif
 	struct batadv_priv_gw gw;
 	struct batadv_priv_tt tt;
 	struct batadv_priv_vis vis;
+
+	struct delayed_work bw_work;
+	struct batadv_bw_vars *bw_vars;
+	spinlock_t bw_list_lock;	/* protects bw_list */
 };
 
 struct batadv_socket_client {
-- 
1.7.8.6

