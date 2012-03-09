Return-Path: <ordex@autistici.org>
Date: Fri, 9 Mar 2012 13:39:06 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120309123905.GB436@ritirata.org>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20120309120455.GF15059@kerneis.info>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 01:04:55PM +0100, Gabriel Kerneis wrote:
> On Fri, Mar 09, 2012 at 07:26:54PM +0800, Marek Lindner wrote:
> > The concept of a primary interface goes back into the early days of bat=
man and=20
> > primarily is an optimization to reduce overhead. At some point we reali=
zed=20
> > that it is not necessary to flood the mesh with OGMs from each and ever=
y=20
> > interface we have. Nearby nodes might want to know about all interfaces=
 to=20
> > select the best one. Nodes that are far away don't care which interface=
 is=20
> > connected to what other interface. They only care about a route to thei=
r=20
> > destination. This concept is briefly explained here[1] (section 2.1.6 a=
nd=20
> > 2.1.7).
>=20
> Thanks for the pointer.
>=20
> Does that mean that it is impossible to announce a route on some interfac=
es
> only?  It looks like a rather arbitrary limitation.

OGMs are broadcasted over all the interfaces (there may be some neighs reac=
hable
only by one interface) and you can't force an OGM to be broadcasted only ov=
er
one of them. I hope I correctly got your question.

>=20
> In case I misunderstood and it is actually possible, I fail to see =C4=A5=
ow the
> alternating algorithm takes this into account: it seems to assume that a =
node
> will accept to route any packet on any interface.  Did I miss something?
>=20

Packets are alternatively routed on all the "possible" interfaces (a neighb=
or could be
connected only to a subset of them) until the metric on that interface is
acceptable. I hope I correctly got your question again.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPWfnpAAoJEFMQTLzJFOZFdX8IAJyFcIc6QA1RIiQb4kspWaWS
EO8jW19hlOk4YTbgCjyS86ERIPah3PgnrmOgw65E4WUEecEl1SR26SORvAnhclza
DUfr5rwoFpQzNnJLM6SdJS6bU1Gj8vtVnGwhqigY8WSXEa4svqKHuDWEpWHpJooN
2LOdzf4g4PHm+2NoYV/xJvGDHf0a6jLTOib2ob3mkSuYlDBYbghN9o60A0w4M9+6
TNGu5w9czmwp7Bt3yBSy7K7vs5MRh3orJ93OXe+xmwCm4Grjia+NbLLxF9jMm53Y
o3Jkkju9yssIKdC2CZI8+/vij/TaNLwUCoI1G5RuYXJGgUVnFpNMHyKXt4bAUpI=
=HeLH
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
