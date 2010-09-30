Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Sep 2010 14:08:42 +0200
Message-Id: <1285848524-13469-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
References: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: use rcu callbacks when
	freeing gw_nodes
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
 batman-adv/gateway_client.c |   14 ++++++++++----
 batman-adv/types.h          |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index d275560..ae1ab1e 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -36,6 +36,14 @@ static void gw_node_free_ref(struct kref *refcount)
 	kfree(gw_node);
 }
 
+static void gw_node_free_rcu(struct rcu_head *rcu)
+{
+	struct gw_node *gw_node;
+
+	gw_node = container_of(rcu, struct gw_node, rcu);
+	kref_put(&gw_node->refcount, gw_node_free_ref);
+}
+
 void *gw_get_selected(struct bat_priv *bat_priv)
 {
 	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
@@ -314,8 +322,7 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 		    (time_after(jiffies, gw_node->deleted + timeout))) {
 
 			hlist_del_rcu(&gw_node->list);
-			synchronize_rcu();
-			kref_put(&gw_node->refcount, gw_node_free_ref);
+			call_rcu(&gw_node->rcu, gw_node_free_rcu);
 		}
 	}
 
@@ -333,8 +340,7 @@ void gw_node_list_free(struct bat_priv *bat_priv)
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
 				 &bat_priv->gw_list, list) {
 		hlist_del_rcu(&gw_node->list);
-		synchronize_rcu();
-		kref_put(&gw_node->refcount, gw_node_free_ref);
+		call_rcu(&gw_node->rcu, gw_node_free_rcu);
 	}
 
 	gw_deselect(bat_priv);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index f5d29e6..11f1017 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -97,6 +97,7 @@ struct gw_node {
 	struct orig_node *orig_node;
 	unsigned long deleted;
 	struct kref refcount;
+	struct rcu_head rcu;
 };
 
 /**
-- 
1.7.1

