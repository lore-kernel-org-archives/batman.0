Return-Path: <antonio@meshcoding.com>
Message-ID: <539AAA10.8030603@meshcoding.com>
Date: Fri, 13 Jun 2014 09:36:48 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1402512191-14922-1-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1402512191-14922-1-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LRaB5selV3kEfQgmdomuOCFRHFp2tHJf6"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: drop QinQ claim frames in
 bridge loop avoidance
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
To: Simon Wunderlich <simon@open-mesh.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LRaB5selV3kEfQgmdomuOCFRHFp2tHJf6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 11/06/14 20:43, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> Since bridge loop avoidance only supports untagged or simple 802.1q
> tagged VLAN claim frames, claim frames with stacked VLAN headers (QinQ)=

> should be detected and dropped. Transporting the over the mesh may caus=
e
> problems on the receivers, or create bogus entries in the local tt
> tables.
>=20
> Reported-by: Antonio Quartulli <antonio@open-mesh.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  bridge_loop_avoidance.c | 84 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 84 insertions(+)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index 6f0d9ec..75274f7 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -851,6 +851,75 @@ static int batadv_check_claim_group(struct batadv_=
priv *bat_priv,
>  	return 2;
>  }
> =20
> +/**
> + * batadv_is_encapsulated_claim

not even a 4 words useless words for our short description? :)

> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: skb to be checked
> + *
> + * Check if this frame is a claim frame encapsulated in at least
> + * two layers of VLANs.
> + *
> + * returns 1 if this is an encapsulated claim frame, 0 otherwise.

Start with Capital letter here.

> + */
> +static int batadv_is_encapsulated_claim(struct batadv_priv *bat_priv,
> +					struct sk_buff *skb)
> +{
> +	struct batadv_bla_claim_dst *bla_dst, *bla_dst_own;
> +	struct vlan_hdr vhdr, *vhdr_ptr;
> +	uint8_t *hw_src, *hw_dst;
> +	struct ethhdr *ethhdr;
> +	struct arphdr *arphdr;
> +	int headlen;
> +
> +	/* Traverse the VLAN/Ethertypes until an ARP header is found.
> +	 *
> +	 * At this point it is known that the first two protocols
> +	 * are VLAN headers, so start checking at the encapsulated protocol
> +	 * of the second header.
> +	 */
> +	headlen =3D VLAN_ETH_HLEN;
> +	do {
> +		vhdr_ptr =3D skb_header_pointer(skb, headlen, VLAN_HLEN, &vhdr);
> +		if (!vhdr_ptr)
> +			return 0;
> +
> +		headlen +=3D VLAN_HLEN;
> +	} while (vhdr_ptr->h_vlan_encapsulated_proto =3D=3D htons(ETH_P_8021Q=
));
> +
> +	if (vhdr_ptr->h_vlan_encapsulated_proto !=3D htons(ETH_P_ARP))
> +		return 0;
> +
> +	if (unlikely(!pskb_may_pull(skb, headlen + arp_hdr_len(skb->dev))))
> +		return 0;
> +
> +	/* pskb_may_pull() may have modified the pointers, get ethhdr again *=
/
> +	ethhdr =3D eth_hdr(skb);
> +	arphdr =3D (struct arphdr *)((uint8_t *)ethhdr + headlen);
> +
> +	/* Check whether the ARP frame carries a valid IP information */
> +	if (arphdr->ar_hrd !=3D htons(ARPHRD_ETHER))
> +		return 0;
> +	if (arphdr->ar_pro !=3D htons(ETH_P_IP))
> +		return 0;
> +	if (arphdr->ar_hln !=3D ETH_ALEN)
> +		return 0;
> +	if (arphdr->ar_pln !=3D 4)
> +		return 0;
> +
> +	hw_src =3D (uint8_t *)arphdr + sizeof(struct arphdr);
> +	hw_dst =3D hw_src + ETH_ALEN + 4;
> +	bla_dst =3D (struct batadv_bla_claim_dst *)hw_dst;
> +	bla_dst_own =3D &bat_priv->bla.claim_dest;
> +
> +	/* check if it is a claim frame in general */
> +	if (memcmp(bla_dst->magic, bla_dst_own->magic,
> +		   sizeof(bla_dst->magic)) !=3D 0)
> +		return 0;
> +
> +	batadv_dbg(BATADV_DBG_BLA, bat_priv, "Dropping encapsulated claim fra=
me\n");

this function is not dropping anything. I'd rather move this message
where the real drop decision is made (e.g. in the chunk below).

> +
> +	return 1;
> +}
> =20
>  /**
>   * batadv_bla_process_claim
> @@ -885,6 +954,21 @@ static int batadv_bla_process_claim(struct batadv_=
priv *bat_priv,
>  		vhdr =3D vlan_eth_hdr(skb);
>  		proto =3D vhdr->h_vlan_encapsulated_proto;
>  		headlen +=3D VLAN_HLEN;
> +
> +		if (proto =3D=3D htons(ETH_P_8021Q)) {
> +			/* check if there is a claim frame encapsulated
> +			 * deeper in (QinQ) and drop that, as this is
> +			 * not supported by BLA but should also not be
> +			 * sent via the mesh.
> +			 *
> +			 * if its not, let the frame pass without further
> +			 * checks, as it is not a claim frame anyway.
> +			 */
> +			if (batadv_is_encapsulated_claim(bat_priv, skb))
> +				return 1;
> +			else
> +				return 0;
> +		}
>  	}
> =20
>  	if (proto !=3D htons(ETH_P_ARP))



The rest looks good thanks!

--=20
Antonio Quartulli


--LRaB5selV3kEfQgmdomuOCFRHFp2tHJf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTmqoXAAoJEJgn97Bh2u9eXJsQALm1QV2/TDoFMFHoiXfwn288
JEmhteB5zxjLsE6iBCXMQC+MCOz4byyJgz52mNnjmY7N9fiKWIfY/LFY/0rps4bs
rZFjYnSjli3H93hTT5Ww2AQf4S7OFJI8+BOQgsjLa1f+9y6taaKAXShPNYxOA/Y7
vr+WYWNFetgaQn8Ub1Wao6X+12Yn77MLjD/VUTh5LqSa7MvWKn8IfV+fTL2M9CHL
KMv0t3c+XVbifJ1AhwHKHboXIIIMzOJNS/CL0NtAhQZyjP/e02oUuyVMn+GgP7sx
myUz4f/0gTYme9zkHWxe6ThOBXbc0pXtTkktVCcWY7TJfebZO1gGpnY5Fl2/6EY3
mIErLkSD25M3GGtaG90YrGgMQbSR03FK8VKorVpwsF0DsmF441dHs2Qc1afALxl0
vn4d7FwA27UFkb2avQJnzxleKHfZRgOzizr3wh3nsNgP/7nnalOd1uKXeUE3Z4aJ
F9MdfYRvd60+/fThIK04tLnDtsmqYptvdGXFkvrQAZ8/tX6Ozib4a9sRpxbvLIMd
lFCcLDYAALlgyn/EOOCsPU6YUWP3J1+ibw3394yiJXOW0M3oPEbJtjiqJ7O5aULz
TvEZ1gK3lDfxPSZD4rztkearsu4l/slDoSsGONfyVRN4sUY4OM7xdvVZvm9POv+V
NDNVcyTuYLv56qn5uCZR
=btfA
-----END PGP SIGNATURE-----

--LRaB5selV3kEfQgmdomuOCFRHFp2tHJf6--
