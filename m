Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
Date: Mon, 5 Oct 2009 11:21:13 +0200
Message-ID: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
From: Andrea Ghittino <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00c09ffb568e91284d04752ca240
Subject: [B.A.T.M.A.N.] batman-adv and TCP problem
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
To: b.a.t.m.a.n@lists.open-mesh.net

--00c09ffb568e91284d04752ca240
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,

I'm testing batman-adv in this scenario:

B1 -- GW -- EX

- B1 has only one interface (eth0) managed by batman
- GW has two interfaces: eth0, managed by batman and eth1
- EX has only one interface not managed by batman.

IP addresses:
- B1 - bat0: 192.168.10.1/24 - default gateway: 192.168.10.2
- GW: bat0: 192.168.10.2/24, eth1: 192.168.20.2/24
- EX: eth0: 192.168.20.3/24 - default gateway: 192.168.20.3

The three nodes are based on OpenWRT with kernel 2.6.28.10, but I have also
repeated the test using a Ubuntu 9.04 PC.

The IP connectivity is ok and I can ping from B1 to EX and vice versa.
I have installed a tcp echo server on the three nodes and it works between
B1-GW and GW-EX, but I have problem with B1-EX test.
B1 correctly receives data from EX, but EX application doesn=92t receive da=
ta
from B1. I repeated the test without batman and everything works fine.
Do you have any suggestion?
Regards,

--00c09ffb568e91284d04752ca240
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>I&#39;m testing batman-adv in this scenario:<br><br>B1 -- =
GW -- EX<br><br>- B1 has only one interface (eth0) managed by batman<br>- G=
W has two interfaces: eth0, managed by batman and eth1<br>- EX has only one=
 interface not managed by batman.<br>
<br>IP addresses:<br>- B1 - bat0: <a href=3D"http://192.168.10.1/24">192.16=
8.10.1/24</a> - default gateway: 192.168.10.2<br>- GW: bat0: <a href=3D"htt=
p://192.168.10.2/24">192.168.10.2/24</a>, eth1: <a href=3D"http://192.168.2=
0.2/24">192.168.20.2/24</a><br>
- EX: eth0: <a href=3D"http://192.168.20.3/24">192.168.20.3/24</a> - defaul=
t gateway: 192.168.20.3<br><br>The three nodes are based on OpenWRT with ke=
rnel 2.6.28.10, but I have also repeated the test using a Ubuntu 9.04 PC.<b=
r>
<br>The IP connectivity is ok and I can ping from B1 to EX and vice versa.<=
br>I have installed a tcp echo server on the three nodes and it works betwe=
en B1-GW and GW-EX, but I have problem with B1-EX test.<br>B1 correctly rec=
eives data from EX, but EX application doesn=92t receive data from B1. I re=
peated the test without batman and everything works fine. <br>
Do you have any suggestion?<br>Regards,<br><br><br><br>

--00c09ffb568e91284d04752ca240--
