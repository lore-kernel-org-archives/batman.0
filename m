Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aq+4FiT1Na7KiErHFujEetFSKOppDKu8HBf0ueOiTa4nvQ@mail.gmail.com>
References: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
 <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
 <CADP5dB44Or62qRPptw-J0MC4tTD92GupZeB5dgXyeJg4ycjAow@mail.gmail.com>
 <CAHD-aq+4FiT1Na7KiErHFujEetFSKOppDKu8HBf0ueOiTa4nvQ@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Tue, 16 Oct 2012 17:44:28 -0300
Message-ID: <CAHD-aqLqQB=r9070Zv3tFoK-JBDBK7358mGqKZCGhrYc0Bcwbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] How to detect gateway mode in openwrt?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Oct 16, 2012 at 5:17 PM, Gui Iribarren <gui@altermundi.net> wrote:
>
>> Too bad you don't have all default ar71xx router images ready to flash.
>
> Will do.

Here you go,

http://openwrt.altermundi.net/snapshots/r33399/ar71xx/batman-ipv6/

They are built using this ImageBuilder

http://openwrt.altermundi.net/snapshots/r33399/ar71xx/OpenWrt-ImageBuilder-ar71xx_generic-for-linux-i486_r33399.tar.bz2

with PACKAGES='kmod-batman-adv kmod-ipv6 -dnsmasq dnsmasq-dhcpv6
ip6tables kmod-ath9k-htc safe-reboot iperf qos-scripts -ppp
-ppp-mod-pppoe mini-snmpd'

other than that, it's a vanilla openwrt.
so after flashing, you can telnet to 192.168.1.1 and

opkg update
opkg install batman-adv-auto-gw-mode
reboot # so that uci-default scripts are run

:)

alternatively, you can download our ImageBuilder.tar.bz2 and generate
your own images, adding "batman-adv-auto-gw-mode" to the PACKAGES
argument.

http://wiki.openwrt.org/doc/howto/imagebuilder
