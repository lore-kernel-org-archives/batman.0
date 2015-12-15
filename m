Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 15 Dec 2015 14:15:33 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151215131533.GF7560@otheros>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <8889525.bHy7H9IMLu@sven-edge> <20151207221242.GR27041@otheros>
 <10435676.kQRiOMhoYg@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10435676.kQRiOMhoYg@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
 doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>

On Mon, Dec 14, 2015 at 07:56:19PM +0100, Sven Eckelmann wrote:
> On Monday 07 December 2015 23:12:42 Linus Lüssing wrote:
> > On Sat, Nov 28, 2015 at 09:21:02AM +0100, Sven Eckelmann wrote:
> > > mcast.mla_list is protected by tt.commit_lock (see
> > > batadv_mcast_mla_tt_add,
> > > batadv_mcast_mla_list_free and batadv_mcast_mla_tt_retract).
> > 
> > mcast.mla_list changes should be protected by the non-parallel code
> > flow: During runtime, batadv_mcast_mla_tt_update() is only called from
> > the self-rearming OGM scheduler thread -
> > batadv_mcast_mla_tt_update() will never run more than once at the
> > same time.
> > 
> > The second place for mcast.mla_list changes, batadv_mcast_free(), is
> > called only on shutdown after the OGM scheduling thread was stopped.
> 
> The two functions with the lockdep assert are
> 
> * batadv_mcast_mla_list_free
> * batadv_mcast_mla_tt_retract
> 
> (batadv_mcast_mla_tt_add looks basically like batadv_mcast_mla_list_free)
> 
> The call graphs are attached and these graphs have (pure) starting nodes which 
> are not only batadv_exit and batadv_iv_ogm_schedule. Parts of them look like 
> they are only protected because of tt.commit_lock.

Thanks for these pictures! (btw. which tool did you use for that?)

The two non-colliding paths I had in mind were
batadv_iv_ogm_schedule() and batadv_mcast_free(), which looks
like:

batadv_mesh_free()
	-> batadv_purge_outstanding_packets()
		-> cancel_delayed_work_sync()	!
	[...]
	-> batadv_mcast_free()

Which ensures that no batadv_iv_ogm_schedule() is running before
calling batadv_mcast_free().


But I missed the path from batadv_update_min_mtu()... However,
it should not race with batadv_mcast_free() either, which is
called once the last hard-iface gets disabled:

batadv_hardif_disable_interface()
	-> batadv_purge_outstanding_packets()
		-> cancel_delayed_work_sync()	!
	-> dev_put(soft_iface)
		[ if last hard-iface, then soft-iface is out
		  of scope for any new batadv_update_mtu() and
		  gets freed: ]
		-> batadv_softif_free()
			-> batadv_mesh_free()
				-> batadv_mcast_free()

But with yet another path it is getting even more, rediculously
complicated... Just proving that trying to keep a lock-less update
for mla_list here is a bad, unmaintainable approach :).

So I'm definitely in favor of having some spinlock to refer to for
mcast.mla_list update, even if it isn't necessary for
batadv_mcast_free(). But I don't see a race for the current
mla_list updates either (otherwise I'd need a specific, more
verbose example, I guess...).


The question is, do we want to have Simon's patch for maint to
trickle down to 4.3 (where the lockdep patch got added) or back to
3.15 (where multicast.c got added)?

For stable kernels, we need a specific, precise, reproducable issue
to point to, right? (stable_kernel_rules.txt: 'It must fix a real
bug that bothers people (not a, "This could be a problem..." type
thing).'

Regards, Linus
