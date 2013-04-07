Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 7 Apr 2013 16:20:53 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130407142053.GA5909@pandem0nium>
References: <1364980634-8376-1-git-send-email-ordex@autistici.org>
 <20130403092359.GD14372@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20130403092359.GD14372@ritirata.org>
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@open-mesh.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

On Wed, Apr 03, 2013 at 11:23:59AM +0200, Antonio Quartulli wrote:
> On Wed, Apr 03, 2013 at 11:17:14AM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > In order to make batman-adv fully vlan aware later, the
> > semantic used for variables storing the VLAN ID values has
> > to be changed in order to be adapted to the new one which
> > will be used batman-adv wide.

That is for the TT change later I guess? Was confused first, because
batman-adv is already pretty VLAN aware ... maybe add this as a comment?

> >=20
> > In particular, the VID has to be an "_unsigned_ short int"
> > and its 4 MSB will be used as a flag bitfield, while the
> > remaining 12 bits are used to store the real VID value
> >=20
> > Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>=20
> [cut..]
>=20
> > diff --git a/packet.h b/packet.h
> > index a51ccfc..d5464f6 100644
> > --- a/packet.h
> > +++ b/packet.h
> > @@ -105,6 +105,14 @@ enum batadv_tt_client_flags {
> >  	BATADV_TT_CLIENT_PENDING =3D BIT(10),
> >  };
> > =20
> > +/**
> > + * batadv_vlan_flags - flags for the four MSB of any vlan ID field
> > + * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag o=
r not
> > + */
> > +enum batadv_vlan_flags {
> > +	BATADV_VLAN_HAS_TAG	=3D BIT(15),
> > +};
> > +

Please put this into main.h or somewhere else as long as it is not sent over
the wire.

> >  /* claim frame types for the bridge loop avoidance */
> >  enum batadv_bla_claimframe {
> >  	BATADV_CLAIM_TYPE_CLAIM		=3D 0x00,
> > diff --git a/soft-interface.c b/soft-interface.c
> > index 403b8c4..34597a2 100644
> > --- a/soft-interface.c
> > +++ b/soft-interface.c
> > @@ -154,7 +154,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
> >  						    0x00, 0x00};
> >  	unsigned int header_len =3D 0;
> >  	int data_len =3D skb->len, ret;
> > -	short vid __maybe_unused =3D -1;
> > +	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
> >  	bool do_bcast =3D false;
> >  	uint32_t seqno;
> >  	unsigned long brd_delay =3D 1;
> > @@ -303,7 +303,7 @@ void batadv_interface_rx(struct net_device *soft_if=
ace,
> >  	struct ethhdr *ethhdr;
> >  	struct vlan_ethhdr *vhdr;
> >  	struct batadv_header *batadv_header =3D (struct batadv_header *)skb->=
data;
> > -	short vid __maybe_unused =3D -1;
> > +	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
> >  	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
> >  	bool is_bcast;
>=20
> I just realised that this change is going to break compatibility because =
we
> change the menaing of the value that BLA sends over the wire.
>=20
> We must postpone this change to the next (BIG) compat bump.

Actually no, it just uses the VID internally, so this is not a problem. See:
http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-Pro=
tocol

If there is a VID, it will send the frame in the respective VLAN.

The patch looks fine in generally, I have no objections.

Cheers,
	Simon

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlFhgMUACgkQrzg/fFk7axYSbgCeIqraMI/wZ0saL5eCqg+NT+ec
RS0AoIj4X1ED1RhksBYN9TIvdt9J1o8Y
=/yYy
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
