Message-ID: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_5d0c449d-0c3e-49e8-b728-7055d1fa72a3_"
From: Dennis Bartsch <dennis_bartsch@hotmail.com>
Date: Mon, 15 Oct 2007 13:38:29 +0100
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] strange default routes
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

--_5d0c449d-0c3e-49e8-b728-7055d1fa72a3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hello batmen, ;)

here in berlin NE we are about to update the batmands on our backbone to 0.=
3.0 . atm our net is mainly running on olsr and batman in parallel for test=
ing purpose.
after some changes in the net we got heavy HNA-hopping with olsr which is r=
elated to the improper metric in our case. therefore we are somewhat forcin=
g the
migration to batman and got some strange default routes with the most recen=
t 0.3.0 builds on some routers:

root@OpenWrt:/etc/init.d# route -n
Destination  Gateway  Genmask  Flags Metric Ref    Use Iface
[...]
0.0.0.0         0.0.0.0     0.0.0.0      !        0         0       0     *
[...]

batmand has been started with the following parameters:  /usr/sbin/batmand =
-g 0 -r 0 eth2

after appearance of this default-route olsr-"clients" cannot use the uplink=
 anymore, so further testing  is difficult.
we have another problem with this build, but cannot investigate further bec=
ause of this behaviour. so any help is appreciated.

thanks

dennis bartsch
freifunk-bno.de

attached is some console-output:
###########################
root@OpenWrt:/etc/init.d# ifconfig
eth2 Link encap:Ethernet HWaddr 00:01:36:0D:D2:63
inet addr:104.13.0.54 Bcast:104.255.255.255 Mask:255.0.0.0
UP BROADCAST RUNNING MULTICAST MTU:512 Metric:1
RX packets:105511 errors:0 dropped:0 overruns:0 frame:0
TX packets:122436 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000
RX bytes:61107954 (58.2 MiB) TX bytes:45973166 (43.8 MiB)
Interrupt:27

eth2:0 Link encap:Ethernet HWaddr 00:01:36:0D:D2:63
inet addr:105.13.0.54 Bcast:105.255.255.255 Mask:255.0.0.0
UP BROADCAST RUNNING MULTICAST MTU:512 Metric:1
Interrupt:27

lo Link encap:Local Loopback
inet addr:127.0.0.1 Mask:255.0.0.0
UP LOOPBACK RUNNING MTU:16436 Metric:1
RX packets:2800 errors:0 dropped:0 overruns:0 frame:0
TX packets:2800 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:288724 (281.9 KiB) TX bytes:288724 (281.9 KiB)

wifi0 Link encap:UNSPEC HWaddr 00-0B-6B-4D-63-8B-00-0A-00-00-00-00-00-00-00=
-00
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:997788 errors:0 dropped:1221 overruns:0 frame:443273
TX packets:688240 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:199
RX bytes:305805070 (291.6 MiB) TX bytes:126339425 (120.4 MiB)
Interrupt:28

root@OpenWrt:/etc/init.d# /usr/sbin/batmand -g 0 -r 0 eth2:0 -d 4
WARNING: You are using the unstable batman branch. If you are interested in=
 *using* batman get the latest stable release !
[ 0] Error - can't add rule to 105.0.0.0/8: Invalid argument
[ 0] Error - can't add rule to 105.0.0.0/8: Invalid argument
Using interface eth2:0 with address 105.13.0.54 and broadcast address 105.2=
55.255.255
B.A.T.M.A.N. 0.3-beta (compatibility version 4)
[ 0] Error - can't add rule to 0.0.0.0/0: Invalid argument
[ 10] Error - can't add rule to 0.0.0.0/0: Invalid argument
debug level: 4
[ 20]

[ 940] Forwarding packet (originator 105.13.0.54, seqno 1, TTL 50) on inter=
face eth2:0
[ 940]

[ 940] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54 =
(from OG: 105.13.0.54, seqno 1, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 940] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 940]
[ 1090] Received BATMAN packet via NB: 105.12.0.20 , IF: eth2:0 105.13.0.54=
 (from OG: 105.12.0.20, seqno 55800, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 1090] HNA information received (1 HNA network):
[ 1090] hna: 105.0.200.6/32
[ 1090] Creating new originator: 105.12.0.20
[ 1090] Creating new last-hop neighbour of originator
[ 1090] bidirectional: orig =3D 105.12.0.20 neigh =3D 105.12.0.20 =3D> own_=
bcast =3D 0, real recv =3D 0, local tq: 0, asym_penality: 0, total tq: 0
[ 1090] schedule_forward_packet():
[ 1090] forwarding: tq_orig: 0, tq_forw: 0
[ 1090] Forward packet: rebroadcast neighbour packet with direct link and u=
nidirectional flag
[ 1090] Forwarding packet (originator 105.12.0.20, seqno 55800, TTL 49) on =
interface eth2:0
[ 1090] ------------------ DEBUG ------------------
[ 1090] Forward list
[ 1090] 105.13.0.54 at 1946
[ 1090] Originator list
[ 1090] Originator Router (#/255 #/64): Potential routers
[ 1090] No batman nodes in range ...
[ 1090] ---------------------------------------------- END DEBUG
[ 1090]

[ 1090] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54=
 (from OG: 105.12.0.20, seqno 55800, tq 0, TTL 49, V 4, UDF 1, IDF 1)
[ 1090] HNA information received (1 HNA network):
[ 1090] hna: 105.0.200.6/32
[ 1090] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 1090]

[ 1950] Forwarding packet (originator 105.13.0.54, seqno 2, TTL 50) on inte=
rface eth2:0
[ 1950] count own bcast (schedule_own_packet): old =3D 0, [ 1950] new =3D 0
[ 1950]

[ 1950] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54=
 (from OG: 105.13.0.54, seqno 2, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 1950] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 1950]

[ 2710] Received BATMAN packet via NB: 105.12.0.20 , IF: eth2:0 105.13.0.54=
 (from OG: 105.12.0.20, seqno 55801, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 2710] HNA information received (1 HNA network):
[ 2710] hna: 105.0.200.6/32
[ 2710] Other host probably restarted !
[ 2720] updating last_seqno: old 0, new 55801
[ 2720] bidirectional: orig =3D 105.12.0.20 neigh =3D 105.12.0.20 =3D> own_=
bcast =3D 0, real recv =3D 1, local tq: 0, asym_penality: 8, total tq: 0
[ 2720] schedule_forward_packet():
[ 2720] forwarding: tq_orig: 0, tq_forw: 0
[ 2720] Forward packet: rebroadcast neighbour packet with direct link and u=
nidirectional flag
[ 2720] Forwarding packet (originator 105.12.0.20, seqno 55801, TTL 49) on =
interface eth2:0
[ 2720] ------------------ DEBUG ------------------
[ 2720] Forward list
[ 2720] 105.13.0.54 at 2903
[ 2720] Originator list
[ 2720] Originator Router (#/255 #/64): Potential routers
[ 2720] No batman nodes in range ...
[ 2720] ---------------------------------------------- END DEBUG
[ 2720]

[ 2720] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54=
 (from OG: 105.12.0.20, seqno 55801, tq 0, TTL 49, V 4, UDF 1, IDF 1)
[ 2720] HNA information received (1 HNA network):
[ 2720] hna: 105.0.200.6/32
[ 2720] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 2720]

[ 2910] Forwarding packet (originator 105.13.0.54, seqno 3, TTL 50) on inte=
rface eth2:0
[ 2910] count own bcast (schedule_own_packet): old =3D 0, [ 2910] new =3D 0
[ 2910]

[ 2910] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54=
 (from OG: 105.13.0.54, seqno 3, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 2910] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 2910]

[ 3980] Forwarding packet (originator 105.13.0.54, seqno 4, TTL 50) on inte=
rface eth2:0
[ 3980] count own bcast (schedule_own_packet): old =3D 0, [ 3980] new =3D 0
[ 3980]

[ 3980] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54=
 (from OG: 105.13.0.54, seqno 4, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 3980] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 3980] ------------------ DEBUG ------------------
[ 3980] Forward list
[ 3980] 105.13.0.54 at 4917
[ 3980] Originator list
[ 3980] Originator Router (#/255 #/64): Potential routers
[ 3980] No batman nodes in range ...
[ 3980] ---------------------------------------------- END DEBUG
[ 3980]

[ 4920] Forwarding packet (originator 105.13.0.54, seqno 5, TTL 50) on inte=
rface eth2:0
[ 4920] count own bcast (schedule_own_packet): old =3D 0, [ 4920] new =3D 0
[ 4920]

[ 4920] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54=
 (from OG: 105.13.0.54, seqno 5, tq 255, TTL 50, V 4, UDF 0, IDF 0)
[ 4920] Drop packet: received my own broadcast (sender: 105.13.0.54)
[ 4920]

[ 6870] Forwarding packet (originator 105.13.0.54, seqno 6, TTL 50) on inte=
rface eth2:0
[ 6870] count own bcast (schedule_own_packet): old =3D 0, [ 6870] new =3D 0
Deleting all BATMAN routes
[ 6870] Originator timeout: originator 105.12.0.20, last_valid 2710
[ 6870] update_routes()
[ 6870] Error - can't delete rule to 105.0.0.0/8: Invalid argument
[ 6870] Error - can't delete rule to 105.0.0.0/8: Invalid argument
[ 6870] Error - can't delete rule to 105.0.0.0/8: Invalid argument
[ 6870] Error - can't delete rule to 105.0.0.0/8: Invalid argument
[ 6870] Error - can't delete rule to 0.0.0.0/0: Invalid argument
[ 6870] Error - can't delete rule to 0.0.0.0/0: Invalid argument
root@OpenWrt:/etc/init.d#=20

_________________________________________________________________
Windows Live Writer Beta - Ver=F6ffentlichen Sie Multimediainhalte in Ihrem=
 Blog!
http://get.live.com/betas/writer_betas=

--_5d0c449d-0c3e-49e8-b728-7055d1fa72a3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">hello batmen, ;)=
<br><br>here in berlin NE we are about to update the batmands on our backbo=
ne to 0.3.0 . atm our net is mainly running on olsr and batman in parallel =
for testing purpose.<br>after some changes in the net we got heavy HNA-hopp=
ing with olsr which is related to the improper metric in our case. therefor=
e we are somewhat forcing the<br>migration to batman and got some strange d=
efault routes with the most recent 0.3.0 builds on some routers:<br><br>roo=
t@OpenWrt:/etc/init.d# route -n<br>Destination&nbsp; Gateway&nbsp; Genmask&=
nbsp; Flags Metric Ref&nbsp;&nbsp;&nbsp; Use Iface<br>[...]<br>0.0.0.0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0.0.0&nbsp;&nbsp;&nbsp;&nbsp;=
 0.0.0.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; *<br>[...]<br><br>batmand ha=
s been started with the following parameters:&nbsp; /usr/sbin/batmand -g 0 =
-r 0 eth2<br><br>after appearance of this default-route olsr-"clients" cann=
ot use the uplink anymore, so further testing&nbsp; is difficult.<br>we hav=
e another problem with this build, but cannot investigate further because o=
f this behaviour. so any help is appreciated.<br><br>thanks<br><br>dennis b=
artsch<br>freifunk-bno.de<br><br>attached is some console-output:<br>######=
#####################<br>root@OpenWrt:/etc/init.d# ifconfig<br>eth2 Link en=
cap:Ethernet HWaddr 00:01:36:0D:D2:63<br>inet addr:104.13.0.54 Bcast:104.25=
5.255.255 Mask:255.0.0.0<br>UP BROADCAST RUNNING MULTICAST MTU:512 Metric:1=
<br>RX packets:105511 errors:0 dropped:0 overruns:0 frame:0<br>TX packets:1=
22436 errors:0 dropped:0 overruns:0 carrier:0<br>collisions:0 txqueuelen:10=
00<br>RX bytes:61107954 (58.2 MiB) TX bytes:45973166 (43.8 MiB)<br>Interrup=
t:27<br><br>eth2:0 Link encap:Ethernet HWaddr 00:01:36:0D:D2:63<br>inet add=
r:105.13.0.54 Bcast:105.255.255.255 Mask:255.0.0.0<br>UP BROADCAST RUNNING =
MULTICAST MTU:512 Metric:1<br>Interrupt:27<br><br>lo Link encap:Local Loopb=
ack<br>inet addr:127.0.0.1 Mask:255.0.0.0<br>UP LOOPBACK RUNNING MTU:16436 =
Metric:1<br>RX packets:2800 errors:0 dropped:0 overruns:0 frame:0<br>TX pac=
kets:2800 errors:0 dropped:0 overruns:0 carrier:0<br>collisions:0 txqueuele=
n:0<br>RX bytes:288724 (281.9 KiB) TX bytes:288724 (281.9 KiB)<br><br>wifi0=
 Link encap:UNSPEC HWaddr 00-0B-6B-4D-63-8B-00-0A-00-00-00-00-00-00-00-00<b=
r>UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1<br>RX packets:997788 err=
ors:0 dropped:1221 overruns:0 frame:443273<br>TX packets:688240 errors:0 dr=
opped:0 overruns:0 carrier:0<br>collisions:0 txqueuelen:199<br>RX bytes:305=
805070 (291.6 MiB) TX bytes:126339425 (120.4 MiB)<br>Interrupt:28<br><br>ro=
ot@OpenWrt:/etc/init.d# /usr/sbin/batmand -g 0 -r 0 eth2:0 -d 4<br>WARNING:=
 You are using the unstable batman branch. If you are interested in *using*=
 batman get the latest stable release !<br>[ 0] Error - can't add rule to 1=
05.0.0.0/8: Invalid argument<br>[ 0] Error - can't add rule to 105.0.0.0/8:=
 Invalid argument<br>Using interface eth2:0 with address 105.13.0.54 and br=
oadcast address 105.255.255.255<br>B.A.T.M.A.N. 0.3-beta (compatibility ver=
sion 4)<br>[ 0] Error - can't add rule to 0.0.0.0/0: Invalid argument<br>[ =
10] Error - can't add rule to 0.0.0.0/0: Invalid argument<br>debug level: 4=
<br>[ 20]<br><br>[ 940] Forwarding packet (originator 105.13.0.54, seqno 1,=
 TTL 50) on interface eth2:0<br>[ 940]<br><br>[ 940] Received BATMAN packet=
 via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54 (from OG: 105.13.0.54, seqno =
1, tq 255, TTL 50, V 4, UDF 0, IDF 0)<br>[ 940] Drop packet: received my ow=
n broadcast (sender: 105.13.0.54)<br>[ 940]<br>[ 1090] Received BATMAN pack=
et via NB: 105.12.0.20 , IF: eth2:0 105.13.0.54 (from OG: 105.12.0.20, seqn=
o 55800, tq 255, TTL 50, V 4, UDF 0, IDF 0)<br>[ 1090] HNA information rece=
ived (1 HNA network):<br>[ 1090] hna: 105.0.200.6/32<br>[ 1090] Creating ne=
w originator: 105.12.0.20<br>[ 1090] Creating new last-hop neighbour of ori=
ginator<br>[ 1090] bidirectional: orig =3D 105.12.0.20 neigh =3D 105.12.0.2=
0 =3D&gt; own_bcast =3D 0, real recv =3D 0, local tq: 0, asym_penality: 0, =
total tq: 0<br>[ 1090] schedule_forward_packet():<br>[ 1090] forwarding: tq=
_orig: 0, tq_forw: 0<br>[ 1090] Forward packet: rebroadcast neighbour packe=
t with direct link and unidirectional flag<br>[ 1090] Forwarding packet (or=
iginator 105.12.0.20, seqno 55800, TTL 49) on interface eth2:0<br>[ 1090] -=
----------------- DEBUG ------------------<br>[ 1090] Forward list<br>[ 109=
0] 105.13.0.54 at 1946<br>[ 1090] Originator list<br>[ 1090] Originator Rou=
ter (#/255 #/64): Potential routers<br>[ 1090] No batman nodes in range ...=
<br>[ 1090] ---------------------------------------------- END DEBUG<br>[ 1=
090]<br><br>[ 1090] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0=
 105.13.0.54 (from OG: 105.12.0.20, seqno 55800, tq 0, TTL 49, V 4, UDF 1, =
IDF 1)<br>[ 1090] HNA information received (1 HNA network):<br>[ 1090] hna:=
 105.0.200.6/32<br>[ 1090] Drop packet: received my own broadcast (sender: =
105.13.0.54)<br>[ 1090]<br><br>[ 1950] Forwarding packet (originator 105.13=
.0.54, seqno 2, TTL 50) on interface eth2:0<br>[ 1950] count own bcast (sch=
edule_own_packet): old =3D 0, [ 1950] new =3D 0<br>[ 1950]<br><br>[ 1950] R=
eceived BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54 (from OG=
: 105.13.0.54, seqno 2, tq 255, TTL 50, V 4, UDF 0, IDF 0)<br>[ 1950] Drop =
packet: received my own broadcast (sender: 105.13.0.54)<br>[ 1950]<br><br>[=
 2710] Received BATMAN packet via NB: 105.12.0.20 , IF: eth2:0 105.13.0.54 =
(from OG: 105.12.0.20, seqno 55801, tq 255, TTL 50, V 4, UDF 0, IDF 0)<br>[=
 2710] HNA information received (1 HNA network):<br>[ 2710] hna: 105.0.200.=
6/32<br>[ 2710] Other host probably restarted !<br>[ 2720] updating last_se=
qno: old 0, new 55801<br>[ 2720] bidirectional: orig =3D 105.12.0.20 neigh =
=3D 105.12.0.20 =3D&gt; own_bcast =3D 0, real recv =3D 1, local tq: 0, asym=
_penality: 8, total tq: 0<br>[ 2720] schedule_forward_packet():<br>[ 2720] =
forwarding: tq_orig: 0, tq_forw: 0<br>[ 2720] Forward packet: rebroadcast n=
eighbour packet with direct link and unidirectional flag<br>[ 2720] Forward=
ing packet (originator 105.12.0.20, seqno 55801, TTL 49) on interface eth2:=
0<br>[ 2720] ------------------ DEBUG ------------------<br>[ 2720] Forward=
 list<br>[ 2720] 105.13.0.54 at 2903<br>[ 2720] Originator list<br>[ 2720] =
Originator Router (#/255 #/64): Potential routers<br>[ 2720] No batman node=
s in range ...<br>[ 2720] ---------------------------------------------- EN=
D DEBUG<br>[ 2720]<br><br>[ 2720] Received BATMAN packet via NB: 105.13.0.5=
4 , IF: eth2:0 105.13.0.54 (from OG: 105.12.0.20, seqno 55801, tq 0, TTL 49=
, V 4, UDF 1, IDF 1)<br>[ 2720] HNA information received (1 HNA network):<b=
r>[ 2720] hna: 105.0.200.6/32<br>[ 2720] Drop packet: received my own broad=
cast (sender: 105.13.0.54)<br>[ 2720]<br><br>[ 2910] Forwarding packet (ori=
ginator 105.13.0.54, seqno 3, TTL 50) on interface eth2:0<br>[ 2910] count =
own bcast (schedule_own_packet): old =3D 0, [ 2910] new =3D 0<br>[ 2910]<br=
><br>[ 2910] Received BATMAN packet via NB: 105.13.0.54 , IF: eth2:0 105.13=
.0.54 (from OG: 105.13.0.54, seqno 3, tq 255, TTL 50, V 4, UDF 0, IDF 0)<br=
>[ 2910] Drop packet: received my own broadcast (sender: 105.13.0.54)<br>[ =
2910]<br><br>[ 3980] Forwarding packet (originator 105.13.0.54, seqno 4, TT=
L 50) on interface eth2:0<br>[ 3980] count own bcast (schedule_own_packet):=
 old =3D 0, [ 3980] new =3D 0<br>[ 3980]<br><br>[ 3980] Received BATMAN pac=
ket via NB: 105.13.0.54 , IF: eth2:0 105.13.0.54 (from OG: 105.13.0.54, seq=
no 4, tq 255, TTL 50, V 4, UDF 0, IDF 0)<br>[ 3980] Drop packet: received m=
y own broadcast (sender: 105.13.0.54)<br>[ 3980] ------------------ DEBUG -=
-----------------<br>[ 3980] Forward list<br>[ 3980] 105.13.0.54 at 4917<br=
>[ 3980] Originator list<br>[ 3980] Originator Router (#/255 #/64): Potenti=
al routers<br>[ 3980] No batman nodes in range ...<br>[ 3980] -------------=
--------------------------------- END DEBUG<br>[ 3980]<br><br>[ 4920] Forwa=
rding packet (originator 105.13.0.54, seqno 5, TTL 50) on interface eth2:0<=
br>[ 4920] count own bcast (schedule_own_packet): old =3D 0, [ 4920] new =
=3D 0<br>[ 4920]<br><br>[ 4920] Received BATMAN packet via NB: 105.13.0.54 =
, IF: eth2:0 105.13.0.54 (from OG: 105.13.0.54, seqno 5, tq 255, TTL 50, V =
4, UDF 0, IDF 0)<br>[ 4920] Drop packet: received my own broadcast (sender:=
 105.13.0.54)<br>[ 4920]<br><br>[ 6870] Forwarding packet (originator 105.1=
3.0.54, seqno 6, TTL 50) on interface eth2:0<br>[ 6870] count own bcast (sc=
hedule_own_packet): old =3D 0, [ 6870] new =3D 0<br>Deleting all BATMAN rou=
tes<br>[ 6870] Originator timeout: originator 105.12.0.20, last_valid 2710<=
br>[ 6870] update_routes()<br>[ 6870] Error - can't delete rule to 105.0.0.=
0/8: Invalid argument<br>[ 6870] Error - can't delete rule to 105.0.0.0/8: =
Invalid argument<br>[ 6870] Error - can't delete rule to 105.0.0.0/8: Inval=
id argument<br>[ 6870] Error - can't delete rule to 105.0.0.0/8: Invalid ar=
gument<br>[ 6870] Error - can't delete rule to 0.0.0.0/0: Invalid argument<=
br>[ 6870] Error - can't delete rule to 0.0.0.0/0: Invalid argument<br>root=
@OpenWrt:/etc/init.d# <br></div><br /><hr />Schon gesehen? Tolle Bilder von=
 Sarah Connor gibt es hier! <a href=3D'http://redirect.gimas.net/?cat=3Dhmt=
l&n=3DM1007S&d=3Dhttp://search.msn.de/images/results.aspx?q=3DSarah%20Conno=
r' target=3D'_new'>Live Search</a></body>
</html>=

--_5d0c449d-0c3e-49e8-b728-7055d1fa72a3_--
