Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:15 +0100
Message-Id: <1392122903-805-16-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
	packets for throughput sampling
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

In case of a unused link, the throughput estimation will
get stuck to the last sampled value and therefore the
reported metric will becomes obsolete.

Send unicast ELP packets to each neighbor to trigger throughput
sampling on unused links.

These packets will fill an entire frame so that the
measurement is as much reliable as possible

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_elp.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 main.h      |  3 +++
 send.c      |  4 +--
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index ef4e476..14a1e15 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -25,6 +25,7 @@
 #include "bat_v_elp.h"
 #include "originator.h"
 #include "routing.h"
+#include "soft-interface.h"
 #include "translation-table.h"
 
 /**
@@ -171,6 +172,67 @@ static void batadv_v_elp_neigh_purge(struct batadv_hard_iface *hard_iface)
 }
 
 /**
+ * batadv_v_elp_wifi_neigh_probe - send link probing packets to a neighbour
+ * @hard_iface: the interface to use while sending the probing packets
+ * @neigh: the neighbour to probe
+ *
+ * Sends a predefined number of unicast wifi packets to a given neighbour in
+ * order to trigger the throughput estimation on this link by the RC algorithm.
+ * Packets are sent only if there there is not enough payload unicast traffic
+ * towards this neighbour..
+ *
+ * Returns 0 on success and -1 in case of error during skb preparation.
+ */
+static int batadv_v_elp_wifi_neigh_probe(struct batadv_hard_iface *hard_iface,
+					 struct batadv_elp_neigh_node *neigh)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	unsigned long last_tx_diff;
+	struct sk_buff *skb;
+	int probe_len, i;
+
+	/* this probing routine is for Wifi neighbours only */
+	if (batadv_is_wifi_netdev(hard_iface->net_dev))
+		return 0;
+
+	/* probe the neighbor only if no unicast packets have been sent
+	 * to it in the last 100 milliseconds: this is the rate control
+	 * algorithm sampling interval (minstrel). In this way, if not
+	 * enough traffic has been sent to the neighbor, batman-adv can
+	 * generate 2 probe packets and push the RC algorithm to perform
+	 * the sampling
+	 */
+	last_tx_diff = jiffies_to_msecs(jiffies - neigh->last_unicast_tx);
+	if (last_tx_diff <= BATADV_ELP_PROBE_MAX_TX_DIFF)
+		return 0;
+
+	probe_len = max_t(int, sizeof(struct batadv_elp_packet),
+			  BATADV_ELP_MIN_PROBE_SIZE);
+
+	for (i = 0; i < BATADV_ELP_PROBES_PER_NODE; i++) {
+		skb = skb_copy_expand(hard_iface->bat_v.elp_skb, 0,
+				      probe_len - hard_iface->bat_v.elp_skb->len,
+				      GFP_ATOMIC);
+		if (!skb)
+			return -1;
+
+		/* Tell the skb to get as bigger as the allocated space (we want
+		 * the packet to be exactly of that size to make the link
+		 * throughput estimation effective.
+		 */
+		skb_put(skb, probe_len - hard_iface->bat_v.elp_skb->len);
+
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Sending unicast (probe) ELP packet on interface %s to %pM\n",
+			   hard_iface->net_dev->name, neigh->addr);
+
+		batadv_send_skb_packet(skb, hard_iface, neigh->addr);
+	}
+
+	return 0;
+}
+
+/**
  * batadv_v_elp_periodic_work - ELP periodic task per interface
  * @work: work queue item
  *
@@ -181,11 +243,11 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
-	struct batadv_priv *bat_priv;
 	struct batadv_elp_packet *elp_packet;
-	uint32_t elp_interval;
 	struct batadv_elp_neigh_node *neigh;
+	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
+	uint32_t elp_interval;
 	uint8_t num_neighs;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
@@ -206,7 +268,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	skb = skb_copy(hard_iface->bat_v.elp_skb, GFP_ATOMIC);
 	if (!skb)
-		goto update_metric;
+		goto restart_timer;
 
 	/* purge outdated entries first */
 	batadv_v_elp_neigh_purge(hard_iface);
@@ -221,7 +283,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	elp_packet->elp_interval = htonl(elp_interval);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Sending ELP packet on interface %s, seqno %u\n",
+		   "Sending broadcast ELP packet on interface %s, seqno %u\n",
 		   hard_iface->net_dev->name,
 		   atomic_read(&hard_iface->bat_v.elp_seqno));
 
@@ -229,15 +291,27 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
-update_metric:
 	/* Instead of updating the metric each "received" ELP packet, it is
 	 * better to do it on each ELP sending. This way, if a node is dead and
 	 * does not send packets anymore, batman-adv is still able to timely
 	 * react to its death.
+	 *
+	 * The metric is updated by following these steps:
+	 * 1) if the hard_iface if wifi => send a unicast ELP for
+	 * probing/sampling to each neighbor
+	 * 2) update the metric value of each neighbor
+	 *
 	 */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(neigh, &hard_iface->bat_v.neigh_list, list)
+	hlist_for_each_entry_rcu(neigh, &hard_iface->bat_v.neigh_list, list) {
+		if (batadv_v_elp_wifi_neigh_probe(hard_iface, neigh) < 0)
+			/* if something goes wrong while probing, better to stop
+			 * sending packets immediately and reschedule the task
+			 */
+			break;
+
 		ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
+	}
 	rcu_read_unlock();
 
 restart_timer:
diff --git a/main.h b/main.h
index 5699c9f..9cfdbb3 100644
--- a/main.h
+++ b/main.h
@@ -54,6 +54,9 @@
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
 #define BATADV_DAT_ENTRY_TIMEOUT (5*60000) /* 5 mins in milliseconds */
 #define BATADV_ELP_OUTDATED_MAX 4
+#define BATADV_ELP_PROBES_PER_NODE 2
+#define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
+#define BATADV_ELP_PROBE_MAX_TX_DIFF 100 /* milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
diff --git a/send.c b/send.c
index 734b24e..20b60d7 100644
--- a/send.c
+++ b/send.c
@@ -108,8 +108,8 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
 
 	ret = batadv_send_skb_packet(skb, neigh->if_incoming, neigh->addr);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
-	if (ret != NET_XMIT_DROP && neigh->elp_neigh)
-		neigh->elp_neigh->last_unicast_tx = jiffies;
+	if (ret != NET_XMIT_DROP && neigh->bat_v.elp_neigh)
+		neigh->bat_v.elp_neigh->last_unicast_tx = jiffies;
 #endif
 
 	return ret;
-- 
1.8.5.3

