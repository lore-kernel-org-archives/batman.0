Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 14 May 2016 16:51:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160514145129.GD4375@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

Is anyone familiar with the implications of using kmalloc() vs.
kmem_cache_alloc()? Not just allocation speed, but also RAM
fragmentation is something I'm currently wondering about.

We have had issues with the large, bulk allocations from the
debugfs tables before, where if I remember correctly the
experssion "RAM fragmentation" has been mentioned before. With the
fallback from kmalloc() to vmalloc() in the debugfs internals on
more recent kernels, at least that problem has gone for now.

Still, I'm wondering whether a couple of thousand global TT entry
allocations (Freifunk Hamburg currently has more than three
thousand) could lead to a badly fragmented RAM. Too much for a
cute wifi router with just 32MB of RAM, maybe.


I then noticed that the bridge is using kmem_cache_alloc() instead
of kmalloc() for its fdb (forwarding database). Would it make
sense to do the same for global TT entries (and maybe originator
structs, too?)?

If so, I'd be happy to look into providing a patch.

Regards, Linus

PS: Why this thought came up:
https://github.com/freifunk-gluon/gluon/issues/753
Could be a memory leak or something else too though. Investigation
still in progress.
