Return-Path: <outbackdingo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906200323.44115.sven.eckelmann@gmx.de>
	<5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
Date: Mon, 22 Jun 2009 16:31:57 -0400
Message-ID: <5635aa0d0906221331nad876c8x6fec3fde12332c41@mail.gmail.com>
From: Outback Dingo <outbackdingo@gmail.com>
Content-Type: multipart/alternative; boundary=0015175ccf70fb09d0046cf5c388
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
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

--0015175ccf70fb09d0046cf5c388
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

when you say dont go thru, what exactly are they not passing through, which
interface or meaning thru the DSL / internet link, we need to try to detmine
also the bottleneck of the issue, so what interface is data not passing
through, and icmp tests wount decipher much in regards to MTU.... tcpdump
however might tell us where the traffic is getting stopped at

On 6/22/09, Jacob Marble <jacobmarble@gmail.com> wrote:
>
> On Fri, Jun 19, 2009 at 7:23 PM, Sven Eckelmann<sven.eckelmann@gmx.de>
> wrote:
> > On Saturday 20 June 2009 00:17:23 Jacob Marble wrote:
> >> Two Linux boxes, each plugged in via Ethernet to a BATMAN node (two
> >> nodes).  The nodes talk batman-advanced to each other via WiFi.  The
> >> Linux boxes can ping each other all day long.  Both Linux boxes have
> >> Apache running.  Downloading a file via HTTP works only if the file is
> >> smaller than or equal to exactly 1,145 bytes.  TFTP file transfers are
> >> halting, but they get through (4 megabytes took a couple of minutes).
> >>
> >> This happens with both r1176 and r1298 on OpenWrt.
> >
> > Sry, haven't followed your other mails so I don't know your whole setup.
> It
> > looks like a mtu problem for me. Please try to set the mtu a lot lower on
> your
> > eth devices. You can do a ping test with `ping -s TESTSIZEINBYTE -M dont
> > IPTOSENDIPPACKET` - dont forget to add the 28 extra bytes needed for the
> whole
> > headers inside the ethernet frame. So `ping -s 1472 -M do 192.168.1.1`
> would
> > send a 1500 bytes package.
> > You can also set the mtu on your wifi devices higher (and bat0 devices).
> So
> > for example wifi device to 1524 and bat0 to 1500 (like the eth devices).
> > Also check if you have bridge mtu patch from Simon[1] (included in linux
> > 2.6.27) when you are bridging some of the devices. Also check that icmp
> > "Destination Unreachable" - "Fragmentation required, and DF flag set"
> isn't
> > filtered anywhere.
> >
>
>
> The nodes running batman-advanced are OpenWrt 8.09.1, which uses
> kernel 2.6.26.8.  The patch is *not* in there, so I have re-flashed
> (again) with OpenWrt SVN, which uses... 2.6.28.10.  Um, if the patch
> isn't in OpenWrt stable releases, then maybe something should be said
> on open-mesh.net?  Also, I need to make a big fat note in my howto.
>
> The setup is two Ubiquiti NanoStation2 nodes, which have one wifi
> device and one Ethernet device each.  Atheros 231x SoC.
> ath0 = wifi0, ahdemo, channel = 1
> bat0 interfaces = ath0
> br-lan (bridge) = bat0 + eth0, IP address set on this device only
>
> The Linux workstations are attached via Ethernet, running Ubuntu.
>
> The MTU, by default, is 1500 on eth0, ath0, wifi0
> The MTU, by default, is 1476 on bat0, br-lan
>
> Ping from Linux workstation to Linux workstation works as long as the
> -s flag is 1448 or less.  1448 = 1476 - 28
> The -M do doesn't seem to change anything.
>
> HTTP transfers still don't go through when they are larger than ~1400
> bytes.  I'll go play with the MTUs now.
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--0015175ccf70fb09d0046cf5c388
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

when you say dont go thru, what exactly are they not passing through, which=
 interface or meaning thru the DSL / internet link, we need to try to detmi=
ne also the bottleneck of the issue, so what interface is data not passing =
through, and icmp tests wount decipher much in regards to MTU.... tcpdump h=
owever might tell us where the traffic is getting stopped at <br>
<br><div><span class=3D"gmail_quote">On 6/22/09, <b class=3D"gmail_senderna=
me">Jacob Marble</b> &lt;<a href=3D"mailto:jacobmarble@gmail.com">jacobmarb=
le@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
On Fri, Jun 19, 2009 at 7:23 PM, Sven Eckelmann&lt;<a href=3D"mailto:sven.e=
ckelmann@gmx.de">sven.eckelmann@gmx.de</a>&gt; wrote:<br> &gt; On Saturday =
20 June 2009 00:17:23 Jacob Marble wrote:<br> &gt;&gt; Two Linux boxes, eac=
h plugged in via Ethernet to a BATMAN node (two<br>
 &gt;&gt; nodes).=A0=A0The nodes talk batman-advanced to each other via WiF=
i.=A0=A0The<br> &gt;&gt; Linux boxes can ping each other all day long.=A0=
=A0Both Linux boxes have<br> &gt;&gt; Apache running.=A0=A0Downloading a fi=
le via HTTP works only if the file is<br>
 &gt;&gt; smaller than or equal to exactly 1,145 bytes.=A0=A0TFTP file tran=
sfers are<br> &gt;&gt; halting, but they get through (4 megabytes took a co=
uple of minutes).<br> &gt;&gt;<br> &gt;&gt; This happens with both r1176 an=
d r1298 on OpenWrt.<br>
 &gt;<br> &gt; Sry, haven&#39;t followed your other mails so I don&#39;t kn=
ow your whole setup. It<br> &gt; looks like a mtu problem for me. Please tr=
y to set the mtu a lot lower on your<br> &gt; eth devices. You can do a pin=
g test with `ping -s TESTSIZEINBYTE -M dont<br>
 &gt; IPTOSENDIPPACKET` - dont forget to add the 28 extra bytes needed for =
the whole<br> &gt; headers inside the ethernet frame. So `ping -s 1472 -M d=
o 192.168.1.1` would<br> &gt; send a 1500 bytes package.<br> &gt; You can a=
lso set the mtu on your wifi devices higher (and bat0 devices). So<br>
 &gt; for example wifi device to 1524 and bat0 to 1500 (like the eth device=
s).<br> &gt; Also check if you have bridge mtu patch from Simon[1] (include=
d in linux<br> &gt; 2.6.27) when you are bridging some of the devices. Also=
 check that icmp<br>
 &gt; &quot;Destination Unreachable&quot; - &quot;Fragmentation required, a=
nd DF flag set&quot; isn&#39;t<br> &gt; filtered anywhere.<br> &gt;<br> <br=
> <br>The nodes running batman-advanced are OpenWrt 8.09.1, which uses<br>
 kernel 2.6.26.8.=A0=A0The patch is *not* in there, so I have re-flashed<br=
> (again) with OpenWrt SVN, which uses... 2.6.28.10.=A0=A0Um, if the patch<=
br> isn&#39;t in OpenWrt stable releases, then maybe something should be sa=
id<br>
 on <a href=3D"http://open-mesh.net">open-mesh.net</a>?=A0=A0Also, I need t=
o make a big fat note in my howto.<br> <br> The setup is two Ubiquiti NanoS=
tation2 nodes, which have one wifi<br> device and one Ethernet device each.=
=A0=A0Atheros 231x SoC.<br>
 ath0 =3D wifi0, ahdemo, channel =3D 1<br> bat0 interfaces =3D ath0<br> br-=
lan (bridge) =3D bat0 + eth0, IP address set on this device only<br> <br> T=
he Linux workstations are attached via Ethernet, running Ubuntu.<br> <br> T=
he MTU, by default, is 1500 on eth0, ath0, wifi0<br>
 The MTU, by default, is 1476 on bat0, br-lan<br> <br> Ping from Linux work=
station to Linux workstation works as long as the<br> -s flag is 1448 or le=
ss.=A0=A01448 =3D 1476 - 28<br> The -M do doesn&#39;t seem to change anythi=
ng.<br>
 <br> HTTP transfers still don&#39;t go through when they are larger than ~=
1400<br> bytes.=A0=A0I&#39;ll go play with the MTUs now.<br> <br>__________=
_____________________________________<br> B.A.T.M.A.N mailing list<br> <a h=
ref=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-mesh.=
net</a><br>
 <a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://li=
sts.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br> </blockquote></div><br>

--0015175ccf70fb09d0046cf5c388--
