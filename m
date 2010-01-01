Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 1 Jan 2010 17:05:02 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100101160502.GA16855@pandem0nium>
References: <20091231105246.GI8143@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20091231105246.GI8143@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [Patch 1/1] Staging: batman-adv: Use	printk(%pM)
	for MAC addresses
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

thank you for the patch, it is committed now in r1526. I've added some
changes to your patch to allow compatibility for all currently suported
kernels again. This includes:

 * removing ipv4/ipv6 printing support in bat_printk
 * pack_hex_byte() (used in bat_printk()) was missing in older kernels
 * various stuff in compat.h to avoid regressions from my skb patch
 * skb->dev->stats was not available in older kernels

best regards,
	Simon


On Thu, Dec 31, 2009 at 11:52:46AM +0100, Andrew Lunn wrote:
> printk() since kernel version 2.6.29 has supported printing MAC
> addresses directly, as an extension to the %p processing. This patch
> makes use of this for printk() and bat_dbg(). This will remove the
> overhead of using addr_to_string() which is normally never actually
> output.
>=20
> For kernels older than 2.6.29 the printk support from 2.6.31 has been
> imported into batman-adv and will be used for formatting the output
> before passing it onto the native printk() function.
>=20
> Fix the typo found by Gus Wirth.
> grep pMs suggests the typo only occurred once.
>=20
> Stripped out all unneeded %pX functionality in bat_printk.c so that
> the code is more likely to build with older kernels.=20
>=20
> Only build bat_printk.c with kernels that require it, thanks to Simon
> Wunderlich Makefile.kbuild patch.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Index: Makefile.kbuild
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- Makefile.kbuild	(revision 1524)
> +++ Makefile.kbuild	(working copy)
> @@ -32,4 +32,4 @@
>  endif
> =20
>  obj-m +=3D batman-adv.o
> -batman-adv-objs :=3D main.o proc.o send.o routing.o soft-interface.o dev=
ice.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interf=
ace.o aggregation.o originator.o
> +batman-adv-objs :=3D main.o proc.o send.o routing.o soft-interface.o dev=
ice.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interf=
ace.o aggregation.o originator.o $(shell [ "2" -eq "$(VERSION)" ] && [ "6" =
-eq "$(PATCHLEVEL)" ] && [ "$(SUBLEVEL)" -le "28" ] && echo bat_printk.o)
> Index: translation-table.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- translation-table.c	(revision 1524)
> +++ translation-table.c	(working copy)
> @@ -61,7 +61,6 @@
>  	struct hna_local_entry *hna_local_entry;
>  	struct hna_global_entry *hna_global_entry;
>  	struct hashtable_t *swaphash;
> -	char hna_str[ETH_STR_LEN];
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&hna_local_hash_lock, flags);
> @@ -74,19 +73,17 @@
>  		return;
>  	}
> =20
> -	addr_to_string(hna_str, addr);
> -
>  	/* only announce as many hosts as possible in the batman-packet and
>  	   space in batman_packet->num_hna That also should give a limit to
>  	   MAC-flooding. */
>  	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
>  	    (num_hna + 1 > 255)) {
> -		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%s): number of loc=
al hna entries exceeds packet size \n", hna_str);
> +		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%pM): number of lo=
cal hna entries exceeds packet size \n", addr);
>  		return;
>  	}
> =20
> -	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %s \n",
> -		hna_str);
> +	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %pM \n",
> +		addr);
> =20
>  	hna_local_entry =3D kmalloc(sizeof(struct hna_local_entry), GFP_ATOMIC);
>  	if (!hna_local_entry)
> @@ -201,12 +198,9 @@
>  static void hna_local_del(struct hna_local_entry *hna_local_entry,
>  			  char *message)
>  {
> -	char hna_str[ETH_STR_LEN];
> +	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s \n",
> +		hna_local_entry->addr, message);
> =20
> -	addr_to_string(hna_str, hna_local_entry->addr);
> -	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%s): %s \n",
> -		hna_str, message);
> -
>  	hash_remove(hna_local_hash, hna_local_entry->addr);
>  	_hna_local_del(hna_local_entry);
>  }
> @@ -278,13 +272,10 @@
>  	struct hna_global_entry *hna_global_entry;
>  	struct hna_local_entry *hna_local_entry;
>  	struct hashtable_t *swaphash;
> -	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
>  	int hna_buff_count =3D 0;
>  	unsigned long flags;
>  	unsigned char *hna_ptr;
> =20
> -	addr_to_string(orig_str, orig_node->orig);
> -
>  	while ((hna_buff_count + 1) * ETH_ALEN <=3D hna_buff_len) {
>  		spin_lock_irqsave(&hna_global_hash_lock, flags);
> =20
> @@ -304,10 +295,9 @@
> =20
>  			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
> =20
> -			addr_to_string(hna_str, hna_global_entry->addr);
>  			bat_dbg(DBG_ROUTES,
> -				"Creating new global hna entry: %s (via %s)\n",
> -				hna_str, orig_str);
> +				"Creating new global hna entry: %pM (via %pM)\n",
> +				hna_global_entry->addr, orig_node->orig);
> =20
>  			spin_lock_irqsave(&hna_global_hash_lock, flags);
>  			hash_add(hna_global_hash, hna_global_entry);
> @@ -399,14 +389,10 @@
>  void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
>  			  char *message)
>  {
> -	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
> +	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s \n",
> +		hna_global_entry->addr, hna_global_entry->orig_node->orig,
> +		message);
> =20
> -	addr_to_string(orig_str, hna_global_entry->orig_node->orig);
> -	addr_to_string(hna_str, hna_global_entry->addr);
> -
> -	bat_dbg(DBG_ROUTES, "Deleting global hna entry %s (via %s): %s \n",
> -		hna_str, orig_str, message);
> -
>  	hash_remove(hna_global_hash, hna_global_entry->addr);
>  	kfree(hna_global_entry);
>  }
> Index: send.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- send.c	(revision 1524)
> +++ send.c	(working copy)
> @@ -132,7 +132,6 @@
>  	uint8_t packet_num;
>  	int16_t buff_pos;
>  	struct batman_packet *batman_packet;
> -	char orig_str[ETH_STR_LEN];
> =20
>  	if (batman_if->if_active !=3D IF_ACTIVE)
>  		return;
> @@ -154,15 +153,14 @@
>  		else
>  			batman_packet->flags &=3D ~DIRECTLINK;
> =20
> -		addr_to_string(orig_str, batman_packet->orig);
>  		fwd_str =3D (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
>  							    "Sending own" :
>  							    "Forwarding"));
>  		bat_dbg(DBG_BATMAN,
> -			"%s %spacket (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on inte=
rface %s [%s]\n",
> +			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) on int=
erface %s [%s]\n",
>  			fwd_str,
>  			(packet_num > 0 ? "aggregated " : ""),
> -			orig_str, ntohs(batman_packet->seqno),
> +			batman_packet->orig, ntohs(batman_packet->seqno),
>  			batman_packet->tq, batman_packet->ttl,
>  			(batman_packet->flags & DIRECTLINK ?
>  			 "on" : "off"),
> @@ -186,7 +184,6 @@
>  	struct batman_if *batman_if;
>  	struct batman_packet *batman_packet =3D
>  		(struct batman_packet *)(forw_packet->packet_buff);
> -	char orig_str[ETH_STR_LEN];
>  	unsigned char directlink =3D (batman_packet->flags & DIRECTLINK ? 1 : 0=
);
> =20
>  	if (!forw_packet->if_incoming) {
> @@ -197,8 +194,6 @@
>  	if (forw_packet->if_incoming->if_active !=3D IF_ACTIVE)
>  		return;
> =20
> -	addr_to_string(orig_str, batman_packet->orig);
> -
>  	/* multihomed peer assumed */
>  	/* non-primary OGMs are only broadcasted on their interface */
>  	if ((directlink && (batman_packet->ttl =3D=3D 1)) ||
> @@ -206,9 +201,9 @@
> =20
>  		/* FIXME: what about aggregated packets ? */
>  		bat_dbg(DBG_BATMAN,
> -			"%s packet (originator %s, seqno %d, TTL %d) on interface %s [%s]\n",
> +			"%s packet (originator %pM, seqno %d, TTL %d) on interface %s [%s]\n",
>  			(forw_packet->own ? "Sending own" : "Forwarding"),
> -			orig_str, ntohs(batman_packet->seqno),
> +			batman_packet->orig, ntohs(batman_packet->seqno),
>  			batman_packet->ttl, forw_packet->if_incoming->dev,
>  			forw_packet->if_incoming->addr_str);
> =20
> Index: hard-interface.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- hard-interface.c	(revision 1524)
> +++ hard-interface.c	(working copy)
> @@ -74,7 +74,6 @@
>  static void check_known_mac_addr(uint8_t *addr)
>  {
>  	struct batman_if *batman_if;
> -	char mac_string[ETH_STR_LEN];
> =20
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(batman_if, &if_list, list) {
> @@ -85,9 +84,8 @@
>  		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
>  			continue;
> =20
> -		addr_to_string(mac_string, addr);
> -		printk(KERN_WARNING "batman-adv:The newly added mac address (%s) alrea=
dy exists on: %s\n",
> -		       mac_string, batman_if->dev);
> +		printk(KERN_WARNING "batman-adv:The newly added mac address (%pM) alre=
ady exists on: %s\n",
> +		       addr, batman_if->dev);
>  		printk(KERN_WARNING "batman-adv:It is strongly recommended to keep mac=
 addresses unique to avoid problems!\n");
>  	}
>  	rcu_read_unlock();
> Index: originator.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- originator.c	(revision 1524)
> +++ originator.c	(working copy)
> @@ -121,7 +121,6 @@
>  {
>  	struct orig_node *orig_node;
>  	struct hashtable_t *swaphash;
> -	char orig_str[ETH_STR_LEN];
>  	int size;
> =20
>  	orig_node =3D ((struct orig_node *)hash_find(orig_hash, addr));
> @@ -129,8 +128,7 @@
>  	if (orig_node !=3D NULL)
>  		return orig_node;
> =20
> -	addr_to_string(orig_str, addr);
> -	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
> +	bat_dbg(DBG_BATMAN, "Creating new originator: %pM \n", addr);
> =20
>  	orig_node =3D kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
>  	if (!orig_node)
> @@ -186,7 +184,6 @@
>  				 struct neigh_node **best_neigh_node)
>  {
>  	struct list_head *list_pos, *list_pos_tmp;
> -	char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
>  	struct neigh_node *neigh_node;
>  	bool neigh_purged =3D false;
> =20
> @@ -201,9 +198,7 @@
>  			       (neigh_node->last_valid +
>  				((PURGE_TIMEOUT * HZ) / 1000)))) {
> =20
> -			addr_to_string(neigh_str, neigh_node->addr);
> -			addr_to_string(orig_str, orig_node->orig);
> -			bat_dbg(DBG_BATMAN, "neighbor timeout: originator %s, neighbor: %s, l=
ast_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
> +			bat_dbg(DBG_BATMAN, "neighbor timeout: originator %pM, neighbor: %pM,=
 last_valid %lu\n", orig_node->orig, neigh_node->addr, (neigh_node->last_va=
lid / HZ));
> =20
>  			neigh_purged =3D true;
>  			list_del(list_pos);
> @@ -221,17 +216,14 @@
>  static bool purge_orig_node(struct orig_node *orig_node)
>  {
>  	struct neigh_node *best_neigh_node;
> -	char orig_str[ETH_STR_LEN];
> =20
> -	addr_to_string(orig_str, orig_node->orig);
> -
>  	if (time_after(jiffies,
>  		       (orig_node->last_valid +
>  			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
> =20
>  		bat_dbg(DBG_BATMAN,
> -			"Originator timeout: originator %s, last_valid %lu\n",
> -			orig_str, (orig_node->last_valid / HZ));
> +			"Originator timeout: originator %pM, last_valid %lu\n",
> +			orig_node->orig, (orig_node->last_valid / HZ));
>  		return true;
>  	} else {
>  		if (purge_orig_neighbors(orig_node, &best_neigh_node))
> Index: routing.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- routing.c	(revision 1524)
> +++ routing.c	(working copy)
> @@ -80,32 +80,24 @@
>  			 struct neigh_node *neigh_node,
>  			 unsigned char *hna_buff, int hna_buff_len)
>  {
> -	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
> -	char router_str[ETH_STR_LEN];
> -
> -	addr_to_string(orig_str, orig_node->orig);
> -
>  	/* route deleted */
>  	if ((orig_node->router !=3D NULL) && (neigh_node =3D=3D NULL)) {
> =20
> -		bat_dbg(DBG_ROUTES, "Deleting route towards: %s\n",
> -			orig_str);
> +		bat_dbg(DBG_ROUTES, "Deleting route towards: %pM\n",
> +			orig_node->orig);
>  		hna_global_del_orig(orig_node, "originator timed out");
> =20
>  		/* route added */
>  	} else if ((orig_node->router =3D=3D NULL) && (neigh_node !=3D NULL)) {
> =20
> -		addr_to_string(neigh_str, neigh_node->addr);
>  		bat_dbg(DBG_ROUTES,
> -			"Adding route towards: %s (via %s)\n",
> -			orig_str, neigh_str);
> +			"Adding route towards: %pM (via %pM)\n",
> +			orig_node->orig, neigh_node->addr);
>  		hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
> =20
>  		/* route changed */
>  	} else {
> -		addr_to_string(neigh_str, neigh_node->addr);
> -		addr_to_string(router_str, orig_node->router->addr);
> -		bat_dbg(DBG_ROUTES, "Changing route towards: %s (now via %s - was via =
%s)\n", orig_str, neigh_str, router_str);
> +		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was vi=
a %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
>  	}
> =20
>  	if (neigh_node !=3D NULL)
> @@ -138,12 +130,8 @@
>  				struct batman_if *if_incoming)
>  {
>  	struct neigh_node *neigh_node =3D NULL, *tmp_neigh_node =3D NULL;
> -	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
>  	unsigned char total_count;
> =20
> -	addr_to_string(orig_str, orig_node->orig);
> -	addr_to_string(neigh_str, orig_neigh_node->orig);
> -
>  	if (orig_node =3D=3D orig_neigh_node) {
>  		list_for_each_entry(tmp_neigh_node,
>  				    &orig_node->neigh_list,
> @@ -227,8 +215,8 @@
>  			      orig_neigh_node->tq_asym_penalty) /
>  			     (TQ_MAX_VALUE *	 TQ_MAX_VALUE));
> =20
> -	bat_dbg(DBG_BATMAN, "bidirectional: orig =3D %-15s neigh =3D %-15s =3D>=
 own_bcast =3D %2i, real recv =3D %2i, local tq: %3i, asym_penalty: %3i, to=
tal tq: %3i \n",
> -		orig_str, neigh_str, total_count,
> +	bat_dbg(DBG_BATMAN, "bidirectional: orig =3D %-15pM neigh =3D %-15pM =
=3D> own_bcast =3D %2i, real recv =3D %2i, local tq: %3i, asym_penalty: %3i=
, total tq: %3i \n",
> +		orig_node->orig, orig_neigh_node->orig, total_count,
>  		neigh_node->real_packet_count, orig_neigh_node->tq_own,
>  		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
> =20
> @@ -372,8 +360,6 @@
>  {
>  	struct batman_if *batman_if;
>  	struct orig_node *orig_neigh_node, *orig_node;
> -	char orig_str[ETH_STR_LEN], prev_sender_str[ETH_STR_LEN];
> -	char neigh_str[ETH_STR_LEN];
>  	char has_directlink_flag;
>  	char is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;
>  	char is_broadcast =3D 0, is_bidirectional, is_single_hop_neigh;
> @@ -398,20 +384,16 @@
>  	/* could be changed by schedule_own_packet() */
>  	if_incoming_seqno =3D atomic_read(&if_incoming->seqno);
> =20
> -	addr_to_string(orig_str, batman_packet->orig);
> -	addr_to_string(prev_sender_str, batman_packet->prev_sender);
> -	addr_to_string(neigh_str, ethhdr->h_source);
> -
>  	has_directlink_flag =3D (batman_packet->flags & DIRECTLINK ? 1 : 0);
> =20
>  	is_single_hop_neigh =3D (compare_orig(ethhdr->h_source,
>  					    batman_packet->orig) ? 1 : 0);
> =20
> -	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %s, IF: %s [%s] (fr=
om OG: %s, via prev OG: %s, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
> -		neigh_str, if_incoming->dev, if_incoming->addr_str,
> -		orig_str, prev_sender_str, batman_packet->seqno,
> -		batman_packet->tq, batman_packet->ttl, batman_packet->version,
> -		has_directlink_flag);
> +	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (f=
rom OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
> +		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
> +		batman_packet->orig, batman_packet->prev_sender,
> +		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
> +		batman_packet->version, has_directlink_flag);
> =20
>  	list_for_each_entry_rcu(batman_if, &if_list, list) {
>  		if (batman_if->if_active !=3D IF_ACTIVE)
> @@ -442,13 +424,13 @@
> =20
>  	if (is_my_addr) {
>  		bat_dbg(DBG_BATMAN,
> -			"Drop packet: received my own broadcast (sender: %s)\n",
> -			neigh_str);
> +			"Drop packet: received my own broadcast (sender: %pM)\n",
> +			ethhdr->h_source);
>  		return;
>  	}
> =20
>  	if (is_broadcast) {
> -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast =
source addr (sender: %s) \n", neigh_str);
> +		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast =
source addr (sender: %pM) \n", ethhdr->h_source);
>  		return;
>  	}
> =20
> @@ -488,7 +470,7 @@
>  	}
> =20
>  	if (is_my_oldorig) {
> -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (send=
er: %s) \n", neigh_str);
> +		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (send=
er: %pM) \n", ethhdr->h_source);
>  		return;
>  	}
> =20
> @@ -506,7 +488,7 @@
>  	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
>  	    (compare_orig(orig_node->router->addr,
>  			  orig_node->router->orig_node->router->addr))) {
> -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets tha=
t may make me loop (sender: %s) \n", neigh_str);
> +		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets tha=
t may make me loop (sender: %pM) \n", ethhdr->h_source);
>  		return;
>  	}
> =20
> @@ -659,7 +641,6 @@
> =20
>  static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
>  {
> -	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
>  	struct orig_node *orig_node;
>  	struct icmp_packet *icmp_packet;
>  	struct ethhdr *ethhdr;
> @@ -670,11 +651,8 @@
>  	icmp_packet =3D (struct icmp_packet *) skb->data;
>  	ethhdr =3D (struct ethhdr *) skb_mac_header(skb);
> =20
> -	addr_to_string(src_str, icmp_packet->orig);
> -	addr_to_string(dst_str, icmp_packet->dst);
> +	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to=
 %pM: ttl exceeded\n", icmp_packet->orig, icmp_packet->dst);
> =20
> -	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to =
%s: ttl exceeded\n", src_str, dst_str);
> -
>  	/* send TTL exceeded if packet is an echo request (traceroute) */
>  	if (icmp_packet->msg_type !=3D ECHO_REQUEST)
>  		return NET_RX_DROP;
> @@ -793,7 +771,6 @@
>  int recv_unicast_packet(struct sk_buff *skb)
>  {
>  	struct unicast_packet *unicast_packet;
> -	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
>  	struct orig_node *orig_node;
>  	struct ethhdr *ethhdr;
>  	struct batman_if *batman_if;
> @@ -831,10 +808,7 @@
> =20
>  	/* TTL exceeded */
>  	if (unicast_packet->ttl < 2) {
> -		addr_to_string(src_str, ethhdr->h_source);
> -		addr_to_string(dst_str, ethhdr->h_dest);
> -
> -		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to=
 %s: ttl exceeded\n", src_str, dst_str);
> +		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM t=
o %pM: ttl exceeded\n", ethhdr->h_source, unicast_packet->dest);
>  		return NET_RX_DROP;
>  	}
> =20
> @@ -984,5 +958,3 @@
>  	}
>  	return ret;
>  }
> -
> -
> Index: compat.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- compat.h	(revision 1524)
> +++ compat.h	(working copy)
> @@ -73,3 +73,8 @@
>  	ret; \
>  })
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25) */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
> +asmlinkage int bat_printk(const char *fmt, ...);
> +#define printk bat_printk
> +#endif
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks+HS4ACgkQrzg/fFk7axZ3ZgCgkWLHZvZDfo+an0F0FaM+DyuT
wa0AoNhIB729hJw/3zPC721PYWT0PsDz
=tJQo
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
