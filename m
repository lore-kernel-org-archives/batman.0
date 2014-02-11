Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:08 +0100
Message-Id: <1392122903-805-9-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 08/23] batman-adv: OGMv2 - implement
	originators logic
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

Add the support for recognising new originators in the
network and rebroadcast their OGMs.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_elp.c |   7 +-
 bat_v_ogm.c | 422 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 414 insertions(+), 15 deletions(-)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index 1c23951..f9a6bfe 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -63,7 +63,7 @@ void batadv_elp_neigh_node_free_ref(struct batadv_elp_neigh_node *neigh)
  */
 static struct batadv_elp_neigh_node *
 batadv_v_elp_neigh_new(struct batadv_hard_iface *hard_iface,
-		       uint8_t *neigh_addr, uint8_t *orig_addr, uint32_t seqno)
+		       uint8_t *neigh_addr, uint8_t *orig_addr)
 {
 	struct batadv_elp_neigh_node *neigh;
 
@@ -73,7 +73,6 @@ batadv_v_elp_neigh_new(struct batadv_hard_iface *hard_iface,
 
 	memcpy(neigh->orig, orig_addr, ETH_ALEN);
 	memcpy(neigh->addr, neigh_addr, ETH_ALEN);
-	neigh->last_recv_seqno = seqno - 1;
 	neigh->last_seen = jiffies;
 	ewma_init(&neigh->metric, 1024, 8);
 	/* recount initialised to 2 to simplify the caller function */
@@ -326,13 +325,13 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	neigh = batadv_v_elp_neigh_get(if_incoming, neigh_addr);
 	if (!neigh) {
 		neigh = batadv_v_elp_neigh_new(if_incoming, neigh_addr,
-					       elp_packet->orig,
-					       ntohl(elp_packet->seqno));
+					       elp_packet->orig);
 		if (!neigh)
 			goto out;
 	}
 
 	neigh->last_seen = jiffies;
+	neigh->last_recv_seqno = ntohl(elp_packet->seqno);
 
 out:
 	if (neigh)
diff --git a/bat_v_ogm.c b/bat_v_ogm.c
index f66dc02..4981d7c 100644
--- a/bat_v_ogm.c
+++ b/bat_v_ogm.c
@@ -21,6 +21,7 @@
 
 #include "main.h"
 
+#include "bat_v_elp.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "originator.h"
@@ -28,6 +29,78 @@
 #include "send.h"
 #include "translation-table.h"
 
+static struct batadv_orig_node *
+batadv_v_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
+{
+	struct batadv_orig_node *orig_node;
+	int hash_added;
+
+	orig_node = batadv_orig_hash_find(bat_priv, addr);
+	if (orig_node)
+		return orig_node;
+
+	orig_node = batadv_orig_node_new(bat_priv, addr);
+
+	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
+				     batadv_choose_orig, orig_node,
+				     &orig_node->hash_entry);
+	if (hash_added != 0) {
+		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
+		orig_node = NULL;
+	}
+
+	return orig_node;
+}
+
+static struct batadv_neigh_node *
+batadv_v_ogm_neigh_new(struct batadv_priv *bat_priv,
+		       struct batadv_hard_iface *hard_iface,
+		       uint8_t *addr,
+		       struct batadv_orig_node *orig_node,
+		       struct batadv_orig_node *orig_neigh)
+{
+	struct batadv_neigh_node *neigh_node, *tmp_neigh_node;
+	struct batadv_elp_neigh_node *elp_neigh;
+
+	neigh_node = batadv_neigh_node_new(hard_iface, addr, orig_neigh);
+	if (!neigh_node)
+		return NULL;
+
+	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+		kfree(neigh_node);
+		return NULL;
+	}
+
+	elp_neigh = batadv_v_elp_neigh_get(hard_iface, addr);
+	if (!elp_neigh) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "No ELP object for this neighbor!\n");
+		return NULL;
+	}
+
+	neigh_node->bat_v.elp_neigh = elp_neigh;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	tmp_neigh_node = batadv_neigh_node_get(orig_node, hard_iface, addr);
+	if (!tmp_neigh_node) {
+		hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	} else {
+		kfree(neigh_node);
+		batadv_hardif_free_ref(hard_iface);
+		batadv_elp_neigh_node_free_ref(elp_neigh);
+		neigh_node = tmp_neigh_node;
+	}
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	if (!tmp_neigh_node)
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
+			   addr, orig_node->orig, hard_iface->net_dev->name);
+
+	return neigh_node;
+}
+
 static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 {
 	unsigned long msecs;
@@ -48,20 +121,15 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct sk_buff *tmp_skb;
 
 	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		return;
 
-	tmp_skb = skb_clone(skb, GFP_ATOMIC);
-	if (!tmp_skb)
-		return;
-
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
-			   tmp_skb->len + ETH_HLEN);
+			   skb->len + ETH_HLEN);
 
-	batadv_send_skb_packet(tmp_skb, hard_iface, batadv_broadcast_addr);
+	batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
 }
 
 static void batadv_v_ogm_send(struct work_struct *work)
@@ -70,7 +138,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	struct batadv_priv_bat_v *bat_v;
 	struct batadv_priv *bat_priv;
 	struct batadv_ogm2_packet *ogm2;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *tmp_skb;
 	unsigned char *ogm_buff, *pkt_buff;
 	int ogm_buff_len;
 	uint16_t tvlv_len = 0;
@@ -119,7 +187,12 @@ static void batadv_v_ogm_send(struct work_struct *work)
 			   ogm2->ttl, hard_iface->net_dev->name,
 			   hard_iface->net_dev->dev_addr);
 
-		batadv_v_ogm_send_to_if(skb, hard_iface);
+		/* this skb gets consumed by batadv_v_ogm_send_to_if() */
+		tmp_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!tmp_skb)
+			break;
+
+		batadv_v_ogm_send_to_if(tmp_skb, hard_iface);
 	}
 	rcu_read_unlock();
 
@@ -162,11 +235,259 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	rcu_read_unlock();
 }
 
+static void
+batadv_v_ogm_orig_update(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node,
+			 struct batadv_neigh_node *neigh_node,
+			 const struct batadv_ogm2_packet *ogm2,
+			 struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL, *neigh_ifinfo = NULL;
+	struct batadv_neigh_node *router = NULL;
+	struct batadv_orig_ifinfo *orig_ifinfo;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "update_originator(): Searching and updating originator entry of received packet\n");
+
+	/* get the TVLV container and process it */
+	batadv_tvlv_containers_process(bat_priv, true, orig_node, NULL, NULL,
+				       (unsigned char *)(ogm2 + 1),
+				       ntohs(ogm2->tvlv_len));
+
+	orig_node->last_seen = jiffies;
+
+	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
+	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
+	orig_ifinfo->last_ttl = ogm2->ttl;
+	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+
+	/* if this neighbor already is our next hop there is nothing
+	 * to change
+	 */
+	router = batadv_orig_router_get(orig_node, if_outgoing);
+	if (router == neigh_node)
+		goto out;
+
+	/* don't consider neighbours with worse metric */
+	if (router) {
+		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
+		neigh_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+		if (router_ifinfo && neigh_ifinfo &&
+		    router_ifinfo->bat_v.metric >= neigh_ifinfo->bat_v.metric)
+			goto out;
+	}
+
+	batadv_update_route(bat_priv, orig_node, if_outgoing, neigh_node);
+
+out:
+	if (router_ifinfo)
+		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+	if (neigh_ifinfo)
+		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+	if (router)
+		batadv_neigh_node_free_ref(router);
+}
+
+/**
+ * batadv_v_penalty - apply a penalty to the metric forwarded by the OGM
+ * @bat_priv: the bat priv with all the soft interface information
+ * @metric: the current metric value
+ * @link_metric: the metric of the last link traversed by the OGM
+ * @if_incoming: the interface where the OGM has been received
+ *
+ * Apply a penalty on the current metric value based on the characteristic of
+ * the interface where the OGM has been received. The return value is computed
+ * as follows:
+ * - metric * 50% if the incoming interface is wireless and the metric is not
+ *   less than 10% of the link throughput
+ * - metric * (100 - hop_penalty)% otherwise
+ *
+ * Return the penalised metric value
+ */
+static uint32_t batadv_v_penalty(struct batadv_priv *bat_priv,
+				 uint32_t metric, uint32_t link_metric,
+				 struct batadv_hard_iface *if_incoming)
+{
+	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
+
+	/* proportion to use the same value used in batman iv (x * 128 / 256) */
+	hop_penalty = hop_penalty * 100 / 255;
+
+	if (batadv_is_wifi_netdev(if_incoming->net_dev) &&
+	    metric > link_metric / 10)
+		return metric / 2;
+
+	return metric * (100 - hop_penalty) / 100;
+}
+
+static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
+				 const struct batadv_ogm2_packet *ogm2,
+				 struct batadv_neigh_node *neigh_node,
+				 struct batadv_hard_iface *if_incoming,
+				 struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_ogm2_packet *ogm_new;
+	uint32_t link_metric, new_metric;
+	unsigned char *skb_buff;
+	struct sk_buff *skb;
+	uint16_t tvlv_len;
+	size_t packet_len;
+
+	if (ogm2->ttl <= 1) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "ttl exceeded\n");
+		return;
+	}
+
+	tvlv_len = ntohs(ogm2->tvlv_len);
+
+	packet_len = BATADV_OGM2_HLEN + tvlv_len;
+	skb = netdev_alloc_skb_ip_align(if_outgoing->net_dev,
+					ETH_HLEN + packet_len);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, ETH_HLEN);
+	skb_buff = skb_put(skb, packet_len);
+	memcpy(skb_buff, ogm2, packet_len);
+
+	/* apply hop penalty */
+	ogm_new = (struct batadv_ogm2_packet *)skb_buff;
+	link_metric = ewma_read(&neigh_node->bat_v.elp_neigh->metric);
+	new_metric = batadv_v_penalty(bat_priv, ntohl(ogm_new->metric),
+				      link_metric, if_incoming);
+	ogm_new->metric = htonl(new_metric);
+	ogm_new->ttl--;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Forwarding OGM2 packet on %s: metric %u, ttl %u\n",
+		   if_outgoing->net_dev->name, new_metric, ogm_new->ttl);
+
+	batadv_v_ogm_send_to_if(skb, if_outgoing);
+}
+
+/**
+ * batadv_v_ogm_process_per_outif - process a batman iv OGM for an outgoing if
+ * @skb: the skb containing the OGM
+ * @if_incoming: the interface where this packet was received
+ * @if_outgoing: the interface for which the packet should be considered
+ */
+static void
+batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
+			       const struct ethhdr *ethhdr,
+			       const struct batadv_ogm2_packet *ogm2,
+			       struct batadv_orig_node *orig_node,
+			       struct batadv_neigh_node *neigh_node,
+			       struct batadv_hard_iface *if_incoming,
+			       struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL, *router_ifinfo = NULL;
+	struct batadv_neigh_node *orig_neigh_router = NULL;
+	struct batadv_neigh_node *router = NULL, *router_router = NULL;
+	struct batadv_orig_node *orig_neigh_node;
+	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
+	bool is_from_best_next_hop = false;
+	uint32_t new_metric;
+	int32_t seq_diff;
+
+	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
+	seq_diff = ntohl(ogm2->seqno) - orig_ifinfo->last_real_seqno;
+	if (!hlist_empty(&orig_node->neigh_list) &&
+	    batadv_window_protected(bat_priv, seq_diff,
+				    &orig_ifinfo->batman_seqno_reset)) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: packet within window protection time from %pM\n",
+			   ogm2->orig);
+		goto out;
+	}
+
+	new_metric = ntohl(ogm2->metric);
+	neigh_ifinfo = batadv_neigh_ifinfo_new(neigh_node, if_outgoing);
+	if (seq_diff > 0 || new_metric > neigh_ifinfo->bat_v.metric) {
+		neigh_ifinfo->bat_v.metric = new_metric;
+		neigh_ifinfo->last_ttl = ogm2->ttl;
+	}
+
+	router = batadv_orig_router_get(orig_node, if_outgoing);
+	if (router) {
+		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
+		if (router_ifinfo && (router_ifinfo->bat_v.metric != 0) &&
+		    (batadv_compare_eth(router->addr, ethhdr->h_source)))
+			is_from_best_next_hop = true;
+	}
+
+	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
+
+	/* if sender is a direct neighbor the sender mac equals
+	 * originator mac
+	 */
+	if (router && router->orig_node == orig_node)
+		orig_neigh_node = orig_node;
+	else
+		orig_neigh_node = batadv_v_ogm_orig_get(bat_priv,
+							ethhdr->h_source);
+
+	if (!orig_neigh_node)
+		goto out;
+
+	orig_neigh_router = batadv_orig_router_get(orig_neigh_node,
+						   if_outgoing);
+
+	/* drop packet if sender is not a direct neighbor and if we
+	 * don't route towards it
+	 */
+	if (router && router->orig_node != orig_node &&
+	    (!orig_neigh_router)) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: OGM via unknown neighbor!\n");
+		goto out_neigh;
+	}
+
+	/* if there is a router and the sequence number is the same as the last
+	 * received from it, but the metric is worse, then drop the packet
+	 */
+	if (router && seq_diff == 0 && new_metric < router_ifinfo->bat_v.metric)
+		goto out_neigh;
+
+	batadv_v_ogm_orig_update(bat_priv, orig_node, neigh_node, ogm2,
+				 if_outgoing);
+
+	/* strict rule: forward packets coming from the best next hop only */
+	if (router && !is_from_best_next_hop)
+		goto out_neigh;
+
+	/* only forward for specific interface, not for the default one. */
+	if (if_outgoing != BATADV_IF_DEFAULT)
+		batadv_v_ogm_forward(bat_priv, ogm2, neigh_node, if_incoming,
+				     if_outgoing);
+
+out_neigh:
+	if (orig_neigh_node != orig_node && orig_neigh_node)
+		batadv_orig_node_free_ref(orig_neigh_node);
+out:
+	if (orig_ifinfo)
+		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	if (router)
+		batadv_neigh_node_free_ref(router);
+	if (router_ifinfo)
+		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+	if (router_router)
+		batadv_neigh_node_free_ref(router_router);
+	if (orig_neigh_router)
+		batadv_neigh_node_free_ref(orig_neigh_router);
+	if (neigh_ifinfo)
+		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+}
+
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			      struct batadv_hard_iface *if_incoming)
 {	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct batadv_orig_node *orig_node, *orig_neigh;
+	uint32_t ogm_metric, link_metric, new_metric;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm2;
+	int ret = NET_RX_DROP;
 
 	/* did we receive a OGM2 packet on an interface that does not have
 	 * B.A.T.M.A.N. V enabled ?
@@ -189,8 +510,87 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_RX_BYTES,
 			   skb->len + ETH_HLEN);
 
+	ogm_metric = ntohl(ogm2->metric);
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Received OGM2 packet via NB: %pM, IF: %s [%pM] (from OG: %pM, seqno %u, metric %u, TTL %u, V %u, tvlv_len %u)\n",
+		   ethhdr->h_source, if_incoming->net_dev->name,
+		   if_incoming->net_dev->dev_addr, ogm2->orig,
+		   ntohl(ogm2->seqno), ogm_metric, ogm2->ttl,
+		   ogm2->version, ntohs(ogm2->tvlv_len));
+
+	/* if the metric is 0, immediately drop the packet. no need to create
+	 * orig_node/neigh_node for a not usable route
+	 */
+	if (ogm_metric == 0) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: originator packet with metric equal 0\n");
+		return NET_RX_DROP;
+	}
+
+	orig_node = batadv_v_ogm_orig_get(bat_priv, ogm2->orig);
+	if (!orig_node)
+		return NET_RX_DROP;
+
+	orig_neigh = batadv_v_ogm_orig_get(bat_priv, ethhdr->h_source);
+	if (!orig_neigh)
+		goto out;
+
+	neigh_node = batadv_v_ogm_neigh_new(bat_priv, if_incoming,
+					    ethhdr->h_source, orig_node,
+					    orig_neigh);
+	if (!neigh_node) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Could not create neigh node!\n");
+		goto out;
+	}
+
+	/* update the neigh_node information */
+	neigh_node->last_seen = jiffies;
+
+	/* update the received metric to match the node topology: if this node
+	 * is the first hop traversed by the OGM, then the metric is substituted
+	 * with the value of the traversed link. Otherwise the metric is
+	 * computed as the minimum between the metric of the traversed link and
+	 * the value contained in the OGM
+	 */
+	link_metric = ewma_read(&neigh_node->bat_v.elp_neigh->metric);
+	if (ogm_metric == BATADV_MAX_METRIC)
+		new_metric = link_metric;
+	else
+		new_metric = min_t(uint32_t, link_metric, ogm_metric);
+	ogm2->metric = htonl(new_metric);
+
+	batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm2, orig_node,
+				       neigh_node, if_incoming,
+				       BATADV_IF_DEFAULT);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm2,
+					       orig_node, neigh_node,
+					       if_incoming, hard_iface);
+	}
+	rcu_read_unlock();
+
+	ret = NET_RX_SUCCESS;
 	consume_skb(skb);
-	return NET_RX_SUCCESS;
+
+out:
+	if (orig_node)
+		batadv_orig_node_free_ref(orig_node);
+	if (orig_neigh)
+		batadv_orig_node_free_ref(orig_neigh);
+	if (neigh_node)
+		batadv_neigh_node_free_ref(neigh_node);
+
+	return ret;
 }
 
 int batadv_v_ogm_init(struct batadv_priv *bat_priv)
-- 
1.8.5.3

