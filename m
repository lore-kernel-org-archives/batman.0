Return-Path: <ordex@autistici.org>
Date: Mon, 12 Aug 2013 19:48:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130812174820.GJ849@ritirata.org>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
 <1376224403-2494-3-git-send-email-ordex@autistici.org>
 <20130812142812.GA18832@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <20130812142812.GA18832@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/9] batman-adv: make struct
 batadv_orig_node algorithm agnostic
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


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2013 at 04:28:12PM +0200, Simon Wunderlich wrote:
> > diff --git a/routing.c b/routing.c
> > index d4f512d..5b8f087 100644
> > --- a/routing.c
> > +++ b/routing.c
> > @@ -1091,6 +1091,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
> >  	int hdr_size =3D sizeof(*bcast_packet);
> >  	int ret =3D NET_RX_DROP;
> >  	int32_t seq_diff;
> > +	uint32_t seqno;
> > =20
> >  	/* drop packet if it has not necessary minimum size */
> >  	if (unlikely(!pskb_may_pull(skb, hdr_size)))
> > @@ -1126,12 +1127,13 @@ int batadv_recv_bcast_packet(struct sk_buff *sk=
b,
> > =20
> >  	spin_lock_bh(&orig_node->bcast_seqno_lock);
> > =20
> > +	seqno =3D ntohl(bcast_packet->seqno);
> >  	/* check whether the packet is a duplicate */
> >  	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqn=
o,
> > -			    ntohl(bcast_packet->seqno)))
> > +			    seqno))
> >  		goto spin_unlock;
> > =20
> > -	seq_diff =3D ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
> > +	seq_diff =3D seqno - orig_node->last_bcast_seqno;
> > =20
> >  	/* check whether the packet is old and the host just restarted. */
> >  	if (batadv_window_protected(bat_priv, seq_diff,
> > @@ -1142,7 +1144,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
> >  	 * if required.
> >  	 */
> >  	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, =
1))
> > -		orig_node->last_bcast_seqno =3D ntohl(bcast_packet->seqno);
> > +		orig_node->last_bcast_seqno =3D seqno;
> > =20
> >  	spin_unlock_bh(&orig_node->bcast_seqno_lock);
>=20
> Why are you changing this seqno stuff? Although this might be a valid
> (micro-)optimization, I don't think this should be in this patch ... or
> at least I don't understand it. :)

I must introduce a seqno variable to shorten a line that is following.
Since I could choose, I decided to use seqno to store the value received wi=
thin
the packet so that I could reduce the number of ntohs.
So I had to do that change and I did it in a good way :)

Cheers,




--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSCR/kAAoJEADl0hg6qKeOXeoP/1rpCin7n/XGveuV8PWZtgmE
q3fpGo2bv7NqbY3sFuEzQ34m54CNbO3fTeG1UjE/QE1j68Ku9fqfazt1J0w/8rUI
hAYr0LdpQv0DhtE3BsbfXZGBnlCUEyanQdySmhkAe21kS+g+3bVCRf3C5jt5L5QU
3LOsTt26Rkf7IQ3AjtxlYW8XCb7zoKtjYd2fL0MVE/o1VfjIgFGy+IuhkUzhTFrq
m9+l2jXIrOEOu8+oxROG5DXdnuSp4/jW06pQ4mMLwGxsBcyDWj6CSwcooHTpIvmJ
xYVRwDo7XcMQI2RdAnt5jJMHRrV5SogHFeS8i0g9MlNl94PJ9pdXnRzp4cgo275v
vYsxOnZySe5l+btrutXl7JmGV1T2jaqi/0rRi7ms4Zxled5ZKyqNNgcefhp/7J45
4DeVaUkAPV7PopRJ43yJSt6z6zgjne6hgXBcvR8h6c1uqlG8Z/QBhc5e9jFKFj9I
nQUCYnd4HOLIIpNyKXXm/NK46w52MweBlTpEFpkcrGsxDkXYMQ1uQR88hKuuH18d
rfkTHWOsJzAFloIsBkksWNvmrgMescAzzyGAh5H3ory/HFUKKMaw2IaLecg7ir1b
D3vLH/1kX5K6UB2+hhAkJXJN7zc3lKDr2BiAf383WDwvU5WX9o7JiHXyEFk27xxZ
sWgUHMX6YDHnYZEYom6n
=+814
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--
