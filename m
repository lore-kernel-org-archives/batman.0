Message-ID: <468BAFD3.6060700@fokus.fraunhofer.de>
Date: Wed, 04 Jul 2007 16:33:55 +0200
From: Anton Gillert <anton.gillert@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batman problem with tun0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

I have following problem:
I have two Asus wl500gp router, each with atheros(Atheros 5212) 
wlancards, running kamikaze 7.06; kernel ver.:2.6.19.2. and B.A.T.M.A.N. 
0.2 rv451 (compability version 3)
one of them has access to the internet.
The one who has no internet connection, doesn't set a default route to 
the one who has. It only sets this routes:

Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
192.168.33.23   0.0.0.0         255.255.255.255 UH    0      0        0 
ath0
 0.0.0.0             0.0.0.0         0.0.0.0                 U       
0      0        0 tun0
how can I fix it, or what did I wrong? here my are settings

On the router with the internet connection:

NIC:
ath0      IEEE 802.11g  ESSID:"muh"  Nickname:""
         Mode:Ad-Hoc  Frequency:2.412 GHz  Cell: 02:0B:6B:4E:17:DA
         Bit Rate:0 kb/s   Tx-Power:16 dBm   Sensitivity=0/3
         Retry:off   RTS thr:off   Fragment thr:off
         Encryption key:off
         Power Management:off
         Link Quality=27/94  Signal level=-68 dBm  Noise level=-95 dBm
         Rx invalid nwid:621  Rx invalid crypt:0  Rx invalid frag:0
         Tx excessive retries:0  Invalid misc:0   Missed beacon:0

ath0      Link encap:Ethernet  HWaddr 00:0B:6B:4E:17:DA
         inet addr:192.168.33.23  Bcast:192.168.255.255  Mask:255.255.0.0
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:1759 errors:0 dropped:0 overruns:0 frame:0
         TX packets:1720 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:0
         RX bytes:91520 (89.3 KiB)  TX bytes:89328 (87.2 KiB)

batmand:
batmand -g 11 -r 0 ath0

batmand -c -d 1

Originator           Router (#/128):    Potential routers... 
[B.A.T.M.A.N. 0.2 rv451, MainIF/IP: ath0 192.168.33.23, UT: 0d 0h16m]
192.168.33.27     192.168.33.27 (128):   192.168.33.27 (128)

route:

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
192.168.33.27   0.0.0.0         255.255.255.255 UH    0      0        0 
ath0
10.147.112.0    0.0.0.0         255.255.255.128 U     0      0        0 
eth0.1
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 
br-lan
192.168.0.0     0.0.0.0         255.255.0.0     U     0      0        0 
ath0
0.0.0.0         10.147.112.1    0.0.0.0         UG    0      0        0 
eth0.1

configuration of the router without internet connection:

NIC:


ath0      IEEE 802.11g  ESSID:"muh"  Nickname:""
         Mode:Ad-Hoc  Frequency:2.412 GHz  Cell: 02:0B:6B:4E:17:DA
         Bit Rate:0 kb/s   Tx-Power:16 dBm   Sensitivity=0/3
         Retry:off   RTS thr:off   Fragment thr:off
         Encryption key:off
         Power Management:off
         Link Quality=62/94  Signal level=-33 dBm  Noise level=-95 dBm
         Rx invalid nwid:197859  Rx invalid crypt:0  Rx invalid frag:0
         Tx excessive retries:0  Invalid misc:0   Missed beacon:0

ath0      Link encap:Ethernet  HWaddr 00:0B:6B:4E:17:53
         inet addr:192.168.33.27  Bcast:192.168.255.255  Mask:255.255.0.0
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:886366 errors:0 dropped:0 overruns:0 frame:0
         TX packets:887894 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:0
         RX bytes:46036433 (43.9 MiB)  TX bytes:46196970 (44.0 MiB)
# was set by batmand
tun0      Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
         inet addr:192.168.33.27  P-t-P:192.168.33.27  Mask:255.255.255.255
         UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1472  Metric:1
         RX packets:0 errors:0 dropped:0 overruns:0 frame:0
         TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:500
         RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)


batmand:

batmand -r 1 ath0

batmand -c -d 1

Originator           Router (#/128):    Potential routers... 
[B.A.T.M.A.N. 0.2 rv451, MainIF/IP: ath0 192.168.33.27, UT: 5d 0h28m]
192.168.33.23     192.168.33.23 (128):   192.168.33.23 (128)

batmanad -c -d 2

    Gateway              Router (#/128)
=> 192.168.33.23     192.168.33.23 (128), gw_class 11 - >6 MBit, 
reliability: 0

route:

Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
192.168.33.23   0.0.0.0         255.255.255.255 UH    0      0        0 
ath0
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 
br-lan
192.168.0.0     0.0.0.0         255.255.0.0     U     0      0        0 
ath0
0.0.0.0         0.0.0.0         0.0.0.0         U     0      0        0 
tun0
