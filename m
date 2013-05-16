Return-Path: <linus.luessing@web.de>
Date: Fri, 17 May 2013 00:34:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130516223445.GE22374@Linus-Debian>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-3-git-send-email-linus.luessing@web.de>
 <20130511231113.GE901@ritirata.org>
 <20130516181945.GC22374@Linus-Debian>
 <20130516194120.GI3350@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130516194120.GI3350@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Announce new capability
 via multicast TVLV
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi Antonio,

On Thu, May 16, 2013 at 09:41:20PM +0200, Antonio Quartulli wrote:
> On Thu, May 16, 2013 at 08:19:45PM +0200, Linus Lüssing wrote:
> > > 
> > > > +
> > > > +	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
> > > > +	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
> > > > +		atomic_inc(&bat_priv->mcast_num_non_aware);
> > > > +	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
> > > > +		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
> > > > +		atomic_dec(&bat_priv->mcast_num_non_aware);
> > > > +	}
> > > > +
> > > > +	orig->mcast_flags = mcast_flags;
> > > > +}
> > > 
> > > > diff --git a/originator.c b/originator.c
> > > > index 5d53d2f..acc0c2d 100644
> > > > --- a/originator.c
> > > > +++ b/originator.c
> > > > @@ -257,6 +257,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
> > > >  	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
> > > >  	orig_node->bcast_seqno_reset = reset_time;
> > > >  	orig_node->batman_seqno_reset = reset_time;
> > > > +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> > > > +	orig_node->mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> > > > +#endif
> > > 
> > > why do you start assuming that an originator has the optimisation enabled? would
> > > it be better to wait for the first mcast tvlv from it to claim this?
> > 
> > Because it is easier code-wise. I had it the other way round first
> > and issuing an atomic_inc(&bat_priv->mcast_num_non_ware) in
> > batadv_get_orig_node(), but then I ended up counting up too many
> > times because I was increasing that counter for secondary
> > interface originators, too while not decreasing it again because
> > no TVLV handler will be called for these. And within
> > batadv_get_orig_node() I don't see an easy way to determine
> > whether I was called for a primary or secondary interface
> > originator.
> > 
> 
> mh..I don't really understand this (maybe because I don't have a deep knowledge
> of this code). My idea was to start with:
> 
> orig_node->mcast_flags = BATADV_NO_FLAGS;
> 
> and to set
> 
> orig_node->mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> 
> only in the received TVLV parsing function (if any TVLV has been received).
> Is this inconsistent with what you have in the code?

Yes, that was what I initially had and it unfortunately didn't
work that easily.


The thing is, I want to be able to easily determine whether all
nodes have this flag, this capability to be able to know whether I
can safely make use of the new optimization.

I could for any multicast packet I want to send loop through all
originators and check for this flag. But I thought that might be
too performance hungry in that code path. Therefore I decided to
keep track of that via the "mcast_num_non_aware" variable. If it
is zero than I can optimize, otherwise not.

If I were initializing flags to BATADV_NO_FLAGS in batadv_get_orig_node(),
then I'd have to increase "mcast_num_non_aware" in that same
function because the handler wouldn't be able to do so (unless I'd
use some magic value instead of BATADV_NO_FLAGS, like
BATADV_FLAGS_NOT_INIT). So I had something like:

-----
diff --git a/originator.c b/originator.c
index 5d53d2f..40a3611 100644
--- a/originator.c
+++ b/originator.c
@@ -257,6 +257,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
        reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
        orig_node->bcast_seqno_reset = reset_time;
        orig_node->batman_seqno_reset = reset_time;
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+ orig_node->mcast_flags = BATADV_NO_FLAGS;
+#endif
 
        atomic_set(&orig_node->bond_candidates, 0);
 
@@ -281,6 +284,8 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
        if (hash_added != 0)
                goto free_bcast_own_sum;
 
+ atomic_inc(&bat_priv->mcast_num_non_aware);
+
        return orig_node;
 free_bcast_own_sum:
        kfree(orig_node->bcast_own_sum);
---

But that doesn't work because if I am seeing an originator via its
secondary interface then I'll increase that counter twice. And
even if that originator actually has the new MCAST flag set, then
I'll only decrease it once in the handler because the handler is
not called for secondary interface originators.

So ideally I'd do something like:
-----
diff --git a/originator.c b/originator.c
index 5d53d2f..40a3611 100644
--- a/originator.c
+++ b/originator.c
@@ -281,6 +284,8 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
        if (hash_added != 0)
                goto free_bcast_own_sum;

+ if (IS_PRIMARY_ORIG_ADDR(addr))
+     atomic_inc(&bat_priv->mcast_num_non_aware);
+
        return orig_node;
 free_bcast_own_sum:
        kfree(orig_node->bcast_own_sum);
-----

But unfortunately that doesn't exist as far as I know.

> 
> 
> Cheers,
> 
> -- 
> Antonio Quartulli
> 
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Cheers, Linus
