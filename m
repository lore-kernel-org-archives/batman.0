Return-Path: <gmazzurco89@gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date: Sat, 11 Feb 2012 18:37:22 +0100
Message-ID: <1728958.oIGLzpvozS@g10h4cklab>
In-Reply-To: <201202120120.10360.lindner_marek@yahoo.de>
References: <1807712.xKAsDcUsSn@g10h4cklab> <1590796.df4KKcFED8@g10h4cklab>
	<201202120120.10360.lindner_marek@yahoo.de>
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

Yes that configuration worked in the past here is info from a not recently 
flashed device in ninux pisa and as you can see both eth0 and ath0 are added

moreover use of list in cases like that is the recommended openwrt beaviour so 
if batman package is not working with list it should be fixed ;)

root@OpenWrt:~# cat /etc/eigennet/version 
Build Info:

OpenWrt
Path: .
URL: svn://svn.openwrt.org/openwrt/branches/backfire
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 29322
Node Kind: directory
Schedule: normal
Last Changed Author: nico
Last Changed Rev: 29322
Last Changed Date: 2011-11-24 00:24:59 +0100 (Thu, 24 Nov 2011)

Feeds

packages
Path: .
URL: svn://svn.openwrt.org/openwrt/packages
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 29322
Node Kind: directory
Schedule: normal
Last Changed Author: nico
Last Changed Rev: 29290
Last Changed Date: 2011-11-21 23:18:50 +0100 (Mon, 21 Nov 2011)

eigennet
URL: git://gitorious.org/eigennet/packages.git
commit cd2a82fcfaf711376c0364510d10857708ed36af
Author: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date:   Sun Nov 20 20:22:50 2011 +0100

    really stop openwrt firewall if eigennet.network.firewall=0
root@OpenWrt:~# cat /etc/config/batman-adv 

config 'mesh' 'bat0'
        option 'fragmentation' '0'
        list 'interfaces' 'eth0'
        list 'interfaces' 'nmeshwifi0'

root@OpenWrt:~# batctl if
eth0: active
ath0: active
root@OpenWrt:~# cat /etc/config/network 

config 'interface' 'loopback'
        option 'ifname' 'lo'
        option 'proto' 'static'
        option 'ipaddr' '127.0.0.1'
        option 'netmask' '255.0.0.0'
        option 'ip6addr' '0::1/128'

config 'interface' 'bat0'
        option 'proto' 'static'
        option 'ifname' 'bat0'
        option 'ip6addr' '2001:470:ca42:ee:ab:0015:6D73:480D/64'
        option 'ip6gw' '2001:470:ca42:ee:ab::1000'
        option 'ipaddr' '192.168.1.21'
        option 'netmask' '255.255.255.0'

config 'interface' 'eth0'
        option 'ifname' 'eth0'
        option 'proto' 'static'
        option 'ip6addr' 'eeab:10::1/64'
        option 'ipaddr' '192.168.10.21'
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
        option 'country' '860'

config 'wifi-iface' 'meshwifi0'
        option 'device' 'wifi0'
        option 'network' 'nmeshwifi0'
        option 'sw_merge' '1'
        option 'mode' 'adhoc'
        option 'bssid' '02:aa:bb:cc:dd:ee'
        option 'ssid' 'www.eigenlab.org-www.ninux.org'
        option 'encryption' 'none'
        option 'mcast_rate' '6000'

On Sunday 12 February 2012 01:20:09 Marek Lindner wrote:
> On Sunday, February 12, 2012 00:51:53 Gioacchino Mazzurco wrote:
> > root@OpenWrt:~# cat /etc/config/batman-adv
> > 
> > config 'mesh' 'bat0'
> > 
> >         option 'fragmentation' '1'
> >         option 'gw_mode' 'client'
> >         list 'interfaces' 'clients'
> >         list 'interfaces' 'nmeshwifi0'
> 
> Are you sure this configuration ever worked ?
> 
> The default config looks like this:
> 
> config 'mesh' 'bat0'
>         option 'interfaces' 'mesh'
>         option 'aggregated_ogms'
>         option 'ap_isolation'
>         option 'bonding'
>         option 'fragmentation'
>         option 'gw_bandwidth'
>         option 'gw_mode'
>         option 'gw_sel_class'
>         option 'log_level'
>         option 'orig_interval'
>         option 'vis_mode'
> 
> # yet another batX instance
> # config 'mesh' 'bat5'
> #       option 'interfaces' 'second_mesh'
> 
> 
> Pay close attention to the "interfaces" option - it is not a list and never
> was.
> 
> Regards,
> Marek
