Return-Path: <antonio@meshcoding.com>
Date: Tue, 15 Oct 2013 21:20:23 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131015192023.GN3873@neomailbox.net>
References: <1379088490-2693-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <3449342.7k6WirsOky@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Content-Disposition: inline
In-Reply-To: <3449342.7k6WirsOky@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalize batman-adv icmp
 packet handling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2013 at 04:04:31PM +0800, Marek Lindner wrote:
> On Friday 13 September 2013 18:08:10 Simon Wunderlich wrote:
> > +/**
> > + * batadv_socket_receive_packet - schedule an icmp packet to be sent to
> > userspace + *  on an icmp socket.
> > + * @socket_client: the socket this packet belongs to
> > + * @icmph: pointer to the header of the icmp packet
> > + * @icmp_len: total length of the icmp packet
> > + */
> >  static void batadv_socket_add_packet(struct batadv_socket_client
> > *socket_client, -				     struct batadv_icmp_packet_rr=20
> *icmp_packet,
> > +				     struct batadv_icmp_header *icmph,
> >  				     size_t icmp_len)
> >  {
> >  	struct batadv_socket_packet *socket_packet;
> > +	size_t len;
> >=20
> >  	socket_packet =3D kmalloc(sizeof(*socket_packet), GFP_ATOMIC);
> >=20
> >  	if (!socket_packet)
> >  		return;
> >=20
> > +	len =3D icmp_len;
> > +	/* check the maximum length before filling the buffer */
> > +	if (len > sizeof(socket_packet->icmp_packet))
> > +		len =3D sizeof(socket_packet->icmp_packet);
> > +
> >  	INIT_LIST_HEAD(&socket_packet->list);
> > -	memcpy(&socket_packet->icmp_packet, icmp_packet, icmp_len);
> > +	memcpy(&socket_packet->icmp_packet, icmph, icmp_len);
>=20
> Shouldn't "len" be used here ?
>=20
> Besides, if we make everything generic batadv_socket_packet->icmp_packet=
=20
> should not be hard-coded to batadv_icmp_packet_rr but the largest availab=
le=20
> ICMP packet type ?


or we dynamically allocate a buffer of size 'len'? In this way we don't nee=
d to
change icmp_packet each time (hopefully not so many but still..)  the
"largest available ICMP packet type" changes.


>=20
>=20
> > +/**
> > + * batadv_recv_my_icmp_packet - receive an icmp packet locally
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @skb: icmp packet to process
> > + *
> > + * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DR=
OP
> > + * otherwise.
> > + */
> >  static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
> > -				      struct sk_buff *skb, size_t icmp_len)
> > +				      struct sk_buff *skb)
> >  {
> >  	struct batadv_hard_iface *primary_if =3D NULL;
> >  	struct batadv_orig_node *orig_node =3D NULL;
> > -	struct batadv_icmp_packet_rr *icmp_packet;
> > +	struct batadv_icmp_header *icmph;
> >  	int ret =3D NET_RX_DROP;
> >=20
> > -	icmp_packet =3D (struct batadv_icmp_packet_rr *)skb->data;
> > +	icmph =3D (struct batadv_icmp_header *)skb->data;
> >=20
> >  	/* add data to device queue */
> > -	if (icmp_packet->icmph.msg_type !=3D BATADV_ECHO_REQUEST) {
> > -		batadv_socket_receive_packet(icmp_packet, icmp_len);
> > +	if (icmph->msg_type !=3D BATADV_ECHO_REQUEST) {
> > +		if (skb_linearize(skb) < 0)
> > +			goto out;
> > +
> > +		batadv_socket_receive_packet(icmph, skb->len);
> >  		goto out;
> >  	}
>=20
> Wouldn't it be better to dump unkown icmp types for us instead of copying=
=20
> everything to user space ?

dump =3D=3D drop ? in that case I agree. Delivering unknown packets to batc=
tl may
also be dangerous.

>=20
> Same is true for batadv_socket_write(). We should use the icmp header and=
 not=20
> assume icmp echo.

do you mean using the ICMP header to understand what packet it is and then
behave accordingly? Also in this case I agree with you :)


Moving to a packet type based "check" was also part of the original idea of=
 this
generalisation (if I remember correctly), but not really needed when lookin=
g at
avoiding further compatibility breakage (this should be the reason why this
"feature" is not part of this patch).



I am not replying on Simon's behalf, I was just eager to share my 2 cents.

Cheers,


--=20
Antonio Quartulli

--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSXZV3AAoJEADl0hg6qKeO6ywP/izGPWffzVoN50AxUXMtJnIN
045bwjRMMupFAlgB1VL5CutI0lMzkDYzQVJe6pH5gINmLaiZvDUmdWkpyEc3xEKa
qAdM0KJdAraa1Hlx0IRc7OifojrCttgW0vacmvbFSkjBc5zqQvczNci08R+bo/yG
3Ftr7KYcUwtOAlDqfSq4T5NxgPYiReTg1xsEnNe9Z3r8gEbA/YqSiynymF0tYzXJ
aU1HK+hlUXweHFwJUkEqajgktMnkmuqvi+jAcw4BaoxBQYM+vHqKcYlcRdBEK58S
pFbo7yQEjO0mwUr+prJ/ezSyQEAGWDLSIznUlgfml/WuIFh+LCl/KwSuJnjmRCl8
7I8q8TfCrhJY0Hz1PnMYfKxFHsTIInkqUU1zKBW3fapKIxhVZn5Mu540DiU8/9fr
xK6c99DKx3xLFkcyoXkI6iik6HSE0VTeoazoroqYSwE5aF7BItDeh09qvtm32jaQ
s3LB4RyVFyEdw6WtUaRy6t+0x6wfyfxbsyvCZGvyuKV7F/k2mPai960CilsMRYvl
6latdavhySoq7o+PRyHUFzpmruY/PKe0I/VEswzrNXYI70TOachZsjCWFNUY7iy4
DWVDudHOBURLjC6qGlRcCvcQsc0El0QngPCyVHy7aoMHBtIZEFigqTjF5prEI4VA
s02dJWXMNj00ada4HCzY
=M304
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--
