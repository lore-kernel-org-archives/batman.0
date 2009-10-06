Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20091006105436.GB6646@lunn.ch>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
	<200910061143.08021.sven.eckelmann@gmx.de>
	<d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
	<20091006105436.GB6646@lunn.ch>
Date: Tue, 6 Oct 2009 13:11:00 +0200
Message-ID: <d9bba8670910060411h3e47b86bt117e4306514fa926@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00148531b9200c6c5b0475424943
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

--00148531b9200c6c5b0475424943
Content-Type: text/plain; charset=ISO-8859-1

Dear Andrew,

I have sent yesterday night the IP configuration that I am using for the
test; I send it again

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


On Tue, Oct 6, 2009 at 12:54 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Oct 06, 2009 at 12:33:55PM +0200, a wrote:
> > Dear Sven, Marek
> >
> > you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s 0
> -w
> > gw.cap);
> > the output of batctl td -p 4 eth1 is:
> >
> > 10:29:15.510000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50,
> IP
> > 192.168.100.2.9001 > 192.168.20.4.45417: TCP, flags [...PA.], length 6
>
> 192.168.100.2->192.168.20.4
>
> > 10:29:18.000000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50,
> IP
> > 192.168.20.4.38246 > 192.168.100.2.9002: TCP, flags [.S....], length 12
>
> 192.168.20.4->192.168.100.2
>
> > 10:29:18.010000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50,
> IP
> > 192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [.S..A.], length 12
>
> 192.168.100.2-> 192.168.20.4
>
> However you said:
>
> > IP addresses:
> > - B1 - bat0: 192.168.10.1/24 - default gateway: 192.168.10.2
> > - GW: bat0: 192.168.10.2/24, eth1: 192.168.20.2/24
> > - EX: eth0: 192.168.20.3/24 - default gateway: 192.168.20.3
>
> i.e, none of these IP addresses match!
>
> Maybe you should give us all the networking details.
>
>      Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--00148531b9200c6c5b0475424943
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Andrew,<br><br>I have sent yesterday night the IP configuration that I=
 am using for the test; I send it again<br><br>The three nodes are connecte=
d in this way:<br>B1 --- batman --- GW1 ------- EX1<br>eth1 on B1 and GW1 i=
s managed by batman. eth2 on gw1 not.<br>
The IP configuration is:<br>
<br>B1:<br># ip a<br>eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_<div id=3D":i1"=
 class=3D"ii gt">UP&gt; mtu 1500 qdisc pfifo_fast state UNKNOWN qlen 1000<b=
r>=A0=A0=A0 link/ether 52:54:00:00:20:01 brd ff:ff:ff:ff:ff:ff<br>bat0: &lt=
;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1476 qdisc pfifo_fast state UNKNOW=
N qlen 1000<br>

=A0=A0=A0 link/ether 00:ff:ad:e2:6f:dd brd ff:ff:ff:ff:ff:ff<br>=A0=A0=A0 i=
net <a href=3D"http://192.168.100.2/24" target=3D"_blank">192.168.100.2/24<=
/a> brd 192.168.100.255 scope global bat0<br># ip r<br><a href=3D"http://19=
2.168.100.0/24" target=3D"_blank">192.168.100.0/24</a> dev bat0=A0 proto ke=
rnel=A0 scope link=A0 src 192.168.100.2 <br>

default via 192.168.100.3 dev bat0 <br><br>GW1;<br># ip a<br>eth1: &lt;BROA=
DCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast state UNKNOWN qle=
n 1000<br>=A0=A0=A0 link/ether 52:54:00:00:30:01 brd ff:ff:ff:ff:ff:ff<br>e=
th2: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast stat=
e UNKNOWN qlen 1000<br>

=A0=A0=A0 link/ether 52:54:00:00:30:02 brd ff:ff:ff:ff:ff:ff<br>=A0=A0=A0 i=
net <a href=3D"http://192.168.20.3/24" target=3D"_blank">192.168.20.3/24</a=
> brd 192.168.20.255 scope global eth2<br>bat0: &lt;BROADCAST,MULTICAST,UP,=
LOWER_UP&gt; mtu 1476 qdisc pfifo_fast state UNKNOWN qlen 1000<br>

=A0=A0=A0 link/ether 00:ff:15:c2:d0:73 brd ff:ff:ff:ff:ff:ff<br>=A0=A0=A0 i=
net <a href=3D"http://192.168.100.3/24" target=3D"_blank">192.168.100.3/24<=
/a> brd 192.168.100.255 scope global bat0<br># ip r<br><a href=3D"http://19=
2.168.100.0/24" target=3D"_blank">192.168.100.0/24</a> dev bat0=A0 proto ke=
rnel=A0 scope link=A0 src 192.168.100.3 <br>

<a href=3D"http://192.168.20.0/24" target=3D"_blank">192.168.20.0/24</a> de=
v eth2=A0 proto kernel=A0 scope link=A0 src 192.168.20.3 <br><br>EX1:<br># =
ip a<br> bat0: &lt;BROADCAST,MULTICAST&gt; mtu 1500 qdisc noop state DOWN q=
len 1000<br>
=A0=A0=A0 link/ether 00:ff:a1:ff:bb:32 brd ff:ff:ff:ff:ff:ff<br>
eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast sta=
te UNKNOWN qlen 1000<br>=A0=A0=A0 link/ether 52:54:00:00:40:01 brd ff:ff:ff=
:ff:ff:ff<br>=A0=A0=A0 inet <a href=3D"http://192.168.20.4/24" target=3D"_b=
lank">192.168.20.4/24</a> brd 192.168.20.255 scope global eth1<br>

# ip r<br><a href=3D"http://192.168.20.0/24" target=3D"_blank">192.168.20.0=
/24</a> dev eth1=A0 proto kernel=A0 scope link=A0 src 192.168.20.4 <br>defa=
ult via 192.168.20.3 dev eth1 </div><br><br><div class=3D"gmail_quote">On T=
ue, Oct 6, 2009 at 12:54 PM, Andrew Lunn <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:andrew@lunn.ch">andrew@lunn.ch</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Tue, Oct 06, 2009 at 12:33:55PM +0200, a wrote:<br>
&gt; Dear Sven, Marek<br>
&gt;<br>
&gt; you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s=
 0 -w<br>
&gt; gw.cap);<br>
&gt; the output of batctl td -p 4 eth1 is:<br>
&gt;<br>
&gt; 10:29:15.510000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, t=
tl 50, IP<br>
&gt; 192.168.100.2.9001 &gt; 192.168.20.4.45417: TCP, flags [...PA.], lengt=
h 6<br>
<br>
</div>192.168.100.2-&gt;192.168.20.4<br>
<div class=3D"im"><br>
&gt; 10:29:18.000000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST, t=
tl 50, IP<br>
&gt; 192.168.20.4.38246 &gt; 192.168.100.2.9002: TCP, flags [.S....], lengt=
h 12<br>
<br>
</div>192.168.20.4-&gt;192.168.100.2<br>
<div class=3D"im"><br>
&gt; 10:29:18.010000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, t=
tl 50, IP<br>
&gt; 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [.S..A.], lengt=
h 12<br>
<br>
</div>192.168.100.2-&gt; 192.168.20.4<br>
<div class=3D"im"><br>
However you said:<br>
<br>
&gt; IP addresses:<br>
&gt; - B1 - bat0: <a href=3D"http://192.168.10.1/24" target=3D"_blank">192.=
168.10.1/24</a> - default gateway: 192.168.10.2<br>
&gt; - GW: bat0: <a href=3D"http://192.168.10.2/24" target=3D"_blank">192.1=
68.10.2/24</a>, eth1: <a href=3D"http://192.168.20.2/24" target=3D"_blank">=
192.168.20.2/24</a><br>
&gt; - EX: eth0: <a href=3D"http://192.168.20.3/24" target=3D"_blank">192.1=
68.20.3/24</a> - default gateway: 192.168.20.3<br>
<br>
</div>i.e, none of these IP addresses match!<br>
<br>
Maybe you should give us all the networking details.<br>
<div><div></div><div class=3D"h5"><br>
 =A0 =A0 =A0Andrew<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br>

--00148531b9200c6c5b0475424943--
