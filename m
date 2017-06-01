Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 01 Jun 2017 13:43:28 +0200
Message-ID: <2546838.CaOxSCmaqC@prime>
In-Reply-To: <20170601085804.4756-1-apape@phoenixcontact.com>
References: <20170601085804.4756-1-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2976867.KrvH1CQKyG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: prevent adding of loop
 detection mac addresses to global tt
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

--nextPart2976867.KrvH1CQKyG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 1, 2017 10:58:04 AM CEST Andreas Pape wrote:
> This patch prevents that entries in the global translation table are
> generated for mac addresses used by loop detection frames.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/translation-table.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/batman-adv/translation-table.c
> b/net/batman-adv/translation-table.c index e75b493..ca1e0f7 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1618,8 +1618,10 @@ static bool batadv_tt_global_add(struct batadv_priv
> *bat_priv, struct batadv_tt_common_entry *common;
>  	u16 local_flags;
> 
> -	/* ignore global entries from backbone nodes */
> -	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
> +	/* ignore global entries from backbone nodes or
> +	 * adding of entries related to loop detect frames */
> +	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid) ||
> +		batadv_bla_is_loopdetect_mac(tt_addr))
>  		return true;
> 
>  	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr, vid);

Thank you for your patch.

I was thinking, if we implement it like this we may still have problems if an 
older batman-adv version is adding the ba:be mac addresses locally. This could 
create a problem, because the transmitted tt table is not added completely, 
thus the CRC will not match and will lead to a "TT request/response loop".

What do you think? Maybe we should only add it for the speedy join case, but 
accept it if a node really added these mac addresses locally?

Thanks,
      Simon
--nextPart2976867.KrvH1CQKyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkv/eAACgkQoSvjmEKS
nqFzgRAAvnoGFX7HA/XYVJMVt77MqwIMwtBwkVx257jOKh2nPQpax4qMSH6hPxU3
14sdKgngFvHHpOkb1UnV7U0VosyuaumJjdhnLaE+afUXDqX1MoXxwutV8eswUuU1
49zHoXs7Sqy5aghrYxld5y6o3EJGUDCLUPAT7SOActO/HSCIs5CyVQF1nGTecfMh
kvlbFtRqlodQ7MlExq+xAMw1sT7Gr0JiGL81dzFl8IkTxqEX8oVoaSrBoNG3zbES
b2VndI05N4wbzv/AUdXsz8fwfDQs+bErcl0RTEqiVZ9quN44klWbxoE4RSLildJw
vEj0lNVi95H/oUzAUxaK3Id31kKm2QCzD6WpnCV29Aa9MADRAIlNvSVYxhLOMeAg
mtRM0a68RrmxXNLDYPUQh90DMa3S8m8KFxF1oZ1a4VaKPes58BQYYIvOpre7VROC
sv0gCt2akEGOlxIzmJ+g2VjGtqqRvJXBY/Wg/l7gKgFjdC+Lol2EBVdA7CCqhKW3
1qFiuGOlKIJtCUI2OaJ0HPcBy5XAiYmgLE52f6hL6GulruiXw47eGkW5bXUOEG6O
Rr3yphZkTUVfvDUjoeKi1BH5AvdEJdc5ARPJMK4aoVKG7c+By+3Z6iWW4O/ixxvz
TMXFpO6YYt691PwKT1fHZoXmzAySTvFfeDot35inKvSqjwl5Ch8=
=hEiQ
-----END PGP SIGNATURE-----

--nextPart2976867.KrvH1CQKyG--

