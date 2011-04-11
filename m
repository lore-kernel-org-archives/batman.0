Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Apr 2011 08:50:51 +0200
References: <alpine.DEB.2.00.1104102257050.17976@drawesome>
In-Reply-To: <alpine.DEB.2.00.1104102257050.17976@drawesome>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1390151.7AEMkSxNcn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104110851.55819.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] batman-adv coexisting with olsr?
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1390151.7AEMkSxNcn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 11 April 2011 05:01:27 Ryan Hughes wrote:
> Hi.  Is it possible to get batman-adv to coexist with olsr, working with
> different network prefixes?
>=20
> Cuz it seems to me that the olsr traffic would all get routed by batman,
> and every node would think it could see every other node, and olsr would
> add all kinds of nonsense to the routing table.

batman-adv provides a virtual layer 2 switch which can be used through a=20
virtual interface and olsr provides an ip routing table. So you can just st=
art=20
olsr using an interface which is _not_ the virtual batman-adv (aka bat0)=20
interface.

This was explained a year ago during the Wireless Community Weekend 2010 [1=
].=20
Maybe you can find somewhere an example firmware which was made after that=
=20
discussion.

Kind regards,
	Sven

[1] http://wiki.freifunk.net/Wireless_Community_Weekend_2010

--nextPart1390151.7AEMkSxNcn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNoqUJAAoJEF2HCgfBJntGtJwP/2NWL2GCB+IkC1txwTGafK75
WiljXPBeI8TwC94ggTqx0ezunueWto7IHajZ2+veeJ7GgYWez9FxJhmmKqe+jlxX
Igh0xEAvRTrRqSxgVZqh1Tm8vUhN7unvrvnpxR9KUVu8Jnv2BkNYlgIHHBHZhsRe
4XaLZ2BIw1IcwuhI1hYZeWbWF+hLbVZFe2SOBYYpu29mcgXE6HvEJFwIcKjDyRFn
9WNcDRCcUz/o9SID1YuYhsmRPLZvMnZnnGBsJTIULZuHbEu9NPMHECbUQTBqXWTr
aU/7Sn3NAAdwBYln4viNXEW2m1L5+vU/p4/eaGzyutWL+NW7Ghk4/hHILW/U0IdZ
ZR7NDiWJHpmq7Kg0q3UNh3FHrqDd8KjhRkTBrIH2PbeRE4t7/TX5CbLHOzq7zyvS
nIMKmypPXwjn+2Cdb0EmvHou5AaszN1IznSXclxVPJRutgBJWtHbYphuHdKFMYn3
0qBz40But7ssdzQXFr4pDJSgvQX603L8DfUHV/4x1tLsSqSSIy/IDgOonbHuevuM
VA9gfZIGvIY/QLYTFgEN6GqVMFD4qgcEvzzeCYtZ8xwD7LGYaJyLK3S/W4+/EJJ/
Mg2rkFn1e5MSQFWp1vNYGMWFGLuskSV57iheINHJfU5kyz4+nyfLXrd87fEMAkGU
B1uXJoWq+XRK+35NpaGn
=kdXW
-----END PGP SIGNATURE-----

--nextPart1390151.7AEMkSxNcn--
