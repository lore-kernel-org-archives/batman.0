Return-Path: <linus.luessing@web.de>
Date: Wed, 18 Jun 2014 00:24:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140617222414.GG29033@Linus-Debian>
References: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
 <1982917.uLe1stfMfi@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1982917.uLe1stfMfi@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast optimization
 support for bridged setups
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

On Tue, Jun 17, 2014 at 10:50:34PM +0800, Marek Lindner wrote:
> On Thursday 12 June 2014 02:00:27 Linus Lüssing wrote:
> > -	netif_addr_lock_bh(dev);
> > +	netif_addr_lock_bh(bridge ? bridge : dev);
> >  	netdev_for_each_mc_addr(mc_list_entry, dev) {
> >  		new = kmalloc(sizeof(*new), GFP_ATOMIC);
> >  		if (!new) {
> 
> Maybe I am missing something but shouldn't we fetch the entries from the 
> bridge interface instead of dev ?

Ups, right, good catch! The 'netdev_for_each...' should be for "bridge",
not "dev" if "bridge" exists.

> > +static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip
> > *src) +{
> > +	if (src->proto == htons(ETH_P_IP)) {
> > +		/* RFC 1112 */
> > +		memcpy(dst, "\x01\x00\x5e", 3);
> > +		memcpy(dst + 3, ((char *)&src->u.ip4) + 1, ETH_ALEN - 3);
> > +		dst[3] &= 0x7F;
> > +	}
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	else if (src->proto == htons(ETH_P_IPV6)) {
> > +		/* RFC 2464 */
> > +		memcpy(dst, "\x33\x33", 2);
> > +		memcpy(dst + 2, &src->u.ip6.s6_addr32[3],
> > +		       sizeof(src->u.ip6.s6_addr32[3]));
> > +	}
> > +#endif
> > +	else
> > +		memset(dst, 0, ETH_ALEN);
> > +}
> 
> Is there no cleaner way to do this ? "\x01\x00\x5e" and "\x33\x33" looks 
> pretty hackish. Are there no defines for mcast prefixes somewhere ?

Oh, indeed there is: The bridge code pointed me to
"ip_eth_mc_map()" and "ipv6_eth_mc_map()", making that a one-liner
each :).

> 
> 
> > +/**
> > + * batadv_mcast_mla_bridge_get - get bridged-in multicast listeners
> > + * @dev: a bridge slave whose bridge to collect multicast addresses from
> > + * @mcast_list: a list to put found addresses into
> > + *
> > + * Collects multicast addresses of the bridged-in multicast listeners
> > + * from the bridge on top of the given soft interface, dev, in the
> > + * given mcast_list.
> > + *
> > + * Returns -ENOMEM on memory allocation error or the number of
> > + * items added to the mcast_list otherwise.
> > + */
> > +static int batadv_mcast_mla_bridge_get(struct net_device *dev,
> > +				       struct hlist_head *mcast_list)
> > +{
> 
> That is probably where my confusion is coming from. Why do we query the bridge 
> interface again ?

A batman-adv node needs to know on/behind which other batman-adv
node a multicast listener exists to be able to know where it needs
to forward multicast packets to. A multicast listener can either
sit on bat0, on a bridge on top of bat0. Or in this case, that's
what "mla_bridge_get" is for, behind the bridge.

We usually don't have direct access to the kernel of weird Windows
machines behind a bridge. Luckily a protocol, Multicast Listener
Discovery, exists to detect such multicast listeners.

The bridge code has multicast snooping already, so it already
memorizes what multicast listeners it has behind it's bridge.
That's what we are fetching here. To add these to our local TT to
announce them through the mesh.

> 
> 
> > @@ -195,19 +306,18 @@ static bool batadv_mcast_mla_tvlv_update(struct
> > batadv_priv *bat_priv) mcast_data.flags = BATADV_NO_FLAGS;
> >  	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
> > 
> > -	/* Avoid attaching MLAs, if there is a bridge on top of our soft
> > -	 * interface, we don't support that yet (TODO)
> > -	 */
> > -	if (batadv_mcast_has_bridge(bat_priv)) {
> > -		if (bat_priv->mcast.enabled) {
> > -			batadv_tvlv_container_unregister(bat_priv,
> > -							 BATADV_TVLV_MCAST, 1);
> > -			bat_priv->mcast.enabled = false;
> > -		}
> > +	if (!batadv_mcast_has_bridge(bat_priv))
> > +		goto skip;
> > 
> > -		return false;
> > -	}
> > +	mcast_data.flags |= BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
> > +
> > +	if (br_multicast_has_querier_adjacent(bat_priv->soft_iface, ETH_P_IP))
> > +		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV4;
> > 
> > +	if (br_multicast_has_querier_adjacent(bat_priv->soft_iface, ETH_P_IPV6))
> > +		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV6;
> > +
> > +skip:
> >  	if (!bat_priv->mcast.enabled ||
> >  	    mcast_data.flags != bat_priv->mcast.flags) {
> >  		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
> 
> Please find a more intuitive goto label ('skip' is quite generic).

Oki doki, good point.

> 
> 
> > @@ -233,13 +344,17 @@ void batadv_mcast_mla_update(struct batadv_priv
> > *bat_priv) int ret;
> > 
> >  	if (!batadv_mcast_mla_tvlv_update(bat_priv))
> > -		goto update;
> > +		goto skip;
> > 
> >  	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
> >  	if (ret < 0)
> >  		goto out;
> > 
> > -update:
> > +	ret = batadv_mcast_mla_bridge_get(soft_iface, &mcast_list);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +skip:
> >  	batadv_mcast_mla_tt_retract(bat_priv, &mcast_list);
> >  	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
> 
> Again, 'skip' isn't very self-explanatory.

K, right!

> 
> Cheers,
> Marek
> 

Cheers, Linus
