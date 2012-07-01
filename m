Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 01:43:33 +0200
Message-Id: <1341186226-10549-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1341186226-10549-1-git-send-email-ordex@autistici.org>
References: <1341186226-10549-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: Prefix types enum with
	BATADV_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c        |    8 ++++----
 net/batman-adv/routing.c           |   10 +++++-----
 net/batman-adv/soft-interface.c    |    8 ++++----
 net/batman-adv/translation-table.c |    8 ++++----
 net/batman-adv/types.h             |   28 ++++++++++++++--------------
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a59e317..6099719 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -209,8 +209,8 @@ static void batadv_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 	/* create clone because function is called more than once */
 	skb = skb_clone(forw_packet->skb, GFP_ATOMIC);
 	if (skb) {
-		batadv_inc_counter(bat_priv, BAT_CNT_MGMT_TX);
-		batadv_add_counter(bat_priv, BAT_CNT_MGMT_TX_BYTES,
+		batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
+		batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
 				   skb->len + ETH_HLEN);
 		batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
 	}
@@ -1256,8 +1256,8 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	if (bat_priv->bat_algo_ops->bat_ogm_emit != batadv_iv_ogm_emit)
 		return NET_RX_DROP;
 
-	batadv_inc_counter(bat_priv, BAT_CNT_MGMT_RX);
-	batadv_add_counter(bat_priv, BAT_CNT_MGMT_RX_BYTES,
+	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_RX_BYTES,
 			   skb->len + ETH_HLEN);
 
 	packet_len = skb_headlen(skb);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 4d63221..aa8325e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -607,7 +607,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	switch (tt_query->flags & BATADV_TT_QUERY_TYPE_MASK) {
 	case TT_REQUEST:
-		batadv_inc_counter(bat_priv, BAT_CNT_TT_REQUEST_RX);
+		batadv_inc_counter(bat_priv, BATADV_CNT_TT_REQUEST_RX);
 
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded
@@ -622,7 +622,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	case TT_RESPONSE:
-		batadv_inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_RX);
+		batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_RX);
 
 		if (batadv_is_my_mac(tt_query->dst)) {
 			/* packet needs to be linearized to access the TT
@@ -678,7 +678,7 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (is_broadcast_ether_addr(ethhdr->h_source))
 		goto out;
 
-	batadv_inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_RX);
+	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_RX);
 
 	roam_adv_packet = (struct roam_adv_packet *)skb->data;
 
@@ -900,8 +900,8 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	unicast_packet->header.ttl--;
 
 	/* Update stats counter */
-	batadv_inc_counter(bat_priv, BAT_CNT_FORWARD);
-	batadv_add_counter(bat_priv, BAT_CNT_FORWARD_BYTES,
+	batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
+	batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
 			   skb->len + ETH_HLEN);
 
 	/* route it */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index b77e598..19a80d2 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -366,6 +366,7 @@ struct net_device *batadv_softif_create(const char *name)
 	struct net_device *soft_iface;
 	struct bat_priv *bat_priv;
 	int ret;
+	size_t cnt_len = sizeof(uint64_t) * BATADV_CNT_NUM;
 
 	soft_iface = alloc_netdev(sizeof(*bat_priv), name,
 				  batadv_interface_setup);
@@ -411,8 +412,7 @@ struct net_device *batadv_softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
-	bat_priv->bat_counters = __alloc_percpu(sizeof(uint64_t) * BAT_CNT_NUM,
-						__alignof__(uint64_t));
+	bat_priv->bat_counters = __alloc_percpu(cnt_len, __alignof__(uint64_t));
 	if (!bat_priv->bat_counters)
 		goto unreg_soft_iface;
 
@@ -542,14 +542,14 @@ static void batadv_get_ethtool_stats(struct net_device *dev,
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	int i;
 
-	for (i = 0; i < BAT_CNT_NUM; i++)
+	for (i = 0; i < BATADV_CNT_NUM; i++)
 		data[i] = batadv_sum_counter(bat_priv, i);
 }
 
 static int batadv_get_sset_count(struct net_device *dev, int stringset)
 {
 	if (stringset == ETH_SS_STATS)
-		return BAT_CNT_NUM;
+		return BATADV_CNT_NUM;
 
 	return -EOPNOTSUPP;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 156c309..f36d1d5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1471,7 +1471,7 @@ static int batadv_send_tt_request(struct bat_priv *bat_priv,
 		   dst_orig_node->orig, neigh_node->addr,
 		   (full_table ? 'F' : '.'));
 
-	batadv_inc_counter(bat_priv, BAT_CNT_TT_REQUEST_TX);
+	batadv_inc_counter(bat_priv, BATADV_CNT_TT_REQUEST_TX);
 
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
@@ -1599,7 +1599,7 @@ static bool batadv_send_other_tt_response(struct bat_priv *bat_priv,
 		   res_dst_orig_node->orig, neigh_node->addr,
 		   req_dst_orig_node->orig, req_ttvn);
 
-	batadv_inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
+	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
@@ -1720,7 +1720,7 @@ static bool batadv_send_my_tt_response(struct bat_priv *bat_priv,
 		   orig_node->orig, neigh_node->addr,
 		   (tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
 
-	batadv_inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
+	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
@@ -2038,7 +2038,7 @@ static void batadv_send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		   "Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
 		   orig_node->orig, client, neigh_node->addr);
 
-	batadv_inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_TX);
+	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_TX);
 
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fd538ea..fcbac82 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -143,20 +143,20 @@ struct bcast_duplist_entry {
 };
 #endif
 
-enum bat_counters {
-	BAT_CNT_FORWARD,
-	BAT_CNT_FORWARD_BYTES,
-	BAT_CNT_MGMT_TX,
-	BAT_CNT_MGMT_TX_BYTES,
-	BAT_CNT_MGMT_RX,
-	BAT_CNT_MGMT_RX_BYTES,
-	BAT_CNT_TT_REQUEST_TX,
-	BAT_CNT_TT_REQUEST_RX,
-	BAT_CNT_TT_RESPONSE_TX,
-	BAT_CNT_TT_RESPONSE_RX,
-	BAT_CNT_TT_ROAM_ADV_TX,
-	BAT_CNT_TT_ROAM_ADV_RX,
-	BAT_CNT_NUM,
+enum batadv_counters {
+	BATADV_CNT_FORWARD,
+	BATADV_CNT_FORWARD_BYTES,
+	BATADV_CNT_MGMT_TX,
+	BATADV_CNT_MGMT_TX_BYTES,
+	BATADV_CNT_MGMT_RX,
+	BATADV_CNT_MGMT_RX_BYTES,
+	BATADV_CNT_TT_REQUEST_TX,
+	BATADV_CNT_TT_REQUEST_RX,
+	BATADV_CNT_TT_RESPONSE_TX,
+	BATADV_CNT_TT_RESPONSE_RX,
+	BATADV_CNT_TT_ROAM_ADV_TX,
+	BATADV_CNT_TT_ROAM_ADV_RX,
+	BATADV_CNT_NUM,
 };
 
 struct bat_priv {
-- 
1.7.9.4

