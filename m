Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 24 May 2016 02:14:32 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160524001432.GD6623@otheros>
References: <20160514145129.GD4375@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160514145129.GD4375@otheros>
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
To: b.a.t.m.a.n@lists.open-mesh.org

Just to throw in some credibile sources.

https://static.lwn.net/images/pdf/LDD3/ch08.pdf:

"The main differences in passing from scull to scullc are a slight
speed improvement and better memory use. Since quanta are allocated
from a pool of memory fragments of exactly the right size, their
placement in memory is as dense as possible, as opposed to
scull quanta, which bring in an unpredictable memory fragmentation."


Also the paragraph regarding SLAB_HW_CACHE_ALIGN sounds
interesting. (And maybe it might be worth considering to ommit this
flag for the sake of our beloved but always memory deprived embedded
systems? Most TT entries aren't usually read anyway.)


Should we just go for kmem_cache_alloc() or should someone ask
on netdev@ first whether that chapter is still valid for current
kernels?
