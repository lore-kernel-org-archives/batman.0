Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 12:45:17 +0200
Message-ID: <3526113.DGLM0pS6Vy@bentobox>
In-Reply-To: <20160612041426.26339-2-a@unstable.cc>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-2-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1481646.g2mlfRSTAJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 1/4] batman-adv: make the GW selection
	class algorithm specific
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1481646.g2mlfRSTAJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 June 2016 12:14:23 Antonio Quartulli wrote:
[...]
> +	if (bat_priv->algo_ops->gw.show_sel_class)
> +		return bat_priv->algo_ops->gw.show_sel_class(bat_priv, buff);
[...]
> +	if (bat_priv->algo_ops->gw.store_sel_class)
> +		return bat_priv->algo_ops->gw.store_sel_class(bat_priv, buff,
> +							      count);
[...]
>  /**
> + * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
> + * @store_sel_class: parse and stores a new GW selection class
> + * @show_sel_class: prints the current GW selection class
> + */
> +struct batadv_algo_gw_ops {
> +	ssize_t (*store_sel_class)(struct batadv_priv *bat_priv, char *buff,
> +				   size_t count);
> +	ssize_t (*show_sel_class)(struct batadv_priv *bat_priv, char *buff);
> +};

Looks like these two are also optional. Can someone please add the "(optional)"
string to the kernel-doc like it was done in the initial batadv_algo_ops
patches? Thanks

Same for get_best_gw_node, is_eligible and print in patch 2

Kind regards,
	Sven
--nextPart1481646.g2mlfRSTAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXo69AAoJEF2HCgfBJntGKNEQAJSplzDt/AA0Y/G1z35LSwcp
2I7RcG+Xkljjo0ZgfVNdm2/AHK2kl1gwjywgoNhoB0mXIkk/d6qUKliwuwvwxDSl
ldeAxdsWmRllFIxC0/3gdCX/Auq8FYfTL+mUeTUiZG1PHhgmj8vWMJZD/zKLZKLQ
qhWoWDs3OA8mtCdTn+Jq9OC1hD7fyZRlJlvtpUQJfJyti/+r8L6nUsX0e7TByaoV
iDTqQlAmq0AItpZxcjjqwCYkzK1QM/Ts7WdaQKcE9jNJcR0rQ8/RqwRDkyUmfbuH
bN8wcBLCuL2cZC7zDqPB8pMAf7T9NtqN4qOFXh4IMXWICHzk6HXHRgSXyu+OHaRE
SaNKv+pETeNO0CIGtocYDW6IzfshiBj5x6G4PT5BryDhCfJAM1GSxOThYPwL6zBn
T4olYYkOGsmLEXWiZ7LACHIE4cZA+O5sBV7bMSSNAmhuhIh4yzqWlJSH5uJLy68a
iXEStyIUS83m++HW9t8ff/VIlwfQWve8uXnj2gqokQppXUS40fr2MtlD2skpn3lo
H4VDmA1cN2sHNiDtdO3AYwpSugafykbN1O25+Cz7VzWHs91WRpCZhRtIHt3LXxBl
bC1RUnnVeArYd8HjWO0THPE/G3sGRBdF1dzX8tLmZQX70NMn8iV4zBNdo2WOTlxH
rCAZDQ1ankEw6rHjp7gu
=9G3u
-----END PGP SIGNATURE-----

--nextPart1481646.g2mlfRSTAJ--

