Return-Path: <linus.luessing@web.de>
Date: Thu, 16 May 2013 20:19:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130516181945.GC22374@Linus-Debian>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-3-git-send-email-linus.luessing@web.de>
 <20130511231113.GE901@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130511231113.GE901@ritirata.org>
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

On Sun, May 12, 2013 at 01:11:13AM +0200, Antonio Quartulli wrote:
> On Sat, May 11, 2013 at 07:23:26PM +0200, Linus Lüssing wrote:
> >  /**
> > + * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @orig: the orig_node of the ogm
> > + * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
> > + * @tvlv_value: tvlv buffer containing the multicast data
> > + * @tvlv_value_len: tvlv buffer length
> > + */
> > +static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
> > +					     struct batadv_orig_node *orig,
> > +					     uint8_t flags,
> > +					     void *tvlv_value,
> > +					     uint16_t tvlv_value_len)
> > +{
> > +	uint8_t mcast_flags = BATADV_NO_FLAGS;
> > +
> > +	/* only fetch the tvlv value if the handler wasn't called via the
> > +	 * CIFNOTFND flag and if there is data to fetch
> > +	 */
> > +	if (!(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
> > +	    (tvlv_value) && (tvlv_value_len == 1))
> 		just for style reason I'd suggest to use sizeof(mcast_flags)
> 		instead of 1. and there is no need for parentheses around
> 		tvlv_value.
> 
> > +		mcast_flags = *(unsigned char *)tvlv_value;
> 
> mcast_flags is uint8_t, therefore (even if it may practically be the same) you
> should use the same type for the cast.

ok

> 
> > +
> > +	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
> > +	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
> > +		atomic_inc(&bat_priv->mcast_num_non_aware);
> > +	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
> > +		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
> > +		atomic_dec(&bat_priv->mcast_num_non_aware);
> > +	}
> > +
> > +	orig->mcast_flags = mcast_flags;
> > +}
> 
> > diff --git a/originator.c b/originator.c
> > index 5d53d2f..acc0c2d 100644
> > --- a/originator.c
> > +++ b/originator.c
> > @@ -257,6 +257,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
> >  	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
> >  	orig_node->bcast_seqno_reset = reset_time;
> >  	orig_node->batman_seqno_reset = reset_time;
> > +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> > +	orig_node->mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> > +#endif
> 
> why do you start assuming that an originator has the optimisation enabled? would
> it be better to wait for the first mcast tvlv from it to claim this?

Because it is easier code-wise. I had it the other way round first
and issuing an atomic_inc(&bat_priv->mcast_num_non_ware) in
batadv_get_orig_node(), but then I ended up counting up too many
times because I was increasing that counter for secondary
interface originators, too while not decreasing it again because
no TVLV handler will be called for these. And within
batadv_get_orig_node() I don't see an easy way to determine
whether I was called for a primary or secondary interface
originator.

> 
> > +/* multicast capabilities */
> > +enum batadv_mcast_flags {
> > +	BATADV_MCAST_LISTENER_ANNOUNCEMENT = BIT(0),
> > +};
> > +
> 
> > diff --git a/types.h b/types.h
> > index 5d73a75..4ef5fb9 100644
> > --- a/types.h
> > +++ b/types.h
> > @@ -146,6 +146,9 @@ struct batadv_orig_node {
> >  	unsigned long last_seen;
> >  	unsigned long bcast_seqno_reset;
> >  	unsigned long batman_seqno_reset;
> > +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> > +	uint8_t mcast_flags;
> > +#endif
> >  	uint8_t capabilities;
> >  	atomic_t last_ttvn;
> >  	uint32_t tt_crc;
> > @@ -569,6 +572,7 @@ struct batadv_priv {
> >  #endif
> >  #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> >  	atomic_t mcast_group_awareness;
> > +	atomic_t mcast_num_non_aware;
> 
> why isn't this variable in the mcast_priv struct? It is not a user knob (as far
> as I can see)

You're right, will move it.

> 
> Cheers,
> 
> -- 
> Antonio Quartulli
> 
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara


Cheers, Linus
