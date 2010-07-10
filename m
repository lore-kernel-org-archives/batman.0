Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 10 Jul 2010 16:06:45 +0200
Message-Id: <1278770807-14512-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201007101606.27989.lindner_marek@yahoo.de>
References: <201007101606.27989.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: attach each hard-interface
	to a soft-interface
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

This patch replaces the static bat0 interface with a dynamic/abstracted
approach. It is now possible to create multiple batX interfaces by
assigning hard interfaces to them. Each batX interface acts as an
independent mesh network. A soft interface is removed once no hard
interface references it any longer.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/aggregation.c       |    3 +-
 batman-adv/bat_sysfs.c         |   51 ++++++-----------
 batman-adv/bitarray.c          |    7 +-
 batman-adv/bitarray.h          |    4 +-
 batman-adv/gateway_client.c    |   20 +++----
 batman-adv/gateway_client.h    |    7 +-
 batman-adv/hard-interface.c    |  114 ++++++++++++++++++++++++--------------
 batman-adv/hard-interface.h    |    6 +-
 batman-adv/hash.c              |    6 +-
 batman-adv/hash.h              |    4 +-
 batman-adv/icmp_socket.c       |    6 +-
 batman-adv/main.c              |   54 +-----------------
 batman-adv/main.h              |    2 -
 batman-adv/originator.c        |   45 +++++++--------
 batman-adv/originator.h        |    2 +-
 batman-adv/routing.c           |  121 ++++++++++++++++++++--------------------
 batman-adv/routing.h           |   10 ++--
 batman-adv/send.c              |   47 ++++++++--------
 batman-adv/send.h              |    2 +-
 batman-adv/soft-interface.c    |  118 ++++++++++++++++++++++++++++++--------
 batman-adv/soft-interface.h    |    7 +-
 batman-adv/translation-table.c |   58 ++++++++++---------
 batman-adv/translation-table.h |   13 +++--
 batman-adv/types.h             |    2 +
 batman-adv/vis.c               |   15 ++---
 25 files changed, 379 insertions(+), 345 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index d738b7a..853a74c 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -106,8 +106,7 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 {
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 
 	/* own packet should always be scheduled */
 	if (!own_packet) {
diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index b5d47ca..c7b56a0 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -352,21 +352,6 @@ int sysfs_add_meshif(struct net_device *dev)
 	struct bat_attribute **bat_attr;
 	int err;
 
-	/* FIXME: should be done in the general mesh setup
-		  routine as soon as we have it */
-	atomic_set(&bat_priv->aggregation_enabled, 1);
-	atomic_set(&bat_priv->bonding_enabled, 0);
-	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
-	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
-	atomic_set(&bat_priv->gw_class, 0);
-	atomic_set(&bat_priv->orig_interval, 1000);
-	atomic_set(&bat_priv->log_level, 0);
-	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
-	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
-
-	bat_priv->primary_if = NULL;
-	bat_priv->num_ifaces = 0;
-
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
 	if (!bat_priv->mesh_obj) {
@@ -436,32 +421,34 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (!batman_if)
 		return count;
 
-	if (strncmp(buff, "none", 4) == 0)
-		status_tmp = IF_NOT_IN_USE;
-
-	if (strncmp(buff, "bat0", 4) == 0)
-		status_tmp = IF_I_WANT_YOU;
-
-	if (status_tmp < 0) {
-		if (buff[count - 1] == '\n')
-			buff[count - 1] = '\0';
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
 
+	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: "
-		       "%s\n", buff);
+		       "interface name too long '%s'\n", buff);
 		return -EINVAL;
 	}
 
-	if ((batman_if->if_status == status_tmp) ||
-	    ((status_tmp == IF_I_WANT_YOU) &&
-	     (batman_if->if_status != IF_NOT_IN_USE)))
+	if (strncmp(buff, "none", 4) == 0)
+		status_tmp = IF_NOT_IN_USE;
+	else
+		status_tmp = IF_I_WANT_YOU;
+
+	if ((batman_if->if_status == status_tmp) || ((batman_if->soft_iface) &&
+	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0)))
 		return count;
 
-	if (status_tmp == IF_I_WANT_YOU)
-		status_tmp = hardif_enable_interface(batman_if);
-	else
+	if (status_tmp == IF_NOT_IN_USE) {
+		hardif_disable_interface(batman_if);
+		return count;
+	}
+
+	/* if the interface already is in use */
+	if (batman_if->if_status != IF_NOT_IN_USE)
 		hardif_disable_interface(batman_if);
 
-	return (status_tmp < 0 ? status_tmp : count);
+	return hardif_enable_interface(batman_if, buff);
 }
 
 static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
diff --git a/batman-adv/bitarray.c b/batman-adv/bitarray.c
index dd4193c..eb2dd70 100644
--- a/batman-adv/bitarray.c
+++ b/batman-adv/bitarray.c
@@ -125,11 +125,10 @@ static void bit_reset_window(TYPE_OF_WORD *seq_bits)
  *  1 if the window was moved (either new or very old)
  *  0 if the window was not moved/shifted.
  */
-char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
-		    int8_t set_mark)
+char bit_get_packet(void *priv, TYPE_OF_WORD *seq_bits,
+		    int32_t seq_num_diff, int8_t set_mark)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = (struct bat_priv *)priv;
 
 	/* sequence number is slightly older. We already got a sequence number
 	 * higher than this one, so we just mark it. */
diff --git a/batman-adv/bitarray.h b/batman-adv/bitarray.h
index 01897d6..caa545c 100644
--- a/batman-adv/bitarray.h
+++ b/batman-adv/bitarray.h
@@ -37,8 +37,8 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n);
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
-char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
-					int8_t set_mark);
+char bit_get_packet(void *priv, TYPE_OF_WORD *seq_bits,
+		    int32_t seq_num_diff, int8_t set_mark);
 
 /* count the hamming weight, how many good packets did we receive? */
 int  bit_packet_count(TYPE_OF_WORD *seq_bits);
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index f50bc41..d2de0e1 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -54,10 +54,8 @@ void gw_deselect(void)
 	spin_unlock(&curr_gw_lock);
 }
 
-void gw_election(void)
+void gw_election(struct bat_priv *bat_priv)
 {
-	/* FIXME: get bat_priv */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct gw_node *gw_node, *curr_gw_tmp = NULL;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
@@ -209,10 +207,9 @@ deselect:
 	gw_deselect();
 }
 
-static void gw_node_add(struct orig_node *orig_node, uint8_t new_gwflags)
+static void gw_node_add(struct bat_priv *bat_priv,
+			struct orig_node *orig_node, uint8_t new_gwflags)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct gw_node *gw_node;
 	int down, up;
 
@@ -236,10 +233,9 @@ static void gw_node_add(struct orig_node *orig_node, uint8_t new_gwflags)
 		(up > 2048 ? "MBit" : "KBit"));
 }
 
-void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
+void gw_node_update(struct bat_priv *bat_priv,
+		    struct orig_node *orig_node, uint8_t new_gwflags)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct gw_node *gw_node;
 
 	rcu_read_lock();
@@ -273,12 +269,12 @@ void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
 	if (new_gwflags == 0)
 		return;
 
-	gw_node_add(orig_node, new_gwflags);
+	gw_node_add(bat_priv, orig_node, new_gwflags);
 }
 
-void gw_node_delete(struct orig_node *orig_node)
+void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
-	return gw_node_update(orig_node, 0);
+	return gw_node_update(bat_priv, orig_node, 0);
 }
 
 static void gw_node_free(struct rcu_head *rcu)
diff --git a/batman-adv/gateway_client.h b/batman-adv/gateway_client.h
index 1c24187..19a82a7 100644
--- a/batman-adv/gateway_client.h
+++ b/batman-adv/gateway_client.h
@@ -23,11 +23,12 @@
 #define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 
 void gw_deselect(void);
-void gw_election(void);
+void gw_election(struct bat_priv *bat_priv);
 void *gw_get_selected(void);
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
-void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags);
-void gw_node_delete(struct orig_node *orig_node);
+void gw_node_update(struct bat_priv *bat_priv,
+		    struct orig_node *orig_node, uint8_t new_gwflags);
+void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_purge_deleted(void);
 void gw_node_list_free(void);
 int gw_client_seq_print_text(struct seq_file *seq, void *offset);
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 5ff9dcb..7f413c3 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -160,7 +160,7 @@ static void check_known_mac_addr(uint8_t *addr)
 	rcu_read_unlock();
 }
 
-int hardif_min_mtu(void)
+int hardif_min_mtu(struct net_device *soft_iface)
 {
 	struct batman_if *batman_if;
 	/* allow big frames if all devices are capable to do so
@@ -169,10 +169,15 @@ int hardif_min_mtu(void)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if ((batman_if->if_status == IF_ACTIVE) ||
-		    (batman_if->if_status == IF_TO_BE_ACTIVATED))
-			min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
-				      min_mtu);
+		if ((batman_if->if_status != IF_ACTIVE) &&
+		    (batman_if->if_status != IF_TO_BE_ACTIVATED))
+			continue;
+
+		if (batman_if->soft_iface != soft_iface)
+			continue;
+
+		min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
+			      min_mtu);
 	}
 	rcu_read_unlock();
 
@@ -180,22 +185,23 @@ int hardif_min_mtu(void)
 }
 
 /* adjusts the MTU if a new interface with a smaller MTU appeared. */
-void update_min_mtu(void)
+void update_min_mtu(struct net_device *soft_iface)
 {
 	int min_mtu;
 
-	min_mtu = hardif_min_mtu();
-	if (soft_device->mtu != min_mtu)
-		soft_device->mtu = min_mtu;
+	min_mtu = hardif_min_mtu(soft_iface);
+	if (soft_iface->mtu != min_mtu)
+		soft_iface->mtu = min_mtu;
 }
 
-static void hardif_activate_interface(struct net_device *net_dev,
-				      struct bat_priv *bat_priv,
-				      struct batman_if *batman_if)
+static void hardif_activate_interface(struct batman_if *batman_if)
 {
+	struct bat_priv *bat_priv;
+
 	if (batman_if->if_status != IF_INACTIVE)
 		return;
 
+	bat_priv = netdev_priv(batman_if->soft_iface);
 	dev_hold(batman_if->net_dev);
 
 	update_mac_addresses(batman_if);
@@ -208,17 +214,17 @@ static void hardif_activate_interface(struct net_device *net_dev,
 	if (!bat_priv->primary_if)
 		set_primary_if(bat_priv, batman_if);
 
-	bat_info(net_dev, "Interface activated: %s\n", batman_if->dev);
+	bat_info(batman_if->soft_iface, "Interface activated: %s\n",
+		 batman_if->dev);
 
 	if (atomic_read(&module_state) == MODULE_INACTIVE)
 		activate_module();
 
-	update_min_mtu();
+	update_min_mtu(batman_if->soft_iface);
 	return;
 }
 
-static void hardif_deactivate_interface(struct net_device *net_dev,
-					struct batman_if *batman_if)
+static void hardif_deactivate_interface(struct batman_if *batman_if)
 {
 	if ((batman_if->if_status != IF_ACTIVE) &&
 	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
@@ -228,26 +234,39 @@ static void hardif_deactivate_interface(struct net_device *net_dev,
 
 	batman_if->if_status = IF_INACTIVE;
 
-	bat_info(net_dev, "Interface deactivated: %s\n", batman_if->dev);
+	bat_info(batman_if->soft_iface, "Interface deactivated: %s\n",
+		 batman_if->dev);
 
-	update_min_mtu();
+	update_min_mtu(batman_if->soft_iface);
 }
 
-int hardif_enable_interface(struct batman_if *batman_if)
+int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet;
 
 	if (batman_if->if_status != IF_NOT_IN_USE)
 		goto out;
 
+	batman_if->soft_iface = dev_get_by_name(&init_net, iface_name);
+
+	if (!batman_if->soft_iface) {
+		batman_if->soft_iface = softif_create(iface_name);
+
+		if (!batman_if->soft_iface)
+			goto err;
+
+		/* dev_get_by_name() increases the reference counter for us */
+		dev_hold(batman_if->soft_iface);
+	}
+
+	bat_priv = netdev_priv(batman_if->soft_iface);
 	batman_if->packet_len = BAT_PACKET_LEN;
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
-		bat_err(soft_device, "Can't add interface packet (%s): "
-			"out of memory\n", batman_if->dev);
+		bat_err(batman_if->soft_iface, "Can't add interface packet "
+			"(%s): out of memory\n", batman_if->dev);
 		goto err;
 	}
 
@@ -265,12 +284,13 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
 	atomic_set(&batman_if->seqno, 1);
-	bat_info(soft_device, "Adding interface: %s\n", batman_if->dev);
+	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
+		 batman_if->dev);
 
 	if (hardif_is_iface_up(batman_if))
-		hardif_activate_interface(soft_device, bat_priv, batman_if);
+		hardif_activate_interface(batman_if);
 	else
-		bat_err(soft_device, "Not using interface %s "
+		bat_err(batman_if->soft_iface, "Not using interface %s "
 			"(retrying later): interface not active\n",
 			batman_if->dev);
 
@@ -286,16 +306,16 @@ err:
 
 void hardif_disable_interface(struct batman_if *batman_if)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 
 	if (batman_if->if_status == IF_ACTIVE)
-		hardif_deactivate_interface(soft_device, batman_if);
+		hardif_deactivate_interface(batman_if);
 
 	if (batman_if->if_status != IF_INACTIVE)
 		return;
 
-	bat_info(soft_device, "Removing interface: %s\n", batman_if->dev);
+	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
+		 batman_if->dev);
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
@@ -305,10 +325,17 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	kfree(batman_if->packet_buff);
 	batman_if->packet_buff = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
+	dev_put(batman_if->soft_iface);
+
+	/* nobody uses this interface anymore */
+	if (!bat_priv->num_ifaces)
+		softif_destroy(batman_if->soft_iface);
 
-	if ((atomic_read(&module_state) == MODULE_ACTIVE) &&
-	    (bat_priv->num_ifaces == 0))
-		deactivate_module();
+	batman_if->soft_iface = NULL;
+
+// 	if ((atomic_read(&module_state) == MODULE_ACTIVE) &&
+// 	    (bat_priv->num_ifaces == 0))
+// 		deactivate_module();
 }
 
 static struct batman_if *hardif_add_interface(struct net_device *net_dev)
@@ -337,6 +364,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if->if_num = -1;
 	batman_if->net_dev = net_dev;
+	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&batman_if->list);
 
@@ -392,8 +420,7 @@ static int hard_if_event(struct notifier_block *this,
 {
 	struct net_device *net_dev = (struct net_device *)ptr;
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 
 	if (!batman_if)
 		batman_if = hardif_add_interface(net_dev);
@@ -405,11 +432,11 @@ static int hard_if_event(struct notifier_block *this,
 	case NETDEV_REGISTER:
 		break;
 	case NETDEV_UP:
-		hardif_activate_interface(soft_device, bat_priv, batman_if);
+		hardif_activate_interface(batman_if);
 		break;
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
-		hardif_deactivate_interface(soft_device, batman_if);
+		hardif_deactivate_interface(batman_if);
 		break;
 	case NETDEV_UNREGISTER:
 		hardif_remove_interface(batman_if);
@@ -417,8 +444,13 @@ static int hard_if_event(struct notifier_block *this,
 	case NETDEV_CHANGENAME:
 		break;
 	case NETDEV_CHANGEADDR:
+		if (batman_if->if_status == IF_NOT_IN_USE)
+			goto out;
+
 		check_known_mac_addr(batman_if->net_dev->dev_addr);
 		update_mac_addresses(batman_if);
+
+		bat_priv = netdev_priv(batman_if->soft_iface);
 		if (batman_if == bat_priv->primary_if)
 			set_primary_if(bat_priv, batman_if);
 		break;
@@ -440,8 +472,7 @@ static int batman_skb_recv_finish(struct sk_buff *skb)
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct packet_type *ptype, struct net_device *orig_dev)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
 	struct net_device_stats *stats;
@@ -487,6 +518,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	batman_packet = (struct batman_packet *)skb->data;
+	bat_priv = netdev_priv(batman_if->soft_iface);
 
 	if (batman_packet->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -516,12 +548,12 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 		/* broadcast packet */
 	case BAT_BCAST:
-		ret = recv_bcast_packet(skb);
+		ret = recv_bcast_packet(skb, batman_if);
 		break;
 
 		/* vis packet */
 	case BAT_VIS:
-		ret = recv_vis_packet(skb);
+		ret = recv_vis_packet(skb, batman_if);
 		break;
 	default:
 		ret = NET_RX_DROP;
diff --git a/batman-adv/hard-interface.h b/batman-adv/hard-interface.h
index d5640b0..4b49527 100644
--- a/batman-adv/hard-interface.h
+++ b/batman-adv/hard-interface.h
@@ -32,14 +32,14 @@
 extern struct notifier_block hard_if_notifier;
 
 struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev);
-int hardif_enable_interface(struct batman_if *batman_if);
+int hardif_enable_interface(struct batman_if *batman_if, char *iface_name);
 void hardif_disable_interface(struct batman_if *batman_if);
 void hardif_remove_interfaces(void);
 int batman_skb_recv(struct sk_buff *skb,
 				struct net_device *dev,
 				struct packet_type *ptype,
 				struct net_device *orig_dev);
-int hardif_min_mtu(void);
-void update_min_mtu(void);
+int hardif_min_mtu(struct net_device *soft_iface);
+void update_min_mtu(struct net_device *soft_iface);
 
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/batman-adv/hash.c b/batman-adv/hash.c
index 1286f8f..8ef26eb 100644
--- a/batman-adv/hash.c
+++ b/batman-adv/hash.c
@@ -36,7 +36,7 @@ static void hash_init(struct hashtable_t *hash)
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
  * elements, memory might be leaked. */
-void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
+void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb, void *arg)
 {
 	struct element_t *bucket, *last_bucket;
 	int i;
@@ -46,7 +46,7 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 
 		while (bucket != NULL) {
 			if (free_cb != NULL)
-				free_cb(bucket->data);
+				free_cb(bucket->data, arg);
 
 			last_bucket = bucket;
 			bucket = bucket->next;
@@ -300,7 +300,7 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 
 	/* remove hash and eventual overflow buckets but not the content
 	 * itself. */
-	hash_delete(hash, NULL);
+	hash_delete(hash, NULL, NULL);
 
 	return new_hash;
 }
diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index c483e11..2c8e176 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -30,7 +30,7 @@
 
 typedef int (*hashdata_compare_cb)(void *, void *);
 typedef int (*hashdata_choose_cb)(void *, int);
-typedef void (*hashdata_free_cb)(void *);
+typedef void (*hashdata_free_cb)(void *, void *);
 
 struct element_t {
 	void *data;		/* pointer to the data */
@@ -70,7 +70,7 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t);
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
  * elements, memory might be leaked. */
-void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb);
+void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb, void *arg);
 
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash);
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index a84e84d..2660516 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -69,6 +69,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&socket_client->queue_list);
 	socket_client->queue_len = 0;
 	socket_client->index = i;
+	socket_client->bat_priv = inode->i_private;
 	spin_lock_init(&socket_client->lock);
 	init_waitqueue_head(&socket_client->queue_wait);
 
@@ -155,10 +156,9 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 				size_t len, loff_t *off)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct socket_client *socket_client =
 		(struct socket_client *)file->private_data;
+	struct bat_priv *bat_priv = socket_client->bat_priv;
 	struct icmp_packet_rr icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
@@ -277,7 +277,7 @@ int bat_socket_setup(struct bat_priv *bat_priv)
 		goto err;
 
 	d = debugfs_create_file(ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
-				bat_priv->debug_dir, NULL, &fops);
+				bat_priv->debug_dir, bat_priv, &fops);
 	if (d)
 		goto err;
 
diff --git a/batman-adv/main.c b/batman-adv/main.c
index 1b3acd1..142af2f 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -46,8 +46,6 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 int16_t num_hna;
 
-struct net_device *soft_device;
-
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 atomic_t module_state;
 
@@ -60,8 +58,6 @@ struct workqueue_struct *bat_event_workqueue;
 
 int init_module(void)
 {
-	int retval;
-
 	INIT_LIST_HEAD(&if_list);
 	INIT_HLIST_HEAD(&forw_bat_list);
 	INIT_HLIST_HEAD(&forw_bcast_list);
@@ -78,32 +74,6 @@ int init_module(void)
 	bat_socket_init();
 	debugfs_init();
 
-	/* initialize layer 2 interface */
-	soft_device = alloc_netdev(sizeof(struct bat_priv) , "bat%d",
-				   interface_setup);
-
-	if (!soft_device) {
-		pr_err("Unable to allocate the batman interface\n");
-		goto end;
-	}
-
-	retval = register_netdev(soft_device);
-
-	if (retval < 0) {
-		pr_err("Unable to register the batman interface: %i\n", retval);
-		goto free_soft_device;
-	}
-
-	retval = sysfs_add_meshif(soft_device);
-
-	if (retval < 0)
-		goto unreg_soft_device;
-
-	retval = debugfs_add_meshif(soft_device);
-
-	if (retval < 0)
-		goto unreg_sysfs;
-
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
@@ -112,19 +82,6 @@ int init_module(void)
 		COMPAT_VERSION);
 
 	return 0;
-
-unreg_sysfs:
-	sysfs_del_meshif(soft_device);
-unreg_soft_device:
-	unregister_netdev(soft_device);
-	soft_device = NULL;
-	return -ENOMEM;
-
-free_soft_device:
-	free_netdev(soft_device);
-	soft_device = NULL;
-end:
-	return -ENOMEM;
 }
 
 void cleanup_module(void)
@@ -135,13 +92,6 @@ void cleanup_module(void)
 	unregister_netdevice_notifier(&hard_if_notifier);
 	hardif_remove_interfaces();
 
-	if (soft_device) {
-		debugfs_del_meshif(soft_device);
-		sysfs_del_meshif(soft_device);
-		unregister_netdev(soft_device);
-		soft_device = NULL;
-	}
-
 	dev_remove_pack(&batman_adv_packet_type);
 
 	destroy_workqueue(bat_event_workqueue);
@@ -160,12 +110,12 @@ void activate_module(void)
 	if (hna_global_init() < 1)
 		goto err;
 
-	hna_local_add(soft_device->dev_addr);
+// 	hna_local_add(soft_device->dev_addr);
 
 	if (vis_init() < 1)
 		goto err;
 
-	update_min_mtu();
+// 	update_min_mtu();
 	atomic_set(&module_state, MODULE_ACTIVE);
 	goto end;
 
diff --git a/batman-adv/main.h b/batman-adv/main.h
index 6d759f0..70d6e36 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -138,8 +138,6 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern int16_t num_hna;
 
-extern struct net_device *soft_device;
-
 extern unsigned char broadcast_addr[];
 extern atomic_t module_state;
 extern struct workqueue_struct *bat_event_workqueue;
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 5343ab2..aac675d 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -62,8 +62,7 @@ struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -83,11 +82,12 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 	return neigh_node;
 }
 
-static void free_orig_node(void *data)
+static void free_orig_node(void *data, void *arg)
 {
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
 	struct orig_node *orig_node = (struct orig_node *)data;
+	struct bat_priv *bat_priv = (struct bat_priv *)arg;
 
 	/* for all neighbors towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
@@ -97,7 +97,7 @@ static void free_orig_node(void *data)
 		kfree(neigh_node);
 	}
 
-	hna_global_del_orig(orig_node, "originator timed out");
+	hna_global_del_orig(bat_priv, orig_node, "originator timed out");
 
 	kfree(orig_node->bcast_own);
 	kfree(orig_node->bcast_own_sum);
@@ -114,17 +114,15 @@ void originator_free(void)
 	cancel_delayed_work_sync(&purge_orig_wq);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	hash_delete(orig_hash, free_orig_node);
+// 	hash_delete(orig_hash, free_orig_node, bat_priv);
 	orig_hash = NULL;
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
 
 /* this function finds or creates an originator entry for the given
  * address if it does not exits */
-struct orig_node *get_orig_node(uint8_t *addr)
+struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
 	int size;
@@ -169,7 +167,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			bat_err(soft_device,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
@@ -185,11 +183,10 @@ free_orig_node:
 	return NULL;
 }
 
-static bool purge_orig_neighbors(struct orig_node *orig_node,
+static bool purge_orig_neighbors(struct bat_priv *bat_priv,
+				 struct orig_node *orig_node,
 				 struct neigh_node **best_neigh_node)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
@@ -231,10 +228,9 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 	return neigh_purged;
 }
 
-static bool purge_orig_node(struct orig_node *orig_node)
+static bool purge_orig_node(struct bat_priv *bat_priv,
+			    struct orig_node *orig_node)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *best_neigh_node;
 
 	if (time_after(jiffies,
@@ -245,8 +241,9 @@ static bool purge_orig_node(struct orig_node *orig_node)
 			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
 	} else {
-		if (purge_orig_neighbors(orig_node, &best_neigh_node)) {
-			update_routes(orig_node, best_neigh_node,
+		if (purge_orig_neighbors(bat_priv, orig_node, &best_neigh_node)) {
+			update_routes(bat_priv, orig_node,
+				      best_neigh_node,
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
 			/* update bonding candidates, we could have lost
@@ -269,18 +266,18 @@ void purge_orig(struct work_struct *work)
 	/* for all origins... */
 	while (hash_iterate(orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
-		if (purge_orig_node(orig_node)) {
-			if (orig_node->gw_flags)
-				gw_node_delete(orig_node);
-			hash_remove_bucket(orig_hash, &hashit);
-			free_orig_node(orig_node);
-		}
+// 		if (purge_orig_node(bat_priv, orig_node)) {
+// 			if (orig_node->gw_flags)
+// 				gw_node_delete(bat_priv, orig_node);
+// 			hash_remove_bucket(orig_hash, &hashit);
+// 			free_orig_node(orig_node);
+// 		}
 	}
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 	gw_node_purge_deleted();
-	gw_election();
+// 	gw_election(bat_priv);
 
 	/* if work == NULL we were not called by the timer
 	 * and thus do not need to re-arm the timer */
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index e88411d..bc47c68 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -25,7 +25,7 @@
 int originator_init(void);
 void originator_free(void);
 void purge_orig(struct work_struct *work);
-struct orig_node *get_orig_node(uint8_t *addr);
+struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 5dd4295..5dc78a8 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -39,6 +39,7 @@ static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
@@ -50,7 +51,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 		orig_node = hashit.bucket->data;
 		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
 
-		bit_get_packet(word, 1, 0);
+		bit_get_packet(bat_priv, word, 1, 0);
 		orig_node->bcast_own_sum[batman_if->if_num] =
 			bit_packet_count(word);
 	}
@@ -58,7 +59,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
 
-static void update_HNA(struct orig_node *orig_node,
+static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		       unsigned char *hna_buff, int hna_buff_len)
 {
 	if ((hna_buff_len != orig_node->hna_buff_len) ||
@@ -67,27 +68,26 @@ static void update_HNA(struct orig_node *orig_node,
 	     (memcmp(orig_node->hna_buff, hna_buff, hna_buff_len) != 0))) {
 
 		if (orig_node->hna_buff_len > 0)
-			hna_global_del_orig(orig_node,
+			hna_global_del_orig(bat_priv, orig_node,
 					    "originator changed hna");
 
 		if ((hna_buff_len > 0) && (hna_buff != NULL))
-			hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
+			hna_global_add_orig(bat_priv, orig_node,
+					    hna_buff, hna_buff_len);
 	}
 }
 
-static void update_route(struct orig_node *orig_node,
+static void update_route(struct bat_priv *bat_priv,
+			 struct orig_node *orig_node,
 			 struct neigh_node *neigh_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
-
 	/* route deleted */
 	if ((orig_node->router != NULL) && (neigh_node == NULL)) {
 
 		bat_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
 			orig_node->orig);
-		hna_global_del_orig(orig_node, "originator timed out");
+		hna_global_del_orig(bat_priv, orig_node, "originator timed out");
 
 		/* route added */
 	} else if ((orig_node->router == NULL) && (neigh_node != NULL)) {
@@ -95,7 +95,7 @@ static void update_route(struct orig_node *orig_node,
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Adding route towards: %pM (via %pM)\n",
 			orig_node->orig, neigh_node->addr);
-		hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
+		hna_global_add_orig(bat_priv, orig_node, hna_buff, hna_buff_len);
 
 		/* route changed */
 	} else {
@@ -110,19 +110,20 @@ static void update_route(struct orig_node *orig_node,
 }
 
 
-void update_routes(struct orig_node *orig_node,
-			  struct neigh_node *neigh_node,
-			  unsigned char *hna_buff, int hna_buff_len)
+void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
+		   struct neigh_node *neigh_node, unsigned char *hna_buff,
+		   int hna_buff_len)
 {
 
 	if (orig_node == NULL)
 		return;
 
 	if (orig_node->router != neigh_node)
-		update_route(orig_node, neigh_node, hna_buff, hna_buff_len);
+		update_route(bat_priv, orig_node, neigh_node,
+			     hna_buff, hna_buff_len);
 	/* may be just HNA changed */
 	else
-		update_HNA(orig_node, hna_buff, hna_buff_len);
+		update_HNA(bat_priv, orig_node, hna_buff, hna_buff_len);
 }
 
 static int is_bidirectional_neigh(struct orig_node *orig_node,
@@ -130,8 +131,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct batman_packet *batman_packet,
 				struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	unsigned char total_count;
 
@@ -235,14 +235,14 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	return 0;
 }
 
-static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
+static void update_orig(struct bat_priv *bat_priv,
+			struct orig_node *orig_node,
+			struct ethhdr *ethhdr,
 			struct batman_packet *batman_packet,
 			struct batman_if *if_incoming,
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
 {
-	/* FIXME: get bat_priv */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
@@ -268,12 +268,11 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	if (!neigh_node) {
 		struct orig_node *orig_tmp;
 
-		orig_tmp = get_orig_node(ethhdr->h_source);
+		orig_tmp = get_orig_node(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
 			return;
 
-		neigh_node = create_neighbor(orig_node,
-					     orig_tmp,
+		neigh_node = create_neighbor(orig_node, orig_tmp,
 					     ethhdr->h_source, if_incoming);
 		if (!neigh_node)
 			return;
@@ -315,15 +314,16 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	      >= neigh_node->orig_node->bcast_own_sum[if_incoming->if_num])))
 		goto update_hna;
 
-	update_routes(orig_node, neigh_node, hna_buff, tmp_hna_buff_len);
+	update_routes(bat_priv, orig_node, neigh_node, hna_buff, tmp_hna_buff_len);
 	goto update_gw;
 
 update_hna:
-	update_routes(orig_node, orig_node->router, hna_buff, tmp_hna_buff_len);
+	update_routes(bat_priv, orig_node, orig_node->router,
+		      hna_buff, tmp_hna_buff_len);
 
 update_gw:
 	if (orig_node->gw_flags != batman_packet->gw_flags)
-		gw_node_update(orig_node, batman_packet->gw_flags);
+		gw_node_update(bat_priv, orig_node, batman_packet->gw_flags);
 
 	orig_node->gw_flags = batman_packet->gw_flags;
 
@@ -337,12 +337,10 @@ update_gw:
  *  0 if the packet is to be accepted
  *  1 if the packet is to be ignored.
  */
-static int window_protected(int32_t seq_num_diff,
-				unsigned long *last_reset)
+static int window_protected(struct bat_priv *bat_priv,
+			    int32_t seq_num_diff,
+			    unsigned long *last_reset)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
-
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
 		if (time_after(jiffies, *last_reset +
@@ -371,8 +369,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			       struct batman_packet *batman_packet,
 			       struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	char is_duplicate = 0;
@@ -380,14 +377,15 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	int need_update = 0;
 	int set_mark;
 
-	orig_node = get_orig_node(batman_packet->orig);
+	orig_node = get_orig_node(bat_priv, batman_packet->orig);
 	if (orig_node == NULL)
 		return 0;
 
 	seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
-	if (window_protected(seq_diff, &orig_node->batman_seqno_reset))
+	if (window_protected(bat_priv, seq_diff,
+			     &orig_node->batman_seqno_reset))
 		return -1;
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
@@ -403,7 +401,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			set_mark = 0;
 
 		/* if the window moved, set the update flag. */
-		need_update |= bit_get_packet(tmp_neigh_node->real_bits,
+		need_update |= bit_get_packet(bat_priv, tmp_neigh_node->real_bits,
 						seq_diff, set_mark);
 
 		tmp_neigh_node->real_packet_count =
@@ -532,8 +530,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batman_if *batman_if;
 	struct orig_node *orig_neigh_node, *orig_node;
 	char has_directlink_flag;
@@ -620,7 +617,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		TYPE_OF_WORD *word;
 		int offset;
 
-		orig_neigh_node = get_orig_node(ethhdr->h_source);
+		orig_neigh_node = get_orig_node(bat_priv, ethhdr->h_source);
 
 		if (!orig_neigh_node)
 			return;
@@ -652,7 +649,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		return;
 	}
 
-	orig_node = get_orig_node(batman_packet->orig);
+	orig_node = get_orig_node(bat_priv, batman_packet->orig);
 	if (orig_node == NULL)
 		return;
 
@@ -688,7 +685,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac */
 	orig_neigh_node = (is_single_hop_neigh ?
-			   orig_node : get_orig_node(ethhdr->h_source));
+			   orig_node :
+			   get_orig_node(bat_priv, ethhdr->h_source));
 	if (orig_neigh_node == NULL)
 		return;
 
@@ -710,7 +708,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    (!is_duplicate ||
 	     ((orig_node->last_real_seqno == batman_packet->seqno) &&
 	      (orig_node->last_ttl - 3 <= batman_packet->ttl))))
-		update_orig(orig_node, ethhdr, batman_packet,
+		update_orig(bat_priv, orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
 	mark_bonding_address(bat_priv, orig_node,
@@ -1017,8 +1015,7 @@ int recv_icmp_packet(struct sk_buff *skb)
 struct neigh_node *find_router(struct orig_node *orig_node,
 		struct batman_if *recv_if)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
 	struct neigh_node *router, *first_candidate, *best_router;
@@ -1034,9 +1031,14 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 	/* without bonding, the first node should
 	 * always choose the default router. */
 
+	if (!recv_if)
+		return orig_node->router;
+
+	bat_priv = netdev_priv(recv_if->soft_iface);
 	bonding_enabled = atomic_read(&bat_priv->bonding_enabled);
-	if (!bonding_enabled && (recv_if == NULL))
-			return orig_node->router;
+
+	if (!bonding_enabled)
+		return orig_node->router;
 
 	router_orig = orig_node->router->orig_node;
 
@@ -1121,7 +1123,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (skb_headlen(skb) < hdr_size)
 		return NET_RX_DROP;
 
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_bcast(ethhdr->h_dest))
@@ -1135,11 +1137,11 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (!is_my_mac(ethhdr->h_dest))
 		return NET_RX_DROP;
 
-	unicast_packet = (struct unicast_packet *) skb->data;
+	unicast_packet = (struct unicast_packet *)skb->data;
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(skb, hdr_size);
+		interface_rx(recv_if->soft_iface, skb, hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
@@ -1191,11 +1193,12 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	return NET_RX_SUCCESS;
 }
 
-int recv_bcast_packet(struct sk_buff *skb)
+int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
 {
 	struct orig_node *orig_node;
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	int hdr_size = sizeof(struct bcast_packet);
 	int32_t seq_diff;
 	unsigned long flags;
@@ -1247,37 +1250,38 @@ int recv_bcast_packet(struct sk_buff *skb)
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
-	if (window_protected(seq_diff, &orig_node->bcast_seqno_reset)) {
+	if (window_protected(bat_priv, seq_diff,
+			     &orig_node->bcast_seqno_reset)) {
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 		return NET_RX_DROP;
 	}
 
 	/* mark broadcast in flood history, update window position
 	 * if required. */
-	if (bit_get_packet(orig_node->bcast_bits, seq_diff, 1))
+	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	/* rebroadcast packet */
-	add_bcast_packet_to_list(skb);
+	add_bcast_packet_to_list(bat_priv, skb);
 
 	/* broadcast for me */
-	interface_rx(skb, hdr_size);
+	interface_rx(batman_if->soft_iface, skb, hdr_size);
 
 	return NET_RX_SUCCESS;
 }
 
-int recv_vis_packet(struct sk_buff *skb)
+int recv_vis_packet(struct sk_buff *skb, struct batman_if *batman_if)
 {
 	struct vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
-	struct bat_priv *bat_priv;
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	int hdr_size = sizeof(struct vis_packet);
 
 	if (skb_headlen(skb) < hdr_size)
 		return NET_RX_DROP;
 
-	vis_packet = (struct vis_packet *) skb->data;
+	vis_packet = (struct vis_packet *)skb->data;
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* not for me */
@@ -1291,9 +1295,6 @@ int recv_vis_packet(struct sk_buff *skb)
 	if (is_my_mac(vis_packet->sender_orig))
 		return NET_RX_DROP;
 
-	/* FIXME: each batman_if will be attached to a softif */
-	bat_priv = netdev_priv(soft_device);
-
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
 		/* TODO: handle fragmented skbs properly */
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 3eac64e..68c21b5 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -29,13 +29,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				struct batman_packet *batman_packet,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming);
-void update_routes(struct orig_node *orig_node,
-				struct neigh_node *neigh_node,
-				unsigned char *hna_buff, int hna_buff_len);
+void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
+		   struct neigh_node *neigh_node, unsigned char *hna_buff,
+		   int hna_buff_len);
 int recv_icmp_packet(struct sk_buff *skb);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
-int recv_bcast_packet(struct sk_buff *skb);
-int recv_vis_packet(struct sk_buff *skb);
+int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
 struct neigh_node *find_router(struct orig_node *orig_node,
diff --git a/batman-adv/send.c b/batman-adv/send.c
index cd6be2b..785f997 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -126,8 +126,7 @@ void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
 static void send_packet_to_if(struct forw_packet *forw_packet,
 			      struct batman_if *batman_if)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	char *fwd_str;
 	uint8_t packet_num;
 	int16_t buff_pos;
@@ -182,9 +181,9 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 /* send a batman packet */
 static void send_packet(struct forw_packet *forw_packet)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_if *batman_if;
+	struct bat_priv *bat_priv =
+		netdev_priv(forw_packet->if_incoming->soft_iface);
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->packet_buff);
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
@@ -253,8 +252,7 @@ static void rebuild_batman_packet(struct batman_if *batman_if)
 
 void schedule_own_packet(struct batman_if *batman_if)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
 	int vis_server;
@@ -317,8 +315,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_incoming)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
@@ -409,12 +406,10 @@ static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
  *
  * The skb is not consumed, so the caller should make sure that the
  * skb is freed. */
-int add_bcast_packet_to_list(struct sk_buff *skb)
+int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
 {
 	struct forw_packet *forw_packet;
 	struct bcast_packet *bcast_packet;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	if (!atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
 		bat_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
@@ -462,8 +457,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
 	struct sk_buff *skb1;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -492,6 +486,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	}
 
 out:
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 	forw_packet_free(forw_packet);
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
@@ -503,8 +498,7 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	struct forw_packet *forw_packet =
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 
 	spin_lock_irqsave(&forw_bat_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -524,6 +518,8 @@ void send_outstanding_bat_packet(struct work_struct *work)
 		schedule_own_packet(forw_packet->if_incoming);
 
 out:
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
+
 	/* don't count own packet */
 	if (!forw_packet->own)
 		atomic_inc(&bat_priv->batman_queue_left);
@@ -533,19 +529,22 @@ out:
 
 void purge_outstanding_packets(struct batman_if *batman_if)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
 	unsigned long flags;
 
-	if (batman_if)
-		bat_dbg(DBG_BATMAN, bat_priv,
-			"purge_outstanding_packets(): %s\n",
-			batman_if->dev);
-	else
-		bat_dbg(DBG_BATMAN, bat_priv,
-			"purge_outstanding_packets()\n");
+	if (batman_if->soft_iface) {
+		bat_priv = netdev_priv(batman_if->soft_iface);
+
+		if (batman_if)
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"purge_outstanding_packets(): %s\n",
+				batman_if->dev);
+		else
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"purge_outstanding_packets()\n");
+	}
 
 	/* free bcast list */
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
diff --git a/batman-adv/send.h b/batman-adv/send.h
index b64c627..2c48042 100644
--- a/batman-adv/send.h
+++ b/batman-adv/send.h
@@ -35,7 +35,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     struct batman_packet *batman_packet,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
-int  add_bcast_packet_to_list(struct sk_buff *skb);
+int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct batman_if *batman_if);
 
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 0d89597..9851a7d 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -24,10 +24,13 @@
 #include "hard-interface.h"
 #include "routing.h"
 #include "send.h"
+#include "bat_debugfs.h"
 #include "translation-table.h"
 #include "types.h"
 #include "hash.h"
+
 #include <linux/slab.h>
+#include "gateway_common.h"
 #include "gateway_client.h"
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
@@ -94,12 +97,13 @@ static int interface_release(struct net_device *dev)
 
 static struct net_device_stats *interface_stats(struct net_device *dev)
 {
-	struct bat_priv *priv = netdev_priv(dev);
-	return &priv->stats;
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	return &bat_priv->stats;
 }
 
 static int interface_set_mac_addr(struct net_device *dev, void *p)
 {
+	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -107,8 +111,9 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 
 	/* only modify hna-table if it has been initialised before */
 	if (atomic_read(&module_state) == MODULE_ACTIVE) {
-		hna_local_remove(dev->dev_addr, "mac address changed");
-		hna_local_add(addr->sa_data);
+		hna_local_remove(bat_priv, dev->dev_addr,
+				 "mac address changed");
+		hna_local_add(dev, addr->sa_data);
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
@@ -119,7 +124,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 static int interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
-	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu()))
+	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu(dev)))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
@@ -127,16 +132,15 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-int interface_tx(struct sk_buff *skb, struct net_device *dev)
+int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 {
 	struct unicast_packet *unicast_packet;
 	struct bcast_packet *bcast_packet;
 	struct orig_node *orig_node;
 	struct neigh_node *router;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-	struct bat_priv *priv = netdev_priv(dev);
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct batman_if *batman_if;
-	struct bat_priv *bat_priv;
 	uint8_t dstaddr[6];
 	int data_len = skb->len;
 	unsigned long flags;
@@ -145,12 +149,9 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dropped;
 
-	/* FIXME: each batman_if will be attached to a softif */
-	bat_priv = netdev_priv(soft_device);
-
-	dev->trans_start = jiffies;
+	soft_iface->trans_start = jiffies;
 	/* TODO: check this for locks */
-	hna_local_add(ethhdr->h_source);
+	hna_local_add(soft_iface, ethhdr->h_source);
 
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
 		bcast_dst = true;
@@ -178,7 +179,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		bcast_packet->seqno = htonl(bcast_seqno);
 
 		/* broadcast packet. on success, increase seqno. */
-		if (add_bcast_packet_to_list(skb) == NETDEV_TX_OK)
+		if (add_bcast_packet_to_list(bat_priv, skb) == NETDEV_TX_OK)
 			bcast_seqno++;
 
 		/* a copy is stored in the bcast list, therefore removing
@@ -232,23 +233,22 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		send_skb_packet(skb, batman_if, dstaddr);
 	}
 
-	priv->stats.tx_packets++;
-	priv->stats.tx_bytes += data_len;
+	bat_priv->stats.tx_packets++;
+	bat_priv->stats.tx_bytes += data_len;
 	goto end;
 
 unlock:
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 dropped:
-	priv->stats.tx_dropped++;
+	bat_priv->stats.tx_dropped++;
 	kfree_skb(skb);
 end:
 	return NETDEV_TX_OK;
 }
 
-void interface_rx(struct sk_buff *skb, int hdr_size)
+void interface_rx(struct net_device *soft_iface, struct sk_buff *skb, int hdr_size)
 {
-	struct net_device *dev = soft_device;
-	struct bat_priv *priv = netdev_priv(dev);
+	struct bat_priv *priv = netdev_priv(soft_iface);
 
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size)) {
@@ -258,8 +258,8 @@ void interface_rx(struct sk_buff *skb, int hdr_size)
 	skb_pull_rcsum(skb, hdr_size);
 /*	skb_set_mac_header(skb, -sizeof(struct ethhdr));*/
 
-	skb->dev = dev;
-	skb->protocol = eth_type_trans(skb, dev);
+	skb->dev = soft_iface;
+	skb->protocol = eth_type_trans(skb, soft_iface);
 
 	/* should not be neccesary anymore as we use skb_pull_rcsum()
 	 * TODO: please verify this and remove this TODO
@@ -273,7 +273,7 @@ void interface_rx(struct sk_buff *skb, int hdr_size)
 	priv->stats.rx_packets++;
 	priv->stats.rx_bytes += skb->len;
 
-	dev->last_rx = jiffies;
+	soft_iface->last_rx = jiffies;
 
 	netif_rx(skb);
 }
@@ -290,7 +290,7 @@ static const struct net_device_ops bat_netdev_ops = {
 };
 #endif
 
-void interface_setup(struct net_device *dev)
+static void interface_setup(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
 	char dev_addr[ETH_ALEN];
@@ -309,7 +309,7 @@ void interface_setup(struct net_device *dev)
 #endif
 	dev->destructor = free_netdev;
 
-	dev->mtu = hardif_min_mtu();
+	dev->mtu = hardif_min_mtu(dev);
 	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
 						* skbuff for our header */
 
@@ -322,6 +322,74 @@ void interface_setup(struct net_device *dev)
 	memset(priv, 0, sizeof(struct bat_priv));
 }
 
+struct net_device *softif_create(char *name)
+{
+	struct net_device *soft_iface;
+	struct bat_priv *bat_priv;
+	int ret;
+
+	soft_iface = alloc_netdev(sizeof(struct bat_priv) , name,
+				   interface_setup);
+
+	if (!soft_iface) {
+		pr_err("Unable to allocate the batman interface: %s\n", name);
+		goto out;
+	}
+
+	ret = register_netdev(soft_iface);
+
+	if (ret < 0) {
+		pr_err("Unable to register the batman interface '%s': %i\n",
+		       name, ret);
+		goto free_soft_iface;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	atomic_set(&bat_priv->aggregation_enabled, 1);
+	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
+	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
+	atomic_set(&bat_priv->gw_class, 0);
+	atomic_set(&bat_priv->orig_interval, 1000);
+	atomic_set(&bat_priv->log_level, 0);
+	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
+	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
+
+	bat_priv->primary_if = NULL;
+	bat_priv->num_ifaces = 0;
+
+	ret = sysfs_add_meshif(soft_iface);
+
+	if (ret < 0)
+		goto unreg_soft_iface;
+
+	ret = debugfs_add_meshif(soft_iface);
+
+	if (ret < 0)
+		goto unreg_sysfs;
+
+	return soft_iface;
+
+unreg_sysfs:
+	sysfs_del_meshif(soft_iface);
+unreg_soft_iface:
+	unregister_netdev(soft_iface);
+	return NULL;
+
+free_soft_iface:
+	free_netdev(soft_iface);
+out:
+	return NULL;
+}
+
+void softif_destroy(struct net_device *soft_iface)
+{
+	debugfs_del_meshif(soft_iface);
+	sysfs_del_meshif(soft_iface);
+	unregister_netdev(soft_iface);
+}
+
 /* ethtool */
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
diff --git a/batman-adv/soft-interface.h b/batman-adv/soft-interface.h
index 6364854..af0438e 100644
--- a/batman-adv/soft-interface.h
+++ b/batman-adv/soft-interface.h
@@ -23,10 +23,11 @@
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
 void set_main_if_addr(uint8_t *addr);
-void interface_setup(struct net_device *dev);
-int interface_tx(struct sk_buff *skb, struct net_device *dev);
-void interface_rx(struct sk_buff *skb, int hdr_size);
+int interface_tx(struct sk_buff *skb, struct net_device *soft_iface);
+void interface_rx(struct net_device *soft_iface, struct sk_buff *skb, int hdr_size);
 int my_skb_push(struct sk_buff *skb, unsigned int len);
+struct net_device *softif_create(char *name);
+void softif_destroy(struct net_device *soft_iface);
 
 extern unsigned char main_if_addr[];
 
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 1513495..bf0a2b5 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -35,7 +35,8 @@ static DEFINE_SPINLOCK(hna_global_hash_lock);
 
 static void hna_local_purge(struct work_struct *work);
 static DECLARE_DELAYED_WORK(hna_local_purge_wq, hna_local_purge);
-static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+static void _hna_global_del_orig(struct bat_priv *bat_priv,
+				 struct hna_global_entry *hna_global_entry,
 				 char *message);
 
 static void hna_local_start_timer(void)
@@ -59,10 +60,9 @@ int hna_local_init(void)
 	return 1;
 }
 
-void hna_local_add(uint8_t *addr)
+void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
@@ -101,7 +101,7 @@ void hna_local_add(uint8_t *addr)
 	hna_local_entry->last_seen = jiffies;
 
 	/* the batman interface mac address should never be purged */
-	if (compare_orig(addr, soft_device->dev_addr))
+	if (compare_orig(addr, soft_iface->dev_addr))
 		hna_local_entry->never_purge = 1;
 	else
 		hna_local_entry->never_purge = 0;
@@ -131,7 +131,8 @@ void hna_local_add(uint8_t *addr)
 		((struct hna_global_entry *)hash_find(hna_global_hash, addr));
 
 	if (hna_global_entry != NULL)
-		_hna_global_del_orig(hna_global_entry, "local hna received");
+		_hna_global_del_orig(bat_priv, hna_global_entry,
+				     "local hna received");
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 }
@@ -215,26 +216,26 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static void _hna_local_del(void *data)
+static void _hna_local_del(void *data, void *arg)
 {
 	kfree(data);
 	num_hna--;
 	atomic_set(&hna_local_changed, 1);
 }
 
-static void hna_local_del(struct hna_local_entry *hna_local_entry,
+static void hna_local_del(struct bat_priv *bat_priv,
+			  struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
 	hash_remove(hna_local_hash, hna_local_entry->addr);
-	_hna_local_del(hna_local_entry);
+	_hna_local_del(hna_local_entry, bat_priv);
 }
 
-void hna_local_remove(uint8_t *addr, char *message)
+void hna_local_remove(struct bat_priv *bat_priv,
+		      uint8_t *addr, char *message)
 {
 	struct hna_local_entry *hna_local_entry;
 	unsigned long flags;
@@ -244,7 +245,7 @@ void hna_local_remove(uint8_t *addr, char *message)
 	hna_local_entry = (struct hna_local_entry *)
 		hash_find(hna_local_hash, addr);
 	if (hna_local_entry)
-		hna_local_del(hna_local_entry, message);
+		hna_local_del(bat_priv, hna_local_entry, message);
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 }
@@ -262,9 +263,10 @@ static void hna_local_purge(struct work_struct *work)
 		hna_local_entry = hashit.bucket->data;
 
 		timeout = hna_local_entry->last_seen + LOCAL_HNA_TIMEOUT * HZ;
-		if ((!hna_local_entry->never_purge) &&
-		    time_after(jiffies, timeout))
-			hna_local_del(hna_local_entry, "address timed out");
+// 		if ((!hna_local_entry->never_purge) &&
+// 		    time_after(jiffies, timeout))
+// 			hna_local_del(bat_priv, hna_local_entry,
+// 				      "address timed out");
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -277,7 +279,7 @@ void hna_local_free(void)
 		return;
 
 	cancel_delayed_work_sync(&hna_local_purge_wq);
-	hash_delete(hna_local_hash, _hna_local_del);
+	hash_delete(hna_local_hash, _hna_local_del, NULL);
 	hna_local_hash = NULL;
 }
 
@@ -294,11 +296,10 @@ int hna_global_init(void)
 	return 1;
 }
 
-void hna_global_add_orig(struct orig_node *orig_node,
+void hna_global_add_orig(struct bat_priv *bat_priv,
+			 struct orig_node *orig_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
 	struct hashtable_t *swaphash;
@@ -346,7 +347,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 			hash_find(hna_local_hash, hna_ptr);
 
 		if (hna_local_entry != NULL)
-			hna_local_del(hna_local_entry, "global hna received");
+			hna_local_del(bat_priv, hna_local_entry, "global hna received");
 
 		spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 
@@ -430,11 +431,10 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+static void _hna_global_del_orig(struct bat_priv *bat_priv,
+				 struct hna_global_entry *hna_global_entry,
 				 char *message)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	bat_dbg(DBG_ROUTES, bat_priv,
 		"Deleting global hna entry %pM (via %pM): %s\n",
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
@@ -444,7 +444,8 @@ static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 	kfree(hna_global_entry);
 }
 
-void hna_global_del_orig(struct orig_node *orig_node, char *message)
+void hna_global_del_orig(struct bat_priv *bat_priv,
+			 struct orig_node *orig_node, char *message)
 {
 	struct hna_global_entry *hna_global_entry;
 	int hna_buff_count = 0;
@@ -463,7 +464,8 @@ void hna_global_del_orig(struct orig_node *orig_node, char *message)
 
 		if ((hna_global_entry != NULL) &&
 		    (hna_global_entry->orig_node == orig_node))
-			_hna_global_del_orig(hna_global_entry, message);
+			_hna_global_del_orig(bat_priv, hna_global_entry,
+					     message);
 
 		hna_buff_count++;
 	}
@@ -475,7 +477,7 @@ void hna_global_del_orig(struct orig_node *orig_node, char *message)
 	orig_node->hna_buff = NULL;
 }
 
-static void hna_global_del(void *data)
+static void hna_global_del(void *data, void *arg)
 {
 	kfree(data);
 }
@@ -485,7 +487,7 @@ void hna_global_free(void)
 	if (!hna_global_hash)
 		return;
 
-	hash_delete(hna_global_hash, hna_global_del);
+	hash_delete(hna_global_hash, hna_global_del, NULL);
 	hna_global_hash = NULL;
 }
 
diff --git a/batman-adv/translation-table.h b/batman-adv/translation-table.h
index fa93e37..af7a59c 100644
--- a/batman-adv/translation-table.h
+++ b/batman-adv/translation-table.h
@@ -25,16 +25,19 @@
 #include "types.h"
 
 int hna_local_init(void);
-void hna_local_add(uint8_t *addr);
-void hna_local_remove(uint8_t *addr, char *message);
+void hna_local_add(struct net_device *soft_iface, uint8_t *addr);
+void hna_local_remove(struct bat_priv *bat_priv,
+		      uint8_t *addr, char *message);
 int hna_local_fill_buffer(unsigned char *buff, int buff_len);
 int hna_local_seq_print_text(struct seq_file *seq, void *offset);
 void hna_local_free(void);
 int hna_global_init(void);
-void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff,
-			 int hna_buff_len);
+void hna_global_add_orig(struct bat_priv *bat_priv,
+			 struct orig_node *orig_node,
+			 unsigned char *hna_buff, int hna_buff_len);
 int hna_global_seq_print_text(struct seq_file *seq, void *offset);
-void hna_global_del_orig(struct orig_node *orig_node, char *message);
+void hna_global_del_orig(struct bat_priv *bat_priv,
+			 struct orig_node *orig_node, char *message);
 void hna_global_free(void);
 struct orig_node *transtable_search(uint8_t *addr);
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 9cd19b7..4d46439 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -45,6 +45,7 @@ struct batman_if {
 	int packet_len;
 	struct kobject *hardif_obj;
 	struct rcu_head rcu;
+	struct net_device *soft_iface;
 };
 
 /**
@@ -138,6 +139,7 @@ struct socket_client {
 	unsigned char index;
 	spinlock_t lock;
 	wait_queue_head_t queue_wait;
+	struct bat_priv *bat_priv;
 };
 
 struct socket_packet {
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 5c825b5..cad444d 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -701,17 +701,16 @@ static void send_vis_packets(struct work_struct *work)
 {
 	struct vis_info *info, *temp;
 	unsigned long flags;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+// 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 
 	purge_vis_packets();
 
-	if (generate_vis_packet(bat_priv) == 0) {
-		/* schedule if generation was successful */
-		send_list_add(my_vis_info);
-	}
+// 	if (generate_vis_packet(bat_priv) == 0) {
+// 		/* schedule if generation was successful */
+// 		send_list_add(my_vis_info);
+// 	}
 
 	list_for_each_entry_safe(info, temp, &send_list, send_list) {
 
@@ -785,7 +784,7 @@ err:
 }
 
 /* Decrease the reference count on a hash item info */
-static void free_info_ref(void *data)
+static void free_info_ref(void *data, void *arg)
 {
 	struct vis_info *info = data;
 
@@ -804,7 +803,7 @@ void vis_quit(void)
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	/* properly remove, kill timers ... */
-	hash_delete(vis_hash, free_info_ref);
+	hash_delete(vis_hash, free_info_ref, NULL);
 	vis_hash = NULL;
 	my_vis_info = NULL;
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
-- 
1.7.0.4

