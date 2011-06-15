Return-Path: <ordex@autistici.org>
Date: Thu, 16 Jun 2011 00:43:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110615224355.GA15320@ritirata.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
	<1307307664-19910-2-git-send-email-ordex@autistici.org>
	<201106152328.29223.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201106152328.29223.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: detect clients connected
 through a 802.11 device
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On mer, giu 15, 2011 at 11:28:28 +0200, Marek Lindner wrote:
> On Sunday, June 05, 2011 11:01:02 PM Antonio Quartulli wrote:
> > +/* This function returns true if the interface represented by ifindex is a
> > + * 802.11 wireless device */
> > +bool is_wifi_iface(int ifindex)
> > +{
> > +       struct net_device *net_device;
> > +
> > +       if (ifindex == NULL_IFINDEX)
> > +               return false;
> > +
> > +       net_device = dev_get_by_index(&init_net, ifindex);
> > +       if (!net_device)
> > +               return false;
> > +
> > +#ifdef CONFIG_WIRELESS_EXT
> > +       /* pre-cfg80211 drivers have to implement WEXT, so it is possible to
> > +        * check for wireless_handlers != NULL */
> > +       if (net_device->wireless_handlers)
> > +               return true;
> > +       else
> > +#endif
> > +               /* cfg80211 drivers have to set ieee80211_ptr */
> > +               if (net_device->ieee80211_ptr)
> > +                       return true;
> > +       return false;
> > +}
> 
> If I am not mistaken dev_get_by_index() increases a counter on the returned 
> interface. We have to decrease that counter as soon as we don't need the 
> interface anymore otherwise the interface can never be freed.

Definitely right!

> 
> 
> > @@ -108,7 +108,7 @@ int mesh_init(struct net_device *soft_iface)
> >  	if (tt_init(bat_priv) < 1)
> >  		goto err;
> > 
> > -	tt_local_add(soft_iface, soft_iface->dev_addr);
> > +	tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
> 
> Are you sure 0 is not a valid index for any interface ?

Yes. You can also check the function dev_new_index() at
http://lxr.linux.no/linux+v2.6.39/net/core/dev.c#L5080
indexes start from 1 :)

> 
> 
> >  static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
> > -			   const uint8_t *addr, bool roaming)
> > +			   const uint8_t *addr, bool roaming, bool wifi)
> 
> How about adding a set of flags (TT_CLIENT_ROAM / TT_CLIENT_WIFI / etc) 
> instead of adding more and more bool arguments ? In several places the code 
> converts one to the other which does not seem necessary.

You mean simply passing a int value which is combination of the used
flags? mught be a good idea, even for further changes.

> 
> 
> > +void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
> > +		  int ifindex)
> >  {
> >  	struct bat_priv *bat_priv = netdev_priv(soft_iface);
> >  	struct tt_local_entry *tt_local_entry = NULL;
> > @@ -204,21 +231,22 @@ void tt_local_add(struct net_device *soft_iface,
> > const uint8_t *addr) if (!tt_local_entry)
> >  		goto out;
> > 
> > -	tt_local_event(bat_priv, NO_FLAGS, addr, false);
> > -
> >  	bat_dbg(DBG_TT, bat_priv,
> >  		"Creating new local tt entry: %pM (ttvn: %d)\n", addr,
> >  		(uint8_t)atomic_read(&bat_priv->ttvn));
> > 
> >  	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
> >  	tt_local_entry->last_seen = jiffies;
> > +	tt_local_entry->flags = 0;
> 
> Here you should make use of the NO_FLAGS define you introduced.  :-)

Right :)

> 
> 
> >  	/* the batman interface mac address should never be purged */
> >  	if (compare_eth(addr, soft_iface->dev_addr))
> > -		tt_local_entry->never_purge = 1;
> > -	else
> > -		tt_local_entry->never_purge = 0;
> > +		tt_local_entry->flags |= TT_LOCAL_NOPURGE;
> > +
> > +	tt_local_event(bat_priv, NO_FLAGS, addr, false,
> > +		       tt_local_entry->flags & TT_CLIENT_WIFI);
> 
> Changing "never_purge" to a flag probably is a good idea but should go into a 
> separate patch.

Ok, I'll propose a separated patch.

Thank you for reviewing!

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
