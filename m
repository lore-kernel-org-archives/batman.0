Return-Path: <antonio.quartulli@open-mesh.com>
Date: Tue, 3 May 2016 01:28:28 +0800
From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Message-ID: <20160502172828.GZ11201@prodigo.lan>
References: <1459508076-29674-1-git-send-email-sven@open-mesh.com>
 <1459508076-29674-3-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AAiVQQES42Kk67ff"
Content-Disposition: inline
In-Reply-To: <1459508076-29674-3-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: throughput meter
 implementation
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>


--AAiVQQES42Kk67ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sven,

a comment is inline.

On Fri, Apr 01, 2016 at 12:54:36PM +0200, Sven Eckelmann wrote:

[...]

> +/**
> + * batadv_tp_send - main sending thread of a tp meter session
> + * @arg: address of the related tp_vars
> + *
> + * Return: nothing, this function never returns
> + */
> +static int batadv_tp_send(void *arg)
> +{
> +	struct batadv_tp_vars *tp_vars =3D arg;
> +	struct batadv_priv *bat_priv =3D tp_vars->bat_priv;
> +	struct batadv_hard_iface *primary_if =3D NULL;
> +	struct batadv_orig_node *orig_node =3D NULL;
> +	size_t payload_len, packet_len;
> +	int err =3D 0;
> +
> +	if (unlikely(tp_vars->role !=3D BATADV_TP_SENDER)) {
> +		err =3D BATADV_TP_DST_UNREACHABLE;
> +		goto out;
> +	}
> +
> +	orig_node =3D batadv_orig_hash_find(bat_priv, tp_vars->other_end);
> +	if (unlikely(!orig_node)) {
> +		err =3D BATADV_TP_DST_UNREACHABLE;
> +		goto out;
> +	}
> +
> +	primary_if =3D batadv_primary_if_get_selected(bat_priv);
> +	if (unlikely(!primary_if)) {
> +		err =3D BATADV_TP_DST_UNREACHABLE;
> +		goto out;
> +	}

in case of error we modify err and then we jump to out, but:

[...]

> +out:
> +	if (likely(primary_if))
> +		batadv_hardif_put(primary_if);
> +	if (likely(orig_node))
> +		batadv_orig_node_put(orig_node);
> +
> +	batadv_tp_sender_end(bat_priv, tp_vars);
> +	batadv_tp_sender_cleanup(bat_priv, tp_vars);
> +
> +	batadv_tp_vars_put(tp_vars);
> +
> +	do_exit(0);
> +}

shouldn't we propagate the value saved in err to tp_vars->reason ?

We found this error while using the tp_meter, because we tried to run it
against a non-existing originator and batctl crashed.


Cheers,

--=20
Antonio Quartulli

--AAiVQQES42Kk67ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXJ448AAoJEJ4aZjxxc6bKYUEP/jYxJAKpS5GnFrXbU+W5Zazm
bv3ats0dqlpOGzozgH6hPRHbzUkbC7zOxSrxVGQzuMzrW+lROsh0ASfDx4I3A5zH
z3QnsWPOX45ERFAQ7KQFKdB4fgp8p3bMr19N50qgWbMDX+aEKIOJtxYc6JgIhUhO
XP9NDJEL3O//lQXoRdXLnKYGnQeyDePQu1p+1MPdCf4bBQZbBEPxKxJxeRS1ls4v
LRUfwwo6Abl2/ycZqlw/4bA9eOpSCofuut1VhhzN+MEeKccv6HPnNPxHXEHEV1a6
2bvNCEFcoqG2UbQDoO7RMas8EstEwYZL9hz6WQS6Mn3iJQjCD05opEYaPk8R373R
C5E2D95urSLgXiYn84clsxJkR0d20gPmcd0zXHZtKIh1xnYV1VFBBUVsjFGJRagt
cxbD9KrrXjHQyo3+irIYC0CRGMV10nGQDXKKpQsE3MPfgnwPEgWOQTyDR/sY9zlI
Uu5FPsvd1yamDebOm/lJ6rPPSeHygAtvmZCjnfveEyvtTf1f6VQSpwdJi6/PRVNB
Yn6H1vxuocUn4+jzyXecVa9vJy2tZTczVBT12YaS5TGIFdnVzNp0Lgy0Zs6HNSIV
pwaZToRmmQ6KnTAbhWE40DoKXBJrm8l30qkHY/k/YlOJnrXDDQqrwiCyUYT2XA0m
Y5vUZ5sxEOxir8p7XXxS
=1hMp
-----END PGP SIGNATURE-----

--AAiVQQES42Kk67ff--
