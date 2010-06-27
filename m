Return-Path: <an.langer@gmx.de>
Date: Sun, 27 Jun 2010 17:24:16 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100627172416.62e7554d@rechenknecht>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] PATCH fragmentation of unicast packets
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

If fragmentation is on, the mtu of the bat interface will be set to 1500 and bigger packets will be
splitted in two parts. The receiver stores the packets in a buffer list for each originator, which
will be created with the first fragmented packet. For this handling i added a sequenznumber and the
orig address to the unicast_packet definition.

regards,
Andreas

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batman-adv/Makefile.kbuild  |    2 +-
 batman-adv/bat_sysfs.c      |   55 ++++++++++++++++
 batman-adv/fragmentation.c  |  148 +++++++++++++++++++++++++++++++++++++++++++
 batman-adv/fragmentation.h  |   34 ++++++++++
 batman-adv/hard-interface.c |   15 ++++-
 batman-adv/originator.c     |   13 ++++
 batman-adv/packet.h         |    7 ++
 batman-adv/routing.c        |   35 ++++++++++
 batman-adv/soft-interface.c |   88 ++++++++++++++++++++++----
 batman-adv/types.h          |    9 +++
 10 files changed, 390 insertions(+), 16 deletions(-)
 create mode 100644 batman-adv/fragmentation.c
 create mode 100644 batman-adv/fragmentation.h

diff --git a/batman-adv/Makefile.kbuild b/batman-adv/Makefile.kbuild
index 762ee4e..3e99ba5 100644
--- a/batman-adv/Makefile.kbuild
+++ b/batman-adv/Makefile.kbuild
@@ -32,4 +32,4 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o
icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o
aggregation.o originator.o gateway_common.o gateway_client.o $(shell [ "2" -eq "$(VERSION)" ] 2>&-
&& [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-objs := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o
icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o
aggregation.o originator.o gateway_common.o gateway_client.o fragmentation.o $(shell [ "2" -eq
"$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo
bat_printk.o) diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c index 68ce453..74d388a
100644 --- a/batman-adv/bat_sysfs.c +++ b/batman-adv/bat_sysfs.c @@ -136,6 +136,58 @@ static
ssize_t store_bond(struct kobject *kobj, struct attribute *attr, return count; } +static ssize_t
show_frag(struct kobject *kobj, struct attribute *attr,
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
+		printk(KERN_ERR "batman-adv:Invalid parameter for 'frag' setting on mesh %s
received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->frag_enabled) == frag_enabled_tmp)
+		return count;
+
+	printk(KERN_INFO "batman-adv:Changing frag from: %s to: %s on mesh: %s\n",
+	       atomic_read(&bat_priv->frag_enabled) == 1 ?
+	       "enabled" : "disabled",
+	       frag_enabled_tmp == 1 ? "enabled" : "disabled",
+	       net_dev->name);
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
@@ -279,6 +331,7 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 static BAT_ATTR(aggregated_ogms, S_IRUGO | S_IWUSR,
 		show_aggr_ogms, store_aggr_ogms);
 static BAT_ATTR(bonding, S_IRUGO | S_IWUSR, show_bond, store_bond);
+static BAT_ATTR(fragmentation, S_IRUGO | S_IWUSR, show_frag, store_frag);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
@@ -287,6 +340,7 @@ static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
+	&bat_attr_fragmentation,
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
@@ -304,6 +358,7 @@ int sysfs_add_meshif(struct net_device *dev)
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
 	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->frag_enabled, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_class, 0);
diff --git a/batman-adv/fragmentation.c b/batman-adv/fragmentation.c
new file mode 100644
index 0000000..a0513da
--- /dev/null
+++ b/batman-adv/fragmentation.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
+ *
+ * Andreas Langer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+#include "main.h"
+#include "fragmentation.h"
+
+
+struct sk_buff *merge_frag_packet(struct list_head *head,
+	struct frag_packet_list_entry *tfp,
+	struct sk_buff *skb) {
+
+	struct unicast_packet *up = (struct unicast_packet *) skb->data;
+	struct sk_buff *tmp_skb;
+
+	/* skb is alsways the first packet,tmp_skb always the second */
+	if (up->flags & UNI_FRAG_HEAD) {
+		tmp_skb = tfp->skb;
+	} else {
+		tmp_skb = skb;
+		skb = tfp->skb;
+	}
+
+	/* move free entry to end */
+	tfp->skb = NULL;
+	tfp->seqno = 0;
+	list_move_tail(&tfp->list, head);
+
+	skb_pull(tmp_skb, sizeof(struct unicast_packet));
+	pskb_expand_head(skb, 0, tmp_skb->len, GFP_ATOMIC);
+	memcpy(skb_put(skb, tmp_skb->len), tmp_skb->data, tmp_skb->len);
+	kfree_skb(tmp_skb);
+	return skb;
+}
+
+void create_frag_entry(struct list_head *head, struct sk_buff *skb)
+{
+	struct frag_packet_list_entry *tfp;
+	struct unicast_packet *up = (struct unicast_packet *) skb->data;
+
+	/* free and oldest packets stand at the end */
+	tfp = list_entry((head)->prev, typeof(*tfp), list);
+
+	if (tfp->skb)
+		kfree_skb(tfp->skb);
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
+	struct unicast_packet *up) {
+
+	struct frag_packet_list_entry *tfp;
+	struct unicast_packet *tmp_up = NULL;
+	uint16_t tmp_seq;
+
+	list_for_each_entry(tfp, head, list) {
+
+		if (tfp->seqno == ntohs(up->seqno))
+			goto mov_tail;
+
+		if (tfp->skb)
+			tmp_up = (struct unicast_packet *) tfp->skb->data;
+
+		if (up->flags & UNI_FRAG_HEAD) {
+			tmp_seq = ntohs(up->seqno) ==
+				FRAG_MAX_SEQ ? 1 : ntohs(up->seqno)+1;
+
+			if (tfp->seqno == tmp_seq) {
+				if (tmp_up->flags & UNI_FRAG_HEAD)
+					goto mov_tail;
+				else
+					goto ret_tfp;
+			}
+		} else {
+			tmp_seq = ntohs(up->seqno) ==
+				1 ? FRAG_MAX_SEQ : ntohs(up->seqno)-1;
+
+			if (tfp->seqno == tmp_seq) {
+				if (tmp_up->flags & UNI_FRAG_HEAD)
+					goto ret_tfp;
+				else
+					goto mov_tail;
+			}
+		}
+	}
+	goto ret_null;
+
+ret_tfp:
+	return tfp;
+mov_tail:
+	list_move_tail(&tfp->list, head);
+ret_null:
+	return NULL;
+}
+
+void frag_list_free(struct list_head *head)
+{
+
+	struct frag_packet_list_entry *pf, *tmp_pf;
+
+	if (!list_empty(head)) {
+
+		list_for_each_entry_safe(pf, tmp_pf, head, list) {
+			if (pf->skb)
+				kfree_skb(pf->skb);
+			list_del(&pf->list);
+			kfree(pf);
+		}
+	}
+	return;
+}
diff --git a/batman-adv/fragmentation.h b/batman-adv/fragmentation.h
new file mode 100644
index 0000000..36afb7b
--- /dev/null
+++ b/batman-adv/fragmentation.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
+ *
+ * Andreas Langer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#define FRAG_TIMEOUT 60000	/* purge frag list entrys after time in ms */
+#define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
+#define FRAG_MAX_SEQ 65535
+
+extern struct sk_buff *merge_frag_packet(struct list_head *head,
+	struct frag_packet_list_entry *tfp,
+	struct sk_buff *skb);
+
+extern void create_frag_entry(struct list_head *head, struct sk_buff *skb);
+extern void create_frag_buffer(struct list_head *head);
+extern struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+	struct unicast_packet *up);
+extern void frag_list_free(struct list_head *head);
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 0773420..7f07baa 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -168,13 +168,20 @@ int hardif_min_mtu(void)
 	/* allow big frames if all devices are capable to do so
 	 * (have MTU > 1500 + BAT_HEADER_LEN) */
 	int min_mtu = ETH_DATA_LEN;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if ((batman_if->if_status == IF_ACTIVE) ||
-		    (batman_if->if_status == IF_TO_BE_ACTIVATED))
-			min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
-				      min_mtu);
+		    (batman_if->if_status == IF_TO_BE_ACTIVATED)) {
+
+			if (atomic_read(&bat_priv->frag_enabled))
+				min_mtu = MIN(batman_if->net_dev->mtu, min_mtu);
+			else
+				min_mtu = MIN(batman_if->net_dev->mtu -
+					BAT_HEADER_LEN, min_mtu);
+		}
 	}
 	rcu_read_unlock();
 
@@ -189,6 +196,7 @@ void update_min_mtu(void)
 	min_mtu = hardif_min_mtu();
 	if (soft_device->mtu != min_mtu)
 		soft_device->mtu = min_mtu;
+
 }
 
 static void hardif_activate_interface(struct bat_priv *bat_priv,
@@ -268,6 +276,7 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
 	atomic_set(&batman_if->seqno, 1);
+	atomic_set(&batman_if->frag_seqno, 1);
 	printk(KERN_INFO "batman-adv:Adding interface: %s\n", batman_if->dev);
 
 	if (hardif_is_iface_up(batman_if))
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index d276afd..87c3dc9 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -29,6 +29,7 @@
 #include "compat.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
+#include "fragmentation.h"
 
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
@@ -58,6 +59,7 @@ err:
 	return 0;
 }
 
+
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming)
@@ -94,6 +96,7 @@ static void free_orig_node(void *data)
 		kfree(neigh_node);
 	}
 
+	frag_list_free(&orig_node->frag_list);
 	hna_global_del_orig(orig_node, "originator timed out");
 
 	kfree(orig_node->bcast_own);
@@ -155,6 +158,10 @@ struct orig_node *get_orig_node(uint8_t *addr)
 
 	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
+
+	INIT_LIST_HEAD(&orig_node->frag_list);
+	orig_node->last_frag_packet = 0;
+
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
@@ -269,6 +276,12 @@ void purge_orig(struct work_struct *work)
 			hash_remove_bucket(orig_hash, &hashit);
 			free_orig_node(orig_node);
 		}
+
+		if (time_after(jiffies, (orig_node->last_frag_packet +
+			msecs_to_jiffies(FRAG_TIMEOUT))))
+			frag_list_free(&orig_node->frag_list);
+
+
 	}
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
diff --git a/batman-adv/packet.h b/batman-adv/packet.h
index e94960d..65c1771 100644
--- a/batman-adv/packet.h
+++ b/batman-adv/packet.h
@@ -47,6 +47,10 @@
 #define VIS_TYPE_SERVER_SYNC		0
 #define VIS_TYPE_CLIENT_UPDATE		1
 
+/* fragmentation defines */
+#define UNI_IS_FRAG 0x01
+#define UNI_FRAG_HEAD 0x02
+
 struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
@@ -95,7 +99,10 @@ struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  dest[6];
+	uint8_t  orig[6];
 	uint8_t  ttl;
+	uint8_t  flags;
+	uint16_t seqno;
 } __attribute__((packed));
 
 struct bcast_packet {
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a37c288..5de6197 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -34,6 +34,7 @@
 #include "aggregation.h"
 #include "compat.h"
 #include "gateway_client.h"
+#include "fragmentation.h"
 
 static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
@@ -1100,6 +1101,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
 	struct sk_buff *skb_old;
+	struct frag_packet_list_entry *tmp_frag_entry;
 	uint8_t dstaddr[ETH_ALEN];
 	int hdr_size = sizeof(struct unicast_packet);
 	unsigned long flags;
@@ -1126,6 +1128,39 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
+
+		/* check if unicast packet fragmented */
+
+		if (unicast_packet->flags & UNI_IS_FRAG) {
+
+			/* TODO: spinlock ??? */
+			orig_node = ((struct orig_node *)
+				hash_find(orig_hash, unicast_packet->orig));
+
+			if (!orig_node) {
+				printk(KERN_WARNING
+					"frag: couldn't find orig node\n");
+				return NET_RX_DROP;
+			}
+
+			orig_node->last_frag_packet = jiffies;
+
+			if (list_empty(&orig_node->frag_list))
+				create_frag_buffer(&orig_node->frag_list);
+
+			tmp_frag_entry =
+				search_frag_packet(&orig_node->frag_list,
+				unicast_packet);
+
+			if (!tmp_frag_entry) {
+				create_frag_entry(&orig_node->frag_list, skb);
+				return NET_RX_SUCCESS;
+			}
+
+			skb = merge_frag_packet(&orig_node->frag_list,
+				tmp_frag_entry, skb);
+		}
+
 		interface_rx(skb, hdr_size);
 		return NET_RX_SUCCESS;
 	}
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 0d89597..96cdba9 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -32,6 +32,7 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include "compat.h"
+#include "fragmentation.h"
 
 static uint32_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 				  * broadcast storms */
@@ -130,6 +131,7 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 int interface_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct unicast_packet *unicast_packet;
+	struct unicast_packet *unicast_packet_frag;
 	struct bcast_packet *bcast_packet;
 	struct orig_node *orig_node;
 	struct neigh_node *router;
@@ -137,9 +139,11 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	struct bat_priv *priv = netdev_priv(dev);
 	struct batman_if *batman_if;
 	struct bat_priv *bat_priv;
+	struct sk_buff *frag_skb;
 	uint8_t dstaddr[6];
 	int data_len = skb->len;
 	unsigned long flags;
+	int hdr_len;
 	bool bcast_dst = false, do_bcast = true;
 
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
@@ -216,20 +220,80 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		if (batman_if->if_status != IF_ACTIVE)
 			goto dropped;
 
-		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
-			goto dropped;
+		if (atomic_read(&bat_priv->frag_enabled) &&
+		   data_len > dev->mtu) {
+
+			hdr_len = sizeof(struct unicast_packet);
+
+			frag_skb = dev_alloc_skb(data_len / 2 + hdr_len + 1);
+			skb_split(skb, frag_skb, data_len/2);
+
+			if (!(my_skb_push(frag_skb, hdr_len) >= 0 &&
+				my_skb_push(skb, hdr_len) >= 0)) {
+
+				kfree_skb(frag_skb);
+				goto dropped;
+			}
+
+			unicast_packet = (struct unicast_packet *)skb->data;
+			unicast_packet_frag =
+				(struct unicast_packet *)frag_skb->data;
+
+			unicast_packet->version = COMPAT_VERSION;
+			unicast_packet->packet_type = BAT_UNICAST;
+			unicast_packet->ttl = TTL;
+			unicast_packet->flags |= UNI_IS_FRAG;
+			memcpy(unicast_packet->orig,
+				batman_if->net_dev->dev_addr, ETH_ALEN);
+			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+
+			memcpy(unicast_packet_frag, unicast_packet,
+			       sizeof(struct unicast_packet));
+
+			unicast_packet->flags |= UNI_FRAG_HEAD;
+			unicast_packet_frag->flags &= ~UNI_FRAG_HEAD;
 
-		unicast_packet = (struct unicast_packet *)skb->data;
+			/* no zero at seqno */
+			if (atomic_read(&batman_if->frag_seqno) == FRAG_MAX_SEQ)
+				atomic_set(&batman_if->frag_seqno, 0);
 
-		unicast_packet->version = COMPAT_VERSION;
-		/* batman packet type: unicast */
-		unicast_packet->packet_type = BAT_UNICAST;
-		/* set unicast ttl */
-		unicast_packet->ttl = TTL;
-		/* copy the destination for faster routing */
-		memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+			unicast_packet->seqno =
+				htons((uint16_t)atomic_inc_return(
+				&batman_if->frag_seqno));
 
-		send_skb_packet(skb, batman_if, dstaddr);
+			if (atomic_read(&batman_if->frag_seqno) == FRAG_MAX_SEQ)
+				atomic_set(&batman_if->frag_seqno, 0);
+
+			unicast_packet_frag->seqno =
+				htons((uint16_t)atomic_inc_return(
+				&batman_if->frag_seqno));
+
+			send_skb_packet(skb, batman_if, dstaddr);
+			send_skb_packet(frag_skb, batman_if, dstaddr);
+
+		} else {
+
+			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
+				goto dropped;
+
+			unicast_packet = (struct unicast_packet *)skb->data;
+
+			unicast_packet->version = COMPAT_VERSION;
+			/* batman packet type: unicast */
+			unicast_packet->packet_type = BAT_UNICAST;
+			/* set unicast ttl */
+			unicast_packet->ttl = TTL;
+			/* set fragmentation */
+			unicast_packet->flags &= ~UNI_IS_FRAG;
+			/* copy the destination for faster routing */
+			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+			memcpy(unicast_packet->orig,
+				batman_if->net_dev->dev_addr, ETH_ALEN);
+
+			unicast_packet->seqno = 0;
+
+			send_skb_packet(skb, batman_if, dstaddr);
+		}
 	}
 
 	priv->stats.tx_packets++;
@@ -370,4 +434,4 @@ static u32 bat_get_rx_csum(struct net_device *dev)
 static int bat_set_rx_csum(struct net_device *dev, u32 data)
 {
 	return -EOPNOTSUPP;
-}
+}
\ No newline at end of file
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1daebed..0539515 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -43,6 +43,7 @@ struct batman_if {
 	char addr_str[ETH_STR_LEN];
 	struct net_device *net_dev;
 	atomic_t seqno;
+	atomic_t frag_seqno;
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
@@ -84,6 +85,8 @@ struct orig_node {
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
+	struct list_head frag_list;
+	unsigned long last_frag_packet;
 	struct {
 		uint8_t candidates;
 		struct neigh_node *selected;
@@ -120,6 +123,7 @@ struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
 	atomic_t bonding_enabled;
+	atomic_t frag_enabled;
 	atomic_t vis_mode;
 	atomic_t gw_mode;
 	atomic_t gw_class;
@@ -184,4 +188,9 @@ struct if_list_entry {
 	struct hlist_node list;
 };
 
+struct frag_packet_list_entry {
+	struct list_head list;
+	uint16_t seqno;
+	struct sk_buff *skb;
+};
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.0.4
