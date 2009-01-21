Date: Wed, 21 Jan 2009 15:38:14 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090121143814.GA13404@pandem0nium>
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<200901211436.08998.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <200901211436.08998.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Install Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

we also have precompiled binaries for x86:
http://downloads.open-mesh.net/batman/stable/binaries/i386/
http://downloads.open-mesh.net/batman/development/binaries/i386/

another option is to compile/linu batmand with the -static flag on your=20
x86 (i386) desktop and just copy it, as Sven explained. Unfortunately
you won't get an ipkg package with this, but it should run. ;)

best regards
	Simon


On Wed, Jan 21, 2009 at 02:36:03PM +0100, Sven Eckelmann wrote:
> Hi,
> On Wednesday 21 January 2009 13:54:44 Kartik Muralidharan wrote:
> > I have a couple of embedded
> > devices (x86) running the latest version of OpenWRT. I would like to kn=
ow
> > if I could compile and run batman on these nodes and if so how.
> There is a howto written by Wesley at
>  http://downloads.open-mesh.net/batman/misc/batmand_howto.pdf
>=20
> This should describe the process of building and the first steps quite go=
od.=20
> You can compile the batmand binary by using a gcc with i386 as target=20
> plattform. This should be the case for every standard gcc on non-amd64 i3=
68=20
> distributions. Afterwards you can copy it to your embedded device and use=
 it.
> I am not up to date with the current development in trunk of openwrt but =
I=20
> think they don't provide packages for gcc yet. So it will not be possible=
=20
> (unless you installed gcc by hand) to compile it on your device running=
=20
> openwrt.
> This is the really quick and dirty method but you can also create ipkgs w=
ith=20
> the standard openwrt build environment with the build scripts from=20
> https://svn.openwrt.org/openwrt/packages/net/batman/
>=20
> I would recommend that you use a current snapshot of the batman sources f=
rom=20
> trunk because they contain a bunch of fixes since the last release (0.3).=
 You=20
> can obtain them by running
>  svn export http://downloads.open-mesh.net/svn/batman/trunk/batman/
>=20
> Best regards,
> 	Sven

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJdzNWrzg/fFk7axYRAkdkAJ0T3fBRi4Lrozdj4gySb3k23LyvMwCg1u0y
q9/NzD08p4MlXJXDnYC6MCg=
=Xsbh
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
