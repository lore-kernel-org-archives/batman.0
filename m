Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 20 Jul 2013 15:24:27 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130720132427.GA16255@pandem0nium>
References: <20130519105034.GB16497@pandem0nium>
 <51EA08D1.7010807@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <51EA08D1.7010807@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Alfred Open Beta
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
To: Gui Iribarren <gui@altermundi.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guido,

On Sat, Jul 20, 2013 at 12:49:37AM -0300, Gui Iribarren wrote:
> On 05/19/2013 07:50 AM, Simon Wunderlich wrote:
> >To those of you who actively follow the recent discussions it may come t=
o no
> >big surprise that it was decided to remove the vis functionality from the
> >batman-adv kernel module in a not so distant future (with the next
> >compatibility bump). There always has been a debate whether or not such
> >functionality belongs into the kernel or not. The in-kernel solution bea=
rs the
> >disadvantage of being rather inflexible because every change has to go t=
hrough
> >the official Linux channels. With the growing interest in flooding the n=
etwork
> >with arbitrary data in addition to the visualization data realizing a so=
lution
> >in user-space became the obvious choice.
> >
> >A new, more general user-space daemon which takes over the old vis
> >functionality and much more, called A.L.F.R.E.D. (Almighty Lightweight F=
act
> >Remote Exchange Daemon) came to life. Alfred is capable of distributing
> >information over your mesh network in a decentralized fashion, for examp=
le
> >graph information for vis, but also any other data which appears to be u=
seful
> >- like hostnames, phone books, administration information, DNS informati=
on,
> >the local weather forecast, etc while requiring (almost) zero configurat=
ion.
> >
> >As the development on the core functionality has been finished and alfre=
d works
> >(at least on the developers boxes), we would like to call for an open be=
ta!
> >There are bleeding edge downloads and an OpenWRT feed available [1]. Ple=
ase
> >try alfred and report bugs, send patches and inform us about your experi=
ences.
>=20
> Cheerful Simon,
> finally, i have just taken the time to test alfred, and it looks
> pretty good, binary cli is dead simple to use, thanks a lot!!
>=20
> http://chef.mesh.altermundi.net/downloads/r36139/ar71xx/packages/alfred_2=
012.0.0-5_ar71xx.ipk

Thanks a lot for testing and reporting back!
>=20
> i'll take a stab at making a bat-hosts generator (are there any
> published efforts along these lines already?), but first i gave a
> quick look into current vis generator, and i observed some glitches
>=20
> * where does this 00:00:00:00:00:00 mac come from?
> * double interfaces don't seem to be properly detected or something
>=20

Yeah, that is indeed a glitch. There was a bug that only the first interface
MAC was filled correctly, and other interfaces were just reported as
00:00:00:00:00:00. This should be fixed upstream and in the openwrt package
(release 6), please give it a try!

The double interfaces issue should be fixed with that too, I hope. :)

Cheers,
	Simon

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlHqj4sACgkQrzg/fFk7axZ79QCgrJnnCN6U9HMI3i3gl8Y55z8R
LrcAoM+wsL7taFtBSPW4ty0dv4lChcTJ
=jbsc
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
