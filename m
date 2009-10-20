Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
From: Francesco <francesco.cappuccio@gmail.com>
Date: Tue, 20 Oct 2009 17:02:10 +0200
Message-ID: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
Content-Type: multipart/alternative; boundary=00163628453eb68f0a04765f26fb
Subject: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
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

--00163628453eb68f0a04765f26fb
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
i'm starting a B.A.T.M.A.N. mesh testbed, i've read some messages to find
some answers but no luck.
I'll try to explain what I've done and the errors i get..hope i get some
help in here.

From the beginning, I am using batman-adv 3.2 compiled along with batctl.
Only one wireless interface (wlan0) on each linux box (5 boxes by now)
Here are commands I fire on each node:

$ insmod batman-adv.ko
$ iwconfig wlan0 mode ad-hoc essid BATMAN_NET
$ echo wlan0 > /proc/net/batman-adv/interfaces
$ ifconfig wlan0 192.168.1.xxx up
$ ifconfig bat0 up

I get a new bat0 interface, iwconfig shows nodes properly part of the ad-hoc
network.
I see correct $batctl o  output but i cannot $batctl ping $mac_address

There are no bridges between interfaces. I just want to run batman-adv  on
wlan0.
Do I need to set an IP address for wlan0, for bat0 or for both?
Or I have to bridge bat0 and wlan0 together?




-- 
Francesco Cappuccio

--00163628453eb68f0a04765f26fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br>i&#39;m starting a B.A.T.M.A.N. mesh testbed, i&#39;ve read some=
 messages to find some answers but no luck.<br>I&#39;ll try to explain what=
 I&#39;ve done and the errors i get..hope i get some help in here.<br><br>

From the beginning, I am using batman-adv 3.2 compiled along with batctl.<b=
r>Only one wireless interface (wlan0) on each linux box (5 boxes by now)<br=
>Here are commands I fire on each node:<br><br>$ insmod batman-adv.ko<br>

$ iwconfig wlan0 mode ad-hoc essid BATMAN_NET<br>$ echo wlan0 &gt; /proc/ne=
t/batman-adv/interfaces<br>$ ifconfig wlan0 192.168.1.xxx up<br>$ ifconfig =
bat0 up<br><br>I get a new bat0 interface, iwconfig shows nodes properly pa=
rt of the ad-hoc network.<br>

I see correct $batctl o=A0 output but i cannot $batctl ping $mac_address<br=
><br>There are no bridges between interfaces. I just want to run batman-adv=
=A0 on wlan0.<br>Do I need to set an IP address for wlan0, for bat0 or for =
both?<br>

Or I have to bridge bat0 and wlan0 together?<br><br><br><br clear=3D"all"><=
br>-- <br>Francesco Cappuccio<br><br>

--00163628453eb68f0a04765f26fb--
