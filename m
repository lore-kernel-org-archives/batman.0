Return-Path: <ordex@autistici.org>
Date: Fri, 9 Mar 2012 14:03:01 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120309130300.GC436@ritirata.org>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>
	<20120309123905.GB436@ritirata.org>
	<20120309125741.GJ15059@kerneis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20120309125741.GJ15059@kerneis.info>
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


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 01:57:41PM +0100, Gabriel Kerneis wrote:
> Antonio,
>=20
> On Fri, Mar 09, 2012 at 01:39:06PM +0100, Antonio Quartulli wrote:
> > > Does that mean that it is impossible to announce a route on some inte=
rfaces
> > > only?  It looks like a rather arbitrary limitation.
> >=20
> > OGMs are broadcasted over all the interfaces (there may be some neighs =
reachable
> > only by one interface) and you can't force an OGM to be broadcasted onl=
y over
> > one of them. I hope I correctly got your question.
>=20
> My question is about some kind of policy routing (setup by the administra=
tor,
> not guessed by batman).
>=20
> Consider the following topology:
>=20
>=20
>        l0     l1
>     A ---- B =3D=3D=3D=3D C
>               l2
>=20
> where --- is a single link (l0) and =3D=3D=3D are two links (l1 and l2).
>=20
> Now imagine that the administator wants to dedicate the link l2 to the
> communication between B=C2=A0and C, for whatever reason.  It is fairly ea=
sy to set
> netfilter rules to that effect, for instance.

Thanks for the exhaustive explanation.

>=20
> 1) Is it possible for the administrator of B to configure batman so that =
it
>    announces a route to A=C2=A0only over l1, and not l2?  Such that C wil=
l only ever
>    send packets for A over l1, and B never replies on l2 either.
>=20

No, it is not possible. No filtering/manual selection is possible in batman=
-adv,
right now.

>    It looks like both l1 and l2 will end up as bonding alternates for C.

Yes.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPWf+EAAoJEFMQTLzJFOZFbKsIAIfVcOti+o8arY/dffl6W7wk
D9He8mWFzIDq7mU1uCovL8nbBBBHGj1XYghPN24Qo661QMlgjBo4efAcN1r9j3eb
KfCInnkFmKrQhXTsbxV7VtjeO4xMGpeLS/x6R4+7xsaENdMfzVMN66CuumAkBlKG
DeRdORfb+9VVuwJB7q7+Y2dDrLjpMFCb/hW1hGBOvuJuXjK1pNyVCmc5Se1WRJYE
CcrEk7Aq7zwpPbAAbgDJrpf5NXF4mc1+yKZe36Uqyh1+yPEsR1NLelFQvK8NQRsw
l+j/jqCMRicWBhIjaccKVuJ9vhutaXJtWHj5Oidda0Px6EPyaz/9MfNaSqNttbA=
=lo62
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
