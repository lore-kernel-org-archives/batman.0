Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910052324.55426.sven.eckelmann@gmx.de>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052201.30645.lindner_marek@yahoo.de>
	<d9bba8670910051354i1039f6f7x76c2467032f68db2@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
Date: Tue, 6 Oct 2009 11:26:01 +0200
Message-ID: <d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00163600d8539812b3047540d109
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--00163600d8539812b3047540d109
Content-Type: text/plain; charset=ISO-8859-1

It is correct. I'm using openwrt and, at the moment, without -M option.
1500byte packets work, with fragmentation.
However, my TCP packets are small (about 60bytes). I have verified TCPDump
file and packets arrive. It seems that the Linux IP stack does not forward
them to the application.
Moreover, if I disable batman on B1-GW1 link, it works

andrea

2009/10/5 Sven Eckelmann <sven.eckelmann@gmx.de>

> a wrote:
> > The ping with 1500 byte packets works.
> How can you send 1500 bytes packets with an mtu of 1476?
> Do the test with `ping -M do -s 1472 IP` (this should create an 1500 bytes
> packet and disables fragmentation).
>
> > The three nodes are connected in this way:
> > B1 --- batman --- GW1 ------- EX1
> > eth1 on B1 and GW1 is managed by batman. eth2 on gw1 not.
> > The IP configuration is:
> >
> > B1:
> > # ip a
> > eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
> > UNKNOWN qlen 1000
> >     link/ether 52:54:00:00:20:01 brd ff:ff:ff:ff:ff:ff
> > bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1476 qdisc pfifo_fast state
> > UNKNOWN qlen 1000
> >     link/ether 00:ff:ad:e2:6f:dd brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.100.2/24 brd 192.168.100.255 scope global bat0
> > # ip r
> > 192.168.100.0/24 dev bat0  proto kernel  scope link  src 192.168.100.2
> > default via 192.168.100.3 dev bat0
>
> Best regards,
>         Sven
>

--00163600d8539812b3047540d109
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It is correct. I&#39;m using openwrt and, at the moment, without -M option.=
 1500byte packets work, with fragmentation. <br>However, my TCP packets are=
 small (about 60bytes). I have verified TCPDump file and packets arrive. It=
 seems that the Linux IP stack does not forward them to the application.<br=
>
Moreover, if I disable batman on B1-GW1 link, it works<br><br>andrea<br><br=
><div class=3D"gmail_quote">2009/10/5 Sven Eckelmann <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sven.eckelmann@gmx.de" target=3D"_blank">sven.eckelmann@g=
mx.de</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>a wrote:<br>
&gt; The ping with 1500 byte packets works.<br>
</div>How can you send 1500 bytes packets with an mtu of 1476?<br>
Do the test with `ping -M do -s 1472 IP` (this should create an 1500 bytes<=
br>
packet and disables fragmentation).<br>
<div><br>
&gt; The three nodes are connected in this way:<br>
&gt; B1 --- batman --- GW1 ------- EX1<br>
&gt; eth1 on B1 and GW1 is managed by batman. eth2 on gw1 not.<br>
&gt; The IP configuration is:<br>
&gt;<br>
&gt; B1:<br>
&gt; # ip a<br>
&gt; eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fas=
t state<br>
&gt; UNKNOWN qlen 1000<br>
&gt; =A0 =A0 link/ether 52:54:00:00:20:01 brd ff:ff:ff:ff:ff:ff<br>
&gt; bat0: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1476 qdisc pfifo_fas=
t state<br>
&gt; UNKNOWN qlen 1000<br>
&gt; =A0 =A0 link/ether 00:ff:ad:e2:6f:dd brd ff:ff:ff:ff:ff:ff<br>
&gt; =A0 =A0 inet <a href=3D"http://192.168.100.2/24" target=3D"_blank">192=
.168.100.2/24</a> brd 192.168.100.255 scope global bat0<br>
&gt; # ip r<br>
&gt; <a href=3D"http://192.168.100.0/24" target=3D"_blank">192.168.100.0/24=
</a> dev bat0 =A0proto kernel =A0scope link =A0src 192.168.100.2<br>
&gt; default via 192.168.100.3 dev bat0<br>
<br>
</div>Best regards,<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0Sven<br>
</font></blockquote></div><br>

--00163600d8539812b3047540d109--
