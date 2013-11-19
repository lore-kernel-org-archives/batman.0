Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
From: tjhowse <tjhowse@gmail.com>
Date: Tue, 19 Nov 2013 13:36:16 +1000
Message-ID: <CAAxzKbRaF_a5UZdZUUQXmgO_zEp=Fe2_AdTAfSOKrTX=rFpq2A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Automatically starting adaptors at boot
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello Ladies and Gentlemen,

This might be a question better suited to the OpenWRT list, but I
figure it would've been solved better here.

I've got a two-node mesh set up and working well. Config files are
below. I have some minor woes though. Each time one of the nodes boots
up I must:

brctl addif br-lan bat0
ifconfig bat0 up

...before traffic starts to flow between clients connected to the
wlan0 radios of each node. What's the best way of having this happen
automatically? I assume there's a better way than having an init
script run those commands at boot.

Please note that I'm somewhat of a networking novice, so if anything
below seems super dumb, please say so.

Thanks,
Travis.

radio0 is 2.4GHz, for connecting to clients.
radio1 is 5GHz, for the mesh interconnects.

wireless:
config wifi-device  radio0
option type     mac80211
option channel  11
option hwmode 11ng
option path 'platform/ar934x_wmac'
option htmode HT20
list ht_capab LDPC
list ht_capab SHORT-GI-20
list ht_capab SHORT-GI-40
list ht_capab TX-STBC
list ht_capab RX-STBC1
list ht_capab DSSS_CCK-40
# REMOVE THIS LINE TO ENABLE WIFI:
# option disabled 1

config wifi-iface
option device   radio0
option channel 10
option network  lan
option mode     ap
option ssid     HWMesh2-Clients-10
option encryption psk2
option key 3141592653

config wifi-device  radio1
option type     mac80211
option channel  36
option hwmode 11na
option path 'pci0000:00/0000:00:00.0'
option htmode HT20
list ht_capab LDPC
list ht_capab SHORT-GI-20
list ht_capab SHORT-GI-40
list ht_capab TX-STBC
list ht_capab RX-STBC1
list ht_capab DSSS_CCK-40
# REMOVE THIS LINE TO ENABLE WIFI:
# option disabled 1

config wifi-iface wmesh
option device   radio1
option ifname adhoc0
option network  mesh
option mode     adhoc
option ssid     HWMesh2-Backbone
option encryption psk2
option key 3141592653

network:

config interface 'loopback'
option ifname 'lo'
option proto 'static'
option ipaddr '127.0.0.1'
option netmask '255.0.0.0'

config globals 'globals'
option ula_prefix 'fd87:bd28:e37e::/48'

config interface 'lan'
option ifname 'eth0.1'
#option ifname 'bat0'
#option ifname 'wlan0'
option type 'bridge'
option proto 'static'
option ipaddr '192.168.1.1'
option netmask '255.255.255.0'
option ip6assign '60'

config interface 'wan'
option ifname 'eth0.2'
option proto 'dhcp'

config interface 'wan6'
option ifname '@wan'
option proto 'dhcpv6'

config switch
option name 'switch0'
option reset '1'
option enable_vlan '1'

config switch_vlan
option device 'switch0'
option vlan '1'
option ports '0t 2 3 4 5'

config switch_vlan
option device 'switch0'
option vlan '2'
option ports '0t 1'

config interface 'mesh'
option ifname adhoc0
option mtu 1528
option proto batadv
option mesh bat0

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
option 'network_coding'
option 'hop_penalty'

# yet another batX instance
# config 'mesh' 'bat5'
# option 'interfaces' 'second_mesh'
