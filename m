Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 5 May 2011 19:35:11 +0200
References: <BANLkTikaMjY9t=0gDQCn0xUzz+c4YPz7gQ@mail.gmail.com>
	<201105051744.40330.lindner_marek@yahoo.de>
	<BANLkTin0ge+SNpLr3wjTibT303PZ8SRbGw@mail.gmail.com>
In-Reply-To: <BANLkTin0ge+SNpLr3wjTibT303PZ8SRbGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9322777.24poj6uXVg";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105051935.12979.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Routing decisions
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

--nextPart9322777.24poj6uXVg
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ed Okerson wrote:
> On Thu, May 5, 2011 at 10:44 AM, Marek Lindner <lindner_marek@yahoo.de>=20
wrote:
> > Hi,
> >=20
> >> We are evaluating using Batman in an environment where there could be
> >> 200-300 devices in a single building.  We started out setting up 10
> >> devices in our office to figure out how everything works and do some
> >> throughput testing.  We have noticed that the routing decisions always
> >> send the packet to the node towards the destination with the highest
> >> signal strength.  This causes the packet to always traverse the
> >> network with the maximum possible number of hops, which causes
> >> performance to degrade quickly.  Is it possible to use a different
> >> routing algorithm?  It would seem that sending to the node closest to
> >> the destination that the source node can still communicate with
> >> directly would minimize the number of hops.
> >=20
> > if you wish to minimize the number of hops you have to increase the hop
> > penalty. Check the "hop penalty" section here:
> > http://www.open-mesh.org/wiki/batman-adv/Tweaking
>=20
> That seems to indicate that it is a per node setting, i.e. "using this
> node will incur a penalty of x".  That is also not the desired
> behavior.  For our installation all nodes are in a fixed location, so
> using a particular node as a next hop in the route may incur a penalty
> for one source node, but not another.  This should be dynamically
> determined for each route from each source to each destination to
> minimize hops.

So you have to increase the hop penalty everywhere to force the routing=20
algorithm to reduce the number of hops and prefer worse routes with less ho=
ps.

Kind regards,
	Sven

--nextPart9322777.24poj6uXVg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNwt/PAAoJEF2HCgfBJntG2s8P/0MdhQNhTennQH12LTBdUcqj
TJsJZ/t3L5ovYvEJ9EcmukttqNlVHYT0eyEtRgDMx+8f6RdT+V9VBDT8YRN7VpF0
l0fVEuXzd6nC+2zFDzlY5BerJqHMBH0iek7UzCfe05t1getsSxKD6sPawGrWjSgp
aAJ7W2IDkY8MIt/Ysh4SMl49pTs/O9FIhYrxzsoQ6nkTzJkLHfQ+0SxfUpPiYuYt
uZ/GMRyl2+KICqzgEZMwrVVe39xss5tbtED6mxb0dIGtJV7i0Daxk5fotDNcjkw7
j4jAsOaWSaZVnEV0FVy8vDWKassXXZsSZeS2PKod4KfKpcZX6GaG+V4Cn1yUgDAB
K8GCJN00VaLSRa8Q8C2HU/hYGkYZIto48LXMT+fF5E/ydqXdd00Mx1SqqB59DhbP
7wiun8Zyi4banFNiqQ9dTJG068Lh7PZRRIXNeR3Ap3GtFjSO+TUdZ3Y0GQwZNwA4
cXNd9ejskpAch3YhCbUzRrKdCpP2e/pR/fKNf5DBkXrGB9WXACy6Z/LjCnBGUVrW
jd2F8UgzvGXcU7wiL8P06Bt+xx6M0yQg1QeVZqVAVntVhaeIjkOyhMbxKzk7d1vQ
9eb/Uzx6Pdi+pd9QeV71dqezRzosG7SVk39Mg72ldY+ru//1mkf5Xl6k/vrDrR/n
b6vlh+506jWkrmH/+HJ+
=8dZl
-----END PGP SIGNATURE-----

--nextPart9322777.24poj6uXVg--
