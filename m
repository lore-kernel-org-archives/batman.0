Return-Path: <linus.luessing@web.de>
Date: Sun, 14 Jul 2013 18:25:42 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130714162542.GA4014@Linus-Debian>
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
 <1372889002-6767-5-git-send-email-linus.luessing@web.de>
 <20130712091215.GA9077@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130712091215.GA9077@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 4/4] batman-adv: Add IPv4
 link-local/IPv6-ll-all-nodes multicast support
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
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Jul 12, 2013 at 11:12:16AM +0200, Simon Wunderlich wrote:
> On Thu, Jul 04, 2013 at 12:03:22AM +0200, Linus Lüssing wrote:
> > [...]
> > +enum batadv_forw_mode
> > +batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
> > +{
> > +	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
> > +	int ret;
> > +
> > +	ret = batadv_mcast_forw_mode_check(skb, bat_priv);
> > +	if (ret == -ENOMEM)
> > +		return BATADV_FORW_NONE;
> > +	else if (ret == -EINVAL)
> 
> Shouldn't this better be "ret < 0", in case you add more error cases later?

Good idea! Looks better, I'm adding that.

> 
> >  		return BATADV_FORW_ALL;
> >  
> > -	count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
> > +	ret = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
> >  					    BATADV_NO_FLAGS);
> >  
> > -	switch (count) {
> > +	switch (ret) {
> >  	case 0:
> >  		return BATADV_FORW_NONE;
> >  	case 1:
> > @@ -263,6 +348,28 @@ batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
> >  }
> >  
> >  /**
> > + * batadv_mcast_tvlv_update_flag_counter - update the counter of a flag
> > + * @flag: the flag we want to update counters for
> > + * @flag_counter: the counter we might update
> > + * @new_flags: the new capability bitset of a node
> > + * @old_flags: the current, to be updated bitset of a node
> > + *
> > + * Update the given flag_counter with the help of the new flag information
> > + * of a node to reflect how many nodes have the given flag unset.
> > + */
> > +static void batadv_mcast_tvlv_update_flag_counter(uint8_t flag,
> > +						  atomic_t *flag_counter,
> > +						  uint8_t new_flags,
> > +						  int old_flags)
> 
> Why are parts of the bitsets uint8_t, some int?

Because the locally stored mcast_flags variable is bigger than the tvlv
mcast_flags (because of the BATADV_UNINIT_FLAGS).

> 
> Also, this function should go into one of the previous patches, this has nothing to do with
> IPv4 but is just a refactoring.

Hm, it's just moving some code to a new function because the
original function got too long for my taste now. Anyways, ok, I'm
going to introduce that function in the previous patch already.

> 
> > +{
> > +	if (!(new_flags & flag) &&
> > +	    (old_flags & flag || old_flags & BATADV_UNINIT_FLAGS))
> > +		atomic_inc(flag_counter);
> > +	else if (new_flags & flag && !(old_flags & flag))
> > +		atomic_dec(flag_counter);
> > +}
> > +
> > +/**
> >   * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
> >   * @bat_priv: the bat priv with all the soft interface information
> >   * @orig: the orig_node of the ogm
> > @@ -285,13 +392,14 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
> >  	    (tvlv_value) && (tvlv_value_len == sizeof(mcast_flags)))
> >  		mcast_flags = *(uint8_t *)tvlv_value;
> >  
> > -	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
> > -	    (orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT ||
> > -	     orig->mcast_flags & BATADV_UNINIT_FLAGS))
> > -		atomic_inc(&bat_priv->mcast.num_no_mla);
> > -	else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
> > -		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT))
> > -		atomic_dec(&bat_priv->mcast.num_no_mla);
> > +	batadv_mcast_tvlv_update_flag_counter(
> > +					BATADV_MCAST_LISTENER_ANNOUNCEMENT,
> > +					&bat_priv->mcast.num_no_mla,
> > +					mcast_flags, orig->mcast_flags);
> > +	batadv_mcast_tvlv_update_flag_counter(
> > +					BATADV_MCAST_HAS_NO_BRIDGE,
> > +					&bat_priv->mcast.num_has_bridge,
> > +					mcast_flags, orig->mcast_flags);
> 
> You should find a shorter name, the alignment looks really ugly. :)

Oki doki, fair point :).

> 
> Cheers,
> 	Simon

Cheers, Linus
