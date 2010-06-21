Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Mon, 21 Jun 2010 16:11:40 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1370900.rkP7cv2aUg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201006211611.45412.clemens-john@gmx.de>
Subject: [B.A.T.M.A.N.] Cannot build actual OpenWrt Backfire branch with
	Batman Advanced
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1370900.rkP7cv2aUg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I tried to build OpenWrt Backfire with Batman adv from an actual branch 5=20
minutes ago and it fails with the following error  (seems to be a=20
version/download problem):

=2D-----------
=2D-2010-06-21 16:03:50--  http://mirror2.openwrt.org/sources/batctl-
maint-1611.tar.gz
Resolving mirror2.openwrt.org... 88.198.39.176
Connecting to mirror2.openwrt.org|88.198.39.176|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2010-06-21 16:03:50 ERROR 404: Not Found.

Download failed.
=2D-2010-06-21 16:03:50--  http://downloads.openwrt.org/sources/batctl-
maint-1611.tar.gz
Resolving downloads.openwrt.org... 78.24.191.177
Connecting to downloads.openwrt.org|78.24.191.177|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2010-06-21 16:03:50 ERROR 404: Not Found.

Download failed.
No more mirrors to try - giving up.
Checking out files from the svn repository...
svn: Write error: Broken pipe
svn: '/svn/batman/!svn/bc/1718/branches/batctl-0.2.x' path not found
svn: '/svn/batman/!svn/bc/1718/branches/batctl-0.2.x' path not found
make[3]: *** [/home/floh1111/openwrtbuild_luci/dl/batctl-maint-1611.tar.gz]=
=20
Error 1
make[3]: Leaving directory=20
`/home/floh1111/openwrtbuild_luci/feeds/packages/net/batman-advanced'
make[2]: *** [package/feeds/packages/batman-advanced/compile] Error 2
make[2]: Leaving directory `/home/floh1111/openwrtbuild_luci'
make[1]: *** [/home/floh1111/openwrtbuild_luci/staging_dir/target-
mips_uClibc-0.9.30.1/stamp/.package_compile] Error 2
make[1]: Leaving directory `/home/floh1111/openwrtbuild_luci'
make: *** [world] Fehler 2
=2D------

It seems to be that the source file saved in the makefile is not right.
https://dev.openwrt.org/browser/packages/net/batman-advanced/Makefile

Can someone fix this please?

Another question:
What=B4s up with the latest release (Batman-adv 2010.0.0)?
Will I be able to build it with the Backfire branch? Maybe someone can upda=
te=20
the makefile?

Thanks
Clemens

--nextPart1370900.rkP7cv2aUg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwfcxwACgkQZgdHbA22lqNTrgCeLJAtq+/vJ15ScStfx+WGvoJH
0eAAmwZF/VfvMpjvQ0gQ2HQjDLpkiqzk
=MoGi
-----END PGP SIGNATURE-----

--nextPart1370900.rkP7cv2aUg--
