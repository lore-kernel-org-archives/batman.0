Return-Path: <ordex@autistici.org>
Date: Tue, 4 Jun 2013 07:38:41 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130604053841.GK1226@ritirata.org>
References: <51A3C7E9.7080208@inti.gob.ar> <20130528070057.GC3333@ritirata.org>
 <51ACBCE4.8000506@inti.gob.ar> <20130603160813.GC1226@ritirata.org>
 <51AD0277.1060907@inti.gob.ar> <20130604051326.GJ1226@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline
In-Reply-To: <20130604051326.GJ1226@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: Gabriel =?utf-8?B?VG9sw7Nu?= <gtolon@inti.gob.ar>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2013 at 07:13:26AM +0200, Antonio Quartulli wrote:
> On Mon, Jun 03, 2013 at 05:54:15PM -0300, Gabriel Tol=C3=B3n wrote:
> > So, in menuconfig I should select that id for batman-adv-devel right? I=
=20
> > wanted to see that  commit on the git page using the search field but I=
=20
> > couldn't. By the way, how to know which batctl version use with each=20
> > batman-adv-devel commit? Sorry if all these questions are too basic, bu=
t=20
> > I've tried to compile with this d672369 version and I got some errors,=
=20
> > so I'd like to understand if it was related to these things.
>=20
> no problems. These are not basic questions :) Actually the user usually d=
o not
> enter these dev details and therefore it is normal to find issues.
>=20
> For batctl, you should use the last commit ID in this branch (ordex/bw_me=
ter)
> http://git.open-mesh.org/batctl.git/shortlog/refs/heads/ordex/bw_meter
>=20
> >=20
> > >
> > >
> > > By the way, your iperf tests have been done on top of batman-adv? or =
directly on
> > > the wifi interface?
> > >
> > > Cheers,
> > >
> >=20
> > I got the results mentioned using interfaces managed by batman-adv.
>=20
> mh...maybe the pign is not working because of some changes brought by the
> bw_meter in the icmp packets. I'll check and I'll let you know.

I juested the current ordex/bw_meter branches (batctl and batman-adv) and t=
he
ping works fine.

Please, let me know your results.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRrX1hAAoJEADl0hg6qKeOpfUP/2mj3UT8eILkEecEv4ZfQQ+1
Av1MutcnUd3OOI6CCVJir4fOu14JZqaG0AFf7vz3iF4yFVdULixeCWRn2XigIiIR
Zq+5XSR7U5XY1YEFbPo3C256mItzNJhMkpgz1f0V5bKM+gIB/NhBFVp5p008Dvbs
WFP9HO88pdoY1rNPMhpsjCVKeZSkPjBnzo/jQrnXAexVHBbaeSXXn9RaE9pP6vER
uA7OygyU/JdDKcQ/7n9PJ5IU2xKNM72F3ce1Zwbpn09f0nS4wB6/C91Ld1QcmTYI
Wro3yGzou0o5Y3hWtTcLP7linqtCbEiUUUIgg8UsdNoVgb9QcrVEyWysq2GDAJtM
w8HcueW/KgXs9wYSS0B2VkJP5qTJB8psfl8KiJJ+cQPh6M+zKlwTKJ6pdClPle1o
sC6VWfTOZJ9hniNqnBKd73DABdkUBtBlzj05tpkbGAaWiLplToiOmyMoUNrhTPff
VfUUP8FcHJM1fXvk0DL8As6Mim+uZAghvVneUn+EZcROfewH5PASMOesaIYrmpso
kZaj4S1u0jxksFTMzQwKml2xW48QtowQpyKm/nPzlLSbMXq1mfoPXw112yT5hGQE
sWSdCc8Wypv7mLT5QieVWr0JB7R9zXvPl2kUbnCmo007r5NQ0R1Qp97AzbAfw+Rk
KS6GpZtz16EwisNGCALg
=BwGK
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
