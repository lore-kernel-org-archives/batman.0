Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 6 Apr 2010 12:41:29 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100406104129.GA19923@pandem0nium>
References: <20100404220120.GA9171@pandem0nium>
	<20100406093331.GA24150@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20100406093331.GA24150@Sellars>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Reorganize sequence
	number	handling
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

=66rom the time where the messages come (the printk is removed in the submi=
tted
version of the patch BTW), we can see that there is a 30 second period betw=
een
the protection time starts - as it is supposed to be.

I guess you have stopped your broadcast ping after ~900 seconds, but still
receive packets some time later. Do you have some dumps or any analysis data
for this?

I will try to rebuild your setup and turn the broadcast replies on later.

Thanks for testing.
	Simon

On Tue, Apr 06, 2010 at 11:33:31AM +0200, Linus L=C3=BCssing wrote:
> Hi Simon,
>=20
> sorry, I need to resign my ack again, I guess. I now noticed that
> I couldn't reproduce the issue anymore because of not being able
> to produce enough broadcasts (~3x83 small packets per second).
> It turned out, that the ping utility itself seems to limit the
> interval when it gets no icmp reply although flood-ping is
> activated. So with setting "/proc/sys/net/ipv4/icmp_echo_ignore_broadcast=
s"
> to 0 on the host which produces the icmp requests, I could produce
> ~7000 packets per second again - the ping utilitly seems to use
> the icmp replies as a flow control, I guess.
>=20
> And then the issue seems to still be there here. I start the
> broadcast-flood-ping in a setup A - B - C on node A and stop it
> again on node A a second later. Then the icmp-packets still
> bounce between B and C until B stops with no more memory available
> (haven't applied your 2nd patch for limiting the queue yet).
>=20
> From your original patch, I'm getting only one "XXX protected it messages=
" on A and C,
> but a lot more on B:
> [  416.612253] XXX protect it!
> [  446.618569] XXX protect it!
> [  476.824103] XXX protect it!
> [  506.836694] XXX protect it!
> [  537.036869] XXX protect it!
> [  567.056133] XXX protect it!
> [  597.058637] XXX protect it!
> [  847.936099] XXX protect it!
> [  848.560450] XXX protect it!
> [  907.686827] XXX protect it!
> [ 1994.836111] XXX protect it!
>=20
> Cheers, Linus
>=20
> On Mon, Apr 05, 2010 at 12:01:20AM +0200, Simon Wunderlich wrote:
> > BATMAN and broadcast packets are tracked with a sequence number window =
of
> > currently 64 entries to measure and avoid duplicates. Packets which hav=
e a=20
> > sequence number smaller than the newest received packet minus 64 are not
> > within this sequence number window anymore and are called "old packets"=
 from
> > now on.
> >=20
> > When old packets are received, the routing code assumes that the host o=
f the=20
> > originator has been restarted. This assumption however might be wrong a=
s=20
> > packets can also be delayed by NIC drivers, e.g. because of long queues=
 or=20
> > collision detection in dense WiFi environments. This behaviour can be=
=20
> > reproduced by doing a broadcast ping flood in a dense node environment.
> >=20
> > The effect is that the sequence number window is jumping forth and back=
,=20
> > accepting and forwarding any packet (because packets are assumed to be =
"new")
> > and causing loops.
> >=20
> > To overcome this problem, the sequence number handling has been reorgan=
ized.
> > When an old packet is received, the window is reset back only once. Oth=
er old
> > packets are dropped for (currently) 30 seconds to "protect" the new seq=
uence
> > number and avoid the hopping as described above.
> >=20
> > The reorganization brings some code cleanups (at least i hope you feel =
the
> > same) and also fixes a bug in count_real_packets() which falsely update=
d=20
> > the last_real_seqno for slightly older packets within the seqno window
> > if they are no duplicates.
> >=20
> > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > Acked-by: Linus Luessing <linus.luessing@web.de>
> >=20
> > Index: a/batman-adv-kernelland/types.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/batman-adv-kernelland/types.h	(revision 1616)
> > +++ a/batman-adv-kernelland/types.h	(working copy)
> > @@ -55,6 +55,10 @@
> >  	uint8_t tq_own;
> >  	int tq_asym_penalty;
> >  	unsigned long last_valid;        /* when last packet from this node w=
as received */
> > +	unsigned long bcast_seqno_reset; /* time when the broadcast
> > +					    seqno window was reset. */
> > +	unsigned long batman_seqno_reset;/* time when the batman seqno
> > +					    window was reset. */
> >  	uint8_t gw_flags;      /* flags related to gateway class */
> >  	uint8_t flags;    /* for now only VIS_SERVER flag. */
> >  	unsigned char *hna_buff;
> > Index: a/batman-adv-kernelland/bitarray.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/batman-adv-kernelland/bitarray.c	(revision 1616)
> > +++ a/batman-adv-kernelland/bitarray.c	(working copy)
> > @@ -111,48 +111,74 @@
> >  		seq_bits[i] =3D 0;
> >  }
> > =20
> > +static void bit_reset_window(TYPE_OF_WORD *seq_bits)
> > +{
> > +	int i;
> > +	for (i =3D 0; i < NUM_WORDS; i++)
> > +		seq_bits[i] =3D 0;
> > +}
> > =20
> > -/* receive and process one packet, returns 1 if received seq_num is co=
nsidered
> > - * new, 0 if old  */
> > +
> > +/* receive and process one packet within the sequence number window.
> > + *
> > + * returns:
> > + *  1 if the window was moved (either new or very old)
> > + *  0 if the window was not moved/shifted.
> > + */
> >  char bit_get_packet(TYPE_OF_WORD *seq_bits, int16_t seq_num_diff,
> >  		    int8_t set_mark)
> >  {
> > -	int i;
> > +	/* sequence number is slightly older. We already got a sequence number
> > +	 * higher than this one, so we just mark it. */
> > =20
> > -	/* we already got a sequence number higher than this one, so we just
> > -	 * mark it. this should wrap around the integer just fine */
> >  	if ((seq_num_diff < 0) && (seq_num_diff >=3D -TQ_LOCAL_WINDOW_SIZE)) {
> >  		if (set_mark)
> >  			bit_mark(seq_bits, -seq_num_diff);
> >  		return 0;
> >  	}
> > =20
> > -	/* it seems we missed a lot of packets or the other host restarted */
> > -	if ((seq_num_diff > TQ_LOCAL_WINDOW_SIZE) ||
> > -	    (seq_num_diff < -TQ_LOCAL_WINDOW_SIZE)) {
> > +	/* sequence number is slightly newer, so we shift the window and
> > +	 * set the mark if required */
> > =20
> > -		if (seq_num_diff > TQ_LOCAL_WINDOW_SIZE)
> > -			bat_dbg(DBG_BATMAN,
> > -				"We missed a lot of packets (%i) !\n",
> > -				seq_num_diff-1);
> > +	if ((seq_num_diff >=3D 0) && (seq_num_diff <=3D TQ_LOCAL_WINDOW_SIZE)=
) {
> > +		bit_shift(seq_bits, seq_num_diff);
> > =20
> > -		if (-seq_num_diff > TQ_LOCAL_WINDOW_SIZE)
> > -			bat_dbg(DBG_BATMAN,
> > -				"Other host probably restarted !\n");
> > +		if (set_mark)
> > +			bit_mark(seq_bits, 0);
> > +		return 1;
> > +	}
> > =20
> > -		for (i =3D 0; i < NUM_WORDS; i++)
> > -			seq_bits[i] =3D 0;
> > +	/* sequence number is much newer, probably missed a lot of packets */
> > =20
> > +	if (seq_num_diff > TQ_LOCAL_WINDOW_SIZE) {
> > +		bat_dbg(DBG_BATMAN,
> > +			"We missed a lot of packets (%i) !\n",
> > +			seq_num_diff - 1);
> > +		bit_reset_window(seq_bits);
> >  		if (set_mark)
> > -			seq_bits[0] =3D 1;  /* we only have the latest packet */
> > -	} else {
> > -		bit_shift(seq_bits, seq_num_diff);
> > +			bit_mark(seq_bits, 0);
> > +		return 1;
> > +	}
> > =20
> > +	/* received a much older packet. The other host either restarted
> > +	 * or the old packet got delayed somewhere in the network. The
> > +	 * packet should be dropped without calling this function if the
> > +	 * seqno window is protected. */
> > +
> > +	if (-seq_num_diff > TQ_LOCAL_WINDOW_SIZE) {
> > +
> > +		bat_dbg(DBG_BATMAN,
> > +			"Other host probably restarted!\n");
> > +
> > +		bit_reset_window(seq_bits);
> >  		if (set_mark)
> >  			bit_mark(seq_bits, 0);
> > +
> > +		return 1;
> >  	}
> > =20
> > -	return 1;
> > +	/* never reached */
> > +	return 0;
> >  }
> > =20
> >  /* count the hamming weight, how many good packets did we receive? jus=
t count
> > Index: a/batman-adv-kernelland/originator.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/batman-adv-kernelland/originator.c	(revision 1616)
> > +++ a/batman-adv-kernelland/originator.c	(working copy)
> > @@ -141,6 +141,8 @@
> >  	orig_node->router =3D NULL;
> >  	orig_node->batman_if =3D NULL;
> >  	orig_node->hna_buff =3D NULL;
> > +	orig_node->bcast_seqno_reset =3D jiffies;
> > +	orig_node->batman_seqno_reset =3D jiffies;
> > =20
> >  	size =3D num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
> > =20
> > Index: a/batman-adv-kernelland/routing.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/batman-adv-kernelland/routing.c	(revision 1616)
> > +++ a/batman-adv-kernelland/routing.c	(working copy)
> > @@ -323,6 +323,37 @@
> >  		gw_check_election(bat_priv, orig_node);
> >  }
> > =20
> > +/* checks whether the host restarted and is in the protection time.
> > + * returns:
> > + *  0 if the packet is to be accepted
> > + *  1 if the packet is to be ignored.
> > + */
> > +static int window_protected(int16_t seq_num_diff,
> > +				unsigned long *last_reset)
> > +{
> > +	if (-seq_num_diff > TQ_LOCAL_WINDOW_SIZE) {
> > +		if (time_after(jiffies, *last_reset +
> > +			msecs_to_jiffies(RESET_PROTECTION_MS))) {
> > +
> > +			*last_reset =3D jiffies;
> > +			bat_dbg(DBG_BATMAN,
> > +				"old packet received, start protection\n");
> > +
> > +			return 0;
> > +		} else
> > +			return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* processes a batman packet for all interfaces, adjusts the sequence =
number and
> > + * finds out whether it is a duplicate.
> > + * returns:
> > + *   1 the packet is a duplicate
> > + *   0 the packet has not yet been received
> > + *  -1 the packet is old and has been received while the seqno window
> > + *     was protected. Caller should drop it.
> > + */
> >  static char count_real_packets(struct ethhdr *ethhdr,
> >  			       struct batman_packet *batman_packet,
> >  			       struct batman_if *if_incoming)
> > @@ -330,31 +361,41 @@
> >  	struct orig_node *orig_node;
> >  	struct neigh_node *tmp_neigh_node;
> >  	char is_duplicate =3D 0;
> > -	uint16_t seq_diff;
> > +	int16_t seq_diff;
> > +	int need_update =3D 0;
> > +	int set_mark;
> > =20
> >  	orig_node =3D get_orig_node(batman_packet->orig);
> >  	if (orig_node =3D=3D NULL)
> >  		return 0;
> > =20
> > +	seq_diff =3D batman_packet->seqno - orig_node->last_real_seqno;
> > +
> > +	/* signalize caller that the packet is to be dropped. */
> > +	if (window_protected(seq_diff, &orig_node->batman_seqno_reset))
> > +		return -1;
> > +
> >  	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
> > =20
> > -		if (!is_duplicate)
> > -			is_duplicate =3D
> > -				get_bit_status(tmp_neigh_node->real_bits,
> > +		is_duplicate |=3D get_bit_status(tmp_neigh_node->real_bits,
> >  					       orig_node->last_real_seqno,
> >  					       batman_packet->seqno);
> > -		seq_diff =3D batman_packet->seqno - orig_node->last_real_seqno;
> > +
> >  		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
> >  		    (tmp_neigh_node->if_incoming =3D=3D if_incoming))
> > -			bit_get_packet(tmp_neigh_node->real_bits, seq_diff, 1);
> > +			set_mark =3D 1;
> >  		else
> > -			bit_get_packet(tmp_neigh_node->real_bits, seq_diff, 0);
> > +			set_mark =3D 0;
> > =20
> > +		/* if the window moved, set the update flag. */
> > +		need_update |=3D bit_get_packet(tmp_neigh_node->real_bits,
> > +						seq_diff, set_mark);
> > +
> >  		tmp_neigh_node->real_packet_count =3D
> >  			bit_packet_count(tmp_neigh_node->real_bits);
> >  	}
> > =20
> > -	if (!is_duplicate) {
> > +	if (need_update) {
> >  		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d\n",
> >  			orig_node->last_real_seqno, batman_packet->seqno);
> >  		orig_node->last_real_seqno =3D batman_packet->seqno;
> > @@ -587,24 +628,27 @@
> >  		return;
> >  	}
> > =20
> > -	if (batman_packet->tq =3D=3D 0) {
> > -		count_real_packets(ethhdr, batman_packet, if_incoming);
> > -
> > -		bat_dbg(DBG_BATMAN, "Drop packet: originator packet with tq equal 0\=
n");
> > -		return;
> > -	}
> > -
> >  	if (is_my_oldorig) {
> >  		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (se=
nder: %pM)\n", ethhdr->h_source);
> >  		return;
> >  	}
> > =20
> > -	is_duplicate =3D count_real_packets(ethhdr, batman_packet, if_incomin=
g);
> > -
> >  	orig_node =3D get_orig_node(batman_packet->orig);
> >  	if (orig_node =3D=3D NULL)
> >  		return;
> > =20
> > +	is_duplicate =3D count_real_packets(ethhdr, batman_packet, if_incomin=
g);
> > +
> > +	if (is_duplicate =3D=3D -1) {
> > +		bat_dbg(DBG_BATMAN, "Drop packet: packet within seqno protection tim=
e (sender: %pM)\n", ethhdr->h_source);
> > +		return;
> > +	}
> > +
> > +	if (batman_packet->tq =3D=3D 0) {
> > +		bat_dbg(DBG_BATMAN,	"Drop packet: originator packet with tq equal 0\=
n");
> > +		return;
> > +	}
> > +
> >  	/* avoid temporary routing loops */
> >  	if ((orig_node->router) &&
> >  	    (orig_node->router->orig_node->router) &&
> > @@ -1088,6 +1132,7 @@
> >  	struct bcast_packet *bcast_packet;
> >  	struct ethhdr *ethhdr;
> >  	int hdr_size =3D sizeof(struct bcast_packet);
> > +	int16_t seq_diff;
> >  	unsigned long flags;
> > =20
> >  	/* drop packet if it has not necessary minimum size */
> > @@ -1123,7 +1168,7 @@
> >  		return NET_RX_DROP;
> >  	}
> > =20
> > -	/* check flood history */
> > +	/* check whether the packet is a duplicate */
> >  	if (get_bit_status(orig_node->bcast_bits,
> >  			   orig_node->last_bcast_seqno,
> >  			   ntohs(bcast_packet->seqno))) {
> > @@ -1131,14 +1176,20 @@
> >  		return NET_RX_DROP;
> >  	}
> > =20
> > -	/* mark broadcast in flood history */
> > -	if (bit_get_packet(orig_node->bcast_bits,
> > -			   ntohs(bcast_packet->seqno) -
> > -			   orig_node->last_bcast_seqno, 1))
> > +	seq_diff =3D ntohs(bcast_packet->seqno) - orig_node->last_bcast_seqno;
> > +
> > +	/* check whether the packet is old and the host just restarted. */
> > +	if (window_protected(seq_diff, &orig_node->bcast_seqno_reset)) {
> > +		spin_unlock_irqrestore(&orig_hash_lock, flags);
> > +		return NET_RX_DROP;
> > +	}
> > +
> > +	/* mark broadcast in flood history, update window position
> > +	 * if required. */
> > +	if (bit_get_packet(orig_node->bcast_bits, seq_diff, 1))
> >  		orig_node->last_bcast_seqno =3D ntohs(bcast_packet->seqno);
> > =20
> >  	spin_unlock_irqrestore(&orig_hash_lock, flags);
> > -
> >  	/* rebroadcast packet */
> >  	add_bcast_packet_to_list(skb);
> > =20
> > Index: a/batman-adv-kernelland/main.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/batman-adv-kernelland/main.h	(revision 1616)
> > +++ a/batman-adv-kernelland/main.h	(working copy)
> > @@ -66,6 +66,9 @@
> >  				   * forw_packet->direct_link_flags */
> >  #define MAX_AGGREGATION_MS 100
> > =20
> > +#define RESET_PROTECTION_MS 30000
> > +/* don't reset again within 30 seconds */
> > +
> >  #define MODULE_INACTIVE 0
> >  #define MODULE_ACTIVE 1
> >  #define MODULE_DEACTIVATING 2
> >=20
>=20

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku7D9kACgkQrzg/fFk7axYFpQCgkXrbA7+R83RMMvtq84MYfeOO
DvgAoLfwV/yS/aLeJLwhT4lXNOBOUOdd
=bllY
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
