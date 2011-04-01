Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Apr 2011 08:49:19 +0200
Message-Id: <1301640559-4152-2-git-send-email-sven@narfation.org>
In-Reply-To: <1301640559-4152-1-git-send-email-sven@narfation.org>
References: <1301640559-4152-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix imbalanced locking in
	gw_node_update
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

8ffdea813e32cee3c60be36fb9e6a5e077e51ea0 used rcu_read_unlock without
using rcu_read_lock when gw_get_selected_gw_node didn't return a valid
gw_node.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateway_client.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 3d0050b..a5757da 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -312,7 +312,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
 	if (!curr_gw)
-		goto out;
+		goto freeref;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
@@ -350,6 +350,7 @@ deselect:
 	gw_deselect(bat_priv);
 out:
 	rcu_read_unlock();
+freeref:
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
 }
-- 
1.7.4.1

