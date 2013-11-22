Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 22 Nov 2013 13:30:27 +0100
Message-Id: <1385123427-15460-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
References: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix sparse warning in
	batadv_iv_ogm_process_per_outif
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The orig_node_tmp variable is not needed anymore, and spare complains
about that. Remove it.

This variable was used for line length reasons and usage was removed
in de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b ("batman-adv: split out
router from orig_node")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2a36de8..939d16e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1368,7 +1368,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
-	struct batadv_orig_node *orig_neigh_node, *orig_node_tmp;
+	struct batadv_orig_node *orig_neigh_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
@@ -1412,7 +1412,6 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router) {
-		orig_node_tmp = router->orig_node;
 		router_router = batadv_orig_router_get(router->orig_node,
 						       if_outgoing);
 		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
-- 
1.7.10.4

