Return-Path: <umut.deniz@gmail.com>
MIME-Version: 1.0
References: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
In-Reply-To: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
From: umut deniz <umut.deniz@gmail.com>
Date: Sun, 24 Feb 2019 23:48:18 +0300
Message-ID: <CAHh66V-79d--F=d-Rx+af6Vffm09bs=-EOTiK4dtB3+r-E91Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] Fwd: nodes start disappearing after a certain node
 count
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

hi,

this mail would be my first post to the list so for a starter i would like
to thank to the project owners, contributors and the community for the great
work being done and appreciate the effort and time being spent for this piece of
software like it is said software is hard.

the main reason i am writing is as follows;
for about 10 months i have been experimenting with batman on various platforms
my current platform is ti's beagleboneblack wireless board running openwrt
distribution (the required bbbw dtb and wl1835 driver firmware applied) with
batman enabled and configured. with this high level description of the
components i am able to build a mesh network 6 nodes (i.e. bbbw cards) but as
soon as i introduce a 7th card into the network batman mesh becomes unresponsive
as the last seen times start to increase and finally, after 200 seconds all the
nodes drops from the originator and neighbor tables which could be inspected
with < :#batctl o> and < :#batctl n> commands respectively. all the cards are on
the same table and well powered.

i would like to give some details about the
configurations of the cards which are identical except the ip addresses

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# cat /etc/config/wireless

config wifi-device 'radio0'
        option type 'mac80211'
        option channel '11'
        option hwmode '11g'
        option path
'platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1/usb1/1-1/1-1:1.0'
        option htmode 'HT20'
        option disabled '1'

config wifi-iface 'default_radio0'
        option device 'radio0'
        option network 'wifi'
        option mode 'mesh'
        option ssid 'my-mesh-network'
        option mesh_id '02:12:34:56:78:9A'

config wifi-device 'radio1'
        option type 'mac80211'
        option channel '3'
        option hwmode '11n'
        option path
'platform/ocp/47810000.mmc/mmc_host/mmc2/mmc2:0001/mmc2:0001:2/wl18xx.0.auto'
        option htmode 'HT40+'
        option disabled '0'

config wifi-iface 'wmesh'
        option device 'radio1'
        option ifname 'adhoc0'
        option network 'bat0_hardif_wlan'
        option mode 'mesh'
        option ssid 'mesh'
        option mesh_fwding '0'
        option 'mcast_rate' '18000'
        option bssid '02:12:34:56:78:9A'

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# cat /etc/config/network

config interface 'loopback'
        option ifname 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config globals 'globals'
        option ula_prefix 'fd99:5d77:fecc::/48'

config interface 'bat0_hardif_wlan'
        option ifname 'adhoc0'
        option mtu '2304'
        option proto 'batadv'
        option mesh 'bat0'
        option ipaddr '192.168.3.100'
        option netmask '255.255.255.0'
        option routing_algo 'BATMAN_IV'
        option ap_isolation '1'

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# cat /etc/config/batman-adv

config 'mesh' 'bat0'
        option 'aggregated_ogms' 1
        option 'ap_isolation' 1
        #option 'bonding' 0
        option 'fragmentation' 1
        #option 'gw_bandwidth' '10000/2000'
        option 'gw_mode' 'off'
        #option 'gw_sel_class' 20
        option 'log_level' 15
        option 'orig_interval' 1000
        option 'bridge_loop_avoidance' 0
        option 'distributed_arp_table' 0
        option 'multicast_mode' 0
        optiion 'network_coding' 0
        option 'hop_penalty' 15
        #option 'isolation_mark' '0x00000000/0x00000000'

# yet another batX instance
# config 'mesh' 'bat5'

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# ifconfig
adhoc0    Link encap:Ethernet  HWaddr 38:D2:69:DC:DE:43
          inet6 addr: fe80::3ad2:69ff:fedc:de43/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:2304  Metric:1
          RX packets:5924 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3707 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:370268 (361.5 KiB)  TX bytes:327332 (319.6 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:480 errors:0 dropped:0 overruns:0 frame:0
          TX packets:480 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:39360 (38.4 KiB)  TX bytes:39360 (38.4 KiB)

///////////////////// 6 node setup with 5 direct neighbors /////////////////////
root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv openwrt-2019.0-0, MainIF/MAC:
adhoc0/38:d2:69:dc:de:43 (bat0/6a:40:89:aa:93:a0 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
   38:d2:69:e0:c3:0d    0.010s   (218) 38:d2:69:e0:5e:de [    adhoc0]
   38:d2:69:e0:c3:0d    0.010s   (211) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:c3:0d    0.010s   (214) 38:d2:69:e0:8f:87 [    adhoc0]
   38:d2:69:e0:c3:0d    0.010s   (222) 38:d2:69:e0:71:73 [    adhoc0]
 * 38:d2:69:e0:c3:0d    0.010s   (255) 38:d2:69:e0:c3:0d [    adhoc0]
   98:84:e3:f0:a5:38    0.700s   (225) 38:d2:69:e0:c3:0d [    adhoc0]
   98:84:e3:f0:a5:38    0.700s   (221) 38:d2:69:e0:5e:de [    adhoc0]
   98:84:e3:f0:a5:38    0.700s   (225) 38:d2:69:e0:71:73 [    adhoc0]
   98:84:e3:f0:a5:38    0.700s   (222) 38:d2:69:e0:8f:87 [    adhoc0]
 * 98:84:e3:f0:a5:38    0.700s   (247) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:8f:87    0.030s   (214) 38:d2:69:e0:c3:0d [    adhoc0]
   38:d2:69:e0:8f:87    0.030s   (221) 38:d2:69:e0:5e:de [    adhoc0]
   38:d2:69:e0:8f:87    0.030s   (217) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:8f:87    0.030s   (225) 38:d2:69:e0:71:73 [    adhoc0]
 * 38:d2:69:e0:8f:87    0.030s   (255) 38:d2:69:e0:8f:87 [    adhoc0]
   38:d2:69:e0:71:73    0.460s   (200) 38:d2:69:e0:c3:0d [    adhoc0]
   38:d2:69:e0:71:73    0.460s   (197) 38:d2:69:e0:5e:de [    adhoc0]
   38:d2:69:e0:71:73    0.460s   (200) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:71:73    0.460s   (210) 38:d2:69:e0:8f:87 [    adhoc0]
 * 38:d2:69:e0:71:73    0.460s   (255) 38:d2:69:e0:71:73 [    adhoc0]
   38:d2:69:e0:5e:de    0.180s   (225) 38:d2:69:e0:c3:0d [    adhoc0]
   38:d2:69:e0:5e:de    0.180s   (215) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:5e:de    0.180s   (218) 38:d2:69:e0:8f:87 [    adhoc0]
   38:d2:69:e0:5e:de    0.180s   (225) 38:d2:69:e0:71:73 [    adhoc0]
 * 38:d2:69:e0:5e:de    0.180s   (251) 38:d2:69:e0:5e:de [    adhoc0]

 root@OpenWrt:/# batctl n
[B.A.T.M.A.N. adv openwrt-2019.0-0, MainIF/MAC:
adhoc0/38:d2:69:dc:de:43 (bat0/6a:40:89:aa:93:a0 BATMAN_IV)]
IF             Neighbor              last-seen
       adhoc0     38:d2:69:e0:c3:0d    0.160s
       adhoc0     38:d2:69:e0:5e:de    0.320s
       adhoc0     98:84:e3:f0:a5:38    0.830s
       adhoc0     38:d2:69:e0:8f:87    0.030s
       adhoc0     38:d2:69:e0:71:73    0.630s

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# iw dev adhoc0 station dump
Station 38:d2:69:e0:71:73 (on adhoc0)
        inactive time:  80 ms
        rx bytes:       1775733
        rx packets:     22623
        tx bytes:       539
        tx packets:     7
        tx retries:     0
        tx failed:      0
        rx drop misc:   12797
        signal:         0 dBm
        signal avg:     -21 dBm
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    27.343Mbps
        mesh llid:      32171
        mesh plid:      13983
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 491 seconds
Station 38:d2:69:e0:8f:87 (on adhoc0)
        inactive time:  20 ms
        rx bytes:       1693321
        rx packets:     21651
        tx bytes:       329
        tx packets:     4
        tx retries:     0
        tx failed:      0
        rx drop misc:   12018
        signal:         0 dBm
        signal avg:     -25 dBm
        Toffset:        18446744071111214636 us
        tx bitrate:     1.0 MBit/s
        expected throughput:    121.93Mbps
        mesh llid:      30373
        mesh plid:      56485
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      UNKNOWN
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 489 seconds
Station 98:84:e3:f0:a5:38 (on adhoc0)
        inactive time:  50 ms
        rx bytes:       1640523
        rx packets:     21040
        tx bytes:       716
        tx packets:     8
        tx retries:     0
        tx failed:      0
        rx drop misc:   11384
        signal:         0 dBm
        signal avg:     -27 dBm
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    140.625Mbps
        mesh llid:      25917
        mesh plid:      65422
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 487 seconds
Station 38:d2:69:e0:5e:de (on adhoc0)
        inactive time:  70 ms
        rx bytes:       1580918
        rx packets:     20324
        tx bytes:       480
        tx packets:     6
        tx retries:     0
        tx failed:      0
        rx drop misc:   10662
        signal:         0 dBm
        signal avg:     -34 dBm
        Toffset:        18446744071107370820 us
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    140.625Mbps
        mesh llid:      52541
        mesh plid:      55210
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 485 seconds
Station 38:d2:69:e0:c3:0d (on adhoc0)
        inactive time:  60 ms
        rx bytes:       1605955
        rx packets:     20603
        tx bytes:       480
        tx packets:     6
        tx retries:     0
        tx failed:      0
        rx drop misc:   11110
        signal:         0 dBm
        signal avg:     -26 dBm
        Toffset:        18446744071104088264 us
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    140.625Mbps
        mesh llid:      36132
        mesh plid:      36029
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 481 seconds

////////////////////////////////////////////////////////////////////////////////
at this point everything is fine i can level 2 ping each neighbor etc. but when
i boot up the 6th neighbor (i.e. 7th node in the mesh network) last-seen values
start to increase and finally nodes disappear

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv openwrt-2019.0-0, MainIF/MAC:
adhoc0/38:d2:69:dc:de:43 (bat0/6a:40:89:aa:93:a0 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
   38:d2:69:e0:c3:0d   97.200s   (225) 38:d2:69:e0:5e:de [    adhoc0]
   38:d2:69:e0:c3:0d   97.200s   (222) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:c3:0d   97.200s   (214) 38:d2:69:e0:8f:87 [    adhoc0]
   38:d2:69:e0:c3:0d   97.200s   (225) 38:d2:69:e0:71:73 [    adhoc0]
 * 38:d2:69:e0:c3:0d   97.200s   (251) 38:d2:69:e0:c3:0d [    adhoc0]
   98:84:e3:f0:a5:38  100.970s   (221) 38:d2:69:e0:c3:0d [    adhoc0]
   98:84:e3:f0:a5:38  100.970s   (225) 38:d2:69:e0:5e:de [    adhoc0]
   98:84:e3:f0:a5:38  100.970s   (225) 38:d2:69:e0:71:73 [    adhoc0]
   98:84:e3:f0:a5:38  100.970s   (214) 38:d2:69:e0:8f:87 [    adhoc0]
 * 98:84:e3:f0:a5:38  100.970s   (255) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:8f:87  100.170s   (221) 38:d2:69:e0:c3:0d [    adhoc0]
   38:d2:69:e0:8f:87  100.170s   (225) 38:d2:69:e0:5e:de [    adhoc0]
   38:d2:69:e0:8f:87  100.170s   (225) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:8f:87  100.170s   (225) 38:d2:69:e0:71:73 [    adhoc0]
 * 38:d2:69:e0:8f:87  100.170s   (255) 38:d2:69:e0:8f:87 [    adhoc0]
   38:d2:69:e0:71:73   18.750s   (  0) 38:d2:69:e0:c3:0d [    adhoc0]
   38:d2:69:e0:71:73   18.750s   (  0) 38:d2:69:e0:5e:de [    adhoc0]
   38:d2:69:e0:71:73   18.750s   (  0) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:71:73   18.750s   (  0) 38:d2:69:e0:8f:87 [    adhoc0]
 * 38:d2:69:e0:71:73   18.750s   ( 12) 38:d2:69:e0:71:73 [    adhoc0]
   38:d2:69:e0:5e:de   93.200s   (218) 38:d2:69:e0:c3:0d [    adhoc0]
   38:d2:69:e0:5e:de   93.200s   (  0) 98:84:e3:f0:a5:38 [    adhoc0]
   38:d2:69:e0:5e:de   93.200s   (  0) 38:d2:69:e0:8f:87 [    adhoc0]
   38:d2:69:e0:5e:de   93.200s   (211) 38:d2:69:e0:71:73 [    adhoc0]
 * 38:d2:69:e0:5e:de   93.200s   (247) 38:d2:69:e0:5e:de [    adhoc0]

root@OpenWrt:/# batctl n
[B.A.T.M.A.N. adv openwrt-2019.0-0, MainIF/MAC:
adhoc0/38:d2:69:dc:de:43 (bat0/6a:40:89:aa:93:a0 BATMAN_IV)]
IF             Neighbor              last-seen
       adhoc0     38:d2:69:e0:c3:0d  121.780s
       adhoc0     38:d2:69:e0:5e:de  117.780s
       adhoc0     98:84:e3:f0:a5:38  125.560s
       adhoc0     38:d2:69:e0:8f:87  124.750s
       adhoc0     38:d2:69:e0:71:73   43.210s

////////////////////////////////////////////////////////////////////////////////

at this point the neighbors are giong to dissapear after 200 sec timeout but
the command < :#iw dev adhoc0 station dump> list all the nodes plink established

////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# iw dev adhoc0 station dump
Station 38:d2:69:e0:71:73 (on adhoc0)
        inactive time:  90 ms
        rx bytes:       3864389
        rx packets:     49751
        tx bytes:       539
        tx packets:     7
        tx retries:     0
        tx failed:      0
        rx drop misc:   26681
        signal:         0 dBm
        signal avg:     -21 dBm
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    27.343Mbps
        mesh llid:      32171
        mesh plid:      13983
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 1159 seconds
Station 38:d2:69:e0:8f:87 (on adhoc0)
        inactive time:  30 ms
        rx bytes:       3690399
        rx packets:     47696
        tx bytes:       329
        tx packets:     4
        tx retries:     0
        tx failed:      0
        rx drop misc:   24935
        signal:         0 dBm
        signal avg:     -24 dBm
        tx bitrate:     1.0 MBit/s
        expected throughput:    3.906Mbps
        mesh llid:      30373
        mesh plid:      56485
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      UNKNOWN
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 1157 seconds
Station 98:84:e3:f0:a5:38 (on adhoc0)
        inactive time:  60 ms
        rx bytes:       3622627
        rx packets:     46907
        tx bytes:       716
        tx packets:     8
        tx retries:     0
        tx failed:      0
        rx drop misc:   24144
        signal:         0 dBm
        signal avg:     -25 dBm
        Toffset:        18446744071109913820 us
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    140.625Mbps
        mesh llid:      25917
        mesh plid:      65422
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 1155 seconds
Station 38:d2:69:e0:5e:de (on adhoc0)
        inactive time:  80 ms
        rx bytes:       3489728
        rx packets:     45344
        tx bytes:       480
        tx packets:     6
        tx retries:     0
        tx failed:      0
        rx drop misc:   22514
        signal:         0 dBm
        signal avg:     -31 dBm
        Toffset:        18446744071107371412 us
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    140.625Mbps
        mesh llid:      52541
        mesh plid:      55210
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 1153 seconds
Station 38:d2:69:e0:c3:0d (on adhoc0)
        inactive time:  80 ms
        rx bytes:       3585647
        rx packets:     46475
        tx bytes:       480
        tx packets:     6
        tx retries:     0
        tx failed:      0
        rx drop misc:   23601
        signal:         0 dBm
        signal avg:     -25 dBm
        Toffset:        18446744071104087603 us
        tx bitrate:     72.2 MBit/s MCS 7 short GI
        rx bitrate:     65.0 MBit/s MCS 7
        expected throughput:    140.625Mbps
        mesh llid:      36132
        mesh plid:      36029
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      ACTIVE
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 1149 seconds
Station 38:d2:69:cd:86:96 (on adhoc0)
        inactive time:  60 ms
        rx bytes:       195354
        rx packets:     3004
        tx bytes:       270
        tx packets:     3
        tx retries:     0
        tx failed:      0
        rx drop misc:   3
        signal:         0 dBm
        signal avg:     -41 dBm
        Toffset:        18446744070115910174 us
        tx bitrate:     1.0 MBit/s
        expected throughput:    70.312Mbps
        mesh llid:      25879
        mesh plid:      29955
        mesh plink:     ESTAB
        mesh local PS mode:     ACTIVE
        mesh peer PS mode:      UNKNOWN
        mesh non-peer PS mode:  ACTIVE
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            no
        TDLS peer:      no
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 161 seconds

////////////////////////////////////////////////////////////////////////////////

and finally
////////////////////////////////////////////////////////////////////////////////
root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv openwrt-2019.0-0, MainIF/MAC:
adhoc0/38:d2:69:dc:de:43 (bat0/6a:40:89:aa:93:a0 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]

////////////////////////////////////////////////////////////////////////////////

i researched for a while for the cause with no avail. i would appreciate any
kind of help to point me to the right direction to solve this.

ps: i can provide more detail explanation, configuration and logs i you could
tell me which

thank you in advance.
