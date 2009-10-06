Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20091006094908.GA6646@lunn.ch>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052201.30645.lindner_marek@yahoo.de>
	<d9bba8670910051354i1039f6f7x76c2467032f68db2@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
	<20091006094908.GA6646@lunn.ch>
Date: Tue, 6 Oct 2009 12:27:22 +0200
Message-ID: <d9bba8670910060327h1045108aj5503b3bf5e9a844b@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00148531b9200b4924047541adff
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

--00148531b9200b4924047541adff
Content-Type: text/plain; charset=ISO-8859-1

Dear Andrew,

2009/10/6 Andrew Lunn <andrew@lunn.ch>

> On Tue, Oct 06, 2009 at 11:26:01AM +0200, a wrote:
> > It is correct. I'm using openwrt and, at the moment, without -M option.
> > 1500byte packets work, with fragmentation.
> > However, my TCP packets are small (about 60bytes). I have verified
> TCPDump
> > file and packets arrive. It seems that the Linux IP stack does not
> forward
> > them to the application.
>
> Going back to your first email:
>
> - B1 - bat0: 192.168.10.1/24 - default gateway: 192.168.10.2
> - GW: bat0: 192.168.10.2/24,   eth1: 192.168.20.2/24
> - EX: eth0: 192.168.20.3/24 - default gateway: 192.168.20.3
>
> You default GW on EX does not make sense. You cannot use yourself as a
> default gateway. It needs to be a remote device. In this case, EXs
> default gateway should point to 192.168.20.2.
>
You are right. The gateway is 192.168.20.2


>
> However, you say ping works, so that does not explain your problem.
>
> Check your firewall rules.
>
> iptable -L
>
Checked; the ouput is the some for the three nodes:

 # iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

>
> maybe one of the rules is causing the kernel to drop the packets.
>


>      Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--00148531b9200b4924047541adff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Andrew,<br><br><div class=3D"gmail_quote">2009/10/6 Andrew Lunn <span =
dir=3D"ltr">&lt;<a href=3D"mailto:andrew@lunn.ch" target=3D"_blank">andrew@=
lunn.ch</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">

<div>On Tue, Oct 06, 2009 at 11:26:01AM +0200, a wrote:<br>
&gt; It is correct. I&#39;m using openwrt and, at the moment, without -M op=
tion.<br>
&gt; 1500byte packets work, with fragmentation.<br>
&gt; However, my TCP packets are small (about 60bytes). I have verified TCP=
Dump<br>
&gt; file and packets arrive. It seems that the Linux IP stack does not for=
ward<br>
&gt; them to the application.<br>
<br>
</div>Going back to your first email:<br>
<div><br>
- B1 - bat0: <a href=3D"http://192.168.10.1/24" target=3D"_blank">192.168.1=
0.1/24</a> - default gateway: 192.168.10.2<br>
- GW: bat0: <a href=3D"http://192.168.10.2/24" target=3D"_blank">192.168.10=
.2/24</a>, =A0 eth1: <a href=3D"http://192.168.20.2/24" target=3D"_blank">1=
92.168.20.2/24</a><br>
- EX: eth0: <a href=3D"http://192.168.20.3/24" target=3D"_blank">192.168.20=
.3/24</a> - default gateway: 192.168.20.3<br>
<br>
</div>You default GW on EX does not make sense. You cannot use yourself as =
a<br>
default gateway. It needs to be a remote device. In this case, EXs<br>
default gateway should point to 192.168.20.2.<br></blockquote><div>You are =
right. The gateway is 192.168.20.2<br>=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">


<br>
However, you say ping works, so that does not explain your problem.<br>
<br>
Check your firewall rules.<br>
<br>
iptable -L<br></blockquote><div>Checked; the ouput is the some for the thre=
e nodes:<br><br>=A0# iptables -L<br>Chain INPUT (policy ACCEPT)<br>target=
=A0=A0=A0=A0 prot opt source=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dest=
ination=A0=A0=A0=A0=A0=A0=A0 =A0<br><br>Chain FORWARD (policy ACCEPT)<br>
target=A0=A0=A0=A0 prot opt source=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 destination=A0=A0=A0=A0=A0=A0=A0 =A0<br><br>Chain OUTPUT (policy ACCEPT=
)<br>target=A0=A0=A0=A0 prot opt source=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 destination=A0=A0=A0=A0=A0=A0=A0=A0 <br></div><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
maybe one of the rules is causing the kernel to drop the packets.<br></bloc=
kquote><div><br></div><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">

<font color=3D"#888888"><br>
 =A0 =A0 =A0Andrew<br>
</font><div><div></div><div>_______________________________________________=
<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net" target=3D"_blank">B.A.T.=
M.A.N@lists.open-mesh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br>

--00148531b9200b4924047541adff--
