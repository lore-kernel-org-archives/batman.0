Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 29 Nov 2009 21:09:50 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091129200950.GA19275@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Removing the big batman lock
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The orig_hash_lock locks big sections of the batman-adv code base, which
might lead to unneccesary performance degradation at some points.=20

Therefore this patch moves the locking from the whole originator hash
table to individual orig nodes, introducing a reference count based
system to identify whether a node is still in use or can be free()d.

To summarize the changes:
 * when iterating, the hash is only locked while an item is picked
   from the hash. Access to the orig_nodes themselves is no longer=20
   protected by orig_hash_lock.
 * Each orig_node is referenced when it is used or referenced (e.g. as
   neighbor), and freed when there are no references left. This makes
   it neccesary to carefully reference and unreference nodes.
 * orig_nodes receive an individual spin lock to protect access to
   their data.

I did some testing, including loading, unloading, killing individual
nodes etc, which seems to be clean so far. However there might be=20
more race conditions introduced by this large patch, and i'm therefore
requesting a careful review before committing.

Signed-off-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
---

Index: batman-adv-kernelland/vis.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/vis.c	(revision 1489)
+++ batman-adv-kernelland/vis.c	(working copy)
@@ -26,6 +26,7 @@
 #include "soft-interface.h"
 #include "hard-interface.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
=20
 struct hashtable_t *vis_hash;
@@ -262,16 +263,16 @@
=20
 /* Walk the originators and find the VIS server with the best tq. Set the =
packet
  * address to its address and return the best_tq.
- *
- * Must be called with the originator hash locked */
+ */
 static int find_best_vis_server(struct vis_info *info)
 {
 	struct hash_it_t *hashit =3D NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
 	int best_tq =3D -1;
=20
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
-		orig_node =3D hashit->bucket->data;
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
+
+		spin_lock(&orig_node->lock);
 		if ((orig_node !=3D NULL) &&
 		    (orig_node->router !=3D NULL) &&
 		    (orig_node->flags & VIS_SERVER) &&
@@ -280,6 +281,7 @@
 			memcpy(info->packet.target_orig, orig_node->orig,
 			       ETH_ALEN);
 		}
+		spin_unlock(&orig_node->lock);
 	}
 	return best_tq;
 }
@@ -298,7 +300,7 @@
 static int generate_vis_packet(void)
 {
 	struct hash_it_t *hashit =3D NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
 	struct vis_info *info =3D (struct vis_info *)my_vis_info;
 	struct vis_info_entry *entry, *entry_array;
 	struct hna_local_entry *hna_local_entry;
@@ -307,7 +309,6 @@
=20
 	info->first_seen =3D jiffies;
=20
-	spin_lock(&orig_hash_lock);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 	info->packet.ttl =3D TTL;
 	info->packet.seqno++;
@@ -316,17 +317,17 @@
 	if (!is_vis_server_locked()) {
 		best_tq =3D find_best_vis_server(info);
 		if (best_tq < 0) {
-			spin_unlock(&orig_hash_lock);
 			return -1;
 		}
 	}
-	hashit =3D NULL;
=20
 	entry_array =3D (struct vis_info_entry *)
 		((char *)info + sizeof(struct vis_info));
=20
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
-		orig_node =3D hashit->bucket->data;
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
+
+		spin_lock(&orig_node->lock);
+
 		if (orig_node->router !=3D NULL
 			&& compare_orig(orig_node->router->addr, orig_node->orig)
 			&& orig_node->batman_if
@@ -340,15 +341,16 @@
 			entry->quality =3D orig_node->router->tq_avg;
 			info->packet.entries++;
=20
+			/* TODO: this is is a possible memory leak,=20
+			 * hashit should be freed somewhere. */
 			if (vis_packet_full(info)) {
-				spin_unlock(&orig_hash_lock);
+				spin_unlock(&orig_node->lock);
+				orig_unreference(orig_node);
 				return 0;
 			}
 		}
 	}
=20
-	spin_unlock(&orig_hash_lock);
-
 	hashit =3D NULL;
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 	while (NULL !=3D (hashit =3D hash_iterate(hna_local_hash, hashit))) {
@@ -388,14 +390,12 @@
 static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct hash_it_t *hashit =3D NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
=20
-	spin_lock(&orig_hash_lock);
-
 	/* send to all routers in range. */
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
-		orig_node =3D hashit->bucket->data;
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
=20
+		spin_lock(&orig_node->lock);
 		/* if it's a vis server and reachable, send it. */
 		if (orig_node &&
 		    (orig_node->flags & VIS_SERVER) &&
@@ -415,27 +415,28 @@
 					orig_node->batman_if,
 					orig_node->router->addr);
 		}
+		spin_unlock(&orig_node->lock);
 	}
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-	spin_unlock(&orig_hash_lock);
 }
=20
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
=20
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)
-		     hash_find(orig_hash, info->packet.target_orig));
+	orig_node =3D orig_find(info->packet.target_orig);
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
-		send_raw_packet((unsigned char *) &info->packet, packet_length,
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
+	    if ((orig_node->batman_if !=3D NULL) &&
+	    	(orig_node->router !=3D NULL)) {
+			send_raw_packet((unsigned char *) &info->packet, packet_length,
 				orig_node->batman_if,
 				orig_node->router->addr);
+		}
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
-	spin_unlock(&orig_hash_lock);
 }
=20
 /* only send one vis packet. called from send_vis_packets() */
Index: batman-adv-kernelland/Makefile.kbuild
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/Makefile.kbuild	(revision 1489)
+++ batman-adv-kernelland/Makefile.kbuild	(working copy)
@@ -25,7 +25,7 @@
 -include $(TOPDIR)/Rules.make
 endif
=20
-# EXTRA_CFLAGS +=3D -DCONFIG_BATMAN_DEBUG
+EXTRA_CFLAGS +=3D -DCONFIG_BATMAN_DEBUG
=20
 ifneq ($(REVISION),)
 EXTRA_CFLAGS +=3D -DREVISION_VERSION=3D\"r$(REVISION)\"
Index: batman-adv-kernelland/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/types.h	(revision 1489)
+++ batman-adv-kernelland/types.h	(working copy)
@@ -62,6 +62,8 @@
 	int16_t  hna_buff_len;
 	uint16_t last_real_seqno;   /* last and best known squence number */
 	uint8_t last_ttl;         /* ttl of last received packet */
+	spinlock_t lock;
+	atomic_t refcnt;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint16_t last_bcast_seqno;  /* last broadcast sequence number received by=
 this host */
 	struct list_head neigh_list;
Index: batman-adv-kernelland/translation-table.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/translation-table.c	(revision 1489)
+++ batman-adv-kernelland/translation-table.c	(working copy)
@@ -24,6 +24,7 @@
 #include "soft-interface.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
=20
 struct hashtable_t *hna_local_hash;
@@ -257,6 +258,9 @@
 	return 1;
 }
=20
+
+/* adds an HNA entry to the global address table.
+ * orig_node's spinlock should be hold from outside */
 void hna_global_add_orig(struct orig_node *orig_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
@@ -299,7 +303,7 @@
=20
 		}
=20
-		hna_global_entry->orig_node =3D orig_node;
+		hna_global_entry->orig_node =3D orig_reference(orig_node);
 		spin_unlock_irqrestore(&hna_global_hash_lock, flags);
=20
 		/* remove address from local hash if present */
@@ -391,6 +395,8 @@
 		hna_str, orig_str, message);
=20
 	hash_remove(hna_global_hash, hna_global_entry->addr);
+	orig_unreference(hna_global_entry->orig_node);
+
 	kfree(hna_global_entry);
 }
=20
@@ -452,5 +458,5 @@
 	if (hna_global_entry =3D=3D NULL)
 		return NULL;
=20
-	return hna_global_entry->orig_node;
+	return orig_reference(hna_global_entry->orig_node);
 }
Index: batman-adv-kernelland/send.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/send.c	(revision 1489)
+++ batman-adv-kernelland/send.c	(working copy)
@@ -294,6 +294,7 @@
 	batman_packet->ttl--;
 	memcpy(batman_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
=20
+	spin_lock(&orig_node->lock);
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
 	 * of our best tq value */
 	if ((orig_node->router) && (orig_node->router->tq_avg !=3D 0)) {
@@ -308,6 +309,7 @@
=20
 		tq_avg =3D orig_node->router->tq_avg;
 	}
+	spin_unlock(&orig_node->lock);
=20
 	/* apply hop penalty */
 	batman_packet->tq =3D hop_penalty(batman_packet->tq);
Index: batman-adv-kernelland/device.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/device.c	(revision 1489)
+++ batman-adv-kernelland/device.c	(working copy)
@@ -24,6 +24,7 @@
 #include "send.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
=20
 #include "compat.h"
=20
@@ -205,6 +206,7 @@
 	struct icmp_packet icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
+	uint8_t router_addr[ETH_ALEN];
=20
 	if (len < sizeof(struct icmp_packet)) {
 		printk(KERN_DEBUG "batman-adv:Error - can't send packet from char device=
: invalid packet size\n");
@@ -239,15 +241,20 @@
 	if (atomic_read(&module_state) !=3D MODULE_ACTIVE)
 		goto dst_unreach;
=20
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
+	orig_node =3D orig_find(icmp_packet.dst);
=20
 	if (!orig_node)
-		goto unlock;
+		goto dst_unreach;
=20
+	spin_lock(&orig_node->lock);
+
 	if (!orig_node->router)
 		goto unlock;
=20
+	memcpy(router_addr,
+	       orig_node->router->addr,
+	       ETH_ALEN);
+
 	batman_if =3D orig_node->batman_if;
=20
 	if (!batman_if)
@@ -257,15 +264,18 @@
 	       batman_if->net_dev->dev_addr,
 	       ETH_ALEN);
=20
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
+
 	send_raw_packet((unsigned char *)&icmp_packet,
 			sizeof(struct icmp_packet),
-			batman_if, orig_node->router->addr);
+			batman_if, router_addr);
=20
-	spin_unlock(&orig_hash_lock);
 	goto out;
=20
 unlock:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
 dst_unreach:
 	icmp_packet.msg_type =3D DESTINATION_UNREACHABLE;
 	bat_device_add_packet(device_client, &icmp_packet);
Index: batman-adv-kernelland/proc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/proc.c	(revision 1489)
+++ batman-adv-kernelland/proc.c	(working copy)
@@ -28,6 +28,7 @@
 #include "hash.h"
 #include "vis.h"
 #include "compat.h"
+#include "originator.h"
=20
 static uint8_t vis_format =3D DOT_DRAW;
=20
@@ -187,7 +188,7 @@
 static int proc_originators_read(struct seq_file *seq, void *offset)
 {
 	struct hash_it_t *hashit =3D NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
 	struct neigh_node *neigh_node;
 	int batman_count =3D 0;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
@@ -213,11 +214,10 @@
 		   ((struct batman_if *)if_list.next)->addr_str);
=20
 	rcu_read_unlock();
-	spin_lock(&orig_hash_lock);
=20
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
=20
-		orig_node =3D hashit->bucket->data;
+		spin_lock(&orig_node->lock);
=20
 		if (!orig_node->router)
 			continue;
@@ -241,11 +241,10 @@
 		}
=20
 		seq_printf(seq, "\n");
+		spin_unlock(&orig_node->lock);
=20
 	}
=20
-	spin_unlock(&orig_hash_lock);
-
 	if (batman_count =3D=3D 0)
 		seq_printf(seq, "No batman nodes in range ... \n");
=20
Index: batman-adv-kernelland/soft-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/soft-interface.c	(revision 1489)
+++ batman-adv-kernelland/soft-interface.c	(working copy)
@@ -26,6 +26,7 @@
 #include "translation-table.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include "compat.h"
@@ -34,7 +35,6 @@
 				  * broadcast storms */
 static int32_t skb_packets;
 static int32_t skb_bad_packets;
-static int32_t lock_dropped;
=20
 unsigned char mainIfAddr[ETH_ALEN];
 static unsigned char mainIfAddr_default[ETH_ALEN];
@@ -205,60 +205,55 @@
 	/* unicast packet */
 	} else {
=20
-		/* simply spin_lock()ing can deadlock when the lock is already
-		 * hold. */
-		/* TODO: defer the work in a working queue instead of
-		 * dropping */
-		if (!spin_trylock(&orig_hash_lock)) {
-			lock_dropped++;
-			printk(KERN_WARNING "batman-adv:%d packets dropped because lock was hol=
d\n", lock_dropped);
-			goto dropped;
-		}
-
 		/* get routing information */
-		orig_node =3D ((struct orig_node *)hash_find(orig_hash,
-							   ethhdr->h_dest));
+		orig_node =3D orig_find(ethhdr->h_dest);
=20
 		/* check for hna host */
 		if (!orig_node)
 			orig_node =3D transtable_search(ethhdr->h_dest);
=20
-		if ((orig_node) &&
-		    (orig_node->batman_if) &&
-		    (orig_node->router)) {
-			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
-				goto unlock;
+		if (!orig_node)=20
+			goto dropped;
=20
-			unicast_packet =3D (struct unicast_packet *)skb->data;
+		spin_lock(&orig_node->lock);
=20
-			unicast_packet->version =3D COMPAT_VERSION;
-			/* batman packet type: unicast */
-			unicast_packet->packet_type =3D BAT_UNICAST;
-			/* set unicast ttl */
-			unicast_packet->ttl =3D TTL;
-			/* copy the destination for faster routing */
-			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	    if (!((orig_node->batman_if) &&
+		    (orig_node->router)))=20
+			goto unlock;
=20
-			/* net_dev won't be available when not active */
-			if (orig_node->batman_if->if_active !=3D IF_ACTIVE)
-				goto unlock;
+		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)=20
+			goto unlock;
=20
-			send_raw_packet(skb->data, skb->len,
-					orig_node->batman_if,
-					orig_node->router->addr);
-		} else {
+		unicast_packet =3D (struct unicast_packet *)skb->data;
+
+		unicast_packet->version =3D COMPAT_VERSION;
+		/* batman packet type: unicast */
+		unicast_packet->packet_type =3D BAT_UNICAST;
+		/* set unicast ttl */
+		unicast_packet->ttl =3D TTL;
+		/* copy the destination for faster routing */
+		memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+
+		/* net_dev won't be available when not active */
+		if (orig_node->batman_if->if_active !=3D IF_ACTIVE)=20
 			goto unlock;
-		}
+	=09
+		send_raw_packet(skb->data, skb->len,
+			orig_node->batman_if,
+			orig_node->router->addr);
=20
-		spin_unlock(&orig_hash_lock);
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
=20
 	priv->stats.tx_packets++;
 	priv->stats.tx_bytes +=3D data_len;
 	goto end;
=20
+
 unlock:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
 dropped:
 	priv->stats.tx_dropped++;
 end:
Index: batman-adv-kernelland/hard-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/hard-interface.c	(revision 1489)
+++ batman-adv-kernelland/hard-interface.c	(working copy)
@@ -26,6 +26,7 @@
 #include "translation-table.h"
 #include "routing.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
=20
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
@@ -317,8 +318,9 @@
 {
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
 	struct hash_it_t *hashit =3D NULL;
+	int ret;
=20
 	batman_if =3D kmalloc(sizeof(struct batman_if), GFP_KERNEL);
=20
@@ -375,18 +377,18 @@
=20
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock(&orig_hash_lock);
=20
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
-		orig_node =3D hashit->bucket->data;
-		if (resize_orig(orig_node, if_num) =3D=3D -1) {
-			spin_unlock(&orig_hash_lock);
-			goto out;
-		}
+	ret =3D 0;
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
+		ret |=3D resize_orig(orig_node, if_num);
 	}
=20
-	spin_unlock(&orig_hash_lock);
+	if (ret) {
+		printk(KERN_ERR "batman-adv:Resizing originators for %s failed.\n", batm=
an_if->dev);
+		goto out;
+	}
=20
+
 	if (!hardif_is_interface_up(batman_if->dev))
 		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): int=
erface not active\n", batman_if->dev);
 	else
Index: batman-adv-kernelland/originator.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/originator.c	(revision 1489)
+++ batman-adv-kernelland/originator.c	(working copy)
@@ -19,17 +19,86 @@
  *
  */
=20
-/* increase the reference counter for this originator */
-
 #include "main.h"
+#include "hash.h"
 #include "originator.h"
-#include "hash.h"
 #include "translation-table.h"
 #include "routing.h"
=20
=20
+DEFINE_SPINLOCK(orig_hash_lock);
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
=20
+/* increase the reference counter for this originator */
+
+struct orig_node *orig_reference(struct orig_node *orig_node)
+{
+	if (orig_node =3D=3D NULL) {
+		printk(KERN_ERR "batman-adv: tried to reference a NULL orig\n");
+		dump_stack();
+		return NULL;
+	} else if (atomic_read(&orig_node->refcnt) < 1) {
+		printk(KERN_DEBUG "batman-adv: trying to access a vanished node with ref=
cnt %d\n", atomic_read(&orig_node->refcnt));
+		return NULL;
+	} else {
+		atomic_inc(&orig_node->refcnt);
+
+		return orig_node;
+	}
+}
+
+static void __free_orig_node(void *data)
+{
+	struct orig_node *orig_node =3D (struct orig_node *)data;
+
+	hna_global_del_orig(orig_node, "__free_orig_node");
+
+	kfree(orig_node->bcast_own);
+	kfree(orig_node->bcast_own_sum);
+	kfree(orig_node);
+}
+
+
+/* decrease the reference counter for this originator */
+struct orig_node *orig_unreference(struct orig_node *orig_node)
+{
+	char orig_str[ETH_STR_LEN];
+
+	if (orig_node =3D=3D NULL) {
+		printk(KERN_ERR "batman-adv: tried to reference a NULL orig\n");
+		dump_stack();
+		return NULL;
+	} else if (atomic_read(&orig_node->refcnt) < 1) {
+		printk(KERN_DEBUG "batman-adv: trying to access a vanished node with ref=
cnt %d\n", atomic_read(&orig_node->refcnt));
+		return NULL;
+	} else {
+
+		if (atomic_dec_and_test(&orig_node->refcnt)) {
+			addr_to_string(orig_str, orig_node->orig);
+			bat_dbg(DBG_BATMAN,"%s:decreasing refcnt of orig %s to %d, time to free=
\n", __func__, orig_str, atomic_read(&orig_node->refcnt));
+			__free_orig_node(orig_node);
+		}
+		return orig_node;
+	}
+}
+
+
+/* find an orig node and increase the reference counter */
+
+struct orig_node *orig_find(char *mac)
+{
+	struct orig_node *orig_node;
+
+	spin_lock(&orig_hash_lock);
+	orig_node =3D ((struct orig_node *)hash_find(orig_hash, mac));
+	spin_unlock(&orig_hash_lock);
+
+	if (orig_node)
+		orig_node =3D orig_reference(orig_node);
+
+	return orig_node;
+}
+
 static void start_purge_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &purge_orig_wq, 1 * HZ);
@@ -64,6 +133,7 @@
=20
 	spin_lock(&orig_hash_lock);
 	hash_delete(orig_hash, free_orig_node);
+
 	orig_hash =3D NULL;
 	spin_unlock(&orig_hash_lock);
 }
@@ -81,7 +151,7 @@
 	INIT_LIST_HEAD(&neigh_node->list);
=20
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
-	neigh_node->orig_node =3D orig_neigh_node;
+	neigh_node->orig_node =3D orig_reference(orig_neigh_node);
 	neigh_node->if_incoming =3D if_incoming;
=20
 	list_add_tail(&neigh_node->list, &orig_node->neigh_list);
@@ -90,39 +160,35 @@
=20
 void free_orig_node(void *data)
 {
+	struct orig_node *orig_node =3D (struct orig_node *) data;
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
-	struct orig_node *orig_node =3D (struct orig_node *)data;
=20
+	hna_global_del_orig(orig_node, "originator timeout");
+
+	spin_lock(&orig_node->lock);
 	/* for all neighbours towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node =3D list_entry(list_pos, struct neigh_node, list);
=20
+		orig_unreference(neigh_node->orig_node);
+
 		list_del(list_pos);
 		kfree(neigh_node);
 	}
+	orig_node->router =3D NULL;
+	spin_unlock(&orig_node->lock);
=20
-	hna_global_del_orig(orig_node, "originator timed out");
-
-	kfree(orig_node->bcast_own);
-	kfree(orig_node->bcast_own_sum);
-	kfree(orig_node);
+	orig_unreference(orig_node);
 }
=20
-/* this function finds or creates an originator entry for the given
- * address if it does not exits */
-struct orig_node *get_orig_node(uint8_t *addr)
+struct orig_node *orig_node_create(uint8_t *addr)
 {
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
 	char orig_str[ETH_STR_LEN];
 	int size;
=20
-	orig_node =3D ((struct orig_node *)hash_find(orig_hash, addr));
-
-	if (orig_node !=3D NULL)
-		return orig_node;
-
 	addr_to_string(orig_str, addr);
 	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
=20
@@ -131,9 +197,12 @@
 	INIT_LIST_HEAD(&orig_node->neigh_list);
=20
 	memcpy(orig_node->orig, addr, ETH_ALEN);
+
+	orig_node->lock =3D __SPIN_LOCK_UNLOCKED(device_client->lock);
 	orig_node->router =3D NULL;
 	orig_node->batman_if =3D NULL;
 	orig_node->hna_buff =3D NULL;
+	atomic_set(&orig_node->refcnt, 1);
=20
 	size =3D num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
=20
@@ -155,7 +224,24 @@
 		else
 			orig_hash =3D swaphash;
 	}
+	return orig_node;
+}
=20
+/* this function finds or creates an originator entry for the given
+ * address if it does not exits */
+struct orig_node *get_orig_node(uint8_t *addr)
+{
+	struct orig_node *orig_node;
+
+	orig_node =3D orig_find(addr);
+
+	if (orig_node)
+		return orig_node;
+
+	orig_node =3D orig_node_create(addr);
+	if (orig_node)
+		orig_node =3D orig_reference(orig_node_create(addr));
+
 	return orig_node;
 }
=20
@@ -164,6 +250,7 @@
 {
 	struct list_head *list_pos, *list_pos_tmp;
 	char neigh_str[ETH_STR_LEN];
+	char orig_str[ETH_STR_LEN];
 	struct neigh_node *neigh_node;
 	bool neigh_purged =3D false;
=20
@@ -178,10 +265,14 @@
 			       (neigh_node->last_valid +
 				((PURGE_TIMEOUT * HZ) / 1000)))) {
=20
+			addr_to_string(orig_str, orig_node->orig);
 			addr_to_string(neigh_str, neigh_node->addr);
 			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, l=
ast_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
+			neigh_purged =3D true;
+			if (neigh_node =3D=3D orig_node->router)
+				orig_node->router =3D NULL;
=20
-			neigh_purged =3D true;
+			orig_unreference(neigh_node->orig_node);
 			list_del(list_pos);
 			kfree(neigh_node);
 		} else {
@@ -201,10 +292,10 @@
=20
 	addr_to_string(orig_str, orig_node->orig);
=20
+	spin_lock(&orig_node->lock);
 	if (time_after(jiffies,
 		       (orig_node->last_valid +
 			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
-
 		bat_dbg(DBG_BATMAN,
 			"Originator timeout: originator %s, last_valid %lu\n",
 			orig_str, (orig_node->last_valid / HZ));
@@ -215,28 +306,48 @@
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
 	}
+	spin_unlock(&orig_node->lock);
 	return false;
 }
=20
 void purge_orig(struct work_struct *work)
 {
 	struct hash_it_t *hashit =3D NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
=20
-	spin_lock(&orig_hash_lock);
=20
 	/* for all origins... */
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
-		orig_node =3D hashit->bucket->data;
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
+
 		if (purge_orig_node(orig_node)) {
 			hash_remove_bucket(orig_hash, hashit);
 			free_orig_node(orig_node);
 		}
 	}
=20
-	spin_unlock(&orig_hash_lock);
-
 	start_purge_timer();
 }
=20
=20
+/* iterates over the originator hash, automatically referencing acquired o=
rig_nodes.
+ * It also unreferences the last node if it is given.
+ *
+ * The calling function does not have to handle the orig_hash locks as thi=
s function
+ * does it. */
+struct orig_node *orig_hash_iterate(struct hash_it_t **hashit, struct orig=
_node *orig_node)
+{
+	if (orig_node)
+		orig_unreference(orig_node);
+
+	spin_lock(&orig_hash_lock);
+
+	*hashit =3D hash_iterate(orig_hash, *hashit);
+	if (*hashit)
+		orig_node =3D orig_reference((*hashit)->bucket->data);
+	else=20
+		orig_node =3D NULL;
+
+	spin_unlock(&orig_hash_lock);
+
+	return orig_node;
+}
Index: batman-adv-kernelland/originator.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/originator.h	(revision 1489)
+++ batman-adv-kernelland/originator.h	(working copy)
@@ -19,6 +19,8 @@
  *
  */
=20
+extern spinlock_t orig_hash_lock;
+
 int originator_init(void);
 void free_orig_node(void *data);
 void originator_free(void);
@@ -28,4 +30,8 @@
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_=
node,
 		uint8_t *neigh, struct batman_if *if_incoming);
+struct orig_node *orig_reference(struct orig_node *orig);
+struct orig_node *orig_unreference(struct orig_node *orig);
+struct orig_node *orig_find(char *mac);
+struct orig_node *orig_hash_iterate(struct hash_it_t **hashit, struct orig=
_node *orig_node);
=20
Index: batman-adv-kernelland/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/main.c	(revision 1489)
+++ batman-adv-kernelland/main.c	(working copy)
@@ -23,7 +23,6 @@
 #include "proc.h"
 #include "routing.h"
 #include "send.h"
-#include "originator.h"
 #include "soft-interface.h"
 #include "device.h"
 #include "translation-table.h"
@@ -31,6 +30,7 @@
 #include "types.h"
 #include "vis.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
=20
 struct list_head if_list;
@@ -38,7 +38,6 @@
 struct hlist_head forw_bcast_list;
 struct hashtable_t *orig_hash;
=20
-DEFINE_SPINLOCK(orig_hash_lock);
 DEFINE_SPINLOCK(forw_bat_list_lock);
 DEFINE_SPINLOCK(forw_bcast_list_lock);
=20
Index: batman-adv-kernelland/routing.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/routing.c	(revision 1489)
+++ batman-adv-kernelland/routing.c	(working copy)
@@ -38,24 +38,21 @@
=20
 static atomic_t data_ready_cond;
 atomic_t exit_cond;
+
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct hash_it_t *hashit =3D NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node =3D NULL;
 	TYPE_OF_WORD *word;
=20
-	spin_lock(&orig_hash_lock);
+	while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
=20
-	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
-		orig_node =3D hashit->bucket->data;
 		word =3D &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
=20
 		bit_get_packet(word, 1, 0);
 		orig_node->bcast_own_sum[batman_if->if_num] =3D
 			bit_packet_count(word);
 	}
-
-	spin_unlock(&orig_hash_lock);
 }
=20
 static void update_HNA(struct orig_node *orig_node,
@@ -131,6 +128,8 @@
 		update_HNA(orig_node, hna_buff, hna_buff_len);
 }
=20
+/* TODO: rename and comment this function */
+/* TODO: review referencing here */
 static int isBidirectionalNeigh(struct orig_node *orig_node,
 				struct orig_node *orig_neigh_node,
 				struct batman_packet *batman_packet,
@@ -144,25 +143,29 @@
 	addr_to_string(neigh_str, orig_neigh_node->orig);
=20
 	if (orig_node =3D=3D orig_neigh_node) {
+		spin_lock(&orig_node->lock);
 		list_for_each_entry(tmp_neigh_node,
 				    &orig_node->neigh_list,
 				    list) {
=20
 			if (compare_orig(tmp_neigh_node->addr,
-					 orig_neigh_node->orig) &&
+					 orig_node->orig) &&
 			    (tmp_neigh_node->if_incoming =3D=3D if_incoming))
 				neigh_node =3D tmp_neigh_node;
 		}
=20
 		if (neigh_node =3D=3D NULL)
 			neigh_node =3D create_neighbor(orig_node,
-						     orig_neigh_node,
-						     orig_neigh_node->orig,
+						     orig_node,
+						     orig_node->orig,
 						     if_incoming);
=20
 		neigh_node->last_valid =3D jiffies;
+		spin_unlock(&orig_node->lock);
 	} else {
 		/* find packet count of corresponding one hop neighbor */
+		spin_lock(&orig_neigh_node->lock);
+
 		list_for_each_entry(tmp_neigh_node,
 				    &orig_neigh_node->neigh_list, list) {
=20
@@ -177,6 +180,7 @@
 						     orig_neigh_node,
 						     orig_neigh_node->orig,
 						     if_incoming);
+		spin_unlock(&orig_neigh_node->lock);
 	}
=20
 	orig_node->last_valid =3D jiffies;
@@ -239,6 +243,7 @@
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
 {
+	struct orig_node *source_orig_node;
 	struct neigh_node *neigh_node =3D NULL, *tmp_neigh_node =3D NULL;
 	int tmp_hna_buff_len;
=20
@@ -260,11 +265,13 @@
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 	}
=20
-	if (neigh_node =3D=3D NULL)
+	if (neigh_node =3D=3D NULL) {
+		source_orig_node =3D get_orig_node(ethhdr->h_source);
 		neigh_node =3D create_neighbor(orig_node,
-					     get_orig_node(ethhdr->h_source),
+					     source_orig_node,
 					     ethhdr->h_source, if_incoming);
-	else
+		orig_unreference(source_orig_node);
+	} else
 		bat_dbg(DBG_BATMAN,
 			"Updating existing last-hop neighbour of originator\n");
=20
@@ -323,6 +330,7 @@
 	if (orig_node =3D=3D NULL)
 		return 0;
=20
+	spin_lock(&orig_node->lock);
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
=20
 		if (!is_duplicate)
@@ -346,10 +354,13 @@
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno =3D batman_packet->seqno;
 	}
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
=20
 	return is_duplicate;
 }
=20
+/* receive and handle one batman packet */
 void receive_bat_packet(struct ethhdr *ethhdr,
 			struct batman_packet *batman_packet,
 			unsigned char *hna_buff,
@@ -448,10 +459,13 @@
 		 * come via the corresponding interface */
 		/* if received seqno equals last send seqno save new
 		 * seqno for bidirectional check */
+
+		spin_lock(&orig_neigh_node->lock);
 		if (has_directlink_flag &&
 		    compare_orig(if_incoming->net_dev->dev_addr,
 				 batman_packet->orig) &&
 		    (batman_packet->seqno - if_incoming_seqno + 2 =3D=3D 0)) {
+
 			offset =3D if_incoming->if_num * NUM_WORDS;
 			word =3D &(orig_neigh_node->bcast_own[offset]);
 			bit_mark(word, 0);
@@ -459,6 +473,9 @@
 				bit_packet_count(word);
 		}
=20
+		spin_unlock(&orig_neigh_node->lock);
+		orig_unreference(orig_neigh_node);
+
 		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via nei=
ghbour) \n");
 		return;
 	}
@@ -481,6 +498,8 @@
 	if (orig_node =3D=3D NULL)
 		return;
=20
+	spin_lock(&orig_node->lock);
+
 	/* avoid temporary routing loops */
 	if ((orig_node->router) &&
 	    (orig_node->router->orig_node->router) &&
@@ -489,36 +508,49 @@
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
+
 		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that =
may make me loop (sender: %s) \n", neigh_str);
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 		return;
 	}
+	spin_unlock(&orig_node->lock);
=20
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac */
 	orig_neigh_node =3D (is_single_hop_neigh ?
-			   orig_node : get_orig_node(ethhdr->h_source));
-	if (orig_neigh_node =3D=3D NULL)
+			   orig_reference(orig_node) : get_orig_node(ethhdr->h_source));
+	if (orig_neigh_node =3D=3D NULL) {
+		orig_unreference(orig_node);
 		return;
+	}
=20
 	/* drop packet if sender is not a direct neighbor and if we
 	 * don't route towards it */
 	if (!is_single_hop_neigh &&
 	    (orig_neigh_node->router =3D=3D NULL)) {
 		bat_dbg(DBG_BATMAN, "Drop packet: OGM via unknown neighbor!\n");
+
+		orig_unreference(orig_node);
+		orig_unreference(orig_neigh_node);
 		return;
 	}
=20
 	is_bidirectional =3D isBidirectionalNeigh(orig_node, orig_neigh_node,
 						batman_packet, if_incoming);
+	orig_unreference(orig_neigh_node);
=20
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate */
+	spin_lock(&orig_node->lock);
 	if (is_bidirectional &&
 	    (!is_duplicate ||
 	     ((orig_node->last_real_seqno =3D=3D batman_packet->seqno) &&
 	      (orig_node->last_ttl - 3 <=3D batman_packet->ttl))))
 		update_orig(orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
+	spin_unlock(&orig_node->lock);
=20
 	/* is single hop (direct) neighbour */
 	if (is_single_hop_neigh) {
@@ -528,6 +560,7 @@
 					1, hna_buff_len, if_incoming);
=20
 		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbour packet wit=
h direct link flag\n");
+		orig_unreference(orig_node);
 		return;
 	}
=20
@@ -535,11 +568,13 @@
 	if (!is_bidirectional) {
 		bat_dbg(DBG_BATMAN,
 			"Drop packet: not received via bidirectional link\n");
+		orig_unreference(orig_node);
 		return;
 	}
=20
 	if (is_duplicate) {
 		bat_dbg(DBG_BATMAN, "Drop packet: duplicate packet received\n");
+		orig_unreference(orig_node);
 		return;
 	}
=20
@@ -547,6 +582,7 @@
 		"Forwarding packet: rebroadcast originator packet\n");
 	schedule_forward_packet(orig_node, ethhdr, batman_packet,
 				0, hna_buff_len, if_incoming);
+	orig_unreference(orig_node);
 }
=20
=20
@@ -585,12 +621,10 @@
 	if (result < sizeof(struct ethhdr) + sizeof(struct batman_packet))
 		return;
=20
-	spin_lock(&orig_hash_lock);
 	receive_aggr_bat_packet(ethhdr,
 				packet_buff + sizeof(struct ethhdr),
 				result - sizeof(struct ethhdr),
 				batman_if);
-	spin_unlock(&orig_hash_lock);
 }
=20
 static void recv_my_icmp_packet(struct ethhdr *ethhdr,
@@ -608,25 +642,28 @@
=20
 	/* answer echo request (ping) */
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)hash_find(orig_hash,
-						   icmp_packet->orig));
+	orig_node =3D orig_find(icmp_packet->orig);
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
-		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
-		icmp_packet->msg_type =3D ECHO_REPLY;
-		icmp_packet->ttl =3D TTL;
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
=20
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+		if ((orig_node->batman_if !=3D NULL) &&
+		    (orig_node->router !=3D NULL)) {
+			memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+			memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
+			icmp_packet->msg_type =3D ECHO_REPLY;
+			icmp_packet->ttl =3D TTL;
+=09
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
=20
-	spin_unlock(&orig_hash_lock);
 	return;
 }
=20
@@ -642,33 +679,32 @@
 	addr_to_string(src_str, icmp_packet->orig);
 	addr_to_string(dst_str, icmp_packet->dst);
=20
-	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %s=
: ttl exceeded\n", src_str, dst_str);
-
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type !=3D ECHO_REQUEST)
 		return;
=20
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)
-		     hash_find(orig_hash, icmp_packet->orig));
+	orig_node =3D orig_find(icmp_packet->orig);
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
-		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
-		icmp_packet->msg_type =3D TTL_EXCEEDED;
-		icmp_packet->ttl =3D TTL;
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
=20
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+		if ((orig_node->batman_if !=3D NULL) &&
+		    (orig_node->router !=3D NULL)) {
+			memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+			memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
+			icmp_packet->msg_type =3D TTL_EXCEEDED;
+			icmp_packet->ttl =3D TTL;
=20
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
-
-	spin_unlock(&orig_hash_lock);
 }
=20
=20
@@ -713,24 +749,27 @@
 	}
=20
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)
-		     hash_find(orig_hash, icmp_packet->dst));
+	orig_node =3D orig_find(icmp_packet->dst);
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
=20
-		/* decrement ttl */
-		icmp_packet->ttl--;
+	    if ((orig_node->batman_if !=3D NULL) &&
+		    (orig_node->router !=3D NULL)) {
=20
-		/* route it */
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+			/* decrement ttl */
+			icmp_packet->ttl--;
+
+			/* route it */
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
+
 	}
-	spin_unlock(&orig_hash_lock);
 }
=20
 static void recv_unicast_packet(struct ethhdr *ethhdr,
@@ -781,23 +820,26 @@
 	}
=20
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)
-		     hash_find(orig_hash, unicast_packet->dest));
+	orig_node =3D orig_find(unicast_packet->dest);
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
-		/* decrement ttl */
-		unicast_packet->ttl--;
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
=20
-		/* route it */
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+	    if ((orig_node->batman_if !=3D NULL) &&
+		    (orig_node->router !=3D NULL)) {
+			/* decrement ttl */
+			unicast_packet->ttl--;
+=09
+			/* route it */
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
-	spin_unlock(&orig_hash_lock);
 }
=20
=20
@@ -833,20 +875,19 @@
 	if (is_my_mac(bcast_packet->orig))
 		return;
=20
-	spin_lock(&orig_hash_lock);
-	orig_node =3D ((struct orig_node *)
-		     hash_find(orig_hash, bcast_packet->orig));
+	orig_node =3D orig_find(bcast_packet->orig);
=20
-	if (orig_node =3D=3D NULL) {
-		spin_unlock(&orig_hash_lock);
+	if (!orig_node)
 		return;
-	}
=20
+	spin_lock(&orig_node->lock);
+
 	/* check flood history */
 	if (get_bit_status(orig_node->bcast_bits,
 			   orig_node->last_bcast_seqno,
 			   ntohs(bcast_packet->seqno))) {
-		spin_unlock(&orig_hash_lock);
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 		return;
 	}
=20
@@ -856,7 +897,8 @@
 			   orig_node->last_bcast_seqno, 1))
 		orig_node->last_bcast_seqno =3D ntohs(bcast_packet->seqno);
=20
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
=20
 	/* broadcast for me */
 	interface_rx(soft_device, packet_buff + hdr_size, result - hdr_size);
Index: batman-adv-kernelland/main.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/main.h	(revision 1489)
+++ batman-adv-kernelland/main.h	(working copy)
@@ -124,7 +124,6 @@
 extern struct hlist_head forw_bcast_list;
 extern struct hashtable_t *orig_hash;
=20
-extern spinlock_t orig_hash_lock;
 extern spinlock_t forw_bat_list_lock;
 extern spinlock_t forw_bcast_list_lock;
=20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksS1Q4ACgkQrzg/fFk7axZOkQCff0+tDVosV/cuGKiE2Rhzhiy8
6JsAoLefbHgi7wiOy8cwmksjqtN7m+Uu
=7Dum
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
