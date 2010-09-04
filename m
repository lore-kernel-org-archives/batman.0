Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:25 +0200
Message-Id: <1283644718-653-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/21] Staging: batman-adv: layer2 unicast
	packet fragmentation
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Andreas Langer <an.langer@gmx.de>

This patch implements a simple layer2 fragmentation to allow traffic
exchange over network interfaces with a MTU smaller than 1500 bytes. The
fragmentation splits the big packets into two parts and marks the frames
accordingly. The receiving end buffers the packets to reassemble the
orignal packet before passing it to the higher layers. This feature
makes it necessary to modify the batman-adv encapsulation for unicast
packets by adding a sequence number, flags and the originator address.
This modifcation is part of a seperate packet type for fragemented
packets to keep the original overhead as low as possible. This patch
enables the feature by default to ensure the data traffic can travel
through the network. But it also prints a warning to notify the user
about the performance implications.

Note: Fragmentation should be avoided at all costs since it has a
dramatic impact on the performance, especially when it comes wifi
networks. Instead of a single packet, 2 packets have to be sent! Not
only valuable airtime is wasted but also packetloss decreases the
throughput. A link with 50% packetloss and fragmentation enabled is
pretty much unusable.

Signed-off-by: Andreas Langer <an.langer@gmx.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c      |   55 ++++++++
 drivers/staging/batman-adv/hard-interface.c |   34 +++++-
 drivers/staging/batman-adv/originator.c     |   10 ++
 drivers/staging/batman-adv/packet.h         |   26 +++-
 drivers/staging/batman-adv/routing.c        |  115 ++++++++++++++---
 drivers/staging/batman-adv/routing.h        |    1 +
 drivers/staging/batman-adv/soft-interface.c |    4 +-
 drivers/staging/batman-adv/types.h          |   10 ++
 drivers/staging/batman-adv/unicast.c        |  177 +++++++++++++++++++++++++++
 drivers/staging/batman-adv/unicast.h        |   12 ++
 10 files changed, 416 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index d49adde..b9fe391 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -134,6 +134,58 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
+			     char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int frag_status = atomic_read(&bat_priv->frag_enabled);
+
+	return sprintf(buff, "%s\n",
+		       frag_status == 0 ? "disabled" : "enabled");
+}
+
+static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
+			  char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	int frag_enabled_tmp = -1;
+
+	if (((count == 2) && (buff[0] == '1')) ||
+	    (strncmp(buff, "enable", 6) == 0))
+		frag_enabled_tmp = 1;
+
+	if (((count == 2) && (buff[0] == '0')) ||
+	    (strncmp(buff, "disable", 7) == 0))
+		frag_enabled_tmp = 0;
+
+	if (frag_enabled_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		bat_err(net_dev,
+			"Invalid parameter for 'fragmentation' setting on mesh"
+			"received: %s\n", buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->frag_enabled) == frag_enabled_tmp)
+		return count;
+
+	bat_info(net_dev, "Changing fragmentation from: %s to: %s\n",
+		 atomic_read(&bat_priv->frag_enabled) == 1 ?
+		 "enabled" : "disabled",
+		 frag_enabled_tmp == 1 ? "enabled" : "disabled");
+
+	atomic_set(&bat_priv->frag_enabled, (unsigned)frag_enabled_tmp);
+
+	update_min_mtu();
+
+	return count;
+}
+
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -279,6 +331,7 @@ static ssize_t store_log_level(struct kobject *kobj, struct attribute *attr,
 static BAT_ATTR(aggregated_ogms, S_IRUGO | S_IWUSR,
 		show_aggr_ogms, store_aggr_ogms);
 static BAT_ATTR(bonding, S_IRUGO | S_IWUSR, show_bond, store_bond);
+static BAT_ATTR(fragmentation, S_IRUGO | S_IWUSR, show_frag, store_frag);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
 		show_orig_interval, store_orig_interval);
@@ -289,6 +342,7 @@ static BAT_ATTR(log_level, S_IRUGO | S_IWUSR, show_log_level, store_log_level);
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
+	&bat_attr_fragmentation,
 	&bat_attr_vis_mode,
 	&bat_attr_orig_interval,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -308,6 +362,7 @@ int sysfs_add_meshif(struct net_device *dev)
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
 	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->frag_enabled, 1);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->log_level, 0);
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 6e973a7..82d3d55 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -166,6 +166,11 @@ int hardif_min_mtu(void)
 	/* allow big frames if all devices are capable to do so
 	 * (have MTU > 1500 + BAT_HEADER_LEN) */
 	int min_mtu = ETH_DATA_LEN;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+
+	if (atomic_read(&bat_priv->frag_enabled))
+		goto out;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
@@ -175,7 +180,7 @@ int hardif_min_mtu(void)
 				      min_mtu);
 	}
 	rcu_read_unlock();
-
+out:
 	return min_mtu;
 }
 
@@ -261,8 +266,30 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
 	atomic_set(&batman_if->seqno, 1);
+	atomic_set(&batman_if->frag_seqno, 1);
 	bat_info(soft_device, "Adding interface: %s\n", batman_if->dev);
 
+	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
+		ETH_DATA_LEN + BAT_HEADER_LEN)
+		bat_info(soft_device,
+			"The MTU of interface %s is too small (%i) to handle "
+			"the transport of batman-adv packets. Packets going "
+			"over this interface will be fragmented on layer2 "
+			"which could impact the performance. Setting the MTU "
+			"to %zi would solve the problem.\n",
+			batman_if->dev, batman_if->net_dev->mtu,
+			ETH_DATA_LEN + BAT_HEADER_LEN);
+
+	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
+		ETH_DATA_LEN + BAT_HEADER_LEN)
+		bat_info(soft_device,
+			"The MTU of interface %s is too small (%i) to handle "
+			"the transport of batman-adv packets. If you experience"
+			" problems getting traffic through try increasing the "
+			"MTU to %zi.\n",
+			batman_if->dev, batman_if->net_dev->mtu,
+			ETH_DATA_LEN + BAT_HEADER_LEN);
+
 	if (hardif_is_iface_up(batman_if))
 		hardif_activate_interface(soft_device, bat_priv, batman_if);
 	else
@@ -495,6 +522,11 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		ret = recv_unicast_packet(skb, batman_if);
 		break;
 
+		/* fragmented unicast packet */
+	case BAT_UNICAST_FRAG:
+		ret = recv_ucast_frag_packet(skb, batman_if);
+		break;
+
 		/* broadcast packet */
 	case BAT_BCAST:
 		ret = recv_bcast_packet(skb);
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index de5a8c1..b51a13e 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -27,6 +27,7 @@
 #include "translation-table.h"
 #include "routing.h"
 #include "hard-interface.h"
+#include "unicast.h"
 
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
@@ -95,6 +96,7 @@ static void free_orig_node(void *data)
 		kfree(neigh_node);
 	}
 
+	frag_list_free(&orig_node->frag_list);
 	hna_global_del_orig(orig_node, "originator timed out");
 
 	kfree(orig_node->bcast_own);
@@ -157,6 +159,10 @@ struct orig_node *get_orig_node(uint8_t *addr)
 
 	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
+
+	INIT_LIST_HEAD(&orig_node->frag_list);
+	orig_node->last_frag_packet = 0;
+
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
@@ -271,6 +277,10 @@ void purge_orig(struct work_struct *work)
 			hash_remove_bucket(orig_hash, &hashit);
 			free_orig_node(orig_node);
 		}
+
+		if (time_after(jiffies, (orig_node->last_frag_packet +
+			msecs_to_jiffies(FRAG_TIMEOUT))))
+			frag_list_free(&orig_node->frag_list);
 	}
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index abb5e46..44de1bf 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -24,14 +24,15 @@
 
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
-#define BAT_PACKET    0x01
-#define BAT_ICMP      0x02
-#define BAT_UNICAST   0x03
-#define BAT_BCAST     0x04
-#define BAT_VIS       0x05
+#define BAT_PACKET       0x01
+#define BAT_ICMP         0x02
+#define BAT_UNICAST      0x03
+#define BAT_BCAST        0x04
+#define BAT_VIS          0x05
+#define BAT_UNICAST_FRAG 0x06
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 11
+#define COMPAT_VERSION 13
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -47,6 +48,9 @@
 #define VIS_TYPE_SERVER_SYNC		0
 #define VIS_TYPE_CLIENT_UPDATE		1
 
+/* fragmentation defines */
+#define UNI_FRAG_HEAD 0x01
+
 struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
@@ -96,6 +100,16 @@ struct unicast_packet {
 	uint8_t  ttl;
 } __attribute__((packed));
 
+struct unicast_frag_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  dest[6];
+	uint8_t  ttl;
+	uint8_t  flags;
+	uint8_t  orig[6];
+	uint16_t seqno;
+} __attribute__((packed));
+
 struct bcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 032195e..d8e77ac 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -32,6 +32,7 @@
 #include "ring_buffer.h"
 #include "vis.h"
 #include "aggregation.h"
+#include "unicast.h"
 
 static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
@@ -1105,43 +1106,43 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 	return router;
 }
 
-int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
+static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 {
-	struct unicast_packet *unicast_packet;
-	struct orig_node *orig_node;
-	struct neigh_node *router;
 	struct ethhdr *ethhdr;
-	struct batman_if *batman_if;
-	struct sk_buff *skb_old;
-	uint8_t dstaddr[ETH_ALEN];
-	int hdr_size = sizeof(struct unicast_packet);
-	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
 	if (skb_headlen(skb) < hdr_size)
-		return NET_RX_DROP;
+		return -1;
 
 	ethhdr = (struct ethhdr *) skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_bcast(ethhdr->h_dest))
-		return NET_RX_DROP;
+		return -1;
 
 	/* packet with broadcast sender address */
 	if (is_bcast(ethhdr->h_source))
-		return NET_RX_DROP;
+		return -1;
 
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return NET_RX_DROP;
+		return -1;
 
-	unicast_packet = (struct unicast_packet *) skb->data;
+	return 0;
+}
 
-	/* packet for me */
-	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(skb, hdr_size);
-		return NET_RX_SUCCESS;
-	}
+static int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+		int hdr_size)
+{
+	struct orig_node *orig_node;
+	struct neigh_node *router;
+	struct batman_if *batman_if;
+	struct sk_buff *skb_old;
+	uint8_t dstaddr[ETH_ALEN];
+	unsigned long flags;
+	struct unicast_packet *unicast_packet =
+		(struct unicast_packet *) skb->data;
+	struct ethhdr *ethhdr = (struct ethhdr *) skb_mac_header(skb);
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
@@ -1172,7 +1173,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 	/* create a copy of the skb, if needed, to modify it. */
-	if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
+	if (!skb_clone_writable(skb, hdr_size)) {
 		skb_old = skb;
 		skb = skb_copy(skb, GFP_ATOMIC);
 		if (!skb)
@@ -1191,6 +1192,80 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	return NET_RX_SUCCESS;
 }
 
+int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
+{
+	struct unicast_packet *unicast_packet;
+	int hdr_size = sizeof(struct unicast_packet);
+
+	if (check_unicast_packet(skb, hdr_size) < 0)
+		return NET_RX_DROP;
+
+	unicast_packet = (struct unicast_packet *) skb->data;
+
+	/* packet for me */
+	if (is_my_mac(unicast_packet->dest)) {
+		interface_rx(skb, hdr_size);
+		return NET_RX_SUCCESS;
+	}
+
+	return route_unicast_packet(skb, recv_if, hdr_size);
+}
+
+int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
+{
+	struct unicast_frag_packet *unicast_packet;
+	struct orig_node *orig_node;
+	struct frag_packet_list_entry *tmp_frag_entry;
+	int hdr_size = sizeof(struct unicast_frag_packet);
+	unsigned long flags;
+
+	if (check_unicast_packet(skb, hdr_size) < 0)
+		return NET_RX_DROP;
+
+	unicast_packet = (struct unicast_frag_packet *) skb->data;
+
+	/* packet for me */
+	if (is_my_mac(unicast_packet->dest)) {
+
+		spin_lock_irqsave(&orig_hash_lock, flags);
+		orig_node = ((struct orig_node *)
+			hash_find(orig_hash, unicast_packet->orig));
+
+		if (!orig_node) {
+			pr_warning("couldn't find orig node for "
+				"fragmentation\n");
+			spin_unlock_irqrestore(&orig_hash_lock, flags);
+			return NET_RX_DROP;
+		}
+
+		orig_node->last_frag_packet = jiffies;
+
+		if (list_empty(&orig_node->frag_list))
+			create_frag_buffer(&orig_node->frag_list);
+
+		tmp_frag_entry =
+			search_frag_packet(&orig_node->frag_list,
+			unicast_packet);
+
+		if (!tmp_frag_entry) {
+			create_frag_entry(&orig_node->frag_list, skb);
+			spin_unlock_irqrestore(&orig_hash_lock, flags);
+			return NET_RX_SUCCESS;
+		}
+
+		skb = merge_frag_packet(&orig_node->frag_list,
+			tmp_frag_entry, skb);
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		if (!skb)
+			return NET_RX_DROP;
+
+		interface_rx(skb, hdr_size);
+		return NET_RX_SUCCESS;
+	}
+
+	return route_unicast_packet(skb, recv_if, hdr_size);
+}
+
 int recv_bcast_packet(struct sk_buff *skb)
 {
 	struct orig_node *orig_node;
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index 3eac64e..81c684f 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -34,6 +34,7 @@ void update_routes(struct orig_node *orig_node,
 				unsigned char *hna_buff, int hna_buff_len);
 int recv_icmp_packet(struct sk_buff *skb);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb);
 int recv_vis_packet(struct sk_buff *skb);
 int recv_bat_packet(struct sk_buff *skb,
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 315fdeb..d60b1a8 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -249,7 +249,9 @@ void interface_setup(struct net_device *dev)
 #endif
 	dev->destructor = free_netdev;
 
-	dev->mtu = hardif_min_mtu();
+	dev->mtu = ETH_DATA_LEN;	/* can't call min_mtu, because the
+					 * needed variables have not been
+					 * initialized yet */
 	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
 						* skbuff for our header */
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 67bf4db..ac16575 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -41,6 +41,7 @@ struct batman_if {
 	char addr_str[ETH_STR_LEN];
 	struct net_device *net_dev;
 	atomic_t seqno;
+	atomic_t frag_seqno;
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
@@ -81,6 +82,8 @@ struct orig_node {
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
+	struct list_head frag_list;
+	unsigned long last_frag_packet;
 	struct {
 		uint8_t candidates;
 		struct neigh_node *selected;
@@ -110,6 +113,7 @@ struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
 	atomic_t bonding_enabled;
+	atomic_t frag_enabled;
 	atomic_t vis_mode;
 	atomic_t orig_interval;
 	atomic_t log_level;
@@ -183,4 +187,10 @@ struct debug_log {
 	wait_queue_head_t queue_wait;
 };
 
+struct frag_packet_list_entry {
+	struct list_head list;
+	uint16_t seqno;
+	struct sk_buff *skb;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 27c4abb..153914e 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -28,6 +28,177 @@
 #include "routing.h"
 #include "hard-interface.h"
 
+
+struct sk_buff *merge_frag_packet(struct list_head *head,
+				  struct frag_packet_list_entry *tfp,
+				  struct sk_buff *skb)
+{
+	struct unicast_frag_packet *up =
+		(struct unicast_frag_packet *) skb->data;
+	struct sk_buff *tmp_skb;
+
+	/* set skb to the first part and tmp_skb to the second part */
+	if (up->flags & UNI_FRAG_HEAD) {
+		tmp_skb = tfp->skb;
+	} else {
+		tmp_skb = skb;
+		skb = tfp->skb;
+	}
+
+	skb_pull(tmp_skb, sizeof(struct unicast_frag_packet));
+	if (pskb_expand_head(skb, 0, tmp_skb->len, GFP_ATOMIC) < 0) {
+		/* free buffered skb, skb will be freed later */
+		kfree_skb(tfp->skb);
+		return NULL;
+	}
+
+	/* move free entry to end */
+	tfp->skb = NULL;
+	tfp->seqno = 0;
+	list_move_tail(&tfp->list, head);
+
+	memcpy(skb_put(skb, tmp_skb->len), tmp_skb->data, tmp_skb->len);
+	kfree_skb(tmp_skb);
+	return skb;
+}
+
+void create_frag_entry(struct list_head *head, struct sk_buff *skb)
+{
+	struct frag_packet_list_entry *tfp;
+	struct unicast_frag_packet *up =
+		(struct unicast_frag_packet *) skb->data;
+
+	/* free and oldest packets stand at the end */
+	tfp = list_entry((head)->prev, typeof(*tfp), list);
+	kfree_skb(tfp->skb);
+
+	tfp->seqno = ntohs(up->seqno);
+	tfp->skb = skb;
+	list_move(&tfp->list, head);
+	return;
+}
+
+void create_frag_buffer(struct list_head *head)
+{
+	int i;
+	struct frag_packet_list_entry *tfp;
+
+	for (i = 0; i < FRAG_BUFFER_SIZE; i++) {
+		tfp = kmalloc(sizeof(struct frag_packet_list_entry),
+			GFP_ATOMIC);
+		tfp->skb = NULL;
+		tfp->seqno = 0;
+		INIT_LIST_HEAD(&tfp->list);
+		list_add(&tfp->list, head);
+	}
+
+	return;
+}
+
+struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+						 struct unicast_frag_packet *up)
+{
+	struct frag_packet_list_entry *tfp;
+	struct unicast_frag_packet *tmp_up = NULL;
+	uint16_t search_seqno;
+
+	if (up->flags & UNI_FRAG_HEAD)
+		search_seqno = ntohs(up->seqno)+1;
+	else
+		search_seqno = ntohs(up->seqno)-1;
+
+	list_for_each_entry(tfp, head, list) {
+
+		if (!tfp->skb)
+			continue;
+
+		if (tfp->seqno == ntohs(up->seqno))
+			goto mov_tail;
+
+		tmp_up = (struct unicast_frag_packet *) tfp->skb->data;
+
+		if (tfp->seqno == search_seqno) {
+
+			if ((tmp_up->flags & UNI_FRAG_HEAD) !=
+			    (up->flags & UNI_FRAG_HEAD))
+				return tfp;
+			else
+				goto mov_tail;
+		}
+	}
+	return NULL;
+
+mov_tail:
+	list_move_tail(&tfp->list, head);
+	return NULL;
+}
+
+void frag_list_free(struct list_head *head)
+{
+	struct frag_packet_list_entry *pf, *tmp_pf;
+
+	if (!list_empty(head)) {
+
+		list_for_each_entry_safe(pf, tmp_pf, head, list) {
+			kfree_skb(pf->skb);
+			list_del(&pf->list);
+			kfree(pf);
+		}
+	}
+	return;
+}
+
+static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			  struct batman_if *batman_if, uint8_t dstaddr[],
+			  struct orig_node *orig_node)
+{
+	struct unicast_frag_packet *ucast_frag1, *ucast_frag2;
+	int hdr_len = sizeof(struct unicast_frag_packet);
+	struct sk_buff *frag_skb;
+	int data_len = skb->len;
+
+	if (!bat_priv->primary_if)
+		goto dropped;
+
+	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + hdr_len);
+	skb_split(skb, frag_skb, data_len / 2);
+
+	if (my_skb_push(frag_skb, hdr_len) < 0 ||
+	    my_skb_push(skb, hdr_len) < 0)
+		goto drop_frag;
+
+	ucast_frag1 = (struct unicast_frag_packet *)skb->data;
+	ucast_frag2 = (struct unicast_frag_packet *)frag_skb->data;
+
+	ucast_frag1->version = COMPAT_VERSION;
+	ucast_frag1->packet_type = BAT_UNICAST_FRAG;
+	ucast_frag1->ttl = TTL;
+	memcpy(ucast_frag1->orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(ucast_frag1->dest, orig_node->orig, ETH_ALEN);
+
+	memcpy(ucast_frag2, ucast_frag1, sizeof(struct unicast_frag_packet));
+
+	ucast_frag1->flags |= UNI_FRAG_HEAD;
+	ucast_frag2->flags &= ~UNI_FRAG_HEAD;
+
+	ucast_frag1->seqno = htons((uint16_t)atomic_inc_return(
+						&batman_if->frag_seqno));
+
+	ucast_frag2->seqno = htons((uint16_t)atomic_inc_return(
+						&batman_if->frag_seqno));
+
+	send_skb_packet(skb, batman_if, dstaddr);
+	send_skb_packet(frag_skb, batman_if, dstaddr);
+	return 0;
+
+drop_frag:
+	kfree_skb(frag_skb);
+dropped:
+	kfree_skb(skb);
+	return 1;
+}
+
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
@@ -35,6 +206,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
 	struct neigh_node *router;
+	int data_len = skb->len;
 	uint8_t dstaddr[6];
 	unsigned long flags;
 
@@ -63,6 +235,11 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dropped;
 
+	if (atomic_read(&bat_priv->frag_enabled) &&
+	    data_len + sizeof(struct unicast_packet) > batman_if->net_dev->mtu)
+		return unicast_send_frag_skb(skb, bat_priv, batman_if,
+					     dstaddr, orig_node);
+
 	if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto dropped;
 
diff --git a/drivers/staging/batman-adv/unicast.h b/drivers/staging/batman-adv/unicast.h
index dd00703..1d5cbeb 100644
--- a/drivers/staging/batman-adv/unicast.h
+++ b/drivers/staging/batman-adv/unicast.h
@@ -22,6 +22,18 @@
 #ifndef _NET_BATMAN_ADV_UNICAST_H_
 #define _NET_BATMAN_ADV_UNICAST_H_
 
+#define FRAG_TIMEOUT 10000	/* purge frag list entrys after time in ms */
+#define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
+
+struct sk_buff *merge_frag_packet(struct list_head *head,
+	struct frag_packet_list_entry *tfp,
+	struct sk_buff *skb);
+
+void create_frag_entry(struct list_head *head, struct sk_buff *skb);
+void create_frag_buffer(struct list_head *head);
+struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+	struct unicast_frag_packet *up);
+void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.1

