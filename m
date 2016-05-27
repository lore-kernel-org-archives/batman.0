Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 27 May 2016 15:48:37 +0200
Message-ID: <1623801.mhGnxyytJi@bentobox>
In-Reply-To: <20160525152736.9031-6-a@unstable.cc>
References: <20160525152736.9031-1-a@unstable.cc>
 <20160525152736.9031-6-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1478310.4nVosVohau";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 5/6] batman-adv: B.A.T.M.A.N. V -
	implement GW selection logic
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

--nextPart1478310.4nVosVohau
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 25 May 2016 23:27:35 Antonio Quartulli wrote:
> +#ifdef CONFIG_BATMAN_ADV_BATMAN_V
> +struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
> +                                         struct batadv_orig_node *orig_node);
> +#endif /* CONFIG_BATMAN_ADV_BATMAN_V */

This is rather odd because the function is also compiled (and used) even when
CONFIG_BATMAN_ADV_BATMAN_V is not enabled.

Here is the relevant diff:

> @@ -356,9 +360,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
>   *
>   * Return: gateway node if found or NULL otherwise.
>   */
> -static struct batadv_gw_node *
> -batadv_gw_node_get(struct batadv_priv *bat_priv,
> -                  struct batadv_orig_node *orig_node)
> +struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
> +                                         struct batadv_orig_node *orig_node)
>  {
>         struct batadv_gw_node *gw_node_tmp, *gw_node = NULL;
>  

Maybe you should drop the CONFIG_BATMAN_ADV_BATMAN_V check.

But I should at least whitelist the batadv_gw_node_get for the unused symbols
check.

Kind regards,
	Sven
--nextPart1478310.4nVosVohau
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXSFA1AAoJEF2HCgfBJntGJzoP/3TPocT3F64t1XypewS5+smQ
wzXcaf1pR8GYu4sm2DZFK8/UZ6/ypMnFsI6YYLlnj3R2H4f328/hgP/0V2Kfc4KP
m4YbeF6bs6qQh17HgFAEHnmN205uNOM3BiisQj799gNXXQcvKa2fiQbJ3f2H+rd8
+6fA2oVhVvLfhB+D1QsVFKPMr9bp7GXKwvb+oDAb7sAoJi7OwL3gOGH0N6o4+YXu
qwTsZynIksr5z0tPCfwXesZ/+DzC0kfUmAUxM5dUXEC2y8v6GoLbLVDbARvbxv1Z
4Vu06US0Dv56LBfBhx0snusOohgYGUbz0L15dtoIJGyaDL+bzbMXGF5Wv6FLfvrl
QmrWAuUyWEA7LKfV7fFPtaiwd2sqS3NhSlg3BeKMECJc9A1Hd4yVykU4jhpb4HjB
JY5cyTC8NqfaeAcJkDrYYuxiozKQcUk/mpwYNL+DZjmacgxLpsxsR3b8Z9PySx+n
IjVdQ507HRuzoQCuoa+ab0ourhogwli/4C0kypiew8nhNVih+sp7VlfV1tdupfWp
Gjl+HI6Vr2sgu4Bl2KzvozPFDzoHS5Npvu2JUq3tATNc9NHhNN/nhPC7UfrguijQ
uqG+bXcCG54IHTZr0xj1zobAri1bdtRMC40b2agkZhdUfSje0DokaHVH4b8acwKt
2KZnnFRraaIFsnks8Crz
=K5yz
-----END PGP SIGNATURE-----

--nextPart1478310.4nVosVohau--

