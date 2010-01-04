Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
In-Reply-To: <20100104205827.GB9585@lunn.ch>
References: <201001042344.02273.lindner_marek@yahoo.de>
	<591bc9931001041223m13d96837o4d4f95afa08e42e2@mail.gmail.com>
	<20100104205827.GB9585@lunn.ch>
Date: Tue, 5 Jan 2010 10:20:29 +1300
Message-ID: <591bc9931001041320m309a40dcxe7da013683f97d2@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: multipart/alternative; boundary=00504502d814705597047c5d4a97
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway support
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

--00504502d814705597047c5d4a97
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 5, 2010 at 9:58 AM, Andrew Lunn <andrew@lunn.ch> wrote:

>
> BPF for outgoing packets? Different. I've only ever seen it used for
> filtering incoming packets. ARP requests for *.*.*.1? I don't get
> that. There should only be one host in the subnet which matches
> *.*.*.1/24, so its going to reply anyway. What are you trying to
> achieve here?
>

BPF because it's already in the kernel and has a rule language.  Rules to
match "all DHCP packets, and IPv6 router solicitations" are easy to write,
and people who want to do something different/wierd don't need to rebuild
their kernels.

If it makes any more sense, substitute *.*.*.1 for "something matching the
IPs I use for gateways".  Aim: make it harder for people to configure their
PCs to respond to those ARPs and break the network.  Although for a mobile
node whose DHCP lease hasn't yet expired I can see that causing problems.
But if it's just a BPF filter then you can experiment with rules like these
fairly easily.

donald

--00504502d814705597047c5d4a97
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Jan 5, 2010 at 9:58 AM, Andrew Lunn <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:andrew@lunn.ch">andrew@lunn.ch</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1p=
x solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
</div>BPF for outgoing packets? Different. I&#39;ve only ever seen it used =
for<br>
filtering incoming packets. ARP requests for *.*.*.1? I don&#39;t get<br>
that. There should only be one host in the subnet which matches<br>
*.*.*.1/24, so its going to reply anyway. What are you trying to<br>
achieve here?<br></blockquote><div><br>BPF because it&#39;s already in the =
kernel and has a rule language.=A0 Rules to match &quot;all DHCP packets, a=
nd IPv6 router solicitations&quot; are easy to write, and people who want t=
o do something different/wierd don&#39;t need to rebuild their kernels.<br>
<br>If it makes any more sense, substitute *.*.*.1 for &quot;something matc=
hing the IPs I use for gateways&quot;.=A0 Aim: make it harder for people to=
 configure their PCs to respond to those ARPs and break the network.=A0 Alt=
hough for a mobile node whose DHCP lease hasn&#39;t yet expired I can see t=
hat causing problems.=A0 But if it&#39;s just a BPF filter then you can exp=
eriment with rules like these fairly easily.<br>
=A0</div>donald<br></div>

--00504502d814705597047c5d4a97--
