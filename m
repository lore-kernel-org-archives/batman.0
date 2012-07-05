Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 Jul 2012 19:22:49 +0200
Message-Id: <1341508969-22984-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: create a unique entry point for
	unicast packets
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

Right now in batman-adv we have several unicast packets 'subtypes' (UNICAST,
UNICAST_FRAG, TT_QUERY and ROAM_ADV) that in the initial part of the rx path
need the same treatment (e.g. size check, destination check, is_for_me? check,
etc.).

For this reason we would like to propose to unify the rx paths in this early
stage. This change would reduce code duplication and avoid introducing bugs
(e.g. it is easy to add a check for the TT_QUERY and forget to do the same for
the UNICAST packet).

It could be the case that to better address this issue we would need to slightly
redesign packet format. So we would probably need to wait until the next (and
hopefully last needed) compatibility breakage.

But for now you get this a proposal :-)

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c    |   17 +++++++++-----
 routing.c |   74 ++++++++++++++++++++++++++++++++-----------------------------
 routing.h |   10 ++-------
 3 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/main.c b/main.c
index 13c88b2..da1b728 100644
--- a/main.c
+++ b/main.c
@@ -277,18 +277,23 @@ static void batadv_recv_handler_init(void)
 
 	/* batman icmp packet */
 	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
-	/* unicast packet */
-	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_unicast_packet;
-	/* fragmented unicast packet */
-	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_ucast_frag_packet;
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
 	/* vis packet */
 	batadv_rx_handler[BATADV_VIS] = batadv_recv_vis_packet;
+
+	/* all the unicast packets have now a single entry point that will make
+	 * all the common checks on the packets. It will then invoke the proper
+	 * parser function based on the real packet type
+	 */
+	/* unicast packet */
+	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_generic_unicast;
+	/* fragmented unicast packet */
+	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_generic_unicast;
 	/* Translation table query (request or response) */
-	batadv_rx_handler[BATADV_TT_QUERY] = batadv_recv_tt_query;
+	batadv_rx_handler[BATADV_TT_QUERY] = batadv_recv_generic_unicast;
 	/* Roaming advertisement */
-	batadv_rx_handler[BATADV_ROAM_ADV] = batadv_recv_roam_adv;
+	batadv_rx_handler[BATADV_ROAM_ADV] = batadv_recv_generic_unicast;
 }
 
 int
diff --git a/routing.c b/routing.c
index bc2b88b..25ee461 100644
--- a/routing.c
+++ b/routing.c
@@ -579,12 +579,12 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 	return router;
 }
 
-int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
+static int batadv_recv_tt_query(struct sk_buff *skb,
+				struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_tt_query_packet *tt_query;
 	uint16_t tt_size;
-	struct ethhdr *ethhdr;
 	char tt_flag;
 	size_t packet_size;
 
@@ -597,16 +597,6 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 	if (skb_cow(skb, sizeof(struct batadv_tt_query_packet)) < 0)
 		goto out;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		goto out;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
-		goto out;
-
 	tt_query = (struct batadv_tt_query_packet *)skb->data;
 
 	switch (tt_query->flags & BATADV_TT_QUERY_TYPE_MASK) {
@@ -669,28 +659,18 @@ out:
 	return NET_RX_DROP;
 }
 
-int batadv_recv_roam_adv(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
+static int batadv_recv_roam_adv(struct sk_buff *skb,
+				struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_roam_adv_packet *roam_adv_packet;
 	struct batadv_orig_node *orig_node;
-	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb,
 				    sizeof(struct batadv_roam_adv_packet))))
 		goto out;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		goto out;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
-		goto out;
-
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_RX);
 
 	roam_adv_packet = (struct batadv_roam_adv_packet *)skb->data;
@@ -1008,21 +988,17 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	return 1;
 }
 
-int batadv_recv_unicast_packet(struct sk_buff *skb,
-			       struct batadv_hard_iface *recv_if)
+static int batadv_recv_unicast_packet(struct sk_buff *skb,
+				      struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
-
-	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
-		return NET_RX_DROP;
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
 	if (!batadv_check_unicast_ttvn(bat_priv, skb))
 		return NET_RX_DROP;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-
 	/* packet for me */
 	if (batadv_is_my_mac(unicast_packet->dest)) {
 		batadv_interface_rx(recv_if->soft_iface, skb, recv_if,
@@ -1033,8 +1009,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	return batadv_route_unicast_packet(skb, recv_if);
 }
 
-int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
-				  struct batadv_hard_iface *recv_if)
+static int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
+					 struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_frag_packet *unicast_packet;
@@ -1042,10 +1018,10 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 	struct sk_buff *new_skb = NULL;
 	int ret;
 
-	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
+	if (!batadv_check_unicast_ttvn(bat_priv, skb))
 		return NET_RX_DROP;
 
-	if (!batadv_check_unicast_ttvn(bat_priv, skb))
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return NET_RX_DROP;
 
 	unicast_packet = (struct batadv_unicast_frag_packet *)skb->data;
@@ -1211,3 +1187,31 @@ int batadv_recv_vis_packet(struct sk_buff *skb,
 	 */
 	return NET_RX_DROP;
 }
+
+int batadv_recv_generic_unicast(struct sk_buff *skb,
+				struct batadv_hard_iface *recv_if)
+{
+	struct batadv_unicast_packet *unicast_packet;
+	int to_pull = sizeof(*unicast_packet);
+
+	/* pull only what we need to check the common fields in each unicast
+	 * packet
+	 */
+	if (batadv_check_unicast_packet(skb, to_pull) < 0)
+		return NET_RX_DROP;
+
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
+	switch (unicast_packet->header.packet_type) {
+	case BATADV_UNICAST:
+		return batadv_recv_unicast_packet(skb, recv_if);
+	case BATADV_UNICAST_FRAG:
+		return batadv_recv_ucast_frag_packet(skb, recv_if);
+	case BATADV_TT_QUERY:
+		return batadv_recv_tt_query(skb, recv_if);
+	case BATADV_ROAM_ADV:
+		return batadv_recv_roam_adv(skb, recv_if);
+	}
+	/* did we get an unknown unicast packet ? */
+	return NET_RX_DROP;
+}
diff --git a/routing.h b/routing.h
index 9262279..2e7e1fe 100644
--- a/routing.h
+++ b/routing.h
@@ -29,18 +29,12 @@ void batadv_update_route(struct batadv_priv *bat_priv,
 			 struct batadv_neigh_node *neigh_node);
 int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if);
-int batadv_recv_unicast_packet(struct sk_buff *skb,
-			       struct batadv_hard_iface *recv_if);
-int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
-				  struct batadv_hard_iface *recv_if);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_vis_packet(struct sk_buff *skb,
 			   struct batadv_hard_iface *recv_if);
-int batadv_recv_tt_query(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
-int batadv_recv_roam_adv(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
+int batadv_recv_generic_unicast(struct sk_buff *skb,
+				struct batadv_hard_iface *recv_if);
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
-- 
1.7.9.4

