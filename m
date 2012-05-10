Return-Path: <pedroncr@sapo.pt>
Date: Thu, 10 May 2012 23:16:49 +0100
Message-ID: <20120510231649.Horde.mtJYKOanEAJPrD5R7pqW_NA@beta.mail.sapo.pt>
From: Pedro Nuno Costa Rodrigues <pedroncr@sapo.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Fwd: Batman-adv simple configuration example
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


Hello again!

First of all thank's Sven Eckelmann and Guido Iribarren for your  
replies and for the attention in my issue.

I would like to say that i already found the solution, as you can see below=
.
I couldn't split the radios on the wireless network, because i'm using  
only chips broadcom (and it isn't possible to have more than 1 radio  
interface). When i said that i only need a simple two router network,  
doesn't mean that i only going to use 2 routers... the gold is to use  
many of them in a mesh network, but i needed to start with a simple 2  
mesh configuration router configuration.

After some configuration, it worked correctly in ad-hoc mode... and to  
the clients access the mesh through wireless i=B4m going to use another  
router linked by cable (ethernet) using lan ports, with dd-wrt  
firmware (or something like that) as a AP -access point (only used to  
forward the signal to wireless). By cable it isn't necessary an access  
point, only plug the cable in batman-adv node.



I'm using backfire (openwrt build):

cat /home/pedro/backfire/feeds/packages/net/batman-adv/Makefile | grep 2012
# Copyright (C) 2010-2012 OpenWrt.org
PKG_VERSION:=3D2012.0.0
BATCTL_VERSION:=3D2012.0.0


The batman-adv-devel version didn't work...:

In the:https://dev.openwrt.org/wiki/GetSource

downloaded:=A0svn co svn://svn.openwrt.org/openwrt/trunk/

with this feed in feeds.conf.default:
src-svn batman http://downloads.open-mesh.org/svn/openwrt-feed/

(i know this is a issue related with openwrt, but i must explain how i did)

this is the version of the batman-adv-devel:
cat /home/pedro/trunk/feeds/packages/net/batman-adv/Makefile | grep 2012
PKG_VERSION:=3D2012.1.0
BATCTL_VERSION:=3D2012.1.0

root@OpenWrt:~# batctl -v
batctl 54b7d54 [batman-adv: master-b0f3829]

the error was using the same configurations file (below) that worked  
with batman-adv backfire stable release:
root@OpenWrt:/lib/batman-adv# batman-adv start
/usr/sbin/batman-adv: eval: line 1: can't  
create/sys/class/net/bat0/mesh/orig_interval: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/log_level: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create  
/sys/class/net/bat0/mesh/bonding: nonexistent  
directory/usr/sbin/batman-adv: eval: line 1: can't create  
/sys/class/net/bat0/mesh/fragmentation: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create  
/sys/class/net/bat0/mesh/gw_bandwidth: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create  
/sys/class/net/bat0/mesh/gw_mode: nonexistent  
directory/usr/sbin/batman-adv: eval: line 1: can't create  
/sys/class/net/bat0/mesh/vis_mode: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create  
/sys/class/net/bat0/mesh/ap_isolation: nonexistent directory




I tryed to analyze if the problem was with the =A0"crc16" lib in the  
configuration files, but it wasn't... the configuration files were  
like the backfire stable release...

pedro@rodrigues:~/trunk/feeds/packages/net/batman-adv/files/lib/batman-adv$=
 vi  
config.sh=A0
#!/bin/sh
bat_load_module(){
=A0 =A0 =A0 =A0 [ -d "/sys/module/batman_adv/" ] && return

=A0 =A0 =A0 =A0 . /etc/functions.sh=A0
   =A0 =A0 =A0 load_modules /etc/modules.d/*-crc16 /etc/modules.d/*-batman-=
adv*}


etc..........

This is a issue to analyze...

Going back to the stable release that worked fine:
this is the server file of batman-adv configuration(with # comment is  
the client version modifications):

root@OpenWrt:/etc/config# vi batman-adv
config 'mesh' 'bat0'=A0 =A0 =A0 =A0
      option 'interfaces' 'wifi'
      option 'aggregated_ogms' '1'
  =A0 =A0 option 'ap_isolation' '0'
  =A0 =A0 option 'bonding' '0'=A0
  =A0 =A0 option 'fragmentation' '1'
  =A0 =A0 option 'gw_bandwidth' '5mbit/1024kbit' #comented line in client  
mode=A0 =A0        =A0 =A0  option 'gw_mode' 'server' =A0 =A0 =A0 =A0 =A0 =
=A0 =A0#'client'=A0  
=A0 =A0 =A0 #option 'gw_sel_class' =A0 =A0=A0 #option 'gw_sel_class' '2'=A0
  =A0 =A0 option 'log_level' 'all'
  =A0 =A0 option 'orig_interval' '1000'
  =A0 =A0 option 'vis_mode' 'server' =A0 =A0 =A0 =A0 =A0 =A0 #option 'vis_m=
ode' 'client'
------------------------------------

this is the dhcp configuration:


root@OpenWrt:/etc/config# vi dhcp
config dnsmasq
=A0 =A0 =A0 =A0 option domainneeded =A0 =A0 1
=A0 =A0 =A0 =A0 option boguspriv =A0 =A0 =A0 =A01
=A0 =A0 =A0 =A0 option filterwin2k =A0 =A0 =A00 =A0# enable for dial on dem=
and
=A0 =A0 =A0 =A0 option localise_queries 1
=A0 =A0 =A0 =A0 option rebind_protection 1 =A0# disable if upstream must se=
rve  
RFC1918 addresses
=A0 =A0 =A0 =A0 option rebind_localhost 1 =A0# enable for RBL checking and =
 
similar services=A0   =A0 =A0 =A0 #list rebind_domain example.lan =A0# whit=
elist  
RFC1918 responses for domains
     =A0 =A0 option local =A0 =A0'/lan/'
=A0 =A0 =A0 =A0 option domain =A0 'lan'
=A0 =A0 =A0 =A0 option expandhosts =A0 =A0 =A01
=A0 =A0 =A0 =A0 option nonegcache =A0 =A0 =A0 0
=A0 =A0 =A0 =A0 option authoritative =A0 =A01
=A0 =A0 =A0 =A0 option readethers =A0 =A0 =A0 1
=A0 =A0 =A0 =A0 option leasefile =A0 =A0 =A0 =A0'/tmp/dhcp.leases'
=A0 =A0 =A0 =A0 option resolvfile =A0 =A0 =A0 '/tmp/resolv.conf.auto'
=A0 =A0 =A0 =A0 #list server =A0 =A0 =A0 =A0 =A0 =A0'/mycompany.local/1.2.3=
.4'
=A0 =A0 =A0 =A0 #option nonwildcard =A0 =A0 1
=A0 =A0 =A0 =A0 #list interface =A0 =A0 =A0 =A0 br-lan
=A0 =A0 =A0 =A0 #list notinterface =A0 =A0 =A0lo
=A0 =A0 =A0 =A0 #list bogusnxdomain =A0 =A0 '64.94.110.11'

config dhcp lan
=A0 =A0 =A0 =A0 option interface =A0 =A0 =A0 =A0lan
=A0 =A0 =A0 =A0 option start =A0 =A051
=A0 =A0 =A0 =A0 option limit =A0 =A070
=A0 =A0 =A0 =A0 #option leasetime =A0 =A0 =A0 12h
	option force	1 =A0 #this line is only for server router, the=A0=A0 =A0 =A0=
 =A0 =A0  
=A0 =A0  =A0 =A0 =A0 =A0 =A0 =A0 =A0 #one who is going to distribute the IP=
's to the  
clients=A0

config dhcp wan
=A0 =A0 =A0 =A0 option interface =A0 =A0 =A0 =A0wan
=A0 =A0 =A0 =A0 option ignore =A0 1
____________________________________

this is the network file configuration:

root@OpenWrt:/etc/config# vi network
#### VLAN configurationconfig switch eth0
=A0 =A0 =A0 =A0 option enable =A0 1

config switch_vlan eth0 0
=A0 =A0 =A0 =A0 option device =A0 "eth0"
=A0 =A0 =A0 =A0 option vlan =A0 =A0 0
=A0 =A0 =A0 =A0 option ports =A0 =A0"1 2 3 4 5"

config switch_vlan eth0_1
=A0 =A0 =A0 =A0 option device =A0 "eth0"
=A0 =A0 =A0 =A0 option vlan =A0 =A0 1
=A0 =A0 =A0 =A0 option ports =A0 =A0"0 5" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=A0

#### Loopback configuration
config interface loopback
=A0 =A0 =A0 =A0 option ifname =A0 "lo"
=A0 =A0 =A0 =A0 option proto =A0 =A0static
=A0 =A0 =A0 =A0 option ipaddr =A0 127.0.0.1
=A0 =A0 =A0 =A0 option netmask =A0255.0.0.0

#### LAN configuration
config interface lan
=A0 =A0 =A0 =A0 option type =A0 =A0 bridge
=A0 =A0 =A0 =A0 option ifname =A0 "eth0.0 bat0 wlan0"
=A0 =A0 =A0 =A0 option proto =A0 =A0static
=A0 =A0 =A0 =A0 option ipaddr =A0 10.3.1.1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#=
10.3.1.X for other routers
=A0 =A0 =A0 =A0 option netmask =A0255.255.255.0
=A0 =A0 =A0 =A0 option broadcast 10.3.1.255
=A0 =A0 =A0 =A0 option mtu =A0 =A0 =A01500

#### WLAN configuration
config interface =A0 =A0 =A0 =A0wifi
=A0 =A0 =A0 =A0 option proto =A0 =A0none
=A0 =A0 =A0 =A0 option ifname =A0 "wlan0"
=A0 =A0 =A0 =A0 #option ipaddr =A0 10.1.1.1=A0 =A0 =A0 =A0 #option netmask =
=A0255.255.255.0
=A0 =A0 =A0 =A0 option mtu =A0 =A0 =A01528

#### WAN configuration
config interface =A0 =A0 =A0 =A0wan
=A0 =A0 =A0 =A0 option ifname =A0 "eth0.1"
=A0 =A0 =A0 =A0 option proto =A0 =A0dhcp =A0

________________________________-
this is the wireless file configuration:

root@OpenWrt:/etc/config# vi wireless
config wifi-device =A0radio0
=A0 =A0 =A0 =A0 option type =A0 =A0 mac80211
=A0 =A0 =A0 =A0 option channel =A06
=A0 =A0 =A0 =A0 option phy =A0 =A0 =A0phy0
=A0 =A0 =A0 =A0 option hwmode =A0 11g
=A0 =A0 =A0 =A0 option country =A0PT
=A0 =A0 =A0 =A0 option txpower =A020
=A0 =A0 =A0 =A0 option disabled 0


config wifi-iface
=A0 =A0 =A0 =A0 option device =A0 radio0
=A0 =A0 =A0 =A0 option network =A0wifi
=A0 =A0 =A0 =A0 option mode =A0 =A0 adhoc
=A0 =A0 =A0 =A0 option ssid =A0 =A0 PR
=A0 =A0 =A0 =A0 option bssid XX:XX:XX:XX:XX:XX =A0 #the bssid must be the s=
ame  
in all routers
=A0 =A0 =A0 =A0 option encryption none


______________________________________-

all these configuration files are located in "/etc/config".

As you can see the mesh interface is the wireless "wifi":
the bat0 interface it appears only in the lan bridge;
and it worked fine.

root@OpenWrt:/etc/config# batctl if
wlan0: active

root@OpenWrt:/etc/config# batctl o
=A0[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0/00:13:10:7c:da:73  
(bat0)]=A0 Originator =A0 =A0 =A0last-seen (#/255) =A0 =A0 =A0 =A0 =A0 Next=
hop  
[outgoingIF]: =A0 Potential nexthops ...00:06:25:00:63:7b =A0 =A00.228s =A0=
  
(246) 00:06:25:00:63:7b [ =A0 =A0 wlan0]: 00:06:25:00:63:7b (246)

root@OpenWrt:/etc/config# batctl vd dot
digraph {
	"00:13:10:7c:da:73" -> "00:06:25:00:63:7b" [label=3D"1.000"]
	"00:13:10:7c:da:73" -> "76:0f:22:e4:5f:d8" [label=3D"TT"]
	subgraph "cluster_00:13:10:7c:da:73" {
		"00:13:10:7c:da:73" [peripheries=3D2]
	}
	"00:06:25:00:63:7b" -> "00:13:10:7c:da:73" [label=3D"1.214"]
	"00:06:25:00:63:7b" -> "56:71:dc:31:13:2c" [label=3D"TT"]
	subgraph "cluster_00:06:25:00:63:7b" {
		"00:06:25:00:63:7b" [peripheries=3D2]
	}
}

=A0using the xdot ubuntu application it made the figure (.png) that  
shows the batman-adv mesh picture.

The only thing that didn't start with the boot of the routers was the:
-option 'gw_bandwidth' '5mbit/1024kbit'
-option 'gw_mode' 'server'
-option 'vis_mode' 'server'

it was necessary to start manually... the rest worked weel in the  
boot.Just one thing before i forget... the router "server" must be the  
first one to start (switch on)... we must wait until it finish the  
boot and then we can start the client router...

(the problem is probably the definition who is the master -IP  
distribution and so on...)(i used the "option force 1 in the dhcp  
configuration file, but didn't worked...) if we start the client first  
it will not be possible to access the internet, supposed the ISP is  
connected with the "server" router... the ad-hoc mode and the mesh  
network works the same way (works fine)...

is a issue to study (yes i know that is a openwrt problem, and there  
are a bunch of openwrt problems here).My gold is to contribute with  
something here, and to get my job done as well.

For now i stay here, and thank you for your lights and publications,  
they helped me a lot!!


Best regards,Pedro Rodrigues - Portugal


