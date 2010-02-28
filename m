Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 28 Feb 2010 17:34:28 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100228163428.GA15370@pandem0nium>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch>
	<20100211094659.GH2900@lunn.ch> <20100211100156.GI2900@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20100211100156.GI2900@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--+pHx0qQiF2pBVqBT
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

i can reproduce the slowpath warning in the trunk within my qemu setup. Whe=
n i
start a server, some of the clients show this slow path warning.

I've tried Andrews patch, and i can not see any memory leaks - it varies in=
 a=20
100k window. However some of the servers crash after some time (30 minutes)
without any special trigger i am aware of. Stack trace is this:

root@OpenWrt:/# ------------[ cut here ]------------
WARNING: at lib/kref.c:43 kref_get+0x18/0x30()
Hardware name:
Modules linked in: via_velocity via_rhine tg3 sis900 r8169 pcnet32 ne2k_pci=
 8390 e1000 e100 batman_adv 8139too 3c59x nf_nat_tftp nf_conntrack_tftp nf_=
nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable=
_nat nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv=
4 nf_conntrack pppoe pppox libphy ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport=
 xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables=
 ppp_async ppp_generic slhc natsemi crc_ccitt ipv6
Pid: 570, comm: bat_events Not tainted 2.6.31.1 #32
Call Trace:
 [<c10dd608>] ? kref_get+0x18/0x30
 [<c101f55f>] ? warn_slowpath_common+0x7f/0xb0
 [<c10dd608>] ? kref_get+0x18/0x30
 [<c101f5a3>] ? warn_slowpath_null+0x13/0x20
 [<c10dd608>] ? kref_get+0x18/0x30
 [<c2ac51a2>] ? proc_vis_read_prim_sec+0x352/0x5a0 [batman_adv]
 [<c2ac4ee0>] ? proc_vis_read_prim_sec+0x90/0x5a0 [batman_adv]
 [<c102d23a>] ? worker_thread+0xca/0x150
 [<c102fd80>] ? autoremove_wake_function+0x0/0x50
 [<c102d170>] ? worker_thread+0x0/0x150
 [<c102fbc3>] ? kthread+0x73/0x90
 [<c102fb50>] ? kthread+0x0/0x90
 [<c1003813>] ? kernel_thread_helper+0x7/0x14
---[ end trace 4f770856ce7e0712 ]---
------------[ cut here ]------------
kernel BUG at mm/slub.c:2929!
invalid opcode: 0000 [#1]
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in: via_velocity via_rhine tg3 sis900 r8169 pcnet32 ne2k_pci=
 8390 e1000 e100 batman_adv 8139too 3c59x nf_nat_tftp nf_conntrack_tftp nf_=
nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable=
_nat nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv=
4 nf_conntrack pppoe pppox libphy ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport=
 xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables=
 ppp_async ppp_generic slhc natsemi crc_ccitt ipv6

Pid: 570, comm: bat_events Tainted: G        W  (2.6.31.1 #32)
EIP: 0060:[<c1064669>] EFLAGS: 00010046 CPU: 0
EIP is at kfree+0x49/0xc0
EAX: 00000000 EBX: c1f5dd94 ECX: 40080000 EDX: c133cba0
ESI: c2ac5540 EDI: c1f5dd80 EBP: 00000216 ESP: c0d06eec
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process bat_events (pid: 570, ti=3Dc0d06000 task=3Dc18d0000 task.ti=3Dc0d06=
000)
Stack:
 00000002 c1f5dd94 c1f5dd94 c2ac5540 c1f5dda4 c10dd5cf c1f5dda4 00000000
<0> c2ac538b c0d06f68 c0e0504a c1f5dd84 c1f5dd94 c1f5dd80 c1f5dd80 000022a0
<0> 00000046 c0e05024 c0e05030 00000286 00000086 c1f5dda4 0000003f 00000080
Call Trace:
 [<c2ac5540>] ? vis_init+0x150/0x1b0 [batman_adv]
 [<c10dd5cf>] ? kref_put+0x4f/0x70
 [<c2ac538b>] ? proc_vis_read_prim_sec+0x53b/0x5a0 [batman_adv]
 [<c2ac4ee0>] ? proc_vis_read_prim_sec+0x90/0x5a0 [batman_adv]
 [<c102d23a>] ? worker_thread+0xca/0x150
 [<c102fd80>] ? autoremove_wake_function+0x0/0x50
 [<c102d170>] ? worker_thread+0x0/0x150
 [<c102fbc3>] ? kthread+0x73/0x90
 [<c102fb50>] ? kthread+0x0/0x90
 [<c1003813>] ? kernel_thread_helper+0x7/0x14
Code: 00 40 a1 80 cb 2e c1 c1 ea 0c c1 e2 05 01 c2 8b 0a 89 c8 25 00 80 00 =
00 66 85 c0 74 05 8b 52 0c 8b 0a 84 c9 78 24 f6 c5 c0 75 09 <0f> 0b 90 8d 7=
4 26 00 eb fe 8b 5c 24 08 89 d0 8b 74 24 0c 8b 7c
EIP: [<c1064669>] kfree+0x49/0xc0 SS:ESP 0068:c0d06eec
---[ end trace 4f770856ce7e0713 ]---

Please note that in this moment, i have not queried the vis_data file, so=
=20
the proc_vis_read_prim_sec call is probably not correctly reported. Further=
more
there are some more stack traces in vfs/mount and then the boxes reboot -
we probably write at some bad memory position.

I've changed Andrews patch a little bit, and could not crash my 9 kvm insta=
nces
when running it some hours last night. I've added kref_get() calls when the=
 info=20
packets get referenced from the send_list, this reference is removed with=
=20
kref_put() in the send_vis_packets() after sending the packet. The disadvan=
tage=20
of this solution is that in a race condition, we might (unnecessarily) send=
 out an=20
old packet. No memory leaks as far as i could see after running some hours.

Please give it a try (patch is attached to this e-mail)!

best regards,
	Simon



On Thu, Feb 11, 2010 at 11:01:56AM +0100, Andrew Lunn wrote:
> On Thu, Feb 11, 2010 at 10:46:59AM +0100, Andrew Lunn wrote:
> > Hi Linus
> >=20
> > Here is a new version of the patch. I've tested it this time using
> > five UML machines. It should not immediately opps now.=20
>=20
> Instead is will leak memory and crash after a while...
>=20
> I will try to find the memory leak.
>=20
>   Andrew
>=20

--IJpNTDwzlM2Ie8A6
Content-Type: text/x-diff; charset=utf8
Content-Disposition: attachment; filename="vis_refcount.patch"
Content-Transfer-Encoding: quoted-printable

taging: batman-adv: Don't have interrupts disabled while sending.

send_vis_packets() would disable interrupts before calling
dev_queue_xmit() which resulting in a backtrace in local_bh_enable().
Fix this by using kref on the vis_info object so that we can call
send_vis_packets() without holding vis_hash_lock. vis_hash_lock also
used to protect recv_list, so we now need a new lock to protect that
instead of vis_hash_lock.

Also a few checkpatch cleanups.

Reported-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/vis.c	(revision 1578)
+++ batman-adv-kernelland/vis.c	(working copy)
@@ -30,22 +30,26 @@
=20
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
+static DEFINE_SPINLOCK(recv_list_lock);
 static struct vis_info *my_vis_info;
 static struct list_head send_list;	/* always locked with vis_hash_lock */
=20
 static void start_vis_timer(void);
=20
 /* free the info */
-static void free_info(void *data)
+static void free_info(struct kref *ref)
 {
-	struct vis_info *info =3D data;
+	struct vis_info *info =3D container_of(ref, struct vis_info, refcount);
 	struct recvlist_node *entry, *tmp;
+	unsigned long flags;
=20
 	list_del_init(&info->send_list);
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
 		list_del(&entry->list);
 		kfree(entry);
 	}
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 	kfree(info);
 }
=20
@@ -147,32 +151,41 @@
 static void recv_list_add(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
+	unsigned long flags;
+
 	entry =3D kmalloc(sizeof(struct recvlist_node), GFP_ATOMIC);
 	if (!entry)
 		return;
=20
 	memcpy(entry->mac, mac, ETH_ALEN);
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_add_tail(&entry->list, recv_list);
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 }
=20
 /* returns 1 if this mac is in the recv_list */
 static int recv_list_is_in(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_for_each_entry(entry, recv_list, list) {
-		if (memcmp(entry->mac, mac, ETH_ALEN) =3D=3D 0)
+		if (memcmp(entry->mac, mac, ETH_ALEN) =3D=3D 0) {
+			spin_unlock_irqrestore(&recv_list_lock, flags);
 			return 1;
+		}
 	}
-
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 	return 0;
 }
=20
 /* try to add the packet to the vis_hash. return NULL if invalid (e.g. too=
 old,
- * broken.. ).  vis hash must be locked outside.  is_new is set when the p=
acket
+ * broken.. ).	vis hash must be locked outside.  is_new is set when the pa=
cket
  * is newer than old entries in the hash. */
 static struct vis_info *add_packet(struct vis_packet *vis_packet,
-				   int vis_info_len, int *is_new)
+				   int vis_info_len, int *is_new,
+				   int make_broadcast)
 {
 	struct vis_info *info, *old_info;
 	struct vis_info search_elem;
@@ -199,13 +212,14 @@
 		}
 		/* remove old entry */
 		hash_remove(vis_hash, old_info);
-		free_info(old_info);
+		kref_put(&old_info->refcount, free_info);
 	}
=20
 	info =3D kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
 	if (info =3D=3D NULL)
 		return NULL;
=20
+	kref_init(&info->refcount);
 	INIT_LIST_HEAD(&info->send_list);
 	INIT_LIST_HEAD(&info->recv_list);
 	info->first_seen =3D jiffies;
@@ -215,16 +229,21 @@
 	/* initialize and add new packet. */
 	*is_new =3D 1;
=20
+	/* Make it a broadcast packet, if required */
+	if (make_broadcast)
+		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+
 	/* repair if entries is longer than packet. */
 	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
-		info->packet.entries =3D vis_info_len / sizeof(struct vis_info_entry);
+		info->packet.entries =3D vis_info_len /
+			sizeof(struct vis_info_entry);
=20
 	recv_list_add(&info->recv_list, info->packet.sender_orig);
=20
 	/* try to add it */
 	if (hash_add(vis_hash, info) < 0) {
 		/* did not work (for some reason) */
-		free_info(info);
+		kref_put(&old_info->refcount, free_info);
 		info =3D NULL;
 	}
=20
@@ -235,21 +254,24 @@
 void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_inf=
o_len)
 {
 	struct vis_info *info;
-	int is_new;
+	int is_new, make_broadcast;
 	unsigned long flags;
 	int vis_server =3D atomic_read(&vis_mode);
=20
+	make_broadcast =3D (vis_server =3D=3D VIS_TYPE_SERVER_SYNC);
+
 	spin_lock_irqsave(&vis_hash_lock, flags);
-	info =3D add_packet(vis_packet, vis_info_len, &is_new);
+	info =3D add_packet(vis_packet, vis_info_len, &is_new, make_broadcast);
 	if (info =3D=3D NULL)
 		goto end;
=20
 	/* only if we are server ourselves and packet is newer than the one in
 	 * hash.*/
 	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC && is_new) {
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-		if (list_empty(&info->send_list))
+		if (list_empty(&info->send_list)) {
+			kref_get(&info->refcount);
 			list_add_tail(&info->send_list, &send_list);
+		}
 	}
 end:
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
@@ -263,31 +285,38 @@
 	int is_new;
 	unsigned long flags;
 	int vis_server =3D atomic_read(&vis_mode);
+	int are_target =3D 0;
=20
 	/* clients shall not broadcast. */
 	if (is_bcast(vis_packet->target_orig))
 		return;
=20
+	/* Are we the target for this VIS packet? */
+	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC	&&
+	    is_my_mac(vis_packet->target_orig))
+		are_target =3D 1;
+
 	spin_lock_irqsave(&vis_hash_lock, flags);
-	info =3D add_packet(vis_packet, vis_info_len, &is_new);
+	info =3D add_packet(vis_packet, vis_info_len, &is_new, are_target);
 	if (info =3D=3D NULL)
 		goto end;
 	/* note that outdated packets will be dropped at this point. */
=20
=20
 	/* send only if we're the target server or ... */
-	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC  &&
-	    is_my_mac(info->packet.target_orig) &&
-	    is_new) {
+	if (are_target && is_new) {
 		info->packet.vis_type =3D VIS_TYPE_SERVER_SYNC;	/* upgrade! */
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-		if (list_empty(&info->send_list))
+		if (list_empty(&info->send_list)) {
+			kref_get(&info->refcount);
 			list_add_tail(&info->send_list, &send_list);
+		}
=20
 		/* ... we're not the recipient (and thus need to forward). */
 	} else if (!is_my_mac(info->packet.target_orig)) {
-		if (list_empty(&info->send_list))
+		if (list_empty(&info->send_list)) {
+			kref_get(&info->refcount);
 			list_add_tail(&info->send_list, &send_list);
+		}
 	}
 end:
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
@@ -362,14 +391,17 @@
 	while (hash_iterate(orig_hash, &hashit_global)) {
 		orig_node =3D hashit_global.bucket->data;
 		if (orig_node->router !=3D NULL
-			&& compare_orig(orig_node->router->addr, orig_node->orig)
+			&& compare_orig(orig_node->router->addr,
+					orig_node->orig)
 			&& orig_node->batman_if
 			&& (orig_node->batman_if->if_active =3D=3D IF_ACTIVE)
 		    && orig_node->router->tq_avg > 0) {
=20
 			/* fill one entry into buffer. */
 			entry =3D &entry_array[info->packet.entries];
-			memcpy(entry->src, orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
+			memcpy(entry->src,
+			       orig_node->batman_if->net_dev->dev_addr,
+			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality =3D orig_node->router->tq_avg;
 			info->packet.entries++;
@@ -401,6 +433,8 @@
 	return 0;
 }
=20
+/* free old vis packets. Must be called with this vis_hash_lock
+ * held */
 static void purge_vis_packets(void)
 {
 	HASHIT(hashit);
@@ -413,7 +447,7 @@
 		if (time_after(jiffies,
 			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
 			hash_remove_bucket(vis_hash, &hashit);
-			free_info(info);
+			kref_put(&info->refcount, free_info);
 		}
 	}
 }
@@ -423,6 +457,8 @@
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	unsigned long flags;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
=20
 	spin_lock_irqsave(&orig_hash_lock, flags);
=20
@@ -431,46 +467,57 @@
 		orig_node =3D hashit.bucket->data;
=20
 		/* if it's a vis server and reachable, send it. */
-		if (orig_node &&
-		    (orig_node->flags & VIS_SERVER) &&
-		    orig_node->batman_if &&
-		    orig_node->router) {
+		if ((!orig_node) || (!orig_node->batman_if) ||
+		    (!orig_node->router))
+			continue;
+		if (!(orig_node->flags & VIS_SERVER))
+			continue;
+		/* don't send it if we already received the packet from
+		 * this node. */
+		if (recv_list_is_in(&info->recv_list, orig_node->orig))
+			continue;
=20
-			/* don't send it if we already received the packet from
-			 * this node. */
-			if (recv_list_is_in(&info->recv_list, orig_node->orig))
-				continue;
+		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
+		batman_if =3D orig_node->batman_if;
+		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
=20
-			memcpy(info->packet.target_orig,
-			       orig_node->orig, ETH_ALEN);
+		send_raw_packet((unsigned char *)&info->packet,
+				packet_length, batman_if, dstaddr);
=20
-			send_raw_packet((unsigned char *) &info->packet,
-					packet_length,
-					orig_node->batman_if,
-					orig_node->router->addr);
-		}
+		spin_lock_irqsave(&orig_hash_lock, flags);
+
 	}
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
=20
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
 	unsigned long flags;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
=20
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node =3D ((struct orig_node *)
 		     hash_find(orig_hash, info->packet.target_orig));
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
-		send_raw_packet((unsigned char *) &info->packet, packet_length,
-				orig_node->batman_if,
-				orig_node->router->addr);
-	}
+	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
+		goto out;
+
+	/* don't lock while sending the packets ... we therefore
+	 * copy the required data before sending */
+	batman_if =3D orig_node->batman_if;
+	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	send_raw_packet((unsigned char *)&info->packet,
+			packet_length, batman_if, dstaddr);
+	return;
+
+out:
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
=20
 /* only send one vis packet. called from send_vis_packets() */
@@ -503,15 +550,23 @@
 	unsigned long flags;
=20
 	spin_lock_irqsave(&vis_hash_lock, flags);
+
 	purge_vis_packets();
=20
-	if (generate_vis_packet() =3D=3D 0)
+	if (generate_vis_packet() =3D=3D 0) {
 		/* schedule if generation was successful */
+		kref_get(&my_vis_info->refcount);
 		list_add_tail(&my_vis_info->send_list, &send_list);
+	}
=20
 	list_for_each_entry_safe(info, temp, &send_list, send_list) {
+		spin_unlock_irqrestore(&vis_hash_lock, flags);
+
+		send_vis_packet(info);
+
+		spin_lock_irqsave(&vis_hash_lock, flags);
 		list_del_init(&info->send_list);
-		send_vis_packet(info);
+		kref_put(&info->refcount, free_info);
 	}
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 	start_vis_timer();
@@ -544,6 +599,7 @@
 	my_vis_info->first_seen =3D jiffies - atomic_read(&vis_interval);
 	INIT_LIST_HEAD(&my_vis_info->recv_list);
 	INIT_LIST_HEAD(&my_vis_info->send_list);
+	kref_init(&my_vis_info->refcount);
 	my_vis_info->packet.version =3D COMPAT_VERSION;
 	my_vis_info->packet.packet_type =3D BAT_VIS;
 	my_vis_info->packet.ttl =3D TTL;
@@ -557,9 +613,9 @@
=20
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		printk(KERN_ERR
-			  "batman-adv:Can't add own vis packet into hash\n");
-		free_info(my_vis_info);	/* not in hash, need to remove it
-					 * manually. */
+		       "batman-adv:Can't add own vis packet into hash\n");
+		/* not in hash, need to remove it manually. */
+		kref_put(&my_vis_info->refcount, free_info);
 		goto err;
 	}
=20
@@ -573,6 +629,13 @@
 	return 0;
 }
=20
+/* Decrease the reference count on a hash item info */
+static void free_info_ref(void *data)
+{
+	struct vis_info *info =3D data;
+	kref_put(&info->refcount, free_info);
+}
+
 /* shutdown vis-server */
 void vis_quit(void)
 {
@@ -584,7 +647,7 @@
=20
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	/* properly remove, kill timers ... */
-	hash_delete(vis_hash, free_info);
+	hash_delete(vis_hash, free_info_ref);
 	vis_hash =3D NULL;
 	my_vis_info =3D NULL;
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
@@ -594,5 +657,5 @@
 static void start_vis_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (atomic_read(&vis_interval) * HZ ) / 1000);
+			   (atomic_read(&vis_interval) * HZ) / 1000);
 }
Index: batman-adv-kernelland/vis.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman-adv-kernelland/vis.h	(revision 1578)
+++ batman-adv-kernelland/vis.h	(working copy)
@@ -29,6 +29,7 @@
 			    /* list of server-neighbors we received a vis-packet
 			     * from.  we should not reply to them. */
 	struct list_head send_list;
+	struct kref refcount;
 	/* this packet might be part of the vis send queue. */
 	struct vis_packet packet;
 	/* vis_info may follow here*/

--IJpNTDwzlM2Ie8A6--

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuKmxQACgkQrzg/fFk7axYdJQCg3KXZTY5BZ7Hb7CAs0HYDv8u/
500An31BHTAl1AU7Y7Ve+mpEmSbILF73
=zsiv
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
