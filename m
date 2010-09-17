Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 17:41:04 +0200
Message-Id: <1284738065-8715-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: count election of gateway as
	reference
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

We reference the gw_nodes as curr_gw for each bat_priv. They are tracked
inside a rcu protected list gw_list which may free the memory after it
gets removed from the list. Nevertheless it could still be referenced by
curr_gw and access to it would result in a kernel oops.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 16f0757..1cad4f8 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -51,13 +51,18 @@ void *gw_get_selected(struct bat_priv *bat_priv)
 
 void gw_deselect(struct bat_priv *bat_priv)
 {
+	struct gw_node *gw_node = bat_priv->curr_gw;
+
 	bat_priv->curr_gw = NULL;
+
+	if (gw_node)
+		gw_node_put(gw_node);
 }
 
 void gw_election(struct bat_priv *bat_priv)
 {
 	struct hlist_node *node;
-	struct gw_node *gw_node, *curr_gw_tmp = NULL;
+	struct gw_node *gw_node, *curr_gw_tmp = NULL, *old_gw_node = NULL;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	int down, up;
@@ -131,7 +136,6 @@ void gw_election(struct bat_priv *bat_priv)
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
 	}
-	rcu_read_unlock();
 
 	if (bat_priv->curr_gw != curr_gw_tmp) {
 		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
@@ -153,8 +157,17 @@ void gw_election(struct bat_priv *bat_priv)
 				curr_gw_tmp->orig_node->gw_flags,
 				curr_gw_tmp->orig_node->router->tq_avg);
 
+		old_gw_node = bat_priv->curr_gw;
+		if (curr_gw_tmp)
+			gw_node_hold(curr_gw_tmp);
+
 		bat_priv->curr_gw = curr_gw_tmp;
 	}
+
+	rcu_read_unlock();
+
+	if (old_gw_node)
+		gw_node_put(old_gw_node);
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
@@ -258,8 +271,11 @@ void gw_node_update(struct bat_priv *bat_priv,
 				"Gateway %pM removed from gateway list\n",
 				orig_node->orig);
 
-			if (gw_node == bat_priv->curr_gw)
+			if (gw_node == bat_priv->curr_gw) {
+				rcu_read_unlock();
 				gw_deselect(bat_priv);
+				return;
+			}
 		}
 
 		rcu_read_unlock();
-- 
1.7.2.3

