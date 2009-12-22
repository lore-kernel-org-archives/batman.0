Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 23 Dec 2009 00:17:26 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091222231726.GA23462@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: receive packets directly using
	skbs
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch removes the (ugly and racy) packet receiving thread and the=20
kernel socket usage. Instead, packets are received directly by registering=
=20
the ethernet type and handling skbs instead of self-allocated buffers.=20

Some consequences and comments:
 * we don't copy the payload data when forwarding/sending/receiving data=20
   anymore. This should boost performance.
 * packets from/to different interfaces can be (theoretically) processed
   simultaneously. Only the big originator hash lock might be in the way.
 * this might introduce new race conditions.
 * aggregation and vis code still use packet buffers and are not (yet)=20
   converted.

This is the first version of this patch to be released, i would consider
it experimental and would hereby like to as for reviews before committing
it. Some things you might want to test:

 * performace differences (are there any?)
 * do all components still work? (vis, batctl ping, ...)
 * do high load situations or multiple interfaces cause problems
 * any memory leaks i might have overlooked?

I did some tests on my 9 node qemu environment and could confirm that=20
usual sending/receiving, forwarding, vis, batctl ping etc works. However
i can not talk about the performance from this setup.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
Index: a/batman-adv-kernelland/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/types.h	(revision 1507)
+++ b/batman-adv-kernelland/types.h	(working copy)
@@ -39,7 +39,6 @@
 	char if_active;
 	char addr_str[ETH_STR_LEN];
 	struct net_device *net_dev;
-	struct socket *raw_sock;
 	atomic_t seqno;
 	unsigned char *packet_buff;
 	int packet_len;
@@ -113,6 +112,7 @@
 	struct hlist_node list;
 	unsigned long send_time;
 	uint8_t own;
+	struct sk_buff *skb;
 	unsigned char *packet_buff;
 	uint16_t packet_len;
 	uint32_t direct_link_flags;
Index: a/batman-adv-kernelland/send.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/send.c	(revision 1507)
+++ b/batman-adv-kernelland/send.c	(working copy)
@@ -58,25 +58,53 @@
 	return send_time;
 }
=20
-/* sends a raw packet. */
-void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
-		     struct batman_if *batman_if, uint8_t *dst_addr)
+/* send out an already prepared packet to the given address via the
+ * specified batman interface */
+int send_skb_packet(struct sk_buff *skb,
+				struct batman_if *batman_if,
+				uint8_t *dst_addr)
 {
 	struct ethhdr *ethhdr;
-	struct sk_buff *skb;
-	int retval;
-	char *data;
=20
 	if (batman_if->if_active !=3D IF_ACTIVE)
-		return;
+		goto send_skb_err;
=20
+	if (unlikely(!batman_if->net_dev))
+		goto send_skb_err;
+
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
 		printk(KERN_WARNING
 		       "batman-adv:Interface %s is not up - can't send packet via that i=
nterface!\n",
 		       batman_if->dev);
-		return;
+		goto send_skb_err;
 	}
=20
+
+	ethhdr =3D (struct ethhdr *) skb_mac_header(skb);
+	memcpy(ethhdr->h_source, batman_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(ethhdr->h_dest, dst_addr, ETH_ALEN);
+	ethhdr->h_proto =3D __constant_htons(ETH_P_BATMAN);
+
+	skb->dev =3D batman_if->net_dev;
+
+	/* dev_queue_xmit() returns a negative result on error.	 However on
+	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
+	 * (which is > 0). This will not be treated as an error. */
+
+	return dev_queue_xmit(skb);
+send_skb_err:
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
+
+/* sends a raw packet. */
+void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
+		     struct batman_if *batman_if, uint8_t *dst_addr)
+{
+	struct sk_buff *skb;
+	char *data;
+
+
 	skb =3D dev_alloc_skb(pack_buff_len + sizeof(struct ethhdr));
 	if (!skb)
 		return;
@@ -84,25 +112,12 @@
=20
 	memcpy(data + sizeof(struct ethhdr), pack_buff, pack_buff_len);
=20
-	ethhdr =3D (struct ethhdr *) data;
-	memcpy(ethhdr->h_source, batman_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(ethhdr->h_dest, dst_addr, ETH_ALEN);
-	ethhdr->h_proto =3D __constant_htons(ETH_P_BATMAN);
-
 	skb_reset_mac_header(skb);
 	skb_set_network_header(skb, ETH_HLEN);
 	skb->priority =3D TC_PRIO_CONTROL;
 	skb->protocol =3D __constant_htons(ETH_P_BATMAN);
-	skb->dev =3D batman_if->net_dev;
=20
-	/* dev_queue_xmit() returns a negative result on error.	 However on
-	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
-	 * (which is > 0). This will not be treated as an error. */
-	retval =3D dev_queue_xmit(skb);
-	if (retval < 0)
-		printk(KERN_WARNING
-		       "batman-adv:Can't write to raw socket: %i\n",
-		       retval);
+	send_skb_packet(skb, batman_if, dst_addr);
 }
=20
 /* Send a packet to a given interface */
@@ -331,6 +346,8 @@
=20
 static void forw_packet_free(struct forw_packet *forw_packet)
 {
+	if (forw_packet->skb)
+		kfree_skb(forw_packet->skb);
 	kfree(forw_packet->packet_buff);
 	kfree(forw_packet);
 }
@@ -353,7 +370,7 @@
 			   send_time);
 }
=20
-void add_bcast_packet_to_list(unsigned char *packet_buff, int packet_len)
+void add_bcast_packet_to_list(struct sk_buff *skb)
 {
 	struct forw_packet *forw_packet;
=20
@@ -361,14 +378,14 @@
 	if (!forw_packet)
 		return;
=20
-	forw_packet->packet_buff =3D kmalloc(packet_len, GFP_ATOMIC);
-	if (!forw_packet->packet_buff) {
+	skb =3D skb_copy(skb, GFP_ATOMIC);
+	if (!skb) {
 		kfree(forw_packet);
 		return;
 	}
=20
-	forw_packet->packet_len =3D packet_len;
-	memcpy(forw_packet->packet_buff, packet_buff, forw_packet->packet_len);
+	forw_packet->skb =3D skb;
+	forw_packet->packet_buff =3D NULL;
=20
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets =3D 0;
@@ -384,6 +401,7 @@
 	struct forw_packet *forw_packet =3D
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
+	struct sk_buff *skb1;
=20
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -392,8 +410,10 @@
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		send_raw_packet(forw_packet->packet_buff,
-				forw_packet->packet_len,
+		/* send a copy of the saved skb */
+		skb1 =3D skb_copy(forw_packet->skb, GFP_ATOMIC);
+		if (skb1)
+			send_skb_packet(skb1,
 				batman_if, broadcastAddr);
 	}
 	rcu_read_unlock();
Index: a/batman-adv-kernelland/send.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/send.h	(revision 1507)
+++ b/batman-adv-kernelland/send.h	(working copy)
@@ -22,6 +22,9 @@
 #include "types.h"
=20
 void send_own_packet_work(struct work_struct *work);
+int send_skb_packet(struct sk_buff *skb,
+				struct batman_if *batman_if,
+				uint8_t *dst_addr);
 void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
 		     struct batman_if *batman_if, uint8_t *dst_addr);
 void schedule_own_packet(struct batman_if *batman_if);
@@ -30,7 +33,7 @@
 			     struct batman_packet *batman_packet,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
-void add_bcast_packet_to_list(unsigned char *packet_buff, int packet_len);
+void add_bcast_packet_to_list(struct sk_buff *skb);
 void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(void);
Index: a/batman-adv-kernelland/soft-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/soft-interface.c	(revision 1507)
+++ b/batman-adv-kernelland/soft-interface.c	(working copy)
@@ -34,7 +34,6 @@
 				  * broadcast storms */
 static int32_t skb_packets;
 static int32_t skb_bad_packets;
-static int32_t lock_dropped;
=20
 unsigned char mainIfAddr[ETH_ALEN];
 static unsigned char mainIfAddr_default[ETH_ALEN];
@@ -169,6 +168,8 @@
 	struct orig_node *orig_node;
 	struct ethhdr *ethhdr =3D (struct ethhdr *)skb->data;
 	struct bat_priv *priv =3D netdev_priv(dev);
+	struct batman_if *batman_if;
+	uint8_t dstaddr[6];
 	int data_len =3D skb->len;
=20
 	if (atomic_read(&module_state) !=3D MODULE_ACTIVE)
@@ -181,11 +182,16 @@
 	/* ethernet packet should be broadcasted */
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
=20
-		if (my_skb_push(skb, sizeof(struct bcast_packet)) < 0)
+		if (my_skb_push(skb, sizeof(struct bcast_packet)
+				+ sizeof(struct ethhdr)) < 0)
 			goto dropped;
=20
-		bcast_packet =3D (struct bcast_packet *)skb->data;
+		skb_reset_mac_header(skb);
=20
+
+		bcast_packet =3D (struct bcast_packet *)(skb->data
+					+ sizeof(struct ethhdr));
+
 		bcast_packet->version =3D COMPAT_VERSION;
=20
 		/* batman packet type: broadcast */
@@ -194,27 +200,21 @@
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
 		memcpy(bcast_packet->orig, mainIfAddr, ETH_ALEN);
+
 		/* set broadcast sequence number */
 		bcast_packet->seqno =3D htons(bcast_seqno);
=20
 		bcast_seqno++;
=20
 		/* broadcast packet */
-		add_bcast_packet_to_list(skb->data, skb->len);
+		add_bcast_packet_to_list(skb);
+		/* a copy is stored in the bcast list, therefore removing
+		 * the original skb. */
+		kfree_skb(skb);
=20
 	/* unicast packet */
 	} else {
-
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
+		spin_lock(&orig_hash_lock);
 		/* get routing information */
 		orig_node =3D ((struct orig_node *)hash_find(orig_hash,
 							   ethhdr->h_dest));
@@ -226,11 +226,15 @@
 		if ((orig_node) &&
 		    (orig_node->batman_if) &&
 		    (orig_node->router)) {
-			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
+			if (my_skb_push(skb, sizeof(struct unicast_packet)
+					+ sizeof(struct ethhdr)) < 0)
 				goto unlock;
=20
-			unicast_packet =3D (struct unicast_packet *)skb->data;
+			skb_reset_mac_header(skb);
=20
+			unicast_packet =3D (struct unicast_packet *)(skb->data
+					+ sizeof(struct ethhdr));
+
 			unicast_packet->version =3D COMPAT_VERSION;
 			/* batman packet type: unicast */
 			unicast_packet->packet_type =3D BAT_UNICAST;
@@ -243,14 +247,17 @@
 			if (orig_node->batman_if->if_active !=3D IF_ACTIVE)
 				goto unlock;
=20
-			send_raw_packet(skb->data, skb->len,
-					orig_node->batman_if,
-					orig_node->router->addr);
+			/* don't lock while sending the packets ... we therefore
+			 * copy the required data before sending */
+
+			batman_if =3D orig_node->batman_if;
+			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+			spin_unlock(&orig_hash_lock);
+
+			send_skb_packet(skb, batman_if, dstaddr);
 		} else {
 			goto unlock;
 		}
-
-		spin_unlock(&orig_hash_lock);
 	}
=20
 	priv->stats.tx_packets++;
@@ -262,38 +269,40 @@
 dropped:
 	priv->stats.tx_dropped++;
 end:
-	kfree_skb(skb);
 	return 0;
 }
=20
-void interface_rx(struct net_device *dev, void *packet, int packet_len)
+void interface_rx(struct sk_buff *skb, int hdr_size)
 {
-	struct sk_buff *skb;
+	struct net_device *dev =3D soft_device;
 	struct bat_priv *priv =3D netdev_priv(dev);
=20
-	skb =3D dev_alloc_skb(packet_len);
-
-	if (!skb) {
-		priv->stats.rx_dropped++;
-		goto out;
+	/* check if enough space is available for pulling, and pull */
+	if (!pskb_may_pull(skb, hdr_size)) {
+		kfree(skb);
+		return;
 	}
+	skb_pull_rcsum(skb, hdr_size);
+/*	skb_set_mac_header(skb, -sizeof(struct ethhdr));*/
=20
-	memcpy(skb_put(skb, packet_len), packet, packet_len);
-
-	/* Write metadata, and then pass to the receive level */
 	skb->dev =3D dev;
 	skb->protocol =3D eth_type_trans(skb, dev);
-	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
=20
+	/* should not be neccesary anymore as we use skb_pull_rcsum()
+	 * TODO: please verify this and remove this TODO
+	 * Dec 21st 2009, Simon Wunderlich */
+
+/*	skb->ip_summed =3D CHECKSUM_UNNECESSARY;*/
+
+	/* TODO: set skb->pkt_type to PACKET_BROADCAST, PACKET_MULTICAST,
+	 * PACKET_OTHERHOST or PACKET_HOST */
+
 	priv->stats.rx_packets++;
-	priv->stats.rx_bytes +=3D packet_len;
+	priv->stats.rx_bytes +=3D skb->len;
=20
 	dev->last_rx =3D jiffies;
=20
 	netif_rx(skb);
-
-out:
-	return;
 }
=20
 /* ethtool */
Index: a/batman-adv-kernelland/hard-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/hard-interface.c	(revision 1507)
+++ b/batman-adv-kernelland/hard-interface.c	(working copy)
@@ -153,9 +153,6 @@
 	if (batman_if->if_active !=3D IF_ACTIVE)
 		return;
=20
-	if (batman_if->raw_sock)
-		sock_release(batman_if->raw_sock);
-
 	/**
 	 * batman_if->net_dev has been acquired by dev_get_by_name() in
 	 * proc_interfaces_write() and has to be unreferenced.
@@ -164,9 +161,6 @@
 	if (batman_if->net_dev)
 		dev_put(batman_if->net_dev);
=20
-	batman_if->raw_sock =3D NULL;
-	batman_if->net_dev =3D NULL;
-
 	batman_if->if_active =3D IF_INACTIVE;
 	active_ifs--;
=20
@@ -177,9 +171,6 @@
 /* (re)activate given interface. */
 static void hardif_activate_interface(struct batman_if *batman_if)
 {
-	struct sockaddr_ll bind_addr;
-	int retval;
-
 	if (batman_if->if_active !=3D IF_INACTIVE)
 		return;
=20
@@ -191,35 +182,8 @@
 	if (!batman_if->net_dev)
 		goto dev_err;
=20
-	retval =3D sock_create_kern(PF_PACKET, SOCK_RAW,
-				  __constant_htons(ETH_P_BATMAN),
-				  &batman_if->raw_sock);
-
-	if (retval < 0) {
-		printk(KERN_ERR "batman-adv:Can't create raw socket: %i\n",
-			  retval);
-		goto sock_err;
-	}
-
-	bind_addr.sll_family =3D AF_PACKET;
-	bind_addr.sll_ifindex =3D batman_if->net_dev->ifindex;
-	bind_addr.sll_protocol =3D 0;	/* is set by the kernel */
-
-	retval =3D kernel_bind(batman_if->raw_sock,
-			     (struct sockaddr *)&bind_addr, sizeof(bind_addr));
-
-	if (retval < 0) {
-		printk(KERN_ERR "batman-adv:Can't create bind raw socket: %i\n",
-			  retval);
-		goto bind_err;
-	}
-
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
=20
-	batman_if->raw_sock->sk->sk_user_data =3D
-		batman_if->raw_sock->sk->sk_data_ready;
-	batman_if->raw_sock->sk->sk_data_ready =3D batman_data_ready;
-
 	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
=20
 	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
@@ -239,12 +203,7 @@
=20
 	return;
=20
-bind_err:
-	sock_release(batman_if->raw_sock);
-sock_err:
-	dev_put(batman_if->net_dev);
 dev_err:
-	batman_if->raw_sock =3D NULL;
 	batman_if->net_dev =3D NULL;
 }
=20
@@ -327,7 +286,6 @@
 		return -1;
 	}
=20
-	batman_if->raw_sock =3D NULL;
 	batman_if->net_dev =3D NULL;
=20
 	if ((if_num =3D=3D 0) && (num_hna > 0))
@@ -443,6 +401,112 @@
 	return NOTIFY_DONE;
 }
=20
+/* find batman interface by netdev. assumes rcu_read_lock on */
+struct batman_if *find_batman_if(struct net_device *dev)
+{
+	struct batman_if *batman_if;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if (batman_if->net_dev =3D=3D dev) {
+			rcu_read_unlock();
+			return batman_if;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
+
+/* receive a packet with the batman ethertype coming on a hard
+ * interface */
+int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
+	struct packet_type *ptype, struct net_device *orig_dev)
+{
+	struct batman_packet *batman_packet;
+	struct batman_if *batman_if;
+	struct net_device_stats *stats;
+	int ret;
+
+    skb =3D skb_share_check(skb, GFP_ATOMIC);
+
+    if (skb =3D=3D NULL)
+		goto err_free;
+
+	/* packet should hold at least type and version */
+	if (unlikely(skb->len < 2))
+		goto err_free;
+
+	batman_if =3D find_batman_if(skb->dev);
+	if (!batman_if)
+		goto err_free;
+
+    stats =3D &skb->dev->stats;
+    stats->rx_packets++;
+    stats->rx_bytes +=3D skb->len;
+
+
+	/* push back, we want to look at the ethernet header as well. */
+	skb_push(skb, sizeof(struct ethhdr));
+	skb_reset_mac_header(skb);
+
+	batman_packet =3D (struct batman_packet *)(skb->data
+					+ sizeof(struct ethhdr));
+
+	if (batman_packet->version !=3D COMPAT_VERSION) {
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: incompatible batman version (%i)\n",
+			batman_packet->version);
+		goto err_free;
+	}
+
+	/* all receive handlers return whether they received or reused
+	 * the supplied skb. if not, we have to free the skb. */
+
+	switch (batman_packet->packet_type) {
+		/* batman originator packet */
+	case BAT_PACKET:
+		ret =3D recv_bat_packet(skb, batman_if);
+		break;
+
+		/* batman icmp packet */
+	case BAT_ICMP:
+		ret =3D recv_icmp_packet(skb);
+		break;
+
+		/* unicast packet */
+	case BAT_UNICAST:
+		ret =3D recv_unicast_packet(skb);
+		break;
+
+		/* broadcast packet */
+	case BAT_BCAST:
+		ret =3D recv_bcast_packet(skb);
+		break;
+
+		/* vis packet */
+	case BAT_VIS:
+		ret =3D recv_vis_packet(skb);
+		break;
+	default:
+		ret =3D NET_RX_DROP;
+	}
+	if (ret =3D=3D NET_RX_DROP)
+		kfree(skb);
+
+	/* return NET_RX_SUCCESS in any case as we
+	 * most probably dropped the packet for
+	 * routing-logical reasons. */
+
+	return NET_RX_SUCCESS;
+
+err_free:
+    kfree_skb(skb);
+    return NET_RX_DROP;
+
+}
+
+
 struct notifier_block hard_if_notifier =3D {
 	.notifier_call =3D hard_if_event,
 };
Index: a/batman-adv-kernelland/soft-interface.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/soft-interface.h	(revision 1507)
+++ b/batman-adv-kernelland/soft-interface.h	(working copy)
@@ -28,6 +28,6 @@
 int interface_set_mac_addr(struct net_device *dev, void *addr);
 int interface_change_mtu(struct net_device *dev, int new_mtu);
 int interface_tx(struct sk_buff *skb, struct net_device *dev);
-void interface_rx(struct net_device *dev, void *packet, int packet_len);
+void interface_rx(struct sk_buff *skb, int hdr_size);
=20
 extern unsigned char mainIfAddr[];
Index: a/batman-adv-kernelland/hard-interface.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/hard-interface.h	(revision 1507)
+++ b/batman-adv-kernelland/hard-interface.h	(working copy)
@@ -32,5 +32,9 @@
 char hardif_get_active_if_num(void);
 void hardif_check_interfaces_status(void);
 void hardif_check_interfaces_status_wq(struct work_struct *work);
+int batman_skb_recv(struct sk_buff *skb,
+				struct net_device *dev,
+				struct packet_type *ptype,
+				struct net_device *orig_dev);
 int hardif_min_mtu(void);
 void update_min_mtu(void);
Index: a/batman-adv-kernelland/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/main.c	(revision 1507)
+++ b/batman-adv-kernelland/main.c	(working copy)
@@ -50,11 +50,14 @@
=20
 struct net_device *soft_device;
=20
-static struct task_struct *kthread_task;
-
 unsigned char broadcastAddr[] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 atomic_t module_state;
=20
+static struct packet_type batman_adv_packet_type __read_mostly =3D {
+	.type =3D cpu_to_be16(ETH_P_BATMAN),
+	.func =3D batman_skb_recv,
+};
+
 struct workqueue_struct *bat_event_workqueue;
=20
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -113,6 +116,7 @@
 	}
=20
 	register_netdevice_notifier(&hard_if_notifier);
+	dev_add_pack(&batman_adv_packet_type);
=20
 	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility ve=
rsion %i) loaded \n",
 		  SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
@@ -135,6 +139,8 @@
 		soft_device =3D NULL;
 	}
=20
+	dev_remove_pack(&batman_adv_packet_type);
+
 	unregister_netdevice_notifier(&hard_if_notifier);
 	cleanup_procfs();
=20
@@ -162,16 +168,6 @@
 	if (vis_init() < 1)
 		goto err;
=20
-	/* (re)start kernel thread for packet processing */
-	if (!kthread_task) {
-		kthread_task =3D kthread_run(packet_recv_thread, NULL, "batman-adv");
-
-		if (IS_ERR(kthread_task)) {
-			printk(KERN_ERR "batman-adv:Unable to start packet receive thread\n");
-			kthread_task =3D NULL;
-		}
-	}
-
 	update_min_mtu();
 	atomic_set(&module_state, MODULE_ACTIVE);
 	goto end;
@@ -193,15 +189,8 @@
=20
 	vis_quit();
=20
-	/* deactivate kernel thread for packet processing (if running) */
-	if (kthread_task) {
-		atomic_set(&exit_cond, 1);
-		wake_up_interruptible(&thread_wait);
-		kthread_stop(kthread_task);
+	/* TODO: unregister BATMAN pack */
=20
-		kthread_task =3D NULL;
-	}
-
 	originator_free();
=20
 	hna_local_free();
Index: a/batman-adv-kernelland/aggregation.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/aggregation.c	(revision 1507)
+++ b/batman-adv-kernelland/aggregation.c	(working copy)
@@ -115,6 +115,7 @@
 	       packet_buff,
 	       forw_packet_aggr->packet_len);
=20
+	forw_packet_aggr->skb =3D NULL;
 	forw_packet_aggr->own =3D own_packet;
 	forw_packet_aggr->if_incoming =3D if_incoming;
 	forw_packet_aggr->num_packets =3D 0;
Index: a/batman-adv-kernelland/routing.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/routing.c	(revision 1507)
+++ b/batman-adv-kernelland/routing.c	(working copy)
@@ -36,8 +36,8 @@
=20
 DECLARE_WAIT_QUEUE_HEAD(thread_wait);
=20
-static atomic_t data_ready_cond;
 atomic_t exit_cond;
+
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	HASHIT(hashit);
@@ -351,10 +351,9 @@
 }
=20
 void receive_bat_packet(struct ethhdr *ethhdr,
-			struct batman_packet *batman_packet,
-			unsigned char *hna_buff,
-			int hna_buff_len,
-			struct batman_if *if_incoming)
+				struct batman_packet *batman_packet,
+				unsigned char *hna_buff, int hna_buff_len,
+				struct batman_if *if_incoming)
 {
 	struct batman_if *batman_if;
 	struct orig_node *orig_neigh_node, *orig_node;
@@ -549,61 +548,51 @@
 				0, hna_buff_len, if_incoming);
 }
=20
-
-static int receive_raw_packet(struct socket *raw_sock,
-			      unsigned char *packet_buff, int packet_buff_len)
+int recv_bat_packet(struct sk_buff *skb,
+				struct batman_if *batman_if)
 {
-	struct kvec iov;
-	struct msghdr msg;
+	struct ethhdr *ethhdr;
=20
-	iov.iov_base =3D packet_buff;
-	iov.iov_len =3D packet_buff_len;
+	/* drop packet if it has not necessary minimum size */
+	if (skb->len < sizeof(struct batman_packet))
+		return NET_RX_DROP;
=20
-	msg.msg_flags =3D MSG_DONTWAIT;	/* non-blocking */
-	msg.msg_name =3D NULL;
-	msg.msg_namelen =3D 0;
-	msg.msg_control =3D NULL;
+	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
=20
-	return kernel_recvmsg(raw_sock, &msg, &iov, 1, packet_buff_len,
-			      MSG_DONTWAIT);
-}
-
-static void recv_bat_packet(struct ethhdr *ethhdr,
-			    unsigned char *packet_buff,
-			    int result,
-			    struct batman_if *batman_if)
-{
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_bcast(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
 	/* packet with broadcast sender address */
 	if (is_bcast(ethhdr->h_source))
-		return;
+		return NET_RX_DROP;
=20
-	/* drop packet if it has not at least one batman packet as payload */
-	if (result < sizeof(struct ethhdr) + sizeof(struct batman_packet))
-		return;
-
 	spin_lock(&orig_hash_lock);
 	receive_aggr_bat_packet(ethhdr,
-				packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
+				skb->data + sizeof(struct ethhdr),
+				skb->len - sizeof(struct ethhdr),
 				batman_if);
 	spin_unlock(&orig_hash_lock);
+
+	kfree_skb(skb);
+	return NET_RX_SUCCESS;
 }
=20
-static void recv_my_icmp_packet(struct ethhdr *ethhdr,
-				struct icmp_packet *icmp_packet,
-				unsigned char *packet_buff,
-				int result)
+static int recv_my_icmp_packet(struct sk_buff *skb)
 {
 	struct orig_node *orig_node;
+	struct icmp_packet *icmp_packet;
+	struct ethhdr *ethhdr;
+	int ret;
=20
+	icmp_packet =3D (struct icmp_packet *)
+			(skb->data + sizeof(struct ethhdr));
+	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
+
 	/* add data to device queue */
 	if (icmp_packet->msg_type !=3D ECHO_REQUEST) {
 		bat_device_receive_packet(icmp_packet);
-		return;
+		return NET_RX_DROP;
 	}
=20
 	/* answer echo request (ping) */
@@ -611,6 +600,7 @@
 	spin_lock(&orig_hash_lock);
 	orig_node =3D ((struct orig_node *)hash_find(orig_hash,
 						   icmp_packet->orig));
+	ret =3D NET_RX_DROP;
=20
 	if ((orig_node !=3D NULL) &&
 	    (orig_node->batman_if !=3D NULL) &&
@@ -620,25 +610,28 @@
 		icmp_packet->msg_type =3D ECHO_REPLY;
 		icmp_packet->ttl =3D TTL;
=20
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
+		send_skb_packet(skb,
 				orig_node->batman_if,
 				orig_node->router->addr);
+		ret =3D NET_RX_SUCCESS;
 	}
=20
 	spin_unlock(&orig_hash_lock);
-	return;
+	return ret;
 }
=20
-static void recv_icmp_ttl_exceeded(struct icmp_packet *icmp_packet,
-				   struct ethhdr *ethhdr,
-				   unsigned char *packet_buff,
-				   int result,
-				   struct batman_if *batman_if)
+static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 {
 	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
 	struct orig_node *orig_node;
+	struct icmp_packet *icmp_packet;
+	struct ethhdr *ethhdr;
+	int ret;
=20
+	icmp_packet =3D (struct icmp_packet *)
+			(skb->data + sizeof(ethhdr));
+	ethhdr =3D (struct ethhdr *) skb_mac_header(skb);
+
 	addr_to_string(src_str, icmp_packet->orig);
 	addr_to_string(dst_str, icmp_packet->dst);
=20
@@ -646,12 +639,13 @@
=20
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type !=3D ECHO_REQUEST)
-		return;
+		return NET_RX_DROP;
=20
 	/* get routing information */
 	spin_lock(&orig_hash_lock);
 	orig_node =3D ((struct orig_node *)
 		     hash_find(orig_hash, icmp_packet->orig));
+	ret =3D NET_RX_DROP;
=20
 	if ((orig_node !=3D NULL) &&
 	    (orig_node->batman_if !=3D NULL) &&
@@ -661,57 +655,59 @@
 		icmp_packet->msg_type =3D TTL_EXCEEDED;
 		icmp_packet->ttl =3D TTL;
=20
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
+		send_skb_packet(skb,
 				orig_node->batman_if,
 				orig_node->router->addr);
+		ret =3D NET_RX_SUCCESS;
=20
 	}
=20
 	spin_unlock(&orig_hash_lock);
+	return ret;
 }
=20
=20
-
-static void recv_icmp_packet(struct ethhdr *ethhdr,
-			     unsigned char *packet_buff,
-			     int result,
-			     struct batman_if *batman_if)
+int recv_icmp_packet(struct sk_buff *skb)
 {
 	struct icmp_packet *icmp_packet;
+	struct ethhdr *ethhdr;
 	struct orig_node *orig_node;
+	int hdr_size =3D sizeof(struct icmp_packet) + sizeof(struct ethhdr);
+	int ret;
=20
+	/* drop packet if it has not necessary minimum size */
+	if (skb->len < hdr_size)
+		return NET_RX_DROP;
+
+	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
+
 	/* packet with unicast indication but broadcast recipient */
 	if (is_bcast(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
 	/* packet with broadcast sender address */
 	if (is_bcast(ethhdr->h_source))
-		return;
+		return NET_RX_DROP;
=20
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
-	/* drop packet if it has not necessary minimum size */
-	if (result < sizeof(struct ethhdr) + sizeof(struct icmp_packet))
-		return;
-
 	icmp_packet =3D (struct icmp_packet *)
-		(packet_buff + sizeof(struct ethhdr));
+			(skb->data + sizeof(struct ethhdr));
=20
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
-		recv_my_icmp_packet(ethhdr, icmp_packet, packet_buff, result);
+		return recv_my_icmp_packet(skb);
=20
 	/* TTL exceeded */
 	if (icmp_packet->ttl < 2) {
-		recv_icmp_ttl_exceeded(icmp_packet, ethhdr, packet_buff, result,
-				       batman_if);
-		return;
+		return recv_icmp_ttl_exceeded(skb);
=20
 	}
=20
+	ret =3D NET_RX_DROP;
+
 	/* get routing information */
 	spin_lock(&orig_hash_lock);
 	orig_node =3D ((struct orig_node *)
@@ -725,49 +721,51 @@
 		icmp_packet->ttl--;
=20
 		/* route it */
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
+		send_skb_packet(skb,
 				orig_node->batman_if,
 				orig_node->router->addr);
+		ret =3D NET_RX_SUCCESS;
 	}
 	spin_unlock(&orig_hash_lock);
+	return ret;
 }
=20
-static void recv_unicast_packet(struct ethhdr *ethhdr,
-				unsigned char *packet_buff,
-				int result,
-				struct batman_if *batman_if)
+int recv_unicast_packet(struct sk_buff *skb)
 {
 	struct unicast_packet *unicast_packet;
 	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
 	struct orig_node *orig_node;
-	int hdr_size =3D sizeof(struct ethhdr) + sizeof(struct unicast_packet);
+	struct ethhdr *ethhdr;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
+	int hdr_size =3D sizeof(struct unicast_packet) + sizeof(struct ethhdr);
+	int ret;
=20
+	/* drop packet if it has not necessary minimum size */
+	if (skb->len < hdr_size)
+		return NET_RX_DROP;
+
+	ethhdr =3D (struct ethhdr *) skb_mac_header(skb);
+
 	/* packet with unicast indication but broadcast recipient */
 	if (is_bcast(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
 	/* packet with broadcast sender address */
 	if (is_bcast(ethhdr->h_source))
-		return;
+		return NET_RX_DROP;
=20
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
-	/* drop packet if it has not necessary minimum size */
-	if (result < hdr_size)
-		return;
-
 	unicast_packet =3D (struct unicast_packet *)
-		(packet_buff + sizeof(struct ethhdr));
+			(skb->data + sizeof(struct ethhdr));
=20
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(soft_device, packet_buff + hdr_size,
-			     result - hdr_size);
-		return;
-
+		interface_rx(skb, hdr_size);
+		return NET_RX_SUCCESS;
 	}
=20
 	/* TTL exceeded */
@@ -777,9 +775,10 @@
 		addr_to_string(dst_str, unicast_packet->dest);
=20
 		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %=
s: ttl exceeded\n", src_str, dst_str);
-		return;
+		return NET_RX_DROP;
 	}
=20
+	ret =3D NET_RX_DROP;
 	/* get routing information */
 	spin_lock(&orig_hash_lock);
 	orig_node =3D ((struct orig_node *)
@@ -791,47 +790,52 @@
 		/* decrement ttl */
 		unicast_packet->ttl--;
=20
+		/* don't lock while sending the packets ... we therefore
+		 * copy the required data before sending */
+		batman_if =3D orig_node->batman_if;
+		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+		spin_unlock(&orig_hash_lock);
+
 		/* route it */
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
-	}
-	spin_unlock(&orig_hash_lock);
+		send_skb_packet(skb, batman_if, dstaddr);
+		ret =3D NET_RX_SUCCESS;
+	} else
+		spin_unlock(&orig_hash_lock);
+	return ret;
 }
=20
=20
-static void recv_bcast_packet(struct ethhdr *ethhdr,
-			      unsigned char *packet_buff,
-			      int result,
-			      struct batman_if *batman_if)
+int recv_bcast_packet(struct sk_buff *skb)
 {
 	struct orig_node *orig_node;
 	struct bcast_packet *bcast_packet;
-	int hdr_size =3D sizeof(struct ethhdr) + sizeof(struct bcast_packet);
+	struct ethhdr *ethhdr;
+	int hdr_size =3D sizeof(struct bcast_packet) + sizeof(struct ethhdr);
=20
+	/* drop packet if it has not necessary minimum size */
+	if (skb->len < hdr_size)
+		return NET_RX_DROP;
+
+	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
+
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_bcast(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
 	/* packet with broadcast sender address */
 	if (is_bcast(ethhdr->h_source))
-		return;
+		return NET_RX_DROP;
=20
-	/* drop packet if it has not necessary minimum size */
-	if (result < hdr_size)
-		return;
-
 	/* ignore broadcasts sent by myself */
 	if (is_my_mac(ethhdr->h_source))
-		return;
+		return NET_RX_DROP;
=20
 	bcast_packet =3D (struct bcast_packet *)
-		(packet_buff + sizeof(struct ethhdr));
+			(skb->data + sizeof(struct ethhdr));
=20
 	/* ignore broadcasts originated by myself */
 	if (is_my_mac(bcast_packet->orig))
-		return;
+		return NET_RX_DROP;
=20
 	spin_lock(&orig_hash_lock);
 	orig_node =3D ((struct orig_node *)
@@ -839,7 +843,7 @@
=20
 	if (orig_node =3D=3D NULL) {
 		spin_unlock(&orig_hash_lock);
-		return;
+		return NET_RX_DROP;
 	}
=20
 	/* check flood history */
@@ -847,7 +851,7 @@
 			   orig_node->last_bcast_seqno,
 			   ntohs(bcast_packet->seqno))) {
 		spin_unlock(&orig_hash_lock);
-		return;
+		return NET_RX_DROP;
 	}
=20
 	/* mark broadcast in flood history */
@@ -858,208 +862,56 @@
=20
 	spin_unlock(&orig_hash_lock);
=20
+	/* rebroadcast packet */
+	add_bcast_packet_to_list(skb);
+
 	/* broadcast for me */
-	interface_rx(soft_device, packet_buff + hdr_size, result - hdr_size);
+	interface_rx(skb, hdr_size);
=20
-	/* rebroadcast packet */
-	add_bcast_packet_to_list(packet_buff + sizeof(struct ethhdr),
-				 result - sizeof(struct ethhdr));
+	return NET_RX_SUCCESS;
 }
=20
-static void recv_vis_packet(struct ethhdr *ethhdr,
-			    unsigned char *packet_buff,
-			    int result)
+int recv_vis_packet(struct sk_buff *skb)
 {
 	struct vis_packet *vis_packet;
+	struct ethhdr *ethhdr;
 	int hdr_size =3D sizeof(struct ethhdr) + sizeof(struct vis_packet);
-	int vis_info_len;
+	int ret;
=20
-	/* drop if too short. */
-	if (result < hdr_size)
-		return;
+	if (skb->len < hdr_size)
+		return NET_RX_DROP;
=20
+	vis_packet =3D (struct vis_packet *)
+			(skb->data + sizeof(struct ethhdr));
+	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
+
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return;
+		return NET_RX_DROP;
=20
-	vis_packet =3D (struct vis_packet *)(packet_buff + sizeof(struct ethhdr));
-	vis_info_len =3D result  - hdr_size;
-
 	/* ignore own packets */
 	if (is_my_mac(vis_packet->vis_orig))
-		return;
+		return NET_RX_DROP;
=20
 	if (is_my_mac(vis_packet->sender_orig))
-		return;
+		return NET_RX_DROP;
=20
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
-		receive_server_sync_packet(vis_packet, vis_info_len);
+		receive_server_sync_packet(vis_packet, skb->len);
+		ret =3D NET_RX_SUCCESS;
 		break;
=20
 	case VIS_TYPE_CLIENT_UPDATE:
-		receive_client_update_packet(vis_packet, vis_info_len);
+		receive_client_update_packet(vis_packet, skb->len);
+		ret =3D NET_RX_SUCCESS;
 		break;
=20
 	default:	/* ignore unknown packet */
+		ret =3D NET_RX_DROP;
 		break;
 	}
+	return ret;
 }
=20
-static int recv_one_packet(struct batman_if *batman_if,
-			   unsigned char *packet_buff)
-{
-	int result;
-	struct ethhdr *ethhdr;
-	struct batman_packet *batman_packet;
=20
-	result =3D receive_raw_packet(batman_if->raw_sock, packet_buff,
-				    PACKBUFF_SIZE);
-	if (result <=3D 0)
-		return result;
-
-	if (result < sizeof(struct ethhdr) + 2)
-		return 0;
-
-	ethhdr =3D (struct ethhdr *)packet_buff;
-	batman_packet =3D (struct batman_packet *)
-		(packet_buff + sizeof(struct ethhdr));
-
-	if (batman_packet->version !=3D COMPAT_VERSION) {
-		bat_dbg(DBG_BATMAN,
-			"Drop packet: incompatible batman version (%i)\n",
-			batman_packet->version);
-		return 0;
-	}
-
-	switch (batman_packet->packet_type) {
-		/* batman originator packet */
-	case BAT_PACKET:
-		recv_bat_packet(ethhdr, packet_buff, result, batman_if);
-		break;
-
-		/* batman icmp packet */
-	case BAT_ICMP:
-		recv_icmp_packet(ethhdr, packet_buff, result, batman_if);
-		break;
-
-		/* unicast packet */
-	case BAT_UNICAST:
-		recv_unicast_packet(ethhdr, packet_buff, result, batman_if);
-		break;
-
-		/* broadcast packet */
-	case BAT_BCAST:
-		recv_bcast_packet(ethhdr,
-				  packet_buff, result, batman_if);
-		break;
-
-		/* vis packet */
-	case BAT_VIS:
-		recv_vis_packet(ethhdr, packet_buff, result);
-		break;
-	}
-	return 0;
-}
-
-
-static int discard_one_packet(struct batman_if *batman_if,
-			      unsigned char *packet_buff)
-{
-	int result =3D -EAGAIN;
-
-	if (batman_if->raw_sock) {
-			result =3D receive_raw_packet(batman_if->raw_sock,
-						    packet_buff,
-						    PACKBUFF_SIZE);
-	}
-	return result;
-}
-
-
-static bool is_interface_active(struct batman_if *batman_if)
-{
-	if (batman_if->if_active !=3D IF_ACTIVE)
-		return false;
-
-	return true;
-}
-
-static void service_interface(struct batman_if *batman_if,
-			      unsigned char *packet_buff)
-
-{
-	int result;
-
-	do {
-		if (is_interface_active(batman_if))
-			result =3D recv_one_packet(batman_if, packet_buff);
-		else
-			result =3D discard_one_packet(batman_if, packet_buff);
-	} while (result >=3D 0);
-
-	/* we perform none blocking reads, so EAGAIN indicates there
-	   are no more packets to read. Anything else is a real
-	   error.*/
-
-	if ((result < 0) && (result !=3D -EAGAIN))
-		printk(KERN_ERR "batman-adv:Could not receive packet from interface %s: =
%i\n", batman_if->dev, result);
-}
-
-static void service_interfaces(unsigned char *packet_buffer)
-{
-	struct batman_if *batman_if;
-	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		rcu_read_unlock();
-		service_interface(batman_if, packet_buffer);
-		rcu_read_lock();
-	}
-	rcu_read_unlock();
-}
-
-
-int packet_recv_thread(void *data)
-{
-	unsigned char *packet_buff;
-
-	atomic_set(&data_ready_cond, 0);
-	atomic_set(&exit_cond, 0);
-	packet_buff =3D kmalloc(PACKBUFF_SIZE, GFP_KERNEL);
-	if (!packet_buff) {
-		printk(KERN_ERR"batman-adv:Could allocate memory for the packet buffer. =
:(\n");
-		return -1;
-	}
-
-	while ((!kthread_should_stop()) && (!atomic_read(&exit_cond))) {
-
-		wait_event_interruptible(thread_wait,
-					 (atomic_read(&data_ready_cond) ||
-					  atomic_read(&exit_cond)));
-
-		atomic_set(&data_ready_cond, 0);
-
-		if (kthread_should_stop() || atomic_read(&exit_cond))
-			break;
-
-		service_interfaces(packet_buff);
-	}
-	kfree(packet_buff);
-
-	/* do not exit until kthread_stop() is actually called,
-	 * otherwise it will wait for us forever. */
-	while (!kthread_should_stop())
-		schedule();
-
-	return 0;
-}
-
-void batman_data_ready(struct sock *sk, int len)
-{
-	void (*data_ready)(struct sock *, int) =3D sk->sk_user_data;
-
-	data_ready(sk, len);
-
-	atomic_set(&data_ready_cond, 1);
-	wake_up_interruptible(&thread_wait);
-}
Index: a/batman-adv-kernelland/routing.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/routing.h	(revision 1507)
+++ b/batman-adv-kernelland/routing.h	(working copy)
@@ -25,8 +25,6 @@
 extern atomic_t exit_cond;
=20
 void slide_own_bcast_window(struct batman_if *batman_if);
-void batman_data_ready(struct sock *sk, int len);
-int packet_recv_thread(void *data);
 void receive_bat_packet(struct ethhdr *ethhdr,
 				struct batman_packet *batman_packet,
 				unsigned char *hna_buff, int hna_buff_len,
@@ -34,3 +32,11 @@
 void update_routes(struct orig_node *orig_node,
 				struct neigh_node *neigh_node,
 				unsigned char *hna_buff, int hna_buff_len);
+int recv_icmp_packet(struct sk_buff *skb);
+int recv_unicast_packet(struct sk_buff *skb);
+int recv_bcast_packet(struct sk_buff *skb);
+int recv_vis_packet(struct sk_buff *skb);
+int recv_bat_packet(struct sk_buff *skb,
+				struct batman_if *batman_if);
+
+

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksxU4YACgkQrzg/fFk7axY3nACfcWQ3U+szoReyEZJJ8+OoV8o0
0SwAnis4obpxTiU4da6gZ6u01I+0GSTi
=B0pT
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
