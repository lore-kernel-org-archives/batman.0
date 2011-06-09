Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 9 Jun 2011 17:43:48 +0200
References: <1307632389-31676-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1307632389-31676-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1875643.h1hUBnW0ra";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106091743.50333.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use NO_FLAGS define instead
	of hard-coding 0
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1875643.h1hUBnW0ra
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 June 2011 17:13:09 Marek Lindner wrote:
> The definition NO_FLAGS was introduced to make the code more
> readable and shall be used to initialize flag fields.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Acked-by: Sven Eckelmann <sven@narfation.org>

> ---
>  aggregation.c    |    2 +-
>  gateway_client.c |    4 ++--
>  hard-interface.c |    2 +-
>  send.c           |    2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/aggregation.c b/aggregation.c
> index ef26011..ede0a56 100644
> --- a/aggregation.c
> +++ b/aggregation.c
> @@ -146,7 +146,7 @@ static void new_aggregated_packet(const unsigned char
> *packet_buff, forw_packet_aggr->own =3D own_packet;
>  	forw_packet_aggr->if_incoming =3D if_incoming;
>  	forw_packet_aggr->num_packets =3D 0;
> -	forw_packet_aggr->direct_link_flags =3D 0;
> +	forw_packet_aggr->direct_link_flags =3D NO_FLAGS;
>  	forw_packet_aggr->send_time =3D send_time;
>=20
>  	/* save packet direct link flag status */
> diff --git a/gateway_client.c b/gateway_client.c
> index cf7f95e..24aee56 100644
> --- a/gateway_client.c
> +++ b/gateway_client.c
> @@ -322,7 +322,7 @@ void gw_node_update(struct bat_priv *bat_priv,
>=20
>  		gw_node->deleted =3D 0;
>=20
> -		if (new_gwflags =3D=3D 0) {
> +		if (new_gwflags =3D=3D NO_FLAGS) {
>  			gw_node->deleted =3D jiffies;
>  			bat_dbg(DBG_BATMAN, bat_priv,
>  				"Gateway %pM removed from gateway list\n",
> @@ -335,7 +335,7 @@ void gw_node_update(struct bat_priv *bat_priv,
>  		goto unlock;
>  	}
>=20
> -	if (new_gwflags =3D=3D 0)
> +	if (new_gwflags =3D=3D NO_FLAGS)
>  		goto unlock;
>=20
>  	gw_node_add(bat_priv, orig_node, new_gwflags);
> diff --git a/hard-interface.c b/hard-interface.c
> index cf972c3..db7aacf 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -331,7 +331,7 @@ int hardif_enable_interface(struct hard_iface
> *hard_iface, batman_packet =3D (struct batman_packet
> *)(hard_iface->packet_buff); batman_packet->packet_type =3D BAT_PACKET;
>  	batman_packet->version =3D COMPAT_VERSION;
> -	batman_packet->flags =3D 0;
> +	batman_packet->flags =3D NO_FLAGS;
>  	batman_packet->ttl =3D 2;
>  	batman_packet->tq =3D TQ_MAX_VALUE;
>  	batman_packet->tt_num_changes =3D 0;
> diff --git a/send.c b/send.c
> index 0c5d671..a150c7c 100644
> --- a/send.c
> +++ b/send.c
> @@ -334,7 +334,7 @@ void schedule_own_packet(struct hard_iface *hard_ifac=
e)
>  		batman_packet->gw_flags =3D
>  				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
>  	else
> -		batman_packet->gw_flags =3D 0;
> +		batman_packet->gw_flags =3D NO_FLAGS;
>=20
>  	atomic_inc(&hard_iface->seqno);

--nextPart1875643.h1hUBnW0ra
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN8Oo0AAoJEF2HCgfBJntGs2sQAKchD0EJq7LgeRPczWphUz8d
PDI3nZh4G7Nodry/Lj9KZcIkT9V3jIeNVk6sptrda68B80sL+094kH+lREPQAAjN
KLcJtvh+pY9WKM2ynb3viQjmqWjBVJmUMnoGUNIXsMsUtzEaeMhsIPChQHcv8kvn
L6oGP8AAXomvwz5G+JbzICKccF4hCebCN9/GfirV0M66SqO2Ez3jGNW6Dnk5ASK3
rhBBzB/I8SPLqdbyQ42RKqz5h2KUh9e3rAnbtwKS7FIH70Fg8Vq5h7Ymutwqs9fY
8NBIrV0pwMXH95udNchxbKhjSDGdQpVg+Qw+ZNyFnjZrjGgts4N0YRZrBDdNTy81
WjDjGlUFgNr3z/qS+P6W1Ky+VafDb1Z6pzcDEwpf45P6LXqcLJjGBwwpU51Q8265
s5xQjKUCebtkvgJFSIvVfrBAvdIxAXiDwcIX8RlN+NFoWHx1dtjJ0khKe+gxVkCQ
5EPLf4HHEPSDezTnE+C4cgdwVA/NPugJaXVAegSPVxTHH/T3mE40vyqDmrLuheHJ
qXPntaqFpBa295nRcHzes/TGMjXUg+05xri79Gjt+X2vIkyrxwyHTbQA1BHtehbl
d1AGH6h10qC4AIrpI/oehyWZF0WZLRQBWwrWUi6XDm6C7PyL0CjP1da4tKDYONbR
nlWRkRguyxHOovUkIeJd
=QknH
-----END PGP SIGNATURE-----

--nextPart1875643.h1hUBnW0ra--
