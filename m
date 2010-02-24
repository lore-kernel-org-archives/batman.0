Return-Path: <skaapgif@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4B84E3B1.9010702@muc.ccc.de>
References: <84e340bd1002232218k6238a13flf790f9e72f2fba9d@mail.gmail.com>
	<4B84E3B1.9010702@muc.ccc.de>
Date: Wed, 24 Feb 2010 11:46:08 +0200
Message-ID: <84e340bd1002240146q265990fcr575bbffd551940e3@mail.gmail.com>
From: Rudolf Meijering <skaapgif@gmail.com>
Content-Type: multipart/alternative; boundary=001485f8612e253af20480558909
Subject: Re: [B.A.T.M.A.N.] Batman-adv r1575 on openwrt 8.09.2 no originators
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--001485f8612e253af20480558909
Content-Type: text/plain; charset=ISO-8859-1

Hi,

The problem lay with me not setting the cellid, and incorrectly setting the
channel (put the option line at the wrong place). Thanks for the help, esp
marek for all the IRC help.

On Wed, Feb 24, 2010 at 10:30 AM, <x@muc.ccc.de> wrote:

> hi!
>
> > I have Batman-adv r1575 on openwrt 8.09.2, but i can't find any
> originators.
>
> hm, would be nice to know on what architecture... :)
>
> > On a clean install of openwrt with batman:
> > Enable wifi
> > Set channel to 1
> > set mode to ahdemo
> > restart
> >
> > Is there something I missed?
>
> you should set the mtu to batman-interface-mtu + 24 (so usually 1524) - but
> i doubt that originator messages are dumped because of this.
>
> it reminds me of initial tries with mixed batman 0.1 and batman 0.2 nodes.
> the protocol obviously isn't compatible between those.
>
> otherwise it would be interesting to know whether your wifi interface and
> the batman interface are UP, and what /proc/net/batman-adv/interfaces says
> (wifi interface should be listed as active).
>
> a tcpdump on your wifi interface should show whether any/originator
> messages are sent or received via the radio interface.
>
> regards,
>
>        Chris
>



-- 
Rudolf Meijering

--001485f8612e253af20480558909
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>The problem lay with me not setting the cellid, and incorrectly =
setting the channel (put the option line at the wrong place). Thanks for th=
e help, esp marek for all the IRC help.<br><br><div class=3D"gmail_quote">
On Wed, Feb 24, 2010 at 10:30 AM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:=
x@muc.ccc.de">x@muc.ccc.de</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
hi!<br>
<div class=3D"im"><br>
&gt; I have Batman-adv r1575 on openwrt 8.09.2, but i can&#39;t find any or=
iginators.<br>
<br>
</div>hm, would be nice to know on what architecture... :)<br>
<div class=3D"im"><br>
&gt; On a clean install of openwrt with batman:<br>
&gt; Enable wifi<br>
&gt; Set channel to 1<br>
&gt; set mode to ahdemo<br>
&gt; restart<br>
&gt;<br>
&gt; Is there something I missed?<br>
<br>
</div>you should set the mtu to batman-interface-mtu + 24 (so usually 1524)=
 - but i doubt that originator messages are dumped because of this.<br>
<br>
it reminds me of initial tries with mixed batman 0.1 and batman 0.2 nodes. =
the protocol obviously isn&#39;t compatible between those.<br>
<br>
otherwise it would be interesting to know whether your wifi interface and t=
he batman interface are UP, and what /proc/net/batman-adv/interfaces says (=
wifi interface should be listed as active).<br>
<br>
a tcpdump on your wifi interface should show whether any/originator message=
s are sent or received via the radio interface.<br>
<br>
regards,<br>
<br>
 =A0 =A0 =A0 =A0Chris<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Rudolf Meijering<br><br=
>

--001485f8612e253af20480558909--
