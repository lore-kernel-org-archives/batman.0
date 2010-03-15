Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 09:03:04 +0800
Message-Id: <1268614986-17280-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003150902.33262.lindner_marek@yahoo.de>
References: <201003150902.33262.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: convert more files from
	/proc to /sys
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

converted files:
vis_mode, gw_mode, vis_data, gateways

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/aggregation.c       |    6 +-
 batman-adv-kernelland/aggregation.h       |    8 +-
 batman-adv-kernelland/bat_sysfs.c         |  221 ++++++++++++++-------
 batman-adv-kernelland/gateway_client.c    |   62 +++++-
 batman-adv-kernelland/gateway_client.h    |    5 +-
 batman-adv-kernelland/gateway_common.c    |   79 ++++-----
 batman-adv-kernelland/gateway_common.h    |    5 +-
 batman-adv-kernelland/main.c              |    6 -
 batman-adv-kernelland/main.h              |    2 -
 batman-adv-kernelland/originator.c        |   34 +++-
 batman-adv-kernelland/originator.h        |    3 +-
 batman-adv-kernelland/proc.c              |  308 -----------------------------
 batman-adv-kernelland/proc.h              |    7 -
 batman-adv-kernelland/routing.c           |   26 ++-
 batman-adv-kernelland/routing.h           |    4 +-
 batman-adv-kernelland/send.c              |   20 ++-
 batman-adv-kernelland/soft-interface.c    |    6 +-
 batman-adv-kernelland/translation-table.c |   26 +++
 batman-adv-kernelland/types.h             |    3 +
 batman-adv-kernelland/vis.c               |  124 ++++++++++--
 batman-adv-kernelland/vis.h               |   17 +-
 21 files changed, 457 insertions(+), 515 deletions(-)

diff --git a/batman-adv-kernelland/aggregation.c b/batman-adv-kernelland/aggregation.c
index a829814..73c9166 100644
--- a/batman-adv-kernelland/aggregation.c
+++ b/batman-adv-kernelland/aggregation.c
@@ -157,10 +157,10 @@ static void aggregate(struct forw_packet *forw_packet_aggr,
 			(1 << forw_packet_aggr->num_packets);
 }
 
-void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
+void add_bat_packet_to_list(struct bat_priv *bat_priv,
+			    unsigned char *packet_buff, int packet_len,
 			    struct batman_if *if_incoming, char own_packet,
-			    unsigned long send_time,
-			    struct bat_priv *bat_priv)
+			    unsigned long send_time)
 {
 	/**
 	 * _aggr -> pointer to the packet we want to aggregate with
diff --git a/batman-adv-kernelland/aggregation.h b/batman-adv-kernelland/aggregation.h
index 7c8e6f7..cda243b 100644
--- a/batman-adv-kernelland/aggregation.h
+++ b/batman-adv-kernelland/aggregation.h
@@ -30,9 +30,9 @@ static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna)
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
 }
 
-void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
-			    struct batman_if *if_outgoing, char own_packet,
-			    unsigned long send_time,
-			    struct bat_priv *bat_priv);
+void add_bat_packet_to_list(struct bat_priv *bat_priv,
+			    unsigned char *packet_buff, int packet_len,
+			    struct batman_if *if_incoming, char own_packet,
+			    unsigned long send_time);
 void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 			     int packet_len, struct batman_if *if_incoming);
diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index 4d8938a..e4685a7 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -24,6 +24,9 @@
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
+#include "vis.h"
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
@@ -51,6 +54,54 @@ struct bin_attribute bat_attr_##_name = {		\
 	.write = _write,				\
 };
 
+static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+			     char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
+
+	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1 \n",
+		       aggr_status == 0 ? "disabled" : "enabled");
+}
+
+static ssize_t store_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	int aggr_tmp = -1;
+
+	if (((count == 2) && (buff[0] == '1')) ||
+	    (strncmp(buff, "enable", 6) == 0))
+		aggr_tmp = 1;
+
+	if (((count == 2) && (buff[0] == '0')) ||
+	    (strncmp(buff, "disable", 7) == 0))
+		aggr_tmp = 0;
+
+	if (aggr_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		printk(KERN_INFO "batman-adv:Invalid parameter for 'aggregate OGM' setting on mesh %s received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
+		return count;
+
+	printk(KERN_INFO "batman-adv:Changing aggregation from: %s to: %s on mesh: %s\n",
+	       atomic_read(&bat_priv->aggregation_enabled) == 1 ?
+	       "enabled" : "disabled", aggr_tmp == 1 ? "enabled" : "disabled",
+	       net_dev->name);
+
+	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
+	return count;
+}
+
 static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -100,61 +151,117 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
-static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
+	int vis_mode = atomic_read(&bat_priv->vis_mode);
 
-	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1 \n",
-		       aggr_status == 0 ? "disabled" : "enabled");
+	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d \n",
+		       vis_mode == VIS_TYPE_CLIENT_UPDATE ?
+							"client" : "server",
+		       VIS_TYPE_SERVER_SYNC, VIS_TYPE_CLIENT_UPDATE);
 }
 
-static ssize_t store_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 			      char *buff, size_t count)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	int aggr_tmp = -1;
+	unsigned long val;
+	int ret, vis_mode_tmp = -1;
 
-	if (((count == 2) && (buff[0] == '1')) ||
-	    (strncmp(buff, "enable", 6) == 0))
-		aggr_tmp = 1;
+	ret = strict_strtoul(buff, 10, &val);
 
-	if (((count == 2) && (buff[0] == '0')) ||
-	    (strncmp(buff, "disable", 7) == 0))
-		aggr_tmp = 0;
+	if (((count == 2) && (!ret) && (val == VIS_TYPE_CLIENT_UPDATE)) ||
+	    (strncmp(buff, "client", 6) == 0))
+		vis_mode_tmp = VIS_TYPE_CLIENT_UPDATE;
 
-	if (aggr_tmp < 0) {
+	if (((count == 2) && (!ret) && (val == VIS_TYPE_SERVER_SYNC)) ||
+	    (strncmp(buff, "server", 6) == 0))
+		vis_mode_tmp = VIS_TYPE_SERVER_SYNC;
+
+	if (vis_mode_tmp < 0) {
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'aggregate OGM' setting on mesh %s received: %s\n",
+		printk(KERN_INFO "batman-adv:Invalid parameter for 'vis mode' setting on mesh %s received: %s\n",
 		       net_dev->name, buff);
 		return -EINVAL;
 	}
 
-	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
+	if (atomic_read(&bat_priv->vis_mode) == vis_mode_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing aggregation from: %s to: %s on mesh: %s\n",
-	       atomic_read(&bat_priv->aggregation_enabled) == 1 ?
-	       "enabled" : "disabled", aggr_tmp == 1 ? "enabled" : "disabled",
-	       net_dev->name);
+	printk(KERN_INFO "batman-adv:Changing vis mode from: %s to: %s on mesh: %s\n",
+	       atomic_read(&bat_priv->vis_mode) == VIS_TYPE_CLIENT_UPDATE ?
+	       "client" : "server", vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
+	       "client" : "server", net_dev->name);
 
-	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
+	atomic_set(&bat_priv->vis_mode, (unsigned)vis_mode_tmp);
 	return count;
 }
 
+static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
+			    char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int down, up, bytes_written;
+	int gw_mode = atomic_read(&bat_priv->gw_mode);
+	int gw_class = atomic_read(&bat_priv->gw_class);
+
+	switch (gw_mode) {
+	case GW_MODE_CLIENT:
+		bytes_written = sprintf(buff, "status: %s (gw_class: %i)\n",
+					GW_MODE_CLIENT_NAME, gw_class);
+		break;
+	case GW_MODE_SERVER:
+		gw_srv_class_to_kbit(gw_class, &down, &up);
+		bytes_written = sprintf(buff,
+					"status: %s (gw_class: %i -> propagating: %i%s/%i%s)\n",
+					GW_MODE_SERVER_NAME, gw_class,
+					(down > 2048 ? down / 1024 : down),
+					(down > 2048 ? "MBit" : "KBit"),
+					(up > 2048 ? up / 1024 : up),
+					(up > 2048 ? "MBit" : "KBit"));
+		break;
+	default:
+		bytes_written = sprintf(buff, "status: %s\n",
+					GW_MODE_OFF_NAME);
+		break;
+	}
+
+	bytes_written += sprintf(buff + bytes_written,
+				 "commands: %s, %s <opt arg>, %s <opt arg> \n",
+				 GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
+				 GW_MODE_SERVER_NAME);
+	return bytes_written;
+}
+
+static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+
+	return gw_mode_set(bat_priv, buff, count);
+}
+
 static BAT_ATTR(aggregate_ogm, S_IRUGO | S_IWUSR,
 		show_aggr_ogm, store_aggr_ogm);
 static BAT_ATTR(bonding, S_IRUGO | S_IWUSR, show_bond, store_bond);
+static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
+static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 
 static struct bat_attribute *mesh_attrs[] = {
-	&bat_attr_bonding,
 	&bat_attr_aggregate_ogm,
+	&bat_attr_bonding,
+	&bat_attr_vis_mode,
+	&bat_attr_gw_mode,
 	NULL,
 };
 
@@ -165,19 +272,6 @@ static ssize_t transtable_local_read(struct kobject *kobj,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
-	}
-	rcu_read_unlock();
-
 	return hna_local_fill_buffer_text(net_dev, buff, count, off);
 }
 
@@ -188,19 +282,6 @@ static ssize_t transtable_global_read(struct kobject *kobj,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
-	}
-	rcu_read_unlock();
-
 	return hna_global_fill_buffer_text(net_dev, buff, count, off);
 }
 
@@ -208,45 +289,44 @@ static ssize_t originators_read(struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
 			       char *buff, loff_t off, size_t count)
 {
-	/* FIXME: orig table should exist per batif */
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
-	}
+	return orig_fill_buffer_text(net_dev, buff, count, off);
+}
 
-	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
-		rcu_read_unlock();
+static ssize_t gateways_read(struct kobject *kobj,
+			     struct bin_attribute *bin_attr,
+			     char *buff, loff_t off, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
 
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - primary interface not active\n",
-				       net_dev->name);
+	return gw_client_fill_buffer_text(net_dev, buff, count, off);
+}
 
-		return 0;
-	}
-	rcu_read_unlock();
+static ssize_t vis_data_read(struct kobject *kobj,
+			     struct bin_attribute *bin_attr,
+			     char *buff, loff_t off, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
 
-	return orig_fill_buffer_text(buff, count, off);
+	return vis_fill_buffer_text(net_dev, buff, count, off);
 }
 
 static BAT_BIN_ATTR(transtable_local, S_IRUGO, transtable_local_read, NULL);
 static BAT_BIN_ATTR(transtable_global, S_IRUGO, transtable_global_read, NULL);
 static BAT_BIN_ATTR(originators, S_IRUGO, originators_read, NULL);
+static BAT_BIN_ATTR(gateways, S_IRUGO, gateways_read, NULL);
+static BAT_BIN_ATTR(vis_data, S_IRUGO, vis_data_read, NULL);
 
 static struct bin_attribute *mesh_bin_attrs[] = {
 	&bat_attr_transtable_local,
 	&bat_attr_transtable_global,
 	&bat_attr_originators,
+	&bat_attr_gateways,
+	&bat_attr_vis_data,
 	NULL,
 };
 
@@ -262,6 +342,9 @@ int sysfs_add_meshif(struct net_device *dev)
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
 	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
+	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
+	atomic_set(&bat_priv->gw_class, 0);
 
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index 3deca40..6b3ac64 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -20,6 +20,7 @@
 #include "main.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
+#include "hard-interface.h"
 #include "compat.h"
 #include <linux/ip.h>
 #include <linux/udp.h>
@@ -331,12 +332,49 @@ static int _write_buffer_text(unsigned char *buff, int bytes_written,
 		       (up > 2048 ? "MBit" : "KBit"));
 }
 
-int gw_client_fill_buffer_text(unsigned char *buff, int buff_len)
+int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
+			       size_t count, loff_t off)
 {
 	struct gw_node *gw_node;
+	size_t hdr_len, tmp_len;
 	int bytes_written = 0, gw_count = 0;
 
 	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+
+	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - primary interface not active\n",
+				       net_dev->name);
+
+		return 0;
+	}
+
+	hdr_len = sprintf(buff,
+			  "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
+			  "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
+			  "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
+			  ((struct batman_if *)if_list.next)->dev,
+			  ((struct batman_if *)if_list.next)->addr_str,
+			  net_dev->name);
+	rcu_read_unlock();
+
+	if (off < hdr_len)
+		bytes_written = hdr_len;
+
+	rcu_read_lock();
 	list_for_each_entry_rcu(gw_node, &gw_list, list) {
 		if (gw_node->deleted)
 			continue;
@@ -344,29 +382,35 @@ int gw_client_fill_buffer_text(unsigned char *buff, int buff_len)
 		if (!gw_node->orig_node->router)
 			continue;
 
-		if (buff_len < bytes_written + (2 * ETH_STR_LEN) + 30)
+		if (count < bytes_written + (2 * ETH_STR_LEN) + 30)
 			break;
 
-		bytes_written += _write_buffer_text(buff,
-						    bytes_written,
-						    gw_node);
+		tmp_len = _write_buffer_text(buff, bytes_written, gw_node);
 		gw_count++;
+
+		hdr_len += tmp_len;
+
+		if (off >= hdr_len)
+			continue;
+
+		bytes_written += tmp_len;
 	}
 	rcu_read_unlock();
 
-	if (gw_count == 0)
-		sprintf(buff, "No gateways in range ... \n");
+	if ((gw_count == 0) && (off == 0))
+		bytes_written += sprintf(buff + bytes_written,
+					 "No gateways in range ... \n");
 
 	return bytes_written;
 }
 
-bool gw_is_target(struct sk_buff *skb)
+bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 {
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
 	struct udphdr *udphdr;
 
-	if (atomic_read(&gw_mode) != GW_MODE_CLIENT)
+	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
 		return false;
 
 	if (!curr_gateway)
diff --git a/batman-adv-kernelland/gateway_client.h b/batman-adv-kernelland/gateway_client.h
index fc7a0df..9920adc 100644
--- a/batman-adv-kernelland/gateway_client.h
+++ b/batman-adv-kernelland/gateway_client.h
@@ -27,5 +27,6 @@ void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags);
 void gw_node_delete(struct orig_node *orig_node);
 void gw_node_purge_deleted(void);
 void gw_node_list_free(void);
-int gw_client_fill_buffer_text(unsigned char *buff, int buff_len);
-bool gw_is_target(struct sk_buff *skb);
+int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
+			       size_t count, loff_t off);
+bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
diff --git a/batman-adv-kernelland/gateway_common.c b/batman-adv-kernelland/gateway_common.c
index d5521a6..3619177 100644
--- a/batman-adv-kernelland/gateway_common.c
+++ b/batman-adv-kernelland/gateway_common.c
@@ -22,9 +22,6 @@
 #include "gateway_client.h"
 #include "compat.h"
 
-atomic_t gw_mode;
-atomic_t gw_srv_class;
-
 /* calculates the gateway class from kbit */
 static void kbit_to_gw_srv_class(int down, int up, long *gw_srv_class)
 {
@@ -78,7 +75,7 @@ void gw_srv_class_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 }
 
 static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
-			      char **gw_mode_tmp_str, long *gw_clnt_class_tmp,
+			      char **gw_mode_tmp_str, long *gw_class_tmp,
 			      long *up, long *down)
 {
 	int ret;
@@ -86,16 +83,16 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 	switch (*gw_mode_tmp) {
 	case GW_MODE_CLIENT:
-		ret = strict_strtoul(tokptr, 10, gw_clnt_class_tmp);
+		ret = strict_strtoul(tokptr, 10, gw_class_tmp);
 		if (ret) {
-			printk(KERN_ERR "Client class of gateway mode invalid: %s\n",
+			printk(KERN_ERR "batman-adv: Client class of gateway mode invalid: %s\n",
 			       tokptr);
 			return false;
 		}
 
-		if (*gw_clnt_class_tmp > TQ_MAX_VALUE) {
-			printk(KERN_ERR "Client class of gateway mode greater than %i: %ld\n",
-					TQ_MAX_VALUE, *gw_clnt_class_tmp);
+		if (*gw_class_tmp > TQ_MAX_VALUE) {
+			printk(KERN_ERR "batman-adv: Client class of gateway mode greater than %i: %ld\n",
+					TQ_MAX_VALUE, *gw_class_tmp);
 			return false;
 		}
 
@@ -107,7 +104,7 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 		ret = strict_strtoul(tokptr, 10, down);
 		if (ret) {
-			printk(KERN_ERR "Download speed of gateway mode invalid: %s\n",
+			printk(KERN_ERR "batman-adv: Download speed of gateway mode invalid: %s\n",
 			       tokptr);
 			return false;
 		}
@@ -124,7 +121,7 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 		if (slash_ptr) {
 			ret = strict_strtoul(slash_ptr + 1, 10, up);
 			if (ret) {
-				printk(KERN_ERR "Upload speed of gateway mode invalid: %s\n",
+				printk(KERN_ERR "batman-adv: Upload speed of gateway mode invalid: %s\n",
 				       slash_ptr + 1);
 				return false;
 			}
@@ -161,27 +158,18 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 	return true;
 }
 
-ssize_t gw_mode_set(const char __user *userbuffer, size_t count)
+ssize_t gw_mode_set(struct bat_priv *bat_priv, char *buff, size_t count)
 {
-	char *gw_mode_string, *tokptr, *cp;
+	char *tokptr, *cp, finished;
 	char *gw_mode_curr_str, *gw_mode_tmp_str = NULL;
-	int finished, not_copied = 0;
 	long gw_mode_curr, gw_mode_tmp = GW_MODE_OFF;
-	long gw_srv_class_tmp = 0, gw_clnt_class_tmp = 0, up = 0, down = 0;
+	long gw_class_tmp = 0, up = 0, down = 0;
 	bool ret;
 
-	gw_mode_string = kmalloc(count, GFP_KERNEL);
-
-	if (!gw_mode_string)
-		return -ENOMEM;
-
-	not_copied = copy_from_user(gw_mode_string, userbuffer, count);
-	gw_mode_string[count - not_copied - 1] = 0;
+	tokptr = buff;
+	gw_mode_curr = atomic_read(&bat_priv->gw_mode);
 
-	tokptr = gw_mode_string;
-	gw_mode_curr = atomic_read(&gw_mode);
-
-	for (cp = gw_mode_string, finished = 0; !finished; cp++) {
+	for (cp = buff, finished = 0; !finished; cp++) {
 		switch (*cp) {
 		case 0:
 			finished = 1;
@@ -189,14 +177,19 @@ ssize_t gw_mode_set(const char __user *userbuffer, size_t count)
 		case '\n':
 		case '\t':
 			*cp = 0;
+
+			if (strlen(tokptr) == 0)
+				goto next;
+
 			ret = parse_gw_mode_tok(tokptr, &gw_mode_tmp,
 						&gw_mode_tmp_str,
-						&gw_clnt_class_tmp,
+						&gw_class_tmp,
 						&up, &down);
 
 			if (!ret)
 				goto end;
 
+next:
 			tokptr = cp + 1;
 			break;
 		default:
@@ -205,9 +198,9 @@ ssize_t gw_mode_set(const char __user *userbuffer, size_t count)
 	}
 
 	if (!gw_mode_tmp_str) {
-		printk(KERN_INFO "Gateway mode can only be set to: '%s', '%s' or '%s' - given value: %s\n",
+		printk(KERN_INFO "batman-adv: Gateway mode can only be set to: '%s', '%s' or '%s' - given value: %s\n",
 			GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
-			GW_MODE_SERVER_NAME, gw_mode_string);
+			GW_MODE_SERVER_NAME, buff);
 		goto end;
 	}
 
@@ -225,12 +218,11 @@ ssize_t gw_mode_set(const char __user *userbuffer, size_t count)
 
 	switch (gw_mode_tmp) {
 	case GW_MODE_CLIENT:
-		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_clnt_class_tmp))
-			gw_clnt_class_tmp = 20;
+		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_class_tmp))
+			gw_class_tmp = 20;
 
-		printk(KERN_INFO "Changing gateway mode from: '%s' to: '%s' (gw_clnt_class: %ld)\n",
-			  gw_mode_curr_str, gw_mode_tmp_str,
-			  gw_clnt_class_tmp);
+		printk(KERN_INFO "batman-adv: Changing gateway mode from: '%s' to: '%s' (gw_class: %ld)\n",
+			  gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
 		break;
 	case GW_MODE_SERVER:
 		if (!down)
@@ -239,39 +231,36 @@ ssize_t gw_mode_set(const char __user *userbuffer, size_t count)
 		if (!up)
 			up = down / 5;
 
-		kbit_to_gw_srv_class(down, up, &gw_srv_class_tmp);
+		kbit_to_gw_srv_class(down, up, &gw_class_tmp);
 
 		/**
 		 * the gw class we guessed above might not match the given
 		 * speeds, hence we need to calculate it back to show the
 		 * number that is going to be propagated
 		 **/
-		gw_srv_class_to_kbit((uint8_t)gw_srv_class_tmp,
+		gw_srv_class_to_kbit((uint8_t)gw_class_tmp,
 				     (int *)&down, (int *)&up);
 
 		printk(KERN_INFO
-			  "Changing gateway mode from: '%s' to: '%s' (gw_srv_class: %ld -> propagating: %ld%s/%ld%s)\n",
-			  gw_mode_curr_str, gw_mode_tmp_str,
-			  gw_srv_class_tmp,
+			  "batman-adv: Changing gateway mode from: '%s' to: '%s' (gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
+			  gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
 			  (down > 2048 ? down / 1024 : down),
 			  (down > 2048 ? "MBit" : "KBit"),
 			  (up > 2048 ? up / 1024 : up),
 			  (up > 2048 ? "MBit" : "KBit"));
 		break;
 	default:
-		printk(KERN_INFO "Changing gateway mode from: '%s' to: '%s'\n",
+		printk(KERN_INFO "batman-adv: Changing gateway mode from: '%s' to: '%s'\n",
 			  gw_mode_curr_str, gw_mode_tmp_str);
 		break;
 	}
 
-	atomic_set(&gw_mode, gw_mode_tmp);
-	atomic_set(&gw_srv_class, gw_srv_class_tmp);
-	atomic_set(&gw_clnt_class, gw_clnt_class_tmp);
+	atomic_set(&bat_priv->gw_mode, gw_mode_tmp);
+	atomic_set(&bat_priv->gw_class, gw_class_tmp);
 
-	if (gw_clnt_class_tmp == 0)
+	if (gw_class_tmp == 0)
 		gw_deselect();
 
 end:
-	kfree(gw_mode_string);
 	return count;
 }
diff --git a/batman-adv-kernelland/gateway_common.h b/batman-adv-kernelland/gateway_common.h
index 365cd00..91c6a38 100644
--- a/batman-adv-kernelland/gateway_common.h
+++ b/batman-adv-kernelland/gateway_common.h
@@ -27,8 +27,5 @@ enum gw_modes {
 #define GW_MODE_CLIENT_NAME	"client"
 #define GW_MODE_SERVER_NAME	"server"
 
-extern atomic_t gw_mode;
-extern atomic_t gw_srv_class;
-
 void gw_srv_class_to_kbit(uint8_t gw_class, int *down, int *up);
-ssize_t gw_mode_set(const char __user *userbuffer, size_t count);
+ssize_t gw_mode_set(struct bat_priv *bat_priv, char *buff, size_t count);
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index a1f7111..6867cad 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -29,7 +29,6 @@
 #include "device.h"
 #include "translation-table.h"
 #include "hard-interface.h"
-#include "gateway_common.h"
 #include "gateway_client.h"
 #include "types.h"
 #include "vis.h"
@@ -47,7 +46,6 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 atomic_t originator_interval;
 atomic_t vis_interval;
-atomic_t vis_mode;
 int16_t num_hna;
 int16_t num_ifs;
 
@@ -87,10 +85,6 @@ int init_module(void)
 	atomic_set(&originator_interval, 1000);
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
-	atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
-	atomic_set(&gw_mode, GW_MODE_OFF);
-	atomic_set(&gw_srv_class, 0);
-	atomic_set(&gw_clnt_class, 0);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index 307a6e6..6b9bbf1 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -135,8 +135,6 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
-extern atomic_t vis_mode;
-extern atomic_t bonding_enabled;
 extern int16_t num_hna;
 extern int16_t num_ifs;
 
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index dd69a32..0a9f905 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -28,6 +28,7 @@
 #include "routing.h"
 #include "compat.h"
 #include "gateway_client.h"
+#include "hard-interface.h"
 
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
@@ -207,7 +208,6 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 	return neigh_purged;
 }
 
-
 static bool purge_orig_node(struct orig_node *orig_node)
 {
 	/* FIXME: each batman_if will be attached to a softif */
@@ -229,7 +229,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 				      orig_node->hna_buff_len);
 			/* update bonding candidates, we could have lost
 			 * some candidates. */
-			update_bonding_candidates(orig_node, bat_priv);
+			update_bonding_candidates(bat_priv, orig_node);
 		}
 	}
 	return false;
@@ -261,7 +261,8 @@ void purge_orig(struct work_struct *work)
 	start_purge_timer();
 }
 
-ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off)
+ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
@@ -272,12 +273,35 @@ ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off)
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
 	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+
+	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - primary interface not active\n",
+				       net_dev->name);
+
+		return 0;
+	}
+
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   ((struct batman_if *)if_list.next)->dev,
-		   ((struct batman_if *)if_list.next)->addr_str);
+		   ((struct batman_if *)if_list.next)->addr_str,
+		   net_dev->name);
 	rcu_read_unlock();
 
 	if (off < hdr_len)
diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/originator.h
index 3d22259..1f025b7 100644
--- a/batman-adv-kernelland/originator.h
+++ b/batman-adv-kernelland/originator.h
@@ -28,4 +28,5 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
-ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off);
+ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off);
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index a6fb20e..d9d70db 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -33,8 +33,6 @@
 
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
 static struct proc_dir_entry *proc_orig_interval_file;
-static struct proc_dir_entry *proc_vis_srv_file, *proc_vis_data_file;
-static struct proc_dir_entry *proc_gw_mode_file, *proc_gw_srv_list_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
@@ -177,255 +175,6 @@ static int proc_orig_interval_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_orig_interval_read, NULL);
 }
 
-/* setting the mode of the vis server by the user */
-static ssize_t proc_vis_srv_write(struct file *file, const char __user * buffer,
-			      size_t count, loff_t *ppos)
-{
-	char *vis_mode_string;
-	int not_copied = 0;
-
-	vis_mode_string = kmalloc(count, GFP_KERNEL);
-
-	if (!vis_mode_string)
-		return -ENOMEM;
-
-	not_copied = copy_from_user(vis_mode_string, buffer, count);
-	vis_mode_string[count - not_copied - 1] = 0;
-
-	if ((strcmp(vis_mode_string, "client") == 0) ||
-			(strcmp(vis_mode_string, "disabled") == 0)) {
-		printk(KERN_INFO "batman-adv:Setting VIS mode to client (disabling vis server)\n");
-		atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
-	} else if ((strcmp(vis_mode_string, "server") == 0) ||
-			(strcmp(vis_mode_string, "enabled") == 0)) {
-		printk(KERN_INFO "batman-adv:Setting VIS mode to server (enabling vis server)\n");
-		atomic_set(&vis_mode, VIS_TYPE_SERVER_SYNC);
-	} else
-		printk(KERN_ERR "batman-adv:Unknown VIS mode: %s\n",
-		       vis_mode_string);
-
-	kfree(vis_mode_string);
-	return count;
-}
-
-static int proc_vis_srv_read(struct seq_file *seq, void *offset)
-{
-	int vis_server = atomic_read(&vis_mode);
-
-	seq_printf(seq, "[%c] client mode (server disabled) \n",
-			(vis_server == VIS_TYPE_CLIENT_UPDATE) ? 'x' : ' ');
-	seq_printf(seq, "[%c] server mode (server enabled) \n",
-			(vis_server == VIS_TYPE_SERVER_SYNC) ? 'x' : ' ');
-
-	return 0;
-}
-
-static int proc_vis_srv_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_vis_srv_read, NULL);
-}
-
-static int proc_vis_data_read(struct seq_file *seq, void *offset)
-{
-	HASHIT(hashit);
-	struct vis_info *info;
-	struct vis_info_entry *entries;
-	HLIST_HEAD(vis_if_list);
-	struct if_list_entry *entry;
-	struct hlist_node *pos, *n;
-	int i;
-	char tmp_addr_str[ETH_STR_LEN];
-	unsigned long flags;
-	int vis_server = atomic_read(&vis_mode);
-
-	rcu_read_lock();
-	if (list_empty(&if_list) || (vis_server == VIS_TYPE_CLIENT_UPDATE)) {
-		rcu_read_unlock();
-		goto end;
-	}
-
-	rcu_read_unlock();
-
-	spin_lock_irqsave(&vis_hash_lock, flags);
-	while (hash_iterate(vis_hash, &hashit)) {
-		info = hashit.bucket->data;
-		entries = (struct vis_info_entry *)
-			((char *)info + sizeof(struct vis_info));
-
-		for (i = 0; i < info->packet.entries; i++) {
-			if (entries[i].quality == 0)
-				continue;
-			proc_vis_insert_interface(entries[i].src, &vis_if_list,
-				compare_orig(entries[i].src,
-						info->packet.vis_orig));
-		}
-
-		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-			addr_to_string(tmp_addr_str, entry->addr);
-			seq_printf(seq, "%s,", tmp_addr_str);
-
-			for (i = 0; i < info->packet.entries; i++)
-				proc_vis_read_entry(seq, &entries[i],
-						entry->addr, entry->primary);
-
-			/* add primary/secondary records */
-			if (compare_orig(entry->addr, info->packet.vis_orig))
-				proc_vis_read_prim_sec(seq, &vis_if_list);
-
-			seq_printf(seq, "\n");
-		}
-
-		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
-			hlist_del(&entry->list);
-			kfree(entry);
-		}
-	}
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-
-end:
-	return 0;
-}
-
-static int proc_vis_data_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_vis_data_read, NULL);
-}
-
-static int proc_gw_mode_read(struct seq_file *seq, void *offset)
-{
-	int down, up;
-	long gw_mode_curr = atomic_read(&gw_mode);
-	uint8_t gw_srv_class_curr = (uint8_t)atomic_read(&gw_srv_class);
-
-	gw_srv_class_to_kbit(gw_srv_class_curr, &down, &up);
-
-	seq_printf(seq, "[%c] %s\n",
-		   (gw_mode_curr == GW_MODE_OFF) ? 'x' : ' ',
-		   GW_MODE_OFF_NAME);
-
-	if (gw_mode_curr == GW_MODE_CLIENT)
-		seq_printf(seq, "[x] %s (gw_clnt_class: %i)\n",
-			   GW_MODE_CLIENT_NAME,
-			   atomic_read(&gw_clnt_class));
-	else
-		seq_printf(seq, "[ ] %s\n", GW_MODE_CLIENT_NAME);
-
-	if (gw_mode_curr == GW_MODE_SERVER)
-		seq_printf(seq,
-			   "[x] %s (gw_srv_class: %i -> propagating: %i%s/%i%s)\n",
-			   GW_MODE_SERVER_NAME,
-			   gw_srv_class_curr,
-			   (down > 2048 ? down / 1024 : down),
-			   (down > 2048 ? "MBit" : "KBit"),
-			   (up > 2048 ? up / 1024 : up),
-			   (up > 2048 ? "MBit" : "KBit"));
-	else
-		seq_printf(seq, "[ ] %s\n", GW_MODE_SERVER_NAME);
-
-	return 0;
-}
-
-static int proc_gw_mode_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_gw_mode_read, NULL);
-}
-
-static ssize_t proc_gw_mode_write(struct file *instance,
-				    const char __user *userbuffer,
-				    size_t count, loff_t *data)
-{
-	return gw_mode_set(userbuffer, count);
-}
-
-static int proc_gw_srv_list_read(struct seq_file *seq, void *offset)
-{
-	char *buff;
-	int buffsize = 4096;
-
-	buff = kmalloc(buffsize, GFP_KERNEL);
-	if (!buff)
-		return 0;
-
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-		seq_printf(seq,
-			   "BATMAN disabled - please specify interfaces to enable it\n");
-		goto end;
-	}
-
-	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
-		rcu_read_unlock();
-		seq_printf(seq,
-			   "BATMAN disabled - primary interface not active\n");
-		goto end;
-	}
-
-	seq_printf(seq,
-		   "      %-12s (%s/%i) %17s [%10s]: gw_srv_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
-		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
-		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
-		   ((struct batman_if *)if_list.next)->dev,
-		   ((struct batman_if *)if_list.next)->addr_str);
-
-	rcu_read_unlock();
-
-	gw_client_fill_buffer_text(buff, buffsize);
-	seq_printf(seq, "%s", buff);
-
-end:
-	kfree(buff);
-	return 0;
-}
-
-static int proc_gw_srv_list_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_gw_srv_list_read, NULL);
-}
-
-/* satisfying different prototypes ... */
-static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos)
-{
-	return count;
-}
-
-static const struct file_operations proc_gw_srv_list_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_gw_srv_list_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_gw_mode_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_gw_mode_open,
-	.read		= seq_read,
-	.write		= proc_gw_mode_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_vis_srv_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_srv_open,
-	.read		= seq_read,
-	.write		= proc_vis_srv_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_vis_data_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_data_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static const struct file_operations proc_interfaces_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_interfaces_open,
@@ -452,18 +201,6 @@ void cleanup_procfs(void)
 	if (proc_interface_file)
 		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
 
-	if (proc_vis_data_file)
-		remove_proc_entry(PROC_FILE_VIS_DATA, proc_batman_dir);
-
-	if (proc_vis_srv_file)
-		remove_proc_entry(PROC_FILE_VIS_SRV, proc_batman_dir);
-
-	if (proc_gw_mode_file)
-		remove_proc_entry(PROC_FILE_GW_MODE, proc_batman_dir);
-
-	if (proc_gw_srv_list_file)
-		remove_proc_entry(PROC_FILE_GW_SRV_LIST, proc_batman_dir);
-
 	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
 		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
@@ -507,50 +244,5 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
-	proc_vis_srv_file = create_proc_entry(PROC_FILE_VIS_SRV,
-						S_IWUSR | S_IRUGO,
-						proc_batman_dir);
-	if (proc_vis_srv_file) {
-		proc_vis_srv_file->proc_fops = &proc_vis_srv_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_SRV);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_vis_data_file = create_proc_entry(PROC_FILE_VIS_DATA, S_IRUGO,
-					  proc_batman_dir);
-	if (proc_vis_data_file) {
-		proc_vis_data_file->proc_fops = &proc_vis_data_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_DATA);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_gw_mode_file = create_proc_entry(PROC_FILE_GW_MODE,
-					   S_IWUSR | S_IRUGO,
-					   proc_batman_dir);
-	if (proc_gw_mode_file) {
-		proc_gw_mode_file->proc_fops = &proc_gw_mode_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n",
-		       PROC_ROOT_DIR, PROC_FILE_GW_MODE);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_gw_srv_list_file = create_proc_entry(PROC_FILE_GW_SRV_LIST,
-					   S_IWUSR | S_IRUGO,
-					   proc_batman_dir);
-	if (proc_gw_srv_list_file) {
-		proc_gw_srv_list_file->proc_fops = &proc_gw_srv_list_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n",
-		       PROC_ROOT_DIR, PROC_FILE_GW_SRV_LIST);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	return 0;
 }
diff --git a/batman-adv-kernelland/proc.h b/batman-adv-kernelland/proc.h
index 6d74c54..37d0558 100644
--- a/batman-adv-kernelland/proc.h
+++ b/batman-adv-kernelland/proc.h
@@ -25,13 +25,6 @@
 #define PROC_ROOT_DIR "batman-adv"
 #define PROC_FILE_INTERFACES "interfaces"
 #define PROC_FILE_ORIG_INTERVAL "orig_interval"
-#define PROC_FILE_GATEWAYS "gateways"
-#define PROC_FILE_LOG "log"
-#define PROC_FILE_LOG_LEVEL "log_level"
-#define PROC_FILE_VIS_SRV "vis_server"
-#define PROC_FILE_VIS_DATA "vis_data"
-#define PROC_FILE_GW_MODE "gateway_mode"
-#define PROC_FILE_GW_SRV_LIST "gateway_srv_list"
 
 void cleanup_procfs(void);
 int setup_procfs(void);
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 0051259..479c579 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -362,10 +362,10 @@ static char count_real_packets(struct ethhdr *ethhdr,
 }
 
 /* copy primary address for bonding */
-static void mark_bonding_address(struct orig_node *orig_node,
+static void mark_bonding_address(struct bat_priv *bat_priv,
+				 struct orig_node *orig_node,
 				 struct orig_node *orig_neigh_node,
-				 struct batman_packet *batman_packet,
-				 struct bat_priv *bat_priv)
+				 struct batman_packet *batman_packet)
 
 {
 	/* don't care if bonding is not enabled */
@@ -382,8 +382,8 @@ static void mark_bonding_address(struct orig_node *orig_node,
 }
 
 /* mark possible bonding candidates in the neighbor list */
-void update_bonding_candidates(struct orig_node *orig_node,
-			       struct bat_priv *bat_priv)
+void update_bonding_candidates(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node)
 {
 	int candidates;
 	int interference_candidate;
@@ -642,9 +642,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		update_orig(orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
-	mark_bonding_address(orig_node, orig_neigh_node,
-			     batman_packet, bat_priv);
-	update_bonding_candidates(orig_node, bat_priv);
+	mark_bonding_address(bat_priv, orig_node,
+			     orig_neigh_node, batman_packet);
+	update_bonding_candidates(bat_priv, orig_node);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
@@ -1150,6 +1150,7 @@ int recv_vis_packet(struct sk_buff *skb)
 {
 	struct vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
+	struct bat_priv *bat_priv;
 	int hdr_size = sizeof(struct vis_packet);
 
 	if (skb_headlen(skb) < hdr_size)
@@ -1169,15 +1170,20 @@ int recv_vis_packet(struct sk_buff *skb)
 	if (is_my_mac(vis_packet->sender_orig))
 		return NET_RX_DROP;
 
+	/* FIXME: each batman_if will be attached to a softif */
+	bat_priv = netdev_priv(soft_device);
+
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
 		/* TODO: handle fragmented skbs properly */
-		receive_server_sync_packet(vis_packet, skb_headlen(skb));
+		receive_server_sync_packet(bat_priv, vis_packet,
+					   skb_headlen(skb));
 		break;
 
 	case VIS_TYPE_CLIENT_UPDATE:
 		/* TODO: handle fragmented skbs properly */
-		receive_client_update_packet(vis_packet, skb_headlen(skb));
+		receive_client_update_packet(bat_priv, vis_packet,
+					     skb_headlen(skb));
 		break;
 
 	default:	/* ignore unknown packet */
diff --git a/batman-adv-kernelland/routing.h b/batman-adv-kernelland/routing.h
index 9e3d4a2..bce4458 100644
--- a/batman-adv-kernelland/routing.h
+++ b/batman-adv-kernelland/routing.h
@@ -38,5 +38,5 @@ int recv_vis_packet(struct sk_buff *skb);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
 struct neigh_node *find_router(struct orig_node *orig_node);
-void update_bonding_candidates(struct orig_node *orig_node,
-			       struct bat_priv *bat_priv);
+void update_bonding_candidates(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node);
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 1c82f43..ae6e745 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -253,7 +253,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
-	int vis_server = atomic_read(&vis_mode);
+	int vis_server = atomic_read(&bat_priv->vis_mode);
 
 	/**
 	 * the interface gets activated here to avoid race conditions between
@@ -283,17 +283,21 @@ void schedule_own_packet(struct batman_if *batman_if)
 	else
 		batman_packet->flags &= ~VIS_SERVER;
 
-	batman_packet->gw_flags = (uint8_t)atomic_read(&gw_srv_class);
+	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER)
+		batman_packet->gw_flags =
+				(uint8_t)atomic_read(&bat_priv->gw_class);
+	else
+		batman_packet->gw_flags = 0;
 
 	/* could be read by receive_bat_packet() */
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
 	send_time = own_send_time();
-	add_bat_packet_to_list(batman_if->packet_buff,
+	add_bat_packet_to_list(bat_priv,
+			       batman_if->packet_buff,
 			       batman_if->packet_len,
-			       batman_if, 1, send_time,
-			       bat_priv);
+			       batman_if, 1, send_time);
 }
 
 void schedule_forward_packet(struct orig_node *orig_node,
@@ -350,10 +354,10 @@ void schedule_forward_packet(struct orig_node *orig_node,
 		batman_packet->flags &= ~DIRECTLINK;
 
 	send_time = forward_send_time(bat_priv);
-	add_bat_packet_to_list((unsigned char *)batman_packet,
+	add_bat_packet_to_list(bat_priv,
+			       (unsigned char *)batman_packet,
 			       sizeof(struct batman_packet) + hna_buff_len,
-			       if_incoming, 0, send_time,
-			       bat_priv);
+			       if_incoming, 0, send_time);
 }
 
 static void forw_packet_free(struct forw_packet *forw_packet)
diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index 582134f..1e0eff0 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -187,6 +187,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *priv = netdev_priv(dev);
 	struct batman_if *batman_if;
+	struct bat_priv *bat_priv;
 	uint8_t dstaddr[6];
 	int data_len = skb->len;
 	unsigned long flags;
@@ -195,6 +196,9 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dropped;
 
+	/* FIXME: each batman_if will be attached to a softif */
+	bat_priv = netdev_priv(soft_device);
+
 	dev->trans_start = jiffies;
 	/* TODO: check this for locks */
 	hna_local_add(ethhdr->h_source);
@@ -202,7 +206,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
 		bcast_dst = true;
 
-	if ((bcast_dst) && gw_is_target(skb))
+	if ((bcast_dst) && gw_is_target(bat_priv, skb))
 		do_bcast = false;
 
 	/* ethernet packet should be broadcasted */
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index e118d59..f9fb14b 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -166,6 +166,19 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 	unsigned long flags;
 	size_t hdr_len;
 
+	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+	rcu_read_unlock();
+
 	hdr_len = sprintf(buff,
 			  "Locally retrieved addresses (from %s) announced via HNA:\n",
 			  net_dev->name);
@@ -370,6 +383,19 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 	unsigned long flags;
 	size_t hdr_len;
 
+	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+	rcu_read_unlock();
+
 	hdr_len = sprintf(buff,
 			  "Globally announced HNAs received via the mesh %s (translation table):\n",
 			  net_dev->name);
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index feb3343..ca34353 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -96,6 +96,9 @@ struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
 	atomic_t bonding_enabled;
+	atomic_t vis_mode;
+	atomic_t gw_mode;
+	atomic_t gw_class;
 	struct kobject *mesh_obj;
 };
 
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index ff8bdd0..f8068ff 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -103,7 +103,7 @@ static int vis_info_choose(void *data, int size)
 
 /* insert interface to the list of interfaces of one originator, if it
  * does not already exist in the list */
-void proc_vis_insert_interface(const uint8_t *interface,
+void vis_data_insert_interface(const uint8_t *interface,
 				      struct hlist_head *if_list,
 				      bool primary)
 {
@@ -124,36 +124,119 @@ void proc_vis_insert_interface(const uint8_t *interface,
 	hlist_add_head(&entry->list, if_list);
 }
 
-void proc_vis_read_prim_sec(struct seq_file *seq,
-			    struct hlist_head *if_list)
+ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 {
 	struct if_list_entry *entry;
 	struct hlist_node *pos;
 	char tmp_addr_str[ETH_STR_LEN];
+	size_t len = 0;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
 		if (entry->primary)
-			seq_printf(seq, "PRIMARY, ");
+			len += sprintf(buff + len, "PRIMARY, ");
 		else {
 			addr_to_string(tmp_addr_str, entry->addr);
-			seq_printf(seq, "SEC %s, ", tmp_addr_str);
+			len += sprintf(buff + len,  "SEC %s, ", tmp_addr_str);
 		}
 	}
+
+	return len;
 }
 
 /* read an entry  */
-void proc_vis_read_entry(struct seq_file *seq,
-				struct vis_info_entry *entry,
-				uint8_t *src,
-				bool primary)
+ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
+			    uint8_t *src, bool primary)
 {
 	char to[40];
 
 	addr_to_string(to, entry->dest);
 	if (primary && entry->quality == 0)
-		seq_printf(seq, "HNA %s, ", to);
+		return sprintf(buff, "HNA %s, ", to);
 	else if (compare_orig(entry->src, src))
-		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
+		return sprintf(buff, "TQ %s %d, ", to, entry->quality);
+
+	return 0;
+}
+
+ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off)
+{
+	HASHIT(hashit);
+	struct vis_info *info;
+	struct vis_info_entry *entries;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	HLIST_HEAD(vis_if_list);
+	struct if_list_entry *entry;
+	struct hlist_node *pos, *n;
+	size_t hdr_len, tmp_len;
+	int i, bytes_written = 0;
+	char tmp_addr_str[ETH_STR_LEN];
+	unsigned long flags;
+	int vis_server = atomic_read(&bat_priv->vis_mode);
+
+	rcu_read_lock();
+	if (list_empty(&if_list) || (vis_server == VIS_TYPE_CLIENT_UPDATE)) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	rcu_read_unlock();
+	hdr_len = 0;
+
+	spin_lock_irqsave(&vis_hash_lock, flags);
+	while (hash_iterate(vis_hash, &hashit)) {
+		info = hashit.bucket->data;
+		entries = (struct vis_info_entry *)
+			((char *)info + sizeof(struct vis_info));
+
+		/* estimated line length */
+		if (count < bytes_written + 200)
+			break;
+
+		for (i = 0; i < info->packet.entries; i++) {
+			if (entries[i].quality == 0)
+				continue;
+			vis_data_insert_interface(entries[i].src, &vis_if_list,
+				compare_orig(entries[i].src,
+						info->packet.vis_orig));
+		}
+
+		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
+			addr_to_string(tmp_addr_str, entry->addr);
+			tmp_len = sprintf(buff + bytes_written,
+					  "%s,", tmp_addr_str);
+
+			for (i = 0; i < info->packet.entries; i++)
+				tmp_len += vis_data_read_entry(
+						buff + bytes_written + tmp_len,
+						&entries[i], entry->addr,
+						entry->primary);
+
+			/* add primary/secondary records */
+			if (compare_orig(entry->addr, info->packet.vis_orig))
+				tmp_len += vis_data_read_prim_sec(
+						buff + bytes_written + tmp_len,
+						&vis_if_list);
+
+			tmp_len += sprintf(buff + bytes_written + tmp_len,
+					  "\n");
+
+			hdr_len += tmp_len;
+
+			if (off >= hdr_len)
+				continue;
+
+			bytes_written += tmp_len;
+		}
+
+		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
+			hlist_del(&entry->list);
+			kfree(entry);
+		}
+	}
+	spin_unlock_irqrestore(&vis_hash_lock, flags);
+
+	return bytes_written;
 }
 
 /* add the info packet to the send list, if it was not
@@ -281,12 +364,14 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 }
 
 /* handle the server sync packet, forward if needed. */
-void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
+void receive_server_sync_packet(struct bat_priv *bat_priv,
+				struct vis_packet *vis_packet,
+				int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new, make_broadcast;
 	unsigned long flags;
-	int vis_server = atomic_read(&vis_mode);
+	int vis_server = atomic_read(&bat_priv->vis_mode);
 
 	make_broadcast = (vis_server == VIS_TYPE_SERVER_SYNC);
 
@@ -304,13 +389,14 @@ end:
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
-void receive_client_update_packet(struct vis_packet *vis_packet,
+void receive_client_update_packet(struct bat_priv *bat_priv,
+				  struct vis_packet *vis_packet,
 				  int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new;
 	unsigned long flags;
-	int vis_server = atomic_read(&vis_mode);
+	int vis_server = atomic_read(&bat_priv->vis_mode);
 	int are_target = 0;
 
 	/* clients shall not broadcast. */
@@ -377,7 +463,7 @@ static bool vis_packet_full(struct vis_info *info)
 
 /* generates a packet of own vis data,
  * returns 0 on success, -1 if no packet could be generated */
-static int generate_vis_packet(void)
+static int generate_vis_packet(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit_local);
 	HASHIT(hashit_global);
@@ -389,7 +475,7 @@ static int generate_vis_packet(void)
 	unsigned long flags;
 
 	info->first_seen = jiffies;
-	info->packet.vis_type = atomic_read(&vis_mode);
+	info->packet.vis_type = atomic_read(&bat_priv->vis_mode);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
@@ -569,12 +655,14 @@ static void send_vis_packets(struct work_struct *work)
 {
 	struct vis_info *info, *temp;
 	unsigned long flags;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 
 	purge_vis_packets();
 
-	if (generate_vis_packet() == 0) {
+	if (generate_vis_packet(bat_priv) == 0) {
 		/* schedule if generation was successful */
 		send_list_add(my_vis_info);
 	}
diff --git a/batman-adv-kernelland/vis.h b/batman-adv-kernelland/vis.h
index a1f92a4..7e803bb 100644
--- a/batman-adv-kernelland/vis.h
+++ b/batman-adv-kernelland/vis.h
@@ -49,18 +49,13 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-void proc_vis_insert_interface(const uint8_t *interface,
-				      struct hlist_head *if_list,
-				      bool primary);
-void proc_vis_read_entry(struct seq_file *seq,
-				struct vis_info_entry *entry,
-				uint8_t *src,
-				bool primary);
-void proc_vis_read_prim_sec(struct seq_file *seq,
-			    struct hlist_head *if_list);
-void receive_server_sync_packet(struct vis_packet *vis_packet,
+ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off);
+void receive_server_sync_packet(struct bat_priv *bat_priv,
+				struct vis_packet *vis_packet,
 				int vis_info_len);
-void receive_client_update_packet(struct vis_packet *vis_packet,
+void receive_client_update_packet(struct bat_priv *bat_priv,
+				  struct vis_packet *vis_packet,
 				  int vis_info_len);
 int vis_init(void);
 void vis_quit(void);
-- 
1.7.0

