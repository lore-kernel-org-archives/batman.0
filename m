Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 17:31:27 +0200
Message-ID: <7378987.EkNMrEAytt@sven-edge>
In-Reply-To: <20160920121245.593-2-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2637391.hlttVWl1zy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Store and transmit own
	neighborhood hash
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

--nextPart2637391.hlttVWl1zy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:43 CEST Linus L=FCssing wrote:
[...]
>  /**
> + * batadv_hardif_neigh_get_pre - get the predecessor of a neighbor node
> + * @hard_iface: the interface this neighbour is connected to
> + * @neigh_addr: address of the neighbour to retrieve the predecessor for
> + *
> + * Tries to find the neighbor node which has an address closest to but
> + * smaller than the neigh_addr provided. In other words, tries to
> + * find a potential predecessor of a given MAC address.
> + *
> + * Return: The alphabetical predecessor of a neighbor node. Returns NULL
> + * if no such predecessor exists.
> + */
> +static struct batadv_hardif_neigh_node *
> +batadv_hardif_neigh_get_pre(struct batadv_hard_iface *hard_iface,
> +			    const u8 *neigh_addr)
> +{
> +	struct batadv_hardif_neigh_node *tmp_hardif_neigh, *hardif_neigh =3D NU=
LL;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(tmp_hardif_neigh, &hard_iface->neigh_list,
> +				 list) {
> +		if (memcmp(tmp_hardif_neigh->addr, neigh_addr, ETH_ALEN) >=3D 0)
> +			break;
> +
> +		if (!kref_get_unless_zero(&tmp_hardif_neigh->refcount))
> +			continue;
> +
> +		if (hardif_neigh)
> +			batadv_hardif_neigh_put(hardif_neigh);
> +
> +		hardif_neigh =3D tmp_hardif_neigh;
> +	}
> +	rcu_read_unlock();
> +
> +	return hardif_neigh;
> +}
> +
> +/**
>   * batadv_hardif_neigh_create - create a hardif neighbour node
>   * @hard_iface: the interface this neighbour is connected to
>   * @neigh_addr: the interface address of the neighbour to retrieve
> @@ -522,7 +559,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *=
hard_iface,
>  			   struct batadv_orig_node *orig_node)
>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_iface);
> -	struct batadv_hardif_neigh_node *hardif_neigh =3D NULL;
> +	struct batadv_hardif_neigh_node *hardif_neigh =3D NULL, *pre_neigh;
> =20
>  	spin_lock_bh(&hard_iface->neigh_list_lock);
> =20
> @@ -547,7 +584,13 @@ batadv_hardif_neigh_create(struct batadv_hard_iface =
*hard_iface,
>  	if (bat_priv->algo_ops->neigh.hardif_init)
>  		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
> =20
> -	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
> +	pre_neigh =3D batadv_hardif_neigh_get_pre(hard_iface, neigh_addr);
> +	if (!pre_neigh) {
> +		hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
> +	} else {
> +		hlist_add_behind(&hardif_neigh->list, &pre_neigh->list);
> +		batadv_hardif_neigh_put(pre_neigh);
> +	}

I personally would have liked to see this in a separate patch. But there are
more important things here.

=46irst you have to use hlist_add_head_rcu and hlist_add_behind_rcu here be=
cause
the readers use RCU to access the list. I think it would also be more
appropriate to replace the rcu_read_lock in the batadv_hardif_neigh_get_pre
function and instead use lockdep to mark the function as "requires
hard_iface->neigh_list_lock".

Stuff to other parts will follow later.

Kind regards,
	Sven
--nextPart2637391.hlttVWl1zy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TPPAAoJEF2HCgfBJntG2egQANjwegOvKgxO0rr0wemoa5My
WmJgtJgZsvR1wRN4ZHGHnKJvZBoa7hpxrDFA6M/XJN9Ew9m4/4MbDbjH+LS5guRg
iJgx36Q+xqDav47rmbPyItElQwQoRhlSfHTlxrbOli4UTV2kLq6mFfyVOcMw+rDQ
Td3wZ0cYlYy1FA2vLGV1KnZibkGyC8v0/c4kKJahr6i3eooKC9ylJ4OBRNku5i1p
zZvD3Ehlw1ba5/ZQAB/wj/E0OAqEd5iPq/OXO4TFrrVig1OpVAK5HajtJSgNUqkX
dGJk6A8OD+LjOCIyod4Xcj5EgeIEuTtwuu5wO8niHtHuEWo1dY1i2uKXEknQr9cK
YxySDVUE3goJNtvGwavpatgpmcvxA7ecgeuwk/ZnYlRUG7NDRtwk8Iu1lizVULAT
B+RGdHRy+zfFl2P922haVcJS5yjpfP3EUyd7b8tXF0cV8aIp1G1HkA9irc6pHrmR
5dk1mgH5UeUyyfHRCcriD5xtrQYDts3/BBbeEa+UvL2csuPXeUCCsriIWfQfyKiZ
n3KUuRZq3VMmJB9lKG2rTBubj4K63HBrR08R3oLzHp4ucYawYSUph4qNKrx7dZi3
gkfc8AT2JsuyqnEZr0Lg1xmlO/jGu1jAPYbFV3kaRnDRoBKLgaseCwFt2UezfEQd
0qkvzxqPhxC4PbOa4dA+
=0aJF
-----END PGP SIGNATURE-----

--nextPart2637391.hlttVWl1zy--

