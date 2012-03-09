Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>
	<20120309123905.GB436@ritirata.org>
	<20120309125741.GJ15059@kerneis.info>
	<74A4488FAEEC56408507A6FECA6909910122184D@SC000647.CHASCOM.INT>
	<20120309134600.GK15059@kerneis.info>
Date: Fri, 09 Mar 2012 15:26:18 +0100
In-Reply-To: <20120309134600.GK15059@kerneis.info> (Gabriel Kerneis's message
	of "Fri, 9 Mar 2012 14:46:00 +0100")
Message-ID: <7ilin9voj9.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]     Battlemesh v5 tests
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

>        l0        l1
>     A ---- B ---------- C  Example:
>            \           /   I want to restrict the link l1 to communication
>             D -- E -- F    between A and C. (Nice frying-pan, isn’t it? ;-)

I think that Andrew has answered your question.  BATMAN is a pure mesh
protocol; it doesn't support filtering, aggregation, or overlapping
prefixes, and only limited support for multiple interfaces per node.
Pure mesh is an excellent choice for layer 2 routing, where there are no
overlapping prefixes, and little opportunity for aggregation or
filtering.

(In a pure mesh protocol, routers with multiple interfaces should
probably appear as multiple nodes; that is not done in BATMAN, seemingly
for efficiency reasons, a choice I am not quite comfortable with.)

> Your solution [...] only pushes the problem outside of batman.

Yes, and that's a feature.  Layer 3 problems are outside the scope of
a layer 2 protocol.

-- Juliusz
