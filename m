Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 11 Jun 2011 12:15:42 +0200
Message-Id: <1307787342-24307-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1304946150-6026-2-git-send-email-ordex@autistici.org>
References: <1304946150-6026-2-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 2/3] batman-adv: throw uevent in userspace
	on gateway add/change/del event
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

From: Antonio Quartulli <ordex@autistici.org>

In case of new default gw, changing the default gw or deleting the default gw a
uevent is triggered with type=gw, action=add/change/del and
data={GW_ORIG_ADDRESS} (if any).

The gateway election mechanism has been a little revised. Now the
gw_election is trigered by an atomic_t flag (gw_reselect) which is is set
to 1 in case of election needed, avoding to set curr_gw to NULL.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
* gw_election() code refactored to increase readability
* bug fixed: if curr_gw_tmp is NULL the uevent would never be triggered
  because the variable "router" would also be NULL

 gateway_client.c |  143 ++++++++++++++++++++++++++++++++---------------------
 main.c           |    1 +
 types.h          |    1 +
 3 files changed, 88 insertions(+), 57 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 24aee56..964a27e 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -20,6 +20,7 @@
  */
 
 #include "main.h"
+#include "bat_sysfs.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
@@ -97,40 +98,19 @@ static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
 
 void gw_deselect(struct bat_priv *bat_priv)
 {
-	gw_select(bat_priv, NULL);
+	atomic_set(&bat_priv->gw_reselect, 1);
 }
 
-void gw_election(struct bat_priv *bat_priv)
+static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 {
-	struct hlist_node *node;
-	struct gw_node *gw_node, *curr_gw = NULL, *curr_gw_tmp = NULL;
 	struct neigh_node *router;
-	uint8_t max_tq = 0;
+	struct hlist_node *node;
+	struct gw_node *gw_node, *curr_gw = NULL;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
+	uint8_t max_tq = 0;
 	int down, up;
 
-	/**
-	 * The batman daemon checks here if we already passed a full originator
-	 * cycle in order to make sure we don't choose the first gateway we
-	 * hear about. This check is based on the daemon's uptime which we
-	 * don't have.
-	 **/
-	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
-		return;
-
-	curr_gw = gw_get_selected_gw_node(bat_priv);
-	if (curr_gw)
-		goto out;
-
 	rcu_read_lock();
-	if (hlist_empty(&bat_priv->gw_list)) {
-		bat_dbg(DBG_BATMAN, bat_priv,
-			"Removing selected gateway - "
-			"no gateway in range\n");
-		gw_deselect(bat_priv);
-		goto unlock;
-	}
-
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
 		if (gw_node->deleted)
 			continue;
@@ -139,6 +119,9 @@ void gw_election(struct bat_priv *bat_priv)
 		if (!router)
 			continue;
 
+		if (!atomic_inc_not_zero(&gw_node->refcount))
+			goto next;
+
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
 			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
@@ -151,8 +134,12 @@ void gw_election(struct bat_priv *bat_priv)
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-			     (router->tq_avg > max_tq)))
-				curr_gw_tmp = gw_node;
+			     (router->tq_avg > max_tq))) {
+				if (curr_gw)
+					gw_node_free_ref(curr_gw);
+				curr_gw = gw_node;
+				atomic_inc(&curr_gw->refcount);
+			}
 			break;
 
 		default: /**
@@ -163,8 +150,12 @@ void gw_election(struct bat_priv *bat_priv)
 			  *     soon as a better gateway appears which has
 			  *     $routing_class more tq points)
 			  **/
-			if (router->tq_avg > max_tq)
-				curr_gw_tmp = gw_node;
+			if (router->tq_avg > max_tq) {
+				if (curr_gw)
+					gw_node_free_ref(curr_gw);
+				curr_gw = gw_node;
+				atomic_inc(&curr_gw->refcount);
+			}
 			break;
 		}
 
@@ -174,42 +165,80 @@ void gw_election(struct bat_priv *bat_priv)
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
 
+next:
 		neigh_node_free_ref(router);
+		gw_node_free_ref(gw_node);
 	}
+	rcu_read_unlock();
 
-	if (curr_gw != curr_gw_tmp) {
-		router = orig_node_get_router(curr_gw_tmp->orig_node);
-		if (!router)
-			goto unlock;
+	return curr_gw;
+}
 
-		if ((curr_gw) && (!curr_gw_tmp))
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Removing selected gateway - "
-				"no gateway in range\n");
-		else if ((!curr_gw) && (curr_gw_tmp))
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Adding route to gateway %pM "
-				"(gw_flags: %i, tq: %i)\n",
-				curr_gw_tmp->orig_node->orig,
-				curr_gw_tmp->orig_node->gw_flags,
-				router->tq_avg);
-		else
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Changing route to gateway %pM "
-				"(gw_flags: %i, tq: %i)\n",
-				curr_gw_tmp->orig_node->orig,
-				curr_gw_tmp->orig_node->gw_flags,
-				router->tq_avg);
+void gw_election(struct bat_priv *bat_priv)
+{
+	struct gw_node *curr_gw = NULL, *next_gw = NULL;
+	struct neigh_node *router = NULL;
+	char gw_addr[18] = { '\0' };
 
-		neigh_node_free_ref(router);
-		gw_select(bat_priv, curr_gw_tmp);
+	/**
+	 * The batman daemon checks here if we already passed a full originator
+	 * cycle in order to make sure we don't choose the first gateway we
+	 * hear about. This check is based on the daemon's uptime which we
+	 * don't have.
+	 **/
+	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
+		goto out;
+
+	if (!atomic_dec_not_zero(&bat_priv->gw_reselect))
+		goto out;
+
+	curr_gw = gw_get_selected_gw_node(bat_priv);
+
+	next_gw = gw_get_best_gw_node(bat_priv);
+
+	if (curr_gw == next_gw)
+		goto out;
+
+	if (next_gw) {
+		sprintf(gw_addr, "%pM", next_gw->orig_node->orig);
+
+		router = orig_node_get_router(next_gw->orig_node);
+		if (!router) {
+			gw_deselect(bat_priv);
+			goto out;
+		}
 	}
 
-unlock:
-	rcu_read_unlock();
+	if ((curr_gw) && (!next_gw)) {
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Removing selected gateway - no gateway in range\n");
+		throw_uevent(bat_priv, UEV_GW, UEV_DEL, NULL);
+	} else if ((!curr_gw) && (next_gw)) {
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
+			next_gw->orig_node->orig,
+			next_gw->orig_node->gw_flags,
+			router->tq_avg);
+		throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
+	} else {
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Changing route to gateway %pM "
+			"(gw_flags: %i, tq: %i)\n",
+			next_gw->orig_node->orig,
+			next_gw->orig_node->gw_flags,
+			router->tq_avg);
+		throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
+	}
+
+	gw_select(bat_priv, next_gw);
+
 out:
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
+	if (next_gw)
+		gw_node_free_ref(next_gw);
+	if (router)
+		neigh_node_free_ref(router);
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
diff --git a/main.c b/main.c
index c2b06b7..e367e69 100644
--- a/main.c
+++ b/main.c
@@ -113,6 +113,7 @@ int mesh_init(struct net_device *soft_iface)
 	if (vis_init(bat_priv) < 1)
 		goto err;
 
+	atomic_set(&bat_priv->gw_reselect, 0);
 	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
 	goto end;
 
diff --git a/types.h b/types.h
index 11e8569..85cf122 100644
--- a/types.h
+++ b/types.h
@@ -201,6 +201,7 @@ struct bat_priv {
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
+	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct vis_info *my_vis_info;
 };
-- 
1.7.5.3

