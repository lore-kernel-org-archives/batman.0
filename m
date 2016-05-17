Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 May 2016 17:06:24 +0800
Message-ID: <2942703.MT5BSIy3gc@voltaire>
In-Reply-To: <1463087478-7101-1-git-send-email-a@unstable.cc>
References: <1463087478-7101-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6184890.vmTmCONhd6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N. V -
	implement hard-iface init function
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

--nextPart6184890.vmTmCONhd6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, May 13, 2016 05:11:18 Antonio Quartulli wrote:
> Changes from v1:
> - move bat_algo.h include line to the right location

$ make CONFIG_BATMAN_ADV_BATMAN_V=3Dy
/home/marek/batman-adv/gen-compat-autoconf.sh /home/marek/batman-adv/co=
mpat-autoconf.h
make -C /lib/modules/4.4.0-1-amd64/build M=3D/home/marek/batman-adv/net=
/batman-adv CONFIG_BATMAN_ADV=3Dm CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BA=
TMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CONFIG_BATMAN_ADV_NC=3Dn CON=
FIG_BATMAN_ADV_MCAST=3Dy CONFIG_BATMAN_ADV_BATMAN_V=3Dy INSTALL_MOD_DIR=
=3Dupdates/net/batman-adv/       modules
make[1]: Entering directory '/usr/src/linux-headers-4.4.0-1-amd64'
Makefile:10: *** mixed implicit and normal rules: deprecated syntax
  CC [M]  /home/marek/batman-adv/net/batman-adv/../../compat-sources/ne=
t/core/skbuff.o
  CC [M]  /home/marek/batman-adv/net/batman-adv/../../compat-sources/ne=
t/ipv4/igmp.o
  CC [M]  /home/marek/batman-adv/net/batman-adv/../../compat-sources/ne=
t/ipv6/mcast_snoop.o
  CC [M]  /home/marek/batman-adv/net/batman-adv/bat_iv_ogm.o
In file included from /home/marek/batman-adv/net/batman-adv/bat_iv_ogm.=
c:18:0:
/home/marek/batman-adv/net/batman-adv/bat_algo.h:28:34: warning: =E2=80=
=98struct batadv_hard_iface=E2=80=99 declared inside parameter list
 void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
                                  ^
/home/marek/batman-adv/net/batman-adv/bat_algo.h:28:34: warning: its sc=
ope is only this definition or declaration, which is probably not what =
you want
  CC [M]  /home/marek/batman-adv/net/batman-adv/bat_v.o
In file included from /home/marek/batman-adv/net/batman-adv/bat_v.c:18:=
0:
/home/marek/batman-adv/net/batman-adv/bat_algo.h:28:34: warning: =E2=80=
=98struct batadv_hard_iface=E2=80=99 declared inside parameter list
 void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
                                  ^
/home/marek/batman-adv/net/batman-adv/bat_algo.h:28:34: warning: its sc=
ope is only this definition or declaration, which is probably not what =
you want
/home/marek/batman-adv/net/batman-adv/bat_v.c:340:6: error: conflicting=
 types for =E2=80=98batadv_v_hardif_init=E2=80=99
 void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
      ^
In file included from /home/marek/batman-adv/net/batman-adv/bat_v.c:18:=
0:
/home/marek/batman-adv/net/batman-adv/bat_algo.h:28:6: note: previous d=
eclaration of =E2=80=98batadv_v_hardif_init=E2=80=99 was here
 void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
      ^
/usr/src/linux-headers-4.4.0-1-common/scripts/Makefile.build:263: recip=
e for target '/home/marek/batman-adv/net/batman-adv/bat_v.o' failed
make[4]: *** [/home/marek/batman-adv/net/batman-adv/bat_v.o] Error 1
/usr/src/linux-headers-4.4.0-1-common/Makefile:1401: recipe for target =
'_module_/home/marek/batman-adv/net/batman-adv' failed
make[3]: *** [_module_/home/marek/batman-adv/net/batman-adv] Error 2
Makefile:146: recipe for target 'sub-make' failed
make[2]: *** [sub-make] Error 2
Makefile:8: recipe for target 'all' failed
make[1]: *** [all] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-4.4.0-1-amd64'
Makefile:72: recipe for target 'all' failed
make: *** [all] Error 2
--nextPart6184890.vmTmCONhd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXOt8QAAoJEFNVTo/uthzAZFMH/3GAL7K1ajPP1v9F6dylPHq3
5jdxCU/Z3EuJtaIZYuzTbVgruzncqmgnAljQKAuX6OYd4cC16lHu8HYVUB2zCW04
ei5MjXEV5QO265lqxkf6KM01uwP/YIKUz/mYn83ycGHQGnMKWmngRSeo/+0p7om9
/Wluji89GNovzOaov+bXjiyBgRarZYHNcvG+5dhCMtOb7kZCGyltv8d+mfeQo27K
juCs9wsoAj5tJ7aPX2SaJPIjZqd+B8E64OzgD493a/n0vbBEevObcDsdV8k3+8OQ
SyAG2EP49tkOjGnygXkvVnFOjviUv/hqfHNfG7QLq4EtSzrdW5wnri9Hxp0E3dM=
=9Zck
-----END PGP SIGNATURE-----

--nextPart6184890.vmTmCONhd6--

