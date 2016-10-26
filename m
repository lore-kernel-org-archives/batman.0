Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <581058E6.4080706@yahoo.com>
Date: Wed, 26 Oct 2016 15:19:02 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: Whether Batman-adv need suitable wifi network card (support
 interface modes ( mesh point ) ) .
References: <580F251E.7060400@yahoo.com> <580FE89F.1090808@yahoo.com>
 <580FFD64.7020704@yahoo.com> <4752844.Su7blveJaV@bentobox>
In-Reply-To: <4752844.Su7blveJaV@bentobox>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hello Sven:






HostB wlan0 : mac addr : ether 00:1d:43:10:15:44

HostA wlan0 : mac addr: ether c8:3a:35:c9:ce:71




i run the command at Host A ( Rt2070 ) at ( ping HostA from HostB)
iw dev wlan0 station dump:
Station 00:1d:43:10:15:44 (on wlan0)
inactive time: 140 ms
rx bytes: 4977553
rx packets: 126014
tx bytes: 0
tx packets: 0
tx retries: 0
tx failed: 0
rx drop misc: 0
signal: -39 dBm
signal avg: -39 dBm
tx bitrate: 1.0 MBit/s
rx bitrate: 1.0 MBit/s
authorized: yes
authenticated: yes
associated: yes
preamble: long
WMM/WME: no
MFP: no
TDLS peer: no
DTIM period: 0
beacon interval:100
connected time: 10084 seconds

[root@alarmpi ~]# tcpdump -i bat0

07:01:40.635517 ARP, Reply 0.0.0.0 is-at 43:05:43:05:00:00 (oui 
Unknown), length 28
07:01:50.655521 ARP, Reply 0.0.0.0 is-at 43:05:43:05:00:00 (oui 
Unknown), length 28

[root@alarmpi ~]# tcpdump -i wlan0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on wlan0, link-type EN10MB (Ethernet), capture size 262144 bytes
07:02:35.815528 c8:3a:35:c9:ce:71 (oui Unknown) > Broadcast, ethertype 
Unknown (0x4305), length 66:
0x0000: 000f 3202 d7e6 278c c83a 35c9 ce71 c83a ..2...'..:5..q.:
0x0010: 35c9 ce71 00ff 001c 0401 000c 0104 0001 5..q............
0x0020: 48b5 3b30 0000 0000 0601 0004 0000 0000 H.;0............
0x0030: 0201 0000


and i ping ip address belong to hostB (wlan0 )from HostA and it will be 
fine .

batctl o No batman nodes in range

-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

and i run same command at Host B ( RTL8188CUS ) at ( ping HostB from HostA)

iw dev wlan0 station dump:

" is blank "

[root@alarmpi ~]# tcpdump -i bat0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on bat0, link-type EN10MB (Ethernet), capture size 262144 bytes
06:55:51.505401 ARP, Request who-has bogon tell bogon, length 28
06:55:51.506177 ARP, Reply bogon is-at a6:b8:8a:11:be:a2 (oui Unknown), 
length 28

tcpdump -i wlan0

06:57:11.425351 c8:3a:35:c9:ce:71 (oui Unknown) > Broadcast, ethertype 
Unknown (0x4305), length 66:
0x0000: 000f 3202 d7e6 2649 c83a 35c9 ce71 c83a ..2...&I.:5..q.:
0x0010: 35c9 ce71 00ff 001c 0401 000c 0104 0001 5..q............
0x0020: 48b5 3b30 0000 0000 0601 0004 0000 0000 H.;0............
0x0030: 0201 0000 ....
06:57:11.534759 00:1d:43:10:15:44 (oui Unknown) > Broadcast, ethertype 
Unknown (0x4305), length 66:
0x0000: 000f 3105 d7e6 2649 c83a 35c9 ce71 c83a ..1...&I.:5..q.:
0x0010: 35c9 ce71 0000 001c 0401 000c 0104 0001 5..q............
0x0020: 48b5 3b30 0000 0000 0601 0004 0000 0000 H.;0............
0x0030: 0201 0000


and i ping ip address belong to hostA wlan0 from HostB and it will be fine .

batctl o No batman nodes in range


------------------------------------------------------------------------------------------------------------

And i thought Rt2070 support Broadcast and RTL8188CUS don't support 
Broadcast or send ...

because when i ping ip (RTL8188CUS) from Rt2070 , and i can see ping 
packet via (tcpdump -i bat0 ) and i can see Rt2070 mac addr via (tcpdump 
-i wlan0 ) at HOSTB,

but i ping ip (Rt2070) from RTL8188CUS and i can't see any ping packet 
from RTL8188CUS and i can't see RTL8188CUS mac via (tcpdump -i wlan0 ) 
at HOSTA


Whether it will be master reason ?


Thanks
...










于 2016年10月26日 14:07, Sven Eckelmann 写道:
> iw dev wlan0 station dump

