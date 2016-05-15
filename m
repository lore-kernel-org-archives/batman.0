Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 15 May 2016 23:26:32 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160515212632.GB10345@otheros>
References: <20160514145129.GD4375@otheros> <20160515120626.GG4375@otheros>
 <20160515124138.GI4375@otheros> <10164043.KPuzFIC6Pp@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10164043.KPuzFIC6Pp@sven-edge>
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

On Sun, May 15, 2016 at 10:50:20PM +0200, Sven Eckelmann wrote:
> Hm, looks like the the biggest difference is in kmalloc-64. So this would mean 
> that the kmalloc version uses 64 byte entries for tg entries. And the 
> batadv_tt_global_cache version uses 192 bytes (so it has an even larger 
> overhead). The question is now - why?

The biggest difference is not only in kmalloc-64 but also
kmalloc-node.

tg entries seem to end up in kmalloc-node (192 objsize), tt orig list entries
in kmalloc-64 I think (like I wrote in my previous mails).

> 
> My first guess was that you you are using ar71xx with MIPS_L1_CACHE_SHIFT == 
> 5. This would cause a cache_line_size() of 32. The tg object is 48 bytes on 
> ar71xx. So it looks like you are using a different architecture [1] because 
> otherwise the (cache) alignment would also be 64 bytes. Maybe you have some 
> debug things enabled that cause the extra used bytes?

Yes, it's not ar71xx like you have, it's x86-64/amd64 in a
VM. sizeof() actually tells me 144 bytes for a tg entry. And 56
bytes for an orig-list entry (like I wrote before).

> 
> Extra debug information would also explain it why bridge_fdb_cache requires 
> 128 bytes (cache aligned) per net_bridge_fdb_entry. I would have expected that 
> it is not using more than 64 bytes and is merged automatically together with 
> something like kmalloc-64 (see __kmem_cache_alias for the code merging 
> different kmem_caches).

Hm, could be, yes I have enabled quite a bit of options in the
kernel hacking section.

> 
> 
> Just some thoughts about the kmem_cache approach: We would only have a benefit 
> by using kmem_cache when we could have a objsize which is smaller than any 
> available slub/slab kmalloc-*. Otherwise slub/slab would automatically use a 
> good fitting, internal kmem_cache for everything.

Might be. From /proc/slabinfo output batadv_tt_global_cache and
kmalloc-node, as well as batadv_tt_orig_cache and kmalloc-64
looked similar.

But don't know whether there are any internal differences for the
custom caches. Unfortunately documentation seems rare regarding
kmem-caches :(.

> 
> Right now, the size of a tg entry on my system (ar71xx mips, amd64) would have 
> a raw size of 48-80 bytes. These would end up at an objsize (cache line 
> aligned) of 64-96 bytes. On OpenWrt (ar71xx) it should be merged with 
> kmalloc-64 and on Debian (amd64) it should be merged with kmalloc-96 (not 
> tested -

> but maybe it is important to mention that kmalloc-96 has an objsize 
> of 128 on my running system).

In my VMs too, as can be seen in the provided slabinfo.

> 
> Kind regards,
> 	Sven
> 
> [1] Yes, I saw the kvm and ACPI lines after I wrote this stuff. So you are
>     most likely testing on some x86 system

Indeed :).
