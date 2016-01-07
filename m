Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 07 Jan 2016 09:32:25 +0100
Message-ID: <2336857.vgGxGdEGcu@sven-edge>
In-Reply-To: <20160107033933.GA2893@otheros>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-12-git-send-email-sven@narfation.org>
 <20160107033933.GA2893@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2250120.sIj78b4L7o";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 12/31] batman-adv: Add compatibility
	code for kref_get_unless_zero
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2250120.sIj78b4L7o
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday 07 January 2016 04:39:33 Linus L=C3=BCssing wrote:
[...]
> Does not compile for me on a 3.2 kernel:
>=20
> -----
> /home/tux/dev/batman-adv-t_x/gen-compat-autoconf.sh
> /home/tux/dev/batman-adv-t_x/compat-autoconf.h make -C
> /lib/modules/3.2.0-4-amd64/build
> M=3D/home/tux/dev/batman-adv-t_x/net/batman-adv CONFIG_BATMAN_ADV=3Dm=

> CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_A=
DV_DAT=3Dy
> CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy
> INSTALL_MOD_DIR=3Dupdates/net/batman-adv/   modules make[1]: Entering=

> directory `/usr/src/linux-headers-3.2.0-4-amd64' CC [M]=20
> /home/tux/dev/batman-adv-t_x/net/batman-adv/bat_iv_ogm.o distcc[1604]=

> ERROR: compile /home/tux/.ccache/tmp/bat_iv_ogm.tmp.krtek.1599.i on
> localhost failed In file included from
> /usr/src/linux-headers-3.2.0-4-common/include/linux/kobject.h:24:0, f=
rom
> /usr/src/linux-headers-3.2.0-4-common/include/linux/device.h:17, from=

> /usr/src/linux-headers-3.2.0-4-common/include/linux/dmaengine.h:24, f=
rom
> /usr/src/linux-headers-3.2.0-4-common/include/linux/skbuff.h:30, from=

> /home/tux/dev/batman-adv-t_x/compat-include/linux/skbuff.h:25, from
> /usr/src/linux-headers-3.2.0-4-common/include/linux/if_ether.h:133, f=
rom
> /home/tux/dev/batman-adv-t_x/compat-include/linux/if_ether.h:25, from=

> /usr/src/linux-headers-3.2.0-4-common/include/linux/netdevice.h:29, f=
rom
> /home/tux/dev/batman-adv-t_x/compat-include/linux/netdevice.h:25, fro=
m
> /home/tux/dev/batman-adv-t_x/compat.h:52,
>                  from <command-line>:1:
> /home/tux/dev/batman-adv-t_x/compat-include/linux/kref.h:32:95: error=
:
> redefinition of =E2=80=98kref_get_unless_zero=E2=80=99
> /usr/src/linux-headers-3.2.0-4-common/include/linux/kref.h:47:95: not=
e:
> previous definition of =E2=80=98kref_get_unless_zero=E2=80=99 was her=
e make[4]: ***
> [/home/tux/dev/batman-adv-t_x/net/batman-adv/bat_iv_ogm.o] Error 1 ma=
ke[3]:
> *** [_module_/home/tux/dev/batman-adv-t_x/net/batman-adv] Error 2 mak=
e[2]:
> *** [sub-make] Error 2
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/usr/src/linux-headers-3.2.0-4-amd64'
> make: *** [all] Error 2
> make  0,61s user 0,20s system 67% cpu 1,203 total
> -----

This doesn't seem to be an official Linus' kernel because here the 3.2 =
kernel=20
doesn't have this function (checked against Linus' official 3.2 release=
). It=20
looks like this 3.8 change was introduced by Ben Hutchings in Linux sta=
ble for=20
v3.2.44.

Does anyone has interest in adding the code to check for these stable=20=

releases?

Kind regards,
=09Sven
--nextPart2250120.sIj78b4L7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWjiKZAAoJEF2HCgfBJntGHjEQALvxW7s7H9UHqO2OITVqaOEq
93lHN9MXPSoaQy3coi1s2nyHIoF7MUmVQj0yQEFbmoABGUEQXOx3ujFAY6Hq2wn3
LG7JpiiM9N1vbU2jGG2b35ZEYgJA9ZsTgeyE11IpWccfhK3HgnGEKVi4yzuzYQDa
nsGe24EX/g/blf0W9oCGMk6h12SS2QR0DokNeCvec7xupDLJ5CKpdlFZgOV9wxav
tKwN/Kg1fDzWkkrDZqbZns9OFEDOIerQETKiD+zkhoKaZ8SuLIkJX/Bdp5trOztX
Zucggtl1BcJdkQ5jTRxPK2WtY2nACUoZ8P+sd+s2AzoDbYTFnG0h7IwjZmiFyZVn
23g1+pMo4QzTMxBmg+nLjjZyMFZ7uuAN+7w4nTTdb7EuHMaPNv9zYCwAs3XwdIWo
tJuxODTXoJjQc+73qZHK5aXMseZQPHqg30Jb9s72rBb7qPbu4RDdKVm3/XK6Ig2M
HoLXRTq1WapTF9Tm9eNQsbXrGh6egmj/vUymOzNDCApVWiNCdj/aF86EXULv59NY
oIv1EJXRVQCiGPJt32RPIvCIeN4Zt9SuKvZjx8igB1XPXpFS9CqXPoF+X5liNbjW
5aOsRoHJ06Ix63+jpL+8F1kn/Lp5g3c2JOz4GL8/ywWT869S7Le9IESIZvi7L2hS
FvrIWoob8ulViLd5HFcb
=GnV/
-----END PGP SIGNATURE-----

--nextPart2250120.sIj78b4L7o--

