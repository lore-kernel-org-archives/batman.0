Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F51CA9D.2090404@codigosur.org>
Date: Sat, 03 Mar 2012 04:39:09 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc +
	ethernet
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

Mi name is NicoEch=E1niz, this is my first post to the list.


********** INTRO, please skip it if you find it long to read **********

I've been doing free-network stuff for a while (around 10 years). I
started in Buenos Aires, Argentina, where I built one of the first nodes
for BuenosAiresLibre.org

I was the coordinator of the first JRRL (Free Networks Regional
Meeting), where Ram=F3n Roca (from guifi.net) was our guest keynote and
members from Latin American networks intentionally gathered for the
first time.

I've moved last year to a small town in another province, where I'm
experimenting whith a completely different network. BuenosAiresLibre
(a.k.a. BAL) run in infrastructure mode and used OLSR for routing.

In this town (Quintana), we are now building an ad-hoc mesh and as you
must have guessed we're using batman-adv for routing.

Some friends from BAL came along and we worked for a couple of weeks on
this experiment.

You may find information here (spanish but g.translator might help):
http://wiki.arraigodigital.org.ar/RedLibre/QuintanaCamp/Documentaci=F3n

And some interesting pictures here:
http://www.lavecindaria.org.ar/category/quintanacamp/

QuintanaLibre.org is the first experimental implementation of a cheap
design of ad-hoc mesh network that we intend to re-use in hundreds of
small towns around the country, in colaboration with the national
Ministry of Education, through the Arraigo Digital plan. Some info on
that can be found here: http://www.arraigodigital.org.ar

***********************************************************************

Well... after this not-so-brief introduction, here's what I'd like to
ask about.

We have been experimenting with different setups for our nodes. Some of
them are regular TP-Link MR-3220 (thanks Elektra for the recommendation)
with a PoE modification; others have a USB/Wi-fi adapter added (TP-Link
WN722N) and there's a third kind where we connected an Ubiquiti BulletM2
to an MR-3220.

This third kind of setup is the one that has been giving us trouble.

There's a total 5 nodes running in the test network; the longest
inter-node distance is 1.5 Km.


In the example below, the MR is called "marisa-mr" and the bulletM2 is
called "marisa-blt" (this is the only node with this setup so far). They
are connected by ethernet and ad-hoc and share the same tower space.



The network seemed to work quite well, but from time to time, pings
would sort of fall into a hole for a while... so we started looking at
traceroutes and this is what we found.


Traceroute is done from a notebook connected (with batman active on
eth0) to the node called "nogal" and trying to trace the route to
czuk_wlan1 (the other end of the net).


running the command several times, from time to time we get this sort of
output:

$ sudo batctl tr czuk_wlan1
traceroute to czuk_wlan1 (f8:d1:11:0b:76:4b), 50 hops max, ...
 1: nogal_wlan0 (00:15:6d:d6:24:7a)  0.395 ms  0.214 ms  0.416 ms
 2: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  1.702 ms  3.291 ms  1.694 ms
 3: cisterna_wlan0 (54:e6:fc:b9:be:e8)  25.282 ms   *   *
 4: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  2.694 ms  1.722 ms  5.462 ms
 5: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  1.758 ms  1.584 ms  5.409 ms
 6: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  1.335 ms  4.584 ms  3.111 ms
...
47: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  2.090 ms  2.180 ms  2.138 ms
48: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  4.738 ms  2.898 ms  2.735 ms
49: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  2.325 ms  2.269 ms  2.249 ms


$ sudo batctl tr czuk_wlan1
traceroute to czuk_wlan1 (f8:d1:11:0b:76:4b), 50 hops max, ...
 1: nogal_wlan0 (00:15:6d:d6:24:7a)  0.541 ms  0.193 ms  0.188 ms
 2: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  1.347 ms  1.221 ms  1.215 ms
 3: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  1.281 ms  5.103 ms  1.255 ms
 4: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  5.944 ms  1.705 ms  2.238 ms
...
33: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  1.920 ms  1.890 ms  1.815 ms
34: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  2.859 ms  1.778 ms  4.499 ms
35: *   *   *   *
36: czuk_wlan1 (f8:d1:11:0b:76:4b)  299.941 ms  37.911 ms   *


and this is what a correct traceroute looks like:

$ sudo batctl tr czuk_wlan1
traceroute to czuk_wlan1 (f8:d1:11:0b:76:4b), 50 hops max, 20 byte packets
 1: nogal_wlan0 (00:15:6d:d6:24:7a)  0.292 ms  0.211 ms  0.209 ms
 2: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  1.541 ms  1.407 ms  2.508 ms
 3: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  1.464 ms  1.593 ms  1.466 ms
 4: cisterna_wlan0 (54:e6:fc:b9:be:e8)  5.275 ms  18.669 ms  4.106 ms
 5: czuk_wlan1 (f8:d1:11:0b:76:4b)  3.505 ms  5.681 ms  5.198 ms


or this one, when the chosen route skips the cisterna node:
$ sudo batctl tr czuk_wlan1
traceroute to czuk_wlan1 (f8:d1:11:0b:76:4b), 50 hops max, ...
 1: nogal_wlan0 (00:15:6d:d6:24:7a)  0.293 ms  0.184 ms  1.990 ms
 2: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  1.638 ms  1.687 ms  1.442 ms
 3: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  1.635 ms  1.334 ms  1.463 ms
 4: czuk_wlan1 (f8:d1:11:0b:76:4b)  8.783 ms  3.844 ms  3.704 ms


this happens with the nodes configured according to:
http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance

or so we understand!


here are the relevant portions of the nodes config.
we have a central repo for configurations, thus the "strange" syntax.


MARISA-BLT

$ uci show wireless.@wifi-iface[0] -c marisa-blt/etc/config/
wireless.cfg033579=3Dwifi-iface
wireless.cfg033579.device=3Dradio0
wireless.cfg033579.encryption=3Dnone
wireless.cfg033579.mode=3Dadhoc
wireless.cfg033579.ssid=3Dmesh.quintanalibre.org.ar
wireless.cfg033579.bssid=3D02:12:34:56:78:9A


# wlan0 here is a master mode interface
$ uci show network.lan.ifname -c marisa-blt/etc/config/
network.lan.ifname=3Dbat0 wlan0 eth0


# wlan0-1 here is the mesh interface
$ uci show batman-adv.bat0.interfaces -c marisa-blt/etc/config/
batman-adv.bat0.interfaces=3Dwlan0-1 br-lan


MARISA-MR

$ uci show wireless.@wifi-iface[0] -c marisa-mr/etc/config/
wireless.cfg033579=3Dwifi-iface
wireless.cfg033579.encryption=3Dnone
wireless.cfg033579.device=3Dradio0
wireless.cfg033579.bssid=3D02:12:34:56:78:9A
wireless.cfg033579.mode=3Dadhoc
wireless.cfg033579.ssid=3Dmesh.quintanalibre.org.ar
(this is wlan0 in this router)

#eth1 is connected to a router inside the owner's house; no batman
$ uci show network.lan.ifname -c marisa-mr/etc/config/
network.lan.ifname=3Dbat0 eth1 eth0

#wlan0 is the only wireless interface here
$ uci show batman-adv.bat0.interfaces -c marisa-mr/etc/config/
batman-adv.bat0.interfaces=3Dwlan0 br-lan



We have also tried adding eth0 to bat0 and take it out of br-lan, which
also "works" but gives routing loops from time to time.


OpenWRT is trunk from a couple of weeks ago, where batman-adv version
was 2011.4

We hoped that adding a second router through ethernet would give the
mesh an alternate path and more redundancy, but we get much lower
throughputs because of these loops.


We would very much appreciate any insight on this matter.


Hoping to read from you bat-friends soon :)


Cheers,
NicoEch=E1niz


