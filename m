Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Batman_V Originator Loop Issue
From: lavincent15@gmail.com
Date: Tue, 07 Jul 2020 19:47:31 -0000
Message-ID: <20200707194731.1176.30400@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Running batctl 2020.1-openwrt-1 [batman-adv: 2020.1-openwrt-2]

When running a two node network with one node connected to my lan and the other operating as an access point, my network works great. I can connect clients to my batman nodes and access my LAN.

When booting up a third node. My network works for 1 minute, then breaks down. My LAN cannot ping any of the batman nodes anymore.

I keep receiving messages like this: "[ 2900.755655] br-lan: received packet on bat0 with own address as source address (addr:8c:ae:4c:db:14:5c, vlan:0)" which signifies a bridge loop I think.

My originator messages look wrong as I can see my host originator messages along with all the neigbor nodes:

root@OpenWrt:/etc/config# batctl o -n
[B.A.T.M.A.N. adv 2020.1-openwrt-2, MainIF/MAC: mesh0/00:30:1a:4e:b8:26 (bat0/f2:07:f1:5f:e0:78 BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
 * 00:30:1a:4e:b8:18    0.570s (       86.7) 00:30:1a:4e:b8:2e [     mesh0]
   00:30:1a:4e:b8:18    0.570s (       21.6) 00:30:1a:4e:b8:18 [     mesh0]
 * 00:30:1a:4e:b8:2e    1.510s (      212.6) 00:30:1a:4e:b8:2e [     mesh0]
   00:30:1a:4e:b8:2e    1.510s (       38.9) 00:30:1a:4e:b8:18 [     mesh0]
   00:30:1a:4e:b8:26    1.510s (       38.9) 00:30:1a:4e:b8:18 [     mesh0]
 * 00:30:1a:4e:b8:26    1.510s (      108.9) 00:30:1a:4e:b8:2e [     mesh0]

root@OpenWrt:/etc/config# batctl n -n
[B.A.T.M.A.N. adv 2020.1-openwrt-2, MainIF/MAC: mesh0/00:30:1a:4e:b8:26 (bat0/f2:07:f1:5f:e0:78 BATMAN_V)]
IF             Neighbor              last-seen
00:30:1a:4e:b8:2e    0.490s (      179.0) [     mesh0]
00:30:1a:4e:b8:18    0.380s (       79.2) [     mesh0]



Here is my /etc/config/network:
config interface 'loopback'
        option ifname 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config globals 'globals'
        option ula_prefix 'fdc4:e092:8929::/48'

config interface 'lan'
        option type 'bridge'
        option proto 'static'
        option ipaddr '192.168.0.32'
        option netmask '255.255.255.0'
        option ip6assign '60'
        option gateway '192.168.0.1'
        list dns '8.8.8.8'
        option ifname 'bat0 eth0'

config interface 'nwi_mesh0'
        option mtu '2304'
        option proto 'batadv_hardif'
        option master 'bat0'

config interface 'bat0'
        option proto 'batadv'
        option routing_algo 'BATMAN_V'
        option aggregated_ogms '1'
        option ap_isolation '0'
        option bonding '0'
        option fragmentation '1'
        option gw_mode 'server'
        option log_level '0'
        option orig_interval '1000'
        option bridge_loop_avoidance '1'
        option distributed_arp_table '1'
        option multicast_mode '1'
        option network_coding '0'
        option hop_penalty '30'
        option isolation_mark '0x00000000/0x00000000'


And here is my /etc/config/wireless
root@OpenWrt:/etc/config# cat wireless
config wifi-device 'radio0'
        option type 'mac80211'
        option channel '36'
        option hwmode '11a'
        option path 'soc0/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0'
        option htmode 'VHT80'

config wifi-iface 'mesh0'
        option device 'radio0'
        option ifname 'mesh0'
        option network 'nwi_mesh0'
        option mode 'mesh'
        option mesh_fwding '0'
        option mesh_id 'batman_mesh'
        option encryption 'none'

config wifi-iface 'wifinet0'
        option device 'radio0'
        option mode 'ap'
        option ssid 'N2-Lander'
        option encryption 'psk2'
        option key 'finnjamin'
        option ifname 'wlan0'
        option network 'lan'


Any and all help is greatly appreciated
