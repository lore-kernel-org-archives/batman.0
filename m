Return-Path: <derick.deleon@gmail.com>
MIME-Version: 1.0
From: Derick Roman De Leon Leal <derick.deleon@gmail.com>
Date: Thu, 23 Feb 2017 17:37:55 -0600
Message-ID: <CAM0tZWZ-PTLAY2k6Y4Ktfu1OuR3ME44tkFgAQaaoYP5i58GUZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Node freezes but still alive
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

First of all, thanks in advance for this fantastic mesh protocol. I am
kind of new at this so any advice is welcome.

I have a little setup with two nodes and one gateway, from time to
time one of the nodes just stops transmitting data.

I see the node on the originators list but the TQ never changes unlike
when its working OK that the TQ changes a bit during the day. The
thing is that the node is there, since the last-seen time is updating
every few seconds just like when is working normal. I have tried
changing my batman configuration with no positive results. Also, I
have changed the nodes and this is still happening.

This happens and resolves itself in a couple of hours, but it does not
happen in other setups I have with more nodes.

I tried to search the internet for this issue with zero luck. The
three devices are OM2P-HS v3 running Openwrt r49395 with batman-adv
2016.2 using BATMAN IV.

Have you guys have encountered this problem before?
Is my configuration wrong in any way?
Do you have any recommendations for me?

Below is the configuration I am using, hope this helps. Please let me
know if there is any more information I can make available to you to
help me solve this problem.

Thanks a lot for taking the time to read all this. I appreciate any
comments and feedback you can give.

Kind Regards,
Derick



Nodes Configuration: -----------------------------------------------------

batman-adv +++++++++++++++++++++

config 'mesh' 'bat0'
option 'interfaces' 'mesh'
option 'aggregated_ogms'
option 'ap_isolation' '1'
option 'bonding'
option 'fragmentation' '1'
option 'gw_bandwidth'
option 'gw_mode' 'client'
option 'gw_sel_class'
option 'log_level'
option 'orig_interval'
option 'vis_mode'
option 'bridge_loop_avoidance' '1'
option 'distributed_arp_table'
option 'multicast_mode'
option 'network_coding'
option 'hop_penalty'
option 'isolation_mark'

wireless +++++++++++++++++++++++++++

config wifi-device  radio0
option type     mac80211
option channel  6
option hwmode 11g
option path 'platform/ar934x_wmac'
option htmode HT20
option country MX

config wifi-iface wlan0
option ifname   wlan0
option device   radio0
option network  lan
option mode     sta
option encryption none
option disabled 0

config wifi-iface mesh0
option device radio0
option ifname   adhoc0
option network  mesh
option mode     adhoc
option ssid MY-SSID111
option bssid    CA:FE:CA:FE:CA:FE

network +++++++++++++++++++++++++

config interface 'loopback'
option ifname 'lo'
option proto 'static'
option ipaddr '127.0.0.1'
option netmask '255.0.0.0'

config globals 'globals'
option ula_prefix 'fdaa:8902:bcc0::/48'

config interface 'lan'
    option ifname 'eth0 bat0'
    option force_link '1'
    option type 'bridge'
    option proto 'dhcp'
    list dns 8.8.8.8
    list dns 8.8.4.4
    option peerdns 0

config interface 'wan'
    option ifname 'eth1'
    option proto 'dhcp'

config interface 'wan6'
    option ifname 'eth1'
    option proto 'dhcpv6'

config interface 'mesh'
    option proto 'batadv'
    option mtu '1528'
    option mesh 'bat0'


Gateway configuration
-------------------------------------------------------------
everything is the same as in the nodes configuration but batman-adv file.

config 'mesh' 'bat0'
option 'interfaces' 'mesh'
option 'aggregated_ogms'
option 'ap_isolation' '1'
option 'bonding'
option 'fragmentation' '1'
option 'gw_bandwidth'
option 'gw_mode' 'server'
option 'gw_sel_class'
option 'log_level'
option 'orig_interval'
option 'vis_mode'
option 'bridge_loop_avoidance' '1'
option 'distributed_arp_table'
option 'multicast_mode'
option 'network_coding'
option 'hop_penalty'
option 'isolation_mark'
