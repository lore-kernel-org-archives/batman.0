Return-Path: <linus.luessing@web.de>
Date: Sun, 31 Jan 2010 20:37:29 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100131193729.GA20988@Linus-Debian>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20100130165059.GV24649@lunn.ch>
Sender: linus.luessing@web.de
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


--EP0wieDxd4TSJjHq
Content-Type: multipart/mixed; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Yes, ehm it does indeed cause a kernel panic on the server side
immediately :). See the attachment for the full call trace.

Cheers, Linus

On Sat, Jan 30, 2010 at 05:50:59PM +0100, Andrew Lunn wrote:
> Hi Linus
>=20
> Please could you try this patch and see if it fixes the vis problem.
> It compiles cleanly with 2.6.32. It is checkpatch clean, it is sparse
> clean. However, since i've not actually tried running the code i would
> not be too surprised if it deadlocked, leaked memory, oopsed, ...
>=20
>     Andrew
>=20
> Staging: batman-adv: Don't have interrupts disabled while sending.
>=20
> send_vis_packets() would disable interrupts before calling
> dev_queue_xmit() which resulting in a backtrace in local_bh_enable().
> Fix this by using kref on the vis_info object so that we can call
> send_vis_packets() without holding vis_hash_lock. vis_hash_lock also
> used to protect recv_list, so we now need a new lock to protect that
> instead of vis_hash_lock.
>=20
> Also a few checkpatch cleanups.
>=20
> Reported-by: Linus L=FCssing <linus.luessing@web.de>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>=20
> Index: vis.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- vis.c	(revision 1568)
> +++ vis.c	(working copy)
> @@ -30,22 +30,26 @@
> =20
>  struct hashtable_t *vis_hash;
>  DEFINE_SPINLOCK(vis_hash_lock);
> +static DEFINE_SPINLOCK(recv_list_lock);
>  static struct vis_info *my_vis_info;
>  static struct list_head send_list;	/* always locked with vis_hash_lock */
> =20
>  static void start_vis_timer(void);
> =20
>  /* free the info */
> -static void free_info(void *data)
> +static void free_info(struct kref *ref)
>  {
> -	struct vis_info *info =3D data;
> +	struct vis_info *info =3D container_of(ref, struct vis_info, refcount);
>  	struct recvlist_node *entry, *tmp;
> +	unsigned long flags;
> =20
>  	list_del_init(&info->send_list);
> +	spin_lock_irqsave(&recv_list_lock, flags);
>  	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
>  		list_del(&entry->list);
>  		kfree(entry);
>  	}
> +	spin_unlock_irqrestore(&recv_list_lock, flags);
>  	kfree(info);
>  }
> =20
> @@ -147,32 +151,41 @@
>  static void recv_list_add(struct list_head *recv_list, char *mac)
>  {
>  	struct recvlist_node *entry;
> +	unsigned long flags;
> +
>  	entry =3D kmalloc(sizeof(struct recvlist_node), GFP_ATOMIC);
>  	if (!entry)
>  		return;
> =20
>  	memcpy(entry->mac, mac, ETH_ALEN);
> +	spin_lock_irqsave(&recv_list_lock, flags);
>  	list_add_tail(&entry->list, recv_list);
> +	spin_unlock_irqrestore(&recv_list_lock, flags);
>  }
> =20
>  /* returns 1 if this mac is in the recv_list */
>  static int recv_list_is_in(struct list_head *recv_list, char *mac)
>  {
>  	struct recvlist_node *entry;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&recv_list_lock, flags);
>  	list_for_each_entry(entry, recv_list, list) {
> -		if (memcmp(entry->mac, mac, ETH_ALEN) =3D=3D 0)
> +		if (memcmp(entry->mac, mac, ETH_ALEN) =3D=3D 0) {
> +			spin_unlock_irqrestore(&recv_list_lock, flags);
>  			return 1;
> +		}
>  	}
> -
> +	spin_unlock_irqrestore(&recv_list_lock, flags);
>  	return 0;
>  }
> =20
>  /* try to add the packet to the vis_hash. return NULL if invalid (e.g. t=
oo old,
> - * broken.. ).  vis hash must be locked outside.  is_new is set when the=
 packet
> + * broken.. ).	vis hash must be locked outside.  is_new is set when the =
packet
>   * is newer than old entries in the hash. */
>  static struct vis_info *add_packet(struct vis_packet *vis_packet,
> -				   int vis_info_len, int *is_new)
> +				   int vis_info_len, int *is_new,
> +				   int make_broadcast)
>  {
>  	struct vis_info *info, *old_info;
>  	struct vis_info search_elem;
> @@ -199,7 +212,7 @@
>  		}
>  		/* remove old entry */
>  		hash_remove(vis_hash, old_info);
> -		free_info(old_info);
> +		kref_put(&old_info->refcount, free_info);
>  	}
> =20
>  	info =3D kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
> @@ -208,6 +221,7 @@
> =20
>  	INIT_LIST_HEAD(&info->send_list);
>  	INIT_LIST_HEAD(&info->recv_list);
> +	kref_init(&info->refcount);
>  	info->first_seen =3D jiffies;
>  	memcpy(&info->packet, vis_packet,
>  	       sizeof(struct vis_packet) + vis_info_len);
> @@ -215,16 +229,21 @@
>  	/* initialize and add new packet. */
>  	*is_new =3D 1;
> =20
> +	/* Make it a broadcast packet, if required */
> +	if (make_broadcast)
> +		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
> +
>  	/* repair if entries is longer than packet. */
>  	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
> -		info->packet.entries =3D vis_info_len / sizeof(struct vis_info_entry);
> +		info->packet.entries =3D vis_info_len /
> +			sizeof(struct vis_info_entry);
> =20
>  	recv_list_add(&info->recv_list, info->packet.sender_orig);
> =20
>  	/* try to add it */
>  	if (hash_add(vis_hash, info) < 0) {
>  		/* did not work (for some reason) */
> -		free_info(info);
> +		kref_put(&old_info->refcount, free_info);
>  		info =3D NULL;
>  	}
> =20
> @@ -235,19 +254,20 @@
>  void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_i=
nfo_len)
>  {
>  	struct vis_info *info;
> -	int is_new;
> +	int is_new, make_broadcast;
>  	unsigned long flags;
>  	int vis_server =3D atomic_read(&vis_mode);
> =20
> +	make_broadcast =3D (vis_server =3D=3D VIS_TYPE_SERVER_SYNC);
> +
>  	spin_lock_irqsave(&vis_hash_lock, flags);
> -	info =3D add_packet(vis_packet, vis_info_len, &is_new);
> +	info =3D add_packet(vis_packet, vis_info_len, &is_new, make_broadcast);
>  	if (info =3D=3D NULL)
>  		goto end;
> =20
>  	/* only if we are server ourselves and packet is newer than the one in
>  	 * hash.*/
>  	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC && is_new) {
> -		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
>  		if (list_empty(&info->send_list))
>  			list_add_tail(&info->send_list, &send_list);
>  	}
> @@ -263,24 +283,27 @@
>  	int is_new;
>  	unsigned long flags;
>  	int vis_server =3D atomic_read(&vis_mode);
> +	int are_target =3D 0;
> =20
>  	/* clients shall not broadcast. */
>  	if (is_bcast(vis_packet->target_orig))
>  		return;
> =20
> +	/* Are we the target for this VIS packet? */
> +	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC	&&
> +	    is_my_mac(info->packet.target_orig))
> +		are_target =3D 1;
> +
>  	spin_lock_irqsave(&vis_hash_lock, flags);
> -	info =3D add_packet(vis_packet, vis_info_len, &is_new);
> +	info =3D add_packet(vis_packet, vis_info_len, &is_new, are_target);
>  	if (info =3D=3D NULL)
>  		goto end;
>  	/* note that outdated packets will be dropped at this point. */
> =20
> =20
>  	/* send only if we're the target server or ... */
> -	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC  &&
> -	    is_my_mac(info->packet.target_orig) &&
> -	    is_new) {
> +	if (are_target && is_new) {
>  		info->packet.vis_type =3D VIS_TYPE_SERVER_SYNC;	/* upgrade! */
> -		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
>  		if (list_empty(&info->send_list))
>  			list_add_tail(&info->send_list, &send_list);
> =20
> @@ -362,14 +385,17 @@
>  	while (hash_iterate(orig_hash, &hashit_global)) {
>  		orig_node =3D hashit_global.bucket->data;
>  		if (orig_node->router !=3D NULL
> -			&& compare_orig(orig_node->router->addr, orig_node->orig)
> +			&& compare_orig(orig_node->router->addr,
> +					orig_node->orig)
>  			&& orig_node->batman_if
>  			&& (orig_node->batman_if->if_active =3D=3D IF_ACTIVE)
>  		    && orig_node->router->tq_avg > 0) {
> =20
>  			/* fill one entry into buffer. */
>  			entry =3D &entry_array[info->packet.entries];
> -			memcpy(entry->src, orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
> +			memcpy(entry->src,
> +			       orig_node->batman_if->net_dev->dev_addr,
> +			       ETH_ALEN);
>  			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
>  			entry->quality =3D orig_node->router->tq_avg;
>  			info->packet.entries++;
> @@ -401,6 +427,8 @@
>  	return 0;
>  }
> =20
> +/* free old vis packets. Must be called with this vis_hash_lock
> + * held */
>  static void purge_vis_packets(void)
>  {
>  	HASHIT(hashit);
> @@ -413,7 +441,7 @@
>  		if (time_after(jiffies,
>  			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
>  			hash_remove_bucket(vis_hash, &hashit);
> -			free_info(info);
> +			kref_put(&info->refcount, free_info);
>  		}
>  	}
>  }
> @@ -423,6 +451,8 @@
>  	HASHIT(hashit);
>  	struct orig_node *orig_node;
>  	unsigned long flags;
> +	struct batman_if *batman_if;
> +	uint8_t dstaddr[ETH_ALEN];
> =20
>  	spin_lock_irqsave(&orig_hash_lock, flags);
> =20
> @@ -431,46 +461,57 @@
>  		orig_node =3D hashit.bucket->data;
> =20
>  		/* if it's a vis server and reachable, send it. */
> -		if (orig_node &&
> -		    (orig_node->flags & VIS_SERVER) &&
> -		    orig_node->batman_if &&
> -		    orig_node->router) {
> +		if ((!orig_node) || (!orig_node->batman_if) ||
> +		    (!orig_node->router))
> +			continue;
> +		if (!(orig_node->flags & VIS_SERVER))
> +			continue;
> +		/* don't send it if we already received the packet from
> +		 * this node. */
> +		if (recv_list_is_in(&info->recv_list, orig_node->orig))
> +			continue;
> =20
> -			/* don't send it if we already received the packet from
> -			 * this node. */
> -			if (recv_list_is_in(&info->recv_list, orig_node->orig))
> -				continue;
> +		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
> +		batman_if =3D orig_node->batman_if;
> +		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
> +		spin_unlock_irqrestore(&orig_hash_lock, flags);
> =20
> -			memcpy(info->packet.target_orig,
> -			       orig_node->orig, ETH_ALEN);
> +		send_raw_packet((unsigned char *)&info->packet,
> +				packet_length, batman_if, dstaddr);
> =20
> -			send_raw_packet((unsigned char *) &info->packet,
> -					packet_length,
> -					orig_node->batman_if,
> -					orig_node->router->addr);
> -		}
> +		spin_lock_irqsave(&orig_hash_lock, flags);
> +
>  	}
> +	spin_unlock_irqrestore(&orig_hash_lock, flags);
>  	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
> -	spin_unlock_irqrestore(&orig_hash_lock, flags);
>  }
> =20
>  static void unicast_vis_packet(struct vis_info *info, int packet_length)
>  {
>  	struct orig_node *orig_node;
>  	unsigned long flags;
> +	struct batman_if *batman_if;
> +	uint8_t dstaddr[ETH_ALEN];
> =20
>  	spin_lock_irqsave(&orig_hash_lock, flags);
>  	orig_node =3D ((struct orig_node *)
>  		     hash_find(orig_hash, info->packet.target_orig));
> =20
> -	if ((orig_node !=3D NULL) &&
> -	    (orig_node->batman_if !=3D NULL) &&
> -	    (orig_node->router !=3D NULL)) {
> -		send_raw_packet((unsigned char *) &info->packet, packet_length,
> -				orig_node->batman_if,
> -				orig_node->router->addr);
> -	}
> +	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
> +		goto out;
> +
> +	/* don't lock while sending the packets ... we therefore
> +	 * copy the required data before sending */
> +	batman_if =3D orig_node->batman_if;
> +	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
>  	spin_unlock_irqrestore(&orig_hash_lock, flags);
> +
> +	send_raw_packet((unsigned char *)&info->packet,
> +			packet_length, batman_if, dstaddr);
> +	return;
> +
> +out:
> +	spin_unlock_irqrestore(&orig_hash_lock, flags);
>  }
> =20
>  /* only send one vis packet. called from send_vis_packets() */
> @@ -503,6 +544,7 @@
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&vis_hash_lock, flags);
> +
>  	purge_vis_packets();
> =20
>  	if (generate_vis_packet() =3D=3D 0)
> @@ -511,7 +553,11 @@
> =20
>  	list_for_each_entry_safe(info, temp, &send_list, send_list) {
>  		list_del_init(&info->send_list);
> +		kref_get(&info->refcount);
> +		spin_unlock_irqrestore(&vis_hash_lock, flags);
>  		send_vis_packet(info);
> +		spin_lock_irqsave(&vis_hash_lock, flags);
> +		kref_put(&info->refcount, free_info);
>  	}
>  	spin_unlock_irqrestore(&vis_hash_lock, flags);
>  	start_vis_timer();
> @@ -544,6 +590,7 @@
>  	my_vis_info->first_seen =3D jiffies - atomic_read(&vis_interval);
>  	INIT_LIST_HEAD(&my_vis_info->recv_list);
>  	INIT_LIST_HEAD(&my_vis_info->send_list);
> +	kref_init(&my_vis_info->refcount);
>  	my_vis_info->packet.version =3D COMPAT_VERSION;
>  	my_vis_info->packet.packet_type =3D BAT_VIS;
>  	my_vis_info->packet.ttl =3D TTL;
> @@ -557,9 +604,9 @@
> =20
>  	if (hash_add(vis_hash, my_vis_info) < 0) {
>  		printk(KERN_ERR
> -			  "batman-adv:Can't add own vis packet into hash\n");
> -		free_info(my_vis_info);	/* not in hash, need to remove it
> -					 * manually. */
> +		       "batman-adv:Can't add own vis packet into hash\n");
> +		/* not in hash, need to remove it manually. */
> +		kref_put(&my_vis_info->refcount, free_info);
>  		goto err;
>  	}
> =20
> @@ -573,6 +620,13 @@
>  	return 0;
>  }
> =20
> +/* Decrease the reference count on a hash item info */
> +static void free_info_ref(void *data)
> +{
> +	struct vis_info *info =3D data;
> +	kref_put(&info->refcount, free_info);
> +}
> +
>  /* shutdown vis-server */
>  void vis_quit(void)
>  {
> @@ -584,7 +638,7 @@
> =20
>  	spin_lock_irqsave(&vis_hash_lock, flags);
>  	/* properly remove, kill timers ... */
> -	hash_delete(vis_hash, free_info);
> +	hash_delete(vis_hash, free_info_ref);
>  	vis_hash =3D NULL;
>  	my_vis_info =3D NULL;
>  	spin_unlock_irqrestore(&vis_hash_lock, flags);
> @@ -594,5 +648,5 @@
>  static void start_vis_timer(void)
>  {
>  	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
> -			   (atomic_read(&vis_interval) * HZ ) / 1000);
> +			   (atomic_read(&vis_interval) * HZ) / 1000);
>  }
> Index: vis.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- vis.h	(revision 1568)
> +++ vis.h	(working copy)
> @@ -29,6 +29,7 @@
>  			    /* list of server-neighbors we received a vis-packet
>  			     * from.  we should not reply to them. */
>  	struct list_head send_list;
> +	struct kref refcount;
>  	/* this packet might be part of the vis send queue. */
>  	struct vis_packet packet;
>  	/* vis_info may follow here*/
>=20

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="2010-01-31-2030-vis-patch-kernelpanic.log"

root@OpenWrt:/# batctl vs
[ ] client mode (server disabled)
[x] server mode (server enabled)
root@OpenWrt:/# CPU 0 Unable to handle kernel paging request at virtual address 00000024, epc == 8014d58c, ra == 80410154
Oops[#1]:
Cpu 0
$ 0   : 00000000 10009c00 8070e140 00000006
$ 4   : 8070e140 00000024 00000006 00000001
$ 8   : 00000024 00000000 00000000 00000000
$12   : 00000000 7fd89ed8 00000413 00430000
$16   : 80fef500 8041cdc0 00000024 8070e000
$20   : 0000004c 80d63000 00004305 80c05040
$24   : 00000002 8061c874
$28   : 80290000 80291ca8 00000000 80410154
Hi    : 000000f5
Lo    : 15a32180
epc   : 8014d58c memcmp+0xc/0x38
    Tainted: P
ra    : 80410154 is_my_mac+0x3c/0x78 [batman_adv]
Status: 10009c03    KERNEL EXL IE
Cause : 10800008
BadVA : 00000024
PrId  : 00019064 (MIPS 4KEc)
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Process swapper (pid: 0, threadinfo=80290000, task=80292170, tls=00000000)
Stack : 80225540 00000000 80a11c00 8022b330 00000000 00000000 80c05060 80417264
        00000000 8022a728 80000000 806c0052 c02e4000 c02e7000 80f49a40 80c05060
        80c05052 8070e000 80d63000 804124e4 80225540 00000000 80a11c00 00000000
        80c14e40 80fef500 80f49a40 80417bf4 8070e2c0 80c05052 8070e000 80d63000
        80d63000 80f49a40 8070e2c0 806215c4 00000000 80292170 80291db0 000332b6
        ...
Call Trace:
[<8014d58c>] memcmp+0xc/0x38
[<80410154>] is_my_mac+0x3c/0x78 [batman_adv]
[<80417264>] receive_client_update_packet+0x4c/0x154 [batman_adv]
[<804124e4>] recv_vis_packet+0xa4/0xbc [batman_adv]
[<80417bf4>] batman_skb_recv+0x168/0x1dc [batman_adv]
[<806215c4>] ieee80211_saveath+0xb24/0xb80 [ath_ahb]


Code: 08053567  00003821  90430000 <91020000> 00621023  14400006  24c6ffff  00871021  00a74021
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 3 seconds..+

--FsscpQKzF/jJk6ya--

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLZdv5AAoJEBKw7u43QNpfu20P/1f5LJuC62NGNA9FY4jG7mRw
ReuBCkoCZJhA3gCMHV3nI3opftIe3sk7XADggOgEguM7OZJX7QOQCsBqzjCdyWXu
gmJXznfmsW1pQ3M9RTMV+ETr5nQUW6/I67eNuREQfDLa3ZsSrMrPXK+fjyVkTHqk
vqhX28+FAmRV92O1WYQIo7sHhMuK3UhK+ndtb7SrSsE9BxyQ6MQWYOaQPY3CvFM/
MG1QeZCvFNfjEuZDVgLg+ILmC5QUzNhoK9rvCKgDDGTONYxokCzFezFWWUf6shlx
gwlTY1g6EliN6xxANBd+cP7JnDyVnZ4cbAFyXtoKMyyQZcW3HAF1n1aEDEh+OrYQ
lKr/zDujQ1myMs8hLJFocj6lfzUtOSXN0s6gmYQjEFld8xY+y+6qh9lwnvAJFBLZ
wabKKoo5CFDmXQeV9XJXoQQih+ahXhxPXT51lqdCnEDbIOrhRb+pE6dZsKYXTaqR
fAVEsZ58JaZ4BmV7RgxY2lO1JqcKjsB7avqkfASyQGuTXcG6wsfz7AGu68GnRLYp
uNGlxIH7GWZHrTwRGlqj6y0VqSR8uj9K4z+1OGdTHJK5VyWD2a7H3udcDKj3S7xc
AwiIbGL0DS6/0HUG1P55fYX622X0e6oQ0Xu+n/peITsl0iXm9z9n9LFPoaVP6eoR
i88M7cCnZR9POGs23gbW
=JwG/
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
