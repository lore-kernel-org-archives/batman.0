Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Apr 2011 22:44:32 +0200
Message-Id: <1303764272-5943-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1303723103-29582-1-git-send-email-ordex@autistici.org>
References: <1303723103-29582-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4] batman-adv: fix gw_node_update() and
	gw_election()
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

This is a regression from 8ffdea813e32cee3c60be36fb9e6a5e077e51ea0

- gw_node_update() doesn't add a new gw_node in case of empty curr_gw.
This means that at the beginning no gw_node is added, leading to an
empty gateway list.

- gw_election() is terminating in case of curr_gw == NULL. It has to
terminate in case of curr_gw != NULL

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 gateway_client.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 2acd7a6..4b4f71b 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -127,7 +127,7 @@ void gw_election(struct bat_priv *bat_priv)
 		return;
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
-	if (!curr_gw)
+	if (curr_gw)
 		goto out;
 
 	rcu_read_lock();
@@ -311,8 +311,6 @@ void gw_node_update(struct bat_priv *bat_priv,
 	struct gw_node *gw_node, *curr_gw;
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
-	if (!curr_gw)
-		goto out;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
@@ -350,7 +348,7 @@ deselect:
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

