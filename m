Return-Path: <martin@hundeboll.net>
Message-ID: <5189D8BD.8070500@hundeboll.net>
Date: Wed, 08 May 2013 06:46:53 +0200
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1367925902-31578-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1367925902-31578-1-git-send-email-lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: check return value of
 pskb_trim_rcsum()
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

On 2013-05-07 13:25, Marek Lindner wrote:
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

> ---
>   network-coding.c |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/network-coding.c b/network-coding.c
> index f7c5430..e84629e 100644
> --- a/network-coding.c
> +++ b/network-coding.c
> @@ -1514,6 +1514,7 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat=
_priv, struct sk_buff *skb,
>   	struct ethhdr *ethhdr, ethhdr_tmp;
>   	uint8_t *orig_dest, ttl, ttvn;
>   	unsigned int coding_len;
> +	int err;
>
>   	/* Save headers temporarily */
>   	memcpy(&coded_packet_tmp, skb->data, sizeof(coded_packet_tmp));
> @@ -1568,8 +1569,11 @@ batadv_nc_skb_decode_packet(struct batadv_priv *ba=
t_priv, struct sk_buff *skb,
>   			 coding_len);
>
>   	/* Resize decoded skb if decoded with larger packet */
> -	if (nc_packet->skb->len > coding_len + h_size)
> -		pskb_trim_rcsum(skb, coding_len + h_size);
> +	if (nc_packet->skb->len > coding_len + h_size) {
> +		err =3D pskb_trim_rcsum(skb, coding_len + h_size);
> +		if (err)
> +			return NULL;
> +	}
>
>   	/* Create decoded unicast packet */
>   	unicast_packet =3D (struct batadv_unicast_packet *)skb->data;
>


--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
