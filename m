Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
Date: Sat, 7 Jul 2012 13:29:27 -0700
Message-ID: <CAKLmikNDZQL2bDWYMMUHcHA5WTMj2Ou0yFiZ7wg134OHFQZWrw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Route selection over VPN links
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

Hi!

As we are nearing to our transition to Batman, we are playing some
scenarios with it and our current setups and layouts. Currently we
have many nodes connected to more and more VPN servers we have. And we
would like to use Batman on top of that. What happens is that we would
like to use the Batman also for routing over those VPN links. So that
we can connect our nodes to all VPN servers at the same time and
Batman then chooses over which tunnel the data should be routed. And
of course this is a bit different situation then wireless routing. For
example, different VPN servers might have different free capacities at
the moment available, or at least different overall capacity provided
(somebody can donate 100 Mbit/s on the server, somebody else 50
Mbit/s), and then there are also different latencies. Is there some
way for Batman to prefer routes based on this information? So latency
over one link and capacity? I know that capacity is problematic to
measure for wireless links, but here we could configure them manually.
Latency could be measured. And maybe it would even be enough to
measure latency, assuming that congested link would have higher
latency. So the logic could be:
 * if packet loss is different, choose the one with lower packet loss
 * if packet loss is the same, choose the one with lower latency

Such logic could probably be even user also on wireless links, no?

Anyway, is this doable? If I understand correctly, Batman does not
support some plugin system where we could inject this in? Would be
this some addition which could go into the core implementation?

I think I asked a bit of this questions before, but now we have a bit
more concrete picture what would be nice to have for our setup to play
really nicely.


Mitar
