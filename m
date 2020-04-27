Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Oguzhan Kayhan <oguzhan@kayhan.name.tr>
Date: Mon, 27 Apr 2020 15:26:40 +0300
Message-ID: <CANKYHpeiWj7w2KEnkEfjUHWKfbhEAj7kMVE5hL5xv6O_1ZVFwg@mail.gmail.com>
Subject: configuration issue
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello
I am running batman over a openwrt 18.06
default batman config over this firmware is batman-adv 2017.4

I have two systems present..
One board is with 802.11n radio. other is 802.11ac radio
This is the only difference..same image compiled running on both devices..


On 802.11n radio set..
config is as:
batman-adv:
config 'mesh' 'bat0'
        option 'aggregated_ogms'
        option 'ap_isolation'
        option 'bonding'
        option 'fragmentation'
        option 'gw_bandwidth'
        option 'gw_mode'
        option 'gw_sel_class'
        option 'log_level'
        option 'orig_interval'
        option 'vis_mode'
        option 'bridge_loop_avoidance'
        option 'distributed_arp_table'
        option 'multicast_mode'
        option 'network_coding'
        option 'hop_penalty'
        option 'isolation_mark'

wireless :
config wifi-iface
        option device 'radio0'
        option ifname 'mesh0'
        option network 'mesh'
        option mode 'adhoc'
        option ssid 'mesh'
        option bssid '02:CA:FE:CA:CA:40'
        option mcast_rate '18000'


network:
config interface 'lan'
        option type 'bridge'
        option ifname 'eth0 bat0'
        option proto 'static'
....
config interface 'mesh'
        option mtu '1532'
        option proto 'batadv'
        option mesh 'bat0'

config interface 'bat'
        option ifname 'bat0'
        option proto 'static'
        option mtu '1500'
        option ipaddr '172.0.0.10'
        option netmask '255.255.255.0'


This configuration works fine..
But if I run same config on the second node with 802.11ac radio.. it fails..
So I dig around and changed the config as follows.. And it started to work..
batman-adv is same..no difference

wireless:
config wifi-iface 'wmesh'
        option device 'radio0'
        option ifname 'adhoc0'
        option network 'bat0_hardif_wlan'
        option mode 'adhoc'
        option ssid 'mesh'
        option mcast_rate '18000'
        option bssid '02:CA:FE:CA:CA:40'

network:
config interface 'bat0_hardif_wlan'
        option mtu '1532'
        option proto 'batadv'
        option mesh 'bat0'

config interface 'bat0_hardif_eth0'
        option mtu '1532'
        option proto 'batadv'
        option mesh 'bat0'
        option ifname 'eth0'




I have two questions so far..

Why the first config does not work over second system..(Wifi works
fine but. for mesh. i needed to change the config like this)

Second question.. I can live with different config.. Ok..
But I want to use eth0 and eth2 and mesh network as a bridge...
But whenever i add any of this interfaces on bridge.. batman-adv fails..
What am I missing???
