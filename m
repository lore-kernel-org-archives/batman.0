Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Sep 2018 19:41:46 +0800
Message-ID: <1806111.rq7lml0N69@rousseau>
In-Reply-To: <20180812190445.28013-2-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
 <20180812190445.28013-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2078324.BFvsnLQD0H";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Prevent duplicated
 gateway_node entry
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

--nextPart2078324.BFvsnLQD0H
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 13 August 2018 03:04:41 HKT Sven Eckelmann wrote:
> @@ -355,6 +356,8 @@ static void batadv_gw_node_add(struct batadv_priv
> *bat_priv, {
>         struct batadv_gw_node *gw_node;
> 
> +       lockdep_assert_held(&bat_priv->gw.list_lock);
> +
>         if (gateway->bandwidth_down == 0)
>                 return;
> 
> @@ -369,10 +372,8 @@ static void batadv_gw_node_add(struct batadv_priv
> *bat_priv, gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
>         gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
> 
> -       spin_lock_bh(&bat_priv->gw.list_lock);
>         kref_get(&gw_node->refcount);
>         hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.gateway_list);
> -       spin_unlock_bh(&bat_priv->gw.list_lock);

Not mandatory but in other cases the function kernel doc received a hint that 
$some lock needs to be acquired before the function should be called.

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek

--nextPart2078324.BFvsnLQD0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluREnoACgkQU1VOj+62
HMA0zQgAnTa0LWdWQ/e3U838xUG1vlNiHJJQwiDgKkkqRTjblQ8UDUOiInsBPLUi
2H0fCflpsfN20hmeE+hTfL6smWAwIy3txgd93stFGMQ4NCV70VrspeS8J1o1X1kz
6KIA040Prk07kG/1kKUFeHa6ylLDYhZtmHNsA7QKJk2Ste0YxjtVit7wISrnOfDy
pn13gzriCyGLjplFgK+yp8eDvLVShX3nEhiJzFSHi47vMgEUJ0kwEIwg/rmhkBos
inTY91Bk13hS9MOMa3rccM+st2W4ieL3+6OYyGPU4KTwg98DQz8bAcSnknysI39w
D+iMmTVKfU/JcA19z30Gq8pne0Kaew==
=squy
-----END PGP SIGNATURE-----

--nextPart2078324.BFvsnLQD0H--



