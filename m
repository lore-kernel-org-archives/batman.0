Return-Path: <martin@hundeboll.net>
Message-ID: <5189E7E2.9010203@hundeboll.net>
Date: Wed, 08 May 2013 07:51:30 +0200
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1367991380-30270-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1367991380-30270-1-git-send-email-lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: consider network coding
 overhead when calculating required mtu
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On 2013-05-08 07:36, Marek Lindner wrote:
> The module prints a warning when the MTU on the hard interface is too
> small to transfer payload traffic without fragmentation. The required
> MTU is calculated based on the encapsulation header size. If network
> coding is compild into the module its header size is taken into
> account as well.
>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

> ---
>   types.h |    7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/types.h b/types.h
> index b2c94e1..8089bd6 100644
> --- a/types.h
> +++ b/types.h
> @@ -27,9 +27,16 @@
>   /**
>    * Maximum overhead for the encapsulation for a payload packet
>    */
> +#ifdef CONFIG_BATMAN_ADV_NC
> +#define BATADV_HEADER_LEN \
> +	(ETH_HLEN + max3(sizeof(struct batadv_unicast_packet), \
> +			 sizeof(struct batadv_bcast_packet),   \
> +			 sizeof(struct batadv_coded_packet)))
> +#else
>   #define BATADV_HEADER_LEN \
>   	(ETH_HLEN + max(sizeof(struct batadv_unicast_packet), \
>   			sizeof(struct batadv_bcast_packet)))
> +#endif /* CONFIG_BATMAN_ADV_NC */
>
>   #ifdef CONFIG_BATMAN_ADV_DAT
>
>


--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
