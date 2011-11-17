Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Thu, 17 Nov 2011 16:53:52 +0100
Message-Id: <1321545233-32676-4-git-send-email-daniele.furlan@gmail.com>
In-Reply-To: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
References: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.]  [PATCH 4/5] Change ogm forwarding rules
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

 This patch changes ogm forwarding rules in order to guarantee loop-freeness.
 Now only the ogm coming from the current router is forwarded.
 The tq substitution with the router tq is deleted, ogm coming
 from sub-optimal path, they are simply discarded.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 bat_iv_ogm.c |   45 +++++++++++++++++++--------------------------
 1 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 9f6cc9b..ec7265a 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -466,8 +466,7 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 			    int directlink, struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct neigh_node *router;
-	uint8_t in_tq, in_ttl, tq = 0;
+	uint8_t in_tq, in_ttl;
 	uint8_t tt_num_changes;
 
 	if (batman_ogm_packet->ttl <= 1) {
@@ -475,8 +474,6 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 		return;
 	}
 
-	router = orig_node_get_router(orig_node);
-
 	in_tq = batman_ogm_packet->tq;
 	in_ttl = batman_ogm_packet->ttl;
 	tt_num_changes = batman_ogm_packet->tt_num_changes;
@@ -484,31 +481,13 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 	batman_ogm_packet->ttl--;
 	memcpy(batman_ogm_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
 
-	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
-	 * of our best tq value */
-	if (router && router->tq != 0) {
-
-		/* rebroadcast ogm of best ranking neighbor as is */
-		if (!compare_eth(router->addr, ethhdr->h_source)) {
-			batman_ogm_packet->tq = router->tq;
-
-			if (router->last_ttl)
-				batman_ogm_packet->ttl = router->last_ttl - 1;
-		}
-
-		tq = router->tq;
-	}
-
-	if (router)
-		neigh_node_free_ref(router);
-
 	/* apply hop penalty */
 	batman_ogm_packet->tq = hop_penalty(batman_ogm_packet->tq, bat_priv);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
-		"Forwarding packet: tq_orig: %i, tq: %i, "
+		"Forwarding packet: tq_orig: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
-		in_tq, tq, batman_ogm_packet->tq, in_ttl - 1,
+		in_tq, batman_ogm_packet->tq, in_ttl - 1,
 		batman_ogm_packet->ttl);
 
 	batman_ogm_packet->seqno = htonl(batman_ogm_packet->seqno);
@@ -897,6 +876,7 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 	struct hard_iface *hard_iface;
 	struct orig_node *orig_neigh_node, *orig_node;
 	struct neigh_node *router = NULL, *router_router = NULL;
+	struct neigh_node *new_router = NULL;
 	struct neigh_node *orig_neigh_router = NULL;
 	int has_directlink_flag;
 	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
@@ -1113,9 +1093,20 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 		goto out_neigh;
 	}
 
-	if (is_duplicate) {
+	/* old packet */
+	if (orig_node->last_real_seqno > batman_ogm_packet->seqno) {
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Drop packet: old packet received\n");
+		goto out_neigh;
+	}
+	
+	/* get router after updates */
+	new_router = orig_node_get_router(orig_node);
+
+	/* forward only ogm coming from current router */
+	if (compare_eth(new_router->addr, ethhdr->h_source) == 0) {
 		bat_dbg(DBG_BATMAN, bat_priv,
-			"Drop packet: duplicate packet received\n");
+			"Drop packet: not received via current router\n");
 		goto out_neigh;
 	}
 
@@ -1133,6 +1124,8 @@ out:
 		neigh_node_free_ref(router_router);
 	if (orig_neigh_router)
 		neigh_node_free_ref(orig_neigh_router);
+	if (new_router)
+		neigh_node_free_ref(new_router);
 
 	orig_node_free_ref(orig_node);
 }
-- 
1.7.1

