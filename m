Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:39 +0100
Message-Id: <1450222316-1764-6-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/23] batman-adv: Convert batadv_gw_node to
	kref
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 71 +++++++++++++++++++++++++----------------
 net/batman-adv/types.h          |  2 +-
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 8350775..a7b9698 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -28,6 +28,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
@@ -59,12 +60,28 @@
  */
 #define BATADV_DHCP_CHADDR_OFFSET	28
 
-static void batadv_gw_node_free_ref(struct batadv_gw_node *gw_node)
+/**
+ * batadv_gw_node_release - release gw_node from lists and queue for free after
+ *  rcu grace period
+ * * @ref: kref pointer of the gw_node
+ */
+static void batadv_gw_node_release(struct kref *ref)
 {
-	if (atomic_dec_and_test(&gw_node->refcount)) {
-		batadv_orig_node_free_ref(gw_node->orig_node);
-		kfree_rcu(gw_node, rcu);
-	}
+	struct batadv_gw_node *gw_node;
+
+	gw_node = container_of(ref, struct batadv_gw_node, refcount);
+
+	batadv_orig_node_free_ref(gw_node->orig_node);
+	kfree_rcu(gw_node, rcu);
+}
+
+/**
+ * batadv_gw_node_put - decrement the gw_node refcounter and possibly release it
+ * @gw_node: gateway node to free
+ */
+static void batadv_gw_node_put(struct batadv_gw_node *gw_node)
+{
+	kref_put(&gw_node->refcount, batadv_gw_node_release);
 }
 
 static struct batadv_gw_node *
@@ -77,7 +94,7 @@ batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
 	if (!gw_node)
 		goto out;
 
-	if (!atomic_inc_not_zero(&gw_node->refcount))
+	if (!kref_get_unless_zero(&gw_node->refcount))
 		gw_node = NULL;
 
 out:
@@ -107,7 +124,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	return orig_node;
 }
 
@@ -118,14 +135,14 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
 
-	if (new_gw_node && !atomic_inc_not_zero(&new_gw_node->refcount))
+	if (new_gw_node && !kref_get_unless_zero(&new_gw_node->refcount))
 		new_gw_node = NULL;
 
 	curr_gw_node = rcu_dereference_protected(bat_priv->gw.curr_gw, 1);
 	rcu_assign_pointer(bat_priv->gw.curr_gw, new_gw_node);
 
 	if (curr_gw_node)
-		batadv_gw_node_free_ref(curr_gw_node);
+		batadv_gw_node_put(curr_gw_node);
 
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
@@ -170,7 +187,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (!router_ifinfo)
 			goto next;
 
-		if (!atomic_inc_not_zero(&gw_node->refcount))
+		if (!kref_get_unless_zero(&gw_node->refcount))
 			goto next;
 
 		tq_avg = router_ifinfo->bat_iv.tq_avg;
@@ -186,9 +203,9 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			    ((tmp_gw_factor == max_gw_factor) &&
 			     (tq_avg > max_tq))) {
 				if (curr_gw)
-					batadv_gw_node_free_ref(curr_gw);
+					batadv_gw_node_put(curr_gw);
 				curr_gw = gw_node;
-				atomic_inc(&curr_gw->refcount);
+				kref_get(&curr_gw->refcount);
 			}
 			break;
 
@@ -201,9 +218,9 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			  */
 			if (tq_avg > max_tq) {
 				if (curr_gw)
-					batadv_gw_node_free_ref(curr_gw);
+					batadv_gw_node_put(curr_gw);
 				curr_gw = gw_node;
-				atomic_inc(&curr_gw->refcount);
+				kref_get(&curr_gw->refcount);
 			}
 			break;
 		}
@@ -214,7 +231,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
 
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 
 next:
 		batadv_neigh_node_free_ref(router);
@@ -255,7 +272,7 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 	 */
 	batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_DEL, NULL);
 
-	batadv_gw_node_free_ref(curr_gw);
+	batadv_gw_node_put(curr_gw);
 }
 
 void batadv_gw_election(struct batadv_priv *bat_priv)
@@ -330,9 +347,9 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 out:
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 	if (next_gw)
-		batadv_gw_node_free_ref(next_gw);
+		batadv_gw_node_put(next_gw);
 	if (router)
 		batadv_neigh_node_free_ref(router);
 	if (router_ifinfo)
@@ -436,7 +453,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	gw_node->orig_node = orig_node;
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
-	atomic_set(&gw_node->refcount, 1);
+	kref_init(&gw_node->refcount);
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.list);
@@ -469,7 +486,7 @@ batadv_gw_node_get(struct batadv_priv *bat_priv,
 		if (gw_node_tmp->orig_node != orig_node)
 			continue;
 
-		if (!atomic_inc_not_zero(&gw_node_tmp->refcount))
+		if (!kref_get_unless_zero(&gw_node_tmp->refcount))
 			continue;
 
 		gw_node = gw_node_tmp;
@@ -530,19 +547,19 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		hlist_del_init_rcu(&gw_node->list);
 		spin_unlock_bh(&bat_priv->gw.list_lock);
 
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (gw_node == curr_gw)
 			batadv_gw_reselect(bat_priv);
 
 		if (curr_gw)
-			batadv_gw_node_free_ref(curr_gw);
+			batadv_gw_node_put(curr_gw);
 	}
 
 out:
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 }
 
 void batadv_gw_node_delete(struct batadv_priv *bat_priv,
@@ -565,7 +582,7 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.list, list) {
 		hlist_del_init_rcu(&gw_node->list);
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	}
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
@@ -602,7 +619,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	ret = seq_has_overflowed(seq) ? -1 : 0;
 
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 out:
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_free_ref(router_ifinfo);
@@ -862,9 +879,9 @@ out:
 	if (orig_dst_node)
 		batadv_orig_node_free_ref(orig_dst_node);
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	if (neigh_old)
 		batadv_neigh_node_free_ref(neigh_old);
 	if (neigh_curr)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 091ad76..0b3cbdb 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -342,7 +342,7 @@ struct batadv_gw_node {
 	struct batadv_orig_node *orig_node;
 	u32 bandwidth_down;
 	u32 bandwidth_up;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

