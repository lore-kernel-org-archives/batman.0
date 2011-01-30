Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Jan 2011 02:52:56 +0100
Message-Id: <1296352379-1546-2-git-send-email-sven@narfation.org>
In-Reply-To: <1296352379-1546-1-git-send-email-sven@narfation.org>
References: <1296352379-1546-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Correct rcu refcounting for
	gw_node
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

<TODO: write a long monologue about every problem we have or could have or
maybe never had and would have when we not have it>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/gateway_client.c |   28 +++++++++++++---------------
 batman-adv/types.h          |    2 +-
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 429a013..8ce3a63 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -28,20 +28,18 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
-static void gw_node_free_ref(struct kref *refcount)
-{
-	struct gw_node *gw_node;
-
-	gw_node = container_of(refcount, struct gw_node, refcount);
-	kfree(gw_node);
-}
-
 static void gw_node_free_rcu(struct rcu_head *rcu)
 {
 	struct gw_node *gw_node;
 
 	gw_node = container_of(rcu, struct gw_node, rcu);
-	kref_put(&gw_node->refcount, gw_node_free_ref);
+	kfree(gw_node);
+}
+
+static void gw_node_free_ref(struct gw_node *gw_node)
+{
+	if (atomic_dec_and_test(&gw_node->refcount))
+		call_rcu(&gw_node->rcu, gw_node_free_rcu);
 }
 
 void *gw_get_selected(struct bat_priv *bat_priv)
@@ -61,7 +59,7 @@ void gw_deselect(struct bat_priv *bat_priv)
 	bat_priv->curr_gw = NULL;
 
 	if (gw_node)
-		kref_put(&gw_node->refcount, gw_node_free_ref);
+		gw_node_free_ref(gw_node);
 }
 
 static struct gw_node *gw_select(struct bat_priv *bat_priv,
@@ -69,8 +67,8 @@ static struct gw_node *gw_select(struct bat_priv *bat_priv,
 {
 	struct gw_node *curr_gw_node = bat_priv->curr_gw;
 
-	if (new_gw_node)
-		kref_get(&new_gw_node->refcount);
+	if (new_gw_node && !atomic_inc_not_zero(&new_gw_node->refcount))
+		return NULL;
 
 	bat_priv->curr_gw = new_gw_node;
 	return curr_gw_node;
@@ -181,7 +179,7 @@ void gw_election(struct bat_priv *bat_priv)
 
 	/* the kfree() has to be outside of the rcu lock */
 	if (old_gw_node)
-		kref_put(&old_gw_node->refcount, gw_node_free_ref);
+		gw_node_free_ref(old_gw_node);
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
@@ -242,7 +240,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	memset(gw_node, 0, sizeof(struct gw_node));
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
-	kref_init(&gw_node->refcount);
+	atomic_set(&gw_node->refcount, 1);
 
 	spin_lock_bh(&bat_priv->gw_list_lock);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
@@ -325,7 +323,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
 			gw_deselect(bat_priv);
 
 		hlist_del_rcu(&gw_node->list);
-		call_rcu(&gw_node->rcu, gw_node_free_rcu);
+		gw_node_free_ref(gw_node);
 	}
 
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index e4a0462..ca5f20a 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -100,7 +100,7 @@ struct gw_node {
 	struct hlist_node list;
 	struct orig_node *orig_node;
 	unsigned long deleted;
-	struct kref refcount;
+	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
-- 
1.7.2.3

