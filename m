Return-Path: <ordex@autistici.org>
Date: Sun, 7 Apr 2013 17:05:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130407150448.GA5938@ritirata.org>
References: <1364980634-8376-1-git-send-email-ordex@autistici.org>
 <20130403092359.GD14372@ritirata.org>
 <20130407142053.GA5909@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20130407142053.GA5909@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: change VID semantic in the
 BLA code
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
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@open-mesh.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

thanks for reviewing this patch.

On Sun, Apr 07, 2013 at 04:20:53PM +0200, Simon Wunderlich wrote:
> Hey Antonio,
>=20
> On Wed, Apr 03, 2013 at 11:23:59AM +0200, Antonio Quartulli wrote:
> > On Wed, Apr 03, 2013 at 11:17:14AM +0200, Antonio Quartulli wrote:
> > > From: Antonio Quartulli <antonio@open-mesh.com>
> > >=20
> > > In order to make batman-adv fully vlan aware later, the
> > > semantic used for variables storing the VLAN ID values has
> > > to be changed in order to be adapted to the new one which
> > > will be used batman-adv wide.
>=20
> That is for the TT change later I guess? Was confused first, because
> batman-adv is already pretty VLAN aware ... maybe add this as a comment?
>=20

well, the fact that it works does not make it aware, no? :)
Actually batman-adv does not take any action and does not recognise the eve=
nt of
creating a new VLAN on top of it.

But from your comment I realise that "being aware" is probably not the corr=
ect
term. So I will try to improve it.

> > >=20
> > > In particular, the VID has to be an "_unsigned_ short int"
> > > and its 4 MSB will be used as a flag bitfield, while the
> > > remaining 12 bits are used to store the real VID value
> > >=20
> > > Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > [cut..]
> >=20
> > > diff --git a/packet.h b/packet.h
> > > index a51ccfc..d5464f6 100644
> > > --- a/packet.h
> > > +++ b/packet.h
> > > @@ -105,6 +105,14 @@ enum batadv_tt_client_flags {
> > >  	BATADV_TT_CLIENT_PENDING =3D BIT(10),
> > >  };
> > > =20
> > > +/**
> > > + * batadv_vlan_flags - flags for the four MSB of any vlan ID field
> > > + * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag=
 or not
> > > + */
> > > +enum batadv_vlan_flags {
> > > +	BATADV_VLAN_HAS_TAG	=3D BIT(15),
> > > +};
> > > +
>=20
> Please put this into main.h or somewhere else as long as it is not sent o=
ver
> the wire.

Ok. I put it there because I'll be sending it over the wire later. But bett=
er
putting it into main.h for now.

>=20
> > >  /* claim frame types for the bridge loop avoidance */
> > >  enum batadv_bla_claimframe {
> > >  	BATADV_CLAIM_TYPE_CLAIM		=3D 0x00,
> > > diff --git a/soft-interface.c b/soft-interface.c
> > > index 403b8c4..34597a2 100644
> > > --- a/soft-interface.c
> > > +++ b/soft-interface.c
> > > @@ -154,7 +154,7 @@ static int batadv_interface_tx(struct sk_buff *sk=
b,
> > >  						    0x00, 0x00};
> > >  	unsigned int header_len =3D 0;
> > >  	int data_len =3D skb->len, ret;
> > > -	short vid __maybe_unused =3D -1;
> > > +	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
> > >  	bool do_bcast =3D false;
> > >  	uint32_t seqno;
> > >  	unsigned long brd_delay =3D 1;
> > > @@ -303,7 +303,7 @@ void batadv_interface_rx(struct net_device *soft_=
iface,
> > >  	struct ethhdr *ethhdr;
> > >  	struct vlan_ethhdr *vhdr;
> > >  	struct batadv_header *batadv_header =3D (struct batadv_header *)skb=
->data;
> > > -	short vid __maybe_unused =3D -1;
> > > +	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
> > >  	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
> > >  	bool is_bcast;
> >=20
> > I just realised that this change is going to break compatibility becaus=
e we
> > change the menaing of the value that BLA sends over the wire.
> >=20
> > We must postpone this change to the next (BIG) compat bump.
>=20
> Actually no, it just uses the VID internally, so this is not a problem. S=
ee:
> http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-P=
rotocol
>=20
> If there is a VID, it will send the frame in the respective VLAN.
>=20

My bad, I looked at the patch stats and I misinterpreted _my own_ change to
packet.h :)

> The patch looks fine in generally, I have no objections.
>=20

Thanks a lot! I'll send v2.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRYYsgAAoJEADl0hg6qKeOOI4P/i8ym0O/EpQakAqN+ZDNp1K3
E1tZKTEwwrCjDpbYjIfTAWOQWLFBb3lIPYnQqznmEQRTGCb31oH8JwyuKUmuWAkV
OapRb2A0jTSKZ7a2P9FeVIrP5xkkAvyjPDLGwC9/OTTOQYGt3E3MnaY1at1SugUB
LbiafvsKVRXk2j3lwqrwE9CG9mc3z/1jfz3jQqTtxPIZG3Ej9gTM0LhWig+tw4fA
WX926caay6YBVg29emWK8zrN/EJl9ylIbdWIuIMfi+mWaoytdX8tdfmsU78bxcVK
heMzX8KwEumERMLKTrT///Ciftfo8MYFnSwSev6+TIHYIkRaMmNJXcZkQvBdapVs
KX1pNq+ehJKxkoCxO1/v/VP+f+eAaexwnAcXKiQUS2VZ5IjizIdpXc690/IxziY8
qxgKdXbMkUM/erTwpws6VtBp63JUoUiWVrFWbnEhLZuoTzUj85tqF+M5UBP4+I19
OzFbUjzraj8hjEPaXwFlgO+jEHoCpzI3O4P/g2EfAh6msF6PR6/KziGrIahnpRBx
wjnFrE9TEu1bPfhzlFG37esqwqSIJWe5HrJA4Mt2y6N2ddxGYwtwAUopa92kKCOd
I+T31x7fzUsvG+IFJXNIVDYnbkvwz9erFmAL4X70sK5dbQfy/fOFHtE3wHjmR3lQ
DLGjXPt6qWBxCkkULBmh
=JAVl
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
