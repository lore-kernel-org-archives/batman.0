Return-Path: <gio@eigenlab.org>
From: Gio <gio@eigenlab.org>
Date: Thu, 05 May 2016 17:30:57 +0200
Message-ID: <2083541.Hg032Jxeer@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [B.A.T.M.A.N.] Batman-adv doesn't compile in openwrt after last
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, Antonio Quartulli <a@unstable.cc>

Hi!

I get this error after last commit on openwrt routing feed

evelop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/pkginfo/alfred.default.install 
/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/pkginfo/alfred.default.install.clean; fi; echo 
"alfred" >> /home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/pkginfo/alfred.default.install  
make[3]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop/feeds/routing/alfred'
make[3]: Entering directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop/feeds/routing/batman-adv'
make -j1 -C "/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/linux-
ar71xx_generic/linux-3.18.29" ARCH="mips" CROSS_COMPILE="mips-openwrt-linux-
uclibc-" SUBDIRS="/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv" CONFIG_BATMAN_ADV=m 
CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y 
CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_BATMAN_V=n  
EXTRA_CFLAGS=" -DCONFIG_BATMAN_ADV=1  -DCONFIG_BATMAN_ADV_DEBUG=1  -
DCONFIG_BATMAN_ADV_BLA=1  -DCONFIG_BATMAN_ADV_DAT=1  -
DCONFIG_BATMAN_ADV_MCAST=1 " NOSTDINC_FLAGS="-
I/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv -
I/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/usr/include/mac80211-backport/uapi -
I/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/usr/include/mac80211-backport -
I/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/usr/include/mac80211/uapi -
I/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/usr/include/mac80211 -include backport/backport.h -
include /home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/compat-hacks.h" modules
make[4]: Entering directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/linux-
ar71xx_generic/linux-3.18.29'
  CC [M]  /home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv/bat_iv_ogm.o
cc1: fatal error: backport/backport.h: No such file or directory
compilation terminated.
scripts/Makefile.build:257: recipe for target 
'/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv/bat_iv_ogm.o' failed
make[5]: *** [/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv/bat_iv_ogm.o] Error 1
Makefile:1381: recipe for target 
'_module_/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv' failed
make[4]: *** [_module_/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/net/batman-adv] Error 2
make[4]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/linux-
ar71xx_generic/linux-3.18.29'
Makefile:103: recipe for target '/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/.built' failed
make[3]: *** [/home/gioacchino/public_html/openwrt/lime-
build/build/develop/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-
adv/batman-adv-2016.1/.built] Error 2
make[3]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop/feeds/routing/batman-adv'
package/Makefile:191: recipe for target 'package/feeds/routing/batman-
adv/compile' failed
make[2]: *** [package/feeds/routing/batman-adv/compile] Error 2
make[2]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop'
package/Makefile:188: recipe for target 
'/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/stamp/.package_compile' failed
make[1]: *** [/home/gioacchino/public_html/openwrt/lime-
build/build/develop/staging_dir/target-
mips_34kc_uClibc-0.9.33.2/stamp/.package_compile] Error 2
make[1]: Leaving directory '/home/gioacchino/public_html/openwrt/lime-
build/build/develop'
/home/gioacchino/public_html/openwrt/lime-
build/build/develop/include/toplevel.mk:181: recipe for target 'world' failed
make: *** [world] Error 2


Cheers!
