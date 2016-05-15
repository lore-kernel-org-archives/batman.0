Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 15 May 2016 14:06:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160515120626.GG4375@otheros>
References: <20160514145129.GD4375@otheros>
 <2911091.OSPWlnrdxm@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2911091.OSPWlnrdxm@sven-edge>
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, May 15, 2016 at 01:27:39PM +0200, Sven Eckelmann wrote:
> On Saturday 14 May 2016 16:51:29 Linus Lüssing wrote:
> > Hi,
> > 
> > Is anyone familiar with the implications of using kmalloc() vs.
> > kmem_cache_alloc()? Not just allocation speed, but also RAM
> > fragmentation is something I'm currently wondering about.
> 
> Yes, it should reduce the effects of allocating differently sized objects 
> (which can create smaller regions of memory which cannot be used anymore). But 
> my guess is that SLAB isn't that bad because it already has some caches for 
> differently sized memory regions.

Yes, I tested the following patchset [0] yesterday, created a few
hundred clients in x86 VMs and obsevered the output of /proc/slabinfo.

* tt_global_entry uses kmalloc-node cache (objsize 192), same size for
  a batadv_tt_global_cache
* tt_orig_list_entry uses a kmalloc-64, same size for a
  batadv_tt_orig_cache

(sizeof(tt-global) -> 144, sizeof(orig-entry) -> 56,
sizeof(tt-common) -> 64, sizeof(tt_local) -> 80)

So indeed it looks like there might not be a difference in using
one of the predefined or a custom cache fragmentation wise. And
the wasted space seems to be the same (if I'm not misinterpreting the output
of slabinfo).

On the other hand it seems common to use custom caches for
larger amounts of frequently changing objects of the same type.
Filesystems seem to use them regularly.

> 
> I think we should check if this helps by first testing it with the main TT 
> objects. I've send an RFC patch [1]. Unfortunately, I am not aware of any nice 
> tools to really check the size of the available, continuous memory chunks. The 
> only thing partially interesting I know about is /proc/slabinfo which shows 
> you the state of the available caches (including the slab page caches).

Ok, yes, that's what I had looked at yesterday, too. I'll check
whether I can get some guys from Freifunk Rhein-Neckar or Freifunk
Hamburg to test these patches and whether they make a difference
for them.

> 
> Kind regards,
> 	Sven 
> 
> [1] https://patchwork.open-mesh.org/patch/16200/

[0] https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/kmem-cache
