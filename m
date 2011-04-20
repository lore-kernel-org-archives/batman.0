Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
Date: Wed, 20 Apr 2011 22:39:30 +0200
Message-ID: <BANLkTinQ6xjJQTK_zZJYKn4q4bT4Oi6NWQ@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] batman doesn't see neigh on wired lan
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

Hi!

Here in Pisa we are experiencing a big problem!

Nodes doesn't see each other on cable!

below is some data from the 2 nodes

As you can see nodes receives each other BAT packets but don't see
each other as neighbor...

also batctl tr can confirm it...

what is happening?

NODE_1 00:15:6d:7d:09:9e 00:15:6d:7c:09:9e

root@OpenWrt:~# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UP qlen 1000
    link/ether 00:15:6d:7d:09:9e brd ff:ff:ff:ff:ff:ff
3: br-clients: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UNKNOWN
    link/ether 00:15:6d:7d:09:9e brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.21/24 brd 192.168.1.255 scope global br-clients
    inet6 2001:470:ca42:ee:ab:15:6d7d:99e/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::215:6dff:fe7d:99e/64 scope link
       valid_lft forever preferred_lft forever
5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1524 qdisc mq state
UNKNOWN qlen 1000
    link/ether 00:15:6d:7c:09:9e brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.21/24 brd 192.168.1.255 scope global wlan0
    inet6 2001:470:ca42:ee:ab:15:6d7c:99e/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::215:6dff:fe7c:99e/64 scope link
       valid_lft forever preferred_lft forever
6: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UNKNOWN qlen 1000
    link/ether 42:03:7e:92:90:d4 brd ff:ff:ff:ff:ff:ff
root@OpenWrt:~# brctl show
bridge name     bridge id               STP enabled     interfaces
br-clients              8000.00156d7d099e       no              eth0
                                                        bat0

root@OpenWrt:~# batctl if
eth0: active
wlan0: active

root@OpenWrt:~# batctl o
[B.A.T.M.A.N. adv 2011.0.0, MainIF/MAC: wlan0/00:15:6d:7c:09:9e (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
00:15:6d:7a:97:45    0.210s   (143) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 (121) 06:15:6d:fc:71:ce (143)
00:15:6d:7d:09:e8    4.440s   ( 45) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 37) 06:15:6d:fc:71:ce ( 45)
00:15:6d:fc:72:0b   15.020s   ( 64) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 64)
06:15:6d:fc:71:ce    0.080s   (249) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:fc:71:ce (249) 00:15:6d:7a:97:45 ( 82)
00:15:6d:73:48:0d    0.260s   (117) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 98) 06:15:6d:fc:71:ce (117)
06:15:6d:fc:71:f6    0.210s   ( 39) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 39)
00:15:6d:fd:71:f6    4.850s   ( 44) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 37) 06:15:6d:fc:71:ce ( 44)
00:15:6d:fd:71:ce    0.640s   (252) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:fc:71:ce (252)
00:15:6d:7a:97:33    2.490s   ( 63) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 55) 06:15:6d:fc:71:ce ( 63) 00:15:6d:7a:97:33 (
0)
00:15:6d:fd:72:0b    3.370s   ( 74) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 57) 06:15:6d:fc:71:ce ( 74)
00:15:6d:7a:97:08    0.010s   ( 42) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 34) 06:15:6d:fc:71:ce ( 42)
06:15:6d:72:48:0d    2.470s   (126) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:72:48:0d (  0) 00:15:6d:7a:97:45 (100) 06:15:6d:fc:71:ce
(126)
root@OpenWrt:~# batctl tr 00:15:6d:73:48:0d
traceroute to 00:15:6d:73:48:0d (00:15:6d:73:48:0d), 50 hops max, 19
byte packets
 1: 00:15:6d:fd:71:ce  1.537 ms  2.203 ms  1.265 ms
 2: 00:15:6d:7a:97:45  2.062 ms  2.204 ms  1.982 ms
 3: 00:15:6d:73:48:0d  2.936 ms  3.581 ms  3.239 ms
root@OpenWrt:~# batctl tcpdump eth0
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:48.678817 IP6: not implemented yet
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:48.748837 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 52990, IP 10.175.1.1.2050 > 239.255.255.250.1900: UDP, length 276
23:57:48.749329 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 52990, IP 10.175.1.1.2050 > 239.255.255.250.1900: UDP, length 276
23:57:48.749684 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 52990, IP 10.175.1.1.2050 > 239.255.255.250.1900: UDP, length 276
23:57:48.750965 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 52990, IP 10.175.1.1.2050 > 239.255.255.250.1900: UDP, length 276
23:57:48.751342 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 52990, IP 10.175.1.1.2050 > 239.255.255.250.1900: UDP, length 276
23:57:48.751753 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 52990, IP 10.175.1.1.2050 > 239.255.255.250.1900: UDP, length 276
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:48.771207 ARP, Request who-has 131.114.251.119 tell
131.114.250.1 (e4:1f:13:2f:cb:7a), length 46
23:57:48.778757 BAT 00:15:6d:7a:97:33: OGM via neigh
00:15:6d:73:48:0d, seq 43469, tq  77, ttl 48, v 12, flags [....],
length 60
23:57:48.779213 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:73:48:0d,
seq 500714, ARP, Request who-has 131.114.251.119 tell 131.114.250.1
(e4:1f:13:2f:cb:7a), length 46
23:57:48.779660 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:73:48:0d,
seq 500714, ARP, Request who-has 131.114.251.119 tell 131.114.250.1
(e4:1f:13:2f:cb:7a), length 46
23:57:48.780886 BAT 00:15:6d:7a:97:33: OGM via neigh
00:15:6d:7d:09:9e, seq 43469, tq  65, ttl 47, v 12, flags [....],
length 30
Warning - packet contains unknown ether type: 0x86dd
23:57:48.781439 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:73:48:0d,
seq 500714, ARP, Request who-has 131.114.251.119 tell 131.114.250.1
(e4:1f:13:2f:cb:7a), length 46
Warning - packet contains unknown ether type: 0x86dd
23:57:48.790867 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:73:48:0d,
seq 500714, ARP, Request who-has 131.114.251.119 tell 131.114.250.1
(e4:1f:13:2f:cb:7a), length 46
23:57:48.791382 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:73:48:0d,
seq 500714, ARP, Request who-has 131.114.251.119 tell 131.114.250.1
(e4:1f:13:2f:cb:7a), length 46
23:57:48.791728 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:73:48:0d,
seq 500714, ARP, Request who-has 131.114.251.119 tell 131.114.250.1
(e4:1f:13:2f:cb:7a), length 46
Warning - packet contains unknown ether type: 0x86dd


NODE_2 00:15:6d:73:48:0d 00:15:6d:72:48:0d 06:15:6d:72:48:0d

root@OpenWrt:~# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UNKNOWN qlen 1000
    link/ether 00:15:6d:73:48:0d brd ff:ff:ff:ff:ff:ff
    inet6 fe80::215:6dff:fe73:480d/64 scope link
       valid_lft forever preferred_lft forever
3: br-clients: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UNKNOWN
    link/ether 00:15:6d:72:48:0d brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.21/24 brd 192.168.1.255 scope global br-clients
    inet6 2001:470:ca42:ee:ab:15:6d73:480d/64 scope global
       valid_lft forever preferred_lft forever
    inet6 2001:470:c8f6:15:215:6dff:fe73:480d/64 scope global
deprecated dynamic
       valid_lft 372sec preferred_lft -71628sec
    inet6 2001:470:ca42:ee:215:6dff:fe73:480d/64 scope global
deprecated dynamic
       valid_lft 372sec preferred_lft -71628sec
    inet6 fe80::215:6dff:fe73:480d/64 scope link
       valid_lft forever preferred_lft forever
4: wifi0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UNKNOWN qlen 195
    link/ieee802.11 00:15:6d:72:48:0d brd ff:ff:ff:ff:ff:ff
5: ath0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN
    link/ether 00:15:6d:72:48:0d brd ff:ff:ff:ff:ff:ff
    inet6 fe80::215:6dff:fe72:480d/64 scope link
       valid_lft forever preferred_lft forever
6: ath1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1524 qdisc noqueue state UNKNOWN
    link/ether 06:15:6d:72:48:0d brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.21/24 brd 192.168.1.255 scope global ath1
    inet6 2001:470:ca42:ee:ab:15:6d72:480d/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::415:6dff:fe72:480d/64 scope link
       valid_lft forever preferred_lft forever
7: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UNKNOWN qlen 1000
    link/ether 0a:02:ea:9f:28:49 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::802:eaff:fe9f:2849/64 scope link
       valid_lft forever preferred_lft forever

root@OpenWrt:~# batctl if
eth0: active
ath0: active
ath1: active
root@OpenWrt:~# batctl o
[B.A.T.M.A.N. adv 2011.0.0, MainIF/MAC: eth0/00:15:6d:73:48:0d (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
00:15:6d:7a:97:45    0.620s   (156) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 (156)
00:15:6d:7d:09:e8    4.380s   ( 88) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 ( 88)
00:15:6d:fc:72:0b    2.420s   ( 40) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 ( 40)
06:15:6d:fc:71:ce    2.600s   (132) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 (132)
06:15:6d:fc:71:f6    5.410s   (111) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 (111)
00:15:6d:fd:71:f6    0.410s   (109) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 (109)
00:15:6d:fd:71:ce    0.950s   (133) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 (133)
00:15:6d:7a:97:33    2.120s   ( 92) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 ( 92)
00:15:6d:7c:09:9e    0.640s   (119) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 (119)
00:15:6d:fd:72:0b    1.080s   ( 81) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 ( 81)
00:15:6d:7a:97:08    0.640s   ( 90) 00:15:6d:7a:97:45 [      ath1]:
00:15:6d:7a:97:45 ( 90)
root@OpenWrt:~# batctl tr 00:15:6d:7c:09:9e
traceroute to 00:15:6d:7c:09:9e (00:15:6d:7c:09:9e), 50 hops max, 19
byte packets
 1: 00:15:6d:7a:97:45  3.797 ms  0.719 ms  0.700 ms
 2: 00:15:6d:fd:71:ce  26.824 ms  3.203 ms  1.810 ms
 3: 00:15:6d:7c:09:9e  7.790 ms  2.650 ms  2.664 ms
root@OpenWrt:~# batctl tcpdump eth0
23:57:24.626528 IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length 139
Warning - packet contains unknown ether type: 0x86dd
23:57:24.635813 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55307, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
Warning - packet contains unknown ether type: 0x86dd
23:57:24.637739 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55307, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.639202 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55307, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.641845 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55307, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.643417 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55307, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.645796 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55307, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.647247 BAT 00:15:6d:7a:97:45: OGM via neigh
00:15:6d:73:48:0d, seq 97723, tq 135, ttl 49, v 12, flags [....],
length 36
23:57:24.648432 BAT 00:15:6d:7a:97:45: OGM via neigh
00:15:6d:7d:09:9e, seq 97723, tq 124, ttl 48, v 12, flags [....],
length 46
23:57:24.649870 BAT 00:15:6d:73:48:0d: OGM via neigh
00:15:6d:7d:09:9e, seq 87061, tq 108, ttl 47, v 12, flags [....],
length 246
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:24.668902 IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length 139
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:24.683073 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55308, IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length
139
23:57:24.687312 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55308, IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length
139
23:57:24.691854 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55308, IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length
139
23:57:24.695673 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55308, IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length
139
23:57:24.699906 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55308, IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length
139
23:57:24.703927 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55308, IP 10.175.1.101.17500 > 10.175.255.255.17500: UDP, length
139
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:24.737144 IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length 139
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
23:57:24.739683 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55306, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.747901 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55306, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.751056 BAT 00:15:6d:73:48:0d: BCAST, orig 00:15:6d:fd:71:f6,
seq 55306, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
Warning - packet contains unknown ether type: 0x86dd
23:57:24.752670 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55306, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.753877 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55306, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
23:57:24.755080 BAT 00:15:6d:7d:09:9e: BCAST, orig 00:15:6d:fd:71:f6,
seq 55306, IP 10.175.1.101.17500 > 255.255.255.255.17500: UDP, length
139
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
Warning - packet contains unknown ether type: 0x86dd
