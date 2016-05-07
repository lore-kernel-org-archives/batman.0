Return-Path: <contact@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <112511932.Eq5c9Kmyda@sven-edge>
 <572E1219.7070005@wifibot.com> <1884294.h0rzVsQuVd@sven-edge>
From: contact <contact@wifibot.com>
Message-ID: <572E1ADE.5040400@wifibot.com>
Date: Sat, 7 May 2016 18:42:06 +0200
MIME-Version: 1.0
In-Reply-To: <1884294.h0rzVsQuVd@sven-edge>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

it was the default version present in yesterday openwrt stable 15.05.1

in batman makefile i have :

include $(TOPDIR)/rules.mk

PKG_NAME:=batman-adv

PKG_VERSION:=2016.1
PKG_RELEASE:=1
PKG_MD5SUM:=8c8e449009b4d29512d26ee308960bb5

On 07/05/2016 18:28, Sven Eckelmann wrote:
> On Saturday 07 May 2016 18:04:41 contact wrote:
>> Thank you, it is working and it is more clear for me.
>>
>> I have switched to V but when I switch on other V nodes, my first node
>> reset or freeze, probably a kernel panic. Need to plug a rs232 to be
>> able to see what could be the problem.
>> I will switch back to IV.
> Which version did you build?
>
> https://github.com/openwrt-routing/packages/commit/8dec3dc38b514ed8f1212b51f9f6039af3fb0e04
>
> or
>
> https://github.com/openwrt-routing/packages/commit/a3cd8a1729779b8a39336a863ba7f97481e81f5c
>
> or a different version/feed? Please make sure that you don't use a legacy feed
> together with batman-adv v2016.1 and B.A.T.M.A.N. V. It can only be used when
> build directly against the used mac80211 package which is only done in the two
> openwrt feeds linked here (and in a devel feed [1] which is building always
> against the current master).
>
> Kind regards,
> 	Sven
>
> [1] https://git.open-mesh.org/openwrt-feed-devel.git

