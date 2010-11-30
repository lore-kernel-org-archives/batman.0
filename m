Return-Path: <mvanderkolff@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201011301542.45457.lindner_marek@yahoo.de>
References: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
	<201011292258.05388.lindner_marek@yahoo.de>
	<AANLkTikPFR+A5uGZfxB350yD4h0VXuueE+y1g2CcNxS7@mail.gmail.com>
	<201011301542.45457.lindner_marek@yahoo.de>
Date: Wed, 1 Dec 2010 01:55:16 +1100
Message-ID: <AANLkTinh3EzmA5=rJLi05wgy+cSXQwVRE4Ri+QBbCUMr@mail.gmail.com>
From: Michael van der Kolff <mvanderkolff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] global mesh
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

It is in fact feasible to have thousands of mesh nodes -
http://www.so.in.tum.de/wiki/index.php5/Scalable_Source_Routing gives
a real model for something like that.  Linyphi gives a real model for
that - embed a MAC address into subnet address, and get routes to your
immediate successor, 2nd node, 4th node, etc, and forward packets to
the node closest numerically to the destination while still being
under it.  Of course, Linyphi is hardly production ready - more a
proof of concept.

Cheers,

Michael

On Wed, Dec 1, 2010 at 1:42 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Tuesday 30 November 2010 07:12:21 Kosta -- A Human Right wrote:
>> Can B.A.T.M.A.N. scale to millions of users? What are the limitations
>> of B.A.T.M.A.N. in this regard? Where does it excel?
>
> A single mesh cloud consisting of millions of mesh nodes is neither feasible
> nor desirable. Each mesh node is announcing itself and routing information
> about the nodes "behind it". Obviously, the protocol overhead grows up to a
> point where the protocol traffic eats up all available bandwidth.
> On the other hand, mesh protocols inherently rely on trust. Each node trusts
> its neighbor nodes that they send reliable routing information. As in real
> life this trust does not scale either.
>
> Can mesh technology be used to build local inexpensive networks connected to a
> "backbone link" (e.g. satellite) to serve millions of users ? Certainly! That
> is what villagetelco / Freifunk / open-mesh.com / etc are working on.
>
> Regards,
> Marek
>
