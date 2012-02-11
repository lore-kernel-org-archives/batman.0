Return-Path: <gmazzurco89@gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date: Sat, 11 Feb 2012 17:51:53 +0100
Message-ID: <1590796.df4KKcFED8@g10h4cklab>
In-Reply-To: <201202111758.29202.lindner_marek@yahoo.de>
References: <1807712.xKAsDcUsSn@g10h4cklab>
	<201202111758.29202.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] batman openwrt
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Ok so it is not a well known bug

There are some infos:

root@OpenWrt:~# batctl if
ath0: active

root@OpenWrt:~# cat /etc/eigennet/version
Build Info:

OpenWrt
Path: .
URL: svn://svn.openwrt.org/openwrt/branches/backfire
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 30330
Node Kind: directory
Schedule: normal
Last Changed Author: jow
Last Changed Rev: 30306
Last Changed Date: 2012-02-05 18:15:40 +0100 (Sun, 05 Feb 2012)

Feeds

packages
Path: .
URL: svn://svn.openwrt.org/openwrt/packages
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 30330
Node Kind: directory
Schedule: normal
Last Changed Author: jow
Last Changed Rev: 30328
Last Changed Date: 2012-02-06 12:54:43 +0100 (Mon, 06 Feb 2012)

zzzeigennet
URL: git://gitorious.org/eigennet/packages.git
commit d66e3ad00c920213f0ae5ddaa94e14797256570f
Author: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date:   Sun Feb 5 18:41:30 2012 +0100

    gw_mode client enabled by default


root@OpenWrt:~# cat /etc/config/batman-adv 

config 'mesh' 'bat0'
        option 'fragmentation' '1'
        option 'gw_mode' 'client'
        list 'interfaces' 'clients'
        list 'interfaces' 'nmeshwifi0'

root@OpenWrt:~# cat /etc/config/network 

config 'interface' 'loopback'
        option 'ifname' 'lo'
        option 'proto' 'static'
        option 'ipaddr' '127.0.0.1'
        option 'netmask' '255.0.0.0'
        option 'ip6addr' '0::1/128'

config 'interface' 'clients'
        option 'proto' 'static'
        option 'type' 'bridge'
        list 'ifname' 'bat0'
        list 'ifname' 'eth0'
        option 'ip6addr' '2001:470:ca42:ee:ab:0015:6DFD:71F6/64'
        option 'ip6gw' '2001:470:ca42:ee:ab::1000'
        option 'ipaddr' '192.168.1.21'
        option 'netmask' '255.255.255.0'

config 'interface' 'nmeshwifi0'
        option 'proto' 'static'
        option 'mtu' '1528'
        option 'ip6addr' 'eeab:20::1/64'
        option 'ipaddr' '192.168.20.21'
        option 'netmask' '255.255.255.0'

root@OpenWrt:~# cat /etc/config/wireless 

config 'wifi-device' 'wifi0'
        option 'type' 'atheros'
        option 'channel' '8'
        option 'disabled' '0'
        option 'txpower' '30'

config 'wifi-iface' 'meshwifi0'
        option 'device' 'wifi0'
        option 'network' 'nmeshwifi0'
        option 'sw_merge' '1'
        option 'mode' 'adhoc'
        option 'bssid' '02:aa:bb:cc:dd:ee'
        option 'ssid' 'www.eigenlab.org-www.ninux.org'
        option 'encryption' 'none'
        option 'mcast_rate' '6000'

config 'wifi-iface' 'apwifi0'
        option 'device' 'wifi0'
        option 'network' 'clients'
        option 'sw_merge' '1'
        option 'mode' 'ap'
        option 'ssid' 'eigenNet'
        option 'encryption' 'none'
        option 'maxassoc' '20'


root@OpenWrt:~# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state 
UNKNOWN qlen 1000
    link/ether 00:15:6d:fd:71:f6 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::215:6dff:fefd:71f6/64 scope link 
       valid_lft forever preferred_lft forever
3: br-clients: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state 
UNKNOWN 
    link/ether 00:15:6d:fd:71:f6 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.21/24 brd 192.168.1.255 scope global br-clients
    inet6 2001:470:ca42:ee:ab:15:6dfd:71f6/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::215:6dff:fefd:71f6/64 scope link 
       valid_lft forever preferred_lft forever
4: wifi0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state 
UNKNOWN qlen 195
    link/ieee802.11 00:15:6d:fc:71:f6 brd ff:ff:ff:ff:ff:ff
5: ath0-1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state 
UNKNOWN 
    link/ether 00:15:6d:fc:71:f6 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::215:6dff:fefc:71f6/64 scope link 
       valid_lft forever preferred_lft forever
6: ath0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1528 qdisc noqueue state 
UNKNOWN 
    link/ether 06:15:6d:fc:71:f6 brd ff:ff:ff:ff:ff:ff
    inet 192.168.20.21/24 brd 192.168.20.255 scope global ath0
    inet6 eeab:20::1/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::415:6dff:fefc:71f6/64 scope link 
       valid_lft forever preferred_lft forever
7: bat0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UNKNOWN 
    link/ether 26:da:76:30:f6:48 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::24da:76ff:fe30:f648/64 scope link 
       valid_lft forever preferred_lft forever


adding by hand br-clients to batman with batctl if add br-clients work without 
problem the same beaviour on devices where eth0 is not bridged

thanks for help

P.S. as you can see I am using packages from trunk

On Saturday 11 February 2012 17:58:28 Marek Lindner wrote:
> Hi,
> 
> > After upgrading to latest batman version on openwt batman stopped adding
> > ethernet or bridge interfaces at start...
> > 
> > it add only wireless interfaces
> > 
> > I am using backfire for the core and trunk for packages the problem is
> > related to that?
> 
> can you post your /etc/config/batman-adv and as well as the batman-adv
> package version you are using ? Did you switch to the latest and greatest ?
> 
> Cheers,
> Marek
