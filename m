Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110508125553.GA4071@lunn.ch>
References: <BANLkTi=jP-N9wR2TMdB6oDEZcLVpROndUg@mail.gmail.com>
	<201105071933.19780.lindner_marek@yahoo.de>
	<BANLkTi=NMtjCDO5461N+mxmKqmDnSpPa+w@mail.gmail.com>
	<20110508125553.GA4071@lunn.ch>
Date: Sun, 8 May 2011 16:55:29 +0200
Message-ID: <BANLkTikEY9egqZwSX0qPFce=XC-HL_DdHw@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Routing improvement taking into account links
	bit-rate
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

2011/5/8 Andrew Lunn <andrew@lunn.ch>:
> Hi Daniele
>
>> It is not a real Link State routing, the document maybe is not
>> completely clear. =A0Every node before the OGM rebroadcast, attach its
>> current best path toward the originator node. =A0I could do this
>> without adding an hop list, but simply substituting the TQ with PCE.
>
> How you tried this? How well does this work?
>
I've not tried this, but it is perfectly equivalent as appending the
current best path to OGM.
I permit to the next node to do the same operation that previous node has d=
one.

> Not adding path information will be a big help in avoiding routing
> loops. It seems to me, just the simple idea of weighting the local TQ
> with a bitrate factor might help.
>
Routing loops can occur exactly as they can occur with current
protocol, I think.
I did not introduced any cause of loops, I use the list of hop
received in OGM only for PCE computation.
Anyhow I will think deeply on this potential problem.

> The hard part is correctly handling the total air time. One 36Mbps hop
> is better than two 54Mbps hops, because of the total air time.
>
I explained this in the report. I did not calculate the exactly total
air time, but I weight the
metric with its length when comparing it with the current best route.
For example, for doubling the length I require 4 times more PCE.

> It would also be interesting to see how bit rates change with
> usage. It could be that you pick a next hop partially based on its bit
> rate, which puts load onto the next hop, and its bit rate drops, since
> it is now being used more and so suffers more interference. The
> dropping bit rate causes the next hop route decision to change.
>
> It could be, you are actually introducing more route flipping.

Certainly bit-rate is subject to frequent oscillations, so I maintain
an exponential moving average
of PCE that "smooth" this oscillations.
Bit-rate is actually subject to variation for various factor, such as
node distance, channel occupation, etc.. and
all these factor are important for routing decision. I take the
bit-rate that summarize all these information and use it
to weight the TQ.
>
> What would be interesting is to look at the effect of route
> flipping. Is it bad for performance? If so, can hysteresis be added
> without causing routing loops. There was some work posted here a
> couple of months ago that started to look at these
> questions. Unfortunately, it did not consider if routing loops would
> be introduced.
>
I've seen that work and seems interesting. Routing loops have been not
considered yet in
any published paper as far as I know. :(

> =A0 Andrew
>

Thank you for your comments!

--=20
Daniele Furlan
