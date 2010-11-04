Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  4 Nov 2010 18:20:58 +0100
Message-Id: <1288891265-16035-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011041820.44518.lindner_marek@yahoo.de>
References: <201011041820.44518.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: remove redundant
	gw_node_list_free() function
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/gateway_client.c |   30 +++++++++---------------------
 batman-adv/gateway_client.h |    3 +--
 batman-adv/main.c           |    2 +-
 batman-adv/originator.c     |    2 +-
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 24c12b4..e10dc90 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -305,7 +305,7 @@ void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	return gw_node_update(bat_priv, orig_node, 0);
 }
 
-void gw_node_purge_deleted(struct bat_priv *bat_priv)
+void gw_node_purge(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node;
 	struct hlist_node *node, *node_tmp;
@@ -314,32 +314,20 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 	spin_lock_bh(&bat_priv->gw_list_lock);
 
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
-						&bat_priv->gw_list, list) {
-		if ((gw_node->deleted) &&
-		    (time_after(jiffies, gw_node->deleted + timeout))) {
-
-			hlist_del_rcu(&gw_node->list);
-			call_rcu(&gw_node->rcu, gw_node_free_rcu);
-		}
-	}
-
-	spin_unlock_bh(&bat_priv->gw_list_lock);
-}
-
-void gw_node_list_free(struct bat_priv *bat_priv)
-{
-	struct gw_node *gw_node;
-	struct hlist_node *node, *node_tmp;
+				  &bat_priv->gw_list, list) {
+		if (((!gw_node->deleted) ||
+		     (time_before(jiffies, gw_node->deleted + timeout))) &&
+		    atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE)
+			continue;
 
-	spin_lock_bh(&bat_priv->gw_list_lock);
+		if (bat_priv->curr_gw == gw_node)
+			gw_deselect(bat_priv);
 
-	hlist_for_each_entry_safe(gw_node, node, node_tmp,
-				 &bat_priv->gw_list, list) {
 		hlist_del_rcu(&gw_node->list);
 		call_rcu(&gw_node->rcu, gw_node_free_rcu);
 	}
 
-	gw_deselect(bat_priv);
+
 	spin_unlock_bh(&bat_priv->gw_list_lock);
 }
 
diff --git a/batman-adv/gateway_client.h b/batman-adv/gateway_client.h
index ce0b4f0..38699ba 100644
--- a/batman-adv/gateway_client.h
+++ b/batman-adv/gateway_client.h
@@ -29,8 +29,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_update(struct bat_priv *bat_priv,
 		    struct orig_node *orig_node, uint8_t new_gwflags);
 void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
-void gw_node_purge_deleted(struct bat_priv *bat_priv);
-void gw_node_list_free(struct bat_priv *bat_priv);
+void gw_node_purge(struct bat_priv *bat_priv);
 int gw_client_seq_print_text(struct seq_file *seq, void *offset);
 bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
 
diff --git a/batman-adv/main.c b/batman-adv/main.c
index e4e4eca..c91e635 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -132,7 +132,7 @@ void mesh_free(struct net_device *soft_iface)
 
 	vis_quit(bat_priv);
 
-	gw_node_list_free(bat_priv);
+	gw_node_purge(bat_priv);
 	originator_free(bat_priv);
 
 	hna_local_free(bat_priv);
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 8930446..89ec021 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -293,7 +293,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
-	gw_node_purge_deleted(bat_priv);
+	gw_node_purge(bat_priv);
 	gw_election(bat_priv);
 
 	softif_neigh_purge(bat_priv);
-- 
1.7.1

