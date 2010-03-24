Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Mar 2010 12:52:42 +0800
Message-Id: <1269406363-9593-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003241252.18954.lindner_marek@yahoo.de>
References: <201003241252.18954.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: move /proc interface
	handling to /sys
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Instead of having a single /proc file "interfaces" in which you have
to echo the wanted interface batman-adv will create a subfolder in each
suitable /sys/class/net folder. This subfolder contains files for the
interface specific settings. For example, mesh_iface to add/remove an
interface from a virtual mesh network (at the moment only bat0 is
supported).

Example:
echo bat0 > /sys/class/net/eth0/batman-adv/mesh_iface

to deactivate:
echo none > /sys/class/net/eth0/batman-adv/mesh_iface

Interfaces which are not compatible with batman-adv won't contain the
batman-adv folder, therefore can't be activated. Not supported are:
loopback, non-ethernet, non-ARP and virtual mesh network interfaces

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/Makefile.kbuild     |    2 +-
 batman-adv-kernelland/bat_sysfs.c         |  144 ++++++++
 batman-adv-kernelland/bat_sysfs.h         |    3 +
 batman-adv-kernelland/device.c            |    2 +-
 batman-adv-kernelland/gateway_client.c    |    9 +-
 batman-adv-kernelland/hard-interface.c    |  515 +++++++++++++++--------------
 batman-adv-kernelland/hard-interface.h    |   18 +-
 batman-adv-kernelland/main.c              |   21 +-
 batman-adv-kernelland/main.h              |    3 +-
 batman-adv-kernelland/originator.c        |  195 ++++++++++-
 batman-adv-kernelland/originator.h        |    2 +
 batman-adv-kernelland/proc.c              |  173 ----------
 batman-adv-kernelland/proc.h              |   30 --
 batman-adv-kernelland/routing.c           |    4 +-
 batman-adv-kernelland/send.c              |   51 +++-
 batman-adv-kernelland/send.h              |    2 +-
 batman-adv-kernelland/soft-interface.c    |    4 +-
 batman-adv-kernelland/translation-table.c |   14 +-
 batman-adv-kernelland/types.h             |    5 +-
 batman-adv-kernelland/vis.c               |    7 +-
 20 files changed, 668 insertions(+), 536 deletions(-)
 delete mode 100644 batman-adv-kernelland/proc.c
 delete mode 100644 batman-adv-kernelland/proc.h

diff --git a/batman-adv-kernelland/Makefile.kbuild b/batman-adv-kernelland/Makefile.kbuild
index c1f181a..e9b58b9 100644
--- a/batman-adv-kernelland/Makefile.kbuild
+++ b/batman-adv-kernelland/Makefile.kbuild
@@ -32,4 +32,4 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o proc.o bat_sysfs.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-objs := main.o bat_sysfs.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index 58bf44e..4dffa00 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -38,6 +38,14 @@ struct bat_attribute {
 			 char *buf, size_t count);
 };
 
+struct hardif_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
+			 char *buf, size_t count);
+};
+
 #define BAT_ATTR(_name, _mode, _show, _store)	\
 struct bat_attribute bat_attr_##_name = {	\
 	.attr = {.name = __stringify(_name),	\
@@ -54,6 +62,14 @@ struct bin_attribute bat_attr_##_name = {		\
 	.write = _write,				\
 };
 
+#define HARDIF_ATTR(_name, _mode, _show, _store)	\
+struct hardif_attribute hardif_attr_##_name = {		\
+	.attr = {.name = __stringify(_name),		\
+		 .mode = _mode },			\
+	.show   = _show,				\
+	.store  = _store,				\
+};
+
 static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -392,6 +408,8 @@ int sysfs_add_meshif(struct net_device *dev)
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_class, 0);
 	atomic_set(&bat_priv->orig_interval, 1000);
+	bat_priv->primary_if = NULL;
+	bat_priv->num_ifaces = 0;
 
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
@@ -452,3 +470,129 @@ void sysfs_del_meshif(struct net_device *dev)
 	kobject_put(bat_priv->mesh_obj);
 	bat_priv->mesh_obj = NULL;
 }
+
+static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
+			       char *buff)
+{
+	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
+
+	if (!batman_if)
+		return 0;
+
+	return sprintf(buff, "status: %s\ncommands: none, bat0 \n",
+		       batman_if->if_status == IF_NOT_IN_USE ?
+							"none" : "bat0");
+}
+
+static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
+				char *buff, size_t count)
+{
+	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
+	int status_tmp = -1;
+
+	if (!batman_if)
+		return count;
+
+	if (strncmp(buff, "none", 4) == 0)
+		status_tmp = IF_NOT_IN_USE;
+
+	if (strncmp(buff, "bat0", 4) == 0)
+		status_tmp = IF_I_WANT_YOU;
+
+	if (status_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		printk(KERN_ERR "batman-adv:Invalid parameter for 'mesh_iface' setting received: %s\n",
+		       buff);
+		return -EINVAL;
+	}
+
+	if ((batman_if->if_status == status_tmp) ||
+	    ((status_tmp == IF_I_WANT_YOU) &&
+	     (batman_if->if_status != IF_NOT_IN_USE)))
+		return count;
+
+	if (status_tmp == IF_I_WANT_YOU)
+		status_tmp = hardif_enable_interface(batman_if);
+	else
+		hardif_disable_interface(batman_if);
+
+	return (status_tmp < 0 ? status_tmp : count);
+}
+
+static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
+				 char *buff)
+{
+	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
+
+	if (!batman_if)
+		return 0;
+
+	switch (batman_if->if_status) {
+	case IF_TO_BE_REMOVED:
+		return sprintf(buff, "disabling\n");
+	case IF_INACTIVE:
+		return sprintf(buff, "inactive\n");
+	case IF_ACTIVE:
+		return sprintf(buff, "active\n");
+	case IF_TO_BE_ACTIVATED:
+		return sprintf(buff, "enabling\n");
+	case IF_NOT_IN_USE:
+	default:
+		return sprintf(buff, "not in use\n");
+	}
+}
+
+static HARDIF_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
+		   show_mesh_iface, store_mesh_iface);
+static HARDIF_ATTR(iface_status, S_IRUGO, show_iface_status, NULL);
+
+static struct hardif_attribute *batman_attrs[] = {
+	&hardif_attr_mesh_iface,
+	&hardif_attr_iface_status,
+	NULL,
+};
+
+int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
+{
+	struct kobject *hardif_kobject = &dev->dev.kobj;
+	struct hardif_attribute **hardif_attr;
+	int err;
+
+	*hardif_obj = kobject_create_and_add(SYSFS_IF_BAT_SUBDIR,
+						    hardif_kobject);
+
+	if (!*hardif_obj) {
+		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
+		       dev->name, SYSFS_IF_BAT_SUBDIR);
+		goto out;
+	}
+
+	for (hardif_attr = batman_attrs; *hardif_attr; ++hardif_attr) {
+		err = sysfs_create_file(*hardif_obj, &((*hardif_attr)->attr));
+		if (err) {
+			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			       dev->name, SYSFS_IF_BAT_SUBDIR,
+			       ((*hardif_attr)->attr).name);
+			goto rem_attr;
+		}
+	}
+
+	return 0;
+
+rem_attr:
+	for (hardif_attr = batman_attrs; *hardif_attr; ++hardif_attr)
+		sysfs_remove_file(*hardif_obj, &((*hardif_attr)->attr));
+out:
+	return -ENOMEM;
+}
+
+void sysfs_del_hardif(struct kobject **hardif_obj)
+{
+	kobject_put(*hardif_obj);
+	*hardif_obj = NULL;
+}
diff --git a/batman-adv-kernelland/bat_sysfs.h b/batman-adv-kernelland/bat_sysfs.h
index 671ebd1..e189341 100644
--- a/batman-adv-kernelland/bat_sysfs.h
+++ b/batman-adv-kernelland/bat_sysfs.h
@@ -21,6 +21,9 @@
 
 
 #define SYSFS_IF_MESH_SUBDIR "mesh"
+#define SYSFS_IF_BAT_SUBDIR "batman_adv"
 
 int sysfs_add_meshif(struct net_device *dev);
 void sysfs_del_meshif(struct net_device *dev);
+int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev);
+void sysfs_del_hardif(struct kobject **hardif_obj);
diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index a3e066a..f011430 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -268,7 +268,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	if (!batman_if)
 		goto dst_unreach;
 
-	if (batman_if->if_active != IF_ACTIVE)
+	if (batman_if->if_status != IF_ACTIVE)
 		goto dst_unreach;
 
 	memcpy(icmp_packet.orig, batman_if->net_dev->dev_addr, ETH_ALEN);
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index 29a4783..0e619dd 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -337,12 +337,13 @@ static int _write_buffer_text(unsigned char *buff, int bytes_written,
 int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 			       size_t count, loff_t off)
 {
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct gw_node *gw_node;
 	size_t hdr_len, tmp_len;
 	int bytes_written = 0, gw_count = 0;
 
 	rcu_read_lock();
-	if (list_empty(&if_list)) {
+	if (!bat_priv->primary_if) {
 		rcu_read_unlock();
 
 		if (off == 0)
@@ -353,7 +354,7 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 		return 0;
 	}
 
-	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
+	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
 		rcu_read_unlock();
 
 		if (off == 0)
@@ -368,8 +369,8 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 			  "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
 			  "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
 			  "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
-			  ((struct batman_if *)if_list.next)->dev,
-			  ((struct batman_if *)if_list.next)->addr_str,
+			  bat_priv->primary_if->dev,
+			  bat_priv->primary_if->addr_str,
 			  net_dev->name);
 	rcu_read_unlock();
 
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index 0eb861b..64307fc 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -25,23 +25,22 @@
 #include "send.h"
 #include "translation-table.h"
 #include "routing.h"
+#include "bat_sysfs.h"
+#include "originator.h"
 #include "hash.h"
 #include "compat.h"
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
-static char avail_ifs;
-static char active_ifs;
+#include <linux/if_arp.h>
 
-static void hardif_free_interface(struct rcu_head *rcu);
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
 
-static struct batman_if *get_batman_if_by_name(char *name)
+struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (strncmp(batman_if->dev, name, IFNAMSIZ) == 0)
+		if (batman_if->net_dev == net_dev)
 			goto out;
 	}
 
@@ -52,23 +51,90 @@ out:
 	return batman_if;
 }
 
-int hardif_min_mtu(void)
+static int is_valid_iface(struct net_device *net_dev)
+{
+	if (net_dev->flags & IFF_LOOPBACK)
+		return 0;
+
+	if (net_dev->type != ARPHRD_ETHER)
+		return 0;
+
+	if (net_dev->addr_len != ETH_ALEN)
+		return 0;
+
+	/* no batman over batman */
+#ifdef HAVE_NET_DEVICE_OPS
+	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
+		return 0;
+#else
+	if (net_dev->hard_start_xmit == interface_tx)
+		return 0;
+#endif
+
+	/* Device is being bridged */
+	/* if (net_dev->br_port != NULL)
+		return 0; */
+
+	return 1;
+}
+
+static struct batman_if *get_active_batman_if(void)
 {
 	struct batman_if *batman_if;
-	/* allow big frames if all devices are capable to do so
-	 * (have MTU > 1500 + BAT_HEADER_LEN) */
-	int min_mtu = ETH_DATA_LEN;
 
+	/* TODO: should check interfaces belonging to bat_priv */
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if ((batman_if->if_active == IF_ACTIVE) ||
-		    (batman_if->if_active == IF_TO_BE_ACTIVATED))
-			min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
-				      min_mtu);
+		if (batman_if->if_status == IF_ACTIVE)
+			goto out;
 	}
+
+	batman_if = NULL;
+
+out:
 	rcu_read_unlock();
+	return batman_if;
+}
 
-	return min_mtu;
+static void set_primary_if(struct bat_priv *bat_priv,
+			   struct batman_if *batman_if)
+{
+	struct batman_packet *batman_packet;
+
+	bat_priv->primary_if = batman_if;
+
+	if (!bat_priv->primary_if)
+		return;
+
+	set_main_if_addr(batman_if->net_dev->dev_addr);
+
+	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
+	batman_packet->flags = PRIMARIES_FIRST_HOP;
+	batman_packet->ttl = TTL;
+
+	/***
+	 * hacky trick to make sure that we send the HNA information via
+	 * our new primary interface
+	 */
+	atomic_set(&hna_local_changed, 1);
+}
+
+static bool hardif_is_iface_up(struct batman_if *batman_if)
+{
+	if (batman_if->net_dev->flags & IFF_UP)
+		return true;
+
+	return false;
+}
+
+static void update_mac_addresses(struct batman_if *batman_if)
+{
+	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
+
+	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
+	       batman_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(((struct batman_packet *)(batman_if->packet_buff))->prev_sender,
+	       batman_if->net_dev->dev_addr, ETH_ALEN);
 }
 
 static void check_known_mac_addr(uint8_t *addr)
@@ -77,8 +143,8 @@ static void check_known_mac_addr(uint8_t *addr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if ((batman_if->if_active != IF_ACTIVE) &&
-		    (batman_if->if_active != IF_TO_BE_ACTIVATED))
+		if ((batman_if->if_status != IF_ACTIVE) &&
+		    (batman_if->if_status != IF_TO_BE_ACTIVATED))
 			continue;
 
 		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
@@ -91,6 +157,25 @@ static void check_known_mac_addr(uint8_t *addr)
 	rcu_read_unlock();
 }
 
+int hardif_min_mtu(void)
+{
+	struct batman_if *batman_if;
+	/* allow big frames if all devices are capable to do so
+	 * (have MTU > 1500 + BAT_HEADER_LEN) */
+	int min_mtu = ETH_DATA_LEN;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if ((batman_if->if_status == IF_ACTIVE) ||
+		    (batman_if->if_status == IF_TO_BE_ACTIVATED))
+			min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
+				      min_mtu);
+	}
+	rcu_read_unlock();
+
+	return min_mtu;
+}
+
 /* adjusts the MTU if a new interface with a smaller MTU appeared. */
 void update_min_mtu(void)
 {
@@ -101,322 +186,246 @@ void update_min_mtu(void)
 		soft_device->mtu = min_mtu;
 }
 
-/* checks if the interface is up. (returns 1 if it is) */
-static int hardif_is_interface_up(char *dev)
+static void hardif_activate_interface(struct bat_priv *bat_priv,
+				      struct batman_if *batman_if)
 {
-	struct net_device *net_dev;
+	if (batman_if->if_status != IF_INACTIVE)
+		return;
 
-	/**
-	 * if we already have an interface in our interface list and
-	 * the current interface is not the primary interface and
-	 * the primary interface is not up and
-	 * the primary interface has never been up - don't activate any
-	 * secondary interface !
-	 */
+	dev_hold(batman_if->net_dev);
 
-	rcu_read_lock();
-	if ((!list_empty(&if_list)) &&
-	    strncmp(((struct batman_if *)if_list.next)->dev, dev, IFNAMSIZ) &&
-	    !(((struct batman_if *)if_list.next)->if_active == IF_ACTIVE) &&
-	    !(((struct batman_if *)if_list.next)->if_active == IF_TO_BE_ACTIVATED) &&
-	    (!main_if_was_up())) {
-		rcu_read_unlock();
-		goto end;
-	}
-	rcu_read_unlock();
+	update_mac_addresses(batman_if);
+	batman_if->if_status = IF_TO_BE_ACTIVATED;
 
-#ifdef __NET_NET_NAMESPACE_H
-	net_dev = dev_get_by_name(&init_net, dev);
-#else
-	net_dev = dev_get_by_name(dev);
-#endif
-	if (!net_dev)
-		goto end;
+	/**
+	 * the first active interface becomes our primary interface or
+	 * the next active interface after the old primay interface was removed
+	 */
+	if (!bat_priv->primary_if)
+		set_primary_if(bat_priv, batman_if);
 
-	if (!(net_dev->flags & IFF_UP))
-		goto failure;
+	printk(KERN_INFO "batman-adv:Interface activated: %s\n",
+	       batman_if->dev);
 
-	dev_put(net_dev);
-	return 1;
+	if (atomic_read(&module_state) == MODULE_INACTIVE)
+		activate_module();
 
-failure:
-	dev_put(net_dev);
-end:
-	return 0;
+	update_min_mtu();
+	return;
 }
 
-/* deactivates the interface. */
-void hardif_deactivate_interface(struct batman_if *batman_if)
+static void hardif_deactivate_interface(struct batman_if *batman_if)
 {
-	if (batman_if->if_active != IF_ACTIVE)
+	if ((batman_if->if_status != IF_ACTIVE) &&
+	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
 		return;
 
-	/**
-	 * batman_if->net_dev has been acquired by dev_get_by_name() in
-	 * proc_interfaces_write() and has to be unreferenced.
-	 */
-
-	if (batman_if->net_dev)
-		dev_put(batman_if->net_dev);
+	dev_put(batman_if->net_dev);
 
-	batman_if->if_active = IF_INACTIVE;
-	active_ifs--;
+	batman_if->if_status = IF_INACTIVE;
 
 	printk(KERN_INFO "batman-adv:Interface deactivated: %s\n",
-		  batman_if->dev);
+	       batman_if->dev);
+
+	update_min_mtu();
 }
 
-/* (re)activate given interface. */
-static void hardif_activate_interface(struct batman_if *batman_if)
+int hardif_enable_interface(struct batman_if *batman_if)
 {
-	if (batman_if->if_active != IF_INACTIVE)
-		return;
-
-#ifdef __NET_NET_NAMESPACE_H
-	batman_if->net_dev = dev_get_by_name(&init_net, batman_if->dev);
-#else
-	batman_if->net_dev = dev_get_by_name(batman_if->dev);
-#endif
-	if (!batman_if->net_dev)
-		goto dev_err;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct batman_packet *batman_packet;
 
-	check_known_mac_addr(batman_if->net_dev->dev_addr);
+	if (batman_if->if_status != IF_NOT_IN_USE)
+		goto out;
 
-	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
+	batman_if->packet_len = BAT_PACKET_LEN;
+	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
-	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
-	       batman_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(((struct batman_packet *)(batman_if->packet_buff))->prev_sender,
-	       batman_if->net_dev->dev_addr, ETH_ALEN);
+	if (!batman_if->packet_buff) {
+		printk(KERN_ERR "batman-adv:Can't add interface packet (%s): out of memory\n",
+		       batman_if->dev);
+		goto err;
+	}
 
-	batman_if->if_active = IF_TO_BE_ACTIVATED;
-	active_ifs++;
+	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
+	batman_packet->packet_type = BAT_PACKET;
+	batman_packet->version = COMPAT_VERSION;
+	batman_packet->flags = 0;
+	batman_packet->ttl = 2;
+	batman_packet->tq = TQ_MAX_VALUE;
+	batman_packet->num_hna = 0;
 
-	/* save the mac address if it is our primary interface */
-	if (batman_if->if_num == 0)
-		set_main_if_addr(batman_if->net_dev->dev_addr);
+	batman_if->if_num = bat_priv->num_ifaces;
+	bat_priv->num_ifaces++;
+	batman_if->if_status = IF_INACTIVE;
+	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
-	printk(KERN_INFO "batman-adv:Interface activated: %s\n",
-		  batman_if->dev);
+	atomic_set(&batman_if->seqno, 1);
+	printk(KERN_INFO "batman-adv:Adding interface: %s\n", batman_if->dev);
 
-	return;
+	if (hardif_is_iface_up(batman_if))
+		hardif_activate_interface(bat_priv, batman_if);
+	else
+		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): interface not active\n", batman_if->dev);
 
-dev_err:
-	batman_if->net_dev = NULL;
-}
+	/* begin scheduling originator messages on that interface */
+	schedule_own_packet(batman_if);
 
-static void hardif_free_interface(struct rcu_head *rcu)
-{
-	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
+out:
+	return 0;
 
-	kfree(batman_if->packet_buff);
-	kfree(batman_if->dev);
-	kfree(batman_if);
+err:
+	return -ENOMEM;
 }
 
-/**
- * called by
- *  - echo '' > /proc/.../interfaces
- *  - modprobe -r batman-adv-core
- */
-/* removes and frees all interfaces */
-void hardif_remove_interfaces(void)
+void hardif_disable_interface(struct batman_if *batman_if)
 {
-	struct batman_if *batman_if = NULL;
-
-	avail_ifs = 0;
-
-	/* no lock needed - we don't delete somewhere else */
-	list_for_each_entry(batman_if, &if_list, list) {
-
-		list_del_rcu(&batman_if->list);
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
-		/* first deactivate interface */
-		if (batman_if->if_active != IF_INACTIVE)
-			hardif_deactivate_interface(batman_if);
-
-		call_rcu(&batman_if->rcu, hardif_free_interface);
-	}
-}
-
-static int resize_orig(struct orig_node *orig_node, int if_num)
-{
-	void *data_ptr;
+	if (batman_if->if_status == IF_ACTIVE)
+		hardif_deactivate_interface(batman_if);
 
-	data_ptr = kmalloc((if_num + 1) * sizeof(TYPE_OF_WORD) * NUM_WORDS,
-			   GFP_ATOMIC);
-	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
-		return -1;
-	}
+	if (batman_if->if_status != IF_INACTIVE)
+		return;
 
-	memcpy(data_ptr, orig_node->bcast_own,
-	       if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS);
-	kfree(orig_node->bcast_own);
-	orig_node->bcast_own = data_ptr;
+	printk(KERN_INFO "batman-adv:Removing interface: %s\n", batman_if->dev);
+	bat_priv->num_ifaces--;
+	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
-	data_ptr = kmalloc((if_num + 1) * sizeof(uint8_t), GFP_ATOMIC);
-	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
-		return -1;
-	}
+	if (batman_if == bat_priv->primary_if)
+		set_primary_if(bat_priv, get_active_batman_if());
 
-	memcpy(data_ptr, orig_node->bcast_own_sum, if_num * sizeof(uint8_t));
-	kfree(orig_node->bcast_own_sum);
-	orig_node->bcast_own_sum = data_ptr;
+	kfree(batman_if->packet_buff);
+	batman_if->packet_buff = NULL;
+	batman_if->if_status = IF_NOT_IN_USE;
 
-	return 0;
+	if ((atomic_read(&module_state) == MODULE_ACTIVE) &&
+	    (bat_priv->num_ifaces == 0))
+		deactivate_module();
 }
 
-
-/* adds an interface the interface list and activate it, if possible */
-int hardif_add_interface(char *dev, int if_num)
+static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
-	struct batman_packet *batman_packet;
-	struct orig_node *orig_node;
-	unsigned long flags;
-	HASHIT(hashit);
+	int ret;
 
-	batman_if = kmalloc(sizeof(struct batman_if), GFP_KERNEL);
+	ret = is_valid_iface(net_dev);
+	if (ret != 1)
+		goto out;
 
+	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:Can't add interface (%s): out of memory\n", dev);
-		return -1;
-	}
-
-	batman_if->net_dev = NULL;
-
-	if ((if_num == 0) && (num_hna > 0))
-		batman_if->packet_len = BAT_PACKET_LEN + num_hna * ETH_ALEN;
-	else
-		batman_if->packet_len = BAT_PACKET_LEN;
-
-	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_KERNEL);
-
-	if (!batman_if->packet_buff) {
-		printk(KERN_ERR "batman-adv:Can't add interface packet (%s): out of memory\n", dev);
+		printk(KERN_ERR "batman-adv:Can't add interface (%s): out of memory\n",
+		       net_dev->name);
 		goto out;
 	}
 
-	batman_if->if_num = if_num;
-	batman_if->dev = dev;
-	batman_if->if_active = IF_INACTIVE;
-	INIT_RCU_HEAD(&batman_if->rcu);
+	batman_if->dev = kstrdup(net_dev->name, GFP_ATOMIC);
+	if (!batman_if->dev)
+		goto free_if;
 
-	printk(KERN_INFO "batman-adv:Adding interface: %s\n", dev);
-	avail_ifs++;
+	ret = sysfs_add_hardif(&batman_if->hardif_obj, net_dev);
+	if (ret)
+		goto free_dev;
 
+	batman_if->if_num = -1;
+	batman_if->net_dev = net_dev;
+	batman_if->if_status = IF_NOT_IN_USE;
+	INIT_RCU_HEAD(&batman_if->rcu);
 	INIT_LIST_HEAD(&batman_if->list);
 
-	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
-	batman_packet->packet_type = BAT_PACKET;
-	batman_packet->version = COMPAT_VERSION;
-	batman_packet->flags = batman_if->if_num > 0 ?
-			0x00 : PRIMARIES_FIRST_HOP;
-	batman_packet->ttl = batman_if->if_num > 0 ? 2 : TTL;
-	batman_packet->tq = TQ_MAX_VALUE;
-	batman_packet->num_hna = 0;
-
-	if (batman_if->packet_len != BAT_PACKET_LEN) {
-		unsigned char *hna_buff;
-		int hna_len;
-
-		hna_buff = batman_if->packet_buff + BAT_PACKET_LEN;
-		hna_len = batman_if->packet_len - BAT_PACKET_LEN;
-		batman_packet->num_hna = hna_local_fill_buffer(hna_buff,
-							       hna_len);
-	}
-
-	atomic_set(&batman_if->seqno, 1);
+	check_known_mac_addr(batman_if->net_dev->dev_addr);
+	list_add_tail_rcu(&batman_if->list, &if_list);
+	return batman_if;
 
-	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
-	 * if_num */
-	spin_lock_irqsave(&orig_hash_lock, flags);
+free_dev:
+	kfree(batman_if->dev);
+free_if:
+	kfree(batman_if);
+out:
+	return NULL;
+}
 
-	while (hash_iterate(orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
-		if (resize_orig(orig_node, if_num) == -1) {
-			spin_unlock_irqrestore(&orig_hash_lock, flags);
-			goto out;
-		}
-	}
+static void hardif_free_interface(struct rcu_head *rcu)
+{
+	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	/* delete all references to this batman_if */
+	purge_orig(NULL);
+	purge_outstanding_packets(batman_if);
 
-	if (!hardif_is_interface_up(batman_if->dev))
-		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): interface not active\n", batman_if->dev);
-	else
-		hardif_activate_interface(batman_if);
+	kfree(batman_if->dev);
+	kfree(batman_if);
+}
 
-	list_add_tail_rcu(&batman_if->list, &if_list);
+static void hardif_remove_interface(struct batman_if *batman_if)
+{
+	/* first deactivate interface */
+	if (batman_if->if_status != IF_NOT_IN_USE)
+		hardif_disable_interface(batman_if);
 
-	/* begin sending originator messages on that interface */
-	schedule_own_packet(batman_if);
-	return 1;
+	if (batman_if->if_status != IF_NOT_IN_USE)
+		return;
 
-out:
-	kfree(batman_if->packet_buff);
-	kfree(batman_if);
-	kfree(dev);
-	return -1;
+	batman_if->if_status = IF_TO_BE_REMOVED;
+	list_del_rcu(&batman_if->list);
+	sysfs_del_hardif(&batman_if->hardif_obj);
+	call_rcu(&batman_if->rcu, hardif_free_interface);
 }
 
-char hardif_get_active_if_num(void)
+void hardif_remove_interfaces(void)
 {
-	return active_ifs;
+	struct batman_if *batman_if, *batman_if_tmp;
+
+	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list)
+		hardif_remove_interface(batman_if);
 }
 
 static int hard_if_event(struct notifier_block *this,
-			    unsigned long event, void *ptr)
+			 unsigned long event, void *ptr)
 {
-	struct net_device *dev = (struct net_device *)ptr;
-	struct batman_if *batman_if = get_batman_if_by_name(dev->name);
+	struct net_device *net_dev = (struct net_device *)ptr;
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+
+	if (!batman_if)
+		batman_if = hardif_add_interface(net_dev);
 
 	if (!batman_if)
 		goto out;
 
 	switch (event) {
+	case NETDEV_REGISTER:
+		break;
+	case NETDEV_UP:
+		hardif_activate_interface(bat_priv, batman_if);
+		break;
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
-	case NETDEV_UNREGISTER:
 		hardif_deactivate_interface(batman_if);
 		break;
-	case NETDEV_UP:
-		hardif_activate_interface(batman_if);
-		if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
-		    (hardif_get_active_if_num() > 0)) {
-			activate_module();
-		}
+	case NETDEV_UNREGISTER:
+		hardif_remove_interface(batman_if);
+		break;
+	case NETDEV_CHANGENAME:
+		break;
+	case NETDEV_CHANGEADDR:
+		check_known_mac_addr(batman_if->net_dev->dev_addr);
+		update_mac_addresses(batman_if);
+		if (batman_if == bat_priv->primary_if)
+			set_primary_if(bat_priv, batman_if);
 		break;
-	/* NETDEV_CHANGEADDR - mac address change - what are we doing here ? */
 	default:
 		break;
 	};
 
-	update_min_mtu();
-
 out:
 	return NOTIFY_DONE;
 }
 
-/* find batman interface by netdev. assumes rcu_read_lock on */
-static struct batman_if *find_batman_if(struct net_device *dev)
-{
-	struct batman_if *batman_if;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (batman_if->net_dev == dev) {
-			rcu_read_unlock();
-			return batman_if;
-		}
-	}
-	rcu_read_unlock();
-	return NULL;
-}
-
-
 /* receive a packet with the batman ethertype coming on a hard
  * interface */
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
@@ -445,12 +454,12 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 				|| !skb_mac_header(skb)))
 		goto err_free;
 
-	batman_if = find_batman_if(skb->dev);
+	batman_if = get_batman_if_by_netdev(skb->dev);
 	if (!batman_if)
 		goto err_free;
 
 	/* discard frames on not active interfaces */
-	if (batman_if->if_active != IF_ACTIVE)
+	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
 	stats = (struct net_device_stats *)dev_get_stats(skb->dev);
diff --git a/batman-adv-kernelland/hard-interface.h b/batman-adv-kernelland/hard-interface.h
index 4100a27..1e5fc3e 100644
--- a/batman-adv-kernelland/hard-interface.h
+++ b/batman-adv-kernelland/hard-interface.h
@@ -19,19 +19,19 @@
  *
  */
 
-#define IF_INACTIVE 0
-#define IF_ACTIVE 1
-/* #define IF_TO_BE_DEACTIVATED 2 - not needed anymore */
-#define IF_TO_BE_ACTIVATED 3
+#define IF_NOT_IN_USE 0
+#define IF_TO_BE_REMOVED 1
+#define IF_INACTIVE 2
+#define IF_ACTIVE 3
+#define IF_TO_BE_ACTIVATED 4
+#define IF_I_WANT_YOU 5
 
 extern struct notifier_block hard_if_notifier;
 
+struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev);
+int hardif_enable_interface(struct batman_if *batman_if);
+void hardif_disable_interface(struct batman_if *batman_if);
 void hardif_remove_interfaces(void);
-int hardif_add_interface(char *dev, int if_num);
-void hardif_deactivate_interface(struct batman_if *batman_if);
-char hardif_get_active_if_num(void);
-void hardif_check_interfaces_status(void);
-void hardif_check_interfaces_status_wq(struct work_struct *work);
 int batman_skb_recv(struct sk_buff *skb,
 				struct net_device *dev,
 				struct packet_type *ptype,
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index b276e86..b98fd83 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -20,7 +20,6 @@
  */
 
 #include "main.h"
-#include "proc.h"
 #include "bat_sysfs.h"
 #include "routing.h"
 #include "send.h"
@@ -46,7 +45,6 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 atomic_t vis_interval;
 int16_t num_hna;
-int16_t num_ifs;
 
 struct net_device *soft_device;
 
@@ -91,10 +89,6 @@ int init_module(void)
 	if (!bat_event_workqueue)
 		return -ENOMEM;
 
-	retval = setup_procfs();
-	if (retval < 0)
-		return retval;
-
 	bat_device_init();
 
 	/* initialize layer 2 interface */
@@ -137,7 +131,10 @@ end:
 
 void cleanup_module(void)
 {
-	shutdown_module();
+	deactivate_module();
+
+	unregister_netdevice_notifier(&hard_if_notifier);
+	hardif_remove_interfaces();
 
 	if (soft_device) {
 		sysfs_del_meshif(soft_device);
@@ -147,9 +144,6 @@ void cleanup_module(void)
 
 	dev_remove_pack(&batman_adv_packet_type);
 
-	unregister_netdevice_notifier(&hard_if_notifier);
-	cleanup_procfs();
-
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
 }
@@ -180,17 +174,17 @@ void activate_module(void)
 
 err:
 	printk(KERN_ERR "batman-adv:Unable to allocate memory for mesh information structures: out of mem ?\n");
-	shutdown_module();
+	deactivate_module();
 end:
 	return;
 }
 
 /* shuts down the whole module.*/
-void shutdown_module(void)
+void deactivate_module(void)
 {
 	atomic_set(&module_state, MODULE_DEACTIVATING);
 
-	purge_outstanding_packets();
+	purge_outstanding_packets(NULL);
 	flush_workqueue(bat_event_workqueue);
 
 	vis_quit();
@@ -206,7 +200,6 @@ void shutdown_module(void)
 	synchronize_net();
 	bat_device_destroy();
 
-	hardif_remove_interfaces();
 	synchronize_rcu();
 	atomic_set(&module_state, MODULE_INACTIVE);
 }
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index ddb0d6c..5dcbf03 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -133,7 +133,6 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern atomic_t vis_interval;
 extern int16_t num_hna;
-extern int16_t num_ifs;
 
 extern struct net_device *soft_device;
 
@@ -142,7 +141,7 @@ extern atomic_t module_state;
 extern struct workqueue_struct *bat_event_workqueue;
 
 void activate_module(void);
-void shutdown_module(void);
+void deactivate_module(void);
 void inc_module_count(void);
 void dec_module_count(void);
 int addr_to_string(char *buff, uint8_t *addr);
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index dbc7cbf..d04bac4 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -120,6 +120,8 @@ void free_orig_node(void *data)
  * address if it does not exits */
 struct orig_node *get_orig_node(uint8_t *addr)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
 	int size;
@@ -141,13 +143,13 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
 
-	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
+	size = bat_priv->num_ifaces * sizeof(TYPE_OF_WORD) * NUM_WORDS;
 
 	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
 	if (!orig_node->bcast_own)
 		goto free_orig_node;
 
-	size = num_ifs * sizeof(uint8_t);
+	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
@@ -184,16 +186,25 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
 	*best_neigh_node = NULL;
 
-
 	/* for all neighbors towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
 
-		if (time_after(jiffies,
+		if ((time_after(jiffies,
 			       (neigh_node->last_valid +
-				((PURGE_TIMEOUT * HZ) / 1000)))) {
-
-			bat_dbg(DBG_BATMAN, "neighbor timeout: originator %pM, neighbor: %pM, last_valid %lu\n", orig_node->orig, neigh_node->addr, (neigh_node->last_valid / HZ));
+				((PURGE_TIMEOUT * HZ) / 1000)))) ||
+		    (neigh_node->if_incoming->if_status ==
+						IF_TO_BE_REMOVED)) {
+
+			if (neigh_node->if_incoming->if_status ==
+							IF_TO_BE_REMOVED)
+				bat_dbg(DBG_BATMAN, "neighbor purge: originator %pM, neighbor: %pM, iface: %s\n",
+					orig_node->orig, neigh_node->addr,
+					neigh_node->if_incoming->dev);
+			else
+				bat_dbg(DBG_BATMAN, "neighbor timeout: originator %pM, neighbor: %pM, last_valid: %lu\n",
+					orig_node->orig, neigh_node->addr,
+					(neigh_node->last_valid / HZ));
 
 			neigh_purged = true;
 			list_del(list_pos);
@@ -257,13 +268,18 @@ void purge_orig(struct work_struct *work)
 
 	gw_node_purge_deleted();
 	gw_election();
-	start_purge_timer();
+
+	/* if work == NULL we were not called by the timer
+	 * and thus do not need to re-arm the timer */
+	if (work)
+		start_purge_timer();
 }
 
 ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 			      size_t count, loff_t off)
 {
 	HASHIT(hashit);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	size_t hdr_len, tmp_len;
@@ -271,10 +287,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 	unsigned long flags;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
+	if (!bat_priv->primary_if) {
 		if (off == 0)
 			return sprintf(buff,
 				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
@@ -283,9 +296,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 		return 0;
 	}
 
-	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
-		rcu_read_unlock();
-
+	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
 		if (off == 0)
 			return sprintf(buff,
 				       "BATMAN mesh %s disabled - primary interface not active\n",
@@ -294,12 +305,12 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 		return 0;
 	}
 
+	rcu_read_lock();
 	hdr_len = sprintf(buff,
 		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
-		   ((struct batman_if *)if_list.next)->dev,
-		   ((struct batman_if *)if_list.next)->addr_str,
+		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
 		   net_dev->name);
 	rcu_read_unlock();
 
@@ -357,3 +368,153 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	return bytes_written;
 }
+
+static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
+{
+	void *data_ptr;
+
+	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
+			   GFP_ATOMIC);
+	if (!data_ptr) {
+		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		return -1;
+	}
+
+	memcpy(data_ptr, orig_node->bcast_own,
+	       (max_if_num - 1) * sizeof(TYPE_OF_WORD) * NUM_WORDS);
+	kfree(orig_node->bcast_own);
+	orig_node->bcast_own = data_ptr;
+
+	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
+	if (!data_ptr) {
+		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		return -1;
+	}
+
+	memcpy(data_ptr, orig_node->bcast_own_sum,
+	       (max_if_num - 1) * sizeof(uint8_t));
+	kfree(orig_node->bcast_own_sum);
+	orig_node->bcast_own_sum = data_ptr;
+
+	return 0;
+}
+
+int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
+{
+	struct orig_node *orig_node;
+	HASHIT(hashit);
+
+	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
+	 * if_num */
+	spin_lock(&orig_hash_lock);
+
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
+
+		if (orig_node_add_if(orig_node, max_if_num) == -1)
+			goto err;
+	}
+
+	spin_unlock(&orig_hash_lock);
+	return 0;
+
+err:
+	spin_unlock(&orig_hash_lock);
+	return -ENOMEM;
+}
+
+static int orig_node_del_if(struct orig_node *orig_node,
+		     int max_if_num, int del_if_num)
+{
+	void *data_ptr = NULL;
+	int chunk_size;
+
+	/* last interface was removed */
+	if (max_if_num == 0)
+		goto free_bcast_own;
+
+	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
+	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
+	if (!data_ptr) {
+		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		return -1;
+	}
+
+	/* copy first part */
+	memcpy(data_ptr, orig_node->bcast_own, del_if_num * chunk_size);
+
+	/* copy second part */
+	memcpy(data_ptr,
+	       orig_node->bcast_own + ((del_if_num + 1) * chunk_size),
+	       (max_if_num - del_if_num) * chunk_size);
+
+free_bcast_own:
+	kfree(orig_node->bcast_own);
+	orig_node->bcast_own = data_ptr;
+
+	if (max_if_num == 0)
+		goto free_own_sum;
+
+	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
+	if (!data_ptr) {
+		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		return -1;
+	}
+
+	memcpy(data_ptr, orig_node->bcast_own_sum,
+	       del_if_num * sizeof(uint8_t));
+
+	memcpy(data_ptr,
+	       orig_node->bcast_own_sum + ((del_if_num + 1) * sizeof(uint8_t)),
+	       (max_if_num - del_if_num) * sizeof(uint8_t));
+
+free_own_sum:
+	kfree(orig_node->bcast_own_sum);
+	orig_node->bcast_own_sum = data_ptr;
+
+	return 0;
+}
+
+int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
+{
+	struct batman_if *batman_if_tmp;
+	struct orig_node *orig_node;
+	HASHIT(hashit);
+	int ret;
+
+	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
+	 * if_num */
+	spin_lock(&orig_hash_lock);
+
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
+
+		ret = orig_node_del_if(orig_node, max_if_num,
+				       batman_if->if_num);
+
+		if (ret == -1)
+			goto err;
+	}
+
+	/* renumber remaining batman interfaces _inside_ of orig_hash_lock */
+	rcu_read_lock();
+	list_for_each_entry_rcu(batman_if_tmp, &if_list, list) {
+		if (batman_if_tmp->if_status == IF_NOT_IN_USE)
+			continue;
+
+		if (batman_if == batman_if_tmp)
+			continue;
+
+		if (batman_if_tmp->if_num > batman_if->if_num)
+			batman_if_tmp->if_num--;
+	}
+	rcu_read_unlock();
+
+	batman_if->if_num = -1;
+	spin_unlock(&orig_hash_lock);
+	return 0;
+
+err:
+	spin_unlock(&orig_hash_lock);
+	return -ENOMEM;
+}
diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/originator.h
index 745b4b0..afbc7c0 100644
--- a/batman-adv-kernelland/originator.h
+++ b/batman-adv-kernelland/originator.h
@@ -30,3 +30,5 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
 ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 			      size_t count, loff_t off);
+int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
+int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
deleted file mode 100644
index a8a1a67..0000000
--- a/batman-adv-kernelland/proc.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#include "main.h"
-#include "proc.h"
-#include "routing.h"
-#include "translation-table.h"
-#include "hard-interface.h"
-#include "types.h"
-#include "hash.h"
-#include "vis.h"
-#include "compat.h"
-#include "gateway_common.h"
-#include "gateway_client.h"
-
-static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
-
-static int proc_interfaces_read(struct seq_file *seq, void *offset)
-{
-	struct batman_if *batman_if;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		seq_printf(seq, "[%8s] %s %s \n",
-			   (batman_if->if_active == IF_ACTIVE ?
-			    "active" : "inactive"),
-			   batman_if->dev,
-			   (batman_if->if_active == IF_ACTIVE ?
-			    batman_if->addr_str : " "));
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int proc_interfaces_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_interfaces_read, NULL);
-}
-
-static ssize_t proc_interfaces_write(struct file *instance,
-				     const char __user *userbuffer,
-				     size_t count, loff_t *data)
-{
-	char *if_string, *colon_ptr = NULL, *cr_ptr = NULL;
-	int not_copied = 0, if_num = 0, add_success;
-	struct batman_if *batman_if = NULL;
-
-	if_string = kmalloc(count, GFP_KERNEL);
-
-	if (!if_string)
-		return -ENOMEM;
-
-	if (count > IFNAMSIZ - 1) {
-		printk(KERN_WARNING "batman-adv:Can't add interface: device name is too long\n");
-		goto end;
-	}
-
-	not_copied = copy_from_user(if_string, userbuffer, count);
-	if_string[count - not_copied - 1] = 0;
-
-	colon_ptr = strchr(if_string, ':');
-	if (colon_ptr)
-		*colon_ptr = 0;
-
-	if (!colon_ptr) {
-		cr_ptr = strchr(if_string, '\n');
-		if (cr_ptr)
-			*cr_ptr = 0;
-	}
-
-	if (strlen(if_string) == 0) {
-		shutdown_module();
-		num_ifs = 0;
-		goto end;
-	}
-
-	/* add interface */
-	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (strncmp(batman_if->dev, if_string, count) == 0) {
-			printk(KERN_ERR "batman-adv:Given interface is already active: %s\n", if_string);
-			rcu_read_unlock();
-			goto end;
-
-		}
-
-		if_num++;
-	}
-	rcu_read_unlock();
-
-	add_success = hardif_add_interface(if_string, if_num);
-	if (add_success < 0)
-		goto end;
-
-	num_ifs = if_num + 1;
-
-	if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
-	    (hardif_get_active_if_num() > 0))
-		activate_module();
-
-	return count;
-end:
-	kfree(if_string);
-	return count;
-}
-
-static const struct file_operations proc_interfaces_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_interfaces_open,
-	.read		= seq_read,
-	.write		= proc_interfaces_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-void cleanup_procfs(void)
-{
-	if (proc_interface_file)
-		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
-
-	if (proc_batman_dir)
-#ifdef __NET_NET_NAMESPACE_H
-		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
-#else
-		remove_proc_entry(PROC_ROOT_DIR, proc_net);
-#endif
-}
-
-int setup_procfs(void)
-{
-#ifdef __NET_NET_NAMESPACE_H
-	proc_batman_dir = proc_mkdir(PROC_ROOT_DIR, init_net.proc_net);
-#else
-	proc_batman_dir = proc_mkdir(PROC_ROOT_DIR, proc_net);
-#endif
-
-	if (!proc_batman_dir) {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s' folder failed\n", PROC_ROOT_DIR);
-		return -EFAULT;
-	}
-
-	proc_interface_file = create_proc_entry(PROC_FILE_INTERFACES,
-						S_IWUSR | S_IRUGO,
-						proc_batman_dir);
-	if (proc_interface_file) {
-		proc_interface_file->proc_fops = &proc_interfaces_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	return 0;
-}
diff --git a/batman-adv-kernelland/proc.h b/batman-adv-kernelland/proc.h
deleted file mode 100644
index 6f4f5b3..0000000
--- a/batman-adv-kernelland/proc.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-
-#define PROC_ROOT_DIR "batman-adv"
-#define PROC_FILE_INTERFACES "interfaces"
-
-void cleanup_procfs(void);
-int setup_procfs(void);
-
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 3168215..dbe27ad 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -207,7 +207,7 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 	batman_packet->tq = ((batman_packet->tq *
 			      orig_neigh_node->tq_own *
 			      orig_neigh_node->tq_asym_penalty) /
-			     (TQ_MAX_VALUE *	 TQ_MAX_VALUE));
+			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
 
 	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
 		orig_node->orig, orig_neigh_node->orig, total_count,
@@ -514,7 +514,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		batman_packet->version, has_directlink_flag);
 
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (batman_if->if_active != IF_ACTIVE)
+		if (batman_if->if_status != IF_ACTIVE)
 			continue;
 
 		if (compare_orig(ethhdr->h_source,
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index b5a96f5..684bf1d 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -60,7 +60,7 @@ int send_skb_packet(struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 
-	if (batman_if->if_active != IF_ACTIVE)
+	if (batman_if->if_status != IF_ACTIVE)
 		goto send_skb_err;
 
 	if (unlikely(!batman_if->net_dev))
@@ -126,7 +126,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	int16_t buff_pos;
 	struct batman_packet *batman_packet;
 
-	if (batman_if->if_active != IF_ACTIVE)
+	if (batman_if->if_status != IF_ACTIVE)
 		return;
 
 	packet_num = buff_pos = 0;
@@ -184,7 +184,7 @@ static void send_packet(struct forw_packet *forw_packet)
 		return;
 	}
 
-	if (forw_packet->if_incoming->if_active != IF_ACTIVE)
+	if (forw_packet->if_incoming->if_status != IF_ACTIVE)
 		return;
 
 	/* multihomed peer assumed */
@@ -245,7 +245,13 @@ void schedule_own_packet(struct batman_if *batman_if)
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
-	int vis_server = atomic_read(&bat_priv->vis_mode);
+	int vis_server;
+
+	if ((batman_if->if_status == IF_NOT_IN_USE) ||
+	    (batman_if->if_status == IF_TO_BE_REMOVED))
+		return;
+
+	vis_server = atomic_read(&bat_priv->vis_mode);
 
 	/**
 	 * the interface gets activated here to avoid race conditions between
@@ -254,11 +260,12 @@ void schedule_own_packet(struct batman_if *batman_if)
 	 * outdated packets (especially uninitialized mac addresses) in the
 	 * packet queue
 	 */
-	if (batman_if->if_active == IF_TO_BE_ACTIVATED)
-		batman_if->if_active = IF_ACTIVE;
+	if (batman_if->if_status == IF_TO_BE_ACTIVATED)
+		batman_if->if_status = IF_ACTIVE;
 
 	/* if local hna has changed and interface is a primary interface */
-	if ((atomic_read(&hna_local_changed)) && (batman_if->if_num == 0))
+	if ((atomic_read(&hna_local_changed)) &&
+	    (batman_if == bat_priv->primary_if))
 		rebuild_batman_packet(batman_if);
 
 	/**
@@ -366,6 +373,9 @@ static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
 	unsigned long flags;
 	INIT_HLIST_NODE(&forw_packet->list);
 
+	if (forw_packet->if_incoming->if_status == IF_TO_BE_REMOVED)
+		return;
+
 	/* add new packet to packet list */
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_add_head(&forw_packet->list, &forw_bcast_list);
@@ -433,7 +443,8 @@ void send_outstanding_bcast_packet(struct work_struct *work)
 	/* if we still have some more bcasts to send and we are not shutting
 	 * down */
 	if ((forw_packet->num_packets < 3) &&
-	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
+	    (atomic_read(&module_state) != MODULE_DEACTIVATING) &&
+	    (forw_packet->if_incoming->if_status != IF_TO_BE_REMOVED))
 		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
 	else
 		forw_packet_free(forw_packet);
@@ -465,19 +476,31 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	forw_packet_free(forw_packet);
 }
 
-void purge_outstanding_packets(void)
+void purge_outstanding_packets(struct batman_if *batman_if)
 {
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
 	unsigned long flags;
 
-	bat_dbg(DBG_BATMAN, "purge_outstanding_packets()\n");
+	if (batman_if)
+		bat_dbg(DBG_BATMAN, "purge_outstanding_packets(): %s\n",
+			batman_if->dev);
+	else
+		bat_dbg(DBG_BATMAN, "purge_outstanding_packets()\n");
 
 	/* free bcast list */
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
 				  &forw_bcast_list, list) {
 
+		/**
+		 * if purge_outstanding_packets() was called with an argmument
+		 * we delete only packets belonging to the given interface
+		 */
+		if ((batman_if) &&
+		    (forw_packet->if_incoming != batman_if))
+			continue;
+
 		spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
 
 		/**
@@ -494,6 +517,14 @@ void purge_outstanding_packets(void)
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
 				  &forw_bat_list, list) {
 
+		/**
+		 * if purge_outstanding_packets() was called with an argmument
+		 * we delete only packets belonging to the given interface
+		 */
+		if ((batman_if) &&
+		    (forw_packet->if_incoming != batman_if))
+			continue;
+
 		spin_unlock_irqrestore(&forw_bat_list_lock, flags);
 
 		/**
diff --git a/batman-adv-kernelland/send.h b/batman-adv-kernelland/send.h
index b2ddf63..b84a470 100644
--- a/batman-adv-kernelland/send.h
+++ b/batman-adv-kernelland/send.h
@@ -36,4 +36,4 @@ void schedule_forward_packet(struct orig_node *orig_node,
 void add_bcast_packet_to_list(struct sk_buff *skb);
 void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
-void purge_outstanding_packets(void);
+void purge_outstanding_packets(struct batman_if *batman_if);
diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index d2c7864..a36d3de 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -176,8 +176,6 @@ int interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-
-
 int interface_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct unicast_packet *unicast_packet;
@@ -263,7 +261,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-		if (batman_if->if_active != IF_ACTIVE)
+		if (batman_if->if_status != IF_ACTIVE)
 			goto dropped;
 
 		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index bab6d7e..d63f0b8 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -160,16 +160,14 @@ int hna_local_fill_buffer(unsigned char *buff, int buff_len)
 int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 			       size_t count, loff_t off)
 {
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	int bytes_written = 0;
 	unsigned long flags;
 	size_t hdr_len;
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
+	if (!bat_priv->primary_if) {
 		if (off == 0)
 			return sprintf(buff,
 				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
@@ -177,7 +175,6 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 		return 0;
 	}
-	rcu_read_unlock();
 
 	hdr_len = sprintf(buff,
 			  "Locally retrieved addresses (from %s) announced via HNA:\n",
@@ -377,16 +374,14 @@ void hna_global_add_orig(struct orig_node *orig_node,
 int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 				size_t count, loff_t off)
 {
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct hna_global_entry *hna_global_entry;
 	HASHIT(hashit);
 	int bytes_written = 0;
 	unsigned long flags;
 	size_t hdr_len;
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
+	if (!bat_priv->primary_if) {
 		if (off == 0)
 			return sprintf(buff,
 				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
@@ -394,7 +389,6 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 		return 0;
 	}
-	rcu_read_unlock();
 
 	hdr_len = sprintf(buff,
 			  "Globally announced HNAs received via the mesh %s (translation table):\n",
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index de13c99..737db7c 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -36,12 +36,13 @@ struct batman_if {
 	struct list_head list;
 	int16_t if_num;
 	char *dev;
-	char if_active;
+	char if_status;
 	char addr_str[ETH_STR_LEN];
 	struct net_device *net_dev;
 	atomic_t seqno;
 	unsigned char *packet_buff;
 	int packet_len;
+	struct kobject *hardif_obj;
 	struct rcu_head rcu;
 };
 
@@ -99,6 +100,8 @@ struct bat_priv {
 	atomic_t gw_mode;
 	atomic_t gw_class;
 	atomic_t orig_interval;
+	char num_ifaces;
+	struct batman_if *primary_if;
 	struct kobject *mesh_obj;
 };
 
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index a774de7..3144439 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -174,13 +174,10 @@ ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
 	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 
-	rcu_read_lock();
-	if (list_empty(&if_list) || (vis_server == VIS_TYPE_CLIENT_UPDATE)) {
-		rcu_read_unlock();
+	if ((!bat_priv->primary_if) ||
+	    (vis_server == VIS_TYPE_CLIENT_UPDATE))
 		return 0;
-	}
 
-	rcu_read_unlock();
 	hdr_len = 0;
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
-- 
1.7.0

