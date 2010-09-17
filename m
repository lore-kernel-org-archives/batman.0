Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 17:41:02 +0200
Message-Id: <1284738065-8715-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Use refcnt to track usage
	count of gw_node
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

gw_election may leak data from the rcu protected list of all gateway
nodes outside the read-side critical area. This is not valid as we may
free the data using a call_rcu created callback after we unlock using
rcu_read_unlock. A workaround is to provide a reference count to be sure
that the memory isn't freed to early.

It is currently only to implement the already existing functionality and
doesn't provide the full tracking of all usage cases.

Additionally, we must gw_node_hold inside the
rcu_read_lock()..rcu_read_unlock() before we attach to the structure
which "leaks" it. When another function now removed it from its usage
context (curr_gw, usage on stack, ...) then we must gw_node_put it. If
it is decremented to zero then we can issue the call_rcu to the freeing
function. So "put" is not allowed inside an rcu_read_lock.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |   17 +++++++++++++++--
 batman-adv/types.h          |    1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 8bc1cb0..16f0757 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -28,6 +28,17 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
+static void gw_node_hold(struct gw_node *gw_node)
+{
+	atomic_inc(&gw_node->refcnt);
+}
+
+static void gw_node_put(struct gw_node *gw_node)
+{
+	if (atomic_dec_and_test(&gw_node->refcnt))
+		kfree(gw_node);
+}
+
 void *gw_get_selected(struct bat_priv *bat_priv)
 {
 	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
@@ -205,6 +216,8 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	memset(gw_node, 0, sizeof(struct gw_node));
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
+	atomic_set(&gw_node->refcnt, 0);
+	gw_node_hold(gw_node);
 
 	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
@@ -281,7 +294,7 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 
 			hlist_del_rcu(&gw_node->list);
 			synchronize_rcu();
-			kfree(gw_node);
+			gw_node_put(gw_node);
 		}
 	}
 
@@ -300,7 +313,7 @@ void gw_node_list_free(struct bat_priv *bat_priv)
 				 &bat_priv->gw_list, list) {
 		hlist_del_rcu(&gw_node->list);
 		synchronize_rcu();
-		kfree(gw_node);
+		gw_node_put(gw_node);
 	}
 
 	gw_deselect(bat_priv);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1940404..ecc4365 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -95,6 +95,7 @@ struct gw_node {
 	struct hlist_node list;
 	struct orig_node *orig_node;
 	unsigned long deleted;
+	atomic_t refcnt;
 };
 
 /**
-- 
1.7.2.3

