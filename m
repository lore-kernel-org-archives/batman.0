Return-Path: <d.theisen@gmx.net>
From: d.theisen@gmx.net
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Date: Wed, 2 Jul 2014 05:07:05 +0200
Message-Id: <6FDB9FFC-459A-465A-B4BE-66CA52968F74@gmx.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [B.A.T.M.A.N.] increasing BATADV_FRAG_MAX_FRAGMENTS
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

Hi!

I=92m the one who had the suspicion that there might be a limit in the =
number of batman-clients per node.
Just to make things clearer:

* The node was using the 2,4 and 5GHz bands (not just one band). There =
was also no interference from other wifi networks (basement location).
* Network access and throughput was acceptable for the 72 clients (with =
high pings at times) that actually got any data through.
* The problem might very well be unrelated to batman. It=92s just that =
clients got a WLAN connection (so probably no hostapd issue) but a lot =
of those time-out without even assigned an IP.

> kern.err kernel: [15446.130000] ath: phy1: Failed to stop TX DMA, =
queues=3D0x00d!
So this might as well all be a driver issue e.g. =
<https://dev.openwrt.org/ticket/11862> as mentioned!

g3ntle (not subscribed to this list)

P.S. I did not want to accuse anyone or spread false facts. Now we got =
the answer that there is no known limit in batman-adv, we need to look =
elsewhere for the limitation before deploying our mesh network to =
potentially 1000+ clients at a campus.


Here, FWIW, the complete logread during the conference. I was just a =
participant and my task was not to diagnose the network. So this is all =
I have.

Thu Jun 26 15:31:33 2014 kern.err kernel: [15446.130000] ath: phy1: =
Failed to stop TX DMA, queues=3D0x00d!
Thu Jun 26 15:31:33 2014 kern.warn kernel: [15446.800000] net_ratelimit: =
44 callbacks suppressed
Thu Jun 26 15:31:33 2014 daemon.info hostapd: wlan1-2: STA =
48:74:6e:5b:53:53 IEEE 802.11: authenticated
Thu Jun 26 15:31:33 2014 daemon.info hostapd: wlan1-2: STA =
48:74:6e:5b:53:53 IEEE 802.11: associated (aid 38)
Thu Jun 26 15:31:34 2014 daemon.info hostapd: wlan1-2: STA =
b8:f6:b1:10:f2:a1 IEEE 802.11: disassociated
Thu Jun 26 15:31:35 2014 daemon.info hostapd: wlan0-1: STA =
5c:51:4f:e9:c5:cd IEEE 802.11: authenticated
Thu Jun 26 15:31:35 2014 daemon.info hostapd: wlan0-1: STA =
5c:51:4f:e9:c5:cd IEEE 802.11: associated (aid 1)
Thu Jun 26 15:31:35 2014 daemon.info hostapd: wlan1-2: STA =
b8:f6:b1:10:f2:a1 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:31:38 2014 kern.warn kernel: [15451.820000] net_ratelimit: =
1867 callbacks suppressed
Thu Jun 26 15:31:38 2014 kern.err kernel: [15451.890000] ath: phy1: =
Failed to stop TX DMA, queues=3D0x00d!
Thu Jun 26 15:31:41 2014 daemon.info hostapd: wlan1-1: STA =
00:88:65:5c:6a:f4 IEEE 802.11: authenticated
Thu Jun 26 15:31:41 2014 daemon.info hostapd: wlan1-1: STA =
00:88:65:5c:6a:f4 IEEE 802.11: associated (aid 24)
Thu Jun 26 15:31:42 2014 daemon.info hostapd: wlan1-2: STA =
0c:3e:9f:2d:a3:6c IEEE 802.11: authenticated
Thu Jun 26 15:31:42 2014 daemon.info hostapd: wlan1-2: STA =
0c:3e:9f:2d:a3:6c IEEE 802.11: associated (aid 24)
Thu Jun 26 15:31:43 2014 kern.warn kernel: [15456.840000] net_ratelimit: =
1337 callbacks suppressed
Thu Jun 26 15:31:45 2014 daemon.info hostapd: wlan0-1: STA =
38:19:2f:f3:30:5c IEEE 802.11: authenticated
Thu Jun 26 15:31:45 2014 daemon.info hostapd: wlan0-1: STA =
38:19:2f:f3:30:5c IEEE 802.11: associated (aid 13)
Thu Jun 26 15:31:46 2014 daemon.info hostapd: wlan1-1: STA =
10:40:f3:d9:88:05 IEEE 802.11: disassociated
Thu Jun 26 15:31:47 2014 daemon.info hostapd: wlan1-1: STA =
10:40:f3:d9:88:05 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:31:48 2014 daemon.info hostapd: wlan1-1: STA =
10:40:f3:d9:88:05 IEEE 802.11: authenticated
Thu Jun 26 15:31:48 2014 daemon.info hostapd: wlan1-1: STA =
10:40:f3:d9:88:05 IEEE 802.11: associated (aid 16)
Thu Jun 26 15:31:48 2014 kern.warn kernel: [15461.870000] net_ratelimit: =
12 callbacks suppressed
Thu Jun 26 15:31:50 2014 daemon.info hostapd: wlan1-2: STA =
4c:8d:79:04:f6:23 IEEE 802.11: authenticated
Thu Jun 26 15:31:50 2014 daemon.info hostapd: wlan1-2: STA =
4c:8d:79:04:f6:23 IEEE 802.11: associated (aid 26)
Thu Jun 26 15:31:51 2014 kern.err kernel: [15464.460000] ath: phy1: =
Failed to stop TX DMA, queues=3D0x00d!
Thu Jun 26 15:31:53 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: disassociated
Thu Jun 26 15:31:54 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:31:54 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: authenticated
Thu Jun 26 15:31:54 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: associated (aid 7)
Thu Jun 26 15:32:00 2014 daemon.info hostapd: wlan0-1: STA =
44:a7:cf:bf:de:85 IEEE 802.11: disassociated
Thu Jun 26 15:32:01 2014 daemon.info hostapd: wlan1-1: STA =
44:a7:cf:bf:de:85 IEEE 802.11: authenticated
Thu Jun 26 15:32:01 2014 daemon.info hostapd: wlan1-1: STA =
44:a7:cf:bf:de:85 IEEE 802.11: associated (aid 38)
Thu Jun 26 15:32:01 2014 daemon.info hostapd: wlan0-1: STA =
44:a7:cf:bf:de:85 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:02 2014 daemon.info hostapd: wlan1-2: STA =
60:03:08:94:5d:c0 IEEE 802.11: disassociated
Thu Jun 26 15:32:03 2014 daemon.info hostapd: wlan1-2: STA =
60:03:08:94:5d:c0 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:05 2014 daemon.info hostapd: wlan0-1: STA =
38:19:2f:f3:30:5c IEEE 802.11: disassociated
Thu Jun 26 15:32:06 2014 daemon.info hostapd: wlan0-1: STA =
38:19:2f:f3:30:5c IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:11 2014 daemon.info hostapd: wlan1-1: STA =
a8:88:08:14:75:66 IEEE 802.11: disassociated
Thu Jun 26 15:32:12 2014 daemon.info hostapd: wlan1-1: STA =
a8:88:08:14:75:66 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:13 2014 kern.warn kernel: [15486.880000] net_ratelimit: =
1412 callbacks suppressed
Thu Jun 26 15:32:18 2014 daemon.info hostapd: wlan0-1: STA =
44:a7:cf:bf:de:85 IEEE 802.11: authenticated
Thu Jun 26 15:32:18 2014 daemon.info hostapd: wlan0-1: STA =
44:a7:cf:bf:de:85 IEEE 802.11: associated (aid 4)
Thu Jun 26 15:32:18 2014 kern.warn kernel: [15491.890000] net_ratelimit: =
3174 callbacks suppressed
Thu Jun 26 15:32:23 2014 kern.err kernel: [15496.510000] ath: phy1: =
Failed to stop TX DMA, queues=3D0x00d!
Thu Jun 26 15:32:24 2014 daemon.info hostapd: wlan1-2: STA =
48:74:6e:99:18:0b IEEE 802.11: authenticated
Thu Jun 26 15:32:24 2014 daemon.info hostapd: wlan1-2: STA =
48:74:6e:99:18:0b IEEE 802.11: associated (aid 32)
Thu Jun 26 15:32:26 2014 daemon.info hostapd: wlan1-2: STA =
90:b9:31:7b:0d:b4 IEEE 802.11: disassociated
Thu Jun 26 15:32:27 2014 daemon.info hostapd: wlan1-2: STA =
90:b9:31:7b:0d:b4 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:28 2014 daemon.info hostapd: wlan1-2: STA =
b8:e8:56:87:83:89 IEEE 802.11: authenticated
Thu Jun 26 15:32:28 2014 daemon.info hostapd: wlan1-2: STA =
b8:e8:56:87:83:89 IEEE 802.11: associated (aid 33)
Thu Jun 26 15:32:34 2014 daemon.info hostapd: wlan0-1: STA =
48:60:bc:d3:75:0c IEEE 802.11: authenticated
Thu Jun 26 15:32:35 2014 daemon.info hostapd: wlan0-1: STA =
48:60:bc:d3:75:0c IEEE 802.11: associated (aid 1)
Thu Jun 26 15:32:37 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: authenticated
Thu Jun 26 15:32:37 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: associated (aid 13)
Thu Jun 26 15:32:37 2014 daemon.info hostapd: wlan1-2: STA =
90:b9:31:7b:0d:b4 IEEE 802.11: authenticated
Thu Jun 26 15:32:37 2014 daemon.info hostapd: wlan1-2: STA =
90:b9:31:7b:0d:b4 IEEE 802.11: associated (aid 41)
Thu Jun 26 15:32:38 2014 kern.warn kernel: [15511.960000] net_ratelimit: =
25 callbacks suppressed
Thu Jun 26 15:32:41 2014 daemon.info hostapd: wlan1-2: STA =
18:af:61:1d:4c:7f IEEE 802.11: disassociated
Thu Jun 26 15:32:42 2014 daemon.info hostapd: wlan1-2: STA =
18:af:61:1d:4c:7f IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:43 2014 kern.warn kernel: [15516.980000] net_ratelimit: =
2225 callbacks suppressed
Thu Jun 26 15:32:50 2014 daemon.info hostapd: wlan1-1: STA =
60:d9:c7:2b:48:70 IEEE 802.11: disassociated
Thu Jun 26 15:32:51 2014 daemon.info hostapd: wlan1-1: STA =
60:d9:c7:2b:48:70 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:54 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: disassociated
Thu Jun 26 15:32:55 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:32:59 2014 daemon.info hostapd: wlan1-2: STA =
ac:fd:ec:eb:1d:5e IEEE 802.11: disassociated
Thu Jun 26 15:33:00 2014 daemon.info hostapd: wlan1-2: STA =
ac:fd:ec:eb:1d:5e IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:33:04 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: authenticated
Thu Jun 26 15:33:04 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: associated (aid 7)
Thu Jun 26 15:33:05 2014 daemon.info hostapd: wlan0-1: STA =
3c:d0:f8:54:1c:fa IEEE 802.11: authenticated
Thu Jun 26 15:33:05 2014 daemon.info hostapd: wlan0-1: STA =
3c:d0:f8:54:1c:fa IEEE 802.11: associated (aid 26)
Thu Jun 26 15:33:07 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: disassociated
Thu Jun 26 15:33:10 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: authenticated
Thu Jun 26 15:33:10 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: associated (aid 13)
Thu Jun 26 15:33:11 2014 daemon.info hostapd: wlan0-1: STA =
3c:d0:f8:54:1c:fa IEEE 802.11: disassociated
Thu Jun 26 15:33:12 2014 daemon.info hostapd: wlan0-1: STA =
3c:d0:f8:54:1c:fa IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:33:13 2014 kern.warn kernel: [15547.050000] net_ratelimit: =
3615 callbacks suppressed
Thu Jun 26 15:33:14 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: authenticated
Thu Jun 26 15:33:14 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: associated (aid 26)
Thu Jun 26 15:33:21 2014 daemon.info hostapd: wlan0-1: STA =
10:68:3f:fe:6c:35 IEEE 802.11: authenticated
Thu Jun 26 15:33:21 2014 daemon.info hostapd: wlan0-1: STA =
10:68:3f:fe:6c:35 IEEE 802.11: associated (aid 28)
Thu Jun 26 15:33:24 2014 kern.warn kernel: [15557.090000] net_ratelimit: =
88 callbacks suppressed
Thu Jun 26 15:33:29 2014 kern.warn kernel: [15562.110000] net_ratelimit: =
3295 callbacks suppressed
Thu Jun 26 15:33:30 2014 daemon.info hostapd: wlan0-1: STA =
10:68:3f:fe:6c:35 IEEE 802.11: disassociated
Thu Jun 26 15:33:31 2014 daemon.info hostapd: wlan0-1: STA =
10:68:3f:fe:6c:35 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:33:32 2014 daemon.info hostapd: wlan1-1: STA =
d8:50:e6:2e:45:77 IEEE 802.11: authenticated
Thu Jun 26 15:33:32 2014 daemon.info hostapd: wlan1-1: STA =
d8:50:e6:2e:45:77 IEEE 802.11: associated (aid 26)
Thu Jun 26 15:33:34 2014 kern.warn kernel: [15567.130000] net_ratelimit: =
2295 callbacks suppressed
Thu Jun 26 15:33:34 2014 daemon.info hostapd: wlan1-2: STA =
e4:ce:8f:0f:39:9a IEEE 802.11: authenticated
Thu Jun 26 15:33:34 2014 daemon.info hostapd: wlan1-2: STA =
e4:ce:8f:0f:39:9a IEEE 802.11: associated (aid 3)
Thu Jun 26 15:33:35 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: disassociated
Thu Jun 26 15:33:36 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:33:37 2014 daemon.info hostapd: wlan0-1: STA =
7c:c5:37:59:ce:45 IEEE 802.11: authenticated
Thu Jun 26 15:33:37 2014 daemon.info hostapd: wlan0-1: STA =
7c:c5:37:59:ce:45 IEEE 802.11: associated (aid 7)
Thu Jun 26 15:33:38 2014 daemon.info hostapd: wlan0-1: STA =
8c:3a:e3:49:55:42 IEEE 802.11: authenticated
Thu Jun 26 15:33:38 2014 daemon.info hostapd: wlan0-1: STA =
8c:3a:e3:49:55:42 IEEE 802.11: associated (aid 28)
Thu Jun 26 15:33:39 2014 daemon.info hostapd: wlan0-1: STA =
48:60:bc:d3:75:0c IEEE 802.11: disassociated
Thu Jun 26 15:33:39 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: authenticated
Thu Jun 26 15:33:39 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: associated (aid 32)
Thu Jun 26 15:33:40 2014 daemon.info hostapd: wlan0-1: STA =
48:60:bc:d3:75:0c IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:33:41 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: disassociated
Thu Jun 26 15:33:41 2014 daemon.info hostapd: wlan1-1: STA =
60:d9:c7:2b:48:70 IEEE 802.11: authenticated
Thu Jun 26 15:33:41 2014 daemon.info hostapd: wlan1-1: STA =
60:d9:c7:2b:48:70 IEEE 802.11: associated (aid 2)
Thu Jun 26 15:33:42 2014 daemon.info hostapd: wlan1-2: STA =
54:26:96:db:8b:df IEEE 802.11: authenticated
Thu Jun 26 15:33:42 2014 daemon.info hostapd: wlan1-2: STA =
54:26:96:db:8b:df IEEE 802.11: associated (aid 15)
Thu Jun 26 15:33:43 2014 daemon.info hostapd: wlan0-1: STA =
e4:8b:7f:76:4c:1a IEEE 802.11: authenticated
Thu Jun 26 15:33:43 2014 daemon.info hostapd: wlan0-1: STA =
e4:8b:7f:76:4c:1a IEEE 802.11: associated (aid 1)
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:43 2014 daemon.notice hostapd: wlan1-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: did not acknowledge authentication =
response
Thu Jun 26 15:33:44 2014 kern.warn kernel: [15577.090000] net_ratelimit: =
1121 callbacks suppressed
Thu Jun 26 15:33:44 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: authenticated
Thu Jun 26 15:33:44 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: associated (aid 13)
Thu Jun 26 15:33:45 2014 kern.err kernel: [15578.530000] ath: phy1: =
Failed to stop TX DMA, queues=3D0x00d!
Thu Jun 26 15:33:48 2014 daemon.info hostapd: wlan1-2: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: deauthenticated due to local deauth =
request
Thu Jun 26 15:33:49 2014 kern.warn kernel: [15582.140000] net_ratelimit: =
1196 callbacks suppressed
Thu Jun 26 15:33:49 2014 daemon.info hostapd: wlan1-1: STA =
70:de:e2:f2:c1:37 IEEE 802.11: authenticated
Thu Jun 26 15:33:49 2014 daemon.info hostapd: wlan1-1: STA =
70:de:e2:f2:c1:37 IEEE 802.11: associated (aid 28)
Thu Jun 26 15:33:50 2014 daemon.info hostapd: wlan1-2: STA =
68:9c:70:86:34:4b IEEE 802.11: disassociated
Thu Jun 26 15:33:51 2014 daemon.info hostapd: wlan1-2: STA =
68:9c:70:86:34:4b IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:33:54 2014 daemon.info hostapd: wlan1-2: STA =
c0:63:94:77:13:6e IEEE 802.11: authenticated
Thu Jun 26 15:33:54 2014 daemon.info hostapd: wlan1-2: STA =
c0:63:94:77:13:6e IEEE 802.11: associated (aid 34)
Thu Jun 26 15:33:55 2014 daemon.info hostapd: wlan1-2: STA =
54:26:96:db:8b:df IEEE 802.11: disassociated
Thu Jun 26 15:33:56 2014 daemon.info hostapd: wlan1-2: STA =
54:26:96:db:8b:df IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:06 2014 daemon.info hostapd: wlan1-1: STA =
7c:d1:c3:f5:5c:d3 IEEE 802.11: authenticated
Thu Jun 26 15:34:06 2014 daemon.info hostapd: wlan1-1: STA =
7c:d1:c3:f5:5c:d3 IEEE 802.11: associated (aid 30)
Thu Jun 26 15:34:07 2014 daemon.info hostapd: wlan1-2: STA =
18:20:32:9e:a7:43 IEEE 802.11: disassociated
Thu Jun 26 15:34:08 2014 daemon.info hostapd: wlan1-2: STA =
18:20:32:9e:a7:43 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:09 2014 daemon.info hostapd: wlan0-1: STA =
8c:3a:e3:49:55:42 IEEE 802.11: disassociated
Thu Jun 26 15:34:10 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: disassociated
Thu Jun 26 15:34:11 2014 daemon.info hostapd: wlan0-1: STA =
90:18:7c:fc:c5:f0 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:12 2014 daemon.info hostapd: wlan1-1: STA =
8c:3a:e3:49:55:42 IEEE 802.11: authenticated
Thu Jun 26 15:34:12 2014 daemon.info hostapd: wlan1-1: STA =
8c:3a:e3:49:55:42 IEEE 802.11: associated (aid 31)
Thu Jun 26 15:34:14 2014 kern.warn kernel: [15607.190000] net_ratelimit: =
1325 callbacks suppressed
Thu Jun 26 15:34:14 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: disassociated
Thu Jun 26 15:34:14 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: disassociated
Thu Jun 26 15:34:15 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:15 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: authenticated
Thu Jun 26 15:34:15 2014 daemon.info hostapd: wlan0-1: STA =
b4:f0:ab:9b:b0:94 IEEE 802.11: associated (aid 13)
Thu Jun 26 15:34:19 2014 daemon.info hostapd: wlan1-1: STA =
48:74:6e:59:a6:5b IEEE 802.11: disassociated due to inactivity
Thu Jun 26 15:34:20 2014 daemon.info hostapd: wlan1-2: STA =
78:6c:1c:d9:bc:ff IEEE 802.11: disassociated
Thu Jun 26 15:34:20 2014 daemon.info hostapd: wlan1-1: STA =
48:74:6e:59:a6:5b IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:21 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: authenticated
Thu Jun 26 15:34:21 2014 daemon.info hostapd: wlan0-1: STA =
bc:f5:ac:b5:10:88 IEEE 802.11: associated (aid 26)
Thu Jun 26 15:34:21 2014 daemon.info hostapd: wlan1-2: STA =
78:6c:1c:d9:bc:ff IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:27 2014 daemon.info hostapd: wlan0-1: STA =
a8:88:08:14:75:66 IEEE 802.11: disassociated due to inactivity
Thu Jun 26 15:34:29 2014 daemon.info hostapd: wlan0-1: STA =
a8:88:08:14:75:66 IEEE 802.11: deauthenticated due to inactivity (timer =
DEAUTH/REMOVE)
Thu Jun 26 15:34:29 2014 kern.warn kernel: [15622.270000] net_ratelimit: =
16 callbacks suppressed



