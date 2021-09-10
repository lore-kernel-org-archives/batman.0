Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: Bonding Alternating
From: brian.edmisten@viasat.com
Date: Fri, 10 Sep 2021 17:59:54 -0000
Message-ID: <20210910175954.1147.78979@diktynna.open-mesh.org>
In-Reply-To: <8679334.VDzE56WMh6@prime>
References: <8679334.VDzE56WMh6@prime>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Simon,

Thanks for responding.  We are trying out some different solutions for bonding these radios.  For scenarios BATMAN seems really well suited for the problem but we wanted to test this one and see how much work we need to put into it.  I saw the same behavior with IV but I'll switch back and check on it.  While its up though here is what I am seeing with V.

batctl o
[B.A.T.M.A.N. adv 2019.4, MainIF/MAC: eth0/00:0c:29:c5:d2:da (bat0/de:8b:cc:39:d0:69 BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
   00:0c:29:53:f8:c9    0.320s (    10000.0)  00:0c:29:53:f8:dd [      eth2]
   00:0c:29:53:f8:c9    0.320s (    10000.0)  00:0c:29:53:f8:d3 [      eth1]
 * 00:0c:29:53:f8:c9    0.320s (    10000.0)  00:0c:29:53:f8:c9 [      eth0]

batctl n
[B.A.T.M.A.N. adv 2019.4, MainIF/MAC: eth0/00:0c:29:c5:d2:da (bat0/de:8b:cc:39:d0:69 BATMAN_V)]
IF             Neighbor              last-seen
00:0c:29:53:f8:c9    0.436s (    10000.0) [      eth0]
00:0c:29:53:f8:d3    0.340s (    10000.0) [      eth1]
00:0c:29:53:f8:dd    0.116s (    10000.0) [      eth2]

batctl tg
[B.A.T.M.A.N. adv 2019.4, MainIF/MAC: eth0/00:0c:29:c5:d2:da (bat0/de:8b:cc:39:d0:69 BATMAN_V)]
   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )
 * 33:33:00:00:00:02   -1 [....] (  1) 00:0c:29:53:f8:c9 (  2) (0x6b62ac80)
 * 01:00:5e:00:00:01   -1 [....] (  2) 00:0c:29:53:f8:c9 (  2) (0x6b62ac80)
 * 4e:b3:25:58:bd:15   -1 [....] (  1) 00:0c:29:53:f8:c9 (  2) (0x6b62ac80)
 * 33:33:00:00:00:01   -1 [....] (  1) 00:0c:29:53:f8:c9 (  2) (0x6b62ac80)

I do not directly see any of the commands outputting transmit quality  I would expect the three ethernet nics to be the same but it is an assumption.

Here is the same info under IV
batctl o
[B.A.T.M.A.N. adv 2019.4, MainIF/MAC: eth2/00:0c:29:c5:d2:ee (bat0/f2:49:86:e6:ea:aa BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * 00:0c:29:53:f8:d3    0.976s   (255) 00:0c:29:53:f8:d3 [      eth1]
 * 00:0c:29:53:f8:c9    0.944s   (251) 00:0c:29:53:f8:c9 [      eth0]
 * 00:0c:29:53:f8:dd    0.368s   (255) 00:0c:29:53:f8:c9 [      eth0]
   00:0c:29:53:f8:dd    0.368s   (255) 00:0c:29:53:f8:d3 [      eth1]
   00:0c:29:53:f8:dd    0.368s   (252) 00:0c:29:53:f8:dd [      eth2]

batctl n
[B.A.T.M.A.N. adv 2019.4, MainIF/MAC: eth2/00:0c:29:c5:d2:ee (bat0/f2:49:86:e6:ea:aa BATMAN_IV)]
IF             Neighbor              last-seen
         eth0     00:0c:29:53:f8:c9    0.032s
         eth1     00:0c:29:53:f8:d3    0.992s
         eth2     00:0c:29:53:f8:dd    0.384s

batctl tg
[B.A.T.M.A.N. adv 2019.4, MainIF/MAC: eth2/00:0c:29:c5:d2:ee (bat0/f2:49:86:e6:ea:aa BATMAN_IV)]
   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )
 * 33:33:00:00:00:02   -1 [....] (  2) 00:0c:29:53:f8:dd (  3) (0x9339b660)
 * 01:00:5e:00:00:01   -1 [....] (  3) 00:0c:29:53:f8:dd (  3) (0x9339b660)
 * 2a:78:9d:5f:f3:f6   -1 [....] (  1) 00:0c:29:53:f8:dd (  3) (0x9339b660)
 * 33:33:00:00:00:01   -1 [....] (  2) 00:0c:29:53:f8:dd (  3) (0x9339b660)


Thank you again,
Brian
