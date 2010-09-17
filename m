Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 17:41:01 +0200
Message-Id: <1284738065-8715-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv: Use synchronize_rcu instead
	of call_rcu
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

It is recommended [1] to use synchronize_rcu to simplify the code -
especially when otherwise extra locking is needed to protect other code
from picking stale elements. It also protects us for emitting to many
callbacks which may results in OOM conditions.

The only reason not to use it, would be in performance critical sections
or when we are not allowed to block.

[1] Documentation/RCU/checklist.txt

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |   12 ++++--------
 batman-adv/hard-interface.c |   10 ++--------
 batman-adv/types.h          |    2 --
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index bfac0ff..8bc1cb0 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -265,12 +265,6 @@ void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	return gw_node_update(bat_priv, orig_node, 0);
 }
 
-static void gw_node_free(struct rcu_head *rcu)
-{
-	struct gw_node *gw_node = container_of(rcu, struct gw_node, rcu);
-	kfree(gw_node);
-}
-
 void gw_node_purge_deleted(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node;
@@ -286,7 +280,8 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 		    (time_after(jiffies, gw_node->deleted + timeout))) {
 
 			hlist_del_rcu(&gw_node->list);
-			call_rcu(&gw_node->rcu, gw_node_free);
+			synchronize_rcu();
+			kfree(gw_node);
 		}
 	}
 
@@ -304,7 +299,8 @@ void gw_node_list_free(struct bat_priv *bat_priv)
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
 				 &bat_priv->gw_list, list) {
 		hlist_del_rcu(&gw_node->list);
-		call_rcu(&gw_node->rcu, gw_node_free);
+		synchronize_rcu();
+		kfree(gw_node);
 	}
 
 	gw_deselect(bat_priv);
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 3cd7cb1..0b3ee6b 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -420,13 +420,6 @@ out:
 	return NULL;
 }
 
-static void hardif_free_interface(struct rcu_head *rcu)
-{
-	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
-
-	kfree(batman_if);
-}
-
 static void hardif_remove_interface(struct batman_if *batman_if)
 {
 	/* first deactivate interface */
@@ -440,9 +433,10 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 
 	/* caller must take if_list_lock */
 	list_del_rcu(&batman_if->list);
+	synchronize_rcu();
 	sysfs_del_hardif(&batman_if->hardif_obj);
 	dev_put(batman_if->net_dev);
-	call_rcu(&batman_if->rcu, hardif_free_interface);
+	kfree(batman_if);
 }
 
 void hardif_remove_interfaces(void)
diff --git a/batman-adv/types.h b/batman-adv/types.h
index e7b53a4..1940404 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -44,7 +44,6 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
-	struct rcu_head rcu;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 };
@@ -96,7 +95,6 @@ struct gw_node {
 	struct hlist_node list;
 	struct orig_node *orig_node;
 	unsigned long deleted;
-	struct rcu_head rcu;
 };
 
 /**
-- 
1.7.2.3

