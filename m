Return-Path: <gbastien@versatic.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_QGGo54xoAHYO9YBP5zlcNQ)"
Message-id: <4FE1350E.9040807@versatic.net>
Date: Tue, 19 Jun 2012 22:27:26 -0400
From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
Subject: [B.A.T.M.A.N.] packets not processed by batman on eth0
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

This is a multi-part message in MIME format.

--Boundary_(ID_QGGo54xoAHYO9YBP5zlcNQ)
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello,

I talked to marec last week on irc (I'm tahini).  I have a linksys=20
router that runs batman on the eth0 interface and other routers or=20
laptops are connected to it.  Problem is, even though the batman packets=20
pass from the other machines to the linksys, it seems something weird=20
happens on the linksys and the interface is not recognized as a batman=20
neighbor.

As a follow-up with the discussion with marec, here is the detail of my=20
configuration and the logs I get from 3 machines.  It seems leon (the=20
linksys router) receives the packets, but does not process them.  I=20
updated to latest batman 2012.2 and still the same.

Can anyone help?

Thanks,
Genevi=E8ve



--Boundary_(ID_QGGo54xoAHYO9YBP5zlcNQ)
Content-type: text/plain; CHARSET=US-ASCII; name=batman_logs
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=batman_logs

Configuration:

leon:  Router with internet access.  Batman runs only on the eth0 interface
clarence:  bat0 is made of interfaces eth0 and wlan0.  eth0 of clarence and leon are connected together and can ping each other if I set them an ip personnally (not the bat0 ip)
gerard: a laptop with the wlan0 interface on batman.  It connects to clarence on wlan0 without any problem.

Problem:

leon is not seen by anyone and it does not see anyone either


Further notes:

clarence and gerard connected through bat0 on both eth0: no problem, they see each other
leon and gerard connected through bat0 on eth0: same as leon and clarence; they don't see each other



root@leon:~# batctl o
[B.A.T.M.A.N. adv 2012.1.0, MainIF/MAC: eth0/00:0c:41:14:e0:8f (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
No batman nodes in range ...

root@leon:~# batctl td eth0

01:44:17.245439 BAT gerard: OGM via neigh clarence_eth, seq 1968, tq 245, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 46
01:44:17.674480 BAT leon: OGM via neigh leon, seq 219, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 26
01:44:17.775413 BAT leon: OGM via neigh clarence_eth, seq 219, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 46
01:44:18.095426 BAT clarence_eth: OGM via neigh clarence_eth, seq 1643, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 46
01:44:18.255412 BAT gerard: OGM via neigh clarence_eth, seq 1969, tq 245, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 46
01:44:18.674414 BAT leon: OGM via neigh leon, seq 220, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 26
01:44:18.775439 BAT leon: OGM via neigh clarence_eth, seq 220, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 46
01:44:19.095459 BAT clarence_eth: OGM via neigh clarence_eth, seq 1644, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 46
01:44:19.255459 BAT gerard: OGM via neigh clarence_eth, seq 1970, tq 245, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 46
01:44:19.654408 BAT leon: OGM via neigh leon, seq 221, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 26
01:44:19.755477 BAT leon: OGM via neigh clarence_eth, seq 221, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 46
01:44:20.095513 BAT clarence_eth: OGM via neigh clarence_eth, seq 1645, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 46
01:44:20.255492 BAT gerard: OGM via neigh clarence_eth, seq 1971, tq 245, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 46
01:44:20.634400 BAT leon: OGM via neigh leon, seq 222, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 26
01:44:20.735679 BAT leon: OGM via neigh clarence_eth, seq 222, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 46
01:44:21.075527 BAT clarence_eth: OGM via neigh clarence_eth, seq 1646, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 46
01:44:21.245581 BAT gerard: OGM via neigh clarence_eth, seq 1972, tq 245, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 46
01:44:21.614410 BAT leon: OGM via neigh leon, seq 223, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 26
01:44:21.715557 BAT leon: OGM via neigh clarence_eth, seq 223, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 46

root@leon:~# batctl log

[  17179825] Sending own packet (originator leon, seqno 212, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179826] Sending own packet (originator leon, seqno 213, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179827] Sending own packet (originator leon, seqno 214, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179828] Sending own packet (originator leon, seqno 215, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179829] Sending own packet (originator leon, seqno 216, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179830] Sending own packet (originator leon, seqno 217, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179831] Sending own packet (originator leon, seqno 218, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179832] Sending own packet (originator leon, seqno 219, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179833] Sending own packet (originator leon, seqno 220, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179833] Sending own packet (originator leon, seqno 221, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179834] Sending own packet (originator leon, seqno 222, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179835] Sending own packet (originator leon, seqno 223, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179836] Sending own packet (originator leon, seqno 224, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179837] Sending own packet (originator leon, seqno 225, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179838] Sending own packet (originator leon, seqno 226, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179839] Sending own packet (originator leon, seqno 227, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179840] Sending own packet (originator leon, seqno 228, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179841] Sending own packet (originator leon, seqno 229, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179842] Sending own packet (originator leon, seqno 230, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179843] Sending own packet (originator leon, seqno 231, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179844] Sending own packet (originator leon, seqno 232, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179845] Sending own packet (originator leon, seqno 233, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179846] Sending own packet (originator leon, seqno 234, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179847] Sending own packet (originator leon, seqno 235, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179848] Sending own packet (originator leon, seqno 236, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179849] Sending own packet (originator leon, seqno 237, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179850] Sending own packet (originator leon, seqno 238, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179851] Sending own packet (originator leon, seqno 239, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179852] Sending own packet (originator leon, seqno 240, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179853] Sending own packet (originator leon, seqno 241, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179854] Sending own packet (originator leon, seqno 242, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179855] Sending own packet (originator leon, seqno 243, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179856] Sending own packet (originator leon, seqno 244, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179857] Sending own packet (originator leon, seqno 245, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179858] Sending own packet (originator leon, seqno 246, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179859] Sending own packet (originator leon, seqno 247, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179860] Sending own packet (originator leon, seqno 248, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179861] Sending own packet (originator leon, seqno 249, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179862] Sending own packet (originator leon, seqno 250, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179863] Sending own packet (originator leon, seqno 251, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179864] Sending own packet (originator leon, seqno 252, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179865] Sending own packet (originator leon, seqno 253, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179866] Sending own packet (originator leon, seqno 254, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179867] Sending own packet (originator leon, seqno 255, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[  17179868] Sending own packet (originator leon, seqno 256, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         0] Sending own packet (originator leon, seqno 257, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         1] Sending own packet (originator leon, seqno 258, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         2] Sending own packet (originator leon, seqno 259, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         3] Sending own packet (originator leon, seqno 260, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         4] Sending own packet (originator leon, seqno 261, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         5] Sending own packet (originator leon, seqno 262, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         6] Sending own packet (originator leon, seqno 263, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         7] Sending own packet (originator leon, seqno 264, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         8] Sending own packet (originator leon, seqno 265, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[         9] Sending own packet (originator leon, seqno 266, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        10] Sending own packet (originator leon, seqno 267, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        11] Sending own packet (originator leon, seqno 268, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        12] Sending own packet (originator leon, seqno 269, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        13] Sending own packet (originator leon, seqno 270, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        14] Sending own packet (originator leon, seqno 271, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        15] Sending own packet (originator leon, seqno 272, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:0c:41:14:e0:8f]
[        16] Sending own packet (originator leon, seqno 273, TQ 255, TTL

root@clarence:~# batctl o

[B.A.T.M.A.N. adv 2012.1.0, MainIF/MAC: eth0/00:15:6d:f9:5c:9b (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
           gerard    0.090s   (206)            gerard [     wlan0]:            gerard (206)

root@clarence:~# batctl td eth0

12:32:30.400496 BAT clarence_eth: OGM via neigh clarence_eth, seq 1717, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:30.700376 BAT gerard: OGM via neigh clarence_eth, seq 2043, tq 236, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 26
12:32:30.936952 BAT leon: OGM via neigh leon, seq 294, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 46
12:32:31.040390 BAT leon: OGM via neigh clarence_eth, seq 294, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 26
12:32:31.380483 BAT clarence_eth: OGM via neigh clarence_eth, seq 1718, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:31.700379 BAT gerard: OGM via neigh clarence_eth, seq 2044, tq 232, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 26
12:32:31.936914 BAT leon: OGM via neigh leon, seq 295, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 46
12:32:32.040330 BAT leon: OGM via neigh clarence_eth, seq 295, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 26
12:32:32.380464 BAT clarence_eth: OGM via neigh clarence_eth, seq 1719, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:32.690343 BAT gerard: OGM via neigh clarence_eth, seq 2045, tq 232, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 26
12:32:32.936902 BAT leon: OGM via neigh leon, seq 296, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 46
12:32:33.040335 BAT leon: OGM via neigh clarence_eth, seq 296, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 26
12:32:33.380440 BAT clarence_eth: OGM via neigh clarence_eth, seq 1720, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:33.660373 BAT gerard: OGM via neigh clarence_eth, seq 2046, tq 232, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [....], length 26
12:32:33.916874 BAT leon: OGM via neigh leon, seq 297, tq 255, ttvn 1, ttcrc 52918, ttl 50, v 14, flags [..F.], length 46
12:32:34.020377 BAT leon: OGM via neigh clarence_eth, seq 297, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [D...], length 26
12:32:34.380470 BAT clarence_eth: OGM via neigh clarence_eth, seq 1721, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26


root@clarence:~# batctl td wlan0

12:32:43.499850 BAT gerard: OGM via neigh gerard, seq 2056, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
12:32:43.590362 BAT gerard: OGM via neigh clarence_wl, seq 2056, tq 220, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
12:32:43.770331 BAT clarence_wl: OGM via neigh clarence_wl, seq 1720, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
12:32:43.872949 BAT clarence_wl: OGM via neigh gerard, seq 1720, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
12:32:43.960394 BAT leon: OGM via neigh clarence_wl, seq 307, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
12:32:44.240484 BAT clarence_eth: OGM via neigh clarence_wl, seq 1731, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:44.339622 BAT clarence_eth: OGM via neigh gerard, seq 1731, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
12:32:44.503039 BAT gerard: OGM via neigh gerard, seq 2057, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
12:32:44.610421 BAT gerard: OGM via neigh clarence_wl, seq 2057, tq 220, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
12:32:44.770333 BAT clarence_wl: OGM via neigh clarence_wl, seq 1721, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
12:32:44.869523 BAT clarence_wl: OGM via neigh gerard, seq 1721, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
12:32:44.940347 BAT leon: OGM via neigh clarence_wl, seq 308, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
12:32:45.220422 BAT clarence_eth: OGM via neigh clarence_wl, seq 1732, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:45.329605 BAT clarence_eth: OGM via neigh gerard, seq 1732, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
12:32:45.506337 BAT gerard: OGM via neigh gerard, seq 2058, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
12:32:45.600351 BAT gerard: OGM via neigh clarence_wl, seq 2058, tq 220, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
12:32:45.750332 BAT clarence_wl: OGM via neigh clarence_wl, seq 1722, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
12:32:45.852912 BAT clarence_wl: OGM via neigh gerard, seq 1722, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
12:32:45.920341 BAT leon: OGM via neigh clarence_wl, seq 309, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
12:32:46.220429 BAT clarence_eth: OGM via neigh clarence_wl, seq 1733, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:46.332921 BAT clarence_eth: OGM via neigh gerard, seq 1733, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
12:32:46.509656 BAT gerard: OGM via neigh gerard, seq 2059, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
12:32:46.610403 BAT gerard: OGM via neigh clarence_wl, seq 2059, tq 224, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
12:32:46.730346 BAT clarence_wl: OGM via neigh clarence_wl, seq 1723, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
12:32:46.842835 BAT clarence_wl: OGM via neigh gerard, seq 1723, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
12:32:46.920350 BAT leon: OGM via neigh clarence_wl, seq 310, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
12:32:47.200484 BAT clarence_eth: OGM via neigh clarence_wl, seq 1734, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:47.309566 BAT clarence_eth: OGM via neigh gerard, seq 1734, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
12:32:47.493002 BAT gerard: OGM via neigh gerard, seq 2060, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
12:32:47.600391 BAT gerard: OGM via neigh clarence_wl, seq 2060, tq 221, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
12:32:47.710387 BAT clarence_wl: OGM via neigh clarence_wl, seq 1724, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
12:32:47.816818 BAT clarence_wl: OGM via neigh gerard, seq 1724, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
12:32:47.920362 BAT leon: OGM via neigh clarence_wl, seq 311, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
12:32:48.200426 BAT clarence_eth: OGM via neigh clarence_wl, seq 1735, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
12:32:48.309550 BAT clarence_eth: OGM via neigh gerard, seq 1735, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
12:32:48.496292 BAT gerard: OGM via neigh gerard, seq 2061, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
12:32:48.600409 BAT gerard: OGM via neigh clarence_wl, seq 2061, tq 221, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
12:32:48.710349 BAT clarence_wl: OGM via neigh clarence_wl, seq 1725, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26


root@clarence:~# batctl log

[      1446] Drop packet: originator packet from myself (via neighbor)
[      1446] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2069, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1446] updating last_seqno: old 2068, new 2069
[      1446] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1446] update_originator(): Searching and updating originator entry of received packet
[      1446] Updating existing last-hop neighbor of originator
[      1446] Forwarding packet: tq_orig: 231, tq_avg: 231, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1446] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1446] Forwarding packet (originator gerard, seqno 2069, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1446] Forwarding packet (originator gerard, seqno 2069, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1446] Sending own packet (originator clarence_wl, seqno 1733, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1446] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1733, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1446] Drop packet: originator packet from myself (via neighbor)
[      1446] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 320, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1446] updating last_seqno: old 319, new 320
[      1446] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1446] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1446] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1446] Forwarding packet (originator leon, seqno 320, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1446] Forwarding packet (originator leon, seqno 320, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1446] Sending own packet (originator clarence_eth, seqno 1744, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1446] Sending own packet (originator clarence_eth, seqno 1744, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1447] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1744, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1447] Drop packet: originator packet from myself (via neighbor)
[      1447] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2070, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1447] updating last_seqno: old 2069, new 2070
[      1447] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1447] update_originator(): Searching and updating originator entry of received packet
[      1447] Updating existing last-hop neighbor of originator
[      1447] Forwarding packet: tq_orig: 231, tq_avg: 231, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1447] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1447] Forwarding packet (originator gerard, seqno 2070, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1447] Forwarding packet (originator gerard, seqno 2070, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1447] Sending own packet (originator clarence_wl, seqno 1734, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1447] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1734, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1447] Drop packet: originator packet from myself (via neighbor)
[      1447] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 321, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1447] updating last_seqno: old 320, new 321
[      1447] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1447] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1447] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1447] Forwarding packet (originator leon, seqno 321, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1447] Forwarding packet (originator leon, seqno 321, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1447] Sending own packet (originator clarence_eth, seqno 1745, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1447] Sending own packet (originator clarence_eth, seqno 1745, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1448] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1745, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1448] Drop packet: originator packet from myself (via neighbor)
[      1448] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2071, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1448] updating last_seqno: old 2070, new 2071
[      1448] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1448] update_originator(): Searching and updating originator entry of received packet
[      1448] Updating existing last-hop neighbor of originator
[      1448] Forwarding packet: tq_orig: 231, tq_avg: 231, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1448] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1448] Forwarding packet (originator gerard, seqno 2071, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1448] Forwarding packet (originator gerard, seqno 2071, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1448] Sending own packet (originator clarence_wl, seqno 1735, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1448] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1735, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1448] Drop packet: originator packet from myself (via neighbor)
[      1448] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 322, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1448] updating last_seqno: old 321, new 322
[      1448] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1448] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1448] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1448] Forwarding packet (originator leon, seqno 322, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1448] Forwarding packet (originator leon, seqno 322, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1448] Sending own packet (originator clarence_eth, seqno 1746, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1448] Sending own packet (originator clarence_eth, seqno 1746, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1449] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1746, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1449] Drop packet: originator packet from myself (via neighbor)
[      1449] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2072, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1449] updating last_seqno: old 2071, new 2072
[      1449] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1449] update_originator(): Searching and updating originator entry of received packet
[      1449] Updating existing last-hop neighbor of originator
[      1449] Forwarding packet: tq_orig: 231, tq_avg: 231, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1449] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1449] Forwarding packet (originator gerard, seqno 2072, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1449] Forwarding packet (originator gerard, seqno 2072, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1449] Sending own packet (originator clarence_wl, seqno 1736, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1449] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1736, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1449] Drop packet: originator packet from myself (via neighbor)
[      1449] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 323, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1449] updating last_seqno: old 322, new 323
[      1449] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1449] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1449] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1449] Forwarding packet (originator leon, seqno 323, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1449] Forwarding packet (originator leon, seqno 323, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1449] Sending own packet (originator clarence_eth, seqno 1747, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1449] Sending own packet (originator clarence_eth, seqno 1747, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1450] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1747, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1450] Drop packet: originator packet from myself (via neighbor)
[      1450] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2073, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1450] updating last_seqno: old 2072, new 2073
[      1450] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1450] update_originator(): Searching and updating originator entry of received packet
[      1450] Updating existing last-hop neighbor of originator
[      1450] Forwarding packet: tq_orig: 231, tq_avg: 231, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1450] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1450] Forwarding packet (originator gerard, seqno 2073, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1450] Forwarding packet (originator gerard, seqno 2073, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1450] Sending own packet (originator clarence_wl, seqno 1737, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1450] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 324, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1450] updating last_seqno: old 323, new 324
[      1450] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1450] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1450] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1450] Forwarding packet (originator leon, seqno 324, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1450] Forwarding packet (originator leon, seqno 324, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1450] Sending own packet (originator clarence_eth, seqno 1748, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1450] Sending own packet (originator clarence_eth, seqno 1748, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1450] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1748, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1450] Drop packet: originator packet from myself (via neighbor)
[      1451] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2074, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1451] updating last_seqno: old 2073, new 2074
[      1451] bidirectional: orig = gerard neigh = gerard => own_bcast = 57, real recv = 64, local tq: 227, asym_penalty: 255, total tq: 227
[      1451] update_originator(): Searching and updating originator entry of received packet
[      1451] Updating existing last-hop neighbor of originator
[      1451] Forwarding packet: tq_orig: 227, tq_avg: 230, tq_forw: 218, ttl_orig: 49, ttl_forw: 49
[      1451] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1451] Forwarding packet (originator gerard, seqno 2074, TQ 218, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1451] Forwarding packet (originator gerard, seqno 2074, TQ 218, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1451] Sending own packet (originator clarence_wl, seqno 1738, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1451] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1738, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1451] Drop packet: originator packet from myself (via neighbor)
[      1451] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 325, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1451] updating last_seqno: old 324, new 325
[      1451] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1451] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1451] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1451] Forwarding packet (originator leon, seqno 325, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1451] Forwarding packet (originator leon, seqno 325, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1451] Sending own packet (originator clarence_eth, seqno 1749, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1451] Sending own packet (originator clarence_eth, seqno 1749, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1451] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1749, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1451] Drop packet: originator packet from myself (via neighbor)
[      1452] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2075, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1452] updating last_seqno: old 2074, new 2075
[      1452] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1452] update_originator(): Searching and updating originator entry of received packet
[      1452] Updating existing last-hop neighbor of originator
[      1452] Forwarding packet: tq_orig: 231, tq_avg: 230, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1452] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1452] Forwarding packet (originator gerard, seqno 2075, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1452] Forwarding packet (originator gerard, seqno 2075, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1452] Sending own packet (originator clarence_wl, seqno 1739, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1452] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1739, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1452] Drop packet: originator packet from myself (via neighbor)
[      1452] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b] (from OG: leon, via prev OG: leon, seqno 326, ttvn 1, crc 52918, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1452] updating last_seqno: old 325, new 326
[      1452] bidirectional: orig = leon neigh = leon => own_bcast =  0, real recv = 64, local tq:   0, asym_penalty: 255, total tq:   0
[      1452] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig: 49, ttl_forw: 49
[      1452] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1452] Forwarding packet (originator leon, seqno 326, TQ 0, TTL 49, IDF on, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1452] Forwarding packet (originator leon, seqno 326, TQ 0, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1452] Sending own packet (originator clarence_eth, seqno 1750, TQ 255, TTL 50, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1452] Sending own packet (originator clarence_eth, seqno 1750, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1452] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_eth, via prev OG: clarence_wl, seqno 1750, ttvn 1, crc 31297, changes 0, td 245, TTL 49, V 14, IDF 0)
[      1452] Drop packet: originator packet from myself (via neighbor)
[      1453] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: gerard, via prev OG: gerard, seqno 2076, ttvn 1, crc 34194, changes 0, td 255, TTL 50, V 14, IDF 0)
[      1453] updating last_seqno: old 2075, new 2076
[      1453] bidirectional: orig = gerard neigh = gerard => own_bcast = 58, real recv = 64, local tq: 231, asym_penalty: 255, total tq: 231
[      1453] update_originator(): Searching and updating originator entry of received packet
[      1453] Updating existing last-hop neighbor of originator
[      1453] Forwarding packet: tq_orig: 231, tq_avg: 230, tq_forw: 221, ttl_orig: 49, ttl_forw: 49
[      1453] Forwarding packet: rebroadcast neighbor packet with direct link flag
[      1453] Forwarding packet (originator gerard, seqno 2076, TQ 221, TTL 49, IDF off, ttvn 1) on interface eth0 [00:15:6d:f9:5c:9b]
[      1453] Forwarding packet (originator gerard, seqno 2076, TQ 221, TTL 49, IDF on, ttvn 1) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1453] Sending own packet (originator clarence_wl, seqno 1740, TTL 2) on interface wlan0 [00:15:6d:f8:5c:9b]
[      1453] Received BATMAN packet via NB: gerard, IF: wlan0 [00:15:6d:f8:5c:9b] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1740, ttvn 1, crc 31297, changes 0, td 245, TTL 1, V 14, IDF 1)
[      1453] Drop packet: originator packet from myself (via neighbor)
[      1453] Received BATMAN packet via NB: leon, IF: eth0 [00:15:6d:f9:5c:9b]


gen@gerard:~$ batctl o

[B.A.T.M.A.N. adv 2012.1.0, MainIF/MAC: wlan0/00:1b:77:43:90:4e (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
     clarence_eth    0.890s   ( 12)       clarence_wl [     wlan0]:       clarence_wl ( 12)
      clarence_wl    0.500s   ( 18)       clarence_wl [     wlan0]:       clarence_wl ( 18)


gen@gerard:~$ batctl td wlan0

21:48:10.499846 BAT clarence_wl: OGM via neigh clarence_wl, seq 1761, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
21:48:10.523081 BAT gerard: OGM via neigh gerard, seq 2097, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
21:48:10.606362 BAT clarence_wl: OGM via neigh gerard, seq 1761, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
21:48:10.629831 BAT gerard: OGM via neigh clarence_wl, seq 2097, tq 218, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
21:48:10.710161 BAT leon: OGM via neigh clarence_wl, seq 348, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
21:48:10.929908 BAT clarence_eth: OGM via neigh clarence_wl, seq 1772, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
21:48:11.039705 BAT clarence_eth: OGM via neigh gerard, seq 1772, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
21:48:11.500618 BAT clarence_wl: OGM via neigh clarence_wl, seq 1762, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
21:48:11.526341 BAT gerard: OGM via neigh gerard, seq 2098, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
21:48:11.603032 BAT clarence_wl: OGM via neigh gerard, seq 1762, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
21:48:11.630580 BAT gerard: OGM via neigh clarence_wl, seq 2098, tq 218, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
21:48:11.711258 BAT leon: OGM via neigh clarence_wl, seq 349, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
21:48:11.910088 BAT clarence_eth: OGM via neigh clarence_wl, seq 1773, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
21:48:12.016309 BAT clarence_eth: OGM via neigh gerard, seq 1773, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
21:48:12.500731 BAT clarence_wl: OGM via neigh clarence_wl, seq 1763, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
21:48:12.509737 BAT gerard: OGM via neigh gerard, seq 2099, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
21:48:12.599691 BAT clarence_wl: OGM via neigh gerard, seq 1763, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
21:48:12.620326 BAT gerard: OGM via neigh clarence_wl, seq 2099, tq 218, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
21:48:12.690244 BAT leon: OGM via neigh clarence_wl, seq 350, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
21:48:12.890264 BAT clarence_eth: OGM via neigh clarence_wl, seq 1774, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
21:48:12.999703 BAT clarence_eth: OGM via neigh gerard, seq 1774, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
21:48:13.493026 BAT gerard: OGM via neigh gerard, seq 2100, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
21:48:13.500250 BAT clarence_wl: OGM via neigh clarence_wl, seq 1764, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
21:48:13.599929 BAT gerard: OGM via neigh clarence_wl, seq 2100, tq 221, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
21:48:13.602987 BAT clarence_wl: OGM via neigh gerard, seq 1764, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
21:48:13.689949 BAT leon: OGM via neigh clarence_wl, seq 351, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
21:48:13.870386 BAT clarence_eth: OGM via neigh clarence_wl, seq 1775, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
21:48:13.969703 BAT clarence_eth: OGM via neigh gerard, seq 1775, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
21:48:14.480640 BAT clarence_wl: OGM via neigh clarence_wl, seq 1765, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
21:48:14.496372 BAT gerard: OGM via neigh gerard, seq 2101, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
21:48:14.579697 BAT clarence_wl: OGM via neigh gerard, seq 1765, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
21:48:14.589974 BAT gerard: OGM via neigh clarence_wl, seq 2101, tq 218, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
21:48:14.690390 BAT leon: OGM via neigh clarence_wl, seq 352, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26
21:48:14.870821 BAT clarence_eth: OGM via neigh clarence_wl, seq 1776, tq 255, ttvn 1, ttcrc 31297, ttl 50, v 14, flags [..F.], length 26
21:48:14.979723 BAT clarence_eth: OGM via neigh gerard, seq 1776, tq 245, ttvn 1, ttcrc 31297, ttl 49, v 14, flags [....], length 26
21:48:15.479749 BAT gerard: OGM via neigh gerard, seq 2102, tq 255, ttvn 1, ttcrc 34194, ttl 50, v 14, flags [..F.], length 26
21:48:15.480298 BAT clarence_wl: OGM via neigh clarence_wl, seq 1766, tq 255, ttvn 1, ttcrc 31297, ttl  2, v 14, flags [....], length 26
21:48:15.589703 BAT clarence_wl: OGM via neigh gerard, seq 1766, tq 245, ttvn 1, ttcrc 31297, ttl  1, v 14, flags [D...], length 26
21:48:15.590240 BAT gerard: OGM via neigh clarence_wl, seq 2102, tq 218, ttvn 1, ttcrc 34194, ttl 49, v 14, flags [D...], length 26
21:48:15.660346 BAT leon: OGM via neigh clarence_wl, seq 353, tq   0, ttvn 1, ttcrc 52918, ttl 49, v 14, flags [....], length 26


gen@gerard:~$ batctl log

[  14319868] Forwarding packet: rebroadcast originator packet
[  14319868] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319868] Forwarding packet (originator clarence_eth, seqno 1785, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319868] Originator timeout: originator leon, last_valid 0
[  14319868] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1775, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319868] updating last_seqno: old 1774, new 1775
[  14319868] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 60, real recv = 60, local tq: 255, asym_penalty: 255, total tq: 255
[  14319868] update_originator(): Searching and updating originator entry of received packet
[  14319868] Updating existing last-hop neighbor of originator
[  14319868] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319868] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319868] Sending own packet (originator gerard, seqno 2111, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319868] Forwarding packet (originator clarence_wl, seqno 1775, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319869] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2111, ttvn 1, crc 34194, changes 0, td 213, TTL 49, V 14, IDF 1)
[  14319869] Drop packet: originator packet from myself (via neighbor)
[  14319869] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 362, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319869] Creating new originator: 00:0c:41:14:e0:8f
[  14319869] Drop packet: originator packet with tq equal 0
[  14319869] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1786, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319869] updating last_seqno: old 1785, new 1786
[  14319869] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 60, real recv = 60, local tq: 255, asym_penalty: 255, total tq: 255
[  14319869] update_originator(): Searching and updating originator entry of received packet
[  14319869] Updating existing last-hop neighbor of originator
[  14319869] Forwarding packet: rebroadcast originator packet
[  14319869] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319869] Forwarding packet (originator clarence_eth, seqno 1786, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319869] Originator timeout: originator leon, last_valid 0
[  14319869] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1776, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319869] updating last_seqno: old 1775, new 1776
[  14319869] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319869] update_originator(): Searching and updating originator entry of received packet
[  14319869] Updating existing last-hop neighbor of originator
[  14319869] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319869] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319869] Sending own packet (originator gerard, seqno 2112, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319869] Forwarding packet (originator clarence_wl, seqno 1776, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319870] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 363, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319870] Creating new originator: 00:0c:41:14:e0:8f
[  14319870] Drop packet: originator packet with tq equal 0
[  14319870] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2112, ttvn 1, crc 34194, changes 0, td 217, TTL 49, V 14, IDF 1)
[  14319870] Drop packet: originator packet from myself (via neighbor)
[  14319870] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1787, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319870] updating last_seqno: old 1786, new 1787
[  14319870] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319870] update_originator(): Searching and updating originator entry of received packet
[  14319870] Updating existing last-hop neighbor of originator
[  14319870] Forwarding packet: rebroadcast originator packet
[  14319870] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319870] Forwarding packet (originator clarence_eth, seqno 1787, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319870] Originator timeout: originator leon, last_valid 0
[  14319870] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1777, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319870] updating last_seqno: old 1776, new 1777
[  14319870] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319870] update_originator(): Searching and updating originator entry of received packet
[  14319870] Updating existing last-hop neighbor of originator
[  14319870] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319870] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319870] Sending own packet (originator gerard, seqno 2113, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319870] Forwarding packet (originator clarence_wl, seqno 1777, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319870] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 364, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319870] Creating new originator: 00:0c:41:14:e0:8f
[  14319870] Drop packet: originator packet with tq equal 0
[  14319870] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2113, ttvn 1, crc 34194, changes 0, td 217, TTL 49, V 14, IDF 1)
[  14319870] Drop packet: originator packet from myself (via neighbor)
[  14319871] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1788, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319871] updating last_seqno: old 1787, new 1788
[  14319871] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319871] update_originator(): Searching and updating originator entry of received packet
[  14319871] Updating existing last-hop neighbor of originator
[  14319871] Forwarding packet: rebroadcast originator packet
[  14319871] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319871] Forwarding packet (originator clarence_eth, seqno 1788, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319871] Originator timeout: originator leon, last_valid 0
[  14319871] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1778, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319871] updating last_seqno: old 1777, new 1778
[  14319871] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319871] update_originator(): Searching and updating originator entry of received packet
[  14319871] Updating existing last-hop neighbor of originator
[  14319871] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319871] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319871] Sending own packet (originator gerard, seqno 2114, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319871] Forwarding packet (originator clarence_wl, seqno 1778, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319871] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 365, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319871] Creating new originator: 00:0c:41:14:e0:8f
[  14319871] Drop packet: originator packet with tq equal 0
[  14319871] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2114, ttvn 1, crc 34194, changes 0, td 217, TTL 49, V 14, IDF 1)
[  14319871] Drop packet: originator packet from myself (via neighbor)
[  14319872] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1789, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319872] updating last_seqno: old 1788, new 1789
[  14319872] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319872] update_originator(): Searching and updating originator entry of received packet
[  14319872] Updating existing last-hop neighbor of originator
[  14319872] Forwarding packet: rebroadcast originator packet
[  14319872] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319872] Forwarding packet (originator clarence_eth, seqno 1789, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319872] Originator timeout: originator leon, last_valid 0
[  14319872] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1779, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319872] updating last_seqno: old 1778, new 1779
[  14319872] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319872] update_originator(): Searching and updating originator entry of received packet
[  14319872] Updating existing last-hop neighbor of originator
[  14319872] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319872] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319872] Sending own packet (originator gerard, seqno 2115, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319872] Forwarding packet (originator clarence_wl, seqno 1779, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319872] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 366, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319872] Creating new originator: 00:0c:41:14:e0:8f
[  14319872] Drop packet: originator packet with tq equal 0
[  14319872] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2115, ttvn 1, crc 34194, changes 0, td 217, TTL 49, V 14, IDF 1)
[  14319872] Drop packet: originator packet from myself (via neighbor)
[  14319873] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1790, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319873] updating last_seqno: old 1789, new 1790
[  14319873] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319873] update_originator(): Searching and updating originator entry of received packet
[  14319873] Updating existing last-hop neighbor of originator
[  14319873] Forwarding packet: rebroadcast originator packet
[  14319873] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319873] Forwarding packet (originator clarence_eth, seqno 1790, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319873] Originator timeout: originator leon, last_valid 0
[  14319873] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1780, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319873] updating last_seqno: old 1779, new 1780
[  14319873] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319873] update_originator(): Searching and updating originator entry of received packet
[  14319873] Updating existing last-hop neighbor of originator
[  14319873] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319873] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319873] Sending own packet (originator gerard, seqno 2116, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319873] Forwarding packet (originator clarence_wl, seqno 1780, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319873] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 367, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319873] Creating new originator: 00:0c:41:14:e0:8f
[  14319873] Drop packet: originator packet with tq equal 0
[  14319873] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2116, ttvn 1, crc 34194, changes 0, td 217, TTL 49, V 14, IDF 1)
[  14319873] Drop packet: originator packet from myself (via neighbor)
[  14319874] Originator timeout: originator leon, last_valid 0
[  14319874] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1781, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319874] updating last_seqno: old 1780, new 1781
[  14319874] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319874] update_originator(): Searching and updating originator entry of received packet
[  14319874] Updating existing last-hop neighbor of originator
[  14319874] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319874] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319874] Sending own packet (originator gerard, seqno 2117, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319874] Forwarding packet (originator clarence_wl, seqno 1781, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319874] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 368, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319874] Creating new originator: 00:0c:41:14:e0:8f
[  14319874] Drop packet: originator packet with tq equal 0
[  14319874] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2117, ttvn 1, crc 34194, changes 0, td 217, TTL 49, V 14, IDF 1)
[  14319874] Drop packet: originator packet from myself (via neighbor)
[  14319875] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1792, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319875] updating last_seqno: old 1790, new 1792
[  14319875] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 61, real recv = 61, local tq: 255, asym_penalty: 255, total tq: 255
[  14319875] update_originator(): Searching and updating originator entry of received packet
[  14319875] Updating existing last-hop neighbor of originator
[  14319875] Forwarding packet: rebroadcast originator packet
[  14319875] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319875] Forwarding packet (originator clarence_eth, seqno 1792, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319875] Originator timeout: originator leon, last_valid 0
[  14319875] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1782, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319875] updating last_seqno: old 1781, new 1782
[  14319875] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 62, real recv = 62, local tq: 255, asym_penalty: 255, total tq: 255
[  14319875] update_originator(): Searching and updating originator entry of received packet
[  14319875] Updating existing last-hop neighbor of originator
[  14319875] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319875] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319875] Sending own packet (originator gerard, seqno 2118, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319875] Forwarding packet (originator clarence_wl, seqno 1782, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319875] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 369, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319875] Creating new originator: 00:0c:41:14:e0:8f
[  14319875] Drop packet: originator packet with tq equal 0
[  14319875] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2118, ttvn 1, crc 34194, changes 0, td 220, TTL 49, V 14, IDF 1)
[  14319875] Drop packet: originator packet from myself (via neighbor)
[  14319876] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1793, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319876] updating last_seqno: old 1792, new 1793
[  14319876] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 62, real recv = 62, local tq: 255, asym_penalty: 255, total tq: 255
[  14319876] update_originator(): Searching and updating originator entry of received packet
[  14319876] Updating existing last-hop neighbor of originator
[  14319876] Forwarding packet: rebroadcast originator packet
[  14319876] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319876] Forwarding packet (originator clarence_eth, seqno 1793, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319876] Originator timeout: originator leon, last_valid 0
[  14319876] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1783, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319876] updating last_seqno: old 1782, new 1783
[  14319876] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 62, real recv = 62, local tq: 255, asym_penalty: 255, total tq: 255
[  14319876] update_originator(): Searching and updating originator entry of received packet
[  14319876] Updating existing last-hop neighbor of originator
[  14319876] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319876] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319876] Sending own packet (originator gerard, seqno 2119, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319876] Forwarding packet (originator clarence_wl, seqno 1783, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319876] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 370, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319876] Creating new originator: 00:0c:41:14:e0:8f
[  14319876] Drop packet: originator packet with tq equal 0
[  14319876] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2119, ttvn 1, crc 34194, changes 0, td 224, TTL 49, V 14, IDF 1)
[  14319876] Drop packet: originator packet from myself (via neighbor)
[  14319877] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1794, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319877] updating last_seqno: old 1793, new 1794
[  14319877] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 62, real recv = 62, local tq: 255, asym_penalty: 255, total tq: 255
[  14319877] update_originator(): Searching and updating originator entry of received packet
[  14319877] Updating existing last-hop neighbor of originator
[  14319877] Forwarding packet: rebroadcast originator packet
[  14319877] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319877] Forwarding packet (originator clarence_eth, seqno 1794, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319877] Originator timeout: originator leon, last_valid 0
[  14319877] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_wl, via prev OG: clarence_wl, seqno 1784, ttvn 1, crc 31297, changes 0, td 255, TTL 2, V 14, IDF 0)
[  14319877] updating last_seqno: old 1783, new 1784
[  14319877] bidirectional: orig = clarence_wl neigh = clarence_wl => own_bcast = 62, real recv = 62, local tq: 255, asym_penalty: 255, total tq: 255
[  14319877] update_originator(): Searching and updating originator entry of received packet
[  14319877] Updating existing last-hop neighbor of originator
[  14319877] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 1, ttl_forw: 1
[  14319877] Forwarding packet: rebroadcast neighbor packet with direct link flag
[  14319877] Forwarding packet (originator clarence_wl, seqno 1784, TTL 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319877] Sending own packet (originator gerard, seqno 2120, TQ 255, TTL 50, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]
[  14319877] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: leon, via prev OG: leon, seqno 371, ttvn 1, crc 52918, changes 0, td 0, TTL 49, V 14, IDF 0)
[  14319877] Creating new originator: 00:0c:41:14:e0:8f
[  14319877] Drop packet: originator packet with tq equal 0
[  14319877] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: gerard, via prev OG: gerard, seqno 2120, ttvn 1, crc 34194, changes 0, td 228, TTL 49, V 14, IDF 1)
[  14319877] Drop packet: originator packet from myself (via neighbor)
[  14319878] Received BATMAN packet via NB: clarence_wl, IF: wlan0 [00:1b:77:43:90:4e] (from OG: clarence_eth, via prev OG: clarence_eth, seqno 1795, ttvn 1, crc 31297, changes 0, td 255, TTL 50, V 14, IDF 0)
[  14319878] updating last_seqno: old 1794, new 1795
[  14319878] bidirectional: orig = clarence_eth neigh = clarence_wl => own_bcast = 62, real recv = 62, local tq: 255, asym_penalty: 255, total tq: 255
[  14319878] update_originator(): Searching and updating originator entry of received packet
[  14319878] Updating existing last-hop neighbor of originator
[  14319878] Forwarding packet: rebroadcast originator packet
[  14319878] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245, ttl_orig: 49, ttl_forw: 49
[  14319878] Forwarding packet (originator clarence_eth, seqno 1795, TQ 245, TTL 49, IDF off, ttvn 1) on interface wlan0 [00:1b:77:43:90:4e]



--Boundary_(ID_QGGo54xoAHYO9YBP5zlcNQ)--
