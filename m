Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201204021729.02256.lindner_marek@yahoo.de>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<201204021132.42284.lindner_marek@yahoo.de>
	<CAA_JP8WrwQ52eVZsXRh1TcVqPGOq7kZAz1UqMbhLrOEDuuQZiA@mail.gmail.com>
	<201204021729.02256.lindner_marek@yahoo.de>
Date: Mon, 2 Apr 2012 12:21:15 -0600
Message-ID: <CAA_JP8WRwY5OSfOvhV1MzUhKNAp8zDTBJLnPUXUFtM7XTbPwHA@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

> Watching the interface queue would be very interesting for other features=
 as
> well but turns out to be hard in practice. A while ago Simon and others t=
ried
> to improve the interface alternating / bonding by monitoring the fill sta=
tus
> of the queue. But the wifi stack does not report the fill status. Even if=
 it
> did we don't know what is going on in the hardware.
>

Another issue I suspect is that in AdHoc networks, the channel might
be saturated by two other nodes.  A third node may not be able to
receive the tx from one of the first two nodes and theirfor wouldn't
know how saturated the channel was.

>
> We still have the problem that some links might be idle, therefore we wil=
l
> have to generate traffic before we can evaluate these links.
>
> Sounds very similar to the problem above: Without traffic we can't be sur=
e
> about the possible throughput.
>
> Thanks for the flowers! =A0:-)
> Still, we have some work ahead of us. Throughput based routing is a hot t=
opic
> we want to work on. All ideas are welcome.
>
> Cheers,
> Marek
>

In AdHoc networks, every node that is using the same channel would
need to know every other nodes current throughput on that interface so
know how saturated the channel was, at least in it's vacinity.  The
node would basically need to track the MACs that it could see in 1 hop
and then request the throughput from those nodes to see what is in use
'on the air'.  That is going to be difficult, or very expensive in
overhead pulling the throughput from visible nodes and adding up to
determine channel saturation and capabilities...

As far as the issue of having to generate traffic to know where to
route traffic, maybe reverse the train of thought.

Initially assume that all links are quite similar.  Maybe an 'N' node
will have a different default than a 'G' node, ethernet, etc.  Then
adjust down from the assumed average.  you might assume that all of
your nodes with a certain type of interface have the potential for the
same throughput, but if a node begins dropping TQ when a link gets
saturated, then for some period of time we know what the link is
capable of delivering.  This may not be true for very long so this
downward adjustment should swing up to the baseline over time.
Consistent traffic will keep the known maximum populated, light
traffic will let the node drift back to average.

Track this over time.  If a loaded node is routinely having the
throughput number brought down to 75, then we can adjust the node's
default to 75.  If the node becomes more capable because of some
environmental change that we are not aware of, it will still transfer
at full speed, then the history will show that this has been swinging
UP from 75 to 85.  Adjust the default number for the node based on the
trends.  If we store that TQ dropped at throughput X 15 times in the
last 3 days, we should adjust our throughput number to just below that
point as the default.  If that changes, then the recent history will
reflect it and the default will be changed back to the interface type
default.

If we manually assign a node to a certain default speed from some
known values then we have a baseline.

certain things might be initially assumable.
half duplex links are 70/30 to rx/tx (from receiver's perspective).
100Mb aggregate means 70Mb for our purposes
full duplex links are 100/100.  100Mb really means 100Mb here.

assuming a connection level of MCS12 instead of max:
single stream N 20mhz is 65Mb H/D * .7  =3D45
dual stream N is 130 H/D * .7  =3D91
G is 27Mb * .7  =3D19
Ethernet is 100Mb * 1 =3D100
Gigabit is 1000Mb * 1 =3D 1000

set the wireless G interface on a node to 19, the ethernet to 100.

If historically, we see that the link falls apart at about 16Mb, we
need to adjust the default.

this might be some process that sits outside of batman-adv.
batman-adv should handle distributing the throughput numbers, but
another daemon could handle the math and updating the throughput
numbers.  This would allow batman-adv to stay pure as far as
interfaces go.  The helper daemon could handle the differences between
using ifconfig, ethtool, iw etc to determine throughput.
