Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <50EFEB5D.7030703@nixbits.net>
References: <50EFEB5D.7030703@nixbits.net>
From: Gui Iribarren <gui@altermundi.net>
Date: Fri, 11 Jan 2013 09:12:16 -0300
Message-ID: <CAHD-aqLrnwLYiKvLyF3Tp8mSSumyKPR=7JJyxYfg7xHUUYzNEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] Batman-adv 2012.4.0 into
	attitude adjustment
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
To: HeXileD@nixbits.net, OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

IIRC the openwrt package uses the out-of-kernel-tree batman release,
i.e. it doesn't depend on a particular kernel version.

So manually updating the package version in the makefile of your
openwrt AA build environment should work.
You don't need to add batman-adv feed in this case - having the 'packages'
official feed is enough.

What follows is taken from trunk, to serve you as a reference.

~/openwrt/ $ head feeds/packages/net/batman-adv/Makefile
PKG_VERSION:=2012.4.0
BATCTL_VERSION:=2012.4.0
PKG_MD5SUM:=24e922a64a507b146c32c585538407f2
BATCTL_MD5SUM:=79d5aa796ae8b008a9fa42c27d4da2c1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://downloads.open-mesh.org/batman/releases/batman-adv-$(PKG_VERSION)

hope that helps,

Cheers!

On Fri, Jan 11, 2013 at 7:37 AM, HeXiLeD <hexiled@nixbits.net> wrote:
> Which batman-adv feed should i use if there is one available ?
>
> This
> (http://www.open-mesh.org/projects/batman-adv/wiki/Building-with-openwrt)
> takes me to git (batman-adv-devel) which i might not want & need. Will
> change the revision help ?
>
> If i am not mistaken; unless  batman-adv 2012.4.0 is moved by someone
> from openwrt trunk to openwrt attitude adjustment i am not able to find
> a feed that provides me what i need and build batman-adv 2012.4.0 with
> attitude adjustment (kernel 3.3)
>
> What are my options ?
>
>
>
>
>
>
> _______________________________________________
> openwrt-devel mailing list
> openwrt-devel@lists.openwrt.org
> https://lists.openwrt.org/mailman/listinfo/openwrt-devel
