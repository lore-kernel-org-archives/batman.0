Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910052201.30645.lindner_marek@yahoo.de>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910051849.49493.lindner_marek@yahoo.de>
	<d9bba8670910050512m41441532u5d28c6c2a476d152@mail.gmail.com>
	<200910052201.30645.lindner_marek@yahoo.de>
Date: Mon, 5 Oct 2009 22:54:22 +0200
Message-ID: <d9bba8670910051354i1039f6f7x76c2467032f68db2@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/mixed; boundary=00148531b9207834d604753651b1
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
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

--00148531b9207834d604753651b1
Content-Type: multipart/alternative; boundary=00148531b9207834c904753651af

--00148531b9207834c904753651af
Content-Type: text/plain; charset=ISO-8859-1

Dear Marek,

The ping with 1500 byte packets works.

The three nodes are connected in this way:
B1 --- batman --- GW1 ------- EX1
eth1 on B1 and GW1 is managed by batman. eth2 on gw1 not.
The IP configuration is:

B1:
# ip a
eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
UNKNOWN qlen 1000
    link/ether 52:54:00:00:20:01 brd ff:ff:ff:ff:ff:ff
bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1476 qdisc pfifo_fast state
UNKNOWN qlen 1000
    link/ether 00:ff:ad:e2:6f:dd brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.2/24 brd 192.168.100.255 scope global bat0
# ip r
192.168.100.0/24 dev bat0  proto kernel  scope link  src 192.168.100.2
default via 192.168.100.3 dev bat0

GW1;
# ip a
eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
UNKNOWN qlen 1000
    link/ether 52:54:00:00:30:01 brd ff:ff:ff:ff:ff:ff
eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
UNKNOWN qlen 1000
    link/ether 52:54:00:00:30:02 brd ff:ff:ff:ff:ff:ff
    inet 192.168.20.3/24 brd 192.168.20.255 scope global eth2
bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1476 qdisc pfifo_fast state
UNKNOWN qlen 1000
    link/ether 00:ff:15:c2:d0:73 brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.3/24 brd 192.168.100.255 scope global bat0
# ip r
192.168.100.0/24 dev bat0  proto kernel  scope link  src 192.168.100.3
192.168.20.0/24 dev eth2  proto kernel  scope link  src 192.168.20.3

EX1:
# ip a
bat0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:ff:a1:ff:bb:32 brd ff:ff:ff:ff:ff:ff
eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
UNKNOWN qlen 1000
    link/ether 52:54:00:00:40:01 brd ff:ff:ff:ff:ff:ff
    inet 192.168.20.4/24 brd 192.168.20.255 scope global eth1
# ip r
192.168.20.0/24 dev eth1  proto kernel  scope link  src 192.168.20.4
default via 192.168.20.3 dev eth1

I repeated the TCP test between B1 (server) and EX1 (client); the dump on B1
is:

20:04:28.900000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.39127 > 192.168.100.2.8001: TCP, flags [.S....], length 12
20:04:28.910000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [.S..A.], length 12
20:04:28.920000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.39127 > 192.168.100.2.8001: TCP, flags [....A.], length 0
20:04:29.820000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.39127 > 192.168.100.2.8001: TCP, flags [...PA.], length 4
20:04:29.830000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [....A.], length 0
20:04:29.830000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [...PA.], length 6
20:04:29.830000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [F...A.], length 0
20:04:29.850000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.39127 > 192.168.100.2.8001: TCP, flags [....A.], length 12
20:04:32.830000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [...PA.], length 6
20:04:38.830000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [...PA.], length 6
20:04:42.290000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.39127 > 192.168.100.2.8001: TCP, flags [F...A.], length 12
20:04:42.290000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.8001 > 192.168.20.4.39127: TCP, flags [....A.], length 0


and you can find as attachment problem.cap, that contains the dump on EX1.
As you can see, packets arrive to EX1, but it seems that the application
doesn't recognize them and B1 sends it again! (I ended the communication
closing server application).

I have repeated the test without batman and everything works fine (ok.cap is
the dump on EX1 in this case).
A question: am I the first one with this problem?
thanks

andrea

2009/10/5 Marek Lindner <lindner_marek@yahoo.de>

> On Monday 05 October 2009 20:12:20 a wrote:
> > No,
> >
> > it is not a MTU problem. TCP packet are small (I'm sending only few
> > characters) and big packet size (1400 byte) ping works
>
> The limit on ethernet is 1500 bytes - please try that.
> If that still works you should log the traffic on the GW with "batctl td"
> to see
> what your packets are doing. Feel free to post the log here if you need
> help.
>
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--00148531b9207834c904753651af
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Marek,<br><br>The ping with 1500 byte packets works.<br><br>The three =
nodes are connected in this way:<br>B1 --- batman --- GW1 ------- EX1<br>et=
h1 on B1 and GW1 is managed by batman. eth2 on gw1 not.<br>The IP configura=
tion is:<br>
<br>B1:<br># ip a<br>eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500=
 qdisc pfifo_fast state UNKNOWN qlen 1000<br>=A0=A0=A0 link/ether 52:54:00:=
00:20:01 brd ff:ff:ff:ff:ff:ff<br>bat0: &lt;BROADCAST,MULTICAST,UP,LOWER_UP=
&gt; mtu 1476 qdisc pfifo_fast state UNKNOWN qlen 1000<br>
=A0=A0=A0 link/ether 00:ff:ad:e2:6f:dd brd ff:ff:ff:ff:ff:ff<br>=A0=A0=A0 i=
net <a href=3D"http://192.168.100.2/24">192.168.100.2/24</a> brd 192.168.10=
0.255 scope global bat0<br># ip r<br><a href=3D"http://192.168.100.0/24">19=
2.168.100.0/24</a> dev bat0=A0 proto kernel=A0 scope link=A0 src 192.168.10=
0.2 <br>
default via 192.168.100.3 dev bat0 <br><br>GW1;<br># ip a<br>eth1: &lt;BROA=
DCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast state UNKNOWN qle=
n 1000<br>=A0=A0=A0 link/ether 52:54:00:00:30:01 brd ff:ff:ff:ff:ff:ff<br>e=
th2: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast stat=
e UNKNOWN qlen 1000<br>
=A0=A0=A0 link/ether 52:54:00:00:30:02 brd ff:ff:ff:ff:ff:ff<br>=A0=A0=A0 i=
net <a href=3D"http://192.168.20.3/24">192.168.20.3/24</a> brd 192.168.20.2=
55 scope global eth2<br>bat0: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1=
476 qdisc pfifo_fast state UNKNOWN qlen 1000<br>
=A0=A0=A0 link/ether 00:ff:15:c2:d0:73 brd ff:ff:ff:ff:ff:ff<br>=A0=A0=A0 i=
net <a href=3D"http://192.168.100.3/24">192.168.100.3/24</a> brd 192.168.10=
0.255 scope global bat0<br># ip r<br><a href=3D"http://192.168.100.0/24">19=
2.168.100.0/24</a> dev bat0=A0 proto kernel=A0 scope link=A0 src 192.168.10=
0.3 <br>
<a href=3D"http://192.168.20.0/24">192.168.20.0/24</a> dev eth2=A0 proto ke=
rnel=A0 scope link=A0 src 192.168.20.3 <br><br>EX1:<br># ip a<br> bat0: &lt=
;BROADCAST,MULTICAST&gt; mtu 1500 qdisc noop state DOWN qlen 1000<br>=A0=A0=
=A0 link/ether 00:ff:a1:ff:bb:32 brd ff:ff:ff:ff:ff:ff<br>
eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast sta=
te UNKNOWN qlen 1000<br>=A0=A0=A0 link/ether 52:54:00:00:40:01 brd ff:ff:ff=
:ff:ff:ff<br>=A0=A0=A0 inet <a href=3D"http://192.168.20.4/24">192.168.20.4=
/24</a> brd 192.168.20.255 scope global eth1<br>
# ip r<br><a href=3D"http://192.168.20.0/24">192.168.20.0/24</a> dev eth1=
=A0 proto kernel=A0 scope link=A0 src 192.168.20.4 <br>default via 192.168.=
20.3 dev eth1 <br><br>I repeated the TCP test between B1 (server) and EX1 (=
client); the dump on B1 is:<br>
<br>20:04:28.900000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST, tt=
l 50, IP 192.168.20.4.39127 &gt; 192.168.100.2.8001: TCP, flags [.S....], l=
ength 12<br>20:04:28.910000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: U=
CAST, ttl 50, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [.S=
..A.], length 12<br>
20:04:28.920000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST, ttl 50=
, IP 192.168.20.4.39127 &gt; 192.168.100.2.8001: TCP, flags [....A.], lengt=
h 0<br>20:04:29.820000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST,=
 ttl 50, IP 192.168.20.4.39127 &gt; 192.168.100.2.8001: TCP, flags [...PA.]=
, length 4<br>
20:04:29.830000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, ttl 50=
, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [....A.], lengt=
h 0<br>20:04:29.830000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST,=
 ttl 50, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [...PA.]=
, length 6<br>
20:04:29.830000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, ttl 50=
, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [F...A.], lengt=
h 0<br>20:04:29.850000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST,=
 ttl 50, IP 192.168.20.4.39127 &gt; 192.168.100.2.8001: TCP, flags [....A.]=
, length 12<br>
20:04:32.830000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, ttl 50=
, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [...PA.], lengt=
h 6<br>20:04:38.830000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST,=
 ttl 50, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [...PA.]=
, length 6<br>
20:04:42.290000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST, ttl 50=
, IP 192.168.20.4.39127 &gt; 192.168.100.2.8001: TCP, flags [F...A.], lengt=
h 12<br>20:04:42.290000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST=
, ttl 50, IP 192.168.100.2.8001 &gt; 192.168.20.4.39127: TCP, flags [....A.=
], length 0<br>
<br><br>and you can find as attachment problem.cap, that contains the dump =
on EX1. As you can see, packets arrive to EX1, but it seems that the applic=
ation doesn&#39;t recognize them and B1 sends it again! (I ended the commun=
ication closing server application).<br>
<br>I have repeated the test without batman and everything works fine (ok.c=
ap is the dump on EX1 in this case). <br>A question: am I the first one wit=
h this problem?<br>thanks<br><br>andrea<br><br><div class=3D"gmail_quote">
2009/10/5 Marek Lindner <span dir=3D"ltr">&lt;<a href=3D"mailto:lindner_mar=
ek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</span><br><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Monday 05 October 2009 20:12:20 a wrote:<br>
&gt; No,<br>
&gt;<br>
&gt; it is not a MTU problem. TCP packet are small (I&#39;m sending only fe=
w<br>
&gt; characters) and big packet size (1400 byte) ping works<br>
<br>
</div>The limit on ethernet is 1500 bytes - please try that.<br>
If that still works you should log the traffic on the GW with &quot;batctl =
td&quot; to see<br>
what your packets are doing. Feel free to post the log here if you need hel=
p.<br>
<div><div></div><div class=3D"h5"><br>
Regards,<br>
Marek<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br>

--00148531b9207834c904753651af--

--00148531b9207834d604753651b1
Content-Type: application/cap; name="problem.cap"
Content-Disposition: attachment; filename="problem.cap"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g0foq5yy0

1MOyoQIABAAAAAAAAAAAAEQAAAABAAAAZ1LKShCYAgA6AAAAQgAAAFJUAAAwAlJUAABAAQgARQAA
NMmLQABABnfhwKgUBMCoZAKY1x9B6dg6bgAAAACAAhbQgpAAAAIEBbRnUspKIL8CADoAAABCAAAA
UlQAAEABUlQAADACCABFAAA0AABAAD8GQm3AqGQCwKgUBB9BmNfi6tcd6dg6b4ASFnDI7gAAAgQF
nGdSykogvwIANgAAADYAAABSVAAAMAJSVAAAQAEIAEUAACjJjEAAQAZ37MCoFATAqGQCmNcfQenY
Om/i6tceUBALaBSrAABoUspKAHECADoAAAA6AAAAUlQAADACUlQAAEABCABFAAAsyY1AAEAGd+fA
qBQEwKhkApjXH0Hp2Dpv4urXHlAYC2g0JAAAcHBwCmhSykoQmAIAOgAAADwAAABSVAAAQAFSVAAA
MAIIAEUAAChRFkAAPwbxYsCoZALAqBQEH0GY1+Lq1x7p2DpzUBALOBTXAAAAAAAAaFLKShCYAgA6
AAAAPAAAAFJUAABAAVJUAAAwAggARQAALlEXQAA/BvFbwKhkAsCoFAQfQZjX4urXHunYOnNQGAs4
+XcAAGhlbGxoUspKEJgCADoAAAA8AAAAUlQAAEABUlQAADACCABFAAAoURhAAD8G8WDAqGQCwKgU
BB9BmNfi6tck6dg6c1ARCzgU0AAAAAAAAGhSykoQmAIAOgAAAEIAAABSVAAAMAJSVAAAQAEIAEUA
ADTJjkAAQAZ33sCoFATAqGQCmNcfQenYOnPi6tcegBALaGpvAAABAQUKa1LKSjBXBQA6AAAAPAAA
AFJUAABAAVJUAAAwAggARQAALlEZQAA/BvFZwKhkAsCoFAQfQZjX4urXHunYOnNQGAs4+XcAAGhl
bGxxUspK4OYLADoAAAA8AAAAUlQAAEABUlQAADACCABFAAAuURpAAD8G8VjAqGQCwKgUBB9BmNfi
6tce6dg6c1AYCzj5dwAAaGVsbHVSykpAfgUAOgAAADwAAABSVAAAQAFSVAAAMAIIBgABCAAGBAAB
UlQAADACwKgUAwAAAAAAAMCoFAQAAAAAAAAAAAAAAAAAAAAAdVLKSkB+BQAqAAAAKgAAAFJUAAAw
AlJUAABAAQgGAAEIAAYEAAJSVAAAQAHAqBQEUlQAADACwKgUA3VSykoQegcAOgAAAEIAAABSVAAA
MAJSVAAAQAEIAEUAADTJj0AAQAZ33cCoFATAqGQCmNcfQenYOnPi6tcegBELaGpuAAABAQUKdVLK
SiChBwA6AAAAPAAAAFJUAABAAVJUAAAwAggARQAAKFEbQAA/BvFdwKhkAsCoFAQfQZjX4urXJenY
OnRQEAs4FM8AAAAAAAB+UspKAMQJADoAAAA8AAAAUlQAAEABUlQAADACCABFAAAuURxAAD8G8VbA
qGQCwKgUBB9BmNfi6tce6dg6dFAYCzj5dwAAaGVsbA==
--00148531b9207834d604753651b1
Content-Type: application/cap; name="ok.cap"
Content-Disposition: attachment; filename="ok.cap"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g0fouwef1

1MOyoQIABAAAAAAAAAAAAEQAAAABAAAAPFPKSvCcCQA6AAAAQgAAAFJUAAAwAlJUAABAAQgARQAA
NFhsQABABukAwKgUBMCoZAKRox9DsSAfKwAAAACAAhbQ3b0AAAIEBbQ8U8pKAMQJADoAAABCAAAA
UlQAAEABUlQAADACCABFAAA0AABAAD8GQm3AqGQCwKgUBB9DkaOcBlp2sSAfLIASFtDnLwAAAgQF
tDxTykoAxAkANgAAADYAAABSVAAAMAJSVAAAQAEIAEUAAChYbUAAQAbpC8CoFATAqGQCkaMfQ7Eg
HyycBlp3UBALaDNkAAA/U8pKYMwFADoAAAA7AAAAUlQAADACUlQAAEABCABFAAAtWG5AAEAG6QXA
qBQEwKhkApGjH0OxIB8snAZad1AYC2hBfQAAdGVzdD9TykpgzAUAOgAAADwAAABSVAAAQAFSVAAA
MAIIAEUAACiJrkAAPwa4ysCoZALAqBQEH0ORo5wGWnexIB8xUBALaDNfAAAAAAAAP1PKSmDMBQA6
AAAAPAAAAFJUAABAAVJUAAAwAggARQAALomvQAA/BrjDwKhkAsCoFAQfQ5GjnAZad7EgHzFQGAto
73QAAGhlbGw/U8pKYMwFADYAAAA2AAAAUlQAADACUlQAAEABCABFAAAoWG9AAEAG6QnAqBQEwKhk
ApGjH0OxIB8xnAZafVAQC2gzWQAAP1PKSmDMBQA6AAAAPAAAAFJUAABAAVJUAAAwAggARQAAKImw
QAA/BrjIwKhkAsCoFAQfQ5GjnAZafbEgHzFQEQtoM1gAAAAAAAA/U8pKcPMFADYAAAA2AAAAUlQA
ADACUlQAAEABCABFAAAoWHBAAEAG6QjAqBQEwKhkApGjH0OxIB8xnAZaflARC2gzVwAAP1PKSnDz
BQA6AAAAPAAAAFJUAABAAVJUAAAwAggARQAAKImxQAA/BrjHwKhkAsCoFAQfQ5GjnAZafrEgHzJQ
EAtoM1cAAAAAAAA=
--00148531b9207834d604753651b1--
