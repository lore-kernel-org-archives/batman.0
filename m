Return-Path: <perazim@inbox.lt>
From: Perazim <perazim@inbox.lt>
In-Reply-To: <4F2A6AF2.7040603@openwrt.org>
References: <1328179539.3152.44.camel@travelmate.perazim.net>
	<4F2A6AF2.7040603@openwrt.org>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 03 Feb 2012 15:07:14 +0200
Message-ID: <1328274434.3152.61.camel@travelmate.perazim.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] some basic questions
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

Thanks, that took care of the problem.

A followup question: I would rather use branch but it only has
batman-adv-2011.2.0 whereas the current version is 2011.4.0.

Followed the instructions here:

http://www.open-mesh.org/wiki/batman-adv/Building-with-openwrt



...
Changing the batman-adv / batctl version¶

It is also possible to modify the batman-adv version if you ever wanted
to build an older/newer version than configured in the package:

stable version:

Adjust the PKG_VERSION variable to download & build the stable release
you are interested in.

cat openwrt/feeds/packages/net/batman-adv/Makefile
[..]
PKG_VERSION:=2010.0.0
[..]



In doing this, I had to also update the md5sums for the sources.

I now receive this error while building:




make[3]: Leaving directory
`/home/yossi/router/backfire-bullet2/feeds/luci/luci'
make[3]: Entering directory
`/home/yossi/router/backfire-bullet2/feeds/packages/net/batman-adv'
cp /home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batman-adv-2011.4.0/Makefile.kbuild /home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batman-adv-2011.4.0/Makefile
make -C
"/home/yossi/router/backfire-bullet2/build_dir/linux-atheros/linux-2.6.30.10" CROSS_COMPILE="mips-openwrt-linux-uclibc-" ARCH="mips" PATH="/home/yossi/router/backfire-bullet2/staging_dir/toolchain-mips_gcc-4.3.3+cs_uClibc-0.9.30.1/usr/bin:/home/yossi/router/backfire-bullet2/staging_dir/host/bin:/home/yossi/router/backfire-bullet2/staging_dir/toolchain-mips_gcc-4.3.3+cs_uClibc-0.9.30.1/usr/bin:/home/yossi/router/backfire-bullet2/staging_dir/host/bin:/home/yossi/router/backfire-bullet2/staging_dir/toolchain-mips_gcc-4.3.3+cs_uClibc-0.9.30.1/usr/bin:/home/yossi/router/backfire-bullet2/staging_dir/host/bin:/usr/lib/qt-3.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/yossi/bin"  SUBDIRS="/home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batman-adv-2011.4.0" LINUX_VERSION="2.6.30.10" REVISION="" modules
make[4]: Entering directory
`/home/yossi/router/backfire-bullet2/build_dir/linux-atheros/linux-2.6.30.10'
  Building modules, stage 2.
  MODPOST 1 modules
make[4]: Leaving directory
`/home/yossi/router/backfire-bullet2/build_dir/linux-atheros/linux-2.6.30.10'
make
-C /home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batctl-2011.4.0 CFLAGS="-Os -pipe -mips32 -mtune=mips32 -funit-at-a-time -fhonour-copts -msoft-float" CCFLAGS="-Os -pipe -mips32 -mtune=mips32 -funit-at-a-time -fhonour-copts -msoft-float" OFLAGS="-Os -pipe -mips32 -mtune=mips32 -funit-at-a-time -fhonour-copts -msoft-float" REVISION="" CC="mips-openwrt-linux-uclibc-gcc" NODEBUG=1 UNAME="Linux" INSTALL_PREFIX="/home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batman-adv-2011.4.0/ipkg-install" STRIP="/bin/true" batctl install
make[4]: Entering directory
`/home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batctl-2011.4.0'
make[4]: `batctl' is up to date.
mkdir -p /usr/local/sbin
mkdir -p /usr/local/share/man/man8
install -m 0755 batctl /usr/local/sbin
install: cannot create regular file `/usr/local/sbin/batctl': Permission
denied
make[4]: *** [install] Error 1
make[4]: Leaving directory
`/home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batctl-2011.4.0'
make[3]: ***
[/home/yossi/router/backfire-bullet2/build_dir/target-mips_uClibc-0.9.30.1/batman-adv/batman-adv-2011.4.0/.built] Error 2
make[3]: Leaving directory
`/home/yossi/router/backfire-bullet2/feeds/packages/net/batman-adv'
make[2]: *** [package/feeds/packages/batman-adv/compile] Error 2
make[2]: Leaving directory `/home/yossi/router/backfire-bullet2'
make[1]: ***
[/home/yossi/router/backfire-bullet2/staging_dir/target-mips_uClibc-0.9.30.1/stamp/.package_compile] Error 2
make[1]: Leaving directory `/home/yossi/router/backfire-bullet2'
make: *** [world] Error 2
[yossi@maps backfire-bullet2]$ make j=6


Did something change between 2011.2.0 and 2011.4.0?

Thanks,


Perazim

On Thu, 2012-02-02 at 11:52 +0100, Jo-Philipp Wich wrote:
> Hi.
> 
> > Is this normal behavior or is there something wrong with menuconfig that
> > is causing batmand to be included?
> 
> kmod-batgat belongs to the Layer 3 batman, do not select it.
> 
> 
> ~ Jow


