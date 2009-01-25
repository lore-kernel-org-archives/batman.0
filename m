Message-ID: <497CE6F6.7090504@francofon.fr>
Date: Sun, 25 Jan 2009 23:25:58 +0100
From: SoukoussMan <soukoussman@francofon.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------030601040403060206070103"
Subject: [B.A.T.M.A.N.] problem with batman test
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

This is a multi-part message in MIME format.
--------------030601040403060206070103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I've make a test today with Batman and La Fonera2.
I've a problem with the 169.254.0.0/16 routing. In fact, when i launch=20
batman, the 169.254.0.0/16 route with gate0 dev don't add correctly.
With this, i can't have reply on my request.
If i add manually the route with "ip route add table 254 to=20
169.254.0.0/16 dev gate0" this work.

How can i debug this problem.
I've use "-d 4" but i don't have see problem in log. I past you a quick=20
start without node connected :

    root@Fonera:~# /tmp/batmand -o 2000 -g 5000 ath2 -d 4
    Interface activated: ath2
    Using interface ath2 with address 5.0.0.1 and broadcast address
    5.255.255.255
    B.A.T.M.A.N. 0.3.1 rv1203 (compatibility version 5)
    [        30] Warning - batgat kernel modul interface (/dev/batgat)
    not usable: No such file or directory
    This may decrease the performance of batman!
    [        30] Warning - batgat kernel modul interface (/dev/batgat)
    not usable: No such file or directory
    This may decrease the performance of batman!
    debug level: 4
    originator interval: 2000
    gateway class: 49 -> propagating: 4MBit/1024KBit
    [        70] schedule_own_packet(): ath2
    [        80]=20
    [       100] Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 -
    gate0)
    [      2050]=20
    [      2060] Sending own packet (originator 5.0.0.1, seqno 1, TTL
    50, IDF off) on interface ath2
    [      2060] schedule_own_packet(): ath2
    [      2060] ------------------ DEBUG ------------------
    [      2060] Forward list
    [      2060]     5.0.0.1 at 4151
    [      2060] Originator list
    [      2060]   Originator  (#/255)         Nexthop [outgoingIF]: =20
    Potential nexthops
    [      2060] No batman nodes in range ...
    [      2060] ---------------------------------------------- END DEBUG=

    [      2060]=20
    [      2060] Received BATMAN packet via NB: 5.0.0.1, IF: ath2
    5.0.0.1 (from OG: 5.0.0.1, via old OG: 5.0.0.1, seqno 1, tq 255, TTL
    50, V 5, IDF 0)
    [      2060] Is an internet gateway (class 49)
    [      2070] Drop packet: received my own broadcast (sender: 5.0.0.1)=

    [      2070]=20
    [      4160]=20
    [      4170] Sending own packet (originator 5.0.0.1, seqno 2, TTL
    50, IDF off) on interface ath2
    [      4170] schedule_own_packet(): ath2
    [      4170] ------------------ DEBUG ------------------
    [      4170] Forward list
    [      4170]     5.0.0.1 at 6088
    [      4170] Originator list
    [      4170]   Originator  (#/255)         Nexthop [outgoingIF]: =20
    Potential nexthops
    [      4170] No batman nodes in range ...
    [      4170] ---------------------------------------------- END DEBUG=

    [      4170]=20
    [      4170] Received BATMAN packet via NB: 5.0.0.1, IF: ath2
    5.0.0.1 (from OG: 5.0.0.1, via old OG: 5.0.0.1, seqno 2, tq 255, TTL
    50, V 5, IDF 0)
    [      4170] Is an internet gateway (class 49)
    [      4180] Drop packet: received my own broadcast (sender: 5.0.0.1)=

    [      4180]=20
    [      6090]=20
    [      6100] Sending own packet (originator 5.0.0.1, seqno 3, TTL
    50, IDF off) on interface ath2
    [      6100] schedule_own_packet(): ath2
    [      6100] ------------------ DEBUG ------------------
    [      6100] Forward list
    [      6100]     5.0.0.1 at 8109
    [      6100] Originator list
    [      6100]   Originator  (#/255)         Nexthop [outgoingIF]: =20
    Potential nexthops
    [      6100] No batman nodes in range ...
    [      6100] ---------------------------------------------- END DEBUG=

    [      6100]=20
    [      6100] Received BATMAN packet via NB: 5.0.0.1, IF: ath2
    5.0.0.1 (from OG: 5.0.0.1, via old OG: 5.0.0.1, seqno 3, tq 255, TTL
    50, V 5, IDF 0)
    [      6100] Is an internet gateway (class 49)
    [      6100] Drop packet: received my own broadcast (sender: 5.0.0.1)=

    [      6110]=20
    ^C[      6610] Deleting route to 169.254.0.0/16 via 0.0.0.0 (table
    254 - gate0)
    [      6610] Error - can't delete route to 169.254.0.0/16 via
    0.0.0.0 (table 254): No such process
    [      6610] Error - can't delete route to 169.254.0.0/16 via
    0.0.0.0 (table 254): No such process
    Deleting all BATMAN routes
    root@Fonera:~#


In this log, a see "Adding route to 169.254.0.0/16 via 0.0.0.0 (table=20
254 - gate0)" but in the table 254, i don't have this route.
And when i stop BATMAN, the route can't be deleted because don't exist ( =

"Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table 254):=20
No such process")

Someone can help me please ?

--=20
-----
FrancoFON CEO and Founder
Pr=C3=A9sident de l'association FrancoFON
Communaut=C3=A9 des foneros francophones - http://www.francofon.fr


--------------030601040403060206070103
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor=3D"#ffffff" text=3D"#333399">
<font size=3D"+1"><font face=3D"Courier New, Courier, monospace">Hi,<br>
<br>
I've make a test today with Batman and La Fonera2.<br>
I've a problem with the </font></font><font size=3D"+1"><font
 face=3D"Courier New, Courier, monospace">169.254.0.0/16 routing. In
fact, when i launch batman, the </font></font><font size=3D"+1"><font
 face=3D"Courier New, Courier, monospace">169.254.0.0/16 route with gate0=

dev don't add correctly.<br>
With this, i can't have reply on my request.<br>
If i add manually the route with </font></font><font size=3D"+1"><font
 face=3D"Courier New, Courier, monospace">"ip
route add table 254 to 169.254.0.0/16 dev gate0" this work.<br>
<br>
How can i debug this problem.<br>
I've use "-d 4" but i don't have see problem in log. I past you a quick
start without node connected :<br>
<br>
</font></font>
<blockquote><font size=3D"+1"><font face=3D"Courier New, Courier, monospa=
ce">root@Fonera:~#
/tmp/batmand -o 2000 -g 5000 ath2 -d 4</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">Interf=
ace
activated: ath2</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">Using
interface ath2 with address 5.0.0.1 and broadcast address 5.255.255.255</=
font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">B.A.T.=
M.A.N.
0.3.1 rv1203 (compatibility version 5)</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
30] Warning - batgat kernel modul interface (/dev/batgat) not usable:
No such file or directory</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">This m=
ay
decrease the performance of batman!</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
30] Warning - batgat kernel modul interface (/dev/batgat) not usable:
No such file or directory</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">This m=
ay
decrease the performance of batman!</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">debug
level: 4</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">origin=
ator
interval: 2000</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">gatewa=
y
class: 49 -&gt; propagating: 4MBit/1024KBit</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
70] schedule_own_packet(): ath2 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
80]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
100] Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)</font=
></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2050]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] Sending own packet (originator 5.0.0.1, seqno 1, TTL 50, IDF off)
on interface ath2</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] schedule_own_packet(): ath2 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] ------------------ DEBUG ------------------ </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] Forward list </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060]=C2=A0=C2=A0=C2=A0=C2=A0 5.0.0.1 at 4151 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] Originator list </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060]=C2=A0=C2=A0 Originator=C2=A0 (#/255)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Nexthop [outgoingIF]:=C2=A0=C2=A0 Potential
nexthops</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] No batman nodes in range ... </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] ---------------------------------------------- END DEBUG </font></f=
ont><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] Received BATMAN packet via NB: 5.0.0.1, IF: ath2 5.0.0.1
(from OG: 5.0.0.1, via old OG: 5.0.0.1, seqno 1, tq 255, TTL 50, V 5,
IDF 0) </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2060] Is an internet gateway (class 49) </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2070] Drop packet: received my own broadcast (sender: 5.0.0.1) </font></f=
ont><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
2070]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4160]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] Sending own packet (originator 5.0.0.1, seqno 2, TTL 50, IDF off)
on interface ath2</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] schedule_own_packet(): ath2 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] ------------------ DEBUG ------------------ </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] Forward list </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170]=C2=A0=C2=A0=C2=A0=C2=A0 5.0.0.1 at 6088 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] Originator list </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170]=C2=A0=C2=A0 Originator=C2=A0 (#/255)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Nexthop [outgoingIF]:=C2=A0=C2=A0 Potential
nexthops</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] No batman nodes in range ... </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] ---------------------------------------------- END DEBUG </font></f=
ont><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] Received BATMAN packet via NB: 5.0.0.1, IF: ath2 5.0.0.1
(from OG: 5.0.0.1, via old OG: 5.0.0.1, seqno 2, tq 255, TTL 50, V 5,
IDF 0) </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4170] Is an internet gateway (class 49) </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4180] Drop packet: received my own broadcast (sender: 5.0.0.1) </font></f=
ont><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
4180]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6090]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] Sending own packet (originator 5.0.0.1, seqno 3, TTL 50, IDF off)
on interface ath2</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] schedule_own_packet(): ath2 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] ------------------ DEBUG ------------------ </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] Forward list </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100]=C2=A0=C2=A0=C2=A0=C2=A0 5.0.0.1 at 8109 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] Originator list </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100]=C2=A0=C2=A0 Originator=C2=A0 (#/255)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Nexthop [outgoingIF]:=C2=A0=C2=A0 Potential
nexthops</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] No batman nodes in range ... </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] ---------------------------------------------- END DEBUG </font></f=
ont><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] Received BATMAN packet via NB: 5.0.0.1, IF: ath2 5.0.0.1
(from OG: 5.0.0.1, via old OG: 5.0.0.1, seqno 3, tq 255, TTL 50, V 5,
IDF 0) </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] Is an internet gateway (class 49) </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6100] Drop packet: received my own broadcast (sender: 5.0.0.1) </font></f=
ont><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6110]=C2=A0 </font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">^C[=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
6610] Deleting route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)</f=
ont></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6610] Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table
254): No such process</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">[=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
6610] Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table
254): No such process</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">Deleti=
ng
all BATMAN routes</font></font><br>
  <font size=3D"+1"><font face=3D"Courier New, Courier, monospace">root@F=
onera:~#
  </font></font><br>
</blockquote>
<font size=3D"+1"><font face=3D"Courier New, Courier, monospace"><br>
In this log, a see "</font></font><font size=3D"+1"><font
 face=3D"Courier New, Courier, monospace">Adding route to 169.254.0.0/16
via 0.0.0.0 (table 254 - gate0)" but in the table 254, i don't have
this route.<br>
And when i stop BATMAN, the route can't be deleted because don't exist
( "</font></font><font size=3D"+1"><font
 face=3D"Courier New, Courier, monospace">Error - can't delete route to
169.254.0.0/16 via 0.0.0.0 (table 254): No such process")<br>
<br>
Someone can help me please ?<br>
</font></font><font size=3D"+1"><font
 face=3D"Courier New, Courier, monospace"><br>
</font></font>
<pre class=3D"moz-signature" cols=3D"72">--=20
-----
FrancoFON CEO and Founder
Pr=C3=A9sident de l'association FrancoFON
Communaut=C3=A9 des foneros francophones - <a class=3D"moz-txt-link-freet=
ext" href=3D"http://www.francofon.fr">http://www.francofon.fr</a>
</pre>
</body>
</html>

--------------030601040403060206070103--
