Return-Path: <linus.luessing@web.de>
Date: Sat, 6 Jul 2013 14:38:16 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130706123816.GA8562@Linus-Debian>
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
 <1372889002-6767-3-git-send-email-linus.luessing@web.de>
 <201307061857.44563.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201307061857.44563.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 2/4] batman-adv: Announce new
 capability via multicast TVLV
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sat, Jul 06, 2013 at 06:57:44PM +0800, Marek Lindner wrote:
> On Thursday, July 04, 2013 06:03:20 Linus Lüssing wrote:
> > diff --git a/multicast.c b/multicast.c
> > index 7ea19ab..4af4bc9 100644
> > --- a/net/batman-adv/multicast.c
> > +++ b/net/batman-adv/multicast.c
> > @@ -169,13 +169,30 @@ void batadv_mcast_mla_tt_update(struct batadv_priv
> > *bat_priv) struct net_device *soft_iface = bat_priv->soft_iface;
> >         struct hlist_head mcast_list = HLIST_HEAD_INIT;
> >         int ret;
> > +       static bool enabled;
> > +       uint8_t mcast_flags;
> >  
> >         /* Avoid attaching MLAs, if multicast optimization is disabled
> >          * or there is a bridge on top of our soft interface (TODO)
> >          */
> >         if (!atomic_read(&bat_priv->multicast_mode) ||
> > -           bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT)
> > +           bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
> > +               if (enabled) {
> > +                       batadv_tvlv_container_unregister(bat_priv,
> > +                                                        BATADV_TVLV_MCAST,
> > 1); +                       enabled = false;
> > +               }
> > +
> >                 goto update;
> > +       }
> > +
> > +       if (!enabled) {
> > +               mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> > +               batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST,
> > 1, +                                              &mcast_flags,
> > +                                              sizeof(mcast_flags));
> > +               enabled = true;
> > +       }
> >  
> >         ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
> >         if (ret < 0)
> 
> Is there no better way than using a static variable ? Apart from bad 
> readibility this totally breaks when using several batX interfaces with 
> different settings.

Ah, right, didn't think of multiple batX interfaces, that's a bug
indeed. I'm going to fix that.

What do you think about adding new tvlv API like:

---
bool batadv_tvlv_container_is_registered(struct batadv_priv *bat_priv,
					 uint8_t type, uint8_t version)
{
	struct batadv_tvlv_container *tvlv;
	bool ret;

	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
	tvlv = batadv_tvlv_container_get(bat_priv, type, version);
	ret = tvlv ? true : false;
	batadv_tvlv_container_free_ref(tvlv);
	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);

	return ret;
}
----

The disadvantage is that this is a little heavier as it will
perform a list lookup and holds a spin-lock.

If we were going to use something like bat_priv->mcast.tvlv_container_enabled
instead, that would be lighter but less readable.

> 
> 
> > +/* multicast capabilities */
> > +enum batadv_mcast_flags {
> > +       BATADV_MCAST_LISTENER_ANNOUNCEMENT = BIT(0),
> > +};
> 
> Didn't we discuss that using feature names is better ? We talked about things 
> like UNICAST, TRACKER, etc ?

Hm, I only remember discussing the name for sysfs. For the flags
I thought we were only using UNICAST, TRACKER, etc. as
abbreviations for the current names in our IRC discussion, I didn't
interpret that as a suggestion to change these names.

Anyways, let's discuss a renaming of the flags then. I don't like a change
like:

BATADV_MCAST_LISTENER_ANNOUNCEMENT -> BATADV_MCAST_UNICAST

Because for one thing, it isn't up to the node announcing this
flag to deceide whether another, sending node is able use unicast.
Whether unicast can be used depends on a lot more factors.

For another thing this flag is not only adding a unicast feature if
all these factors are met, but also adds the dropping feature
introduced by this patchset.

I'd rather keep the naming for the multicast flags to reflect the
capabilities and settings of the local, announcing node.

Cheers, Linus
