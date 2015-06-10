Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jun 2015 10:57:14 +0200
Message-ID: <1519360.DWtKWxiBrp@bentobox>
In-Reply-To: <1366724403-29629-2-git-send-email-lindner_marek@yahoo.de>
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
 <1366724403-29629-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1532315.X9hoJIdCou";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: tvlv - basic
	infrastructure
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart1532315.X9hoJIdCou
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 23 April 2013 21:39:57 Marek Lindner wrote:
> +/**
> + * batadv_tvlv_handler_unregister - unregister tvlv handler based on the
> + *  provided type and version (both need to match)
> + * @bat_priv: the bat priv with all the soft interface information
> + * @type: tvlv handler type to be unregistered
> + * @version: tvlv handler version to be unregistered
> + */
> +void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
> +				    uint8_t type, uint8_t version)
> +{
> +	struct batadv_tvlv_handler *tvlv_handler;
> +
> +	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
> +	if (!tvlv_handler)
> +		return;
> +
> +	batadv_tvlv_handler_free_ref(tvlv_handler);
> +	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
> +	hlist_del_rcu(&tvlv_handler->list);
> +	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
> +	batadv_tvlv_handler_free_ref(tvlv_handler);
> +}

Looks unsafe. How do you make sure that it is still in the list and not 
already already removed in the meantime? hlist_del_rcu does not re-initialize 
the pointers (only POISON them when CONFIG_DEBUG_LIST is activated). Thus 
calling hlist_del_rcu again on an object not in the list either kills other 
data structures or causes an Oops.

There are more *list_del* related problems of that type in your code. This is 
just one example I've picked.

See http://www.open-mesh.org/issues/217#note-5

Kind regards,
        Sven
--nextPart1532315.X9hoJIdCou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVd/vqAAoJEF2HCgfBJntGgowP/idRBLKbU6XH55CgtT8fGmFI
ObZIara4AVghPlZwU80OGaV9Wh226oHtH3c18hYrB1V2IpmO6BQ6uvMZe+UNHur3
6Dwf7bm4MvPydgc1/weW9RBcjuZwl51iyWu6/TaGxJymhcR08HOJOjyDIiZFY03o
2UZ9kl41w+Ik0kxVQO7HwK/CrGltpFNAavfOqjSvMhp25Haq1cSWiYaJyxtzTwhZ
gyG8+62bSX8EsvJaFgwsc0AC0Xd3UCJpaJJKTNqIIsxhZDLimDll5qmAcsJny2qu
mhuljMqI3RRpZ0YCyitcIBcV5XW+WY+mdwXly8p9xVRy/HVUN4rZIxrQTMZO020F
nBw9irHZW4UhD4xbmAVqNOq0N8IBzzrh+UD4NVEdzkWhwnPvaQ+mAorVqoCNChJD
Rzl9+n7L/MyBUdgIELoyRp3xXpj+9icyHLkg4D7Y2ko1ZkeGUqMlw2i+UwX6e2DZ
KCj8h4WRg4V/27E1AmngSUl67cSXvdGdHrygVbxgngNQknFg3+yeabZ/R8MJ6dTi
c1wyetGXKUtaNK7rP5tzOnyEq7imlA/E3M7pcjVY8R4og0k+KZOstpFvJQ5kjunb
Rc9tEwQQG9+U5eeOJ8Rw5lhVkGdwGNlCWDUANeaAIlVtwMqQL43zfoKoe3qmZiyZ
Vzj7S8FRMhPyOII76Pdj
=0cmI
-----END PGP SIGNATURE-----

--nextPart1532315.X9hoJIdCou--

