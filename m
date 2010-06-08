Return-Path: <neumann@cgws.de>
From: Axel Neumann <neumann@cgws.de>
Date: Tue, 8 Jun 2010 18:32:39 +0200
References: <4C07CD29.7000505@gmail.com>
In-Reply-To: <4C07CD29.7000505@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201006081832.39301.neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] BMX, client node doesn't choose a gateway node.
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
To: sebastian.criado@gmail.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Donnerstag 03 Juni 2010, Sebasti=E1n D. Criado wrote:
> Hello,
>=20
> I'm having a problem with BMX when trying to make a client node
> connect to a gateway node.
>=20
> It's BatMan-eXp 0.3-rc1 rv1636 (compatibility version 10).
>=20
=2E..
>=20
> The start of the client node it's made with: /usr/sbin/bmxd dev=3Dath2
> -o 2000 -r 1
>=20
I could reproduce the problem. There is someting strange with -r [0..2]. On=
ly=20
=2Dr 3 seems working as expected in the current code.

Can you confirm if -r 3 works fine in your setup?
Meanwhile I'll check the code whats going on there...=20

Thanks for the report and sorry for the late response.
cu
/axel




>=20
>=20
> Here it's data from the debug:
>=20
> bmxd -cd1
> Originator       brc          Nexthop [outgoingIF]    Potential nexthops
> ... [MainIF/IP: ath2/5.217.236.96, UT:  0:00:14:26]
> 5.170.251.84    ( 87)   5.217.134.125 [      ath2]      5.255.22.64 ( 84)
> 5.217.134.125   ( 98)   5.217.134.125 [      ath2]      5.255.22.64 ( 98)
> 5.255.22.64     ( 99)     5.255.22.64 [      ath2]    5.217.134.125 ( 92)
>=20
> bmxd -cd2
>   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
>    5.217.134.125     5.217.134.125  98, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.255.22.64         5.255.22.64  99, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.170.251.84      5.217.134.125  86, gw_class 169 - 3MBit/768KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>=20
>=20
> bmxd -cd4
>=20
> ------------------ DEBUG ------------------
> Outstanding OGM for sending:
> 5.255.22.64       (seqno 13462  ttl  49)  at 899745
> 5.217.236.96      (seqno 60294  ttl  50)  at 900000
> 5.217.134.125     (seqno 35844  ttl  49)  at 900086
>=20
> BMX 0.3-rc1 rv1636, 5.217.236.96, LWS 20, PWS 100, OGI 2000ms, UT
> 0:00:15:00, CPU 1.1
>=20
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125    99 100  99      35844    0
>  7   1
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13462    0
>  2   2
>=20
> Originator      outgoingIF bestNextHop      TQ(rcnt) knownSince
> lsqn(diff) lvld pws ~ogi cpu hop
> 5.170.251.84    ath2       5.217.134.125    88  93   0:00:13:24 57688
> 0     1 100 2013   1   2
> 5.217.134.125   ath2       5.217.134.125    98  99   0:00:14:58 35844
> 0     0 100 2026   9   1
> 5.255.22.64     ath2       5.255.22.64      99 100   0:00:14:59 13462
> 0     0 100 1973   1   1
>        3 known Originator(s), averages:     95  97
>       0 100 2004   3   1
>=20
> Originator      Announced networks HNAs:  network/netmask or
> interface/IF (B:blocked)...
>=20
>   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
>    5.217.134.125     5.217.134.125  98, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.255.22.64         5.255.22.64  99, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.170.251.84      5.217.134.125  88, gw_class 169 - 3MBit/768KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>=20
> Originator      Announced services ip:port:seqno ...
>=20
> --------------- END DEBUG ---------------
> ------------------ DEBUG ------------------
> Outstanding OGM for sending:
> 5.170.251.84      (seqno 57689  ttl  48)  at 900886
> 5.217.236.96      (seqno 60295  ttl  50)  at 902000
>=20
> BMX 0.3-rc1 rv1636, 5.217.236.96, LWS 20, PWS 100, OGI 2000ms, UT
> 0:00:15:01, CPU 1.1
>=20
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125    99 100  99      35844    1
>  7   1
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13462    1
>  2   2
>=20
> Originator      outgoingIF bestNextHop      TQ(rcnt) knownSince
> lsqn(diff) lvld pws ~ogi cpu hop
> 5.170.251.84    ath2       5.217.134.125    88  94   0:00:13:25 57689
> 0     0 100 1985   1   2
> 5.217.134.125   ath2       5.217.134.125    98  99   0:00:14:59 35844
> 0     1 100 2026   9   1
> 5.255.22.64     ath2       5.255.22.64      99 100   0:00:15:00 13462
> 0     1 100 1973   1   1
>        3 known Originator(s), averages:     95  97
>       0 100 1994   3   1
>=20
> Originator      Announced networks HNAs:  network/netmask or
> interface/IF (B:blocked)...
>=20
>   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
>    5.217.134.125     5.217.134.125  98, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.255.22.64         5.255.22.64  99, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.170.251.84      5.217.134.125  88, gw_class 169 - 3MBit/768KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>=20
> Originator      Announced services ip:port:seqno ...
>=20
> --------------- END DEBUG ---------------
> ------------------ DEBUG ------------------
> Outstanding OGM for sending:
> 5.217.134.125     (seqno 35845  ttl  49)  at 902186
> 5.217.236.96      (seqno 60296  ttl  50)  at 904000
>=20
> BMX 0.3-rc1 rv1636, 5.217.236.96, LWS 20, PWS 100, OGI 2000ms, UT
> 0:00:15:02, CPU 0.9
>=20
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125    99 100  99      35845    0
>  7   1
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13463    1
>  2   2
>=20
> Originator      outgoingIF bestNextHop      TQ(rcnt) knownSince
> lsqn(diff) lvld pws ~ogi cpu hop
> 5.170.251.84    ath2       5.217.134.125    88  94   0:00:13:26 57689
> 0     2 100 1985   1   2
> 5.217.134.125   ath2       5.217.134.125    98  99   0:00:15:00 35845
> 0     0 100 2035   3   1
> 5.255.22.64     ath2       5.255.22.64      99 100   0:00:15:01 13463
> 0     1 100 1977   1   1
>        3 known Originator(s), averages:     95  97
>       1 100 1999   1   1
>=20
> Originator      Announced networks HNAs:  network/netmask or
> interface/IF (B:blocked)...
>=20
>   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
>    5.217.134.125     5.217.134.125  98, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.255.22.64         5.255.22.64  99, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.170.251.84      5.217.134.125  88, gw_class 169 - 3MBit/768KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>=20
> Originator      Announced services ip:port:seqno ...
>=20
> --------------- END DEBUG ---------------
> ------------------ DEBUG ------------------
> Outstanding OGM for sending:
> 5.255.22.64       (seqno 13464  ttl  49)  at 903665
> 5.217.236.96      (seqno 60296  ttl  50)  at 904000
>=20
> BMX 0.3-rc1 rv1636, 5.217.236.96, LWS 20, PWS 100, OGI 2000ms, UT
> 0:00:15:04, CPU 0.9
>=20
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125    99 100  99      35845    1
>  7   1
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13464    0
>  2   2
>=20
> Originator      outgoingIF bestNextHop      TQ(rcnt) knownSince
> lsqn(diff) lvld pws ~ogi cpu hop
> 5.170.251.84    ath2       5.217.134.125    88  95   0:00:13:28 57690
> 0     0 100 2018   1   2
> 5.217.134.125   ath2       5.217.134.125    98  99   0:00:15:02 35845
> 0     1 100 2035   3   1
> 5.255.22.64     ath2       5.255.22.64      99 100   0:00:15:03 13464
> 0     0 100 1970   3   1
>        3 known Originator(s), averages:     95  98
>       0 100 2007   2   1
>=20
> Originator      Announced networks HNAs:  network/netmask or
> interface/IF (B:blocked)...
>=20
>   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
>    5.217.134.125     5.217.134.125  98, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.255.22.64         5.255.22.64  99, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.170.251.84      5.217.134.125  88, gw_class 169 - 3MBit/768KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>=20
> Originator      Announced services ip:port:seqno ...
>=20
> --------------- END DEBUG ---------------
> ------------------ DEBUG ------------------
> Outstanding OGM for sending:
> 5.170.251.84      (seqno 57691  ttl  48)  at 904905
> 5.217.236.96      (seqno 60297  ttl  50)  at 906000
>=20
> BMX 0.3-rc1 rv1636, 5.217.236.96, LWS 20, PWS 100, OGI 2000ms, UT
> 0:00:15:05, CPU 0.9
>=20
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125    99 100  99      35846    1
>  7   1
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13464    1
>  2   2
>=20
> Originator      outgoingIF bestNextHop      TQ(rcnt) knownSince
> lsqn(diff) lvld pws ~ogi cpu hop
> 5.170.251.84    ath2       5.217.134.125    88  95   0:00:13:29 57691
> 0     0 100 1987   1   2
> 5.217.134.125   ath2       5.217.134.125    98  99   0:00:15:03 35846
> 0     1 100 2031   3   1
> 5.255.22.64     ath2       5.255.22.64      99 100   0:00:15:04 13464
> 0     1 100 1970   3   1
>        3 known Originator(s), averages:     95  98
>       0 100 1996   2   1
>=20
> Originator      Announced networks HNAs:  network/netmask or
> interface/IF (B:blocked)...
>=20
>   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
>    5.217.134.125     5.217.134.125  98, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.255.22.64         5.255.22.64  99, gw_class 25 - 512KBit/128KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>    5.170.251.84      5.217.134.125  88, gw_class 169 - 3MBit/768KBit,
> reliability: 0, supported tunnel types 2WT, 1WT
>=20
> Originator      Announced services ip:port:seqno ...
>=20
> --------------- END DEBUG ---------------
>=20
>=20
> bmxd -cd5
>=20
> Memory usage information:
>    tag:  504, num malloc:    1, bytes per malloc:   44, total:     44
>    tag:  123, num malloc:    4, bytes per malloc:   10, total:     40
>    tag:  103, num malloc:    4, bytes per malloc:   16, total:     64
>    tag:  428, num malloc:    2, bytes per malloc:   20, total:     40
>    tag:  403, num malloc:    8, bytes per malloc:   44, total:    352
>    tag:  429, num malloc:    4, bytes per malloc:    8, total:     32
>    tag:  327, num malloc:   14, bytes per malloc:   16, total:    224
>    tag:  402, num malloc:    4, bytes per malloc:  104, total:    416
>    tag:  209, num malloc:    1, bytes per malloc: 1045, total:   1045
>    tag:  742, num malloc:    8, bytes per malloc:   16, total:    128
>    tag:  741, num malloc:    2, bytes per malloc:   24, total:     48
>    tag:  206, num malloc:    1, bytes per malloc: 1200, total:   1200
>    tag:  778, num malloc:    5, bytes per malloc:    5, total:     25
>    tag:  777, num malloc:    5, bytes per malloc:   24, total:    120
>    tag:  201, num malloc:    1, bytes per malloc:   20, total:     20
>    tag:  109, num malloc:    3, bytes per malloc:   16, total:     48
>    tag:  312, num malloc:    4, bytes per malloc:   24, total:     96
>    tag:  315, num malloc:    3, bytes per malloc:   12, total:     36
>=20
> bmxd -cd8
> BMX 0.3-rc1 rv1636, 5.217.236.96, LWS 20, PWS 100, OGI 2000ms, UT
> 0:00:05:19, CPU 3.0
>=20
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125   100 100 100      36095    0
>  7   2
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13711    1
>  2   1
>=20
> Originator      outgoingIF bestNextHop      TQ(rcnt) knownSince
> lsqn(diff) lvld pws ~ogi cpu hop
> 5.170.251.84    ath2       5.217.134.125    86  99   0:00:03:40 57940
> 0     0 100 2010   1   2
> 5.211.219.234   ath2       5.217.134.125     3  12   0:00:01:33 26027
> 0    62 100 1000   1   2
> 5.217.134.125   ath2       5.217.134.125    88 100   0:00:05:18 36095
> 0     0 100 1971   3   1
> 5.255.22.64     ath2       5.217.134.125    88  99   0:00:05:17 13711
> 0     1 100 2003   1   2
>        4 known Originator(s), averages:     66  77
>      15 100 1746   1   1
>=20
> bmxd -cd10
> Neighbor        viaIF      Originator      RTQ  RQ  TQ       lseq lvld
> rid nid
> 5.217.134.125   ath2       5.217.134.125   100 100 100      36117    0
>  7   2
> 5.255.22.64     ath2       5.255.22.64     100 100 100      13733    1
>  2   1
>=20
>=20
> /usr/sbin/bmxd dev=3Dath2 -o 2000 -r 1 -d 3
> [2718        0] INFO  resetting muted dbg history
> [2718        0] INFO  BatMan-eXp 0.3-rc1 rv1636 (compatibility version
> 10): /usr/sbin/bmxd dev=3Dath2 -o 2000 -r 1 -d 3
> [2718        0] INFO  add rule from 0.0.0.0/0  table 64  prio 6400  iif
> (null)  type 1
> [2718        0] INFO  add rule from 0.0.0.0/0  table 65  prio 6401  iif
> (null)  type 1
> [2718        0] INFO   add route to       127.0.0.0/8   table 65  via
> 0.0.0.0          dev lo         ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718        0] INFO   add route to   10.236.96.192/26  table 65  via
> 0.0.0.0          dev eth0       ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718        0] INFO   add route to     10.236.96.0/25  table 65  via
> 0.0.0.0          dev ath0       ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718        0] INFO   add route to   10.236.96.128/26  table 65  via
> 0.0.0.0          dev ath1       ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718        0] INFO  enabled wireless dev ath2 5.217.236.96/8 brc
> 5.255.255.255 (use ath2 /l=3D1 to optimize for ethernet)
> [2718      186] INFO  get_lndev(): creating new lndev      5.255.22.64
>      ath2 5.217.236.96
> [2718      186] INFO  found new gateway 5.255.22.64, announced by
> 5.255.22.64 -> class: 25 - 512KBit/128KBit, new supported tunnel types
> TWT, OWT
> [2718     1744] INFO  get_lndev(): creating new lndev    5.217.134.125
>      ath2 5.217.236.96
> [2718     1744] INFO  found new gateway 5.217.134.125, announced by
> 5.217.134.125 -> class: 25 - 512KBit/128KBit, new supported tunnel types
> TWT, OWT
> [2718    97400] INFO  change route to 5.217.134.125   via 5.217.134.125
>   ath2   2 / 100 (prev. via 0.0.0.0         --   0)
> [2718    97846] INFO  change route to 5.255.22.64     via 5.255.22.64
>   ath2   2 / 100 (prev. via 0.0.0.0         --   0)
> [2718    99630] INFO  found new gateway 5.170.251.84, announced by
> 5.170.251.84 -> class: 169 - 3MBit/768KBit, new supported tunnel types
> TWT, OWT
> [2718   101616] INFO  change route to 5.170.251.84    via 5.255.22.64
>   ath2   1 / 100 (prev. via 0.0.0.0         --   0)
> [2718   103160] INFO  change route to 5.170.251.84    via 5.217.134.125
>   ath2   2 / 100 (prev. via 5.255.22.64     ath2   1)
> [2718   113731] INFO  change route to 5.255.22.64     via 5.217.134.125
>   ath2  12 / 100 (prev. via 5.255.22.64     ath2   9)
> [2718   121286] INFO  change route to 5.217.134.125   via 5.255.22.64
>   ath2  19 / 100 (prev. via 5.217.134.125   ath2  17)
> [2718   134729] INFO  change route to 5.170.251.84    via 5.255.22.64
>   ath2  25 / 100 (prev. via 5.217.134.125   ath2  23)
> [2718   141059] INFO  change route to 5.217.134.125   via 5.217.134.125
>   ath2  31 / 100 (prev. via 5.255.22.64     ath2  30)
> [2718   144809] INFO  change route to 5.170.251.84    via 5.217.134.125
>   ath2  27 / 100 (prev. via 5.255.22.64     ath2  25)
> [2718   226464] INFO  change route to 5.211.219.234   via 5.217.134.125
>   ath2   2 / 100 (prev. via 0.0.0.0         --   0)
> [2718   226464] INFO  found new gateway 5.211.219.234, announced by
> 5.211.219.234 -> class: 161 - 1536KBit/384KBit, new supported tunnel
> types TWT, OWT
> [2718   357780] INFO  change route to 5.211.219.234   via 0.0.0.0
>   --   0 / 100 (prev. via 5.217.134.125   ath2   0)
> [2718   357780] INFO  Gateway class of originator 5.211.219.234 changed
> from 161 to 0, port 4306, addr 5.211.219.234, new supported tunnel types
> -, -
> [2718   357780] INFO  Gateway 5.211.219.234 removed from gateway list
> [2718   378477] INFO  change route to 5.255.22.64     via 5.255.22.64
>   ath2  93 / 100 (prev. via 5.217.134.125   ath2  92)
>=20
> *(CTRL+C pressed)
>=20
> ^C[2718   490754] ERROR handler(): called with signal 2
> [2718   490814] WARN  can't select! Waiting a moment! errno: Interrupted
> system call
> [2718   490818] INFO  change route to 5.170.251.84    via 0.0.0.0
>   --   0 / 100 (prev. via 5.217.134.125   ath2   0)
> [2718   490818] INFO  Gateway class of originator 5.170.251.84 changed
> from 169 to 0, port 4306, addr 5.170.251.84, new supported tunnel types -,
>  - [2718   490818] INFO  Gateway 5.170.251.84 removed from gateway list
>  [2718   490818] INFO  change route to 5.217.134.125   via 0.0.0.0
>   --   0 / 100 (prev. via 5.217.134.125   ath2   0)
> [2718   490818] INFO  Gateway class of originator 5.217.134.125 changed
> from 25 to 0, port 4306, addr 5.217.134.125, new supported tunnel types -,
>  - [2718   490818] INFO  Gateway 5.217.134.125 removed from gateway list
>  [2718   490818] INFO  change route to 5.255.22.64     via 0.0.0.0
>   --   0 / 100 (prev. via 5.255.22.64     ath2   0)
> [2718   490818] INFO  Gateway class of originator 5.255.22.64 changed
> from 25 to 0, port 4306, addr 5.255.22.64, new supported tunnel types -, -
> [2718   490818] INFO  Gateway 5.255.22.64 removed from gateway list
> [2718   490818] INFO  deactivating plugin bmx_hna_plugin
> [2718   490818] INFO  deactivating plugin bmx_vis_plugin
> [2718   490818] INFO  deactivating plugin bmx_tunnel_plugin
> [2718   490818] INFO  deactivating plugin bmx_srv_plugin
> [2718   490818] INFO   del route to       127.0.0.0/8   table 65  via
> 0.0.0.0          dev (null)     ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718   490818] INFO   del route to   10.236.96.192/26  table 65  via
> 0.0.0.0          dev (null)     ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718   490818] INFO   del route to     10.236.96.0/25  table 65  via
> 0.0.0.0          dev (null)     ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718   490818] INFO   del route to   10.236.96.128/26  table 65  via
> 0.0.0.0          dev (null)     ifi  0  RTN_THROW   TRACK_MY_HNA
> [2718   490818] INFO  del rule from 0.0.0.0/0  table 64  prio 6400  iif
> (null)  type 1
> [2718   490818] INFO  del rule from 0.0.0.0/0  table 65  prio 6401  iif
> (null)  type 1
> [2718   490818] WARN  deactivating IF ath2       5.217.236.96
>=20

