Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  1 Mar 2012 15:35:18 +0800
Message-Id: <1330587321-12177-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: register batman ogm receive
	function during protocol init
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

The B.A.T.M.A.N. IV OGM receive function still was hard-coded although
it is a routing protocol specific function. This patch takes advantage
of the dynamic packet handler registration to remove the hard-coded
function calls.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 main.c       |    5 +----
 routing.c    |   33 ---------------------------------
 routing.h    |    1 -
 types.h      |    3 ---
 5 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index aba0204..5833a3e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1166,8 +1166,8 @@ out:
 	orig_node_free_ref(orig_node);
 }
 
-static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
-			       struct sk_buff *skb)
+static void _bat_iv_ogm_receive(struct sk_buff *skb,
+				struct hard_iface *if_incoming)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 	struct ethhdr *ethhdr;
@@ -1200,6 +1200,39 @@ static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
 					batman_ogm_packet->tt_num_changes));
 }
 
+static int bat_iv_ogm_receive(struct sk_buff *skb,
+			      struct hard_iface *hard_iface)
+{
+	struct ethhdr *ethhdr;
+
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, BATMAN_OGM_HLEN)))
+		return NET_RX_DROP;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* packet with broadcast indication but unicast recipient */
+	if (!is_broadcast_ether_addr(ethhdr->h_dest))
+		return NET_RX_DROP;
+
+	/* packet with broadcast sender address */
+	if (is_broadcast_ether_addr(ethhdr->h_source))
+		return NET_RX_DROP;
+
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, 0) < 0)
+		return NET_RX_DROP;
+
+	/* keep skb linear */
+	if (skb_linearize(skb) < 0)
+		return NET_RX_DROP;
+
+	_bat_iv_ogm_receive(skb, hard_iface);
+
+	kfree_skb(skb);
+	return NET_RX_SUCCESS;
+}
+
 static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
@@ -1208,10 +1241,25 @@ static struct bat_algo_ops batman_iv __read_mostly = {
 	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
 	.bat_ogm_emit = bat_iv_ogm_emit,
-	.bat_ogm_receive = bat_iv_ogm_receive,
 };
 
 int __init bat_iv_init(void)
 {
-	return bat_algo_register(&batman_iv);
+	int ret;
+
+	/* batman originator packet */
+	ret = recv_handler_register(BAT_IV_OGM, bat_iv_ogm_receive);
+	if (ret < 0)
+		goto out;
+
+	ret = bat_algo_register(&batman_iv);
+	if (ret < 0)
+		goto handler_unregister;
+
+	goto out;
+
+handler_unregister:
+	recv_handler_unregister(BAT_IV_OGM);
+out:
+	return ret;
 }
diff --git a/main.c b/main.c
index 0d0cd48..8c3ff21 100644
--- a/main.c
+++ b/main.c
@@ -263,8 +263,6 @@ static void recv_handler_init(void)
 	for (i = 0; i < ARRAY_SIZE(recv_packet_handler); i++)
 		recv_packet_handler[i] = recv_unhandled_packet;
 
-	/* batman originator packet */
-	recv_packet_handler[BAT_IV_OGM] = recv_bat_ogm_packet;
 	/* batman icmp packet */
 	recv_packet_handler[BAT_ICMP] = recv_icmp_packet;
 	/* unicast packet */
@@ -331,8 +329,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_primary_iface_set ||
 	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
-	    !bat_algo_ops->bat_ogm_emit ||
-	    !bat_algo_ops->bat_ogm_receive) {
+	    !bat_algo_ops->bat_ogm_emit) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		goto out;
diff --git a/routing.c b/routing.c
index 0da9f5a..9ec4593 100644
--- a/routing.c
+++ b/routing.c
@@ -248,39 +248,6 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 	return 0;
 }
 
-int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
-{
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct ethhdr *ethhdr;
-
-	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb, BATMAN_OGM_HLEN)))
-		return NET_RX_DROP;
-
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with broadcast indication but unicast recipient */
-	if (!is_broadcast_ether_addr(ethhdr->h_dest))
-		return NET_RX_DROP;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return NET_RX_DROP;
-
-	/* create a copy of the skb, if needed, to modify it. */
-	if (skb_cow(skb, 0) < 0)
-		return NET_RX_DROP;
-
-	/* keep skb linear */
-	if (skb_linearize(skb) < 0)
-		return NET_RX_DROP;
-
-	bat_priv->bat_algo_ops->bat_ogm_receive(hard_iface, skb);
-
-	kfree_skb(skb);
-	return NET_RX_SUCCESS;
-}
-
 static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 			       struct sk_buff *skb, size_t icmp_len)
 {
diff --git a/routing.h b/routing.h
index 3d729cb..d69a5a0 100644
--- a/routing.h
+++ b/routing.h
@@ -30,7 +30,6 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
diff --git a/types.h b/types.h
index 6a3cc88..51c59c2 100644
--- a/types.h
+++ b/types.h
@@ -408,9 +408,6 @@ struct bat_algo_ops {
 				 int tt_num_changes);
 	/* send scheduled OGM */
 	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
-	/* receive incoming OGM */
-	void (*bat_ogm_receive)(struct hard_iface *if_incoming,
-				struct sk_buff *skb);
 };
 
 struct dht_candidate {
-- 
1.7.9

