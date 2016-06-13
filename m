Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 13:12:52 +0200
Message-ID: <3127928.zeFBqT8Kuq@bentobox>
In-Reply-To: <20160612041426.26339-4-a@unstable.cc>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-4-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart43114766.lnRbUGgHaP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
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

--nextPart43114766.lnRbUGgHaP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> --- a/net/batman-adv/gateway_client.c
> +++ b/net/batman-adv/gateway_client.c
> @@ -215,6 +215,10 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
>         if (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr_gw)
>                 goto out;
>  
> +       /* if gw.reselect is set to 1 it means that a previous call to
> +        * gw.is_eligible() said that we have a new best GW, therefore it can
> +        * now be picked from the list and selected
> +        */
>         next_gw = bat_priv->algo_ops->gw.get_best_gw_node(bat_priv);

I would guess that this should be either in patch 2/4 on in an extra patch. At
least it is about nothing which is touched otherwise in this patch

Kind regards,
	Sven
--nextPart43114766.lnRbUGgHaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXpU0AAoJEF2HCgfBJntGsgQQANba8iW7YDOjE2wwxr5Iq9bs
RB5Rr3hn/yY5lVdbelTX8jRhwB36WWXod156Fm09Kx8q8HJFzCt5799OtJduGL2/
ciVUUEJekGjVloC5LTJ/okO3m3Lk4iT78QZ+6BuGa86YZ1l9UFoVHrJLsL/XxOcy
3STgtAVH/goLC2B80sx0hLMo8gji5rhYXWZwQy4CXbFV9udICvR/EyZ9nxn4g9Da
aSaVQL7p78ngyPFgWz2KB3TVgpuveJwFrZOWE0HfRyHzcZX5S6IcdR5ggZTWUjTL
dt+VHaBrF15OILnE/EglNPLh6nEWjdZTBCUZfaFKJZ3kAcGs1qCr0pcNpOMn4bmo
1YOERSxJnVVgG6p2RMUu7ZZPl/U+kn4zsP6ET4kK6pO8PKe5XPOtjthjreyiuFUy
jv2Kg95H9SNP6XSr0gso3A3Y3SEeofse/GW5OId/Bh9AFHoh2ynNvT4EF81MlhcR
S8ukgS35OZJeZsGCU8WLYWx/8mFEuJmA+1Yg59nxCXPZPzIc47Y7zLtqbeCArj65
1H/17nlorlDn+rxJ61NLs/azaVU0RYa0oaWqaX1Hg8IsRWBAyyKMtA7Ph4ntVmND
AzvxUI0JTtqaCz/OxNa5H7px+WU8k9Nh+P/V8HPwBMqkTnjs0eHXcVXHR9IsUB85
WNhylwYu3Qmvcws0YKRj
=3znU
-----END PGP SIGNATURE-----

--nextPart43114766.lnRbUGgHaP--

