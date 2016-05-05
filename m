Return-Path: <a@unstable.cc>
Date: Thu, 5 May 2016 23:34:47 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160505153447.GQ11201@prodigo.lan>
References: <2083541.Hg032Jxeer@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cp+VOSm8VfVBUvcG"
Content-Disposition: inline
In-Reply-To: <2083541.Hg032Jxeer@riseup.net>
Subject: Re: [B.A.T.M.A.N.] Batman-adv doesn't compile in openwrt after last
	commit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Gio <gio@eigenlab.org>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>


--Cp+VOSm8VfVBUvcG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After such commit Marek introduced a dependency to another openwrt packet,
therefore you need to type make in the openwrt root in order to properly re=
build
what's required now.

Cheers,

On Thu, May 05, 2016 at 05:30:57PM +0200, Gio wrote:
> Hi!
>=20
> I get this error after last commit on openwrt routing feed
>=20
> evelop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/pkginfo/alfred.default.install=20
> /home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/pkginfo/alfred.default.install.clean; fi; echo=
=20
> "alfred" >> /home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/pkginfo/alfred.default.install =20
> make[3]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/feeds/routing/alfred'
> make[3]: Entering directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/feeds/routing/batman-adv'
> make -j1 -C "/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/linux-
> ar71xx_generic/linux-3.18.29" ARCH=3D"mips" CROSS_COMPILE=3D"mips-openwrt=
-linux-
> uclibc-" SUBDIRS=3D"/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv" CONFIG_BATMAN_ADV=3Dm=20
> CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_D=
AT=3Dy=20
> CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_BA=
TMAN_V=3Dn =20
> EXTRA_CFLAGS=3D" -DCONFIG_BATMAN_ADV=3D1  -DCONFIG_BATMAN_ADV_DEBUG=3D1  -
> DCONFIG_BATMAN_ADV_BLA=3D1  -DCONFIG_BATMAN_ADV_DAT=3D1  -
> DCONFIG_BATMAN_ADV_MCAST=3D1 " NOSTDINC_FLAGS=3D"-
> I/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv -
> I/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/usr/include/mac80211-backport/uapi -
> I/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/usr/include/mac80211-backport -
> I/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/usr/include/mac80211/uapi -
> I/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/usr/include/mac80211 -include backport/backport=
=2Eh -
> include /home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/compat-hacks.h" modules
> make[4]: Entering directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/linux-
> ar71xx_generic/linux-3.18.29'
>   CC [M]  /home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv/bat_iv_ogm.o
> cc1: fatal error: backport/backport.h: No such file or directory
> compilation terminated.
> scripts/Makefile.build:257: recipe for target=20
> '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv/bat_iv_ogm.o' failed
> make[5]: *** [/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv/bat_iv_ogm.o] Error 1
> Makefile:1381: recipe for target=20
> '_module_/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv' failed
> make[4]: *** [_module_/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/net/batman-adv] Error 2
> make[4]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/linux-
> ar71xx_generic/linux-3.18.29'
> Makefile:103: recipe for target '/home/gioacchino/public_html/openwrt/lim=
e-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/.built' failed
> make[3]: *** [/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
> adv/batman-adv-2016.1/.built] Error 2
> make[3]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/feeds/routing/batman-adv'
> package/Makefile:191: recipe for target 'package/feeds/routing/batman-
> adv/compile' failed
> make[2]: *** [package/feeds/routing/batman-adv/compile] Error 2
> make[2]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop'
> package/Makefile:188: recipe for target=20
> '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/stamp/.package_compile' failed
> make[1]: *** [/home/gioacchino/public_html/openwrt/lime-
> build/build/develop/staging_dir/target-
> mips_34kc_uClibc-0.9.33.2/stamp/.package_compile] Error 2
> make[1]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
> build/build/develop'
> /home/gioacchino/public_html/openwrt/lime-
> build/build/develop/include/toplevel.mk:181: recipe for target 'world' fa=
iled
> make: *** [world] Error 2
>=20
>=20
> Cheers!
>=20

--=20
Antonio Quartulli

--Cp+VOSm8VfVBUvcG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXK2gXAAoJEJ4aZjxxc6bKDfIP/R+mAUZeWQnYAP3Qsedd5cZx
IXci9CsH6634SQGEAoet4jiLXPop5nqdW7pxr21R3afCNqNByGRtBK2j+dWJU7gR
yrZIcHZpyu3j4PcnfGNGCSn8qP2PEtlIh/HaueRRB0JzePgv9eHnACCmDBled+mK
Gj6frP6Cf87Bl4gXHVl1WF5k3UDnQCaNfHjEP1tQklXnIQm/aDx3fMwV1Y3vvK5p
auK2hs52U/yw7KS2hzmI669RZUFcSxESDB/tONKBBFGnRjGuHrzWALQWQCwRuGkt
dqlZjdBOScy8WnrmYH5Z8ob09+StKDy1UaA/BkpHOBhC6+DtAGAegJwSIXIUFrmX
v/uqq8kujwPrToeIObPspP3bGNUXqAs4WH1GODG7TZtEE2P4slWVT1UwDeDcYIT4
0bgF59EV+GO9mFNQCGtsEslnhjIbz+mm0TFaq3RFt/VDrDKT4v3lsLqFCW4V56p2
ou9kboEPlopbH19qgDC+e0Qm9r+qKODZK3g+cuEJg33phJtvexxNLAtPrqktoUBB
c01rJDQjiJGQVLk6f5fDUprZv1d01BkaVstOPPma6xut6fw/W2eml1UmqmZD6DFh
crb3yCTyjPNFMDxsYcwWKOaSiF1FLy6zB/h/Khgalh8PxMk92OvZpeczpUo7pMoY
p32QgcCoeYX0CHzSRkOg
=xn9/
-----END PGP SIGNATURE-----

--Cp+VOSm8VfVBUvcG--
