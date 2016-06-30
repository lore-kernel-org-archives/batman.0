Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 30 Jun 2016 10:58:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160630085828.GH4309@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1467274165-2866-1-git-send-email-linus.luessing@c0d3.blue>
Subject: [B.A.T.M.A.N.] [fengguang.wu@intel.com: [batman:batman-adv/next
 15/28] undefined reference to `br_multicast_has_querier_anywhere']
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

https://lists.01.org/pipermail/kbuild-all/2016-June/021435.html

----- Forwarded message from kbuild test robot <fengguang.wu@intel.com> -----

Date: Thu, 30 Jun 2016 01:00:47 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Simon Wunderlich <sw@simonwunderlich.de>, Linus Lüssing <linus.luessing@c0d3.blue>, Marek Lindner <mareklindner@neomailbox.ch>
Subject: [batman:batman-adv/next 15/28] undefined reference to `br_multicast_has_querier_anywhere'

tree:   git://git.open-mesh.org/linux-merge batman-adv/next
head:   a43fbc01d3f5ef77cab5625f26fa3740229ecf63
commit: 339339cb691ce0318b236cb245a0fdbface88b39 [15/28] batman-adv: Add multicast optimization support for bridged setups
config: i386-randconfig-h0-06292136 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        git checkout 339339cb691ce0318b236cb245a0fdbface88b39
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   net/built-in.o: In function `batadv_mcast_mla_update':
>> (.text+0x19b7eb): undefined reference to `br_multicast_has_querier_anywhere'
   net/built-in.o: In function `batadv_mcast_mla_update':
>> (.text+0x19b7fa): undefined reference to `br_multicast_has_querier_adjacent'
   net/built-in.o: In function `batadv_mcast_mla_update':
   (.text+0x19b809): undefined reference to `br_multicast_has_querier_anywhere'
   net/built-in.o: In function `batadv_mcast_mla_update':
   (.text+0x19b818): undefined reference to `br_multicast_has_querier_adjacent'
   net/built-in.o: In function `batadv_mcast_mla_update':
>> (.text+0x19b8cf): undefined reference to `br_multicast_list_adjacent'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



----- End forwarded message -----
