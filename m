Return-Path: <ordex@autistici.org>
Date: Tue, 23 Apr 2013 22:04:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130423200434.GC16603@ritirata.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-3-git-send-email-ordex@autistici.org>
 <201304240358.56353.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <201304240358.56353.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: use vid when computing
 local and global TT CRC
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


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 03:58:56AM +0800, Marek Lindner wrote:
> On Tuesday, April 23, 2013 22:34:30 Antonio Quartulli wrote:
> > @@ -1535,7 +1535,9 @@ static uint32_t batadv_tt_global_crc(struct
> > batadv_priv *bat_priv, orig_node)) continue;
> > =20
> > -                       crc ^=3D crc32c(0, tt_common->addr, ETH_ALEN);
> > +                       crc_tmp =3D crc32c(0, &tt_common->vid,
> > +                                        sizeof(tt_common->vid));
> > +                       crc ^=3D crc32c(crc_tmp, tt_common->addr, ETH_A=
LEN);
> >                 }
> >                 rcu_read_unlock();
>=20
> Is it necessary to define another variable ?=20

yes

> Why not:
>=20
> crc =3D crc32c(0, &tt_common->vid, sizeof(tt_common->vid));
> crc ^=3D crc32c(crc, tt_common->addr, ETH_ALEN);
>=20

because crc_tmp is the result of the CRC operation on the VID and the MAC
address (so one per client), while crc is the container of all the crc_tmp
xor'ed together..

>=20
> > @@ -1565,7 +1567,9 @@ static uint32_t batadv_tt_local_crc(struct batadv=
_priv=20
> *bat_priv)
> >                         if (tt_common->flags & BATADV_TT_CLIENT_NEW)
> >                                 continue;
> > =20
> > -                       crc ^=3D crc32c(0, tt_common->addr, ETH_ALEN);
> > +                       crc_tmp =3D crc32c(0, &tt_common->vid,
> > +                                        sizeof(tt_common->vid));
> > +                       crc ^=3D crc32c(crc_tmp, tt_common->addr, ETH_A=
LEN);
> >                 }
>=20
> Dito.

Idem.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRdulSAAoJEADl0hg6qKeO26UP+QFZuuA3kSucJMcg0vgljfJx
gyyFQFsoRptfOcGC/oWY7b1Uv6W/9IIPBKlKlVcZlFwq6x+rb1lJfhHJV7WMl7tZ
HJXkyVSmZuNIUbki7tt6luh7qdWbG0HVIOOrGKsWwAHwxm1OBJe8x1n4+Y3X5vpr
Af90xUiv7vj228d7TfYVJ4m/Sxq/6w//qViPp92VMMHHa53EMBnUYvFbNIAFFGwc
ICqmNsJYrfAFOjYDFu3Nwl+zlwljgM+36Tb6L3oW5X13lEWiBsAA4UXK+Dr3iEL8
eyT1y1k1zdnnGsrzARxik0HiP2hz3NkqXohoWCpvaJGygNdgxDJlztGipDXX/Ajf
DKw8l5nqMc4n2yDfJeQ1UA70VbV0qV5x2k80XVK4Y9Xtu2sE2BWW8WuvQK5Pl100
D8WfRAGjhnF0YHeu7XmQQ/hgz+T6XviNvBXCF3+6pYxwwTBId4GUHz3heXcQRtMg
sczBIPP8NqAL4kW/GckdsX1FlgR4FyUGNiJGmwHJF80pHUhsOQq9/soDEQcmMpau
+PA+M62JFKxzJThaDogStZLrSVUJv1GegPC69sBO7qBPefk8uqb2uZmZue3+4QFg
yS7fk8SdHfxPNPOXjXscWl0E758hAGJ5cKrUdezj1ytn3gPbKOP8I2rgIcvwPWF8
mM6czzSed96HrIUBQE4Q
=Jyiv
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
