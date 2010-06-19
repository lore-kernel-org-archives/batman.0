Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:51:52 +0200
Message-Id: <1276908713-28365-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] Staging: batman-adv: bonding and
	interface alternating
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

This patch adds interface alternating to the new bonding feature. By
default, we now try to avoid forwarding packets on the receiving
interface, instead choosing alternative interfaces. This feature
works only on nodes which have multiple interfaces connected to the
mesh. This approach should reduce problems of the half-duplex nature
of WiFi Hardware and thus increase performance.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Acked-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |    2 +-
 drivers/staging/batman-adv/routing.c        |   72 +++++++++++++++++---------
 drivers/staging/batman-adv/routing.h        |    5 +-
 drivers/staging/batman-adv/soft-interface.c |    2 +-
 4 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 028a7ea..ba7ddfc 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -512,7 +512,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 		/* unicast packet */
 	case BAT_UNICAST:
-		ret = recv_unicast_packet(skb);
+		ret = recv_unicast_packet(skb, batman_if);
 		break;
 
 		/* broadcast packet */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 6a2c2d1..048795e 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -402,12 +402,6 @@ static void mark_bonding_address(struct bat_priv *bat_priv,
 				 struct batman_packet *batman_packet)
 
 {
-	/* don't care if bonding is not enabled */
-	if (!atomic_read(&bat_priv->bonding_enabled)) {
-		orig_node->bond.candidates = 0;
-		return;
-	}
-
 	if (batman_packet->flags & PRIMARIES_FIRST_HOP)
 		memcpy(orig_neigh_node->primary_addr,
 		       orig_node->orig, ETH_ALEN);
@@ -425,12 +419,6 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
 	struct neigh_node *first_candidate, *last_candidate;
 
-	/* don't care if bonding is not enabled */
-	if (!atomic_read(&bat_priv->bonding_enabled)) {
-		orig_node->bond.candidates = 0;
-		return;
-	}
-
 	/* update the candidates for this originator */
 	if (!orig_node->router) {
 		orig_node->bond.candidates = 0;
@@ -986,14 +974,16 @@ int recv_icmp_packet(struct sk_buff *skb)
 
 /* find a suitable router for this originator, and use
  * bonding if possible. */
-struct neigh_node *find_router(struct orig_node *orig_node)
+struct neigh_node *find_router(struct orig_node *orig_node,
+		struct batman_if *recv_if)
 {
 	/* FIXME: each orig_node->batman_if will be attached to a softif */
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
-	struct neigh_node *router;
+	struct neigh_node *router, *first_candidate, *best_router;
 	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
+	int bonding_enabled;
 
 	if (!orig_node)
 		return NULL;
@@ -1001,9 +991,12 @@ struct neigh_node *find_router(struct orig_node *orig_node)
 	if (!orig_node->router)
 		return NULL;
 
-	/* don't care if bonding is not enabled */
-	if (!atomic_read(&bat_priv->bonding_enabled))
-		return orig_node->router;
+	/* without bonding, the first node should
+	 * always choose the default router. */
+
+	bonding_enabled = atomic_read(&bat_priv->bonding_enabled);
+	if (!bonding_enabled && (recv_if == NULL))
+			return orig_node->router;
 
 	router_orig = orig_node->router->orig_node;
 
@@ -1031,19 +1024,48 @@ struct neigh_node *find_router(struct orig_node *orig_node)
 	if (primary_orig_node->bond.candidates < 2)
 		return orig_node->router;
 
-	router = primary_orig_node->bond.selected;
 
-	/* sanity check - this should never happen. */
-	if (!router)
-		return orig_node->router;
+	/* all nodes between should choose a candidate which
+	 * is is not on the interface where the packet came
+	 * in. */
+	first_candidate = primary_orig_node->bond.selected;
+	router = first_candidate;
 
-	/* select the next bonding partner ... */
-	primary_orig_node->bond.selected = router->next_bond_candidate;
+	if (bonding_enabled) {
+		/* in the bonding case, send the packets in a round
+		 * robin fashion over the remaining interfaces. */
+		do {
+			/* recv_if == NULL on the first node. */
+			if (router->if_incoming != recv_if)
+				break;
+
+			router = router->next_bond_candidate;
+		} while (router != first_candidate);
+
+		primary_orig_node->bond.selected = router->next_bond_candidate;
+
+	} else {
+		/* if bonding is disabled, use the best of the
+		 * remaining candidates which are not using
+		 * this interface. */
+		best_router = first_candidate;
+
+		do {
+			/* recv_if == NULL on the first node. */
+			if ((router->if_incoming != recv_if) &&
+				(router->tq_avg > best_router->tq_avg))
+					best_router = router;
+
+			router = router->next_bond_candidate;
+		} while (router != first_candidate);
+
+		router = best_router;
+	}
 
 	return router;
 }
 
-int recv_unicast_packet(struct sk_buff *skb)
+int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
@@ -1095,7 +1117,7 @@ int recv_unicast_packet(struct sk_buff *skb)
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, unicast_packet->dest));
 
-	router = find_router(orig_node);
+	router = find_router(orig_node, recv_if);
 
 	if (!router) {
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index 0e33d22..43387a2 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -30,11 +30,12 @@ void update_routes(struct orig_node *orig_node,
 				struct neigh_node *neigh_node,
 				unsigned char *hna_buff, int hna_buff_len);
 int recv_icmp_packet(struct sk_buff *skb);
-int recv_unicast_packet(struct sk_buff *skb);
+int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb);
 int recv_vis_packet(struct sk_buff *skb);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
-struct neigh_node *find_router(struct orig_node *orig_node);
+struct neigh_node *find_router(struct orig_node *orig_node,
+		struct batman_if *recv_if);
 void update_bonding_candidates(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node);
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 37fd565..ef7860d 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -188,7 +188,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		if (!orig_node)
 			orig_node = transtable_search(ethhdr->h_dest);
 
-		router = find_router(orig_node);
+		router = find_router(orig_node, NULL);
 
 		if (!router)
 			goto unlock;
-- 
1.7.1

