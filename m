MIME-Version: 1.0
Date: Fri, 23 Jan 2009 18:30:15 -0600
Message-ID: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd181c0fbbc0604612f9b80
Subject: [B.A.T.M.A.N.] Help in batman advanced configuration
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

--000e0cd181c0fbbc0604612f9b80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I am trying to bring up open mesh with batman advanced.  My network
configuration is as follows:

_____DSL cable_____Linksys Router____Cisco PIX______Switch______ open mesh 1
---------- open mesh 2 -------- client laptop

192.168.50.1 | _______ my PC

       |_______

       |_______

                          |_______

My IPs get automatically assigned by the PIX (In the subnet 192.168.50.0)

OPEN MESH 1 - configuration
===========================

1. I stop the routing daemons running on them.  It has eth0, ath0, ath1 and
ath2 interfaces
   where ath0 is in adhoc mode and ath1 and ath2 are in master mode

   I create a bridge between all these interfaces (br0 - eth0, ath0, ath1,
ath2) and i run
   udhcpc with br0 as an argument so that my bridge gets an IP from the
network

   All other interfaces are given an IP of 0.0.0.0

   My bridge gets an IP (192.168.50.5)

   I have batman_core module and i update the
/proc/net/batman-adv/interfaces with br0 interface
 echo br0 > /proc/net/batman-adv/interfaces


OPENMESH 2 - configuration
==========================

1. I stop the routing daemons. It has ath0, ath1, ath2 interfaces.
   I again bridge these interfaces (br0 - ath0, ath1, ath2

   I try getting an IP for this node usign the same method of running udhcpc
but i am unable to
   So I dont have an IP - but i dont worry about it now.

    I have batman_core module and i update the
/proc/net/batman-adv/interfaces with br0 interface
 echo br0 > /proc/net/batman-adv/interfaces


OBSERVATION
===========
Now when i check connectivity using battool i can ping between openmesh 2
and openmesh 1 using battool bp
My originators file indicate the mac of the other mesh node

E.g. on openmesh2

root@open-mesh:/proc/net/batman-adv# cat originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential
nexthops ..
. [B.A.T.M.A.N. Adv 0.1-beta rv1103, MainIF/MAC: br0/00:18:0a:01:44:d0]
openmesh1 MAC  (255) openmesh1 MAC [       br0]: openmesh1 MAC (255)

Associate a client
==================

I now try to associate a client to open mesh 2.  Its IP request gets
forwarded to the wired network and it receives an IP
(192.168.50.6)

However i can't batping to it from either openmesh 2 or openmesh 1

Is something missing in my configuration?

--000e0cd181c0fbbc0604612f9b80
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi</p>
<p>I am trying to bring up open mesh with batman advanced.&nbsp; My network=
 configuration is as follows:</p>
<p>_____DSL cable_____Linksys Router____Cisco PIX______Switch______ open me=
sh 1 ---------- open mesh 2 -------- client laptop<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 192.168.50.1 |&nbsp;=
_______ my PC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|_______ <br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|_______<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;|_______</p>

<p>My IPs get automatically assigned by the PIX (In the subnet 192.168.50.0=
)</p>
<p>OPEN MESH 1 - configuration<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</p>
<p>1. I stop the routing daemons running on them.&nbsp; It has eth0, ath0, =
ath1 and ath2 interfaces <br>&nbsp;&nbsp; where ath0 is in adhoc mode and a=
th1 and ath2 are in master mode</p>
<p>&nbsp;&nbsp; I create a bridge between all these interfaces (br0 - eth0,=
 ath0, ath1, ath2) and i run<br>&nbsp;&nbsp; udhcpc with br0 as an argument=
 so that my bridge gets an IP from the network</p>
<p>&nbsp;&nbsp; All other interfaces are given an IP of 0.0.0.0</p>
<p>&nbsp;&nbsp; My bridge gets an IP (192.168.50.5)</p>
<p>&nbsp;&nbsp; I have batman_core module and i update the /proc/net/batman=
-adv/interfaces with br0 interface<br>&nbsp;echo br0 &gt; /proc/net/batman-=
adv/interfaces</p>
<p><br>OPENMESH 2 - configuration<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</p>
<p>1. I stop the routing daemons. It has ath0, ath1, ath2 interfaces.<br>&n=
bsp;&nbsp; I again bridge these interfaces (br0 - ath0, ath1, ath2</p>
<p>&nbsp;&nbsp; I try getting an IP for this node usign the same method of =
running udhcpc but i am unable to<br>&nbsp;&nbsp; So I dont have an IP - bu=
t i dont worry about it now.</p>
<p>&nbsp;&nbsp;&nbsp; I have batman_core module and i update the /proc/net/=
batman-adv/interfaces with br0 interface<br>&nbsp;echo br0 &gt; /proc/net/b=
atman-adv/interfaces</p>
<p><br>OBSERVATION<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Now when i check=
 connectivity using battool i can ping between openmesh 2 and openmesh 1 us=
ing battool bp<br>My originators file indicate the mac of the other mesh no=
de</p>
<p>E.g. on openmesh2</p>
<p><a href=3D"mailto:root@open-mesh:/proc/net/batman-adv">root@open-mesh:/p=
roc/net/batman-adv</a># cat originators<br>&nbsp; Originator&nbsp;&nbsp;&nb=
sp;&nbsp; (#/255)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; Nexthop [outgoingIF]:&nbsp;&nbsp; Potential nexthops ..<br>. [B.A.T.M.A.=
N. Adv 0.1-beta rv1103, MainIF/MAC: br0/00:18:0a:01:44:d0]<br>
openmesh1 MAC&nbsp; (255) openmesh1 MAC [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; br0]: openmesh1 MAC (255)</p>
<p>Associate a client<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</p>
<p>I now try to associate a client to open mesh 2.&nbsp; Its IP request get=
s forwarded to the wired network and it receives an IP<br>(192.168.50.6)</p=
>
<p>However i can&#39;t batping to it from either openmesh 2 or openmesh 1</=
p>
<p>Is something missing in my configuration?</p>
<p>&nbsp;</p>

--000e0cd181c0fbbc0604612f9b80--
