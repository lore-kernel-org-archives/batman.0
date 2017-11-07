Return-Path: <ben@decadent.org.uk>
Message-ID: <1510062155.2748.128.camel@decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 07 Nov 2017 13:42:35 +0000
In-Reply-To: <20171107011651.GB1873@otheros>
References: <lsq.1510009377.526284287@decadent.org.uk>
 <lsq.1510009382.466414456@decadent.org.uk> <20171107011651.GB1873@otheros>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-yuER5UlY//X79ushhkfn"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 3.16 076/294] batman-adv: fix TT sync
 flag inconsistencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, akpm@linux-foundation.org, Antonio Quartulli <a@unstable.cc>, Simon Wunderlich <sw@simonwunderlich.de>


--=-yuER5UlY//X79ushhkfn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-11-07 at 02:16 +0100, Linus L=C3=BCssing wrote:
> Hi Ben!
>=20
> On Mon, Nov 06, 2017 at 11:03:02PM +0000, Ben Hutchings wrote:
> > 3.16.50-rc1 review patch.  If anyone has any objections, please let
> > me know.
> >=20
> > ------------------
> >=20
> > From: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> >=20
> > commit 54e22f265e872ae140755b3318521d400a094605 upstream.
>=20
> [...]
> > [bwh: Backported to 3.16:
> >  - Drop changes to batadv_tt_global_dump_subentry()
>=20
> May I ask, were there specific concerns for stable 3.16 kernel
> releases with this change?
>
> It's not bothering me, but I'm currently wondering whether
> this could cause some confusion to users.

That function didn't exist in 3.16 (at least not under that name).

Ben.

--=20
Ben Hutchings
It is impossible to make anything foolproof because fools are so
ingenious.


--=-yuER5UlY//X79ushhkfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAloBuEsACgkQ57/I7JWG
EQmTQw//Wd0lMW3PNsE4lU2XiRidWTQvgCi5DOuFKgt94I1ln3rOm/8ou2r/jFQS
A0Y+UWzZw5juMOR8CWOlVxp+73Feq3Cw0VL7Zn+NCKuGnyCnRUIhQC2Hvw07KBNn
0uZhH4TuZqJg5H3vw93U/urbnHxGU6WW3NdDEF7JmMqiqOOSR9FVev6o624qLN0Q
8LsGybSOU/vbmRUxbkxYYByaWZBb9BkvgdxX5FxPqsQBWFHvHol6T8FXwIJ6YGTT
tPt52bMatHT5BcypUKD7bDg28m58JuG17gu774/y34r/Agh7lxfI35hv3jbEzLAR
yHRrwrgUDJZGHUAqeNN7IYE3HyyIJUcZlu5Ey76QUPqElUus1O3X+xEQW9rWUKRf
eRzuHBapyOWh7bI3fjv14zhUY2fXn+0fJw9YbdswXTIAeJXpjeHT9vaNB+cfWPLM
GAAplaClCGJS3o5tKOP2l1IR2QXV513lrX0+tLjvrXMV8+ayZzdW/A/LtnDcNkIl
nhi909opgSv90aH+83mZn4ak8FlwGZaL8N1WK6PpO2ibQP3jH3XNajS97XeCuJ4f
1S0VYRZIyP/ZAXoSHZzrRpP0lOPhZnFhNLvrv0pq0F+LSv4PybKyzOQNebf55jgP
4Q7FMNWJB+W6vT78ANA24Rf+GP9BmE/pgfrDWfLGKxxGpA08zik=
=1+04
-----END PGP SIGNATURE-----

--=-yuER5UlY//X79ushhkfn--
