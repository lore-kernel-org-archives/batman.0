Message-ID: <497EC25F.2060406@francofon.fr>
Date: Tue, 27 Jan 2009 09:14:23 +0100
From: SoukoussMan <soukoussman@francofon.fr>
MIME-Version: 1.0
References: <497CE6F6.7090504@francofon.fr>	<200901260711.12511.lindner_marek@yahoo.de>	<497D7F55.9040104@francofon.fr>	<200901261808.22139.lindner_marek@yahoo.de>
	<003401c97fa8$cd3c1570$67b44050$@fr>
In-Reply-To: <003401c97fa8$cd3c1570$67b44050$@fr>
Content-Type: multipart/alternative;
	boundary="------------040902070704030301070209"
Subject: Re: [B.A.T.M.A.N.] problem with batman test
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

This is a multi-part message in MIME format.
--------------040902070704030301070209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Someone can help me to find which command is executed to add the=20
169.254.0.0/16 route to try to execute manually and look if i've a error =
?

SoukoussMan - FrancoFON CEO a =C3=A9crit :
> Hi,
>
> When batmand is launch and show this :
> root@Fonera:~# /usr/bin/batmand -g 1mbit/1024 -o 2000 -d 3 ath2
> Interface activated: ath2
> Using interface ath2 with address 5.0.0.1 and broadcast address
> 5.255.255.255
> B.A.T.M.A.N. 0.3.1 rv1203 (compatibility version 5)
> Warning - batgat kernel modul interface (/dev/batgat) not usable: No su=
ch
> file or directory
> This may decrease the performance of batman!
> debug level: 3
> originator interval: 2000
> gateway class: 39 -> propagating: 1024KBit/1024KBit
> Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
>
> I do this command :=20
> root@Fonera:~# ip route ls table 254
> 192.168.182.0/24 dev tun0  proto kernel  scope link  src 192.168.182.1 =

> 192.168.18.0/24 dev eth0.1  proto kernel  scope link  src 192.168.18.3 =

> 192.168.10.0/24 dev br-lan  proto kernel  scope link  src 192.168.10.1 =

> 5.0.0.0/8 dev ath2  proto kernel  scope link  src 5.0.0.1=20
> default via 192.168.18.1 dev eth0.1=20
> root@Fonera:~#
>
> The route isn't present in the table 254.
>
>
> Cordialement,
>
>  =20

--=20
-----
FrancoFON CEO and Founder
Pr=C3=A9sident de l'association FrancoFON
Communaut=C3=A9 des foneros francophones - http://www.francofon.fr


--------------040902070704030301070209
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
</head>
<body bgcolor=3D"#ffffff" text=3D"#333399">
<font size=3D"+1"><font face=3D"Courier New, Courier, monospace">Hi,<br>
<br>
Someone can help me to find which command is executed to add the
169.254.0.0/16 route to try to execute manually and look if i've a
error ?<br>
</font></font><br>
SoukoussMan - FrancoFON CEO a =C3=A9crit=C2=A0:
<blockquote cite=3D"mid:003401c97fa8$cd3c1570$67b44050$@fr" type=3D"cite"=
>
  <pre wrap=3D"">Hi,

When batmand is launch and show this :
root@Fonera:~# /usr/bin/batmand -g 1mbit/1024 -o 2000 -d 3 ath2
Interface activated: ath2
Using interface ath2 with address 5.0.0.1 and broadcast address
5.255.255.255
B.A.T.M.A.N. 0.3.1 rv1203 (compatibility version 5)
Warning - batgat kernel modul interface (/dev/batgat) not usable: No such=

file or directory
This may decrease the performance of batman!
debug level: 3
originator interval: 2000
gateway class: 39 -&gt; propagating: 1024KBit/1024KBit
Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)

I do this command :=20
root@Fonera:~# ip route ls table 254
192.168.182.0/24 dev tun0  proto kernel  scope link  src 192.168.182.1=20
192.168.18.0/24 dev eth0.1  proto kernel  scope link  src 192.168.18.3=20
192.168.10.0/24 dev br-lan  proto kernel  scope link  src 192.168.10.1=20
5.0.0.0/8 dev ath2  proto kernel  scope link  src 5.0.0.1=20
default via 192.168.18.1 dev eth0.1=20
root@Fonera:~#

The route isn't present in the table 254.


Cordialement,

  </pre>
</blockquote>
<br>
<pre class=3D"moz-signature" cols=3D"72">--=20
-----
FrancoFON CEO and Founder
Pr=C3=A9sident de l'association FrancoFON
Communaut=C3=A9 des foneros francophones - <a class=3D"moz-txt-link-freet=
ext" href=3D"http://www.francofon.fr">http://www.francofon.fr</a>
</pre>
</body>
</html>

--------------040902070704030301070209--
