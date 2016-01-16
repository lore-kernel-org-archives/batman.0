Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:40:16 +0800
Message-Id: <1452933619-6712-9-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
Subject: [B.A.T.M.A.N.] [PATCH v2 09/12] batman-adv: ELP - compute the
	metric based on the estimated throughput
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

In case of wireless interface retrieve the throughput by
querying cfg80211. To perform this call a separate work
must be scheduled because the function may sleep and this
is not allowed within an RCU protected context (RCU in this
case is used to iterate over all the neighbours).

Use ethtool to retrieve information about an Ethernet link
like HALF/FULL_DUPLEX and advertised bandwidth (e.g.
100/10Mbps).

The metric is updated each time a new ELP packet is sent,
this way it is possible to timely react to a metric
variation which can imply (for example) a neighbour
disconnection.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 compat.h                   |  21 +++++
 net/batman-adv/bat_v.c     |   3 +
 net/batman-adv/bat_v_elp.c | 207 +++++++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v_elp.h |   2 +
 net/batman-adv/bat_v_ogm.c |   2 +-
 net/batman-adv/main.h      |   4 +
 net/batman-adv/types.h     |  16 ++++
 7 files changed, 254 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index 7152237..454fa4c 100644
--- a/compat.h
+++ b/compat.h
@@ -170,6 +170,27 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 10, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 15, 0)
+
+/* the expected behaviour of this function is to return 0 on success, therefore
+ * it is possible to define it as 1 so that batman-adv thinks like something
+ * went wrong. It will then decide what to do.
+ */
+#define cfg80211_get_station(_a, _b, _c) (1)
+/* the following define substitute the expected_throughput field with a random
+ * one existing in the station_info struct. It can be random because due to the
+ * define above it will never be used. We need it only to make the code compile
+ */
+#define expected_throughput filled
+
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
+#warning cfg80211 based throughput metric is only supported with Linux 3.15+
+
+#endif
+
+#endif /* < KERNEL_VERSION(3, 15, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
 
 #define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index d9cb5c4..ff31f2a 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/init.h>
+#include <linux/workqueue.h>
 
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
@@ -65,6 +66,8 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
+	INIT_WORK(&hardif_neigh->bat_v.metric_work,
+		  batadv_v_elp_throughput_metric_update);
 }
 
 static void batadv_v_ogm_schedule(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1e4d13c..f257897 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -22,19 +22,23 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/cfg80211.h>
 
 #include "bat_algo.h"
 #include "bat_v_ogm.h"
@@ -60,6 +64,168 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 }
 
 /**
+ * batadv_v_elp_get_throughput - get the throughput towards a neighbour
+ * @neigh: the neighbour for which the throughput has to be obtained
+ *
+ * Return: the throughput towards the given neighbour.
+ */
+static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
+{
+	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct station_info sinfo;
+	struct ethtool_cmd cmd;
+	u32 throughput;
+	int ret;
+
+	/* if the user specified a customised value for this interface, then
+	 * return it directly
+	 */
+	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
+	if (throughput != 0)
+		return throughput;
+
+	/* if this is a wireless device, then ask its throughput through
+	 * cfg80211 API
+	 */
+	if (batadv_is_wifi_netdev(hard_iface->net_dev)) {
+		if (hard_iface->net_dev->ieee80211_ptr) {
+			ret = cfg80211_get_station(hard_iface->net_dev,
+						   neigh->addr, &sinfo);
+			if (ret == -ENOENT) {
+				/* Node is not associated anymore! It would be
+				 * possible to delete this neighbor. For now set
+				 * the throughput metric to 0.
+				 */
+				return 0;
+			}
+			if (!ret)
+				return sinfo.expected_throughput / 10;
+		}
+
+		/* unsupported WiFi driver version */
+		goto default_throughput;
+	}
+
+	/* if not a wifi interface, check if this device provides data via
+	 * ethtool (e.g. an Ethernet adapter)
+	 */
+	memset(&cmd, 0, sizeof(cmd));
+	rtnl_lock();
+	ret = __ethtool_get_settings(hard_iface->net_dev, &cmd);
+	rtnl_unlock();
+	if (ret == 0) {
+		/* link characteristics might change over time */
+		if (cmd.duplex == DUPLEX_FULL)
+			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
+		else
+			hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
+
+		throughput = ethtool_cmd_speed(&cmd);
+		if (throughput && throughput != SPEED_UNKNOWN)
+			return throughput * 10;
+	}
+
+default_throughput:
+	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
+		batadv_info(hard_iface->soft_iface,
+			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %d kbit/s. Consider overriding the throughput manually or checking your driver.\n",
+			    hard_iface->net_dev->name,
+			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10);
+		hard_iface->bat_v.flags |= BATADV_WARNING_DEFAULT;
+	}
+
+	/* if none of the above cases apply, return the base_throughput */
+	return BATADV_THROUGHPUT_DEFAULT_VALUE;
+}
+
+/**
+ * batadv_v_elp_throughput_metric_update - worker updating the throughput metric
+ *  of a single hop neighbour
+ * @work: the work queue item
+ */
+void batadv_v_elp_throughput_metric_update(struct work_struct *work)
+{
+	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
+	struct batadv_hardif_neigh_node *neigh;
+
+	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
+				   metric_work);
+	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
+			     bat_v);
+
+	ewma_throughput_add(&neigh->bat_v.throughput,
+			    batadv_v_elp_get_throughput(neigh));
+
+	/* decrement refcounter to balance increment performed before scheduling
+	 * this task
+	 */
+	batadv_hardif_neigh_put(neigh);
+}
+
+/**
+ * batadv_v_elp_wifi_neigh_probe - send link probing packets to a neighbour
+ * @neigh: the neighbour to probe
+ *
+ * Sends a predefined number of unicast wifi packets to a given neighbour in
+ * order to trigger the throughput estimation on this link by the RC algorithm.
+ * Packets are sent only if there there is not enough payload unicast traffic
+ * towards this neighbour..
+ *
+ * Return: True on success and false in case of error during skb preparation.
+ */
+static bool
+batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
+{
+	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	unsigned long last_tx_diff;
+	struct sk_buff *skb;
+	int probe_len, i;
+	int elp_skb_len;
+
+	/* this probing routine is for Wifi neighbours only */
+	if (!batadv_is_wifi_netdev(hard_iface->net_dev))
+		return true;
+
+	/* probe the neighbor only if no unicast packets have been sent
+	 * to it in the last 100 milliseconds: this is the rate control
+	 * algorithm sampling interval (minstrel). In this way, if not
+	 * enough traffic has been sent to the neighbor, batman-adv can
+	 * generate 2 probe packets and push the RC algorithm to perform
+	 * the sampling
+	 */
+	last_tx_diff = jiffies_to_msecs(jiffies - neigh->bat_v.last_unicast_tx);
+	if (last_tx_diff <= BATADV_ELP_PROBE_MAX_TX_DIFF)
+		return true;
+
+	probe_len = max_t(int, sizeof(struct batadv_elp_packet),
+			  BATADV_ELP_MIN_PROBE_SIZE);
+
+	for (i = 0; i < BATADV_ELP_PROBES_PER_NODE; i++) {
+		elp_skb_len = hard_iface->bat_v.elp_skb->len;
+		skb = skb_copy_expand(hard_iface->bat_v.elp_skb, 0,
+				      probe_len - elp_skb_len,
+				      GFP_ATOMIC);
+		if (!skb)
+			return false;
+
+		/* Tell the skb to get as big as the allocated space (we want
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
+	return true;
+}
+
+/**
  * batadv_v_elp_periodic_work - ELP periodic task per interface
  * @work: work queue item
  *
@@ -67,6 +233,7 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
  */
 static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
+	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
 	struct batadv_elp_packet *elp_packet;
@@ -108,6 +275,37 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+	/* The throughput metric is updated on each sent packet. This way, if a
+	 * node is dead and no longer sends packets, batman-adv is still able to
+	 * react timely to its death.
+	 *
+	 * The throughput metric is updated by following these steps:
+	 * 1) if the hard_iface is wifi => send a number of unicast ELPs for
+	 *    probing/sampling to each neighbor
+	 * 2) update the throughput metric value of each neighbor (note that the
+	 *    value retrieved in this step might be 100ms old because the
+	 *    probing packets at point 1) could still be in the HW queue)
+	 */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(hardif_neigh, &hard_iface->neigh_list, list) {
+		if (!batadv_v_elp_wifi_neigh_probe(hardif_neigh))
+			/* if something goes wrong while probing, better to stop
+			 * sending packets immediately and reschedule the task
+			 */
+			break;
+
+		if (!kref_get_unless_zero(&hardif_neigh->refcount))
+			continue;
+
+		/* Reading the estimated throughput from cfg80211 is a task that
+		 * may sleep and that is not allowed in an rcu protected
+		 * context. Therefore schedule a task for that.
+		 */
+		queue_work(batadv_event_workqueue,
+			   &hardif_neigh->bat_v.metric_work);
+	}
+	rcu_read_unlock();
+
 restart_timer:
 	batadv_v_elp_start_timer(hard_iface);
 out:
@@ -146,6 +344,15 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 	atomic_set(&hard_iface->bat_v.elp_seqno, random_seqno);
 	atomic_set(&hard_iface->bat_v.elp_interval, 500);
 
+	/* assume full-duplex by default */
+	hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
+
+	/* warn the user (again) if there is no throughput data is available */
+	hard_iface->bat_v.flags &= ~BATADV_WARNING_DEFAULT;
+
+	if (batadv_is_wifi_netdev(hard_iface->net_dev))
+		hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
+
 	INIT_DELAYED_WORK(&hard_iface->bat_v.elp_wq,
 			  batadv_v_elp_periodic_work);
 	batadv_v_elp_start_timer(hard_iface);
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 5a7bc39..e95f1bc 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -21,11 +21,13 @@
 #define _NET_BATMAN_ADV_BAT_V_ELP_H_
 
 struct sk_buff;
+struct work_struct;
 
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
+void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c800096..d9bcbe6 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -339,7 +339,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 	 */
 	if ((throughput > 10) &&
 	    (if_incoming == if_outgoing) &&
-	    (batadv_is_wifi_netdev(if_incoming->net_dev)))
+	    !(if_incoming->bat_v.flags & BATADV_FULL_DUPLEX))
 		return throughput / 2;
 
 	/* hop penalty of 255 equals 100% */
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e6cef57..6386e45 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -62,6 +62,10 @@
 #define BATADV_TQ_TOTAL_BIDRECT_LIMIT 1
 
 /* B.A.T.M.A.N. V */
+#define BATADV_THROUGHPUT_DEFAULT_VALUE 10
+#define BATADV_ELP_PROBES_PER_NODE 2
+#define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
+#define BATADV_ELP_PROBE_MAX_TX_DIFF 100 /* milliseconds */
 #define BATADV_ELP_MAX_AGE 64
 #define BATADV_OGM_MAX_ORIGDIFF 5
 #define BATADV_OGM_MAX_AGE 64
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c56bb88..9abfb3e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -87,12 +87,25 @@ struct batadv_hard_iface_bat_iv {
 };
 
 /**
+ * enum batadv_v_hard_iface_flags - interface flags useful to B.A.T.M.A.N. V
+ * @BATADV_FULL_DUPLEX: tells if the connection over this link is full-duplex
+ * @BATADV_WARNING_DEFAULT: tells whether we have warned the user that no
+ *  throughput data is available for this interface and that default values are
+ *  assumed.
+ */
+enum batadv_v_hard_iface_flags {
+	BATADV_FULL_DUPLEX	= BIT(0),
+	BATADV_WARNING_DEFAULT	= BIT(1),
+};
+
+/**
  * struct batadv_hard_iface_bat_v - per hard-interface B.A.T.M.A.N. V data
  * @elp_interval: time interval between two ELP transmissions
  * @elp_seqno: current ELP sequence number
  * @elp_skb: base skb containing the ELP message to send
  * @elp_wq: workqueue used to schedule ELP transmissions
  * @throughput_override: throughput override to disable link auto-detection
+ * @flags: interface specific flags
  */
 struct batadv_hard_iface_bat_v {
 	atomic_t elp_interval;
@@ -100,6 +113,7 @@ struct batadv_hard_iface_bat_v {
 	struct sk_buff *elp_skb;
 	struct delayed_work elp_wq;
 	atomic_t throughput_override;
+	u8 flags;
 };
 
 /**
@@ -378,12 +392,14 @@ DECLARE_EWMA(throughput, 1024, 8)
  * @elp_interval: time interval between two ELP transmissions
  * @elp_latest_seqno: latest and best known ELP sequence number
  * @last_unicast_tx: when the last unicast packet has been sent to this neighbor
+ * @metric_work: work queue callback item for metric update
  */
 struct batadv_hardif_neigh_node_bat_v {
 	struct ewma_throughput throughput;
 	u32 elp_interval;
 	u32 elp_latest_seqno;
 	unsigned long last_unicast_tx;
+	struct work_struct metric_work;
 };
 
 /**
-- 
2.7.0.rc3

