Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Feb 2012 16:33:30 +0100
Message-ID: <1849513.Y59H6HZGp2@sven-laptop.home.narfation.org>
In-Reply-To: <1327953557-26774-1-git-send-email-ordex@autistici.org>
References: <1327953557-26774-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1839515.cUatMfO3Sv";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use ETH_ALEN instead of
	hardcoded numeric constants
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1839515.cUatMfO3Sv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 30 January 2012 20:59:17 Antonio Quartulli wrote:
> In packet.h the numeric constant 6 is used instead of the more portable
> ETH_ALEN define. This patch substitute any hardcoded value with such
> define.

Acked-by: Sven Eckelmann <sven@narfation.org>

Can you please also look through batctl tcpdump.h?

Thanks,
	Sven

> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  packet.h |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/packet.h b/packet.h
> index 441f3db..3496d38 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -100,8 +100,8 @@ struct batman_ogm_packet {
>  	struct batman_header header;
>  	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
>  	uint32_t seqno;
> -	uint8_t  orig[6];
> -	uint8_t  prev_sender[6];
> +	uint8_t  orig[ETH_ALEN];
> +	uint8_t  prev_sender[ETH_ALEN];
>  	uint8_t  gw_flags;  /* flags related to gateway class */
>  	uint8_t  tq;
>  	uint8_t  tt_num_changes;
> @@ -114,8 +114,8 @@ struct batman_ogm_packet {
>  struct icmp_packet {
>  	struct batman_header header;
>  	uint8_t  msg_type; /* see ICMP message types above */
> -	uint8_t  dst[6];
> -	uint8_t  orig[6];
> +	uint8_t  dst[ETH_ALEN];
> +	uint8_t  orig[ETH_ALEN];
>  	uint16_t seqno;
>  	uint8_t  uid;
>  	uint8_t  reserved;
> @@ -128,8 +128,8 @@ struct icmp_packet {
>  struct icmp_packet_rr {
>  	struct batman_header header;
>  	uint8_t  msg_type; /* see ICMP message types above */
> -	uint8_t  dst[6];
> -	uint8_t  orig[6];
> +	uint8_t  dst[ETH_ALEN];
> +	uint8_t  orig[ETH_ALEN];
>  	uint16_t seqno;
>  	uint8_t  uid;
>  	uint8_t  rr_cur;
> @@ -139,16 +139,16 @@ struct icmp_packet_rr {
>  struct unicast_packet {
>  	struct batman_header header;
>  	uint8_t  ttvn; /* destination translation table version number */
> -	uint8_t  dest[6];
> +	uint8_t  dest[ETH_ALEN];
>  } __packed;
> 
>  struct unicast_frag_packet {
>  	struct batman_header header;
>  	uint8_t  ttvn; /* destination translation table version number */
> -	uint8_t  dest[6];
> +	uint8_t  dest[ETH_ALEN];
>  	uint8_t  flags;
>  	uint8_t  align;
> -	uint8_t  orig[6];
> +	uint8_t  orig[ETH_ALEN];
>  	uint16_t seqno;
>  } __packed;
> 
> @@ -156,7 +156,7 @@ struct bcast_packet {
>  	struct batman_header header;
>  	uint8_t  reserved;
>  	uint32_t seqno;
> -	uint8_t  orig[6];
> +	uint8_t  orig[ETH_ALEN];
>  } __packed;
> 
>  struct vis_packet {
> @@ -165,9 +165,9 @@ struct vis_packet {
>  	uint32_t seqno;		 /* sequence number */
>  	uint8_t  entries;	 /* number of entries behind this struct */
>  	uint8_t  reserved;
> -	uint8_t  vis_orig[6];	 /* originator that announces its neighbors */
> -	uint8_t  target_orig[6]; /* who should receive this packet */
> -	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
> +	uint8_t  vis_orig[ETH_ALEN];	 /* originator that announces its neighbors
> */ +	uint8_t  target_orig[ETH_ALEN]; /* who should receive this packet */
> +	uint8_t  sender_orig[ETH_ALEN]; /* who sent or rebroadcasted this packet
> */ } __packed;
> 
>  struct tt_query_packet {
--nextPart1839515.cUatMfO3Sv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJPLU/KAAoJEF2HCgfBJntGOj4P/iOC6/A6bo3OVeGuL95RfpEd
+Br6/BOOv/xUOfxAexZXjm2QNWprcfyQE+J/kTwL/5RCwiUrSVs91Ni5LtXnMNj+
UdR3+Qrf16tYrF4Lfuz3eAa+W4afoBzd6fVkOpQFmkVt2PHbZ6r6HOWyuSPgoIwP
exRoQEmlxnCHybXH0s4gFj+2p7wGFH7Hs+eSIL70LCxDF7cg9IoO+4vCXN8Ty1mR
9RqQ/xO3sS7mzhMBvSnesmY525NWiBv9nhF32Z3gnWhURxS9QV/ssk7Sqf8MjQDK
ekLHtqd5aTSVh/6hfjjYd92C4ufiGoxLf1FuCbOtSDfAo22zpZxg4qGm1EW7JWqe
W3tufJkzN814UKgVyl18XmhRwnsBe5zmqlRuIqX16SFr8VFUl6uNGgSYC4bHrO8l
s8OmKRrOWBk3w1LnFRoCRDhGcoqwOjhEzYARWnv1+QncC9e4JrXc8zeXWSqrn2P6
utyZVa5Nq/4oldBvEOLKrzQJtdGXXHbFhiiRjeo6J6iGQXMtQHJ/od3K8Fv+3hWF
zWbUGcvgIv/bXF10Wm8yLUJ0bzd/FCYu7vPmP3rZdfek46OLTonOOb5w6nwJ/mwH
Y/m36J+pUR7esW7KSCkUEkaujKcEJS7qU9gtCchY7fK4g4hrIrUFhSBcHOWe+B1O
wkzxyCepdjEfUeZW2FlL
=xlQl
-----END PGP SIGNATURE-----

--nextPart1839515.cUatMfO3Sv--

