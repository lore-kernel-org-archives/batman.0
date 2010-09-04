Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:34 +0200
Message-Id: <1283644718-653-18-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 17/21] Staging: batman-adv: attach each
	hard-interface to a soft-interface
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

This patch replaces the static bat0 interface with a dynamic/abstracted
approach. It is now possible to create multiple batX interfaces by
assigning hard interfaces to them. Each batX interface acts as an
independent mesh network. A soft interface is removed once no hard
interface references it any longer.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c       |   13 +-
 drivers/staging/batman-adv/bat_sysfs.c         |   67 ++++------
 drivers/staging/batman-adv/bitarray.c          |    7 +-
 drivers/staging/batman-adv/bitarray.h          |    4 +-
 drivers/staging/batman-adv/hard-interface.c    |  131 ++++++++++++-------
 drivers/staging/batman-adv/hard-interface.h    |    6 +-
 drivers/staging/batman-adv/hash.c              |    6 +-
 drivers/staging/batman-adv/hash.h              |    4 +-
 drivers/staging/batman-adv/icmp_socket.c       |    1 +
 drivers/staging/batman-adv/main.c              |   54 +--------
 drivers/staging/batman-adv/main.h              |    2 -
 drivers/staging/batman-adv/originator.c        |   39 +++---
 drivers/staging/batman-adv/originator.h        |    2 +-
 drivers/staging/batman-adv/routing.c           |  163 +++++++++++++-----------
 drivers/staging/batman-adv/routing.h           |   12 +-
 drivers/staging/batman-adv/send.c              |   48 ++++----
 drivers/staging/batman-adv/send.h              |    2 +-
 drivers/staging/batman-adv/soft-interface.c    |  118 ++++++++++++++---
 drivers/staging/batman-adv/soft-interface.h    |    8 +-
 drivers/staging/batman-adv/translation-table.c |   57 +++++----
 drivers/staging/batman-adv/translation-table.h |   13 +-
 drivers/staging/batman-adv/types.h             |    1 +
 drivers/staging/batman-adv/vis.c               |   13 +-
 23 files changed, 419 insertions(+), 352 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index 5896cf2..6e10fe5 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -97,18 +97,15 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 
 #define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
 /* create a new aggregated packet and add this packet to it */
-static void new_aggregated_packet(unsigned char *packet_buff,
-			   int packet_len,
-			   unsigned long send_time,
-			   bool direct_link,
-			   struct batman_if *if_incoming,
-			   int own_packet)
+static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
+				  unsigned long send_time, bool direct_link,
+				  struct batman_if *if_incoming,
+				  int own_packet)
 {
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
 	unsigned char *skb_buff;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 
 	/* own packet should always be scheduled */
 	if (!own_packet) {
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index b9fe391..052f9e8 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -180,9 +180,7 @@ static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
 		 frag_enabled_tmp == 1 ? "enabled" : "disabled");
 
 	atomic_set(&bat_priv->frag_enabled, (unsigned)frag_enabled_tmp);
-
-	update_min_mtu();
-
+	update_min_mtu(net_dev);
 	return count;
 }
 
@@ -358,20 +356,6 @@ int sysfs_add_meshif(struct net_device *dev)
 	struct bat_attribute **bat_attr;
 	int err;
 
-	/* FIXME: should be done in the general mesh setup
-		  routine as soon as we have it */
-	atomic_set(&bat_priv->aggregation_enabled, 1);
-	atomic_set(&bat_priv->bonding_enabled, 0);
-	atomic_set(&bat_priv->frag_enabled, 1);
-	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
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
@@ -441,32 +425,39 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (!batman_if)
 		return count;
 
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	if (strlen(buff) >= IFNAMSIZ) {
+		pr_err("Invalid parameter for 'mesh_iface' setting received: "
+		       "interface name too long '%s'\n", buff);
+		return -EINVAL;
+	}
+
 	if (strncmp(buff, "none", 4) == 0)
 		status_tmp = IF_NOT_IN_USE;
-
-	if (strncmp(buff, "bat0", 4) == 0)
-		status_tmp = IF_I_WANT_YOU;
-
-	if (status_tmp < 0) {
-		if (buff[count - 1] == '\n')
-			buff[count - 1] = '\0';
-
-		pr_err("Invalid parameter for 'mesh_iface' setting received: "
-		       "%s\n", buff);
-		return -EINVAL;
-	}
-
-	if ((batman_if->if_status == status_tmp) ||
-	    ((status_tmp == IF_I_WANT_YOU) &&
-	     (batman_if->if_status != IF_NOT_IN_USE)))
-		return count;
-
-	if (status_tmp == IF_I_WANT_YOU)
-		status_tmp = hardif_enable_interface(batman_if);
 	else
+		status_tmp = IF_I_WANT_YOU;
+
+	if ((batman_if->if_status == status_tmp) || ((batman_if->soft_iface) &&
+	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0)))
+		return count;
+
+	if (status_tmp == IF_NOT_IN_USE) {
+		rtnl_lock();
+		hardif_disable_interface(batman_if);
+		rtnl_unlock();
+		return count;
+	}
+
+	/* if the interface already is in use */
+	if (batman_if->if_status != IF_NOT_IN_USE) {
+		rtnl_lock();
 		hardif_disable_interface(batman_if);
+		rtnl_unlock();
+	}
 
-	return (status_tmp < 0 ? status_tmp : count);
+	return hardif_enable_interface(batman_if, buff);
 }
 
 static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
diff --git a/drivers/staging/batman-adv/bitarray.c b/drivers/staging/batman-adv/bitarray.c
index 9dbaf1e..814274f 100644
--- a/drivers/staging/batman-adv/bitarray.c
+++ b/drivers/staging/batman-adv/bitarray.c
@@ -127,11 +127,10 @@ static void bit_reset_window(TYPE_OF_WORD *seq_bits)
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
diff --git a/drivers/staging/batman-adv/bitarray.h b/drivers/staging/batman-adv/bitarray.h
index c0c1730..d961d56 100644
--- a/drivers/staging/batman-adv/bitarray.h
+++ b/drivers/staging/batman-adv/bitarray.h
@@ -38,8 +38,8 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n);
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
-char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
-					int8_t set_mark);
+char bit_get_packet(void *priv, TYPE_OF_WORD *seq_bits,
+		    int32_t seq_num_diff, int8_t set_mark);
 
 /* count the hamming weight, how many good packets did we receive? */
 int  bit_packet_count(TYPE_OF_WORD *seq_bits);
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index c1863d2..d31cfc3 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -128,9 +128,6 @@ static bool hardif_is_iface_up(struct batman_if *batman_if)
 
 static void update_mac_addresses(struct batman_if *batman_if)
 {
-	if (!batman_if || !batman_if->packet_buff)
-		return;
-
 	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
 
 	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
@@ -160,24 +157,28 @@ static void check_known_mac_addr(uint8_t *addr)
 	rcu_read_unlock();
 }
 
-int hardif_min_mtu(void)
+int hardif_min_mtu(struct net_device *soft_iface)
 {
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct batman_if *batman_if;
 	/* allow big frames if all devices are capable to do so
 	 * (have MTU > 1500 + BAT_HEADER_LEN) */
 	int min_mtu = ETH_DATA_LEN;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	if (atomic_read(&bat_priv->frag_enabled))
 		goto out;
 
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
 out:
@@ -185,22 +186,24 @@ out:
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
+
 	update_mac_addresses(batman_if);
 	batman_if->if_status = IF_TO_BE_ACTIVATED;
 
@@ -211,17 +214,17 @@ static void hardif_activate_interface(struct net_device *net_dev,
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
@@ -229,26 +232,39 @@ static void hardif_deactivate_interface(struct net_device *net_dev,
 
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
 
@@ -272,11 +288,12 @@ int hardif_enable_interface(struct batman_if *batman_if)
 
 	atomic_set(&batman_if->seqno, 1);
 	atomic_set(&batman_if->frag_seqno, 1);
-	bat_info(soft_device, "Adding interface: %s\n", batman_if->dev);
+	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
+		 batman_if->dev);
 
 	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
-		bat_info(soft_device,
+		bat_info(batman_if->soft_iface,
 			"The MTU of interface %s is too small (%i) to handle "
 			"the transport of batman-adv packets. Packets going "
 			"over this interface will be fragmented on layer2 "
@@ -287,7 +304,7 @@ int hardif_enable_interface(struct batman_if *batman_if)
 
 	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
-		bat_info(soft_device,
+		bat_info(batman_if->soft_iface,
 			"The MTU of interface %s is too small (%i) to handle "
 			"the transport of batman-adv packets. If you experience"
 			" problems getting traffic through try increasing the "
@@ -296,9 +313,9 @@ int hardif_enable_interface(struct batman_if *batman_if)
 			ETH_DATA_LEN + BAT_HEADER_LEN);
 
 	if (hardif_is_iface_up(batman_if))
-		hardif_activate_interface(soft_device, bat_priv, batman_if);
+		hardif_activate_interface(batman_if);
 	else
-		bat_err(soft_device, "Not using interface %s "
+		bat_err(batman_if->soft_iface, "Not using interface %s "
 			"(retrying later): interface not active\n",
 			batman_if->dev);
 
@@ -314,16 +331,16 @@ err:
 
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
 	dev_remove_pack(&batman_if->batman_adv_ptype);
 
 	bat_priv->num_ifaces--;
@@ -335,10 +352,17 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	kfree(batman_if->packet_buff);
 	batman_if->packet_buff = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
+	dev_put(batman_if->soft_iface);
 
-	if ((atomic_read(&module_state) == MODULE_ACTIVE) &&
+	/* nobody uses this interface anymore */
+	if (!bat_priv->num_ifaces)
+		softif_destroy(batman_if->soft_iface);
+
+	batman_if->soft_iface = NULL;
+
+	/*if ((atomic_read(&module_state) == MODULE_ACTIVE) &&
 	    (bat_priv->num_ifaces == 0))
-		deactivate_module();
+		deactivate_module();*/
 }
 
 static struct batman_if *hardif_add_interface(struct net_device *net_dev)
@@ -369,8 +393,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if->if_num = -1;
 	batman_if->net_dev = net_dev;
+	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
-	batman_if->packet_buff = NULL;
 	INIT_LIST_HEAD(&batman_if->list);
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
@@ -419,8 +443,11 @@ void hardif_remove_interfaces(void)
 {
 	struct batman_if *batman_if, *batman_if_tmp;
 
-	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list)
+	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list) {
+		rtnl_lock();
 		hardif_remove_interface(batman_if);
+		rtnl_unlock();
+	}
 }
 
 static int hard_if_event(struct notifier_block *this,
@@ -428,8 +455,7 @@ static int hard_if_event(struct notifier_block *this,
 {
 	struct net_device *net_dev = (struct net_device *)ptr;
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 
 	if (!batman_if && event == NETDEV_REGISTER)
 			batman_if = hardif_add_interface(net_dev);
@@ -439,11 +465,11 @@ static int hard_if_event(struct notifier_block *this,
 
 	switch (event) {
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
@@ -451,8 +477,13 @@ static int hard_if_event(struct notifier_block *this,
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
@@ -469,8 +500,7 @@ out:
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct packet_type *ptype, struct net_device *orig_dev)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
 	int ret;
@@ -499,6 +529,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		goto err_free;
 
 	batman_packet = (struct batman_packet *)skb->data;
+	bat_priv = netdev_priv(batman_if->soft_iface);
 
 	if (batman_packet->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -518,7 +549,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 		/* batman icmp packet */
 	case BAT_ICMP:
-		ret = recv_icmp_packet(skb);
+		ret = recv_icmp_packet(skb, batman_if);
 		break;
 
 		/* unicast packet */
@@ -533,12 +564,12 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
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
diff --git a/drivers/staging/batman-adv/hard-interface.h b/drivers/staging/batman-adv/hard-interface.h
index d5640b0..4b49527 100644
--- a/drivers/staging/batman-adv/hard-interface.h
+++ b/drivers/staging/batman-adv/hard-interface.h
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
diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index 1286f8f..8ef26eb 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
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
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index c483e11..2c8e176 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
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
diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index 8e986a1..2a1d3dd 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -156,6 +156,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	struct bat_priv *bat_priv = socket_client->bat_priv;
 	struct sk_buff *skb;
 	struct icmp_packet_rr *icmp_packet;
+
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
 	size_t packet_len = sizeof(struct icmp_packet);
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index eb0bfbe..52c019b 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -44,8 +44,6 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 int16_t num_hna;
 
-struct net_device *soft_device;
-
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 atomic_t module_state;
 
@@ -53,8 +51,6 @@ struct workqueue_struct *bat_event_workqueue;
 
 static int __init batman_init(void)
 {
-	int retval;
-
 	INIT_LIST_HEAD(&if_list);
 	INIT_HLIST_HEAD(&forw_bat_list);
 	INIT_HLIST_HEAD(&forw_bcast_list);
@@ -71,32 +67,6 @@ static int __init batman_init(void)
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
 
 	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) "
@@ -104,19 +74,6 @@ static int __init batman_init(void)
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
 
 static void __exit batman_exit(void)
@@ -127,13 +84,6 @@ static void __exit batman_exit(void)
 	unregister_netdevice_notifier(&hard_if_notifier);
 	hardif_remove_interfaces();
 
-	if (soft_device) {
-		debugfs_del_meshif(soft_device);
-		sysfs_del_meshif(soft_device);
-		unregister_netdev(soft_device);
-		soft_device = NULL;
-	}
-
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
 }
@@ -150,12 +100,12 @@ void activate_module(void)
 	if (hna_global_init() < 1)
 		goto err;
 
-	hna_local_add(soft_device->dev_addr);
+	/*hna_local_add(soft_device->dev_addr);*/
 
 	if (vis_init() < 1)
 		goto err;
 
-	update_min_mtu();
+	/*update_min_mtu();*/
 	atomic_set(&module_state, MODULE_ACTIVE);
 	goto end;
 
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 2d364e0..2309d82 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -138,8 +138,6 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern int16_t num_hna;
 
-extern struct net_device *soft_device;
-
 extern unsigned char broadcast_addr[];
 extern atomic_t module_state;
 extern struct workqueue_struct *bat_event_workqueue;
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index b51a13e..7ed3266 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -61,8 +61,7 @@ struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -82,11 +81,12 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
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
 	}
 
 	frag_list_free(&orig_node->frag_list);
-	hna_global_del_orig(orig_node, "originator timed out");
+	hna_global_del_orig(bat_priv, orig_node, "originator timed out");
 
 	kfree(orig_node->bcast_own);
 	kfree(orig_node->bcast_own_sum);
@@ -114,17 +114,15 @@ void originator_free(void)
 	cancel_delayed_work_sync(&purge_orig_wq);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	hash_delete(orig_hash, free_orig_node);
+	/*hash_delete(orig_hash, free_orig_node, bat_priv);*/
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
@@ -173,7 +171,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			bat_err(soft_device,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
@@ -189,11 +187,10 @@ free_orig_node:
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
@@ -235,10 +232,9 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
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
@@ -249,8 +245,10 @@ static bool purge_orig_node(struct orig_node *orig_node)
 			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
 	} else {
-		if (purge_orig_neighbors(orig_node, &best_neigh_node)) {
-			update_routes(orig_node, best_neigh_node,
+		if (purge_orig_neighbors(bat_priv, orig_node,
+							&best_neigh_node)) {
+			update_routes(bat_priv, orig_node,
+				      best_neigh_node,
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
 			/* update bonding candidates, we could have lost
@@ -273,13 +271,14 @@ void purge_orig(struct work_struct *work)
 	/* for all origins... */
 	while (hash_iterate(orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
-		if (purge_orig_node(orig_node)) {
+
+		/*if (purge_orig_node(bat_priv, orig_node)) {
 			hash_remove_bucket(orig_hash, &hashit);
 			free_orig_node(orig_node);
-		}
+		}*/
 
 		if (time_after(jiffies, (orig_node->last_frag_packet +
-			msecs_to_jiffies(FRAG_TIMEOUT))))
+					msecs_to_jiffies(FRAG_TIMEOUT))))
 			frag_list_free(&orig_node->frag_list);
 	}
 
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index e88411d..bc47c68 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -25,7 +25,7 @@
 int originator_init(void);
 void originator_free(void);
 void purge_orig(struct work_struct *work);
-struct orig_node *get_orig_node(uint8_t *addr);
+struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 6009adc..3cae7c4 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -38,6 +38,7 @@ static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
@@ -49,7 +50,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 		orig_node = hashit.bucket->data;
 		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
 
-		bit_get_packet(word, 1, 0);
+		bit_get_packet(bat_priv, word, 1, 0);
 		orig_node->bcast_own_sum[batman_if->if_num] =
 			bit_packet_count(word);
 	}
@@ -57,7 +58,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
 
-static void update_HNA(struct orig_node *orig_node,
+static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		       unsigned char *hna_buff, int hna_buff_len)
 {
 	if ((hna_buff_len != orig_node->hna_buff_len) ||
@@ -66,27 +67,27 @@ static void update_HNA(struct orig_node *orig_node,
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
+		hna_global_del_orig(bat_priv, orig_node,
+				    "originator timed out");
 
 		/* route added */
 	} else if ((orig_node->router == NULL) && (neigh_node != NULL)) {
@@ -94,7 +95,8 @@ static void update_route(struct orig_node *orig_node,
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Adding route towards: %pM (via %pM)\n",
 			orig_node->orig, neigh_node->addr);
-		hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
+		hna_global_add_orig(bat_priv, orig_node,
+				    hna_buff, hna_buff_len);
 
 		/* route changed */
 	} else {
@@ -109,19 +111,20 @@ static void update_route(struct orig_node *orig_node,
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
@@ -129,8 +132,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct batman_packet *batman_packet,
 				struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	unsigned char total_count;
 
@@ -234,14 +236,14 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
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
 
@@ -267,12 +269,11 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
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
@@ -314,11 +315,13 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	      >= neigh_node->orig_node->bcast_own_sum[if_incoming->if_num])))
 		goto update_hna;
 
-	update_routes(orig_node, neigh_node, hna_buff, tmp_hna_buff_len);
+	update_routes(bat_priv, orig_node, neigh_node,
+		      hna_buff, tmp_hna_buff_len);
 	return;
 
 update_hna:
-	update_routes(orig_node, orig_node->router, hna_buff, tmp_hna_buff_len);
+	update_routes(bat_priv, orig_node, orig_node->router,
+		      hna_buff, tmp_hna_buff_len);
 }
 
 /* checks whether the host restarted and is in the protection time.
@@ -326,12 +329,10 @@ update_hna:
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
@@ -360,8 +361,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			       struct batman_packet *batman_packet,
 			       struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	char is_duplicate = 0;
@@ -369,14 +369,15 @@ static char count_real_packets(struct ethhdr *ethhdr,
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
@@ -392,8 +393,9 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			set_mark = 0;
 
 		/* if the window moved, set the update flag. */
-		need_update |= bit_get_packet(tmp_neigh_node->real_bits,
-						seq_diff, set_mark);
+		need_update |= bit_get_packet(bat_priv,
+					      tmp_neigh_node->real_bits,
+					      seq_diff, set_mark);
 
 		tmp_neigh_node->real_packet_count =
 			bit_packet_count(tmp_neigh_node->real_bits);
@@ -521,8 +523,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batman_if *batman_if;
 	struct orig_node *orig_neigh_node, *orig_node;
 	char has_directlink_flag;
@@ -609,7 +610,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		TYPE_OF_WORD *word;
 		int offset;
 
-		orig_neigh_node = get_orig_node(ethhdr->h_source);
+		orig_neigh_node = get_orig_node(bat_priv, ethhdr->h_source);
 
 		if (!orig_neigh_node)
 			return;
@@ -641,7 +642,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		return;
 	}
 
-	orig_node = get_orig_node(batman_packet->orig);
+	orig_node = get_orig_node(bat_priv, batman_packet->orig);
 	if (orig_node == NULL)
 		return;
 
@@ -677,7 +678,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac */
 	orig_neigh_node = (is_single_hop_neigh ?
-			   orig_node : get_orig_node(ethhdr->h_source));
+			   orig_node :
+			   get_orig_node(bat_priv, ethhdr->h_source));
 	if (orig_neigh_node == NULL)
 		return;
 
@@ -699,7 +701,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    (!is_duplicate ||
 	     ((orig_node->last_real_seqno == batman_packet->seqno) &&
 	      (orig_node->last_ttl - 3 <= batman_packet->ttl))))
-		update_orig(orig_node, ethhdr, batman_packet,
+		update_orig(bat_priv, orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
 	mark_bonding_address(bat_priv, orig_node,
@@ -778,10 +780,11 @@ int recv_bat_packet(struct sk_buff *skb,
 	return NET_RX_SUCCESS;
 }
 
-static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
+static int recv_my_icmp_packet(struct sk_buff *skb,
+			       struct batman_if *recv_if, size_t icmp_len)
 {
 	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node;
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
@@ -840,10 +843,11 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 	return ret;
 }
 
-static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
+static int recv_icmp_ttl_exceeded(struct sk_buff *skb,
+			       struct batman_if *recv_if, size_t icmp_len)
 {
 	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
 	struct ethhdr *ethhdr;
@@ -904,7 +908,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 }
 
 
-int recv_icmp_packet(struct sk_buff *skb)
+int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
@@ -951,11 +955,11 @@ int recv_icmp_packet(struct sk_buff *skb)
 
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
-		return recv_my_icmp_packet(skb, hdr_size);
+		return recv_my_icmp_packet(skb, recv_if, hdr_size);
 
 	/* TTL exceeded */
 	if (icmp_packet->ttl < 2)
-		return recv_icmp_ttl_exceeded(skb, hdr_size);
+		return recv_icmp_ttl_exceeded(skb, recv_if, hdr_size);
 
 	ret = NET_RX_DROP;
 
@@ -996,10 +1000,9 @@ int recv_icmp_packet(struct sk_buff *skb)
 /* find a suitable router for this originator, and use
  * bonding if possible. */
 struct neigh_node *find_router(struct orig_node *orig_node,
-		struct batman_if *recv_if)
+			       struct batman_if *recv_if)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
 	struct neigh_node *router, *first_candidate, *best_router;
@@ -1015,9 +1018,14 @@ struct neigh_node *find_router(struct orig_node *orig_node,
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
 
@@ -1094,7 +1102,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return -1;
 
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_bcast(ethhdr->h_dest))
@@ -1111,17 +1119,24 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-static int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
-		int hdr_size)
+static int route_unicast_packet(struct sk_buff *skb,
+				struct batman_if *recv_if, int hdr_size)
 {
 	struct orig_node *orig_node;
 	struct neigh_node *router;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 	unsigned long flags;
-	struct unicast_packet *unicast_packet =
-		(struct unicast_packet *) skb->data;
-	struct ethhdr *ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	struct unicast_packet *unicast_packet;
+	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	unicast_packet = (struct unicast_packet *)skb->data;
+
+	/* packet for me */
+	if (is_my_mac(unicast_packet->dest)) {
+		interface_rx(recv_if->soft_iface, skb, hdr_size);
+		return NET_RX_SUCCESS;
+	}
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
@@ -1175,11 +1190,11 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
-	unicast_packet = (struct unicast_packet *) skb->data;
+	unicast_packet = (struct unicast_packet *)skb->data;
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(skb, hdr_size);
+		interface_rx(recv_if->soft_iface, skb, hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
@@ -1234,18 +1249,20 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		if (!skb)
 			return NET_RX_DROP;
 
-		interface_rx(skb, hdr_size);
+		interface_rx(recv_if->soft_iface, skb, hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
 	return route_unicast_packet(skb, recv_if, hdr_size);
 }
 
-int recv_bcast_packet(struct sk_buff *skb)
+
+int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
 {
 	struct orig_node *orig_node;
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	int hdr_size = sizeof(struct bcast_packet);
 	int32_t seq_diff;
 	unsigned long flags;
@@ -1297,31 +1314,32 @@ int recv_bcast_packet(struct sk_buff *skb)
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
 
 	/* keep skb linear */
@@ -1331,7 +1349,7 @@ int recv_vis_packet(struct sk_buff *skb)
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return NET_RX_DROP;
 
-	vis_packet = (struct vis_packet *) skb->data;
+	vis_packet = (struct vis_packet *)skb->data;
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* not for me */
@@ -1345,9 +1363,6 @@ int recv_vis_packet(struct sk_buff *skb)
 	if (is_my_mac(vis_packet->sender_orig))
 		return NET_RX_DROP;
 
-	/* FIXME: each batman_if will be attached to a softif */
-	bat_priv = netdev_priv(soft_device);
-
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
 		receive_server_sync_packet(bat_priv, vis_packet,
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index 81c684f..55995e4 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -29,14 +29,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				struct batman_packet *batman_packet,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming);
-void update_routes(struct orig_node *orig_node,
-				struct neigh_node *neigh_node,
-				unsigned char *hna_buff, int hna_buff_len);
-int recv_icmp_packet(struct sk_buff *skb);
+void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
+		   struct neigh_node *neigh_node, unsigned char *hna_buff,
+		   int hna_buff_len);
+int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
-int recv_bcast_packet(struct sk_buff *skb);
-int recv_vis_packet(struct sk_buff *skb);
+int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
 struct neigh_node *find_router(struct orig_node *orig_node,
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index aebd6c3..3505d1b 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -103,8 +103,7 @@ send_skb_err:
 static void send_packet_to_if(struct forw_packet *forw_packet,
 			      struct batman_if *batman_if)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	char *fwd_str;
 	uint8_t packet_num;
 	int16_t buff_pos;
@@ -160,9 +159,9 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 /* send a batman packet */
 static void send_packet(struct forw_packet *forw_packet)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_if *batman_if;
+	struct bat_priv *bat_priv =
+		netdev_priv(forw_packet->if_incoming->soft_iface);
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->skb->data);
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
@@ -232,8 +231,7 @@ static void rebuild_batman_packet(struct batman_if *batman_if)
 
 void schedule_own_packet(struct batman_if *batman_if)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
 	int vis_server;
@@ -290,8 +288,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_incoming)
 {
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
@@ -381,12 +378,10 @@ static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
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
@@ -409,6 +404,7 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 
 	forw_packet->skb = skb;
+	forw_packet->if_incoming = bat_priv->primary_if;
 
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
@@ -433,8 +429,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
 	struct sk_buff *skb1;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -463,6 +458,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	}
 
 out:
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 	forw_packet_free(forw_packet);
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
@@ -474,8 +470,7 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	struct forw_packet *forw_packet =
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct bat_priv *bat_priv;
 
 	spin_lock_irqsave(&forw_bat_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -495,6 +490,8 @@ void send_outstanding_bat_packet(struct work_struct *work)
 		schedule_own_packet(forw_packet->if_incoming);
 
 out:
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
+
 	/* don't count own packet */
 	if (!forw_packet->own)
 		atomic_inc(&bat_priv->batman_queue_left);
@@ -504,19 +501,22 @@ out:
 
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
diff --git a/drivers/staging/batman-adv/send.h b/drivers/staging/batman-adv/send.h
index 0cfe027..39a3426 100644
--- a/drivers/staging/batman-adv/send.h
+++ b/drivers/staging/batman-adv/send.h
@@ -33,7 +33,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     struct batman_packet *batman_packet,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
-int  add_bcast_packet_to_list(struct sk_buff *skb);
+int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct batman_if *batman_if);
 
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index e8be209..864f85d 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -22,8 +22,14 @@
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
+#include "routing.h"
+#include "send.h"
+#include "bat_debugfs.h"
 #include "translation-table.h"
+#include "types.h"
+#include "hash.h"
 #include "send.h"
+#include "bat_sysfs.h"
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
@@ -92,12 +98,13 @@ static int interface_release(struct net_device *dev)
 
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
@@ -105,8 +112,9 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 
 	/* only modify hna-table if it has been initialised before */
 	if (atomic_read(&module_state) == MODULE_ACTIVE) {
-		hna_local_remove(dev->dev_addr, "mac address changed");
-		hna_local_add(addr->sa_data);
+		hna_local_remove(bat_priv, dev->dev_addr,
+				 "mac address changed");
+		hna_local_add(dev, addr->sa_data);
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
@@ -117,7 +125,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 static int interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
-	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu()))
+	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu(dev)))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
@@ -125,19 +133,20 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-int interface_tx(struct sk_buff *skb, struct net_device *dev)
+int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct bcast_packet *bcast_packet;
 	int data_len = skb->len, ret;
 
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dropped;
 
-	dev->trans_start = jiffies;
+	soft_iface->trans_start = jiffies;
+
 	/* TODO: check this for locks */
-	hna_local_add(ethhdr->h_source);
+	hna_local_add(soft_iface, ethhdr->h_source);
 
 	/* ethernet packet should be broadcasted */
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
@@ -160,7 +169,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		bcast_packet->seqno = htonl(bcast_seqno);
 
 		/* broadcast packet. on success, increase seqno. */
-		if (add_bcast_packet_to_list(skb) == NETDEV_TX_OK)
+		if (add_bcast_packet_to_list(bat_priv, skb) == NETDEV_TX_OK)
 			bcast_seqno++;
 
 		/* a copy is stored in the bcast list, therefore removing
@@ -187,10 +196,10 @@ end:
 	return NETDEV_TX_OK;
 }
 
-void interface_rx(struct sk_buff *skb, int hdr_size)
+void interface_rx(struct net_device *soft_iface,
+		  struct sk_buff *skb, int hdr_size)
 {
-	struct net_device *dev = soft_device;
-	struct bat_priv *priv = netdev_priv(dev);
+	struct bat_priv *priv = netdev_priv(soft_iface);
 
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size)) {
@@ -200,8 +209,8 @@ void interface_rx(struct sk_buff *skb, int hdr_size)
 	skb_pull_rcsum(skb, hdr_size);
 /*	skb_set_mac_header(skb, -sizeof(struct ethhdr));*/
 
-	skb->dev = dev;
-	skb->protocol = eth_type_trans(skb, dev);
+	skb->dev = soft_iface;
+	skb->protocol = eth_type_trans(skb, soft_iface);
 
 	/* should not be neccesary anymore as we use skb_pull_rcsum()
 	 * TODO: please verify this and remove this TODO
@@ -215,7 +224,7 @@ void interface_rx(struct sk_buff *skb, int hdr_size)
 	priv->stats.rx_packets++;
 	priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
 
-	dev->last_rx = jiffies;
+	soft_iface->last_rx = jiffies;
 
 	netif_rx(skb);
 }
@@ -232,7 +241,7 @@ static const struct net_device_ops bat_netdev_ops = {
 };
 #endif
 
-void interface_setup(struct net_device *dev)
+static void interface_setup(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
 	char dev_addr[ETH_ALEN];
@@ -251,9 +260,11 @@ void interface_setup(struct net_device *dev)
 #endif
 	dev->destructor = free_netdev;
 
-	dev->mtu = ETH_DATA_LEN;	/* can't call min_mtu, because the
-					 * needed variables have not been
-					 * initialized yet */
+	/**
+	 * can't call min_mtu, because the needed variables
+	 * have not been initialized yet
+	 */
+	dev->mtu = ETH_DATA_LEN;
 	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
 						* skbuff for our header */
 
@@ -266,6 +277,73 @@ void interface_setup(struct net_device *dev)
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
+	atomic_set(&bat_priv->orig_interval, 1000);
+	atomic_set(&bat_priv->log_level, 0);
+	atomic_set(&bat_priv->frag_enabled, 1);
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
+	unregister_netdevice(soft_iface);
+}
+
 /* ethtool */
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
diff --git a/drivers/staging/batman-adv/soft-interface.h b/drivers/staging/batman-adv/soft-interface.h
index 9dbf5fc..04f04b4 100644
--- a/drivers/staging/batman-adv/soft-interface.h
+++ b/drivers/staging/batman-adv/soft-interface.h
@@ -23,10 +23,12 @@
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
 void set_main_if_addr(uint8_t *addr);
-void interface_setup(struct net_device *dev);
-int interface_tx(struct sk_buff *skb, struct net_device *dev);
-void interface_rx(struct sk_buff *skb, int hdr_size);
 int my_skb_head_push(struct sk_buff *skb, unsigned int len);
+int interface_tx(struct sk_buff *skb, struct net_device *soft_iface);
+void interface_rx(struct net_device *soft_iface,
+		  struct sk_buff *skb, int hdr_size);
+struct net_device *softif_create(char *name);
+void softif_destroy(struct net_device *soft_iface);
 
 extern unsigned char main_if_addr[];
 
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index b233377..55e5e08 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -34,7 +34,8 @@ static DEFINE_SPINLOCK(hna_global_hash_lock);
 
 static void hna_local_purge(struct work_struct *work);
 static DECLARE_DELAYED_WORK(hna_local_purge_wq, hna_local_purge);
-static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+static void _hna_global_del_orig(struct bat_priv *bat_priv,
+				 struct hna_global_entry *hna_global_entry,
 				 char *message);
 
 static void hna_local_start_timer(void)
@@ -58,10 +59,9 @@ int hna_local_init(void)
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
@@ -100,7 +100,7 @@ void hna_local_add(uint8_t *addr)
 	hna_local_entry->last_seen = jiffies;
 
 	/* the batman interface mac address should never be purged */
-	if (compare_orig(addr, soft_device->dev_addr))
+	if (compare_orig(addr, soft_iface->dev_addr))
 		hna_local_entry->never_purge = 1;
 	else
 		hna_local_entry->never_purge = 0;
@@ -130,7 +130,8 @@ void hna_local_add(uint8_t *addr)
 		((struct hna_global_entry *)hash_find(hna_global_hash, addr));
 
 	if (hna_global_entry != NULL)
-		_hna_global_del_orig(hna_global_entry, "local hna received");
+		_hna_global_del_orig(bat_priv, hna_global_entry,
+				     "local hna received");
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 }
@@ -214,26 +215,26 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
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
@@ -243,7 +244,7 @@ void hna_local_remove(uint8_t *addr, char *message)
 	hna_local_entry = (struct hna_local_entry *)
 		hash_find(hna_local_hash, addr);
 	if (hna_local_entry)
-		hna_local_del(hna_local_entry, message);
+		hna_local_del(bat_priv, hna_local_entry, message);
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 }
@@ -261,9 +262,10 @@ static void hna_local_purge(struct work_struct *work)
 		hna_local_entry = hashit.bucket->data;
 
 		timeout = hna_local_entry->last_seen + LOCAL_HNA_TIMEOUT * HZ;
-		if ((!hna_local_entry->never_purge) &&
+		/* if ((!hna_local_entry->never_purge) &&
 		    time_after(jiffies, timeout))
-			hna_local_del(hna_local_entry, "address timed out");
+			hna_local_del(bat_priv, hna_local_entry,
+				      "address timed out");*/
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -276,7 +278,7 @@ void hna_local_free(void)
 		return;
 
 	cancel_delayed_work_sync(&hna_local_purge_wq);
-	hash_delete(hna_local_hash, _hna_local_del);
+	hash_delete(hna_local_hash, _hna_local_del, NULL);
 	hna_local_hash = NULL;
 }
 
@@ -293,11 +295,10 @@ int hna_global_init(void)
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
@@ -345,7 +346,8 @@ void hna_global_add_orig(struct orig_node *orig_node,
 			hash_find(hna_local_hash, hna_ptr);
 
 		if (hna_local_entry != NULL)
-			hna_local_del(hna_local_entry, "global hna received");
+			hna_local_del(bat_priv, hna_local_entry,
+				      "global hna received");
 
 		spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 
@@ -429,11 +431,10 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
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
@@ -443,7 +444,8 @@ static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 	kfree(hna_global_entry);
 }
 
-void hna_global_del_orig(struct orig_node *orig_node, char *message)
+void hna_global_del_orig(struct bat_priv *bat_priv,
+			 struct orig_node *orig_node, char *message)
 {
 	struct hna_global_entry *hna_global_entry;
 	int hna_buff_count = 0;
@@ -462,7 +464,8 @@ void hna_global_del_orig(struct orig_node *orig_node, char *message)
 
 		if ((hna_global_entry != NULL) &&
 		    (hna_global_entry->orig_node == orig_node))
-			_hna_global_del_orig(hna_global_entry, message);
+			_hna_global_del_orig(bat_priv, hna_global_entry,
+					     message);
 
 		hna_buff_count++;
 	}
@@ -474,7 +477,7 @@ void hna_global_del_orig(struct orig_node *orig_node, char *message)
 	orig_node->hna_buff = NULL;
 }
 
-static void hna_global_del(void *data)
+static void hna_global_del(void *data, void *arg)
 {
 	kfree(data);
 }
@@ -484,7 +487,7 @@ void hna_global_free(void)
 	if (!hna_global_hash)
 		return;
 
-	hash_delete(hna_global_hash, hna_global_del);
+	hash_delete(hna_global_hash, hna_global_del, NULL);
 	hna_global_hash = NULL;
 }
 
diff --git a/drivers/staging/batman-adv/translation-table.h b/drivers/staging/batman-adv/translation-table.h
index fa93e37..af7a59c 100644
--- a/drivers/staging/batman-adv/translation-table.h
+++ b/drivers/staging/batman-adv/translation-table.h
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
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 4b2e832..c5b738d 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -47,6 +47,7 @@ struct batman_if {
 	struct kobject *hardif_obj;
 	struct rcu_head rcu;
 	struct packet_type batman_adv_ptype;
+	struct net_device *soft_iface;
 };
 
 /**
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index e89a710..ad899fe 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -745,17 +745,16 @@ static void send_vis_packets(struct work_struct *work)
 {
 	struct vis_info *info, *temp;
 	unsigned long flags;
-	/* FIXME: each batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	/* struct bat_priv *bat_priv = netdev_priv(soft_device); */
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 
 	purge_vis_packets();
 
-	if (generate_vis_packet(bat_priv) == 0) {
+	/* if (generate_vis_packet(bat_priv) == 0) {*/
 		/* schedule if generation was successful */
-		send_list_add(my_vis_info);
-	}
+		/*send_list_add(my_vis_info);
+	} */
 
 	list_for_each_entry_safe(info, temp, &send_list, send_list) {
 
@@ -842,7 +841,7 @@ err:
 }
 
 /* Decrease the reference count on a hash item info */
-static void free_info_ref(void *data)
+static void free_info_ref(void *data, void *arg)
 {
 	struct vis_info *info = data;
 
@@ -861,7 +860,7 @@ void vis_quit(void)
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	/* properly remove, kill timers ... */
-	hash_delete(vis_hash, free_info_ref);
+	hash_delete(vis_hash, free_info_ref, NULL);
 	vis_hash = NULL;
 	my_vis_info = NULL;
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
-- 
1.7.1

