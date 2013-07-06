Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 6 Jul 2013 18:57:44 +0800
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
 <1372889002-6767-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1372889002-6767-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201307061857.44563.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, July 04, 2013 06:03:20 Linus L=C3=BCssing wrote:
> diff --git a/multicast.c b/multicast.c
> index 7ea19ab..4af4bc9 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -169,13 +169,30 @@ void batadv_mcast_mla_tt_update(struct batadv_priv
> *bat_priv) struct net_device *soft_iface =3D bat_priv->soft_iface;
>         struct hlist_head mcast_list =3D HLIST_HEAD_INIT;
>         int ret;
> +       static bool enabled;
> +       uint8_t mcast_flags;
> =20
>         /* Avoid attaching MLAs, if multicast optimization is disabled
>          * or there is a bridge on top of our soft interface (TODO)
>          */
>         if (!atomic_read(&bat_priv->multicast_mode) ||
> -           bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT)
> +           bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
> +               if (enabled) {
> +                       batadv_tvlv_container_unregister(bat_priv,
> +                                                        BATADV_TVLV_MCAS=
T,
> 1); +                       enabled =3D false;
> +               }
> +
>                 goto update;
> +       }
> +
> +       if (!enabled) {
> +               mcast_flags =3D BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> +               batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAS=
T,
> 1, +                                              &mcast_flags,
> +                                              sizeof(mcast_flags));
> +               enabled =3D true;
> +       }
> =20
>         ret =3D batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
>         if (ret < 0)

Is there no better way than using a static variable ? Apart from bad=20
readibility this totally breaks when using several batX interfaces with=20
different settings.


> +/* multicast capabilities */
> +enum batadv_mcast_flags {
> +       BATADV_MCAST_LISTENER_ANNOUNCEMENT =3D BIT(0),
> +};

Didn't we discuss that using feature names is better ? We talked about thin=
gs=20
like UNICAST, TRACKER, etc ?

Cheers,
Marek
