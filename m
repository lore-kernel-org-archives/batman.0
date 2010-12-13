Return-Path: <clang@gateworks.com>
From: Chris Lang <clang@gateworks.com>
Content-Type: text/plain
Date: Mon, 13 Dec 2010 00:25:05 -0800
Message-Id: <1292228705.21378.13.camel@chris-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Alternative Multicast Optimizations
Reply-To: clang@gateworks.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

All,

I have the alternative multicast patchset here. I needed to strip the rest of the patches I had in for my own use thus this patchset is only compile tested.
However, the patches should work as the actual structure hasn't changed.

There are 2 additional items that I have in here, one is that the HNA's are sent over the multicast structure to reduce the HNA overhead. This is just an idea, but I have also tested this and it works as well.
The second one is the allowance of bcast packets to transmit over the mcast tree to also optimize bcast packets. This is untested, but in theory should work.

These patches are based on r1828, which I know is old, but this patchset is just to show the idea and prove it working.

Currently, the known issues are that the "discovery" packets can't currently handle fragmentation (which I have an idea on how to handle), so the maximum number of supported nodes would be 235, also this implementation does not consider groups.

Thanks,

- Chris Lang


diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batctl/packet.h batman-adv-devel/batctl/packet.h
--- batman-adv-devel_r1828.clean/batctl/packet.h	2010-09-12 14:35:20.000000000 -0700
+++ batman-adv-devel/batctl/packet.h	2010-12-12 23:19:00.000000000 -0800
@@ -27,9 +27,11 @@
 #define BAT_PACKET       0x01
 #define BAT_ICMP         0x02
 #define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
 #define BAT_VIS          0x05
 #define BAT_UNICAST_FRAG 0x06
+#define BAT_MCAST        0x07
+#define BAT_MCAST_DISC   0x08
+#define BAT_HNA          0x09
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 12
@@ -112,7 +114,7 @@
 	uint16_t seqno;
 } __attribute__((packed));
 
-struct bcast_packet {
+struct mcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  orig[6];
@@ -133,4 +135,13 @@
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __attribute__((packed));
 
+struct mcastd_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  orig[6];
+	uint32_t seqno;
+	uint8_t  ttl;
+	uint8_t  num_dest;
+} __attribute__((packed));
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/hard-interface.c batman-adv-devel/batman-adv/hard-interface.c
--- batman-adv-devel_r1828.clean/batman-adv/hard-interface.c	2010-10-12 02:47:48.000000000 -0700
+++ batman-adv-devel/batman-adv/hard-interface.c	2010-12-12 23:27:42.000000000 -0800
@@ -28,6 +28,7 @@
 #include "bat_sysfs.h"
 #include "originator.h"
 #include "hash.h"
+#include "multicast.h"
 
 #include <linux/if_arp.h>
 
@@ -158,7 +159,7 @@
 	 * hacky trick to make sure that we send the HNA information via
 	 * our new primary interface
 	 */
-	atomic_set(&bat_priv->hna_local_changed, 1);
+	send_hna_packet(bat_priv);
 }
 
 static bool hardif_is_iface_up(struct batman_if *batman_if)
@@ -612,9 +613,17 @@
 		ret = recv_ucast_frag_packet(skb, batman_if);
 		break;
 
-		/* broadcast packet */
-	case BAT_BCAST:
-		ret = recv_bcast_packet(skb, batman_if);
+		/* multicast/broadcast packets */
+	case BAT_MCAST:
+		ret = recv_mcast_packet(skb, batman_if);        
+		break;
+
+	case BAT_MCAST_DISC:
+		ret = recv_mcastd_packet(skb, batman_if);        
+		break;
+
+	case BAT_HNA:
+		ret = recv_mcast_packet(skb, batman_if);        
 		break;
 
 		/* vis packet */
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/main.c batman-adv-devel/batman-adv/main.c
--- batman-adv-devel_r1828.clean/batman-adv/main.c	2010-10-09 04:39:24.000000000 -0700
+++ batman-adv-devel/batman-adv/main.c	2010-12-12 23:28:00.000000000 -0800
@@ -83,7 +83,6 @@
 
 	spin_lock_init(&bat_priv->orig_hash_lock);
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
-	spin_lock_init(&bat_priv->forw_bcast_list_lock);
 	spin_lock_init(&bat_priv->hna_lhash_lock);
 	spin_lock_init(&bat_priv->hna_ghash_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
@@ -92,7 +91,6 @@
 	spin_lock_init(&bat_priv->softif_neigh_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
-	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
 	INIT_HLIST_HEAD(&bat_priv->gw_list);
 	INIT_HLIST_HEAD(&bat_priv->softif_neigh_list);
 
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/main.h batman-adv-devel/batman-adv/main.h
--- batman-adv-devel_r1828.clean/batman-adv/main.h	2010-10-09 04:39:24.000000000 -0700
+++ batman-adv-devel/batman-adv/main.h	2010-12-12 23:28:21.000000000 -0800
@@ -82,7 +82,6 @@
 #define MESH_ACTIVE 1
 #define MESH_DEACTIVATING 2
 
-#define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
 
 /*
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/Makefile batman-adv-devel/batman-adv/Makefile
--- batman-adv-devel_r1828.clean/batman-adv/Makefile	2010-10-17 15:41:40.000000000 -0700
+++ batman-adv-devel/batman-adv/Makefile	2010-12-12 23:37:07.000000000 -0800
@@ -32,4 +32,4 @@
 endif
 
 obj-m += batman-adv.o
-batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o multicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/Makefile.kbuild batman-adv-devel/batman-adv/Makefile.kbuild
--- batman-adv-devel_r1828.clean/batman-adv/Makefile.kbuild	2010-10-12 03:08:29.000000000 -0700
+++ batman-adv-devel/batman-adv/Makefile.kbuild	2010-12-12 23:02:09.000000000 -0800
@@ -32,4 +32,4 @@
 endif
 
 obj-m += batman-adv.o
-batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o multicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/multicast.c batman-adv-devel/batman-adv/multicast.c
--- batman-adv-devel_r1828.clean/batman-adv/multicast.c	1969-12-31 16:00:00.000000000 -0800
+++ batman-adv-devel/batman-adv/multicast.c	2010-12-12 23:37:04.000000000 -0800
@@ -0,0 +1,630 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
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
+#include "main.h"
+#include "multicast.h"
+#include "send.h"
+#include "soft-interface.h"
+#include "gateway_client.h"
+#include "hash.h"
+#include "translation-table.h"
+#include "routing.h"
+#include "hard-interface.h"
+
+static void free_mcast_dest(void *data, void *arg)
+{
+	struct mcast_dest_entry *mcast_dest_entry = 
+		(struct mcast_dest_entry *)data;
+	kfree(mcast_dest_entry);
+}
+
+void free_mcast_router(void *data, void *arg)
+{
+	struct mcast_router_entry *mcast_router_entry = 
+		(struct mcast_router_entry *)data;
+	struct bat_priv *bat_priv = (struct bat_priv *)arg;
+	if (mcast_router_entry->mcast_dest_hash)
+		hash_delete(mcast_router_entry->mcast_dest_hash, 
+			    free_mcast_dest, bat_priv);
+	kfree(mcast_router_entry);
+}
+
+void send_hna_packet(struct bat_priv *bat_priv)
+{
+	struct sk_buff *skb;
+	unsigned char *skb_buff;
+	struct mcast_packet *mcast_packet;
+	uint16_t *num_hna;
+
+	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
+		return;
+
+	if (!bat_priv->num_local_hna)
+		return;
+
+	if (!bat_priv->primary_if)
+		return;
+
+	skb = dev_alloc_skb((bat_priv->num_local_hna * ETH_ALEN) +
+		sizeof(struct mcast_packet) + sizeof(struct ethhdr) + 2);
+
+	if (!skb)
+		return;
+
+	skb_reserve(skb, sizeof(struct ethhdr));
+	
+	skb_buff = skb_put(skb, sizeof(struct mcast_packet) + 
+		(bat_priv->num_local_hna * ETH_ALEN) + 2);
+	mcast_packet = (struct mcast_packet *)skb->data;
+	num_hna = (uint16_t *)((void *)skb->data + sizeof(struct mcast_packet));
+	mcast_packet->version = COMPAT_VERSION;
+	mcast_packet->ttl = TTL;
+	mcast_packet->packet_type = BAT_HNA;
+	memcpy(mcast_packet->orig,
+		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	/* set broadcast sequence number */
+	mcast_packet->seqno =
+		htonl(atomic_inc_return(&bat_priv->mcast_seqno));
+	*num_hna = hna_local_fill_buffer(bat_priv,
+			(void *)((void *)skb->data + 
+			sizeof(struct mcast_packet) + 2),
+			bat_priv->num_local_hna * ETH_ALEN);
+
+	send_mcast_packet(bat_priv, skb, NULL);
+	bat_priv->hna_timer = jiffies + msecs_to_jiffies(5000);
+	kfree_skb(skb);
+}
+
+void send_mcastd_packet(struct bat_priv *bat_priv, struct hashtable_t *hash, 
+			    uint8_t *addr, uint32_t seqno)
+{
+	HASHIT(hashit);
+	HASHIT(_hashit);
+	struct sk_buff *skb;
+	unsigned char *skb_buff;
+	struct mcastd_packet *mcastd_packet;
+	struct mcast_router_entry *mcast_router_entry;
+	struct mcast_dest_entry *mcast_dest_entry;
+	struct batman_if *batman_if;
+	uint8_t mcast_info[1410];
+	uint8_t *mi;
+	
+	while (hash_iterate(hash, &hashit)) {
+		mcast_router_entry = hashit.bucket->data;
+
+		skb = dev_alloc_skb(1410 + 
+			sizeof(struct mcastd_packet) + 
+			sizeof(struct ethhdr));
+
+		if (!skb)
+			continue;
+		
+		skb_reserve(skb, sizeof(struct ethhdr));
+			
+		batman_if = mcast_router_entry->batman_if;
+		_hashit.index = -1;
+		_hashit.bucket = NULL;
+		mi = mcast_info;
+		while (hash_iterate(mcast_router_entry->mcast_dest_hash, 
+				    &_hashit)) {
+			mcast_dest_entry = _hashit.bucket->data;
+			memcpy(mi, mcast_dest_entry->addr, ETH_ALEN);
+			mi += ETH_ALEN;
+		}
+		skb_buff = skb_put(skb, sizeof(struct mcastd_packet) + 
+				   (mcast_router_entry->num_dest * ETH_ALEN));
+		mcastd_packet = (struct mcastd_packet *)skb->data;
+		mcastd_packet->packet_type = BAT_MCAST_DISC;
+		mcastd_packet->version = COMPAT_VERSION;
+		mcastd_packet->ttl = 50;
+		mcastd_packet->num_dest = mcast_router_entry->num_dest;
+		mcastd_packet->seqno = seqno;
+		if (addr == NULL) {
+			memcpy(mcastd_packet->orig, 
+			       bat_priv->primary_if->net_dev->dev_addr, 
+			       ETH_ALEN);
+		} else {
+			memcpy(mcastd_packet->orig, addr, ETH_ALEN);
+		}
+
+		memcpy(((void *)skb->data + sizeof(struct mcastd_packet)),
+			(void *)mcast_info, 
+			mcast_router_entry->num_dest * ETH_ALEN);
+
+		send_skb_packet(skb, batman_if, mcast_router_entry->router);
+	}
+}
+
+static void send_mcastd_packets(struct bat_priv *bat_priv)
+{
+	HASHIT(hashit);
+	struct orig_node *orig_node;
+	struct neigh_node *router;
+	struct mcast_router_entry *mcast_router_entry;
+	struct mcast_dest_entry *mcast_dest_entry;
+	uint32_t seqno;
+
+	if (bat_priv->mcast_router_hash)
+		hash_delete(bat_priv->mcast_router_hash, free_mcast_router, bat_priv);
+	
+	bat_priv->mcast_router_hash = hash_new(128, compare_orig, choose_orig);
+	
+	if (!bat_priv->mcast_router_hash) {
+		goto out;
+	}
+	
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
+
+		router = find_router(orig_node, NULL);
+
+		/* If we don't have a route skip */
+		if (!router) {
+			continue;
+		}
+
+		if (router->tq_avg <= TQ_TOTAL_BIDRECT_LIMIT)
+			continue;
+
+		mcast_router_entry = ((struct mcast_router_entry *)
+			hash_find(bat_priv->mcast_router_hash, 
+				  router->orig_node->primary_addr));
+
+		if (!mcast_router_entry) {
+			mcast_router_entry = 
+				kmalloc(sizeof(struct mcast_router_entry), 
+				        GFP_ATOMIC);
+			mcast_router_entry->num_dest = 0;
+			mcast_router_entry->batman_if = router->if_incoming;
+			mcast_router_entry->tq = router->tq_avg;
+			mcast_router_entry->mcast_dest_hash = 
+				hash_new(128, compare_orig, choose_orig);
+			memcpy(mcast_router_entry->router, router->addr, 
+			       ETH_ALEN);
+			memcpy(mcast_router_entry->primary, 
+			       router->orig_node->primary_addr, ETH_ALEN);
+			hash_add(bat_priv->mcast_router_hash, 
+			         mcast_router_entry);
+		}
+		
+		if (mcast_router_entry->num_dest < 235) {
+			mcast_router_entry->num_dest++;
+			mcast_dest_entry = 
+				kmalloc(sizeof(struct mcast_dest_entry), 
+					GFP_ATOMIC);
+			memcpy(mcast_dest_entry->addr, orig_node->orig, 
+			       ETH_ALEN);
+			hash_add(mcast_router_entry->mcast_dest_hash, 
+				 mcast_dest_entry);
+
+			if (!compare_orig(mcast_router_entry->router, router->addr) &&
+					router->tq_avg > mcast_router_entry->tq) {
+				mcast_router_entry->batman_if = router->if_incoming;
+				mcast_router_entry->tq = router->tq_avg;
+				memcpy(mcast_router_entry->router, router->addr, ETH_ALEN);
+			}
+		}
+	}
+
+	/* set sequence number */
+	seqno = htonl(atomic_inc_return(&bat_priv->mcast_disc_seqno));
+	send_mcastd_packet(bat_priv, bat_priv->mcast_router_hash, 
+				NULL, seqno);
+
+out:
+	bat_priv->mcast_disc_timer = jiffies + msecs_to_jiffies(1000);
+}
+
+int send_mcast_packet(struct bat_priv *bat_priv, struct sk_buff *skb, struct ethhdr *ethhdr)
+{
+	HASHIT(hashit);
+	struct mcast_packet *mcast_packet;
+	struct orig_node *orig_node = NULL;
+	struct mcast_router_entry *mcast_router_entry;
+	struct sk_buff *skb1;
+	struct batman_if *batman_if;
+	
+	if (!bat_priv->primary_if)
+		goto out;
+
+	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
+		goto out;
+
+	skb = skb_copy(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+
+	/* as we have a copy now, it is safe to decrease the TTL */
+	mcast_packet = (struct mcast_packet *)skb->data;
+	mcast_packet->ttl--;
+
+	spin_lock_bh(&bat_priv->orig_hash_lock);
+
+	if (!ethhdr) {
+		if (!bat_priv->mcast_router_hash)
+			goto free;
+		if (time_after(jiffies, bat_priv->mcast_disc_timer))
+			send_mcastd_packets(bat_priv);
+		while (hash_iterate(bat_priv->mcast_router_hash, &hashit)) {
+			mcast_router_entry = hashit.bucket->data;	
+			batman_if = mcast_router_entry->batman_if;
+			skb1 = skb_copy(skb, GFP_ATOMIC);
+			if (!skb1)
+				continue;
+
+			skb_reset_mac_header(skb1);
+			send_skb_packet(skb1, batman_if, 
+				mcast_router_entry->router);
+		}
+	} else {
+		/* Here we consult the orig mcast table to see 
+		 * who we need to forward to 
+		 */
+		orig_node = ((struct orig_node *)
+			hash_find(bat_priv->orig_hash, mcast_packet->orig));
+		if (!orig_node)
+			goto free;
+
+		while (hash_iterate(orig_node->mcast_router_hash, &hashit)) {
+			mcast_router_entry = hashit.bucket->data;	
+			batman_if = mcast_router_entry->batman_if;
+			skb1 = skb_copy(skb, GFP_ATOMIC);
+			if (!skb1)
+				continue;
+
+			send_skb_packet(skb1, batman_if, 
+				mcast_router_entry->router);
+		}
+	}
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+
+free:
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	kfree_skb(skb);
+out:
+	return NETDEV_TX_BUSY;
+}
+
+int mcast_data_print_text(struct seq_file *seq, void *offset)
+{
+	HASHIT(hashit);
+	HASHIT(_hashit);
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct orig_node *orig_node;
+	struct mcast_router_entry *mcast_router_entry;
+	int i;
+
+	if ((!bat_priv->primary_if) ||
+	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
+		if (!bat_priv->primary_if)
+			return seq_printf(seq, "BATMAN mesh %s disabled - "
+				"please specify interfaces to enable it\n",
+				net_dev->name);
+
+		return seq_printf(seq, "BATMAN mesh %s "
+				  "disabled - primary interface not active\n",
+				  net_dev->name);
+	}
+
+	seq_printf(seq, "Mcast sent locally\n");
+
+	spin_lock_bh(&bat_priv->orig_hash_lock);
+
+	if (bat_priv->mcast_router_hash) {
+		while (hash_iterate(bat_priv->mcast_router_hash, &hashit)) {
+			mcast_router_entry = hashit.bucket->data;
+			seq_printf(seq, " * %pM [%pM]\n", 
+				mcast_router_entry->primary,
+				mcast_router_entry->router);
+		}
+	}
+	
+	hashit.index = -1;
+	hashit.bucket = NULL;
+
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
+		_hashit.index = -1;
+		_hashit.bucket = NULL;
+		i = 0;
+		seq_printf(seq, "Mcast forwarded from Originator %pM\n", 
+			   orig_node->orig);
+		while (hash_iterate(orig_node->mcast_router_hash, &_hashit)) {
+			mcast_router_entry = _hashit.bucket->data;
+			seq_printf(seq, "    * %pM - [%10s]\n", 
+				mcast_router_entry->router, 
+				mcast_router_entry->batman_if->net_dev->name);
+		}
+	}
+
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+
+	return 0;
+}
+
+static void mcast_update_orig_routes(struct bat_priv *bat_priv, 
+			     struct orig_node *orig_node, struct sk_buff *skb,
+			     uint8_t is_duplicate, struct batman_if *recv_if)
+{
+	struct ethhdr *ethhdr;
+	struct mcastd_packet *mcastd_packet;
+	uint8_t *dest_addr;
+	struct neigh_node *router;
+	int i;
+	struct mcast_router_entry *mcast_router_entry;
+	struct mcast_dest_entry *mcast_dest_entry;
+	uint8_t new_entries = 0;
+	struct orig_node *router_node;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	mcastd_packet = (struct mcastd_packet *)skb->data;
+
+	if (!is_duplicate) {
+		if (orig_node->mcast_router_hash) 
+			hash_delete(orig_node->mcast_router_hash, 
+				    free_mcast_router, bat_priv);
+
+		orig_node->mcast_router_hash =
+			hash_new(1024, compare_orig, choose_orig);
+	}
+
+	if (!orig_node->mcast_router_hash)
+		orig_node->mcast_router_hash = 
+			hash_new(1024, compare_orig, choose_orig);
+
+	if (!orig_node->mcast_router_hash) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return;	
+	}
+
+	skb->data += sizeof(struct mcastd_packet);
+	for (i = 0; i < mcastd_packet->num_dest; i++, skb->data += ETH_ALEN) {
+		dest_addr = (uint8_t *)skb->data;
+
+		if (is_my_mac(dest_addr))
+			continue;
+
+		router_node = ((struct orig_node *)
+			hash_find(bat_priv->orig_hash, dest_addr));
+		
+		if (!router_node)
+			continue;
+
+		router = find_router(router_node, recv_if);
+
+		if (router->tq_avg <= TQ_TOTAL_BIDRECT_LIMIT)
+			continue;
+
+		if (compare_orig(router->orig_node->primary_addr, 
+				 orig_node->primary_addr))
+			continue;
+
+		mcast_router_entry = ((struct mcast_router_entry *)
+			hash_find(orig_node->mcast_router_hash, 
+				  router->orig_node->primary_addr));
+
+		if (!mcast_router_entry) {
+			mcast_router_entry = 
+				kmalloc(sizeof(struct mcast_router_entry), 
+					GFP_ATOMIC);
+			mcast_router_entry->num_dest = 0;
+			mcast_router_entry->batman_if = router->if_incoming;
+			mcast_router_entry->tq = router->tq_avg;
+			mcast_router_entry->mcast_dest_hash = 
+				hash_new(128, compare_orig, choose_orig);
+			memcpy(mcast_router_entry->router, router->addr, 
+			       ETH_ALEN);
+			memcpy(mcast_router_entry->primary, 
+			       router->orig_node->primary_addr, ETH_ALEN);
+			hash_add(orig_node->mcast_router_hash, 
+				 mcast_router_entry);
+		}
+
+		mcast_dest_entry = ((struct mcast_dest_entry *)
+			hash_find(mcast_router_entry->mcast_dest_hash, dest_addr));
+
+		if (mcast_router_entry->num_dest < 235 && !mcast_dest_entry) {
+			mcast_router_entry->num_dest++;
+			new_entries++;
+			mcast_dest_entry = 
+				kmalloc(sizeof(struct mcast_dest_entry), 
+					GFP_ATOMIC);
+			memcpy(mcast_dest_entry->addr, dest_addr, ETH_ALEN);
+			memcpy(mcast_dest_entry->dest_addr, ethhdr->h_dest,
+			       ETH_ALEN);
+			hash_add(mcast_router_entry->mcast_dest_hash, 
+				 mcast_dest_entry);
+			if (!compare_orig(mcast_router_entry->router, router->addr) &&
+					router->tq_avg > mcast_router_entry->tq) {
+				mcast_router_entry->batman_if = router->if_incoming;
+				mcast_router_entry->tq = router->tq_avg;
+				memcpy(mcast_router_entry->router, router->addr, ETH_ALEN);
+			}
+		}
+	}
+
+	if (new_entries)
+		send_mcastd_packet(bat_priv, orig_node->mcast_router_hash, 
+				   orig_node->orig, mcastd_packet->seqno);
+}	
+
+int recv_mcastd_packet(struct sk_buff *skb, struct batman_if *recv_if)
+{
+	struct ethhdr *ethhdr;
+	struct mcastd_packet *mcastd_packet;
+	int hdr_size = sizeof(struct mcastd_packet);
+	struct orig_node *orig_node;
+	uint8_t is_duplicate = 0;
+	int32_t seq_diff;
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+
+	
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
+		return NET_RX_DROP;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* not for me */
+	if (!is_my_mac(ethhdr->h_dest))
+		return NET_RX_DROP;
+
+	/* ignore discovery packets sent by myself */
+	if (is_my_mac(ethhdr->h_source))
+		return NET_RX_DROP;
+
+	mcastd_packet = (struct mcastd_packet *)skb->data;
+
+	if (is_my_mac(mcastd_packet->orig))
+		return NET_RX_DROP;
+
+	spin_lock_bh(&bat_priv->orig_hash_lock);
+	orig_node = ((struct orig_node *)
+		     hash_find(bat_priv->orig_hash, mcastd_packet->orig));
+		     
+	if (!orig_node) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return NET_RX_DROP;
+	}	
+
+	/* check whether the packet is a duplicate */
+	if (get_bit_status(orig_node->mcast_disc_bits,
+			   orig_node->last_mcast_disc_seqno,
+			   ntohl(mcastd_packet->seqno))) {
+		is_duplicate = 1;
+	}
+
+	seq_diff = ntohl(mcastd_packet->seqno) - 
+		orig_node->last_mcast_disc_seqno;
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(bat_priv, seq_diff,
+			     &orig_node->mcast_disc_seqno_reset)) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return NET_RX_DROP;
+	}
+
+	/* mark multicast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(bat_priv, orig_node->mcast_disc_bits, seq_diff, 1))
+		orig_node->last_mcast_disc_seqno = 
+			ntohl(mcastd_packet->seqno);
+
+	if (seq_diff < 0) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return NET_RX_DROP;
+	}
+
+	mcast_update_orig_routes(bat_priv, orig_node, skb, is_duplicate, 
+				 recv_if);
+
+	kfree_skb(skb);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	return NET_RX_SUCCESS;
+}
+
+int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
+{
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct orig_node *orig_node;
+	struct mcast_packet *mcast_packet;
+	struct ethhdr *ethhdr;
+	int hdr_size = sizeof(struct mcast_packet);
+	int32_t seq_diff;
+	short *num_hna;
+	int hna_buff_len;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* ignore broadcasts sent by myself */
+	if (is_my_mac(ethhdr->h_source))
+		return NET_RX_DROP;
+
+	mcast_packet = (struct mcast_packet *)skb->data;
+
+	/* ignore broadcasts originated by myself */
+	if (is_my_mac(mcast_packet->orig))
+		return NET_RX_DROP;
+
+	if (mcast_packet->ttl < 2)
+		return NET_RX_DROP;
+
+	spin_lock_bh(&bat_priv->orig_hash_lock);
+	orig_node = ((struct orig_node *)
+		     hash_find(bat_priv->orig_hash, mcast_packet->orig));
+
+	if (orig_node == NULL) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return NET_RX_DROP;
+	}
+
+	/* check whether the packet is a duplicate */
+	if (get_bit_status(orig_node->mcast_bits,
+			   orig_node->last_mcast_seqno,
+			   ntohl(mcast_packet->seqno))) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return NET_RX_DROP;
+	}
+
+	seq_diff = ntohl(mcast_packet->seqno) - orig_node->last_mcast_seqno;
+
+	if (seq_diff > 1)
+		printk("dropped %i packet\n", seq_diff);
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(bat_priv, seq_diff,
+			     &orig_node->mcast_seqno_reset)) {
+		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		return NET_RX_DROP;
+	}
+
+	/* mark broadcast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(bat_priv, orig_node->mcast_bits, seq_diff, 1))
+		orig_node->last_mcast_seqno = ntohl(mcast_packet->seqno);
+
+	if (mcast_packet->packet_type == BAT_HNA){
+		num_hna = (uint16_t *)((void *)mcast_packet + 
+			   sizeof(struct mcast_packet));
+		hna_buff_len = *num_hna * ETH_ALEN;
+		update_HNA(bat_priv, orig_node, 
+			(unsigned char *)((void *)mcast_packet + 
+				sizeof(struct mcast_packet) + 2),
+			hna_buff_len);
+	}
+
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	
+	send_mcast_packet(bat_priv, skb, ethhdr);
+
+	/* multicast for me */
+	if (mcast_packet->packet_type != BAT_HNA) {
+		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	} else {
+		kfree_skb(skb);
+	}
+
+	return NET_RX_SUCCESS;
+}
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/multicast.h batman-adv-devel/batman-adv/multicast.h
--- batman-adv-devel_r1828.clean/batman-adv/multicast.h	1969-12-31 16:00:00.000000000 -0800
+++ batman-adv-devel/batman-adv/multicast.h	2010-12-12 22:25:55.000000000 -0800
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
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
+#ifndef _NET_BATMAN_ADV_MULTICAST_H_
+#define _NET_BATMAN_ADV_MULTICAST_H_
+
+void free_mcast_router(void *data, void *arg);
+void send_mcastd_packet(struct bat_priv *bat_priv, struct hashtable_t *hash, 
+			    uint8_t *addr, uint32_t seqno);
+void send_hna_packet(struct bat_priv *bat_priv);
+int send_mcast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
+			struct ethhdr *ethhdr);
+int recv_mcastd_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int mcast_data_print_text(struct seq_file *seq, void *offset);
+
+#endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/originator.c batman-adv-devel/batman-adv/originator.c
--- batman-adv-devel_r1828.clean/batman-adv/originator.c	2010-10-12 02:52:00.000000000 -0700
+++ batman-adv-devel/batman-adv/originator.c	2010-12-12 23:36:20.000000000 -0800
@@ -31,6 +31,7 @@
 #include "hard-interface.h"
 #include "unicast.h"
 #include "soft-interface.h"
+#include "multicast.h"
 
 static void purge_orig(struct work_struct *work);
 
@@ -52,6 +53,11 @@
 	if (!bat_priv->orig_hash)
 		goto err;
 
+	bat_priv->mcast_router_hash = hash_new(1024, compare_orig, choose_orig);
+
+	if (!bat_priv->mcast_router_hash)
+		goto err;
+
 	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 	start_purge_timer(bat_priv);
 	return 1;
@@ -92,6 +98,10 @@
 	struct orig_node *orig_node = (struct orig_node *)data;
 	struct bat_priv *bat_priv = (struct bat_priv *)arg;
 
+	if (orig_node->mcast_router_hash)
+		hash_delete(orig_node->mcast_router_hash, free_mcast_router, 
+			    bat_priv);
+
 	/* for all neighbors towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
@@ -148,7 +158,9 @@
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
-	orig_node->bcast_seqno_reset = jiffies - 1
+	orig_node->mcast_seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
+	orig_node->mcast_disc_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
@@ -182,6 +194,7 @@
 			bat_priv->orig_hash = swaphash;
 	}
 
+	send_hna_packet(bat_priv);
 	return orig_node;
 free_bcast_own_sum:
 	kfree(orig_node->bcast_own_sum);
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/packet.h batman-adv-devel/batman-adv/packet.h
--- batman-adv-devel_r1828.clean/batman-adv/packet.h	2010-09-12 14:35:20.000000000 -0700
+++ batman-adv-devel/batman-adv/packet.h	2010-12-12 23:19:00.000000000 -0800
@@ -27,9 +27,11 @@
 #define BAT_PACKET       0x01
 #define BAT_ICMP         0x02
 #define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
 #define BAT_VIS          0x05
 #define BAT_UNICAST_FRAG 0x06
+#define BAT_MCAST        0x07
+#define BAT_MCAST_DISC   0x08
+#define BAT_HNA          0x09
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 12
@@ -112,7 +114,7 @@
 	uint16_t seqno;
 } __attribute__((packed));
 
-struct bcast_packet {
+struct mcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  orig[6];
@@ -133,4 +135,13 @@
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __attribute__((packed));
 
+struct mcastd_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  orig[6];
+	uint32_t seqno;
+	uint8_t  ttl;
+	uint8_t  num_dest;
+} __attribute__((packed));
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/routing.c batman-adv-devel/batman-adv/routing.c
--- batman-adv-devel_r1828.clean/batman-adv/routing.c	2010-10-09 04:39:24.000000000 -0700
+++ batman-adv-devel/batman-adv/routing.c	2010-12-12 23:19:32.000000000 -0800
@@ -58,7 +58,7 @@
 	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 }
 
-static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
+void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		       unsigned char *hna_buff, int hna_buff_len)
 {
 	if ((hna_buff_len != orig_node->hna_buff_len) ||
@@ -122,9 +122,6 @@
 	if (orig_node->router != neigh_node)
 		update_route(bat_priv, orig_node, neigh_node,
 			     hna_buff, hna_buff_len);
-	/* may be just HNA changed */
-	else
-		update_HNA(bat_priv, orig_node, hna_buff, hna_buff_len);
 }
 
 static int is_bidirectional_neigh(struct orig_node *orig_node,
@@ -339,7 +336,7 @@
  *  0 if the packet is to be accepted
  *  1 if the packet is to be ignored.
  */
-static int window_protected(struct bat_priv *bat_priv,
+int window_protected(struct bat_priv *bat_priv,
 			    int32_t seq_num_diff,
 			    unsigned long *last_reset)
 {
@@ -1266,85 +1263,6 @@
 	return route_unicast_packet(skb, recv_if, hdr_size);
 }
 
-
-int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
-{
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node;
-	struct bcast_packet *bcast_packet;
-	struct ethhdr *ethhdr;
-	int hdr_size = sizeof(struct bcast_packet);
-	int32_t seq_diff;
-	unsigned long flags;
-
-	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		return NET_RX_DROP;
-
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with broadcast indication but unicast recipient */
-	if (!is_bcast(ethhdr->h_dest))
-		return NET_RX_DROP;
-
-	/* packet with broadcast sender address */
-	if (is_bcast(ethhdr->h_source))
-		return NET_RX_DROP;
-
-	/* ignore broadcasts sent by myself */
-	if (is_my_mac(ethhdr->h_source))
-		return NET_RX_DROP;
-
-	bcast_packet = (struct bcast_packet *)skb->data;
-
-	/* ignore broadcasts originated by myself */
-	if (is_my_mac(bcast_packet->orig))
-		return NET_RX_DROP;
-
-	if (bcast_packet->ttl < 2)
-		return NET_RX_DROP;
-
-	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, bcast_packet->orig));
-
-	if (orig_node == NULL) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
-		return NET_RX_DROP;
-	}
-
-	/* check whether the packet is a duplicate */
-	if (get_bit_status(orig_node->bcast_bits,
-			   orig_node->last_bcast_seqno,
-			   ntohl(bcast_packet->seqno))) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
-		return NET_RX_DROP;
-	}
-
-	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
-
-	/* check whether the packet is old and the host just restarted. */
-	if (window_protected(bat_priv, seq_diff,
-			     &orig_node->bcast_seqno_reset)) {
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
-		return NET_RX_DROP;
-	}
-
-	/* mark broadcast in flood history, update window position
-	 * if required. */
-	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
-
-	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
-	/* rebroadcast packet */
-	add_bcast_packet_to_list(bat_priv, skb);
-
-	/* broadcast for me */
-	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
-
-	return NET_RX_SUCCESS;
-}
-
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct vis_packet *vis_packet;
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/routing.h batman-adv-devel/batman-adv/routing.h
--- batman-adv-devel_r1828.clean/batman-adv/routing.h	2010-10-09 04:39:24.000000000 -0700
+++ batman-adv-devel/batman-adv/routing.h	2010-12-12 23:09:25.000000000 -0800
@@ -44,5 +44,9 @@
 		struct batman_if *recv_if);
 void update_bonding_candidates(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node);
+void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
+		unsigned char *hna_buff, int hna_buff_len);
+int window_protected(struct bat_priv *bat_priv,
+		int32_t seq_num_diff, unsigned long *last_reset);
 
 #endif /* _NET_BATMAN_ADV_ROUTING_H_ */
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/send.c batman-adv-devel/batman-adv/send.c
--- batman-adv-devel_r1828.clean/batman-adv/send.c	2010-10-09 04:51:49.000000000 -0700
+++ batman-adv-devel/batman-adv/send.c	2010-12-12 23:20:46.000000000 -0800
@@ -29,11 +29,10 @@
 #include "vis.h"
 #include "aggregation.h"
 #include "gateway_common.h"
+#include "multicast.h"
 
 #include "compat.h"
 
-static void send_outstanding_bcast_packet(struct work_struct *work);
-
 /* apply hop penalty for a normal link */
 static uint8_t hop_penalty(const uint8_t tq)
 {
@@ -214,33 +213,6 @@
 	rcu_read_unlock();
 }
 
-static void rebuild_batman_packet(struct bat_priv *bat_priv,
-				  struct batman_if *batman_if)
-{
-	int new_len;
-	unsigned char *new_buff;
-	struct batman_packet *batman_packet;
-
-	new_len = sizeof(struct batman_packet) +
-			(bat_priv->num_local_hna * ETH_ALEN);
-	new_buff = kmalloc(new_len, GFP_ATOMIC);
-
-	/* keep old buffer if kmalloc should fail */
-	if (new_buff) {
-		memcpy(new_buff, batman_if->packet_buff,
-		       sizeof(struct batman_packet));
-		batman_packet = (struct batman_packet *)new_buff;
-
-		batman_packet->num_hna = hna_local_fill_buffer(bat_priv,
-				new_buff + sizeof(struct batman_packet),
-				new_len - sizeof(struct batman_packet));
-
-		kfree(batman_if->packet_buff);
-		batman_if->packet_buff = new_buff;
-		batman_if->packet_len = new_len;
-	}
-}
-
 void schedule_own_packet(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
@@ -265,9 +237,10 @@
 		batman_if->if_status = IF_ACTIVE;
 
 	/* if local hna has changed and interface is a primary interface */
-	if ((atomic_read(&bat_priv->hna_local_changed)) &&
-	    (batman_if == bat_priv->primary_if))
-		rebuild_batman_packet(bat_priv, batman_if);
+	if (((atomic_read(&bat_priv->hna_local_changed)) &&
+	    (batman_if == bat_priv->primary_if)) ||
+	    (time_after(jiffies, bat_priv->hna_timer)))
+		send_hna_packet(bat_priv);
 
 	/**
 	 * NOTE: packet_buff might just have been re-allocated in
@@ -370,124 +343,7 @@
 	kfree(forw_packet);
 }
 
-static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
-				      struct forw_packet *forw_packet,
-				      unsigned long send_time)
-{
-	unsigned long flags;
-	INIT_HLIST_NODE(&forw_packet->list);
-
-	/* add new packet to packet list */
-	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
-	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
-	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
-
-	/* start timer for this packet */
-	INIT_DELAYED_WORK(&forw_packet->delayed_work,
-			  send_outstanding_bcast_packet);
-	queue_delayed_work(bat_event_workqueue, &forw_packet->delayed_work,
-			   send_time);
-}
-
 #define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
-/* add a broadcast packet to the queue and setup timers. broadcast packets
- * are sent multiple times to increase probability for beeing received.
- *
- * This function returns NETDEV_TX_OK on success and NETDEV_TX_BUSY on
- * errors.
- *
- * The skb is not consumed, so the caller should make sure that the
- * skb is freed. */
-int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
-{
-	struct forw_packet *forw_packet;
-	struct bcast_packet *bcast_packet;
-
-	if (!atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
-		bat_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
-		goto out;
-	}
-
-	if (!bat_priv->primary_if)
-		goto out;
-
-	forw_packet = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
-
-	if (!forw_packet)
-		goto out_and_inc;
-
-	skb = skb_copy(skb, GFP_ATOMIC);
-	if (!skb)
-		goto packet_free;
-
-	/* as we have a copy now, it is safe to decrease the TTL */
-	bcast_packet = (struct bcast_packet *)skb->data;
-	bcast_packet->ttl--;
-
-	skb_reset_mac_header(skb);
-
-	forw_packet->skb = skb;
-	forw_packet->if_incoming = bat_priv->primary_if;
-
-	/* how often did we send the bcast packet ? */
-	forw_packet->num_packets = 0;
-
-	_add_bcast_packet_to_list(bat_priv, forw_packet, 1);
-	return NETDEV_TX_OK;
-
-packet_free:
-	kfree(forw_packet);
-out_and_inc:
-	atomic_inc(&bat_priv->bcast_queue_left);
-out:
-	return NETDEV_TX_BUSY;
-}
-
-static void send_outstanding_bcast_packet(struct work_struct *work)
-{
-	struct batman_if *batman_if;
-	struct delayed_work *delayed_work =
-		container_of(work, struct delayed_work, work);
-	struct forw_packet *forw_packet =
-		container_of(delayed_work, struct forw_packet, delayed_work);
-	unsigned long flags;
-	struct sk_buff *skb1;
-	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
-
-	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
-	hlist_del(&forw_packet->list);
-	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
-
-	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
-		goto out;
-
-	/* rebroadcast packet */
-	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (batman_if->soft_iface != soft_iface)
-			continue;
-
-		/* send a copy of the saved skb */
-		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
-		if (skb1)
-			send_skb_packet(skb1, batman_if, broadcast_addr);
-	}
-	rcu_read_unlock();
-
-	forw_packet->num_packets++;
-
-	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < 3) {
-		_add_bcast_packet_to_list(bat_priv, forw_packet,
-					  ((5 * HZ) / 1000));
-		return;
-	}
-
-out:
-	forw_packet_free(forw_packet);
-	atomic_inc(&bat_priv->bcast_queue_left);
-}
 
 void send_outstanding_bat_packet(struct work_struct *work)
 {
@@ -539,30 +395,6 @@
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"purge_outstanding_packets()\n");
 
-	/* free bcast list */
-	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
-	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
-				  &bat_priv->forw_bcast_list, list) {
-
-		/**
-		 * if purge_outstanding_packets() was called with an argmument
-		 * we delete only packets belonging to the given interface
-		 */
-		if ((batman_if) &&
-		    (forw_packet->if_incoming != batman_if))
-			continue;
-
-		spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
-
-		/**
-		 * send_outstanding_bcast_packet() will lock the list to
-		 * delete the item from the list
-		 */
-		cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
-	}
-	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
-
 	/* free batman packet list */
 	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/send.h batman-adv-devel/batman-adv/send.h
--- batman-adv-devel_r1828.clean/batman-adv/send.h	2010-08-08 15:58:31.000000000 -0700
+++ batman-adv-devel/batman-adv/send.h	2010-12-12 23:31:29.000000000 -0800
@@ -33,7 +33,6 @@
 			     struct batman_packet *batman_packet,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
-int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct bat_priv *bat_priv,
 			       struct batman_if *batman_if);
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/soft-interface.c batman-adv-devel/batman-adv/soft-interface.c
--- batman-adv-devel_r1828.clean/batman-adv/soft-interface.c	2010-10-12 03:00:08.000000000 -0700
+++ batman-adv-devel/batman-adv/soft-interface.c	2010-12-12 23:34:45.000000000 -0800
@@ -39,7 +39,7 @@
 #include "compat.h"
 #include "unicast.h"
 #include "routing.h"
-
+#include "multicast.h"
 
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void bat_get_drvinfo(struct net_device *dev,
@@ -347,11 +347,11 @@
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
-	struct bcast_packet *bcast_packet;
+	struct mcast_packet *mcast_packet;
 	struct vlan_ethhdr *vhdr;
 	int data_len = skb->len, ret;
 	short vid = -1;
-	bool bcast_dst = false, do_bcast = true;
+	bool mcast_dst = false, do_mcast = true;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
@@ -383,39 +383,37 @@
 	hna_local_add(soft_iface, ethhdr->h_source);
 
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
-		bcast_dst = true;
+		mcast_dst = true;
 
-	if ((bcast_dst) && gw_is_target(bat_priv, skb))
-		do_bcast = false;
+	if ((mcast_dst) && gw_is_target(bat_priv, skb))
+		do_mcast = false;
 
 	/* ethernet packet should be broadcasted */
-	if (bcast_dst && do_bcast) {
+	if (mcast_dst && do_mcast) {
 		if (!bat_priv->primary_if)
 			goto dropped;
 
-		if (my_skb_head_push(skb, sizeof(struct bcast_packet)) < 0)
+		if (my_skb_head_push(skb, sizeof(struct mcast_packet)) < 0)
 			goto dropped;
 
-		bcast_packet = (struct bcast_packet *)skb->data;
-		bcast_packet->version = COMPAT_VERSION;
-		bcast_packet->ttl = TTL;
+		mcast_packet = (struct mcast_packet *)skb->data;
+		mcast_packet->version = COMPAT_VERSION;
+		mcast_packet->ttl = TTL;
 
 		/* batman packet type: broadcast */
-		bcast_packet->packet_type = BAT_BCAST;
+		mcast_packet->packet_type = BAT_MCAST;
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
-		memcpy(bcast_packet->orig,
+		memcpy(mcast_packet->orig,
 		       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 
 		/* set broadcast sequence number */
-		bcast_packet->seqno =
-			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
+		mcast_packet->seqno =
+			htonl(atomic_inc_return(&bat_priv->mcast_seqno));
 
-		add_bcast_packet_to_list(bat_priv, skb);
+		send_mcast_packet(bat_priv, skb, NULL);
 
-		/* a copy is stored in the bcast list, therefore removing
-		 * the original skb. */
 		kfree_skb(skb);
 
 	/* unicast packet */
@@ -595,16 +593,17 @@
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->log_level, 0);
 	atomic_set(&bat_priv->frag_enabled, 1);
-	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
-	atomic_set(&bat_priv->bcast_seqno, 1);
-	atomic_set(&bat_priv->hna_local_changed, 0);
+	atomic_set(&bat_priv->mcast_seqno, 1);
+	atomic_set(&bat_priv->mcast_disc_seqno, 1);
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 	bat_priv->softif_neigh = NULL;
+	bat_priv->mcast_disc_timer = jiffies;
+	bat_priv->hna_timer = jiffies + msecs_to_jiffies(5000);
 
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/translation-table.c batman-adv-devel/batman-adv/translation-table.c
--- batman-adv-devel_r1828.clean/batman-adv/translation-table.c	2010-08-08 15:58:31.000000000 -0700
+++ batman-adv-devel/batman-adv/translation-table.c	2010-12-12 23:35:05.000000000 -0800
@@ -24,6 +24,7 @@
 #include "soft-interface.h"
 #include "types.h"
 #include "hash.h"
+#include "multicast.h"
 #include "compat.h"
 
 static void hna_local_purge(struct work_struct *work);
@@ -47,7 +48,6 @@
 	if (!bat_priv->hna_local_hash)
 		return 0;
 
-	atomic_set(&bat_priv->hna_local_changed, 0);
 	hna_local_start_timer(bat_priv);
 
 	return 1;
@@ -105,7 +105,6 @@
 
 	hash_add(bat_priv->hna_local_hash, hna_local_entry);
 	bat_priv->num_local_hna++;
-	atomic_set(&bat_priv->hna_local_changed, 1);
 
 	if (bat_priv->hna_local_hash->elements * 4 >
 					bat_priv->hna_local_hash->size) {
@@ -120,6 +119,8 @@
 
 	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
+	send_hna_packet(bat_priv);
+
 	/* remove address from global hash if present */
 	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
diff -ruN -X ../linux-ixp4xx_generic/linux-2.6.32.20/Documentation/dontdiff batman-adv-devel_r1828.clean/batman-adv/types.h batman-adv-devel/batman-adv/types.h
--- batman-adv-devel_r1828.clean/batman-adv/types.h	2010-10-09 04:44:44.000000000 -0700
+++ batman-adv-devel/batman-adv/types.h	2010-12-12 23:35:53.000000000 -0800
@@ -28,9 +28,9 @@
 #include "bitarray.h"
 
 #define BAT_HEADER_LEN (sizeof(struct ethhdr) + \
-	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
+	((sizeof(struct unicast_packet) > sizeof(struct mcast_packet) ? \
 	 sizeof(struct unicast_packet) : \
-	 sizeof(struct bcast_packet))))
+	 sizeof(struct mcast_packet))))
 
 
 struct batman_if {
@@ -54,13 +54,13 @@
  *	orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
  *	@last_valid: when last packet from this node was received
- *	@bcast_seqno_reset: time when the broadcast seqno window was reset
+ *	@mcast_seqno_reset: time when the broadcast seqno window was reset
  *	@batman_seqno_reset: time when the batman seqno window was reset
  *	@gw_flags: flags related to gateway class
  *	@flags: for now only VIS_SERVER flag
  *	@last_real_seqno: last and best known squence number
  *	@last_ttl: ttl of last received packet
- *	@last_bcast_seqno: last broadcast sequence number received by this host
+ *	@last_mcast_seqno: last broadcast sequence number received by this host
  *
  *	@candidates: how many candidates are available
  *	@selected: next bonding candidate
@@ -74,7 +74,8 @@
 	uint8_t tq_own;
 	int tq_asym_penalty;
 	unsigned long last_valid;
-	unsigned long bcast_seqno_reset;
+	unsigned long mcast_seqno_reset;
+	unsigned long mcast_disc_seqno_reset;
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
 	uint8_t flags;
@@ -82,8 +83,10 @@
 	int16_t hna_buff_len;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
-	TYPE_OF_WORD bcast_bits[NUM_WORDS];
-	uint32_t last_bcast_seqno;
+	TYPE_OF_WORD mcast_bits[NUM_WORDS];
+	TYPE_OF_WORD mcast_disc_bits[NUM_WORDS];
+	uint32_t last_mcast_seqno;
+	uint32_t last_mcast_disc_seqno;
 	struct list_head neigh_list;
 	struct list_head frag_list;
 	unsigned long last_frag_packet;
@@ -91,6 +94,7 @@
 		uint8_t candidates;
 		struct neigh_node *selected;
 	} bond;
+	struct hashtable_t *mcast_router_hash;
 };
 
 struct gw_node {
@@ -132,8 +136,8 @@
 	atomic_t gw_class;
 	atomic_t orig_interval;
 	atomic_t log_level;
-	atomic_t bcast_seqno;
-	atomic_t bcast_queue_left;
+	atomic_t mcast_seqno;
+	atomic_t mcast_disc_seqno;
 	atomic_t batman_queue_left;
 	char num_ifaces;
 	struct hlist_head softif_neigh_list;
@@ -143,22 +147,23 @@
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
-	struct hlist_head forw_bcast_list;
 	struct hlist_head gw_list;
 	struct list_head vis_send_list;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *hna_local_hash;
 	struct hashtable_t *hna_global_hash;
 	struct hashtable_t *vis_hash;
+	struct hashtable_t *mcast_router_hash;
 	spinlock_t orig_hash_lock; /* protects orig_hash */
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
-	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t hna_lhash_lock; /* protects hna_local_hash */
 	spinlock_t hna_ghash_lock; /* protects hna_global_hash */
 	spinlock_t gw_list_lock; /* protects gw_list */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
+	unsigned long mcast_disc_timer;
+	unsigned long hna_timer;
 	int16_t num_local_hna;
 	atomic_t hna_local_changed;
 	struct delayed_work hna_work;
@@ -267,4 +272,17 @@
 	struct rcu_head rcu;
 };
 
+struct mcast_router_entry {
+	uint8_t primary[ETH_ALEN];
+	uint8_t router[ETH_ALEN];
+	uint8_t tq;
+	struct batman_if *batman_if;
+	uint32_t num_dest;
+	struct hashtable_t *mcast_dest_hash;
+};
+
+struct mcast_dest_entry {
+	uint8_t addr[ETH_ALEN];
+	uint8_t dest_addr[ETH_ALEN];
+};
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */


