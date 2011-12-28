Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 28 Dec 2011 03:07:38 +0100
Message-ID: <8282963.hUDWkDfD11@sven-laptop.home.narfation.org>
In-Reply-To: <201112272327.59110.clemens-john@gmx.de>
References: <201112252236.22377.clemens-john@gmx.de>
	<201112272306.40661.clemens-john@gmx.de>
	<201112272327.59110.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8080976.GUIdjQyguv";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
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


--nextPart8080976.GUIdjQyguv
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 27 December 2011 23:27:51 Clemens John wrote:
> On Dienstag, 27. Dezember 2011 23:06:36 Clemens John wrote:
> > Simon commited another patchset today so I took the latest snapshot=
 of
> > his blaII_rebase branch [1] and put it on our own server [2]. I cha=
nged
> > the name of the folder inside the snapshot to 2011.4.0 and the md5s=
um
> > and the url to download the source in the OpenWrt Makefile [3]. For=

> > batctl I used the latest 2011.4.0 release and copied it to our serv=
er.
> > But when I try to compile OpenWrt, I get the following error:
> > http://pastebin.com/PcNH15EC
> Ok I created a patch from this version now and put it into the patche=
s
> folder. This worked. So forget about the last mail.
>=20
> What=B4s about the make option to enable bla2? How does this need to =
be
> applied to the makefile in openwrt or is there no need to change anyt=
hing
> because the option in in batman advanced own makefile is set to y?

Sry for the delay, but we were busy rebasing and fixing the blaII code.=
 There=20
are also some other meetings we are currently attending.

But to make it short: The code is automatically built (you correctly sa=
w the=20
CONFIG_BATMAN_ADV_BLA=3Dy), but you have to enable it through the new s=
ysfs file=20
"bridge_loop_avoidance" or the batctl option.

Kind regards,
=09Sven
--nextPart8080976.GUIdjQyguv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO+nnrAAoJEF2HCgfBJntGpw4P/0AwRF+GPGlDFN4N695irqmA
ZY6FxWsKXjbWBif4WSrNJvzEHcq07apcqP5VFhx49GVGroxjjFl18SC3eBUjTiq4
q5PmD5DcAzYkLcBarqubnCFaEWb3jDYZG7uQGS0SP6QMSpkIbm+vwZATAyU5lnzu
udI3VPNIttx9k0L4C5LkHRKBYjd/3tzPuIkKLSjn/KYdsusocpwThoWIRNkOKdM4
PWl78VQFz2rDtFiuwMXWzZmhvyfY5HMPedh04FsjlJKnykcBrwEBMAayFpphEUwY
5rMZQrvOZ+Ccj+phRYk3TLkq1VcoisdM5JwQzQAjE8uKuBNn41AUb45kuWCMzs0R
BBuz3dGkFj286dhi3nyCus9R03yrPRf6E3VP3j4PDt5KF1Ib3uu0LEImAGireJR6
PlB+M3A9dts/yEiXReRUV12Iv8/k6G5DFSRuhWaTHEyFQrumNkrDYN++hLA/3Jaf
eZOfNRHqOWHBe3OtezwxTe108rvtK1cJ3gbxFAxcslZ8tqXDpc/IhLu2pqK6kj2K
rmph+7oGfWBxorzEv8y0S0Xbj7h5oZMGOyPKuHKbiNZDrHdls9+g+lCoEOE8JcNn
9NkBbV8WnSVD4wyarMCW3msuqz3vV992rPhvTNhY2YJjHjW6FNVHH1JQzNkEV5SF
fVfQirJZj9vR/sIgGDs9
=h1RB
-----END PGP SIGNATURE-----

--nextPart8080976.GUIdjQyguv--

