Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun,  4 Mar 2012 16:56:25 +0800
Message-Id: <1330851385-3457-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330587321-12177-3-git-send-email-lindner_marek@yahoo.de>
References: <1330587321-12177-3-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/6] batman-adv: register batman ogm
	receive function during protocol init
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
 bat_iv_ogm.c |   31 +++++++++++++++++++++++++++----
 main.c       |    5 +----
 routing.c    |   22 ++++++++++------------
 routing.h    |    4 +++-
 types.h      |    3 ---
 5 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index aba0204..784fcef 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1166,13 +1166,18 @@ out:
 	orig_node_free_ref(orig_node);
 }
 
-static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
-			       struct sk_buff *skb)
+static int bat_iv_ogm_receive(struct sk_buff *skb,
+			      struct hard_iface *if_incoming)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 	struct ethhdr *ethhdr;
 	int buff_pos = 0, packet_len;
 	unsigned char *tt_buff, *packet_buff;
+	bool ret;
+
+	ret = check_management_packet(skb, if_incoming, BATMAN_OGM_HLEN);
+	if (!ret)
+		return NET_RX_DROP;
 
 	packet_len = skb_headlen(skb);
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -1198,6 +1203,9 @@ static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
 						(packet_buff + buff_pos);
 	} while (bat_iv_ogm_aggr_packet(buff_pos, packet_len,
 					batman_ogm_packet->tt_num_changes));
+
+	kfree_skb(skb);
+	return NET_RX_SUCCESS;
 }
 
 static struct bat_algo_ops batman_iv __read_mostly = {
@@ -1208,10 +1216,25 @@ static struct bat_algo_ops batman_iv __read_mostly = {
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
index 0da9f5a..d83502a 100644
--- a/routing.c
+++ b/routing.c
@@ -248,37 +248,35 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 	return 0;
 }
 
-int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
+bool check_management_packet(struct sk_buff *skb,
+			     struct hard_iface *hard_iface,
+			     int header_len)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb, BATMAN_OGM_HLEN)))
-		return NET_RX_DROP;
+	if (unlikely(!pskb_may_pull(skb, header_len)))
+		return false;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
-		return NET_RX_DROP;
+		return false;
 
 	/* packet with broadcast sender address */
 	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return NET_RX_DROP;
+		return false;
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, 0) < 0)
-		return NET_RX_DROP;
+		return false;
 
 	/* keep skb linear */
 	if (skb_linearize(skb) < 0)
-		return NET_RX_DROP;
-
-	bat_priv->bat_algo_ops->bat_ogm_receive(hard_iface, skb);
+		return false;
 
-	kfree_skb(skb);
-	return NET_RX_SUCCESS;
+	return true;
 }
 
 static int recv_my_icmp_packet(struct bat_priv *bat_priv,
diff --git a/routing.h b/routing.h
index 3d729cb..d6bbbeb 100644
--- a/routing.h
+++ b/routing.h
@@ -23,6 +23,9 @@
 #define _NET_BATMAN_ADV_ROUTING_H_
 
 void slide_own_bcast_window(struct hard_iface *hard_iface);
+bool check_management_packet(struct sk_buff *skb,
+			     struct hard_iface *hard_iface,
+			     int header_len);
 void update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		  struct neigh_node *neigh_node);
 int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
@@ -30,7 +33,6 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
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

