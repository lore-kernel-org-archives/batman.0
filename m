Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910061143.08021.sven.eckelmann@gmx.de>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
	<200910061143.08021.sven.eckelmann@gmx.de>
Date: Tue, 6 Oct 2009 12:33:55 +0200
Message-ID: <d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/mixed; boundary=00c09ffb4c71737410047541c405
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

--00c09ffb4c71737410047541c405
Content-Type: multipart/alternative; boundary=00c09ffb4c71737406047541c403

--00c09ffb4c71737406047541c403
Content-Type: text/plain; charset=ISO-8859-1

Dear Sven, Marek

you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s 0 -w
gw.cap);
the output of batctl td -p 4 eth1 is:

10:29:15.510000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9001 > 192.168.20.4.45417: TCP, flags [...PA.], length 6
10:29:18.000000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.38246 > 192.168.100.2.9002: TCP, flags [.S....], length 12
10:29:18.010000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [.S..A.], length 12
10:29:18.020000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.38246 > 192.168.100.2.9002: TCP, flags [....A.], length 0
10:29:18.970000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.38246 > 192.168.100.2.9002: TCP, flags [...PA.], length 5
10:29:18.980000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [....A.], length 0
10:29:18.990000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [...PA.], length 6
10:29:18.990000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [F...A.], length 0
10:29:19.000000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
192.168.20.4.38246 > 192.168.100.2.9002: TCP, flags [....A.], length 12
10:29:21.970000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [...PA.], length 6
10:29:27.950000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [...PA.], length 6

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

--00c09ffb4c71737406047541c403
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Sven, Marek<br><br>you can find as attachment the dump on eth2 of GW (=
tcpdump -ni eth2 -s 0 -w gw.cap); <br>the output of batctl td -p 4 eth1 is:=
<br><br>10:29:15.510000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST=
, ttl 50, IP 192.168.100.2.9001 &gt; 192.168.20.4.45417: TCP, flags [...PA.=
], length 6<br>
10:29:18.000000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST, ttl 50=
, IP 192.168.20.4.38246 &gt; 192.168.100.2.9002: TCP, flags [.S....], lengt=
h 12<br>10:29:18.010000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST=
, ttl 50, IP 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [.S..A.=
], length 12<br>
10:29:18.020000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST, ttl 50=
, IP 192.168.20.4.38246 &gt; 192.168.100.2.9002: TCP, flags [....A.], lengt=
h 0<br>10:29:18.970000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST,=
 ttl 50, IP 192.168.20.4.38246 &gt; 192.168.100.2.9002: TCP, flags [...PA.]=
, length 5<br>
10:29:18.980000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, ttl 50=
, IP 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [....A.], lengt=
h 0<br>10:29:18.990000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST,=
 ttl 50, IP 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [...PA.]=
, length 6<br>
10:29:18.990000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, ttl 50=
, IP 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [F...A.], lengt=
h 0<br>10:29:19.000000 BAT 52:54:00:00:30:01 &gt; 52:54:00:00:20:01: UCAST,=
 ttl 50, IP 192.168.20.4.38246 &gt; 192.168.100.2.9002: TCP, flags [....A.]=
, length 12<br>
10:29:21.970000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST, ttl 50=
, IP 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [...PA.], lengt=
h 6<br>10:29:27.950000 BAT 52:54:00:00:20:01 &gt; 52:54:00:00:30:01: UCAST,=
 ttl 50, IP 192.168.100.2.9002 &gt; 192.168.20.4.38246: TCP, flags [...PA.]=
, length 6<br>
<br>andrea<br><br><div class=3D"gmail_quote">On Tue, Oct 6, 2009 at 11:43 A=
M, Sven Eckelmann <span dir=3D"ltr">&lt;<a href=3D"mailto:sven.eckelmann@gm=
x.de">sven.eckelmann@gmx.de</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">a wrote:<br>
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

--00c09ffb4c71737406047541c403--

--00c09ffb4c71737410047541c405
Content-Type: application/cap; name="gw.cap"
Content-Disposition: attachment; filename="gw.cap"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g0gijgeg1

1MOyoQIABAAAAAAAAAAAAP//AAABAAAA+xvLSjDIBwA8AAAAPAAAAFJUAABAAVJUAAAwAggARQAA
Lp1rQAA/BqUHwKhkAsCoFAQjKbFpnU6VsJ5zYlFQGAs4+XcAAGhlbGxvCv4by0oAAAAAQgAAAEIA
AABSVAAAMAJSVAAAQAEIAEUAADT/5UAAQAZBh8CoFATAqGQClWYjKrW27KQAAAAAgAIW0AQEAAAC
BAW0AQEEAgEDAwH+G8tKIE4AAEIAAABCAAAAUlQAAEABUlQAADACCABFAAA0AABAAD8GQm3AqGQC
wKgUBCMqlWa1KbwFtbbspYASFnCTOwAAAgQFnAEBBAIBAwMB/hvLSiBOAAA8AAAAPAAAAFJUAAAw
AlJUAABAAQgARQAAKP/mQABABkGSwKgUBMCoZAKVZiMqtbbspbUpvAZQEAto3vcAAAAAAAAAAP4b
y0oQzQ4APAAAADwAAABSVAAAMAJSVAAAQAEIAEUAAC3/50AAQAZBjMCoFATAqGQClWYjKrW27KW1
KbwGUBgLaO0QAAB0ZXN0CgD+G8tKIPQOADYAAAA2AAAAUlQAAEABUlQAADACCABFAAAoru5AAD8G
k4rAqGQCwKgUBCMqlWa1KbwGtbbsqlAQCzjfIgAA/hvLSjAbDwA8AAAAPAAAAFJUAABAAVJUAAAw
AggARQAALq7vQAA/BpODwKhkAsCoFAQjKpVmtSm8BrW27KpQGAs4+XcAAGhlbGxvCv4by0owGw8A
NgAAADYAAABSVAAAQAFSVAAAMAIIAEUAACiu8EAAPwaTiMCoZALAqBQEIyqVZrUpvAy1tuyqUBEL
ON8bAAD/G8tKAAAAAEIAAABCAAAAUlQAADACUlQAAEABCABFAAA0/+hAAEAGQYTAqBQEwKhkApVm
Iyq1tuyqtSm8BoAQC2jGbQAAAQEFCrUpvAy1KbwNARzLSiD0DgA8AAAAPAAAAFJUAABAAVJUAAAw
AggARQAALq7xQAA/BpOBwKhkAsCoFAQjKpVmtSm8BrW27KpQGAs4+XcAAGhlbGxvCgccy0oQzQ4A
PAAAADwAAABSVAAAQAFSVAAAMAIIAEUAAC6u8kAAPwaTgMCoZALAqBQEIyqVZrUpvAa1tuyqUBgL
OPl3AABoZWxsbwo=
--00c09ffb4c71737410047541c405--
