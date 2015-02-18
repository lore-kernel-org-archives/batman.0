Return-Path: <martin@hundeboll.net>
Message-ID: <54E4CBFD.4000701@hundeboll.net>
Date: Wed, 18 Feb 2015 18:29:33 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1424280024-4262-1-git-send-email-sven@narfation.org>
In-Reply-To: <1424280024-4262-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Use safer default config
 for optional features
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
Cc: Sven Eckelmann <sven@narfation.org>

Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

On 2015-02-18 18:20, Sven Eckelmann wrote:
> The current default settings for optional features in batman-adv seems to=
 be
> based around the idea that the user only compiles what he requires. They =
will
> automatically enabled when they are compiled in. For example the network =
coding
> part of batman-adv is by default disabled in the out-of-tree module but w=
ill be
> enabled when the code is compiled during the module build.
>
> But distributions like Debian just enable all features of the batman-adv =
kernel
> module and hope that more experimental features or features with possible
> negative effects have to be enabled using some runtime configuration inte=
rface.
>
> The network_coding feature can help in specific setups but also has drawb=
acks
> and is not disabled by default in the out-of-tree module. Disabling by de=
fault
> in the runtime config seems to be also quite sane.
>
> The bridge_loop_avoidance is the only feature which is disabled by defaul=
t but
> may be necessary even in simple setups. Packet loops may even be created
> during the initial node setup when this is not enabled. This is different=
 than
> STP on bridges because mesh is usually used on Adhoc WiFi. Having two nod=
es
> (by accident) in the same LAN segment and in the same mesh network is rat=
her
> common in this situation.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> DAT is now removed from this patch because the discussion showed that it =
is
> preferred to have DAT enabled by default.
>
>   network-coding.c | 2 +-
>   soft-interface.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/network-coding.c b/network-coding.c
> index 127cc4d..be005b2 100644
> --- a/network-coding.c
> +++ b/network-coding.c
> @@ -155,7 +155,7 @@ err:
>    */
>   void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
>   {
> -	atomic_set(&bat_priv->network_coding, 1);
> +	atomic_set(&bat_priv->network_coding, 0);
>   	bat_priv->nc.min_tq =3D 200;
>   	bat_priv->nc.max_fwd_delay =3D 10;
>   	bat_priv->nc.max_buffer_time =3D 200;
> diff --git a/soft-interface.c b/soft-interface.c
> index 8748987..22254fb 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -738,7 +738,7 @@ static int batadv_softif_init_late(struct net_device =
*dev)
>   	atomic_set(&bat_priv->aggregated_ogms, 1);
>   	atomic_set(&bat_priv->bonding, 0);
>   #ifdef CONFIG_BATMAN_ADV_BLA
> -	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
> +	atomic_set(&bat_priv->bridge_loop_avoidance, 1);
>   #endif
>   #ifdef CONFIG_BATMAN_ADV_DAT
>   	atomic_set(&bat_priv->distributed_arp_table, 1);
>

--=20
Kind Regards,
Martin Hundeb=F8ll
Frederiks All=E9 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
