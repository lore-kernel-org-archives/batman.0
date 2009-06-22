Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200906222224.43917.sven.eckelmann@gmx.de>
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906200323.44115.sven.eckelmann@gmx.de>
	<5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
	<200906222224.43917.sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 15:06:00 -0600
Message-ID: <5161afcd0906221406w5682774fu900bab1f4ca9d11b@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Mon, Jun 22, 2009 at 2:24 PM, Sven Eckelmann<sven.eckelmann@gmx.de> wrote:
> Ok, setting mtu of ath0's to 1524 and of bat0 to 1500 should help here. Just
> for the sake of completeness: Is there bridging involved in the workstations
> or any icmp filtering on the workstations/nanostations?
>

This is working:

ath0      Link encap:Ethernet  HWaddr 00:15:6D:A7:6A:9E
          UP BROADCAST RUNNING MULTICAST  MTU:1524  Metric:1
          RX packets:17374 errors:0 dropped:3 overruns:0 frame:0
          TX packets:8607 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:888966 (868.1 KiB)  TX bytes:500867 (489.1 KiB)

bat0      Link encap:Ethernet  HWaddr 00:FF:54:AD:F9:38
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:294 errors:0 dropped:0 overruns:0 frame:0
          TX packets:201 errors:0 dropped:17 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:37915 (37.0 KiB)  TX bytes:37156 (36.2 KiB)

br-lan    Link encap:Ethernet  HWaddr 00:15:6D:A8:6A:9E
          inet addr:192.168.1.102  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:291 errors:0 dropped:0 overruns:0 frame:0
          TX packets:161 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:20754 (20.2 KiB)  TX bytes:20798 (20.3 KiB)

eth0      Link encap:Ethernet  HWaddr 00:15:6D:A8:6A:9E
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4489 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1076 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:404668 (395.1 KiB)  TX bytes:131363 (128.2 KiB)
          Interrupt:4 Base address:0x1000

wifi0     Link encap:UNSPEC  HWaddr
00-15-6D-A7-6A-9E-00-00-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:53947 errors:0 dropped:0 overruns:0 frame:486
          TX packets:9433 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:195
          RX bytes:8828675 (8.4 MiB)  TX bytes:741681 (724.2 KiB)
          Interrupt:3 Memory:b0000000-b000ffff
