Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 3 May 2010 22:40:20 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100503204020.GA30927@pandem0nium>
References: <201005030828.08856.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <201005030828.08856.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] sysfs compat
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


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

personally i need 2.6.24, and don't care much about 2.6.20, so i would not =
bother
to drop support for this special version - We can however integrate patches=
, i'm
sure someone will look at it if it is a trivial conversion.

Marek, i've tested your patches with all major kernel releases from 2.6.20 =
to=20
2.6.33. What i have seen is:

 * 2.6.20 fails for various reasons
 * 2.6.23 and 2.6.24 show some warnings
 * all other kernel versions are fine

The warnings for 23 and 24 can be fixed by moving the *_read() defines from=
=20
"< 2.6.25" to "< 2.6.23". If you integrate this modification into your patc=
h,=20
you will gain my blessing and my sign-off. :)

best regards,
	Simon

On Mon, May 03, 2010 at 08:28:08AM +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> the current trunk contains some code which breaks our backward compatibil=
ity,=20
> especially the sysfs API seem to be troublesome. I made 2 patches that ad=
dress=20
> the issue on my 2.6.21 test system. It would be nice if you could test th=
em on=20
> your system as well. I'd be particularly interested in kernels older than=
=20
> 2.6.25. Does someone have a 2.6.20 system ?
>=20
> At some point we have to start thinking about how many versions we want t=
o=20
> support. Each new kernel brings more changes which need to be dealt with.=
=20
> Right now, the required effort is still at a sustainable level but the ga=
p is=20
> growing. On one hand it is a nice playground to expand our knowledge abou=
t=20
> macros and demonstrate what nasty things you can do (see the second patch=
 as=20
> an example).  ;-)
> On the other hand it always requires a serious amount of time and effort.=
 It=20
> only makes sense if at least some people are using it. Opinions ?
>=20
> Regards,
> Marek
>=20

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvfNLQACgkQrzg/fFk7axYP7wCfebXJtx3FLspvTHOMelwFuAH8
B6AAoNKXDf01muFCPwNkZNHva0pV4z2b
=dsgE
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
