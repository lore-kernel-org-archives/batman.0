Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 8 Mar 2010 16:15:30 +0100
References: <20100308151244.GA4468@lunn.ch>
In-Reply-To: <20100308151244.GA4468@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2898362.EiUvhDvB1T";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003081615.49579.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] FWD: batman: potential null dereference
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>
Cc: Dan Carpenter <error27@gmail.com>

--nextPart2898362.EiUvhDvB1T
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> Does somebody have time to look at this?
> ----- Forwarded message from Dan Carpenter <error27@gmail.com> -----
[...]
> drivers/staging/batman-adv/routing.c
>     88          } else if ((orig_node->router =3D=3D NULL) && (neigh_node=
 !=3D
>  NULL)) { ^^^^^^^^^^^^^^^^^^^^^^^^^
>     89
>     90                  bat_dbg(DBG_ROUTES,
>     91                          "Adding route towards: %pM (via %pM)\n",
>     92                          orig_node->orig, neigh_node->addr);
>     93                  hna_global_add_orig(orig_node, hna_buff,
>  hna_buff_len); 94
>     95                  /* route changed */
>     96          } else {
>     97                  bat_dbg(DBG_ROUTES, "Changing route towards: %pM
>  (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr,
>  orig_node->router->addr);
>                                    ^^^^^^^^^^^^^^^^^^^^^^^
>     98          }
>=20
> This could fail if debugging is enabled and neigh_node is null.

It looks a little bit like checked with clang's static analyzer. This analy=
zer=20
has problems to track constraints at all. This means that it doesn't catch =
the=20
update_routes constraint "orig_node->router !=3D neigh_node".

But I am also not good at tracking that kind of constraints and reported th=
is=20
or a similar "bug" in batmand a while ago.

So it is not a real bug, but maybe not easy to read.

Best regards,
	Sven

--nextPart2898362.EiUvhDvB1T
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLlRSTAAoJEF2HCgfBJntGw64P/id/syudUOQT1JzG7v7rqBwy
PJzjvFxDbU0e8cUsiOakEPK37XSFAy5dVscMRXA2Qc6d9mKJNRhEKnrKJXYBoj7/
XQstlDrwa3+wt4cD9sH+BaMGCdNuPFt+CM1gK682dvkf9JSyH59/lDKW9LlCIr/q
Ltb+n7avrhei0sZNc9VyfQRQSKwJuMHTF+3LsBAkYnzMg9eH72tN20sXozdqVwOH
3UAKLVMrgRo1iM5iGvARDrPDs5AmCPgN/8NeL/kDGzxw/CEV02d00F/xJQD17pRL
JUWvmgF4erRLZ2n2ZyiLckE87Vl3DGoU4iAZ7aI0A6nqNnEukB1qYdO2MDngpA1p
pIIuEEb2XpQnndwTD0Xebds+5yqetBbs5mN5r1XrMKZZsnjvRq9dZtE6NpLLbOmR
O+mBSFJw3CJeJI1YPvTXTzDaUBREe7coqjQcxhv+vnL0b1fpZgBNrYBgALKYEs/i
3ekkqhuY97iMdCO8tG/REN4lnKaVjlbv3NHtuuj6/Vslohh6/Ra4i+/LJJsuhJ/b
5FxUF4uh6EOS7nduD2Swh+qA3UdEzV+qO/1gaD3AkULDPQ92uDjRrQfMXo0Hvn5g
FxidpN8WTbaCVgcwGy7GFUjaahLbEsOh1dZx+JhdNgwCprPiIJ9+l4+DGOoQq672
l8/QCBqBH4dum2xCaq5+
=xtLm
-----END PGP SIGNATURE-----

--nextPart2898362.EiUvhDvB1T--
