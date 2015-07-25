Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Jul 2015 04:57:43 +0800
Message-Id: <1437857863-28742-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move neigh_node list add into
	batadv_neigh_node_new()
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

All batadv_neigh_node_* functions expect the neigh_node list item to be part
of the orig_node->neigh_list, therefore the constructor of said list item
should be adding the newly created neigh_node to the respective list.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_iv_ogm.c | 21 +--------------------
 net/batman-adv/originator.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 60ca3dc..912d9c3 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -296,8 +296,7 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			struct batadv_orig_node *orig_node,
 			struct batadv_orig_node *orig_neigh)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_neigh_node *neigh_node, *tmp_neigh_node;
+	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = batadv_neigh_node_new(orig_node, hard_iface, neigh_addr);
 	if (!neigh_node)
@@ -305,24 +304,6 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 
 	neigh_node->orig_node = orig_neigh;
 
-	spin_lock_bh(&orig_node->neigh_list_lock);
-	tmp_neigh_node = batadv_neigh_node_get(orig_node, hard_iface,
-					       neigh_addr);
-	if (!tmp_neigh_node) {
-		hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
-	} else {
-		kfree(neigh_node);
-		batadv_hardif_free_ref(hard_iface);
-		neigh_node = tmp_neigh_node;
-	}
-	spin_unlock_bh(&orig_node->neigh_list_lock);
-
-	if (!tmp_neigh_node)
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
-			   neigh_addr, orig_node->orig,
-			   hard_iface->net_dev->name);
-
 out:
 	return neigh_node;
 }
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 67d3d8e..1429603 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -458,6 +458,10 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 {
 	struct batadv_neigh_node *neigh_node;
 
+	neigh_node = batadv_neigh_node_get(orig_node, hard_iface, neigh_addr);
+	if (neigh_node)
+		goto out;
+
 	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
 	if (!neigh_node)
 		goto out;
@@ -479,6 +483,14 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	/* extra reference for return */
 	atomic_set(&neigh_node->refcount, 2);
 
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	batadv_dbg(BATADV_DBG_BATMAN, orig_node->bat_priv,
+		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
+		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
+
 out:
 	return neigh_node;
 }
-- 
2.1.4

