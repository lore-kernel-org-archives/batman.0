Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Sep 2010 14:08:41 +0200
Message-Id: <1285848524-13469-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
References: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: convert gw_node custom
	refcounting to kref functions
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
 batman-adv/gateway_client.c |   24 ++++++++++--------------
 batman-adv/types.h          |    2 +-
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index e1264ba..d275560 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -28,15 +28,12 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
-static void gw_node_hold(struct gw_node *gw_node)
+static void gw_node_free_ref(struct kref *refcount)
 {
-	atomic_inc(&gw_node->refcnt);
-}
+	struct gw_node *gw_node;
 
-static void gw_node_put(struct gw_node *gw_node)
-{
-	if (atomic_dec_and_test(&gw_node->refcnt))
-		kfree(gw_node);
+	gw_node = container_of(refcount, struct gw_node, refcount);
+	kfree(gw_node);
 }
 
 void *gw_get_selected(struct bat_priv *bat_priv)
@@ -56,7 +53,7 @@ void gw_deselect(struct bat_priv *bat_priv)
 	bat_priv->curr_gw = NULL;
 
 	if (gw_node)
-		gw_node_put(gw_node);
+		kref_put(&gw_node->refcount, gw_node_free_ref);
 }
 
 static struct gw_node *gw_select(struct bat_priv *bat_priv,
@@ -65,7 +62,7 @@ static struct gw_node *gw_select(struct bat_priv *bat_priv,
 	struct gw_node *curr_gw_node = bat_priv->curr_gw;
 
 	if (new_gw_node)
-		gw_node_hold(new_gw_node);
+		kref_get(&new_gw_node->refcount);
 
 	bat_priv->curr_gw = new_gw_node;
 	return curr_gw_node;
@@ -176,7 +173,7 @@ void gw_election(struct bat_priv *bat_priv)
 
 	/* the kfree() has to be outside of the rcu lock */
 	if (old_gw_node)
-		gw_node_put(old_gw_node);
+		kref_put(&old_gw_node->refcount, gw_node_free_ref);
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
@@ -238,8 +235,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	memset(gw_node, 0, sizeof(struct gw_node));
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
-	atomic_set(&gw_node->refcnt, 0);
-	gw_node_hold(gw_node);
+	kref_init(&gw_node->refcount);
 
 	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
@@ -319,7 +315,7 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 
 			hlist_del_rcu(&gw_node->list);
 			synchronize_rcu();
-			gw_node_put(gw_node);
+			kref_put(&gw_node->refcount, gw_node_free_ref);
 		}
 	}
 
@@ -338,7 +334,7 @@ void gw_node_list_free(struct bat_priv *bat_priv)
 				 &bat_priv->gw_list, list) {
 		hlist_del_rcu(&gw_node->list);
 		synchronize_rcu();
-		gw_node_put(gw_node);
+		kref_put(&gw_node->refcount, gw_node_free_ref);
 	}
 
 	gw_deselect(bat_priv);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index a609100..f5d29e6 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -96,7 +96,7 @@ struct gw_node {
 	struct hlist_node list;
 	struct orig_node *orig_node;
 	unsigned long deleted;
-	atomic_t refcnt;
+	struct kref refcount;
 };
 
 /**
-- 
1.7.1

