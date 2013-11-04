Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  4 Nov 2013 20:59:41 +0100
Message-Id: <1383595181-2061-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1383595181-2061-1-git-send-email-antonio@meshcoding.com>
References: <1383595181-2061-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: rename gw_deselect() to
	gw_reselect()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The function batadv_gw_deselect() is actually not deselecting
anything. It is just informing the GW code to perform a
re-election procedure when possible.
The current gateway is not being touched at all and therefore
the name of this function is rather misleading.

Rename it to batadv_gw_reselect() to batadv_gw_reselect()
to make its behaviour easier to grasp.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 gateway_client.c | 35 +++++++++++++++++++++++------------
 gateway_client.h |  2 +-
 gateway_common.c |  2 +-
 sysfs.c          | 10 +++++-----
 4 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 2903bdb..fcaebec 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -105,7 +105,18 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
 
-void batadv_gw_deselect(struct batadv_priv *bat_priv)
+/**
+ * batadv_gw_reselect - force a gateway reselection
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Set a flag to remind the GW component to perform a new gateway reselection.
+ * However this function does not ensure that the current gateway is going to be
+ * deselected. The reselection mechanism may elect the same gateway once again.
+ *
+ * This means that invoking batadv_gw_reselect() does not guarantee a gateway
+ * change and therefore a uevent is not necessarily expected.
+ */
+void batadv_gw_reselect(struct batadv_priv *bat_priv)
 {
 	atomic_set(&bat_priv->gw.reselect, 1);
 }
@@ -243,7 +254,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 		router = batadv_orig_node_get_router(next_gw->orig_node);
 		if (!router) {
-			batadv_gw_deselect(bat_priv);
+			batadv_gw_reselect(bat_priv);
 			goto out;
 		}
 	}
@@ -295,11 +306,11 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 
 	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
 	if (!curr_gw_orig)
-		goto deselect;
+		goto reselect;
 
 	router_gw = batadv_orig_node_get_router(curr_gw_orig);
 	if (!router_gw)
-		goto deselect;
+		goto reselect;
 
 	/* this node already is the gateway */
 	if (curr_gw_orig == orig_node)
@@ -327,8 +338,8 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 		   "Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i)\n",
 		   gw_tq_avg, orig_tq_avg);
 
-deselect:
-	batadv_gw_deselect(bat_priv);
+reselect:
+	batadv_gw_reselect(bat_priv);
 out:
 	if (curr_gw_orig)
 		batadv_orig_node_free_ref(curr_gw_orig);
@@ -458,7 +469,7 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		 */
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (gw_node == curr_gw)
-			batadv_gw_deselect(bat_priv);
+			batadv_gw_reselect(bat_priv);
 	}
 
 out:
@@ -484,7 +495,7 @@ void batadv_gw_node_purge(struct batadv_priv *bat_priv)
 	struct batadv_gw_node *gw_node, *curr_gw;
 	struct hlist_node *node_tmp;
 	unsigned long timeout = msecs_to_jiffies(2 * BATADV_PURGE_TIMEOUT);
-	int do_deselect = 0;
+	int do_reselect = 0;
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
@@ -498,7 +509,7 @@ void batadv_gw_node_purge(struct batadv_priv *bat_priv)
 			continue;
 
 		if (curr_gw == gw_node)
-			do_deselect = 1;
+			do_reselect = 1;
 
 		hlist_del_rcu(&gw_node->list);
 		batadv_gw_node_free_ref(gw_node);
@@ -506,9 +517,9 @@ void batadv_gw_node_purge(struct batadv_priv *bat_priv)
 
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 
-	/* gw_deselect() needs to acquire the gw_list_lock */
-	if (do_deselect)
-		batadv_gw_deselect(bat_priv);
+	/* gw_reselect() needs to acquire the gw_list_lock */
+	if (do_reselect)
+		batadv_gw_reselect(bat_priv);
 
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);
diff --git a/gateway_client.h b/gateway_client.h
index d95c2d2..e73cb15 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -21,7 +21,7 @@
 #define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 
 void batadv_gw_check_client_stop(struct batadv_priv *bat_priv);
-void batadv_gw_deselect(struct batadv_priv *bat_priv);
+void batadv_gw_reselect(struct batadv_priv *bat_priv);
 void batadv_gw_election(struct batadv_priv *bat_priv);
 struct batadv_orig_node *
 batadv_gw_get_selected_orig(struct batadv_priv *bat_priv);
diff --git a/gateway_common.c b/gateway_common.c
index b211b0f..5795d9a 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -164,7 +164,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 	if ((down_curr == down_new) && (up_curr == up_new))
 		return count;
 
-	batadv_gw_deselect(bat_priv);
+	batadv_gw_reselect(bat_priv);
 	batadv_info(net_dev,
 		    "Changing gateway bandwidth from: '%u.%u/%u.%u MBit' to: '%u.%u/%u.%u MBit'\n",
 		    down_curr / 10, down_curr % 10, up_curr / 10, up_curr % 10,
diff --git a/sysfs.c b/sysfs.c
index d1765fd..c686313 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -329,10 +329,10 @@ static ssize_t batadv_show_bat_algo(struct kobject *kobj,
 	return sprintf(buff, "%s\n", bat_priv->bat_algo_ops->name);
 }
 
-static void batadv_post_gw_deselect(struct net_device *net_dev)
+static void batadv_post_gw_reselect(struct net_device *net_dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	batadv_gw_deselect(bat_priv);
+	batadv_gw_reselect(bat_priv);
 }
 
 static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
@@ -408,7 +408,7 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	batadv_info(net_dev, "Changing gw mode from: %s to: %s\n",
 		    curr_gw_mode_str, buff);
 
-	/* invoking batadv_gw_deselect() is not enough to really de-select the
+	/* invoking batadv_gw_reselect() is not enough to really de-select the
 	 * current GW. It will only instruct the gateway code to perform a
 	 * re-election the next time that this is needed.
 	 *
@@ -417,7 +417,7 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	 * client mode reactivation. This is operation is performed in
 	 * batadv_gw_check_client_stop().
 	 */
-	batadv_gw_deselect(bat_priv);
+	batadv_gw_reselect(bat_priv);
 	/* always call batadv_gw_check_client_stop() before changing the gateway
 	 * state
 	 */
@@ -470,7 +470,7 @@ BATADV_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * BATADV_JITTER,
 BATADV_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, BATADV_TQ_MAX_VALUE,
 		     NULL);
 BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
-		     batadv_post_gw_deselect);
+		     batadv_post_gw_reselect);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-- 
1.8.4.2

