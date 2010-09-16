Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 22:18:35 +0200
Message-Id: <1284668317-19890-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284668317-19890-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284668317-19890-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Protect update side of
	gw_list
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
To: b.a.t.m.a.n@lists.open-mesh.net

hlist_add_head_rcu must be protected using gw_list_lock of the current
bat_priv like already done with hlist_del_rcu.

It is important that this lock is now always done using
spin_lock_irqsave because gw_node_add can also be called indirectly from
parts of the kernel with interrupts disabled.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 6721398..dd96d99 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -196,6 +196,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
 {
 	struct gw_node *gw_node;
 	int down, up;
+	unsigned long flags;
 
 	gw_node = kmalloc(sizeof(struct gw_node), GFP_ATOMIC);
 	if (!gw_node)
@@ -205,7 +206,9 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
 
+	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
+	spin_unlock_irqrestore(&bat_priv->gw_list_lock, flags);
 
 	gw_srv_class_to_kbit(new_gwflags, &down, &up);
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -273,8 +276,9 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 	struct gw_node *gw_node;
 	struct hlist_node *node, *node_tmp;
 	unsigned long timeout = 2 * PURGE_TIMEOUT * HZ;
+	unsigned long flags;
 
-	spin_lock(&bat_priv->gw_list_lock);
+	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
 
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
 						&bat_priv->gw_list, list) {
@@ -286,15 +290,16 @@ void gw_node_purge_deleted(struct bat_priv *bat_priv)
 		}
 	}
 
-	spin_unlock(&bat_priv->gw_list_lock);
+	spin_unlock_irqrestore(&bat_priv->gw_list_lock, flags);
 }
 
 void gw_node_list_free(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node;
 	struct hlist_node *node, *node_tmp;
+	unsigned long flags;
 
-	spin_lock(&bat_priv->gw_list_lock);
+	spin_lock_irqsave(&bat_priv->gw_list_lock, flags);
 
 	hlist_for_each_entry_safe(gw_node, node, node_tmp,
 				 &bat_priv->gw_list, list) {
@@ -303,7 +308,7 @@ void gw_node_list_free(struct bat_priv *bat_priv)
 	}
 
 	gw_deselect(bat_priv);
-	spin_unlock(&bat_priv->gw_list_lock);
+	spin_unlock_irqrestore(&bat_priv->gw_list_lock, flags);
 }
 
 static int _write_buffer_text(struct bat_priv *bat_priv,
-- 
1.7.2.3

