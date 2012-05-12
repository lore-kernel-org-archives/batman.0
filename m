Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 18:33:57 +0200
Message-Id: <1336840447-6580-8-git-send-email-sven@narfation.org>
In-Reply-To: <1336840447-6580-1-git-send-email-sven@narfation.org>
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/18] batman-adv: Prefix hard-interface
	local static functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hard-interface.c |   62 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 0337fed..4b9db9a 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -58,7 +58,7 @@ out:
 	return hard_iface;
 }
 
-static int is_valid_iface(const struct net_device *net_dev)
+static int batadv_is_valid_iface(const struct net_device *net_dev)
 {
 	if (net_dev->flags & IFF_LOOPBACK)
 		return 0;
@@ -76,7 +76,8 @@ static int is_valid_iface(const struct net_device *net_dev)
 	return 1;
 }
 
-static struct hard_iface *hardif_get_active(const struct net_device *soft_iface)
+static struct hard_iface *
+batadv_hardif_get_active(const struct net_device *soft_iface)
 {
 	struct hard_iface *hard_iface;
 
@@ -97,8 +98,8 @@ out:
 	return hard_iface;
 }
 
-static void primary_if_update_addr(struct bat_priv *bat_priv,
-				   struct hard_iface *oldif)
+static void batadv_primary_if_update_addr(struct bat_priv *bat_priv,
+					  struct hard_iface *oldif)
 {
 	struct vis_packet *vis_packet;
 	struct hard_iface *primary_if;
@@ -121,8 +122,8 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-static void primary_if_select(struct bat_priv *bat_priv,
-			      struct hard_iface *new_hard_iface)
+static void batadv_primary_if_select(struct bat_priv *bat_priv,
+				     struct hard_iface *new_hard_iface)
 {
 	struct hard_iface *curr_hard_iface;
 
@@ -138,14 +139,14 @@ static void primary_if_select(struct bat_priv *bat_priv,
 		goto out;
 
 	bat_priv->bat_algo_ops->bat_primary_iface_set(new_hard_iface);
-	primary_if_update_addr(bat_priv, curr_hard_iface);
+	batadv_primary_if_update_addr(bat_priv, curr_hard_iface);
 
 out:
 	if (curr_hard_iface)
 		batadv_hardif_free_ref(curr_hard_iface);
 }
 
-static bool hardif_is_iface_up(const struct hard_iface *hard_iface)
+static bool batadv_hardif_is_iface_up(const struct hard_iface *hard_iface)
 {
 	if (hard_iface->net_dev->flags & IFF_UP)
 		return true;
@@ -153,7 +154,7 @@ static bool hardif_is_iface_up(const struct hard_iface *hard_iface)
 	return false;
 }
 
-static void check_known_mac_addr(const struct net_device *net_dev)
+static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 {
 	const struct hard_iface *hard_iface;
 
@@ -216,7 +217,7 @@ void batadv_update_min_mtu(struct net_device *soft_iface)
 		soft_iface->mtu = min_mtu;
 }
 
-static void hardif_activate_interface(struct hard_iface *hard_iface)
+static void batadv_hardif_activate_interface(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv;
 	struct hard_iface *primary_if = NULL;
@@ -234,7 +235,7 @@ static void hardif_activate_interface(struct hard_iface *hard_iface)
 	 */
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
-		primary_if_select(bat_priv, hard_iface);
+		batadv_primary_if_select(bat_priv, hard_iface);
 
 	bat_info(hard_iface->soft_iface, "Interface activated: %s\n",
 		 hard_iface->net_dev->name);
@@ -246,7 +247,7 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-static void hardif_deactivate_interface(struct hard_iface *hard_iface)
+static void batadv_hardif_deactivate_interface(struct hard_iface *hard_iface)
 {
 	if ((hard_iface->if_status != IF_ACTIVE) &&
 	    (hard_iface->if_status != IF_TO_BE_ACTIVATED))
@@ -334,8 +335,8 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 			 hard_iface->net_dev->name, hard_iface->net_dev->mtu,
 			 ETH_DATA_LEN + BAT_HEADER_LEN);
 
-	if (hardif_is_iface_up(hard_iface))
-		hardif_activate_interface(hard_iface);
+	if (batadv_hardif_is_iface_up(hard_iface))
+		batadv_hardif_activate_interface(hard_iface);
 	else
 		bat_err(hard_iface->soft_iface,
 			"Not using interface %s (retrying later): interface not active\n",
@@ -360,7 +361,7 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 	struct hard_iface *primary_if = NULL;
 
 	if (hard_iface->if_status == IF_ACTIVE)
-		hardif_deactivate_interface(hard_iface);
+		batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != IF_INACTIVE)
 		goto out;
@@ -376,8 +377,8 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 	if (hard_iface == primary_if) {
 		struct hard_iface *new_if;
 
-		new_if = hardif_get_active(hard_iface->soft_iface);
-		primary_if_select(bat_priv, new_if);
+		new_if = batadv_hardif_get_active(hard_iface->soft_iface);
+		batadv_primary_if_select(bat_priv, new_if);
 
 		if (new_if)
 			batadv_hardif_free_ref(new_if);
@@ -403,14 +404,15 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
+static struct hard_iface *
+batadv_hardif_add_interface(struct net_device *net_dev)
 {
 	struct hard_iface *hard_iface;
 	int ret;
 
 	ASSERT_RTNL();
 
-	ret = is_valid_iface(net_dev);
+	ret = batadv_is_valid_iface(net_dev);
 	if (ret != 1)
 		goto out;
 
@@ -432,7 +434,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	/* extra reference for return */
 	atomic_set(&hard_iface->refcount, 2);
 
-	check_known_mac_addr(hard_iface->net_dev);
+	batadv_check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 
 	/* This can't be called via a bat_priv callback because
@@ -451,7 +453,7 @@ out:
 	return NULL;
 }
 
-static void hardif_remove_interface(struct hard_iface *hard_iface)
+static void batadv_hardif_remove_interface(struct hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
 
@@ -475,12 +477,12 @@ void batadv_hardif_remove_interfaces(void)
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
 				 &batadv_hardif_list, list) {
 		list_del_rcu(&hard_iface->list);
-		hardif_remove_interface(hard_iface);
+		batadv_hardif_remove_interface(hard_iface);
 	}
 	rtnl_unlock();
 }
 
-static int hard_if_event(struct notifier_block *this,
+static int batadv_hard_if_event(struct notifier_block *this,
 			 unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = ptr;
@@ -489,23 +491,23 @@ static int hard_if_event(struct notifier_block *this,
 	struct bat_priv *bat_priv;
 
 	if (!hard_iface && event == NETDEV_REGISTER)
-		hard_iface = hardif_add_interface(net_dev);
+		hard_iface = batadv_hardif_add_interface(net_dev);
 
 	if (!hard_iface)
 		goto out;
 
 	switch (event) {
 	case NETDEV_UP:
-		hardif_activate_interface(hard_iface);
+		batadv_hardif_activate_interface(hard_iface);
 		break;
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
-		hardif_deactivate_interface(hard_iface);
+		batadv_hardif_deactivate_interface(hard_iface);
 		break;
 	case NETDEV_UNREGISTER:
 		list_del_rcu(&hard_iface->list);
 
-		hardif_remove_interface(hard_iface);
+		batadv_hardif_remove_interface(hard_iface);
 		break;
 	case NETDEV_CHANGEMTU:
 		if (hard_iface->soft_iface)
@@ -515,7 +517,7 @@ static int hard_if_event(struct notifier_block *this,
 		if (hard_iface->if_status == IF_NOT_IN_USE)
 			goto hardif_put;
 
-		check_known_mac_addr(hard_iface->net_dev);
+		batadv_check_known_mac_addr(hard_iface->net_dev);
 
 		bat_priv = netdev_priv(hard_iface->soft_iface);
 		bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
@@ -525,7 +527,7 @@ static int hard_if_event(struct notifier_block *this,
 			goto hardif_put;
 
 		if (hard_iface == primary_if)
-			primary_if_update_addr(bat_priv, NULL);
+			batadv_primary_if_update_addr(bat_priv, NULL);
 		break;
 	default:
 		break;
@@ -572,5 +574,5 @@ out:
 }
 
 struct notifier_block batadv_hard_if_notifier = {
-	.notifier_call = hard_if_event,
+	.notifier_call = batadv_hard_if_event,
 };
-- 
1.7.10

