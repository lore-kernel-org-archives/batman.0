Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 6 Aug 2016 21:58:59 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160806195859.GF9221@otheros>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <1877539.fInDOEgoYM@bentobox> <20160806011112.GC4299@otheros>
 <3793403.6mU5AUzq3p@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3793403.6mU5AUzq3p@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Simple (re)broadcast
 avoidance
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

On Sat, Aug 06, 2016 at 10:13:38AM +0200, Sven Eckelmann wrote:
> And to be fair: There is one case were a spinlock is missing in 
> batadv_find_router
> 
>     	last_candidate = orig_node->last_bonding_candidate;
>     	if (last_candidate)
>     		last_cand_router = rcu_dereference(last_candidate->router);
> 
> I had this on my list but mostly forgot about it while chasing the reference 
> counting bugs. Maybe you found more problems but I am not sure which ones :)

Right, that was the part that startled me in the first place :-).
(bc. of the rcu_read_lock() one line earlier, I falsely assumed
that the author wanted to have it rcu-locked for the reader-side -
but you are right, spinlocking for both reader and writer side is another
option :) )
