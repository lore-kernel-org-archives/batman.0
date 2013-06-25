Return-Path: <linus.luessing@web.de>
Date: Tue, 25 Jun 2013 14:55:08 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130625125508.GA20017@Linus-Debian>
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
 <1371232209-7808-2-git-send-email-linus.luessing@web.de>
 <201306250547.20341.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201306250547.20341.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/3] batman-adv: Multicast Listener
 Announcements via Translation Table
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

Hi Marec,

On Tue, Jun 25, 2013 at 05:47:20AM +0800, Marek Lindner wrote:
> On Saturday, June 15, 2013 01:50:07 Linus Lüssing wrote:
> > With this patch a node which has no bridge interface on top of its soft
> > interface announces its local multicast listeners via the translation
> > table.
> > 
> > Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> > ---
> >  Makefile               |    2 +
> >  Makefile.kbuild        |    1 +
> >  compat.h               |   20 ++++-
> >  gen-compat-autoconf.sh |    1 +
> >  main.c                 |    6 ++
> >  main.h                 |    1 +
> >  multicast.c            |  210
> > ++++++++++++++++++++++++++++++++++++++++++++++++ multicast.h            | 
> >  43 ++++++++++
> >  soft-interface.c       |    3 +
> >  sysfs.c                |    6 ++
> >  translation-table.c    |   22 ++++-
> >  types.h                |   12 +++
> >  12 files changed, 322 insertions(+), 5 deletions(-)
> >  create mode 100644 multicast.c
> >  create mode 100644 multicast.h
> > 
> > diff --git a/Makefile b/Makefile
> > index 407cdc4..d7c6fa6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -27,6 +27,8 @@ export CONFIG_BATMAN_ADV_BLA=y
> >  export CONFIG_BATMAN_ADV_DAT=y
> >  # B.A.T.M.A.N network coding (catwoman):
> >  export CONFIG_BATMAN_ADV_NC=n
> > +# B.A.T.M.A.N. multicast optimizations:
> > +export CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS=y
> 
> Can we please find a shorter define ? How about "CONFIG_BATMAN_ADV_MCAST" ? 
> That would be in line with the rest.

Hm, yes I also don't like the length of that so much. But I had
dismissed "CONFIG_BATMAN_ADV_MCAST" so far because I thought it
might seem as if batman-adv were not able to handle multicast at
all without that option.

What about CONFIG_BATMAN_ADV_MCAST_OPT (hm, that could suggest
'optional', too...) or CONFIG_BATMAN_ADV_MCO?

.oO(also don't sound as nice as the other CONFIG_ exports...)

Ok, maybe CONFIG_BATMAN_ADV_MCAST is still the best option. I'll
change it to that.

> 
> 
> > +struct batadv_hw_addr {
> > +	struct list_head	list;
> > +	unsigned char addr[ETH_ALEN];
> > +};
> 
> All struct defines should go into types.h or packet.h if they are sent over 
> the wire.

This struct isn't sent over the wire, it's just for local book
keeping. I was thinking about naming it 'struct batadv_mcast_hw_addr'
but didn't do that because it is so generic and thought maybe
because of that it might be reusable in the future.

Hm, maybe it's better to rename it to 'struct
batadv_mcast_hw_addr' anyways and leave it in that place to avoid
bloating types.h/packet.h with "unimportant" structs and defines?

> 
> 
> > +/**
> > + * batadv_mcast_mla_tt_update - update the own MLAs
> > + * @bat_priv: the bat priv with all the soft interface information
> > + *
> > + * Update the own multicast listener announcements in the translation
> > + * table. Also take care of registering or unregistering the multicast
> > + * tvlv depending on whether the user activated or deactivated
> > + * multicast optimizations.
> > + */
> > +void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
> > +{
> > +	struct net_device *soft_iface = bat_priv->soft_iface;
> > +	struct list_head mcast_list;
> > +	int ret;
> > +	static bool enabled;
> > +
> > +	INIT_LIST_HEAD(&mcast_list);
> > +
> > +	/* Avoid attaching MLAs, if multicast optimization is disabled
> > +	 * or there is a bridge on top of our soft interface (TODO)
> > +	 */
> > +	if (!atomic_read(&bat_priv->mcast_group_awareness) ||
> > +	    bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
> > +		if (enabled)
> > +			enabled = false;
> > +
> > +		goto update;
> > +	}
> > +
> > +	if (!enabled)
> > +		enabled = true;
> > +
> > +	ret = batadv_mcast_mla_local_collect(soft_iface, &mcast_list);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +update:
> > +	batadv_mcast_mla_tt_clean(bat_priv, &mcast_list);
a> > +	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
> > +
> > +out:
> > +	batadv_mcast_mla_collect_free(&mcast_list);
> > +}
> 
> You can use the LIST_HEAD static initializer.

Ah, indeed, will change that.

> The "enabled" variable does not make any sense.

Woops, indeed, makes more sense in [PATCH 2/3], I'll move it
there.

> 
> How about we change some function names for the sake of clarity ? Here my 
> suggestions:
> 
>  * batadv_mcast_mla_local_collect() => batadv_mcast_mla_softif_retrieve() or 
> batadv_mcast_mla_softif_get()

Sounds good, I like the latter very much (I was using the terms
local, bridge, global - but yes, our own bridge is also kind of
local, so softif is better :) ).

>  * batadv_mcast_mla_tt_clean() => batadv_mcast_mla_tt_retract()

Hm, I think I'd find that a little confusing when reading a
batadv_mcast_mla_tt_retract(bat_priv, mcast_list) in the code
somewhere because I'd think that the things provided by mcast_list
were going to get retracted. batadv_mcast_mla_tt_clean(bat_priv,
mcast_list) would feel more like dusting the table while the
given argument provides the list of valuable items on the table
which you are taking special care of, which you don't want to
accidentally knock over :) (in my opinion).

>  * batadv_mcast_mla_collect_free() => batadv_mcast_mla_list_free()

Sounds good!

> 
> 
> > +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> > +struct batadv_priv_mcast {
> > +	struct list_head mla_list;
> > +};
> > +#endif
> 
> I don't see a good reason to use a double linked list or is there one ?

No, you're right, currently we don't need a double linked list head.
I'll change it to an HLIST.


Thanks for all the feedback so far!

> 
> Cheers,
> Marek

Cheers, Linus
