Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 27 Jun 2016 06:02:18 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160627040218.GP4407@otheros>
References: <1466865846-32621-1-git-send-email-sven@narfation.org>
 <1666680.Y9BoZfK7nu@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1666680.Y9BoZfK7nu@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: use kmem_cache for
 translation table
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

On Sat, Jun 25, 2016 at 05:46:47PM +0200, Sven Eckelmann wrote:
> On Saturday 25 June 2016 16:44:06 Sven Eckelmann wrote:
> > The translation table (global, local) is usually the part of batman-adv
> > which has the most dynamical allocated objects. Most of them
> > (tt_local_entry, tt_global_entry, tt_orig_list_entry, tt_change_node,
> > tt_req_node, tt_roam_node) are equally sized. So it makes sense to have
> > them allocated from a kmem_cache for each type.
> > 
> > This approach allowed a small wireless router (TP-Link TL-841NDv8; SLUB
> > allocator) to store 34% more translation table entries compared to the
> > current implementation.
> > 
> > [1] https://open-mesh.org/projects/batman-adv/wiki/Kmalloc-kmem-cache-tests
> > 
> > Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> 
> Here is the changelog (since the RFC):
> 
> v2:
>  - use kmem_cache_zalloc instead of kmem_cache_alloc + memset as
>    suggested by Linus
>  - add cache batadv_tt_change_cache, batadv_tt_req_cache,
>    batadv_tt_roam_cache
>  - Added Reported-by
>  - rewrote commit message
>  - summarize+link the results from Linus' tests

Looks good. Do you have any typical numbers regarding tt_change_cache
and tt_req_cache sizes for specific setups?

Just wondering whether it is worth it to have extra caches for
these two. (if you don't have any numbers, I might have a look at
/proc/slabinfo with your patch for some Freifunk network(s) later
today)
