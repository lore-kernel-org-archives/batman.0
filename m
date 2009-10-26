Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
From: Francesco <francesco.cappuccio@gmail.com>
Date: Mon, 26 Oct 2009 11:27:02 +0100
Message-ID: <45f642440910260327u6eb01bc3nf468cc092fa8700@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0016e68deb6fccaea50476d401a5
Subject: [B.A.T.M.A.N.] batman-adv metric and next-hop choice
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--0016e68deb6fccaea50476d401a5
Content-Type: text/plain; charset=ISO-8859-1

Hi all
I am experimenting some path hopping in my tests using batman-adv.
Was wondering if and where metric information are shared among batman nodes
(again, with batman-adv) as I did not find any useful infos sniffing packets
with wireshark patched.

The command batctl l shows (with log level 8)

$ batctl l
[      9462] Changing route towards: 00:0b:6b:2f:53:09 (now via
00:0b:6b:34:88:94 - was via 00:0c:42:2c:d8:fc)
[      9525] Changing route towards: 00:0b:6b:2f:53:09 (now via
00:0c:42:2c:d8:fc - was via 00:0b:6b:34:88:94)
[      9560] Changing route towards: 00:0b:6b:2f:53:09 (now via
00:0b:6b:34:88:94 - was via 00:0c:42:2c:d8:fc)

But no info about actual metric when a route is changed.

Thanks.



-- 
Francesco Cappuccio

--0016e68deb6fccaea50476d401a5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all<br>I am experimenting some path hopping in my tests using batman-adv=
.<br>Was wondering if and where metric information are shared among batman =
nodes (again, with batman-adv) as I did not find any useful infos sniffing =
packets with wireshark patched.<br>

<br>The command batctl l shows (with log level 8)<br><br>$ batctl l<br>[=A0=
=A0=A0=A0=A0 9462] Changing route towards: 00:0b:6b:2f:53:09 (now via 00:0b=
:6b:34:88:94 - was via 00:0c:42:2c:d8:fc)<br>[=A0=A0=A0=A0=A0 9525] Changin=
g route towards: 00:0b:6b:2f:53:09 (now via 00:0c:42:2c:d8:fc - was via 00:=
0b:6b:34:88:94)<br>

[=A0=A0=A0=A0=A0 9560] Changing route towards: 00:0b:6b:2f:53:09 (now via 0=
0:0b:6b:34:88:94 - was via 00:0c:42:2c:d8:fc)<br><br>But no info about actu=
al metric when a route is changed.<br><br>Thanks.<br><br><br clear=3D"all">=
<br>-- <br>

Francesco Cappuccio<br><br>

--0016e68deb6fccaea50476d401a5--
