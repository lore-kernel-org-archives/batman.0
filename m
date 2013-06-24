Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Jun 2013 05:47:20 +0800
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
 <1371232209-7808-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1371232209-7808-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201306250547.20341.lindner_marek@yahoo.de>
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

On Saturday, June 15, 2013 01:50:07 Linus L=C3=BCssing wrote:
> With this patch a node which has no bridge interface on top of its soft
> interface announces its local multicast listeners via the translation
> table.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  Makefile               |    2 +
>  Makefile.kbuild        |    1 +
>  compat.h               |   20 ++++-
>  gen-compat-autoconf.sh |    1 +
>  main.c                 |    6 ++
>  main.h                 |    1 +
>  multicast.c            |  210
> ++++++++++++++++++++++++++++++++++++++++++++++++ multicast.h            |=
=20
>  43 ++++++++++
>  soft-interface.c       |    3 +
>  sysfs.c                |    6 ++
>  translation-table.c    |   22 ++++-
>  types.h                |   12 +++
>  12 files changed, 322 insertions(+), 5 deletions(-)
>  create mode 100644 multicast.c
>  create mode 100644 multicast.h
>=20
> diff --git a/Makefile b/Makefile
> index 407cdc4..d7c6fa6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,6 +27,8 @@ export CONFIG_BATMAN_ADV_BLA=3Dy
>  export CONFIG_BATMAN_ADV_DAT=3Dy
>  # B.A.T.M.A.N network coding (catwoman):
>  export CONFIG_BATMAN_ADV_NC=3Dn
> +# B.A.T.M.A.N. multicast optimizations:
> +export CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS=3Dy

Can we please find a shorter define ? How about "CONFIG_BATMAN_ADV_MCAST" ?=
=20
That would be in line with the rest.


> +struct batadv_hw_addr {
> +	struct list_head	list;
> +	unsigned char addr[ETH_ALEN];
> +};

All struct defines should go into types.h or packet.h if they are sent over=
=20
the wire.


> +/**
> + * batadv_mcast_mla_tt_update - update the own MLAs
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Update the own multicast listener announcements in the translation
> + * table. Also take care of registering or unregistering the multicast
> + * tvlv depending on whether the user activated or deactivated
> + * multicast optimizations.
> + */
> +void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
> +{
> +	struct net_device *soft_iface =3D bat_priv->soft_iface;
> +	struct list_head mcast_list;
> +	int ret;
> +	static bool enabled;
> +
> +	INIT_LIST_HEAD(&mcast_list);
> +
> +	/* Avoid attaching MLAs, if multicast optimization is disabled
> +	 * or there is a bridge on top of our soft interface (TODO)
> +	 */
> +	if (!atomic_read(&bat_priv->mcast_group_awareness) ||
> +	    bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
> +		if (enabled)
> +			enabled =3D false;
> +
> +		goto update;
> +	}
> +
> +	if (!enabled)
> +		enabled =3D true;
> +
> +	ret =3D batadv_mcast_mla_local_collect(soft_iface, &mcast_list);
> +	if (ret < 0)
> +		goto out;
> +
> +update:
> +	batadv_mcast_mla_tt_clean(bat_priv, &mcast_list);
> +	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
> +
> +out:
> +	batadv_mcast_mla_collect_free(&mcast_list);
> +}

You can use the LIST_HEAD static initializer.
The "enabled" variable does not make any sense.

How about we change some function names for the sake of clarity ? Here my=20
suggestions:

 * batadv_mcast_mla_local_collect() =3D> batadv_mcast_mla_softif_retrieve()=
 or=20
batadv_mcast_mla_softif_get()
 * batadv_mcast_mla_tt_clean() =3D> batadv_mcast_mla_tt_retract()
 * batadv_mcast_mla_collect_free() =3D> batadv_mcast_mla_list_free()


> +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> +struct batadv_priv_mcast {
> +	struct list_head mla_list;
> +};
> +#endif

I don't see a good reason to use a double linked list or is there one ?

Cheers,
Marek
