Return-Path: <gabriel@kerneis.info>
Date: Wed, 7 Mar 2012 23:18:48 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120307221847.GR12778@kerneis.info>
References: <4F4F6D18.3070403@ninux.org>
	<201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20120307171751.GC1389@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

[CC: b.a.t.m.a.n@lists.open-mesh.org, see note 3 in particular]

Antonio,

On Wed, Mar 07, 2012 at 06:17:52PM +0100, Antonio Quartulli wrote:
> Technical details about what? Interface-alternating? It is there!
> Gabriel wrote the link.  

No. Please re-read my email carefuly.  The wiki contains a rough explanation of
the general principle (ie. “same interface = bad, different interface = good”).
Not the actual algorithm used by batman-adv (quoting from the wiki: “the
algorithm tries to avoid forwarding packets on the interface which just received
the packet”).

Note that the wiki has been updated since then, by Simon with a few more
details [1], and by Marek with benchmark results from WBMv3.

> Gabriel said he has not enough time to look into it. I'm sorry, but I don't think
> this is a good reason to blame batman-adv devs :P

I finally decided to settle this issue and spent my breakfast reading
batman-adv/routing.c [2] instead of my favorite newspaper.  Here is what I
understood:

    At all times, batman-adv maintains a list of "bonding candidates" for each
    node (bonding_candidate_add, called from bat_iv_ogm.c:699).
    Some node "neigh" is a bonding candidate for another node "orig" if and only
    if:
    - neigh and orig have the same primary address, ie. are in fact the same
      router,
    - the links to reach them have the same quality up to some additive
      constant (BONDING_TQ_THRESHOLD = 50) [3],
    - orig does not already have another bonding candidate for the same
      interface, because it could interfere – but what if the neigh has a better
      link quality, isn’t it a pity to ignore it?

    Then, assuming that "interface alternating" is enabled, the list of bonding
    candidates is used on every route selection (find_ifalter_router, called
    from routing.c:769).
    More precisely, once batman has chosen a next-hop router for a packet based
    on its classical routing algorithm, it walks the list of the bonding
    candidates associated to the primary interface for this router [4].  It
    selects the actual next-hop on the following criteria:
    - it must not be on the same interface as the packet came in,
    - its quality must be as high as possible (given the previous constraint).

This is the kind of explanation I would have loved to find on the wiki.  By the
way, consider it public domain and feel free to copy/paste/correct it if you
wish.

It is still not clear to me exactly why this works, but I believe this is what
the code does, and is definitely easier to discuss than generic, unsubstantiated
claims.

Best regards,
Gabriel

[1] “Interface alternating is only performed if the two candidate links to the
    next hop have a similar quality.”
    http://www.open-mesh.org/wiki/batman-adv/Multi-link-optimize

[2] http://www.open-mesh.org/projects/batman-adv/repository/revisions/master/entry/routing.c

[3] By the way, there is something I don’t understand: neigh_node->tq_avg will be
    accepted event if it is far greater than router->tq_avg + BONDING_TQ_THRESHOLD.
    Shouldn’t it be: abs(neigh_node->tq_avg - router->tq_avg) > BONDING_TQ_THRESHOLD?
    http://www.open-mesh.org/projects/batman-adv/repository/revisions/master/entry/routing.c#L166

[4] Why the primary and not the chosen router directly? Is the bonding
    candidates list always associated to the primary interface?
