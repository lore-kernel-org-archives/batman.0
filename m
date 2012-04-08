Return-Path: <trizonelabs@googlemail.com>
MIME-Version: 1.0
Date: Sun, 8 Apr 2012 14:14:15 +0300
Message-ID: <CAJuY50z3heRa3Q_EfVvG7ao1LKnjPRtxfvaRiDiyM3UvhV=B9Q@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Question howto build batman-adv Openwrt Kamikaze
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

How could i build a newer release of batman-adv (2012) for Openwrt
8.09  or devel ?

Or maybe i did something wrong here ?

Started with fresh build enviroment & setup :
  feeds.conf.default
     src-svn packages
svn://svn.openwrt.org/openwrt/branches/packages_8.09
svn://svn.openwrt.org/openwrt/packages
     src-svn batman http://downloads.open-mesh.org/svn/openwrt-feed/

3zl@debian6esxi:~/OpenWRT/8.09tr$ ./scripts/feeds update
Updating feed 'packages' from
'svn://svn.openwrt.org/openwrt/branches/packages_8.09' ...
A    net/batman-advanced
A    net/batman-advanced/files
A    net/batman-advanced/files/etc
A    net/batman-advanced/files/etc/config
A    net/batman-advanced/files/etc/config/batmand-adv
A    net/batman-advanced/files/etc/init.d
A    net/batman-advanced/files/etc/init.d/batmand-adv
A    net/batman-advanced/patches
A    net/batman-advanced/Makefile
Updated to revision 31216.

make menuconfig :  Kernel Module Network select batman-adv (*)
make.. results in : /build_dir/mips/batman-adv-r1176
           with folders :         /batman  /batman-adv-kernelland
/batman-adv-userspace  /batman-experimental  / battool

cat /feeds/packages/net/batman-advanced/makefile
  KG_NAME:=batmand-adv
  PKG_REV:=1176
  PKG_VERSION:=r$(PKG_REV)
  PKG_RELEASE:=1
  PKG_BRANCH:=batman-adv-userspace

PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=batman-adv-$(PKG_VERSION)
PKG_SOURCE_URL:=http://downloads.open-mesh.net/svn/batman/trunk/
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_KMOD_BUILD_DIR:=$(PKG_BUILD_DIR)/batman-adv-kernelland

PKG_TOOL_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-battool-install
PKG_TOOL_BUILD_DIR:=$(PKG_BUILD_DIR)/battool

on DIR-300 router :
   uname -a 2.6.26.8 mips atheros 23xx DIR-300 A1
   batman-adv : 01. rv1176 (cpmpatibility version 6) loaded

is it possible to get rel 2012.x build on Kamikaze ?
thanks
3zl
