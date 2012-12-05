Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 5 Dec 2012 14:12:21 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121205131221.GA29818@pandem0nium>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch> <6578542.D9nnFXgRvc@bentobox>
 <20121205113927.GF26922@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20121205113927.GF26922@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

just a few comments:

On Wed, Dec 05, 2012 at 12:39:27PM +0100, Andrew Lunn wrote:
> > The biggest different is the "lets install a whole kernel to test this =
change"=20
> > methodology ;)
>=20
> Yes, i generally do that, test a whole kernel, not a module. But...
>=20
> > Usually (please correct me) batman-adv is developed outside the kernel =
because=20
> > it is easier to test stuff and it worked till now. No one of us wants t=
o port=20
> > the latest OpenWrt to the -rc kernel to test stuff ;)
>=20
> Do you actually need to port to OpenWrt?

Most people I know using batman-adv use either OpenWRT based routers, some =
others
"normal" (or stripped down versions of) distributions like Debian. So yes, =
this
is probably the biggest user base (from my point of view, at least, no surv=
eys
done yet).

>=20
> How i work is build a kernel, with everything i need built in. No
> modules. Then tftpboot the kernel, and use the rootfs from the
> disk. Why not do the same with OpenWrt?

OpenWRT has many other non-batman-related patches (platform paches, wifi pa=
tches,
=2E..), and upgrading the kernel is a major hassle - you'd need to adapt/po=
rt lots
of these patches, and some of them are not as nice as we are used from our =
Linux
git repos. :)

We try to keep repositories up to date for our OpenWRT users, but this shou=
ldn't
make us or them update the kernel all the time. BTW, OpenWRT also uses comp=
at-wireless
for wifi with custom patches, this is how they keep at the "bleeding edge".=
 If we
change to this style, we would probably have to follow the same pattern.

Cheers,
	Simon

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlC/SDUACgkQrzg/fFk7axY0XgCffFeAK7/cClhY2KmX32JG5y57
tmwAoOkEJU/r/eGNIcI4x9sYLtOcZQ1/
=LJkb
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
