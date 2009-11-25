Return-Path: <aaron@lo-res.org>
Message-ID: <4B0D106F.40404@lo-res.org>
Date: Wed, 25 Nov 2009 12:09:35 +0100
From: "L. Aaron Kaplan" <aaron@lo-res.org>
MIME-Version: 1.0
References: <4B0D0DD2.1040107@rsm-freilassing.de>
In-Reply-To: <4B0D0DD2.1040107@rsm-freilassing.de>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] What routingprotocol is similar to B.A.T.M.A.N ?
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

Michael Rack wrote:
> Dear List,
>
> sorry if that is not the right place for my question. But the approach
> of B.A.T.M.A.N in how to choise the next hop is phantastic. Protocols
> how BGPv4 and OSPF only take the shortest path to the destination.
> B.A.T.M.A.N looks for the fastest way where the Hello-Message arrives
> first.
>
> So long. I need a Routing-Protocol for static mash. My
> Wireless-Network besides on fixed Wireless Stations they become never
> to be dynamic. The complete Wireless Network is in
> Infrastructure-Mode. All members in the Network have just one role (AP
> / Client).
>
> Currently OLSR does the routing job. But there lots of problems. OLSR
> also take the shortest path, also in case, a better link is available.
>
For OLSR development it would be interesting if you could discuss on the
mailing list there how your routing metric should be.
OLSR has a very nice framework (this is one of the advantages that it
has next tom some disadvantages) that actually you *can* change the metric!
We simply did not find any way yet to make layer 2 metrics cross
plattform comparable.

But this is better discussed on the OLSR mailing lists of course. (off
topic here)

> B.A.T.M.A.N is not suitable for my situation. The Client should not be
> able to select a desired gateway. A gateway should inject a default
> gateway to the clients, how OLSR does it.
>
> Is there any other routing protocol on the market, that combine all
> that features, that i need?
>

You could try BGP . It is for sure very stable and very well tested ;-)
And actually it is also used in static mesh networks.
I have the feeling that it will actually do what you want. without major
bugs.


>     * Routing descission on fastest HelloMessage
>     * Inject Default-Gateway via 0.0.0.0/0
>     * Without tunneling data
>
> Liebe Gr=FC=DFe aus Freilassing,
>
> Michael Rack
> RSM Freilassing

