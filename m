Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
	<20120307221847.GR12778@kerneis.info>
	<20120309085636.GA9018@pandem0nium>
	<CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
	<20120309105921.GD15059@kerneis.info>
Date: Fri, 09 Mar 2012 12:39:38 +0100
In-Reply-To: <20120309105921.GD15059@kerneis.info> (Gabriel Kerneis's message
	of "Fri, 9 Mar 2012 11:59:22 +0100")
Message-ID: <7ik42u9f5x.fsf_-_@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] Diversity in BATMAN [was: Battlemesh v5 tests]
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
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> They just decide upfront a set of alternative interfaces, and then
> choose the best interface that it is not the incoming one among this
> set, for each packet.

Can you confirm that, Simon?

> You have no way to declare that two different wifi interfaces interfere, for
> instance; it is roughly similar to babel -z1.

Unlike in Babel, however, where that happens at the metric level, in
BATMAN it appears to be implemented at the route selection level.  I'd
like to better understand all of the tradeoffs involved.

On the one hand, doing things at the route selection level makes
BATMAN's approach to diversity completely metric-agnostic, and avoids
tricky issues of metric compositionality.  On the other hand, encoding
the diversity information in the metric has the advantage of propagating
the information to other nodes.

Consider the following topology (all links assumed lossless), where
we're trying to route from A to S:

      B---C
     /     \\
    /       \\
   A          S
    \        /
     \      /
      B'---*C'  (C' has just a single interface)

In Babel, even with just Z1,the diversity information is encoded in the
metric, and so B announces a smaller metric than B'; this causes A to
prefer the ABCS route to the AB'C'S route.  Unless I'm misunderstanding
something, in BATMAN no information is propagated to A -- the information
about the extra diversity in the upper route is purely local to C.

(Note that this is completely orthogonal to explicitly propagating
diversity information in addition to the metric, which only happens in
Babel-Z3.)

-- Juliusz
