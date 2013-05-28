Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:48 +0200
Message-Id: <1369779649-2537-10-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 08/10] batman-adv: adapt the gateway feature to
	use the new API functions
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

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 gateway_client.c | 74 +++++++++++++++++++++++++++++++-------------------------
 main.h           |  1 +
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 69488b2..0a9f1d0 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -113,13 +113,13 @@ void batadv_gw_deselect(struct batadv_priv *bat_priv)
 static struct batadv_gw_node *
 batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
-	struct batadv_neigh_node *router;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
-	uint32_t gw_divisor;
-	uint8_t max_tq = 0;
-	uint8_t tq_avg;
 	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *router;
+	uint32_t metric, max_metric = 0;
+	uint32_t gw_divisor;
 
 	gw_divisor = BATADV_TQ_LOCAL_WINDOW_SIZE * BATADV_TQ_LOCAL_WINDOW_SIZE;
 	gw_divisor *= 64;
@@ -137,18 +137,19 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (!atomic_inc_not_zero(&gw_node->refcount))
 			goto next;
 
-		tq_avg = router->bat_iv.tq_avg;
+		metric = bao->bat_metric_get(router);
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
-			tmp_gw_factor = tq_avg * tq_avg;
+			tmp_gw_factor = metric * metric;
 			tmp_gw_factor *= gw_node->bandwidth_down;
 			tmp_gw_factor *= 100 * 100;
 			tmp_gw_factor /= gw_divisor;
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-			     (tq_avg > max_tq))) {
+			     (bao->bat_metric_compare(metric,
+						      max_metric) > 0))) {
 				if (curr_gw)
 					batadv_gw_node_free_ref(curr_gw);
 				curr_gw = gw_node;
@@ -163,7 +164,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			  *     soon as a better gateway appears which has
 			  *     $routing_class more tq points)
 			  */
-			if (tq_avg > max_tq) {
+			if (bao->bat_metric_compare(metric, max_metric) > 0) {
 				if (curr_gw)
 					batadv_gw_node_free_ref(curr_gw);
 				curr_gw = gw_node;
@@ -172,8 +173,8 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		if (tq_avg > max_tq)
-			max_tq = tq_avg;
+		if (bao->bat_metric_compare(metric, max_metric) > 0)
+			max_metric = metric;
 
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
@@ -229,22 +230,24 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 				    NULL);
 	} else if ((!curr_gw) && (next_gw)) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Adding route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)\n",
+			   "Adding route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, metric: %u)\n",
 			   next_gw->orig_node->orig,
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
+			   next_gw->bandwidth_up % 10,
+			   bat_priv->bat_algo_ops->bat_metric_get(router));
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)\n",
+			   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, metric: %u)\n",
 			   next_gw->orig_node->orig,
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
+			   next_gw->bandwidth_up % 10,
+			   bat_priv->bat_algo_ops->bat_metric_get(router));
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
 				    gw_addr);
 	}
@@ -263,9 +266,10 @@ out:
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
 			      struct batadv_orig_node *orig_node)
 {
-	struct batadv_orig_node *curr_gw_orig;
 	struct batadv_neigh_node *router_gw = NULL, *router_orig = NULL;
-	uint8_t gw_tq_avg, orig_tq_avg;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_orig_node *curr_gw_orig;
+	uint16_t gw_metric, orig_metric;
 
 	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
 	if (!curr_gw_orig)
@@ -283,23 +287,25 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!router_orig)
 		goto out;
 
-	gw_tq_avg = router_gw->bat_iv.tq_avg;
-	orig_tq_avg = router_orig->bat_iv.tq_avg;
+	gw_metric = bao->bat_metric_get(router_gw);
+	orig_metric = bao->bat_metric_get(router_orig);
 
-	/* the TQ value has to be better */
-	if (orig_tq_avg < gw_tq_avg)
+	/* the metric has to be better */
+	if (bao->bat_metric_compare(orig_metric, gw_metric) > 0)
 		goto out;
 
 	/* if the routing class is greater than 3 the value tells us how much
-	 * greater the TQ value of the new gateway must be
+	 * greater the metric of the new gateway must be.
+	 *
+	 * FIXME: This comparison is strictly TQ related.
 	 */
 	if ((atomic_read(&bat_priv->gw_sel_class) > 3) &&
-	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
+	    (orig_metric - gw_metric < atomic_read(&bat_priv->gw_sel_class)))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i)\n",
-		   gw_tq_avg, orig_tq_avg);
+		   "Restarting gateway selection: better gateway found (metric curr: %u, metric new: %u)\n",
+		   gw_metric, orig_metric);
 
 deselect:
 	batadv_gw_deselect(bat_priv);
@@ -503,11 +509,11 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %u.%u/%u.%u MBit\n",
+	ret = seq_printf(seq, "%s %pM (%10u) %pM [%10s]: %u.%u/%u.%u MBit\n",
 			 (curr_gw == gw_node ? "=>" : "  "),
 			 gw_node->orig_node->orig,
-			 router->bat_iv.tq_avg, router->addr,
-			 router->if_incoming->net_dev->name,
+			 bat_priv->bat_algo_ops->bat_metric_get(router),
+			 router->addr, router->if_incoming->net_dev->name,
 			 gw_node->bandwidth_down / 10,
 			 gw_node->bandwidth_down % 10,
 			 gw_node->bandwidth_up / 10,
@@ -533,8 +539,8 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq,
-		   "      %-12s (%s/%i) %17s [%10s]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
-		   "Gateway", "#", BATADV_TQ_MAX_VALUE, "Nexthop", "outgoingIF",
+		   "      %-12s (%-4s) %17s [%10s]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
+		   "Gateway", "#", "Nexthop", "outgoingIF",
 		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name);
 
@@ -707,12 +713,13 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, struct ethhdr *ethhdr)
 {
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_gw_node *gw_node = NULL, *curr_gw = NULL;
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
-	uint8_t curr_tq_avg;
+	uint32_t curr_metric;
 	unsigned short vid;
 
 	vid = batadv_get_vid(skb, 0);
@@ -739,7 +746,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
 		 */
-		curr_tq_avg = BATADV_TQ_MAX_VALUE;
+		curr_metric = BATADV_MAX_METRIC;
 		break;
 	case BATADV_GW_MODE_CLIENT:
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -759,7 +766,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		if (!neigh_curr)
 			goto out;
 
-		curr_tq_avg = neigh_curr->bat_iv.tq_avg;
+		curr_metric = bao->bat_metric_get(neigh_curr);
 		break;
 	case BATADV_GW_MODE_OFF:
 	default:
@@ -770,7 +777,8 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	if (!neigh_old)
 		goto out;
 
-	if (curr_tq_avg - neigh_old->bat_iv.tq_avg > BATADV_GW_THRESHOLD)
+	if (bao->bat_metric_is_similar(bao->bat_metric_get(neigh_old),
+				       curr_metric))
 		out_of_range = true;
 
 out:
diff --git a/main.h b/main.h
index 1d3611f..8d69641 100644
--- a/main.h
+++ b/main.h
@@ -31,6 +31,7 @@
 
 /* B.A.T.M.A.N. parameters */
 
+#define BATADV_MAX_METRIC 0xffffffff
 #define BATADV_TQ_MAX_VALUE 255
 #define BATADV_JITTER 20
 
-- 
1.8.1.5

