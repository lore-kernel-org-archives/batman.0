Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sun, 25 Mar 2012 11:20:55 -0300
Message-ID: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] BW degradation on p2p links?
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,
i'm participating in the development of a wireless mesh network in
Delta de Tigre, near Buenos Aires, Argentina.
Landscape is absolutely flat, with dense forest 15-20mts tall. Nodes
are being installed along the river, 50 - 150mts apart, with clear LOS
at ground level.
I collaborated with Nico Echaniz last month, bulding another community
network in Cordoba, and given the success, I decided to start one more
here. I'm also really thankful with Elektra, for recommending the
tl-m3220 to Nico!
We chose batman over olsr, in part because of avahi stuff, but also to
have a real-world implementation and thus collaborate in testing /
debugging :) So far, there are  only 4 working nodes, but luckily I'm
already facing unexpected behaviour.

I'm sorry for the long email, it's mostly terminal logs.
In short, iperf between two neighbouring nodes reports >20mbps, yet
running the same iperf between nodes separated by one hop reports
inexplicably low <5mbps.

Links are point to point, with different radios on different channels,
no freq overlap.

A=[ath9k]--(50m)--[ath9k]=B=[ath9k_htc]--(150m)--[ath9k_htc]=C=[ath9k]--(50m)--[ath9k]=D

A is a tplink mr3420 + wn722n
B and C are tplink mr3220 + wn722n
D is a tplink mr3220 (single interface)

All of them are running openwrt trunk r30919.
the internal iface of the mr3x20 uses ath9k, and the wn722n runs with ath9k_htc

the link between B and C is done in infrastructure mode, B is ap and C
is managed. Radios are set to channel 9, HT40-.
C <-> D is made with ath9k , in channel 1 , HT20.

(all hostnames have been obscured for readability :P )

nodeB -> nodeC = 31mbps
nodeC -> nodeD = 21mbps
nodeB -> nodeD = 3mbps

nodeD -> nodeC = 21mbps
nodeC -> nodeB = 21mbps
nodeD -> nodeB = 10mbps

nodeD# batctl tr B_mesh
traceroute to B_mesh (56:e6:fc:be:29:d3), 50 hops max, 20 byte packets
 1: C_mesh (56:e6:fc:b9:b6:47)  1.155 ms  0.834 ms  0.796 ms
 2: B_mesh (56:e6:fc:be:29:d3)  6.523 ms  2.719 ms  1.917 ms

nodeB# batctl tr D_mesh
traceroute to D_mesh (56:e6:fc:b9:b7:01), 50 hops max, 20 byte packets
 1: C_mesh (56:e6:fc:b9:b6:47)  1.323 ms  1.117 ms  0.974 ms
 2: D_mesh (56:e6:fc:b9:b7:01)  2.278 ms  1.839 ms  2.164 ms


### iperf between nodeB -> nodeC
root@nodeB:~# iperf -c nodeC -w 320k  -i 1
------------------------------------------------------------
Client connecting to nodeC, TCP port 5001
TCP window size:  320 KByte
------------------------------------------------------------
[  3] local 10.6.0.1 port 35759 connected with 10.6.0.32 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  3.63 MBytes  30.4 Mbits/sec
[  3]  1.0- 2.0 sec  3.63 MBytes  30.4 Mbits/sec
[  3]  2.0- 3.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3]  3.0- 4.0 sec  3.63 MBytes  30.4 Mbits/sec
[  3]  4.0- 5.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3]  5.0- 6.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3]  6.0- 7.0 sec  4.00 MBytes  33.6 Mbits/sec
[  3]  7.0- 8.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3]  8.0- 9.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3]  9.0-10.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3]  0.0-10.1 sec  38.0 MBytes  31.7 Mbits/sec

### iperf between nodeC -> nodeD
nodeC# iperf -c nodeD -w 320k -i 1
------------------------------------------------------------
Client connecting to nodeD, TCP port 5001
TCP window size:  320 KByte
------------------------------------------------------------
[  3] local 10.6.0.32 port 43655 connected with 10.6.0.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  2.50 MBytes  21.0 Mbits/sec
[  3]  1.0- 2.0 sec  2.63 MBytes  22.0 Mbits/sec
[  3]  2.0- 3.0 sec  2.50 MBytes  21.0 Mbits/sec
[  3]  3.0- 4.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3]  4.0- 5.0 sec  2.63 MBytes  22.0 Mbits/sec
[  3]  5.0- 6.0 sec  2.63 MBytes  22.0 Mbits/sec
[  3]  6.0- 7.0 sec  2.50 MBytes  21.0 Mbits/sec
[  3]  7.0- 8.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3]  8.0- 9.0 sec  2.63 MBytes  22.0 Mbits/sec
[  3]  9.0-10.0 sec  2.63 MBytes  22.0 Mbits/sec
[  3]  0.0-10.1 sec  25.9 MBytes  21.5 Mbits/sec

### Now, enter the mistery..
### Best iperf run after several attemps yielding 1 - 2 mbps
# iperf -c charly-muelle -w 320k -i 1 -t 20
------------------------------------------------------------
Client connecting to charly-muelle, TCP port 5001
TCP window size:  320 KByte
------------------------------------------------------------
[  3] local 10.6.0.1 port 55093 connected with 10.6.0.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec   896 KBytes  7.34 Mbits/sec
[  3]  1.0- 2.0 sec   256 KBytes  2.10 Mbits/sec
[  3]  2.0- 3.0 sec   128 KBytes  1.05 Mbits/sec
[  3]  3.0- 4.0 sec   128 KBytes  1.05 Mbits/sec
[  3]  4.0- 5.0 sec   256 KBytes  2.10 Mbits/sec
[  3]  5.0- 6.0 sec   384 KBytes  3.15 Mbits/sec
[  3]  6.0- 7.0 sec   128 KBytes  1.05 Mbits/sec
[  3]  7.0- 8.0 sec   384 KBytes  3.15 Mbits/sec
[  3]  8.0- 9.0 sec   256 KBytes  2.10 Mbits/sec
[  3]  9.0-10.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 10.0-11.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 11.0-12.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 12.0-13.0 sec   640 KBytes  5.24 Mbits/sec
[  3] 13.0-14.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 14.0-15.0 sec   640 KBytes  5.24 Mbits/sec
[  3] 15.0-16.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 16.0-17.0 sec   640 KBytes  5.24 Mbits/sec
[  3] 17.0-18.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 18.0-19.0 sec   640 KBytes  5.24 Mbits/sec
[  3] 19.0-20.0 sec   512 KBytes  4.19 Mbits/sec
[  3]  0.0-20.3 sec  8.88 MBytes  3.66 Mbits/sec

### and the way back... (i'll snip the logs generously)
nodeD# iperf -c nodeC -w320k
[  3]  0.0-10.1 sec  25.5 MBytes  21.2 Mbits/sec

nodeC# iperf -c nodeB -w 320k
[  3]  0.0-10.0 sec  25.5 MBytes  21.3 Mbits/sec

nodeD# iperf -c nodeB -w320k
[  3]  0.0-10.2 sec  12.3 MBytes  10.0 Mbits/sec

This can be reproduced at will, and i don't understand what's happening.

Looks like node C is getting .. overwhelmed..(?) when forwarding the
packets between B and D
Even more intriguing is that the problem is much worse when going B ->
D (tenfold slower) than from D -> B (twice slower)

##### more screenlogs follow

### similar in node B and C (in D, there's no wlan1)
# batctl -v
batctl 2012.0.0 [batman-adv: 2012.0.0]
# batctl if
wlan0-1: active # ath9k, internal, adhoc mode
wlan1: active # ath9k_htc, usb, infrastructure mode
# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		8000.228082e1fd06	no		wlan0
							eth0
							bat0

### originators seen from nodeB
nodeB# batctl o | cut -b -100
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0-1/56:e6:fc:be:29:d3 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
          A_wlan1    0.830s   (250)           A_wlan1 [     wlan1]:
        C_mesh (  0)
           D_mesh    0.320s   (230)           C_wlan1 [     wlan1]:
       C_wlan1 (230)
           A_mesh    0.890s   (250)           A_wlan1 [     wlan1]:
       A_wlan1 (250)
           C_mesh    0.800s   (241)           C_wlan1 [     wlan1]:
       C_wlan1 (241)
          C_wlan1    0.720s   (241)           C_wlan1 [     wlan1]:
       A_wlan1 (226)

### originators seen from nodeC
nodeC# batctl o |cut -b -100
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0-1/56:e6:fc:b9:b6:47 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
           B_mesh    0.830s   (255)           B_wlan1 [     wlan1]:
        D_mesh (  0)
          A_wlan1    0.180s   (242)           A_wlan1 [     wlan1]:
       B_wlan1 (229)
          B_wlan1    0.280s   (255)           B_wlan1 [     wlan1]:
       A_wlan1 (233)
           D_mesh    0.030s   (235)            D_mesh [   wlan0-1]:
       A_wlan1 (194)
           A_mesh    0.430s   (242)           A_wlan1 [     wlan1]:
       B_wlan1 (230)


Any ideas, thoughts, pointers? Any additional info needed?

I've RTFW, RTFM, and even RTF-PDF concerning bandwidth degradation on
single-interface-node mesh networks, and that's the reason why i'm (so
far unsuccessfully) trying to overcome that problem with the
additional USB interface.

Thanks a lot for the attention!

Guido
