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
	<7ilin9voj9.fsf@lanthane.pps.jussieu.fr> <4F5B7F44.3000803@tnode.com>
Date: Sun, 11 Mar 2012 16:32:37 +0100
In-Reply-To: <4F5B7F44.3000803@tnode.com> (mitar@tnode.com's message of "Sat, 
	10 Mar 2012 08:20:20 -0800")
Message-ID: <7ihaxv5f1m.fsf_-_@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] Network models [was: Battlemesh v5 tests]
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
To: Mitar <mitar@tnode.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

Hmm, are we getting off-topic for the Battlemesh list?

>> (In a pure mesh protocol, routers with multiple interfaces should
>> probably appear as multiple nodes;

> Why? I think it is good that the routing protocol knows that something
> (some interfaces) belongs together (node).

I agree with both of you, this is precious information that should not
be dropped.  The question is whether it should be embedded in the
network model, or kept outside of it.

A pure mesh model has the attraction of being extremely clean and pure;
most graph theory theorems apply to a pure mesh model straight away,
which allows you to leverage a large body of existing litterature.  So
intuitively there should be some strong advantages to keeping your model
small and clean, and encoding the information about linked interfaces in
a separate data structure.

I'm not quite sure what model BATMAN uses, but it would appear that it's
almost, but not quite, a pure mesh model.  Perhaps the BATMAN developers
have thought long and hard about giving up the purity of a mesh model,
and decided that it's worth it.  Perhaps they haven't.  It's difficult
to say, since they're not interested in communicating on technical issues.

OLSR uses a pure model and encodes extra information in additional data
structures.  That's why OLSR uses MIDs and HNAs -- they're the packets
carrying the additional data.  An alternative "clean" model would be to
have a router id for each interface, and an extra flag within TC entries
that shows which links are between multiple interfaces of a single node,
which is what I suggest might be a good choice at layer 2.

Babel uses a different model, the classical Internet model (very well
described by Clark in the early 80s, but I don't have the paper handy).
In that model, we're not working with a graph, but with a structure with
three kind of entities: nodes, interfaces, and links, where links
connect interfaces rather than connecting nodes.  There are some
advantages to using a model that more faithfully represents reality, and
that is a good fit with what classical routing protocols do, but of
course the downside is that we're working with a somewhat messy data
structure that hasn't been studied as exhaustively as graphs have.

-- Juliusz
