Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  9 May 2011 15:02:29 +0200
Message-Id: <1304946150-6026-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1304579589-5222-1-git-send-email-ordex@autistici.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: throw uevent in userspace
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

In case of new default gw, changing the default gw or deleting the default gw a
uevent is triggered with type=gw, action=add/change/del and
data={GW_ORIG_ADDRESS} (if any).

The gateway election mechanism has been a little revised. Now the
gw_election is trigered by an atomic_t flag (gw_reselect) which is is set
to 1 in case of election needed, avoding to set curr_gw to NULL.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
a NULL check on "router" in gw_election() has been added

 gateway_client.c |   33 +++++++++++++++++++++++++++------
 main.c           |    1 +
 types.h          |    1 +
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 65f3953..761dcfb 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -20,6 +20,7 @@
  */
 
 #include "main.h"
+#include "bat_sysfs.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
@@ -105,17 +106,18 @@ static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
 
 void gw_deselect(struct bat_priv *bat_priv)
 {
-	gw_select(bat_priv, NULL);
+	atomic_set(&bat_priv->gw_reselect, 1);
 }
 
 void gw_election(struct bat_priv *bat_priv)
 {
 	struct hlist_node *node;
 	struct gw_node *gw_node, *curr_gw = NULL, *curr_gw_tmp = NULL;
-	struct neigh_node *router;
+	struct neigh_node *router = NULL;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	int down, up;
+	char gw_addr[18] = { '\0' };
 
 	/**
 	 * The batman daemon checks here if we already passed a full originator
@@ -127,7 +129,7 @@ void gw_election(struct bat_priv *bat_priv)
 		return;
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
-	if (curr_gw)
+	if (!atomic_dec_not_zero(&bat_priv->gw_reselect))
 		goto out;
 
 	rcu_read_lock();
@@ -186,9 +188,12 @@ void gw_election(struct bat_priv *bat_priv)
 	}
 
 	if (curr_gw != curr_gw_tmp) {
-		router = orig_node_get_router(curr_gw_tmp->orig_node);
-		if (!router)
+		if (curr_gw_tmp)
+			router = orig_node_get_router(curr_gw_tmp->orig_node);
+		if (!router) {
+			gw_deselect(bat_priv);
 			goto unlock;
+		}
 
 		if ((curr_gw) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
@@ -209,8 +214,24 @@ void gw_election(struct bat_priv *bat_priv)
 				curr_gw_tmp->orig_node->gw_flags,
 				router->tq_avg);
 
-		neigh_node_free_ref(router);
+		if (router)
+			neigh_node_free_ref(router);
 		gw_select(bat_priv, curr_gw_tmp);
+		rcu_read_unlock();
+
+		/* Throw the gateway event to the userspace */
+		if (!curr_gw_tmp) {
+			throw_uevent(bat_priv, UEV_GW, UEV_DEL, NULL);
+			goto out;
+		}
+
+		sprintf(gw_addr, "%pM", curr_gw_tmp->orig_node->orig);
+
+		if (curr_gw)
+			throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
+		else
+			throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
+		goto out;
 	}
 
 unlock:
diff --git a/main.c b/main.c
index 0a7cee0..ca060a9 100644
--- a/main.c
+++ b/main.c
@@ -111,6 +111,7 @@ int mesh_init(struct net_device *soft_iface)
 	if (vis_init(bat_priv) < 1)
 		goto err;
 
+	atomic_set(&bat_priv->gw_reselect, 0);
 	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
 	goto end;
 
diff --git a/types.h b/types.h
index fab70e8..87b890e 100644
--- a/types.h
+++ b/types.h
@@ -173,6 +173,7 @@ struct bat_priv {
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
+	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct vis_info *my_vis_info;
 };
-- 
1.7.3.4

