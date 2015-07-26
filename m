Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Jul 2015 16:27:34 +0800
Message-Id: <1437899254-24073-4-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1437899254-24073-1-git-send-email-mareklindner@neomailbox.ch>
References: <1437899254-24073-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: update last seen field of
	single hop originators
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v2: new patch

 net/batman-adv/bat_iv_ogm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 39fab03..154e36a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1379,6 +1379,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 				struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_neigh_node *router_router = NULL;
 	struct batadv_orig_node *orig_neigh_node;
@@ -1423,6 +1424,13 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		goto out;
 	}
 
+	if (is_single_hop_neigh) {
+		hardif_neigh = batadv_hardif_neigh_get(if_incoming,
+						       ethhdr->h_source);
+		if (hardif_neigh)
+			hardif_neigh->last_seen = jiffies;
+	}
+
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router) {
 		router_router = batadv_orig_router_get(router->orig_node,
@@ -1557,6 +1565,8 @@ out:
 		batadv_neigh_node_free_ref(router_router);
 	if (orig_neigh_router)
 		batadv_neigh_node_free_ref(orig_neigh_router);
+	if (hardif_neigh)
+		batadv_hardif_neigh_free_ref(hardif_neigh);
 
 	kfree_skb(skb_priv);
 }
-- 
2.1.4

