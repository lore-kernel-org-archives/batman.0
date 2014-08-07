Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 7 Aug 2014 20:02:09 +0200
References: <1406673579-20110-1-git-send-email-linus.luessing@web.de>
 <1406673579-20110-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1406673579-20110-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201408072002.09659.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 2/3] batman-adv: Adding 'mcast' log
	level
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
To: b.a.t.m.a.n@lists.open-mesh.org

Sorry, it seems the quotation is a little messed up, but I hope you can=20
understand the rest:

> This patch adds an 'mcast' log level. Currently, it will print changes
> relevant to a nodes own multicast flag changes.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  multicast.c      |  152
> ++++++++++++++++++++++++++++++++++++++++++++++++++++-- soft-interface.c |=
=20
>   5 ++
>  types.h          |   17 ++++++
>  3 files changed, 169 insertions(+), 5 deletions(-)
>=20
> diff --git a/multicast.c b/multicast.c
> index c05f64a..2a80997 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -292,6 +292,123 @@ static bool batadv_mcast_has_bridge(struct
> batadv_priv *bat_priv) }
>=20
>  /**
> + * batadv_mcast_querier_log - debug output regarding the querier status =
on
> link + * @bat_priv: the bat priv with all the soft interface information +
> * @str_proto: a string for the querier protocol (e.g. "IGMP" or "MLD") + *
> @old_querier: the previous querier state on our link
> + * @new_querier: the new querier state on our link

I think changing the variable name from old/new_querier to old/new_state wo=
uld=20
make this part more understandable - there are not two different queriers=20
after all, just their state changes.
> + *
> + * Outputs debug messages to the logging facility with log level 'mcast'
> + * regarding changes to the querier status on the link which are relevant
> + * to our multicast optimizations.
> + *
> + * Usually this is about whether a querier appeared or vanished in
> + * our mesh or whether the querier is in the suboptimal position of being
> + * behind our local bridge segment.

Maybe it would be good to briefly explain at that point again why it's=20
suboptimal?

> + *
> + * This is only interesting for nodes with a bridge on top of their
> + * soft interface.
> + */
> +static void
> +batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
> +			 struct batadv_mcast_querier_state *old_querier,
> +			 struct batadv_mcast_querier_state *new_querier)
> +{
> +	if (!old_querier->exists && new_querier->exists)
> +		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +			   "%s Querier appeared (good!)\n", str_proto);
> +	else if (old_querier->exists && !new_querier->exists)
> +		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +			   "%s Querier disappeared (bad)\n", str_proto);
> +	else if (!bat_priv->mcast.bridged && !new_querier->exists)
> +		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +			   "Note: No %s Querier present\n", str_proto);
> +
> +	if (!new_querier->exists)
> +		return;
> +
> +	if (!old_querier->shadowing && new_querier->shadowing)
> +		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +			   "%s Querier is behind our bridged segment: Might shadow=20
listeners
> (bad)\n", +			   str_proto);
> +	else if (old_querier->shadowing && !new_querier->shadowing)
> +		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +			   "%s Querier is not behind our bridged segment (good!)\n",
> +			   str_proto);

I'm not sure if good/bad is really useful to write here - at least we don't=
=20
really tell why its good or bad?=20

> [...]
> +/**
> + * batadv_mcast_flags_logs - output debug information about mcast flag
> changes + * @bat_priv: the bat priv with all the soft interface
> information + * @mcast_flags: flags indicating the new multicast state
> + *
> + * Whenever the multicast flags this nodes announces changes (@mcast_fla=
gs
> vs. + * bat_priv->mcast.flags), this notifies userspace via the 'mcast'
> log level. + */
> +static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, uint8_t
> flags) +{
> +	char str_undefined[] =3D "<undefined>";
> +	char str_flags[] =3D "[...]";
> +	char *str_flags_old =3D str_undefined;

Can't you write str_flags_old =3D "<undefined>" directly? why that indirect=
ion?
> +	uint8_t old_flags =3D bat_priv->mcast.flags;
> +
> +	if (!bat_priv->mcast.enabled)
> +		goto print;
> +
> +	str_flags_old =3D str_flags;
> +
> +	sprintf(str_flags_old, "[%c%c%c]",
> +		old_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
> +		old_flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
> +		old_flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');

Ah, you want to reuse this buffer? hmm ...
> +
> +print:
> +	batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +		   "Changing multicast flags from '%s' to '[%c%c%c]'\n",
> +		   str_flags_old,
> +		   flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
> +		   flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
> +		   flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');

I think this overly complex to do.=20

How about always writing str_flags_old accoding to old flags, but then do:

batadv_dbg(BATADV_DBG_MCAST, bat_priv,
		   "Changing multicast flags from '%s' to '[%c%c%c]'\n",
		   bat_priv->mcast.enabled ? str_flags_old : "<undefined>",
		   flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
		   flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
		   flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
> +}
> +
> +/**
>   * batadv_mcast_mla_tvlv_update - update multicast tvlv
>   * @bat_priv: the bat priv with all the soft interface information
>   *
> @@ -304,18 +421,33 @@ static bool batadv_mcast_has_bridge(struct
> batadv_priv *bat_priv) static bool batadv_mcast_mla_tvlv_update(struct
> batadv_priv *bat_priv) {
>  	struct batadv_tvlv_mcast_data mcast_data;
> +	struct batadv_mcast_querier_state querier_ipv4, querier_ipv6;
>  	struct net_device *dev =3D bat_priv->soft_iface;
> +	bool bridged;
>=20
>  	mcast_data.flags =3D BATADV_NO_FLAGS;
>  	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
> +	memset(&querier_ipv4, 0, sizeof(querier_ipv4));
> +	memset(&querier_ipv6, 0, sizeof(querier_ipv6));

since it just has two elements, you could do that above in the initializati=
on:

struct batadv_mcast_querier_state querier_ipv4 =3D {false, false};
struct batadv_mcast_querier_state querier_ipv6 =3D {false, false};

>=20
> -	if (!batadv_mcast_has_bridge(bat_priv))
> +	bridged =3D batadv_mcast_has_bridge(bat_priv);
> +	if (!bridged)
>  		goto update;
>=20
>  #if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
>  	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations
> disabled\n"); #endif
>=20
> +	querier_ipv4 =3D (struct batadv_mcast_querier_state){
> +		.exists =3D br_multicast_has_querier_anywhere(dev, ETH_P_IP),
> +		.shadowing =3D br_multicast_has_querier_adjacent(dev, ETH_P_IP),
> +	};
> +
> +	querier_ipv6 =3D (struct batadv_mcast_querier_state){
> +		.exists =3D br_multicast_has_querier_anywhere(dev, ETH_P_IPV6),
> +		.shadowing =3D br_multicast_has_querier_adjacent(dev, ETH_P_IPV6),
> +	};
> +

That would be shorter and more readable by just writing:

querier_ipv4.exists =3D br_multicast_has_querier_anywhere(dev, ETH_P_IP);
querier_ipv4.shadowing =3D br_multicast_has_querier_adjacent(dev, ETH_P_IP);

querier_ipv6.exists =3D br_multicast_has_querier_anywhere(dev, ETH_P_IPV6);
querier_ipv6.shadowing =3D br_multicast_has_querier_adjacent(dev, ETH_P_IPV=
6);

>  	mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
>=20
>  	/* 1) If no querier exists at all, then multicast listeners on
> @@ -327,21 +459,31 @@ static bool batadv_mcast_mla_tvlv_update(struct
> batadv_priv *bat_priv) * In both cases, we will signalize other batman
> nodes that
>  	 * we need all multicast traffic of the according protocol.
>  	 */
> -	if (!br_multicast_has_querier_anywhere(dev, ETH_P_IP) ||
> -	    br_multicast_has_querier_adjacent(dev, ETH_P_IP))
> +	if (!querier_ipv4.exists || querier_ipv4.shadowing)
>  		mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_IPV4;
>=20
> -	if (!br_multicast_has_querier_anywhere(dev, ETH_P_IPV6) ||
> -	    br_multicast_has_querier_adjacent(dev, ETH_P_IPV6))
> +	if (!querier_ipv6.exists || querier_ipv6.shadowing)
>  		mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_IPV6;
>=20
>  update:
> +	batadv_mcast_bridge_log(bat_priv, bridged, &querier_ipv4,
> +				&querier_ipv6);
> +
> +	if (memcmp(&bat_priv->mcast.querier_ipv4, &querier_ipv4,
> +		   sizeof(querier_ipv4)))
> +		bat_priv->mcast.querier_ipv4 =3D querier_ipv4;
> +	if (memcmp(&bat_priv->mcast.querier_ipv6, &querier_ipv6,
> +		   sizeof(querier_ipv6)))
> +		bat_priv->mcast.querier_ipv6 =3D querier_ipv6;
> +

Why comparing and then assigning? You could assign always instead, that sho=
uld=20
eventually not cost more than this construction.

>  	if (!bat_priv->mcast.enabled ||
>  	    mcast_data.flags !=3D bat_priv->mcast.flags) {
> +		batadv_mcast_flags_log(bat_priv, mcast_data.flags);
>  		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
>  					       &mcast_data, sizeof(mcast_data));
>  		bat_priv->mcast.flags =3D mcast_data.flags;
>  		bat_priv->mcast.enabled =3D true;
> +		bat_priv->mcast.bridged =3D bridged;
>  	}
>=20
>  	return !(mcast_data.flags &
> diff --git a/soft-interface.c b/soft-interface.c
> index 9bf382d..0265a58 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -745,7 +745,12 @@ static int batadv_softif_init_late(struct net_device
> *dev) atomic_set(&bat_priv->distributed_arp_table, 1);
>  #endif
>  #ifdef CONFIG_BATMAN_ADV_MCAST
> +	bat_priv->mcast.querier_ipv4 =3D (struct batadv_mcast_querier_state){
> +		.exists =3D false, .shadowing =3D false };
> +	bat_priv->mcast.querier_ipv6 =3D (struct batadv_mcast_querier_state){
> +		.exists =3D false, .shadowing =3D false };

yet again, just do:

bat_priv->mcast.querier_ipv4.exists =3D false;
bat_priv->mcast.querier_ipv4.shadowing =3D false;
bat_priv->mcast.querier_ipv6.exists =3D false;
bat_priv->mcast.querier_ipv6.shadowing =3D false;

[...]
Cheers,
     Simon
