Return-Path: <andrew.lunn@ascom.com>
From: <andrew.lunn@ascom.com>
Date: Fri, 9 Mar 2012 12:44:27 +0000
Message-ID: <74A4488FAEEC56408507A6FECA6909910122181F@SC000647.CHASCOM.INT>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>	<20120307221847.GR12778@kerneis.info>
	<20120309085636.GA9018@pandem0nium>
	<CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
	<20120309105921.GD15059@kerneis.info>
	<7ik42u9f5x.fsf_-_@lanthane.pps.jussieu.fr>
In-Reply-To: <7ik42u9f5x.fsf_-_@lanthane.pps.jussieu.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Diversity in BATMAN [was:
	Battlemesh v5 tests]
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
To: battlemesh@ml.ninux.org
Cc: b.a.t.m.a.n@lists.open-mesh.org

> Consider the following topology (all links assumed lossless), where
> we're trying to route from A to S:
>=20
>       B---C
>      /     \\
>     /       \\
>    A          S
>     \        /
>      \      /
>       B'---*C'  (C' has just a single interface)
>=20
> In Babel, even with just Z1,the diversity information is encoded in the
> metric, and so B announces a smaller metric than B'; this causes A to
> prefer the ABCS route to the AB'C'S route.  Unless I'm misunderstanding
> something, in BATMAN no information is propagated to A -- the
> information
> about the extra diversity in the upper route is purely local to C.
=20
Hi Juliusz

I'm no expert here, but if Simon happens to fall on his head.....

The metric is simply based on TQ. C=3DS will probably have a better local T=
Q than C'-S because of the load balancing over the two links, meaning there=
 are less packets in the air, and so probably less collisions, etc.. A gets=
 to know the complete link path TQ going both ways around the loop, so does=
 get some idea that C=3DS is better than C'-S, assuming it is actually bett=
er.

	Andrew=20
