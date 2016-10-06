Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  6 Oct 2016 08:41:41 +0200
Message-Id: <20161006064142.20003-5-linus.luessing@c0d3.blue>
In-Reply-To: <20161006064142.20003-1-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 4/4] batman-adv: Evaluate and use
	neighborhood hash TVLV
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

This patch aims to reduce protocol overhead for BATMAN V by avoiding
rebroadcasts of OGM2 and broadcast packets in neighborhoods where
every neighbor "sees" another.

This is done by parsing and storing the new information provided by the
ELP specific neighborhood hash TVLV.

We then use this new information to detect certain scenarios where a
rebroadcast of OGM2 and broadcast packets on the incoming interface is
unncessary.

In a nutshell the detection checks whether all neighbors see each
other by comparing their with a neighbors hash. If so, then a node
deciding to rebroadcast will check whether either the ingress side
or the egress side might be a bottleneck metric wise. In other words,
whether a rebroadcast might not enhance any throughput.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changes in v2:
* added kerneldoc for new @skb in batadv_v_elp_neigh_update()
* added include for linux/types.h in bat_v_elp.h
* removed a duplicate bat_v_ogm.h include in bat_v_ogm.c
* adjusted alignment for new function in algo_iface_ops
(thanks Sven!)
---
 net/batman-adv/bat_v.c          |  40 ++++-
 net/batman-adv/bat_v_elp.c      | 316 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/bat_v_elp.h      |  12 ++
 net/batman-adv/bat_v_ogm.c      |  18 ++-
 net/batman-adv/bat_v_ogm.h      |   4 +
 net/batman-adv/hard-interface.c |  47 +++---
 net/batman-adv/hard-interface.h |   6 +-
 net/batman-adv/send.c           |   8 +-
 net/batman-adv/types.h          |  17 +++
 9 files changed, 433 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c93b589..91f8395 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -126,6 +126,9 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
+	hardif_neigh->bat_v.min_throughput = 0;
+	memset(hardif_neigh->bat_v.neigh_hash, 0,
+	       sizeof(hardif_neigh->bat_v.neigh_hash));
 	INIT_WORK(&hardif_neigh->bat_v.metric_work,
 		  batadv_v_elp_throughput_metric_update);
 }
@@ -172,14 +175,33 @@ batadv_v_hardif_neigh_print(struct seq_file *seq,
 {
 	int last_secs, last_msecs;
 	u32 throughput;
+	char nhh_avoid_ogm = '.', nhh_avoid_bcast = '.';
+	bool same_hash;
+
+	same_hash = batadv_v_elp_nhh_cmp(hardif_neigh);
+
+	if (same_hash) {
+		if (batadv_v_elp_rx_ingress_bad(hardif_neigh))
+			nhh_avoid_ogm = 'A';
+
+		if (batadv_v_elp_rx_egress_bad(hardif_neigh))
+			nhh_avoid_ogm = (nhh_avoid_ogm == '.') ? 'B' : 'C';
+
+		if (batadv_v_elp_tx_ingress_bad(hardif_neigh))
+			nhh_avoid_bcast = 'X';
+
+		if (batadv_v_elp_tx_egress_bad(hardif_neigh))
+			nhh_avoid_bcast = (nhh_avoid_bcast == '.') ? 'Y' : 'Z';
+	}
 
 	last_secs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen) / 1000;
 	last_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen) % 1000;
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
 
-	seq_printf(seq, "%pM %4i.%03is (%9u.%1u) [%10s]\n",
+	seq_printf(seq, "%pM %4i.%03is (%9u.%1u) [%10s]     [%c%c%c]\n",
 		   hardif_neigh->addr, last_secs, last_msecs, throughput / 10,
-		   throughput % 10, hardif_neigh->if_incoming->net_dev->name);
+		   throughput % 10, hardif_neigh->if_incoming->net_dev->name,
+		   same_hash ? 'H' : '.', nhh_avoid_ogm, nhh_avoid_bcast);
 }
 
 /**
@@ -196,7 +218,7 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 	int batman_count = 0;
 
 	seq_puts(seq,
-		 "  Neighbor        last-seen ( throughput) [        IF]\n");
+		 "  Neighbor        last-seen ( throughput) [        IF] NHH-flags\n");
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -1039,6 +1061,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	},
 	.neigh = {
 		.hardif_init = batadv_v_hardif_neigh_init,
+		.hardif_no_broadcast = batadv_v_elp_no_broadcast,
 		.cmp = batadv_v_neigh_cmp,
 		.is_similar_or_better = batadv_v_neigh_is_sob,
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
@@ -1081,6 +1104,9 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 
 	bat_v->min_throughput = 0;
 	bat_v->max_throughput = (~(u32)0);
+	bat_v->min_throughput_other = 0;
+	bat_v->max_throughput_other = ~((u32)0);
+
 	memset(bat_v->neigh_hash, 0, sizeof(bat_v->neigh_hash));
 }
 
@@ -1095,9 +1121,15 @@ int batadv_v_mesh_init(struct batadv_priv *bat_priv)
 {
 	int ret = 0;
 
+	ret = batadv_v_elp_mesh_init(bat_priv);
+	if (ret < 0)
+		return ret;
+
 	ret = batadv_v_ogm_init(bat_priv);
-	if (ret < 0)
+	if (ret < 0) {
+		batadv_v_elp_mesh_free(bat_priv);
 		return ret;
+	}
 
 	/* set default throughput difference threshold to 5Mbps */
 	atomic_set(&bat_priv->gw.sel_class, 50);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 931dd2e..ab54344 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -52,6 +52,7 @@
 #include "packet.h"
 #include "routing.h"
 #include "send.h"
+#include "tvlv.h"
 
 static struct crypto_shash *tfm;
 
@@ -88,6 +89,7 @@ static void batadv_v_elp_update_neigh_hash(struct batadv_hard_iface *hard_iface)
 	struct ewma_throughput *ewma_throughput;
 	u8 *own_addr = hard_iface->net_dev->dev_addr;
 	u32 min_throughput = ~((u32)0), max_throughput = 0;
+	u32 min_throughput_other = ~((u32)0), max_throughput_other = 0;
 	u32 throughput;
 	int ret;
 
@@ -129,6 +131,16 @@ static void batadv_v_elp_update_neigh_hash(struct batadv_hard_iface *hard_iface)
 
 		if (throughput > max_throughput)
 			max_throughput = throughput;
+
+		throughput = hardif_neigh->bat_v.min_throughput;
+
+		if (throughput < min_throughput_other)
+			min_throughput_other = throughput;
+
+		throughput = hardif_neigh->bat_v.max_throughput;
+
+		if (throughput > max_throughput_other)
+			max_throughput_other = throughput;
 	}
 	rcu_read_unlock();
 
@@ -144,14 +156,18 @@ static void batadv_v_elp_update_neigh_hash(struct batadv_hard_iface *hard_iface)
 
 	hard_iface->bat_v.min_throughput = min_throughput;
 	hard_iface->bat_v.max_throughput = max_throughput;
+	hard_iface->bat_v.min_throughput_other = min_throughput_other;
+	hard_iface->bat_v.max_throughput_other = max_throughput_other;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Updated neighbor hash on interface %s: %*phN, min_through: %u kbit/s, max_through: %u kbit/s\n",
+		   "Updated neighbor hash on interface %s: %*phN, min_through: %u kbit/s, max_through: %u kbit/s, min_through_other: %u kbit/s, max_through_other: %u kbit/s\n",
 		   hard_iface->net_dev->name,
 		   (int)sizeof(hard_iface->bat_v.neigh_hash),
 		   hard_iface->bat_v.neigh_hash,
 		   hard_iface->bat_v.min_throughput * 100,
-		   hard_iface->bat_v.max_throughput * 100);
+		   hard_iface->bat_v.max_throughput * 100,
+		   hard_iface->bat_v.min_throughput_other * 100,
+		   hard_iface->bat_v.max_throughput_other * 100);
 
 	return;
 
@@ -160,6 +176,8 @@ err:
 	       sizeof(hard_iface->bat_v.neigh_hash));
 	hard_iface->bat_v.min_throughput = 0;
 	hard_iface->bat_v.max_throughput = ~((u32)0);
+	hard_iface->bat_v.min_throughput_other = 0;
+	hard_iface->bat_v.max_throughput_other = ~((u32)0);
 
 	pr_warn_once("An error occurred while calculating neighbor hash for %s\n",
 		     hard_iface->net_dev->name);
@@ -573,8 +591,38 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 }
 
 /**
+ * batadv_v_elp_pack_ctx - pack context to be passed to an ELP TVLV handler
+ * @hardif_neigh: An hardif_neigh to pack (mandatory, may *not* be NULL!)
+ *
+ * This packs the context, here the hardif_neigh the packet came from, so that
+ * it is later available to the to be called ELP TVLV handler.
+ *
+ * Return: The wrapped context.
+ */
+static void *
+batadv_v_elp_pack_ctx(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	return (void *)hardif_neigh;
+}
+
+/**
+ * batadv_v_elp_unpack_ctx - unpack context received with a TVLV handler call
+ * @ctx: The context container to unpack
+ *
+ * This unpacks the context received within an ELP TVLV handler, here the
+ * hardif_neigh the packet came from.
+ *
+ * Return: The hardif_neigh the packet came from.
+ */
+static struct batadv_hardif_neigh_node *batadv_v_elp_unpack_ctx(void *ctx)
+{
+	return (struct batadv_hardif_neigh_node *)ctx;
+}
+
+/**
  * batadv_v_elp_neigh_update - update an ELP neighbour node
  * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the received packet
  * @neigh_addr: the neighbour interface address
  * @if_incoming: the interface the packet was received through
  * @elp_packet: the received ELP packet
@@ -583,6 +631,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
  * ELP packet.
  */
 static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
+				      struct sk_buff *skb,
 				      u8 *neigh_addr,
 				      struct batadv_hard_iface *if_incoming,
 				      struct batadv_elp_packet *elp_packet)
@@ -591,6 +640,8 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh;
 	struct batadv_orig_node *orig_neigh;
 	struct batadv_hardif_neigh_node *hardif_neigh;
+	unsigned int tvlv_offset = sizeof(*elp_packet);
+	void *ctx;
 	s32 seqno_diff;
 	s32 elp_latest_seqno;
 
@@ -607,6 +658,11 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	if (!hardif_neigh)
 		goto neigh_free;
 
+	ctx = batadv_v_elp_pack_ctx(hardif_neigh);
+
+	batadv_tvlv_containers_process2(bat_priv, skb, BATADV_ELP, tvlv_offset,
+					ntohs(elp_packet->tvlv_len), ctx);
+
 	elp_latest_seqno = hardif_neigh->bat_v.elp_latest_seqno;
 	seqno_diff = ntohl(elp_packet->seqno) - elp_latest_seqno;
 
@@ -673,7 +729,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (!primary_if)
 		goto out;
 
-	batadv_v_elp_neigh_update(bat_priv, ethhdr->h_source, if_incoming,
+	batadv_v_elp_neigh_update(bat_priv, skb, ethhdr->h_source, if_incoming,
 				  elp_packet);
 
 out:
@@ -684,6 +740,260 @@ out:
 }
 
 /**
+ * batadv_v_elp_nhh_cmp - compares a neighbor's hash with the own one
+ * @hardif_neigh: the hardif_neigh to compare with
+ *
+ * Checks whether the neighbor hash a neighbor advertised matches our own
+ * hash, the one we computed for the same interface.
+ *
+ * Return: True, if the hashes match, false otherwise.
+ */
+bool batadv_v_elp_nhh_cmp(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	return !memcmp(hardif_neigh->if_incoming->bat_v.neigh_hash,
+		       hardif_neigh->bat_v.neigh_hash,
+		       sizeof(hardif_neigh->bat_v.neigh_hash));
+}
+
+/**
+ * batadv_v_elp_rx_ingress_bad - check for ingress RX-metric bottlenecks
+ * @hardif_neigh: the hardif_neigh a packet was received from
+ *
+ * Checks whether we could potentially be a better path for packets
+ * coming from the given hardif_neigh to any neighbor on the same interface.
+ * Or whether there is some bottleneck making us unfavourable to become
+ * a forwarder for packets from this hardif_neigh.
+ *
+ * More specifically, this function checks whether our ingress side, that
+ * is the connection from us to the given hardif_neigh, is worse than the
+ * direct transmission any other neighbor to this hardif_neigh.
+ *
+ * Return: True if our incoming side a bottleneck, false otherwise.
+ */
+
+bool batadv_v_elp_rx_ingress_bad(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	struct batadv_hard_iface *iface = hardif_neigh->if_incoming;
+	struct batadv_priv *bat_priv = netdev_priv(iface->soft_iface);
+	u32 throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
+	u32 limit = iface->bat_v.min_throughput_other;
+
+	throughput = batadv_v_forward_penalty(bat_priv, iface, iface,
+					      throughput);
+
+	return throughput < limit;
+}
+
+/**
+ * batadv_v_elp_rx_egress_bad - check for egress RX-metric bottlenecks
+ * @hardif_neigh: the hardif_neigh a packet was received from
+ *
+ * Checks whether we could potentially be a better path for packets
+ * coming from the given hardif_neigh to any neighbor on the same interface.
+ * Or whether there is some bottleneck making us unfavourable to become
+ * a forwarder for packets from this hardif_neigh.
+ *
+ * More specifically, this function checks whether our egress side, that is
+ * the connection from from any neighbor other than hardif_neigh to us, is
+ * worse than the direct transmission of any other neighbor to this
+ * hardif_neigh.
+ *
+ * Return: True if our outgoing side a bottleneck, false otherwise.
+ */
+bool batadv_v_elp_rx_egress_bad(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	struct batadv_hard_iface *iface = hardif_neigh->if_incoming;
+	struct batadv_priv *bat_priv = netdev_priv(iface->soft_iface);
+	u32 throughput = iface->bat_v.max_throughput_other;
+	u32 limit = iface->bat_v.min_throughput_other;
+
+	throughput = batadv_v_forward_penalty(bat_priv, iface, iface,
+					      throughput);
+
+	return throughput < limit;
+}
+
+/**
+ * batadv_v_elp_tx_ingress_bad - check for ingress TX-metric bottlenecks
+ * @hardif_neigh: the hardif_neigh a packet was received from
+ *
+ * Checks whether we could potentially be a better path for packets
+ * coming from the given hardif_neigh to any neighbor on the same interface.
+ * Or whether there is some bottleneck making us unfavourable to become
+ * a forwarder for packets from this hardif_neigh.
+ *
+ * More specifically, this function checks whether our ingress side, that
+ * is the connection from the given hardif_neigh to us, is worse than the
+ * direct transmission of the hardif_neigh to any other neighbor.
+ *
+ * Return: True if our incoming side a bottleneck, false otherwise.
+ */
+bool batadv_v_elp_tx_ingress_bad(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	struct batadv_hard_iface *iface = hardif_neigh->if_incoming;
+	struct batadv_priv *bat_priv = netdev_priv(iface->soft_iface);
+	u32 throughput = hardif_neigh->bat_v.max_throughput;
+	u32 limit = hardif_neigh->bat_v.min_throughput;
+
+	throughput = batadv_v_forward_penalty(bat_priv, iface, iface,
+					      throughput);
+
+	return throughput < limit;
+}
+
+/**
+ * batadv_v_elp_tx_egress_bad - check for egress TX-metric bottlenecks
+ * @hardif_neigh: the hardif_neigh a packet was received from
+ *
+ * Checks whether we could potentially be a better path for packets
+ * coming from the given hardif_neigh to any neighbor on the same interface.
+ * Or whether there is some bottleneck making us unfavourable to become
+ * a forwarder for packets from this hardif_neigh.
+ *
+ * More specifically, this function checks whether our egress side, that is
+ * the connection from us to any neighbor other than hardif_neigh, is
+ * worse than the direct transmission of the hardif_neigh to any other neighbor.
+ *
+ * Return: True if our outgoing side a bottleneck, false otherwise.
+ */
+bool batadv_v_elp_tx_egress_bad(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	struct batadv_hard_iface *iface = hardif_neigh->if_incoming;
+	struct batadv_priv *bat_priv = netdev_priv(iface->soft_iface);
+	u32 throughput = iface->bat_v.max_throughput;
+	u32 limit = hardif_neigh->bat_v.min_throughput;
+
+	throughput = batadv_v_forward_penalty(bat_priv, iface, iface,
+					      throughput);
+
+	return throughput < limit;
+}
+
+/**
+ * batadv_v_elp_no_broadcast - checks whether a rebroadcast can be avoided
+ * @if_outgoing: the outgoing interface to be considered for rebroadcast
+ * @hardif_neigh: the hardif_neigh the packet came from
+ * @inverse_metric: the metric direction to use (e.g. "true" for OGMs, "false"
+ *  for broadcast packets
+ *
+ * This function checks whether with the information available to/from ELP, a
+ * rebroadcast of an OGM2 or broadcast packet on an interface can be
+ * avoided.
+ *
+ * The inverse_metric parameter indicates whether the considered packet
+ * should follow the best RX (inverse_metric = "true", e.g. OGMs) or TX
+ * path (inverse_metric = "false", e.g. broadcast packets).
+ *
+ * Return: True, if a rebroadcast can be avoided, false otherwise.
+ */
+bool batadv_v_elp_no_broadcast(struct batadv_hard_iface *if_outgoing,
+			       struct batadv_hardif_neigh_node *hardif_neigh,
+			       bool inverse_metric)
+{
+	if (!if_outgoing || !hardif_neigh)
+		return false;
+
+	/* ELP does not provide information across inferface domains */
+	if (if_outgoing != hardif_neigh->if_incoming)
+		return false;
+
+	if (!batadv_v_elp_nhh_cmp(hardif_neigh))
+		return false;
+
+	/* same neighborhood, is a better path possible? */
+	if (inverse_metric) {
+		/* OGM2 check */
+		if (batadv_v_elp_rx_ingress_bad(hardif_neigh) ||
+		    batadv_v_elp_rx_egress_bad(hardif_neigh))
+			return true;
+	} else {
+		/* broadcast packet check */
+		if (batadv_v_elp_tx_ingress_bad(hardif_neigh) ||
+		    batadv_v_elp_tx_egress_bad(hardif_neigh))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * batadv_v_elp_tvlv_handler_nhh - process incoming NHH tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tvlv_value: tvlv buffer containing the neighborhood hash data
+ * @tvlv_value_len: tvlv buffer length
+ * @ctx: handler specific context information (here: hardif_neigh)
+ *
+ * Return: NET_RX_DROP on parsing errors, NET_RX_SUCCESS otherwise.
+ */
+static int batadv_v_elp_tvlv_handler_nhh(struct batadv_priv *bat_priv,
+					 void *tvlv_value, u16 tvlv_value_len,
+					 void *ctx)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct batadv_tvlv_nhh_data *nhh_data;
+	u32 min_throughput = 0;
+	u32 max_throughput = (~(u32)0);
+
+	hardif_neigh = batadv_v_elp_unpack_ctx(ctx);
+	if (WARN_ON(!hardif_neigh))
+		return NET_RX_DROP;
+
+	if (tvlv_value) {
+		if (tvlv_value_len < sizeof(*nhh_data))
+			return NET_RX_DROP;
+
+		nhh_data = (struct batadv_tvlv_nhh_data *)tvlv_value;
+
+		memcpy(hardif_neigh->bat_v.neigh_hash, nhh_data->neigh_hash,
+		       sizeof(hardif_neigh->bat_v.neigh_hash));
+		min_throughput = ntohl(nhh_data->min_throughput);
+		max_throughput = ntohl(nhh_data->max_throughput);
+	} else {
+		memset(hardif_neigh->bat_v.neigh_hash, 0,
+		       sizeof(hardif_neigh->bat_v.neigh_hash));
+	}
+
+	hardif_neigh->bat_v.min_throughput = min_throughput;
+	hardif_neigh->bat_v.max_throughput = max_throughput;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Got neighbor hash on interface %s from %pM: %*phN, min_through: %u kbit/s, max_through: %u kbit/s\n",
+		   hardif_neigh->if_incoming->net_dev->name,
+		   hardif_neigh->addr,
+		   (int)sizeof(hardif_neigh->bat_v.neigh_hash),
+		   hardif_neigh->bat_v.neigh_hash,
+		   hardif_neigh->bat_v.min_throughput * 100,
+		   hardif_neigh->bat_v.max_throughput * 100);
+
+	return NET_RX_SUCCESS;
+}
+
+/**
+ * batadv_v_elp_mesh_init - initialize the ELP private resources for a mesh
+ * @bat_priv: the object representing the mesh interface to initialise
+ *
+ * Return: Always returns 0.
+ */
+int batadv_v_elp_mesh_init(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_handler_register2(bat_priv, batadv_v_elp_tvlv_handler_nhh,
+				      BATADV_ELP, BATADV_TVLV_NHH, 1,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
+
+	return 0;
+}
+
+/**
+ * batadv_v_elp_mesh_free - free the ELP private resources for a mesh
+ * @bat_priv: the object representing the mesh interface to free
+ */
+void batadv_v_elp_mesh_free(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_ELP, BATADV_TVLV_NHH,
+					1);
+}
+
+/**
  * batadv_v_elp_init - initialize global ELP structures
  *
  * Return: A negative value on error, zero on success.
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index ed5936c..7029f5a 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -20,9 +20,13 @@
 
 #include "main.h"
 
+#include <linux/types.h>
+
 struct sk_buff;
 struct work_struct;
 
+int batadv_v_elp_mesh_init(struct batadv_priv *bat_priv);
+void batadv_v_elp_mesh_free(struct batadv_priv *bat_priv);
 int batadv_v_elp_init(void);
 void batadv_v_elp_free(void);
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
@@ -32,6 +36,14 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
+bool batadv_v_elp_nhh_cmp(struct batadv_hardif_neigh_node *hardif_neigh);
+bool batadv_v_elp_rx_ingress_bad(struct batadv_hardif_neigh_node *hardif_neigh);
+bool batadv_v_elp_rx_egress_bad(struct batadv_hardif_neigh_node *hardif_neigh);
+bool batadv_v_elp_tx_ingress_bad(struct batadv_hardif_neigh_node *hardif_neigh);
+bool batadv_v_elp_tx_egress_bad(struct batadv_hardif_neigh_node *hardif_neigh);
+bool batadv_v_elp_no_broadcast(struct batadv_hard_iface *if_outgoing,
+			       struct batadv_hardif_neigh_node *hardif_neigh,
+			       bool inverse_metric);
 void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 606f899..2c1d5b4 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -183,7 +183,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
-		ret = batadv_hardif_no_broadcast(hard_iface, NULL, NULL);
+		ret = batadv_hardif_no_broadcast(hard_iface, NULL, NULL, true);
 		if (ret) {
 			char *type;
 
@@ -197,6 +197,9 @@ static void batadv_v_ogm_send(struct work_struct *work)
 			case BATADV_HARDIF_BCAST_DUPORIG:
 				type = "single neighbor is originator";
 				break;
+			case BATADV_HARDIF_BCAST_WORSENHH:
+				type = "worse neighborhood metric";
+				break;
 			default:
 				type = "unknown";
 			}
@@ -289,10 +292,10 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
  *
  * Return: the penalised throughput metric.
  */
-static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
-				    struct batadv_hard_iface *if_incoming,
-				    struct batadv_hard_iface *if_outgoing,
-				    u32 throughput)
+u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
+			     struct batadv_hard_iface *if_incoming,
+			     struct batadv_hard_iface *if_outgoing,
+			     u32 throughput)
 {
 	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
 	int hop_penalty_max = BATADV_TQ_MAX_VALUE;
@@ -752,7 +755,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 
 		ret = batadv_hardif_no_broadcast(hard_iface,
 						 ogm_packet->orig,
-						 hardif_neigh->orig);
+						 hardif_neigh, true);
 
 		if (ret) {
 			char *type;
@@ -767,6 +770,9 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 			case BATADV_HARDIF_BCAST_DUPORIG:
 				type = "single neighbor is originator";
 				break;
+			case BATADV_HARDIF_BCAST_WORSENHH:
+				type = "worse neighborhood metric";
+				break;
 			default:
 				type = "unknown";
 			}
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 4c4d45c..de01593 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -30,6 +30,10 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface);
 struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 					       const u8 *addr);
 void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface);
+u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
+			     struct batadv_hard_iface *if_incoming,
+			     struct batadv_hard_iface *if_outgoing,
+			     u32 throughput);
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index dc1816e..7037910 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -232,8 +232,9 @@ bool batadv_is_wifi_netdev(struct net_device *net_device)
  * batadv_hardif_no_broadcast - check whether (re)broadcast is necessary
  * @if_outgoing: the outgoing interface checked and considered for (re)broadcast
  * @orig_addr: the originator of this packet
- * @orig_neigh: originator address of the forwarder we just got the packet from
- *  (NULL if we originated)
+ * @hardif_neigh: the neighbor we got this packet from (NULL if we originated)
+ * @inverse_metric: the metric direction to use (e.g. "true" for OGMs, "false"
+ *  for broadcast packets
  *
  * Checks whether a packet needs to be (re)broadcasted on the given interface.
  *
@@ -241,12 +242,16 @@ bool batadv_is_wifi_netdev(struct net_device *net_device)
  *	BATADV_HARDIF_BCAST_NORECIPIENT: No neighbor on interface
  *	BATADV_HARDIF_BCAST_DUPFWD: Just one neighbor, but it is the forwarder
  *	BATADV_HARDIF_BCAST_DUPORIG: Just one neighbor, but it is the originator
+ *	BATADV_HARDIF_BCAST_WORSENHH: ELP detected a worse neighborhood metric
  *	BATADV_HARDIF_BCAST_OK: Several neighbors, must broadcast
  */
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
-			       u8 *orig_addr, u8 *orig_neigh)
+			       u8 *orig_addr,
+			       struct batadv_hardif_neigh_node *hardif_neigh,
+			       bool inverse_metric)
 {
-	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct batadv_priv *bat_priv = netdev_priv(if_outgoing->soft_iface);
+	struct batadv_hardif_neigh_node *hardif_neigh_cmp;
 	struct hlist_node *first;
 	int ret = BATADV_HARDIF_BCAST_OK;
 
@@ -259,22 +264,30 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 		goto out;
 	}
 
-	/* >1 neighbors -> (re)brodcast */
-	if (rcu_dereference(hlist_next_rcu(first)))
-		goto out;
+	/* single neighbor checks */
+	if (!rcu_dereference(hlist_next_rcu(first)) && hardif_neigh) {
+		hardif_neigh_cmp = hlist_entry(first,
+					       struct batadv_hardif_neigh_node,
+					       list);
 
-	hardif_neigh = hlist_entry(first, struct batadv_hardif_neigh_node,
-				   list);
-
-	/* 1 neighbor, is the originator -> no rebroadcast */
-	if (orig_addr && batadv_compare_eth(hardif_neigh->orig, orig_addr)) {
-		ret = BATADV_HARDIF_BCAST_DUPORIG;
-	/* 1 neighbor, is the one we received from -> no rebroadcast */
-	} else if (orig_neigh &&
-		   batadv_compare_eth(hardif_neigh->orig, orig_neigh)) {
-		ret = BATADV_HARDIF_BCAST_DUPFWD;
+		/* 1 neighbor, is the originator -> no rebroadcast */
+		if (batadv_compare_eth(hardif_neigh_cmp->orig, orig_addr)) {
+			ret = BATADV_HARDIF_BCAST_DUPORIG;
+			goto out;
+		/* 1 neighbor, is the one we received from -> no rebroadcast */
+		} else if (batadv_compare_eth(hardif_neigh_cmp->orig,
+					      hardif_neigh->orig)) {
+			ret = BATADV_HARDIF_BCAST_DUPFWD;
+			goto out;
+		}
 	}
 
+	if (bat_priv->algo_ops->neigh.hardif_no_broadcast &&
+	    bat_priv->algo_ops->neigh.hardif_no_broadcast(if_outgoing,
+							  hardif_neigh,
+							  inverse_metric))
+		ret = BATADV_HARDIF_BCAST_WORSENHH;
+
 out:
 	rcu_read_unlock();
 	return ret;
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index a043182..d75b767 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -45,12 +45,14 @@ enum batadv_hard_if_state {
  * @BATADV_HARDIF_BCAST_NORECIPIENT: Broadcast not needed, there is no recipient
  * @BATADV_HARDIF_BCAST_DUPFWD: There is just the neighbor we got it from
  * @BATADV_HARDIF_BCAST_DUPORIG: There is just the originator
+ * @BATADV_HARDIF_BCAST_WORSENHH: ELP detected a worse neighborhood metric
  */
 enum batadv_hard_if_bcast {
 	BATADV_HARDIF_BCAST_OK = 0,
 	BATADV_HARDIF_BCAST_NORECIPIENT,
 	BATADV_HARDIF_BCAST_DUPFWD,
 	BATADV_HARDIF_BCAST_DUPORIG,
+	BATADV_HARDIF_BCAST_WORSENHH,
 };
 
 /**
@@ -78,7 +80,9 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_release(struct kref *ref);
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
-			       u8 *orig_addr, u8 *orig_neigh);
+			       u8 *orig_addr,
+			       struct batadv_hardif_neigh_node *hardif_neigh,
+			       bool inverse_metric);
 
 /**
  * batadv_hardif_put - decrement the hard interface refcounter and possibly
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 041de77..56bf8eb 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -788,7 +788,6 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	u8 *neigh_addr;
-	u8 *orig_neigh;
 	unsigned long send_time = jiffies + msecs_to_jiffies(5);
 	int ret = 0;
 
@@ -823,10 +822,8 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 							     neigh_addr);
 		}
 
-		orig_neigh = neigh_node ? neigh_node->orig : NULL;
-
 		ret = batadv_hardif_no_broadcast(hard_iface, bcast_packet->orig,
-						 orig_neigh);
+						 neigh_node, false);
 
 		if (ret) {
 			char *type;
@@ -841,6 +838,9 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 			case BATADV_HARDIF_BCAST_DUPORIG:
 				type = "single neighbor is originator";
 				break;
+			case BATADV_HARDIF_BCAST_WORSENHH:
+				type = "worse neighborhood metric";
+				break;
 			default:
 				type = "unknown";
 			}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6a71522..2f35a97 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -111,6 +111,8 @@ enum batadv_v_hard_iface_flags {
  * @flags: interface specific flags
  * @min_throughput: worst of all TX throughputs this neighbor has to others
  * @max_throughput: best of all TX throughputs this neighbor has to others
+ * @min_throughput_other: worst of all min_throughput's of other neighbors
+ * @max_throughput_other: worst of all max_throughput's of other neighbors
  * @neigh_hash: a sha512 hash of all neighbors this neighbor sees
  *  (hash over the alphabetically ordered, concatenated, binary representation)
  */
@@ -123,6 +125,8 @@ struct batadv_hard_iface_bat_v {
 	u8 flags;
 	u32 min_throughput;
 	u32 max_throughput;
+	u32 min_throughput_other;
+	u32 max_throughput_other;
 	u8 neigh_hash[SHA512_DIGEST_SIZE];
 };
 
@@ -401,6 +405,10 @@ DECLARE_EWMA(throughput, 1024, 8)
  * @throughput: ewma link throughput towards this neighbor
  * @elp_interval: time interval between two ELP transmissions
  * @elp_latest_seqno: latest and best known ELP sequence number
+ * @min_throughput: worst of all TX throughputs this neighbor has to others
+ * @max_throughput: best of all TX throughputs this neighbor has to others
+ * @neigh_hash: a sha512 hash of all neighbors this neighbor sees
+ *  (hash over the alphabetically ordered, concatenated, binary representation)
  * @last_unicast_tx: when the last unicast packet has been sent to this neighbor
  * @metric_work: work queue callback item for metric update
  */
@@ -408,6 +416,9 @@ struct batadv_hardif_neigh_node_bat_v {
 	struct ewma_throughput throughput;
 	u32 elp_interval;
 	u32 elp_latest_seqno;
+	u32 min_throughput;
+	u32 max_throughput;
+	u8 neigh_hash[SHA512_DIGEST_SIZE];
 	unsigned long last_unicast_tx;
 	struct work_struct metric_work;
 };
@@ -1426,6 +1437,8 @@ struct batadv_algo_iface_ops {
  * struct batadv_algo_neigh_ops - mesh algorithm callbacks (neighbour specific)
  * @hardif_init: called on creation of single hop entry
  *  (optional)
+ * @hardif_no_broadcast: algorithm specific check(s) regarding rebroadcasts
+ *  (optional)
  * @cmp: compare the metrics of two neighbors for their respective outgoing
  *  interfaces
  * @is_similar_or_better: check if neigh1 is equally similar or better than
@@ -1435,6 +1448,10 @@ struct batadv_algo_iface_ops {
  */
 struct batadv_algo_neigh_ops {
 	void (*hardif_init)(struct batadv_hardif_neigh_node *neigh);
+	bool (*hardif_no_broadcast)
+		  (struct batadv_hard_iface *if_outgoing,
+		   struct batadv_hardif_neigh_node *hardif_neigh,
+		   bool inverse_metric);
 	int (*cmp)(struct batadv_neigh_node *neigh1,
 		   struct batadv_hard_iface *if_outgoing1,
 		   struct batadv_neigh_node *neigh2,
-- 
2.1.4

