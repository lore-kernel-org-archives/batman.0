Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 6 Aug 2016 03:04:13 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160806010413.GB4299@otheros>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <20160803212552.GB16866@otheros> <20160803234329.GD16866@otheros>
 <3736273.XKRaZoI53k@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3736273.XKRaZoI53k@bentobox>
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

On Thu, Aug 04, 2016 at 09:29:20AM +0200, Sven Eckelmann wrote:
> On Donnerstag, 4. August 2016 01:43:29 CEST Linus Lüssing wrote:
> [...]
> > So the regular purging routines will break the cycle in the end
> > when they reduce the refcount of the hardif_neigh_node to zero.
> 
> Ok, lets go through it with following idea:
> 
> 1. the cycle exists (including the missing batadv_orig_node::ifinfo_list
>    in my earlier example graph)
> 2. batadv_purge_orig is called via the worker (for some reason with a large delay)
> 3. _batadv_purge_orig goes through all entries in the orig hashtable
> 4. batadv_purge_orig_node is called
> 5. batadv_has_timed_out returns "hey, you are old - go away"
> 6. batadv_purge_orig_node now only does for this orig_entry:
>    - batadv_gw_node_delete(bat_priv, orig_node);
>    - hlist_del_rcu(&orig_node->hash_entry);
>    - batadv_tt_global_del_orig(orig_node->bat_priv,
> 							  orig_node, -1,
> 							  "originator timed out");
>    - batadv_orig_node_put(orig_node);
> 
> So the most cleanup work (batadv_orig_node_release) is only done when
> the orig_node refcnt reaches zero.
> 
> The batadv_purge_orig_ifinfo, batadv_purge_orig_neighbors and the
> rest from batadv_purge_orig_node is only done when the originator
> has not yet reached its timeout. I would therefore guess it working
> because you are lucky and your batadv_purge_orig_neighbors and
> batadv_purge_orig_ifinfo sometimes(tm) solve this problem for you.

Did some more tests today. Confirmed.

batadv_purge_orig_node has 2*PURGE_TIMEOUT, while
purge_orig_neighbours only has 1*PURGE_TIMEOUT. All
hardif_neigh_release() and orig_node_release() calls happened as
expected, even with the patch of this thread.

purge_orig_neighbors seems to reset the
orig_node->last_bonding_candidate to NULL and break the cycle.


If I switch the two purging intervals, then I have the memory leak
with this patch. Without this patch, no memory leak.


I'll send a v3 with a simple six bytes orig address copy instead
of a full orig_node reference.


Thanks for this awesome finding of a rare but nasty bug! Even
though it'll probably mostly not happen due to the big timeout
differences, it would nevertheless have been very, very difficult
to spot & reproduce later on...
