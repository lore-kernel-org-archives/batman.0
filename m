Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910201717.12868.sven.eckelmann@gmx.de>
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com> 
	<200910201717.12868.sven.eckelmann@gmx.de>
From: Francesco <francesco.cappuccio@gmail.com>
Date: Tue, 20 Oct 2009 18:02:39 +0200
Message-ID: <45f642440910200902l14132a61o484e5a674b8e4985@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0016e64762f20ea0e604765fff4d
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
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

--0016e64762f20ea0e604765fff4d
Content-Type: text/plain; charset=ISO-8859-1

Hi Sven,


> There is nothing like batman-adv 3.2. Where did you got it from?
>

Sorry, my fault, i meant 0.3.2 release.


>
> > Only one wireless interface (wlan0) on each linux box (5 boxes by now)
> > Here are commands I fire on each node:
> >
> > $ insmod batman-adv.ko
> > $ iwconfig wlan0 mode ad-hoc essid BATMAN_NET
> > $ echo wlan0 > /proc/net/batman-adv/interfaces
> > $ ifconfig wlan0 192.168.1.xxx up
> > $ ifconfig bat0 up
>


> You must give bat0 also an ip to use IPv4(/6) over it... in most cases only
> bat0 as it is just the hardware interface the bat0 interface is using.
> If you only want to test raw ethernet data over bat0 this should work.
>

Ok now i have assigned ip addresses only to bat0 interface, i do ping nodes
with ping command.
here are some output:

$batctl o

  Originator     (#/255)           Nexthop [outgoingIF]:   Potential
nexthops ... [B.A.T.M.A.N. Adv 0.1, MainIF/MAC: wlan0/00:0b:6b:34:88:94]
00:0c:42:2c:d8:fc  (221) 00:1e:4c:02:94:95 [     wlan0]: 00:0c:42:2c:d8:fc
(170) 00:0b:6b:2f:53:09 (148) 00:0b:6b:2f:53:03 (199) 00:1e:4c:02:94:95
(221)
00:0b:6b:2f:53:03  (220) 00:0b:6b:2f:53:03 [     wlan0]: 00:0b:6b:2f:53:03
(220) 00:0b:6b:2f:53:09 (146) 00:0c:42:2c:d8:fc (157) 00:1e:4c:02:94:95
(201)
00:1e:4c:02:94:95  (234) 00:1e:4c:02:94:95 [     wlan0]: 00:1e:4c:02:94:95
(234) 00:0b:6b:2f:53:03 (191) 00:0b:6b:2f:53:09 (146) 00:0c:42:2c:d8:fc
(157)
00:0b:6b:2f:53:09  (194) 00:1e:4c:02:94:95 [     wlan0]: 00:0b:6b:2f:53:09
(157) 00:0b:6b:2f:53:03 (183) 00:0c:42:2c:d8:fc (138) 00:1e:4c:02:94:95 (19

It shows 4 of 5 nodes I have online at this very moment.

Say i fire ping from the box missing:

root@francesco-desktop:/home/francesco# ping 192.168.1.2
PING 192.168.1.2 (192.168.1.2) 56(84) bytes of data.
64 bytes from 192.168.1.2: icmp_seq=1 ttl=64 time=3.16 ms
64 bytes from 192.168.1.2: icmp_seq=2 ttl=64 time=3.55 ms
64 bytes from 192.168.1.2: icmp_seq=3 ttl=64 time=8.01 ms
^C
--- 192.168.1.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2011ms
rtt min/avg/max/mdev = 3.167/4.911/8.012/2.198 ms

Everything ok. But if I try to batctl ping a node that I can see with
$batctl o:

root@francesco-desktop:/home/francesco# batctl ping 00:0b:6b:2f:53:03
PING 00:0b:6b:2f:53:03 (00:0b:6b:2f:53:03) 19(47) bytes of data
From 00:0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)
From 00:0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)
From 00:0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)
^C--- 00:0b:6b:2f:53:03 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss
rtt min/avg/max/mdev = 0.000/0.000/0.000/0.000 ms


What am I missing? I will post dump files tomorrow when i get back in the
lab.

Thanks.


>
> > I get a new bat0 interface, iwconfig shows nodes properly part of the
> >  ad-hoc network.
> > I see correct $batctl o  output but i cannot $batctl ping $mac_address
> Can you please give the originator table and send some small dumps (tcpdump
> -
> w, batctl td) of both nodes when you try to send a batctl ping?
> What mac address did you use?
>
> Best regards,
>         Sven
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Francesco Cappuccio

--0016e64762f20ea0e604765fff4d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sven,<br><div class=3D"gmail_quote"><div>=A0</div><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">There is nothing like batman-adv 3.2. W=
here did you got it from?<br>


</blockquote><div><br>Sorry, my fault, i meant 0.3.2 release.<br>=A0</div><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><br>
&gt; Only one wireless interface (wlan0) on each linux box (5 boxes by now)=
<br>
&gt; Here are commands I fire on each node:<br>
&gt;<br>
&gt; $ insmod batman-adv.ko<br>
&gt; $ iwconfig wlan0 mode ad-hoc essid BATMAN_NET<br>
&gt; $ echo wlan0 &gt; /proc/net/batman-adv/interfaces<br>
&gt; $ ifconfig wlan0 192.168.1.xxx up<br>
&gt; $ ifconfig bat0 up<br></div></blockquote><div>=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>
</div>You must give bat0 also an ip to use IPv4(/6) over it... in most case=
s only<br>
bat0 as it is just the hardware interface the bat0 interface is using.<br>
If you only want to test raw ethernet data over bat0 this should work.<br><=
/blockquote><div><br>Ok now i have assigned ip addresses only to bat0 inter=
face, i do ping nodes with ping command. <br>here are some output:<br>


<br>$batctl o<br><br>=A0 Originator=A0=A0=A0=A0 (#/255)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 Nexthop [outgoingIF]:=A0=A0 Potential nexthops ... [B.A.T.M.A.=
N. Adv 0.1, MainIF/MAC: wlan0/00:0b:6b:34:88:94] <br>00:0c:42:2c:d8:fc=A0 (=
221) 00:1e:4c:02:94:95 [=A0=A0=A0=A0 wlan0]: 00:0c:42:2c:d8:fc (170) 00:0b:=
6b:2f:53:09 (148) 00:0b:6b:2f:53:03 (199) 00:1e:4c:02:94:95 (221)<br>


00:0b:6b:2f:53:03=A0 (220) 00:0b:6b:2f:53:03 [=A0=A0=A0=A0 wlan0]: 00:0b:6b=
:2f:53:03 (220) 00:0b:6b:2f:53:09 (146) 00:0c:42:2c:d8:fc (157) 00:1e:4c:02=
:94:95 (201)<br>00:1e:4c:02:94:95=A0 (234) 00:1e:4c:02:94:95 [=A0=A0=A0=A0 =
wlan0]: 00:1e:4c:02:94:95 (234) 00:0b:6b:2f:53:03 (191) 00:0b:6b:2f:53:09 (=
146) 00:0c:42:2c:d8:fc (157)<br>


00:0b:6b:2f:53:09=A0 (194) 00:1e:4c:02:94:95 [=A0=A0=A0=A0 wlan0]: 00:0b:6b=
:2f:53:09 (157) 00:0b:6b:2f:53:03 (183) 00:0c:42:2c:d8:fc (138) 00:1e:4c:02=
:94:95 (19<br><br>It shows 4 of 5 nodes I have online at this very moment.<=
br><br>


Say i fire ping from the box missing:<br><br>root@francesco-desktop:/home/f=
rancesco# ping 192.168.1.2<br>PING 192.168.1.2 (192.168.1.2) 56(84) bytes o=
f data.<br>64 bytes from <a href=3D"http://192.168.1.2" target=3D"_blank">1=
92.168.1.2</a>: icmp_seq=3D1 ttl=3D64 time=3D3.16 ms<br>


64 bytes from <a href=3D"http://192.168.1.2" target=3D"_blank">192.168.1.2<=
/a>: icmp_seq=3D2 ttl=3D64 time=3D3.55 ms<br>64 bytes from <a href=3D"http:=
//192.168.1.2" target=3D"_blank">192.168.1.2</a>: icmp_seq=3D3 ttl=3D64 tim=
e=3D8.01 ms<br>

^C<br>--- 192.168.1.2 ping statistics ---<br>
3 packets transmitted, 3 received, 0% packet loss, time 2011ms<br>rtt min/a=
vg/max/mdev =3D 3.167/4.911/8.012/2.198 ms<br><br>Everything ok. But if I t=
ry to batctl ping a node that I can see with=A0 $batctl o:<br><br>root@fran=
cesco-desktop:/home/francesco# batctl ping 00:0b:6b:2f:53:03<br>

PING 00:0b:6b:2f:53:03 (00:0b:6b:2f:53:03) 19(47) bytes of data<br>From 00:=
0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)<br>From 00:0b:=
6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)<br>From 00:0b:6b:=
2f:53:03: Destination Host Unreachable (icmp_seq 6170)<br>

^C--- 00:0b:6b:2f:53:03 ping statistics ---<br>3 packets transmitted, 0 rec=
eived, 100% packet loss<br>rtt min/avg/max/mdev =3D 0.000/0.000/0.000/0.000=
 ms<br><br><br>What am I missing? I will post dump files tomorrow when i ge=
t back in the lab.<br>

<br>Thanks.<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">

<div><br>
&gt; I get a new bat0 interface, iwconfig shows nodes properly part of the<=
br>
&gt; =A0ad-hoc network.<br>
&gt; I see correct $batctl o =A0output but i cannot $batctl ping $mac_addre=
ss<br>
</div>Can you please give the originator table and send some small dumps (t=
cpdump -<br>
w, batctl td) of both nodes when you try to send a batctl ping?<br>
What mac address did you use?<br>
<br>
Best regards,<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0Sven<br>
</font><br>_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net" target=3D"_blank">B.A.T.=
M.A.N@lists.open-mesh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Francesco Cappuccio=
<br><br>

--0016e64762f20ea0e604765fff4d--
