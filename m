Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 21 Jan 2010 15:12:27 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <201001210632.19709.lindner_marek@yahoo.de>
Message-ID: <20100121141227.319490@gmx.net>
MIME-Version: 1.0
References: <20100119145806.275330@gmx.net>
	<201001201015.59477.lindner_marek@yahoo.de>	<20100120131234.4760@gmx.net>
	<201001210632.19709.lindner_marek@yahoo.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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


-------- Original-Nachricht --------
> Datum: Thu, 21 Jan 2010 06:32:19 +0800
> Von: Marek Lindner <lindner_marek@yahoo.de>

Hi,

Ok, here's another set:
---IN ARM DEVICE---
##> ifconfig
bat0      Link encap:Ethernet  HWaddr BE:8F:67:10:32:A9 =20
          inet addr:10.1.1.33  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1476  Metric:1
          RX packets:12 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:768 (768.0 B)  TX bytes:378 (378.0 B)

eth1      Link encap:Ethernet  HWaddr 00:11:F6:83:AF:1C =20
          inet addr:10.0.1.33  Bcast:10.0.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9842 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17276 errors:5 dropped:0 overruns:0 carrier:5
          collisions:0 txqueuelen:1000=20
          RX bytes:320656 (313.1 KiB)  TX bytes:3038557 (2.8 MiB)

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:7 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:784 (784.0 B)  TX bytes:784 (784.0 B)
##> cat /proc/net/batman-adv/interfaces=20
[  active] eth1 00:11:f6:83:af:1c=20
##> cat /proc/net/batman-adv/originators=20
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nextho=
ps ... [B.A.T.M.A.N. adv 0.3.0-alpha r1559, MainIF/MAC: eth1/00:11:f6:83:af=
:1c]=20
No batman nodes in range ...=20
##> route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Ifa=
ce
10.0.1.0        *               255.255.255.0   U     0      0        0 eth1
10.0.0.0        *               255.0.0.0       U     0      0        0 bat0
224.0.0.0       *               240.0.0.0       U     0      0        0 eth1
##> ping -c 3 10.0.1.40
PING 10.0.1.40 (10.0.1.40): 56 data bytes
64 bytes from 10.0.1.40: seq=3D0 ttl=3D64 time=3D19.123 ms
64 bytes from 10.0.1.40: seq=3D1 ttl=3D64 time=3D7.077 ms
64 bytes from 10.0.1.40: seq=3D2 ttl=3D64 time=3D7.239 ms

--- 10.0.1.40 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max =3D 7.077/11.146/19.123 ms
---
And the same set from the laptop counterpart:
---LAPTOP---
ylo@ylo-laptop:~$ ifconfig=20
bat0      Link encap:Ethernet  HWaddr 26:22:26:1b:f4:f5 =20
          inet addr:10.1.1.40  Bcast:10.255.255.255  Mask:255.0.0.0
          inet6 addr: fe80::2422:26ff:fe1b:f4f5/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1476  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:936 (936.0 B)

eth0      Link encap:Ethernet  HWaddr 00:24:7e:68:bf:10 =20
          inet addr:10.10.10.126  Bcast:10.10.10.255  Mask:255.255.255.0
          inet6 addr: fe80::224:7eff:fe68:bf10/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1370811 errors:0 dropped:0 overruns:0 frame:0
          TX packets:613889 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:1847455539 (1.8 GB)  TX bytes:54536457 (54.5 MB)
          Memory:fc000000-fc020000=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:3060 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3060 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:817467 (817.4 KB)  TX bytes:817467 (817.4 KB)

wlan0     Link encap:Ethernet  HWaddr 00:22:fa:dc:9a:ce =20
          inet addr:10.0.1.40  Bcast:10.0.1.255  Mask:255.255.255.0
          inet6 addr: fe80::222:faff:fedc:9ace/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:37473 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5862 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:10662970 (10.6 MB)  TX bytes:539481 (539.4 KB)

wmaster0  Link encap:UNSPEC  HWaddr 00-22-FA-DC-9A-CE-61-63-00-00-00-00-00-=
00-00-00 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
ylo@ylo-laptop:~$ cat /proc/net/batman-adv/interfaces=20
[  active] wlan0 00:22:fa:dc:9a:ce=20
ylo@ylo-laptop:~$ cat /proc/net/batman-adv/originators=20
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nextho=
ps ... [B.A.T.M.A.N. adv 0.3.0-alpha r1559, MainIF/MAC: wlan0/00:22:fa:dc:9=
a:ce]=20
No batman nodes in range ...=20
ylo@ylo-laptop:~$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Ifa=
ce
10.0.1.0        *               255.255.255.0   U     0      0        0 wla=
n0
10.10.10.0      *               255.255.255.0   U     0      0        0 eth0
link-local      *               255.255.0.0     U     1000   0        0 eth0
10.0.0.0        *               255.0.0.0       U     0      0        0 bat0
default         10.10.10.1      0.0.0.0         UG    100    0        0 eth0
ylo@ylo-laptop:~$ ping -c 3 10.0.1.33
PING 10.0.1.33 (10.0.1.33) 56(84) bytes of data.
64 bytes from 10.0.1.33: icmp_seq=3D1 ttl=3D64 time=3D6.08 ms
64 bytes from 10.0.1.33: icmp_seq=3D2 ttl=3D64 time=3D5.71 ms
64 bytes from 10.0.1.33: icmp_seq=3D3 ttl=3D64 time=3D5.59 ms

--- 10.0.1.33 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev =3D 5.596/5.797/6.082/0.224 ms
---

> It might be useful to join us on irc to speed things up. Is that an option
> for=20
> you ? We idle in #batman on irc.freenode.org.

Yeah, I've been lurking there for a while, but being so much on/off from th=
e computer lately it's been easier to email. I'll certainly begin bugging Y=
ou through irc once I have time to sit down for a while..=3D)

-Juha
--=20
Haiti-Nothilfe! Helfen Sie per SMS: Sende UIHAITI an die Nummer 81190.
Von 5 Euro je SMS (zzgl. SMS-Geb=FChr) gehen 4,83 Euro an UNICEF.
