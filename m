Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 5 May 2011 20:26:41 +0200
References: <BANLkTikaMjY9t=0gDQCn0xUzz+c4YPz7gQ@mail.gmail.com>
	<201105051935.12979.sven@narfation.org>
	<BANLkTikO=kA3JVfACWmnyV3QhDksGhQL8Q@mail.gmail.com>
In-Reply-To: <BANLkTikO=kA3JVfACWmnyV3QhDksGhQL8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1474908.x8f2loUKKS";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105052026.42719.sven@narfation.org>
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
To: Ed Okerson <ed.okerson@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1474908.x8f2loUKKS
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ed Okerson wrote:
> On Thu, May 5, 2011 at 12:35 PM, Sven Eckelmann <sven@narfation.org> wrot=
e:
> > Ed Okerson wrote:
> >> On Thu, May 5, 2011 at 10:44 AM, Marek Lindner <lindner_marek@yahoo.de>
> >=20
> > wrote:
> >> > Hi,
> >> >=20
> >> >> We are evaluating using Batman in an environment where there could =
be
> >> >> 200-300 devices in a single building.  We started out setting up 10
> >> >> devices in our office to figure out how everything works and do some
> >> >> throughput testing.  We have noticed that the routing decisions
> >> >> always send the packet to the node towards the destination with the
> >> >> highest signal strength.  This causes the packet to always traverse
> >> >> the network with the maximum possible number of hops, which causes
> >> >> performance to degrade quickly.  Is it possible to use a different
> >> >> routing algorithm?  It would seem that sending to the node closest
> >> >> to the destination that the source node can still communicate with
> >> >> directly would minimize the number of hops.
> >> >=20
> >> > if you wish to minimize the number of hops you have to increase the
> >> > hop penalty. Check the "hop penalty" section here:
> >> > http://www.open-mesh.org/wiki/batman-adv/Tweaking
> >>=20
> >> That seems to indicate that it is a per node setting, i.e. "using this
> >> node will incur a penalty of x".  That is also not the desired
> >> behavior.  For our installation all nodes are in a fixed location, so
> >> using a particular node as a next hop in the route may incur a penalty
> >> for one source node, but not another.  This should be dynamically
> >> determined for each route from each source to each destination to
> >> minimize hops.
> >=20
> > So you have to increase the hop penalty everywhere to force the routing
> > algorithm to reduce the number of hops and prefer worse routes with less
> > hops.
>=20
> If I increase the hop penalty on all nodes, they will all still be
> equal.  If all nodes have a hop penalty of 128, will it not make the
> same routing decisions as it does if they are all 10?

No, the wiki explains it quite well, but I'll try to explain it a little bi=
t=20
different. Lets assume that you have perfect links (quality =3D 255) betwee=
n all=20
nodes in a route. Each one would say: "hey, I can reach the following=20
neighbors with the quality of 255".... now introduce a penalty in each hop =
(10=20
for example) which is just substracted from the incoming value. So after a=
=20
distance of 5 hops only a quality of 205 would be announced. Therefore a no=
de=20
with only a distance of 2 (quality =3D 235) would be prefered as next hop i=
n=20
this case and not the one with the distance of 5.

Target - X1 - X2 - X3 - X4 - X5 - (Announces route with quality 205 to Targ=
et)
      \
       \ Y1 - Y2 - (Announces route with quality 235 to Target)

This is a quite abstract and not 100% correct explanation of the hop penalt=
y,=20
but should help to understand the implications a little bit better. You hav=
e=20
to do the calculations yourself to find a good value for hop penalty.

You should have a look at send.c to find more information about it. You sho=
uld=20
see that it is not really substracted in a linear fashion and that the actu=
al=20
quality is calculation is also more complex,... but the idea is similar to =
the=20
example mentioned before.

Kind regards,
	Sven

--nextPart1474908.x8f2loUKKS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNwuvhAAoJEF2HCgfBJntG0JQP/RfdEvbhKs+R97vdY3qeBX0m
QOZqm9dLr9bWOXGalK4oq8BTAiChwlxKy8oKFtSaDLOyCfukGOpms7MZBuO4/7jF
AfWzMN/egde1XMj+rlIJ6j0mc19Aa9kCkfBBYFosbR9sFOVKKr6JM+Q9bZ0yWNVa
b6yrKmeUGNC5poKEFsVdXl4zNh4r2sWEvKJKdWgHmBRD40MZdzHKmEMhkTdKD4qg
t6GnuXe6XQLvxXfJFFFvu3e6uveI37eR/u8jG/qnSY1vZf8rj9UdRS46jVEuArN5
7kHnm9zZbfr62SjC6kuyH9s3aGxgVPu2lAEwhQtW+SYJFNZSyXSQ91D2n4mFAMb1
B0lI2lqNvzf61TXJ0uKuyNCCs0JdiYJT7kvLhfd2YKInI57NNyU0awPencM7YpD7
EL0Rk05bMZZOkXYDIyChTKqN+JWbxlX0XwO3RlsVhY+bnZtyiHahlMrWR8eYeqs5
zfCeNIcSTXUUwjxD8qSMjsCG6GHtUTIPY7NNU+nXhuCRXDeFwlVm21xMGsO5Xw7m
B4bZQGYYuTeyo5BlQws4O5NPUk2yv8QlqbGR5M7WrWncbiXxetOsSaqfRoLe32Il
xEY+jI+iMdjzk/qFQnEqdwdT5MgkegUfIm/Iae+X4WKT/jc79ro0EQi+eS8F0WgG
/yFs4hJsA8ZDGpTBl/TW
=XxDn
-----END PGP SIGNATURE-----

--nextPart1474908.x8f2loUKKS--
