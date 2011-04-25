Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Apr 2011 11:18:23 +0200
Message-Id: <1303723103-29582-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: gw_node_update() now adds a new
	gw_node if no curr_gw is selected
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

gw_node_update() doesn't add a new gw_node in case of empty curr_gw.
This means that at the beginning no gw_node is added, leading to an
empty gateway list.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 gateway_client.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 2acd7a6..db4468c 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -311,10 +311,10 @@ void gw_node_update(struct bat_priv *bat_priv,
 	struct gw_node *gw_node, *curr_gw;
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
+	rcu_read_lock();
 	if (!curr_gw)
-		goto out;
+		goto gw_node_add;
 
-	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
 		if (gw_node->orig_node != orig_node)
 			continue;
@@ -340,6 +340,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 		goto unlock;
 	}
 
+gw_node_add:
 	if (new_gwflags == 0)
 		goto unlock;
 
@@ -350,7 +351,7 @@ deselect:
 	gw_deselect(bat_priv);
 unlock:
 	rcu_read_unlock();
-out:
+
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
 }
-- 
1.7.3.4

