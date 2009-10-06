Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910061143.08021.sven.eckelmann@gmx.de>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
	<200910061143.08021.sven.eckelmann@gmx.de>
Date: Tue, 6 Oct 2009 12:49:01 +0200
Message-ID: <d9bba8670910060349j63fe6515y65bff306bd7e0587@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00c09ffb55446ba82b047541facd
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

--00c09ffb55446ba82b047541facd
Content-Type: text/plain; charset=ISO-8859-1

I also tested ping with -M option, from B1 to GW1:
ping -M do -s 1448 192.168.20.4

It works up to 1448 bytes, then starting from 1549 I receive the error
"From 192.168.100.2 icmp_seq=1 Frag needed and DF set (mtu = 1476)"

And my bat0 configuration is:

bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1476 qdisc pfifo_fast state
UNKNOWN qlen 1000


andrea

On Tue, Oct 6, 2009 at 11:43 AM, Sven Eckelmann <sven.eckelmann@gmx.de>wrote:

> a wrote:
> > It is correct. I'm using openwrt and, at the moment, without -M option.
> > 1500byte packets work, with fragmentation.
> > However, my TCP packets are small (about 60bytes). I have verified
> TCPDump
> > file and packets arrive. It seems that the Linux IP stack does not
> forward
> > them to the application.
> > Moreover, if I disable batman on B1-GW1 link, it works
> So it would be a good idea to do what Marek said. Give him a dump with
> `batctl
> td` on the gateway and if I could add something: complete tcpdump of both
> ends
> so we can see what packets receive on both sites.
>
> Best regards,
>         Sven
>

--00c09ffb55446ba82b047541facd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I also tested ping with -M option, from B1 to GW1:<br>ping -M do -s 1448 19=
2.168.20.4<br><br>It works up to 1448 bytes, then starting from 1549 I rece=
ive the error <br>&quot;From 192.168.100.2 icmp_seq=3D1 Frag needed and DF =
set (mtu =3D 1476)&quot;<br>
<br>And my bat0 configuration is:<br><br>bat0: &lt;BROADCAST,MULTICAST,UP,L=
OWER_UP&gt; mtu 1476 qdisc pfifo_fast state UNKNOWN qlen 1000<br><br><br>an=
drea<br><br><div class=3D"gmail_quote">On Tue, Oct 6, 2009 at 11:43 AM, Sve=
n Eckelmann <span dir=3D"ltr">&lt;<a href=3D"mailto:sven.eckelmann@gmx.de">=
sven.eckelmann@gmx.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>a wrote:<br>
&gt; It is correct. I&#39;m using openwrt and, at the moment, without -M op=
tion.<br>
&gt; 1500byte packets work, with fragmentation.<br>
&gt; However, my TCP packets are small (about 60bytes). I have verified TCP=
Dump<br>
&gt; file and packets arrive. It seems that the Linux IP stack does not for=
ward<br>
&gt; them to the application.<br>
&gt; Moreover, if I disable batman on B1-GW1 link, it works<br>
</div>So it would be a good idea to do what Marek said. Give him a dump wit=
h `batctl<br>
td` on the gateway and if I could add something: complete tcpdump of both e=
nds<br>
so we can see what packets receive on both sites.<br>
<br>
Best regards,<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0Sven<br>
</font></blockquote></div><br>

--00c09ffb55446ba82b047541facd--
