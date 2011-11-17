Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Thu, 17 Nov 2011 16:53:53 +0100
Message-Id: <1321545233-32676-5-git-send-email-daniele.furlan@gmail.com>
In-Reply-To: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
References: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.]  [PATCH 5/5] Remove unnecessary code
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

 This patch remove the now unnecessary code that avoid temporary routing loops
 since new forwading rules guarantees loop-freeness so it becomes useless.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 bat_iv_ogm.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index ec7265a..f76a38c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -875,7 +875,6 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct hard_iface *hard_iface;
 	struct orig_node *orig_neigh_node, *orig_node;
-	struct neigh_node *router = NULL, *router_router = NULL;
 	struct neigh_node *new_router = NULL;
 	struct neigh_node *orig_neigh_router = NULL;
 	int has_directlink_flag;
@@ -1025,22 +1024,6 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 		goto out;
 	}
 
-	router = orig_node_get_router(orig_node);
-	if (router)
-		router_router = orig_node_get_router(router->orig_node);
-
-	/* avoid temporary routing loops */
-	if (router && router_router &&
-	    (compare_eth(router->addr, batman_ogm_packet->prev_sender)) &&
-	    !(compare_eth(batman_ogm_packet->orig,
-			  batman_ogm_packet->prev_sender)) &&
-	    (compare_eth(router->addr, router_router->addr))) {
-		bat_dbg(DBG_BATMAN, bat_priv,
-			"Drop packet: ignoring all rebroadcast packets that "
-			"may make me loop (sender: %pM)\n", ethhdr->h_source);
-		goto out;
-	}
-
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac */
 	orig_neigh_node = (is_single_hop_neigh ?
@@ -1118,10 +1101,6 @@ out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
 		orig_node_free_ref(orig_neigh_node);
 out:
-	if (router)
-		neigh_node_free_ref(router);
-	if (router_router)
-		neigh_node_free_ref(router_router);
 	if (orig_neigh_router)
 		neigh_node_free_ref(orig_neigh_router);
 	if (new_router)
-- 
1.7.1

