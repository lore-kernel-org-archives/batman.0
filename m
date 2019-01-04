Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Jan 2019 08:44:38 +0100
Message-ID: <2492575.sfqEKcoiOs@sven-edge>
In-Reply-To: <20190104015726.GG21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-15-sven@narfation.org> <20190104015726.GG21623@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3292708.no659Z6khT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 14/19] batman-adv: Add multicast_mode
 mesh genl configuration
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Jiri Pirko <jiri@mellanox.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3292708.no659Z6khT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 4 January 2019 02.57.26 CET Linus L=FCssing wrote:
> On Fri, Dec 07, 2018 at 02:58:41PM +0100, Sven Eckelmann wrote:
> > diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> > index 8e3a1b6e..32762003 100644
> > --- a/net/batman-adv/netlink.c
> > +++ b/net/batman-adv/netlink.c
> > @@ -155,6 +155,7 @@ static const struct nla_policy batadv_netlink_polic=
y[NUM_BATADV_ATTR] =3D {
> >  	[BATADV_ATTR_GW_SEL_CLASS]		=3D { .type =3D NLA_U32 },
> >  	[BATADV_ATTR_HOP_PENALTY]		=3D { .type =3D NLA_U8 },
> >  	[BATADV_ATTR_LOG_LEVEL]			=3D { .type =3D NLA_U32 },
> > +	[BATADV_ATTR_MULTICAST_MODE]		=3D { .type =3D NLA_U8 },
> >  };
>=20
> Since the name is more generic than just a flag, would it make
> sense to make this a U32, just to stay flexible for the future?
>=20
> (I don't have any specific ideas or plans to use more
> values for it right now, though)

Please discuss this with Jiro because he told us to use u8.

Kind regards,
	Sven


--nextPart3292708.no659Z6khT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwvDuYACgkQXYcKB8Em
e0ZadA/+IlRriAgFfP2po18F/p4knkA+EchytGz0R5nUt8RKLS+JVNAItWPmutRB
7f0PG2JaKSORTqhsSNkiTeXWoid/Db9ROe4e1BfjGdjAHuohVgY5w3UkRA6Qtk+n
WlpNv6vuGvDYBhuWIf00j7t9bfBcN/JsQtNXJdmi2vnrCJ+FiCEu/yADs6UJ2IRp
AeJOQpKbzO/UtDIOztUjnJm99IYRj7/ruGkjTZu71SFSXKKT664/c3jKxrHO/fcT
fnxs1fpKFPu/fkKaiqzhSHn4es8LFeAVQQ/fjVs3h9UPLPfiVGGDSVheclvVyUtD
cpj6dHQ/IzcgT77yqmpt9R/vWUvToJUTIs1IzvgKv9KCUgUyy+6i6RR/YR3VNaMr
whYbMl23ffO3EKPJOPtJvBzJefsDrG7XO7t6Lipx76ShHqWso6SlPznLGZfiR++v
p9lK+GuoA0EEQ9dhv8GOseYnk5bMSpQUJqNWHaG76oKoXnyjksm16iDit57AugsS
ZsJDHdMQFJq9wzrNrDExO/xRUJ9FAunhuQExm38GELceLDcBOEEyHx8dEwb8EBdz
kTQ2z0+9Z9aAo8zvDY18U/PDtOcuaDR5bCoz68R6BLra3C2hQT/VQ+jmmCGDlave
xHvRGuRdqsnEHYaYw2l2zUPE5bu8AuGHGg6G1lHLNFRHTDlJr9Y=
=/Ty6
-----END PGP SIGNATURE-----

--nextPart3292708.no659Z6khT--



