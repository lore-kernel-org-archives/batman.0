Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 08 Apr 2012 13:38:50 +0200
Message-ID: <1435020.7jvg1fZClC@sven-laptop.home.narfation.org>
In-Reply-To: <CAJuY50z3heRa3Q_EfVvG7ao1LKnjPRtxfvaRiDiyM3UvhV=B9Q@mail.gmail.com>
References: <CAJuY50z3heRa3Q_EfVvG7ao1LKnjPRtxfvaRiDiyM3UvhV=B9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1592127.zJsCT5F3K4";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Question howto build batman-adv Openwrt Kamikaze
	8.09 rev 2012 build
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


--nextPart1592127.zJsCT5F3K4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 08 April 2012 14:14:15 3zl Trizonelabs wrote:
> How could i build a newer release of batman-adv (2012) for Openwrt
> 8.09  or devel ?

I haven't tested kamikaze together with batman-adv 2012.1.x, but here are some 
things which look a little bit confusing:

> Or maybe i did something wrong here ?
> 
> Started with fresh build enviroment & setup :
>   feeds.conf.default
>      src-svn packages
> svn://svn.openwrt.org/openwrt/branches/packages_8.09
> svn://svn.openwrt.org/openwrt/packages
>      src-svn batman http://downloads.open-mesh.org/svn/openwrt-feed/

Ok, judging from the last line, you want to have the batman-adv-devel that 
contains just the package for a snapshot... (so not really the latest release, 
but some "random" shapshot right before the release)?

> 3zl@debian6esxi:~/OpenWRT/8.09tr$ ./scripts/feeds update
> Updating feed 'packages' from
> 'svn://svn.openwrt.org/openwrt/branches/packages_8.09' ...
> A    net/batman-advanced
> A    net/batman-advanced/files
> A    net/batman-advanced/files/etc
> A    net/batman-advanced/files/etc/config
> A    net/batman-advanced/files/etc/config/batmand-adv
> A    net/batman-advanced/files/etc/init.d
> A    net/batman-advanced/files/etc/init.d/batmand-adv
> A    net/batman-advanced/patches
> A    net/batman-advanced/Makefile
> Updated to revision 31216.

This stuff is from the kamikaze package repository. Please install the batman-
adv-devel package using `./scripts/feeds install batman-adv-devel` when you 
want it. Kamikaze is deprecated and will not receive any updates for batman-
adv. 

> make menuconfig :  Kernel Module Network select batman-adv (*)
> make.. results in : /build_dir/mips/batman-adv-r1176
>            with folders :         /batman  /batman-adv-kernelland
> /batman-adv-userspace  /batman-experimental  / battool
> 
> cat /feeds/packages/net/batman-advanced/makefile
>   KG_NAME:=batmand-adv
>   PKG_REV:=1176
>   PKG_VERSION:=r$(PKG_REV)
>   PKG_RELEASE:=1
>   PKG_BRANCH:=batman-adv-userspace
> 
> PKG_SOURCE_PROTO:=svn
> PKG_SOURCE_VERSION:=$(PKG_REV)
> PKG_SOURCE_SUBDIR:=batman-adv-$(PKG_VERSION)
> PKG_SOURCE_URL:=http://downloads.open-mesh.net/svn/batman/trunk/
> PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.gz
> PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
> 
> PKG_KMOD_BUILD_DIR:=$(PKG_BUILD_DIR)/batman-adv-kernelland
> 
> PKG_TOOL_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-battool-install
> PKG_TOOL_BUILD_DIR:=$(PKG_BUILD_DIR)/battool
> 
> on DIR-300 router :
>    uname -a 2.6.26.8 mips atheros 23xx DIR-300 A1
>    batman-adv : 01. rv1176 (cpmpatibility version 6) loaded

This is some really outdated stuff from kamikaze. Why are you trying to use 
kamikaze anyway? It is marked as deprecated since a while. Maybe you can use 
backfire or trunk (devel).

Kind regards,
	Sven
--nextPart1592127.zJsCT5F3K4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPgXjKAAoJEF2HCgfBJntGZLcP/2Lv+dHNQysTB84kj9TmuHNI
MK1DAii09YDPdOoFOrq9t3rDtJn4ZGC5gcVcOtha0XEAQYQkOplGZAOQgBXhM2a7
PSuuQQwNMYsetuO0w5HovaNE9Qc9Bvdn6Yi9COPHsgfqMTKmzrBJHhlmdNPVWBC8
Djwpz2m7ON1ZwXoyB1+0fAyn7Ofg6MhJURtDVEseZjA+WuFWq/yK9XWVsQMe17DE
lL1BroZPl2qNsU905fjbi0+xrcg4TEjgrTuzb0R0TDNeYACvwrqQzOpT6nVo4dhL
AnZEiOetFJjir/WCIyS4YF1JcWGzo089RV3znVQxYJanFG1Q6DQF7pUCTIn36qhO
J06SseF/czpniw8RvWIhHGMH80SXE0+BlCj8XBH5D0DfhxP05N0z94LZFdQm1ee1
sXewCTViAAl0ldy0EnSs6PFdVm1l9w2fnJX9VsQzfhDixAlwElxLFFYiGvV2Rsh1
uO718pqMLgiPlxZPeFKhJcEn4CskgxPHmUgD92pIhH46gjM8/Nfcd4OH7hAsLDWV
LAjtf5lQlHCOkTkxLT0HJIY4Kq44tLrqcKKqxBAYXQid14RH7iIRh9uRtc4yAtyD
ecz9HOaPrrb42UfAcO7/9lv579LGhHMy0UTJwcMf/9RoHfeiDVhhRYhsorihb5lf
vxjhOu2Do1Y/ATHW9E1W
=UrW1
-----END PGP SIGNATURE-----

--nextPart1592127.zJsCT5F3K4--

