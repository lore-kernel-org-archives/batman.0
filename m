Return-Path: <clang@gateworks.com>
From: Chris Lang <clang@gateworks.com>
Date: Sun, 24 Oct 2010 23:34:48 -0700
Message-Id: <1287988488-10533-1-git-send-email-clang@gateworks.com>
In-Reply-To: <clang@gateworks.com>
References: <clang@gateworks.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Re-Enable Interface alternating
	and bonding
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

r1765 incidentally disabled bonding of packets first entering the
mesh along with also disabling interface alternating regardless
of where the packet came from. This re-enables these options.

Signed-off-by: Chris Lang <clang@gateworks.com>
---
 routing.c |   12 ++++--------
 routing.h |    4 ++--
 unicast.c |    2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/routing.c b/routing.c
index 7c9a053..f1012bc 100644
--- a/routing.c
+++ b/routing.c
@@ -1001,10 +1001,10 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 /* find a suitable router for this originator, and use
  * bonding if possible. */
-struct neigh_node *find_router(struct orig_node *orig_node,
+struct neigh_node *find_router(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node,
 			       struct batman_if *recv_if)
 {
-	struct bat_priv *bat_priv;
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
 	struct neigh_node *router, *first_candidate, *best_router;
@@ -1020,13 +1020,9 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 	/* without bonding, the first node should
 	 * always choose the default router. */
 
-	if (!recv_if)
-		return orig_node->router;
-
-	bat_priv = netdev_priv(recv_if->soft_iface);
 	bonding_enabled = atomic_read(&bat_priv->bonding_enabled);
 
-	if (!bonding_enabled)
+	if (!recv_if && !bonding_enabled)
 		return orig_node->router;
 
 	router_orig = orig_node->router->orig_node;
@@ -1155,7 +1151,7 @@ static int route_unicast_packet(struct sk_buff *skb,
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, unicast_packet->dest));
 
-	router = find_router(orig_node, recv_if);
+	router = find_router(bat_priv, orig_node, recv_if);
 
 	if (!router) {
 		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
diff --git a/routing.h b/routing.h
index 06ea99d..92674c8 100644
--- a/routing.h
+++ b/routing.h
@@ -38,8 +38,8 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
-struct neigh_node *find_router(struct orig_node *orig_node,
-		struct batman_if *recv_if);
+struct neigh_node *find_router(struct bat_priv *bat_priv,
+		struct orig_node *orig_node, struct batman_if *recv_if);
 void update_bonding_candidates(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node);
 
diff --git a/unicast.c b/unicast.c
index 0dac50d..0459413 100644
--- a/unicast.c
+++ b/unicast.c
@@ -224,7 +224,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	if (!orig_node)
 		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 
-	router = find_router(orig_node, NULL);
+	router = find_router(bat_priv, orig_node, NULL);
 
 	if (!router)
 		goto unlock;
-- 
1.7.3

