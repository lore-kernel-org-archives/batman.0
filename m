Return-Path: <antonio@meshcoding.com>
Message-ID: <53957653.5000406@meshcoding.com>
Date: Mon, 09 Jun 2014 10:54:43 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1401911616-18318-1-git-send-email-gaul@web-yard.de>
In-Reply-To: <1401911616-18318-1-git-send-email-gaul@web-yard.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nINbrqEQCjTcHrVr0Q6DVSNNqBtppogRO"
Subject: Re: [B.A.T.M.A.N.] [PATCH] remove unnecessary logspam
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
To: =?UTF-8?B?QW5kcsOpIEdhdWw=?= <gaul@web-yard.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nINbrqEQCjTcHrVr0Q6DVSNNqBtppogRO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On 04/06/14 21:53, Andr=C3=A9 Gaul wrote:
> This patch removes unnecessary logspam which resulted from superfluous
> calls to net_ratelimit(). With the supplied patch, net_ratelimit() is
> called after the loglevel has been checked.

good catch!

> -#define batadv_dbg(type, bat_priv, fmt, arg...)			\
> +/* possibly ratelimited debug output */
> +#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)			\

can you please put the ending "\" at the same position of the ones below
? (This way the entire macro definition looks better).

>  	do {							\
> -		if (atomic_read(&bat_priv->log_level) & type)	\
> +		if (atomic_read(&bat_priv->log_level) & type && \
> +		    (!ratelimited || net_ratelimit()))	\

same here

>  			batadv_debug_log(bat_priv, fmt, ## arg);\
>  	}							\
>  	while (0)
>  #else /* !CONFIG_BATMAN_ADV_DEBUG */
> -__printf(3, 4)
> -static inline void batadv_dbg(int type __always_unused,
> +__printf(4, 5)
> +static inline void _batadv_dbg(int type __always_unused,
>  			      struct batadv_priv *bat_priv __always_unused,
> +			      int ratelimited __always_unused,
>  			      const char *fmt __always_unused, ...)
>  {
>  }
>  #endif
> =20
> +#define batadv_dbg(type, bat_priv, arg...) \
> +	_batadv_dbg(type, bat_priv, 0, ## arg)
> +#define batadv_dbg_ratelimited(type, bat_priv, arg...) \
> +	_batadv_dbg(type, bat_priv, 1, ## arg)
> +
>  #define batadv_info(net_dev, fmt, arg...)				\
>  	do {								\
>  		struct net_device *_netdev =3D (net_dev);                 \
> diff --git a/routing.c b/routing.c
> index 3514153..c679c6f 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -706,7 +706,7 @@ static int batadv_check_unicast_ttvn(struct batadv_=
priv *bat_priv,
>  	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid))=
 {
>  		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
>  						  ethhdr->h_dest, vid))
> -			net_ratelimited_function(batadv_dbg, BATADV_DBG_TT,
> +			batadv_dbg_ratelimited(BATADV_DBG_TT,
>  						 bat_priv,
>  						 "Rerouting unicast packet to %pM (dst=3D%pM): Local Roaming\n",=

>  						 unicast_packet->dest,

The arguments on a new line must be lined up to the first column after
the opening parenthesis. (I think that checkpatch would have suggested
the same)

> @@ -752,7 +752,7 @@ static int batadv_check_unicast_ttvn(struct batadv_=
priv *bat_priv,
>  	 */
>  	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
>  					  ethhdr->h_dest, vid)) {
> -		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
> +		batadv_dbg_ratelimited(BATADV_DBG_TT, bat_priv,
>  					 "Rerouting unicast packet to %pM (dst=3D%pM): TTVN mismatch old_=
ttvn=3D%u new_ttvn=3D%u\n",
>  					 unicast_packet->dest, ethhdr->h_dest,
>  					 old_ttvn, curr_ttvn);

same here.


The rest looks good!



--=20
Antonio Quartulli


--nINbrqEQCjTcHrVr0Q6DVSNNqBtppogRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTlXZbAAoJEJgn97Bh2u9eiv4QALz5ADcj/08vo0wwA2309kAB
zgO6Hh0Tw1G16taO8lyMGPfXwMiCM34H+xkLlcpGc3rMPgPurGOVlCfn8qQ7XFRZ
pqhZ5kZmnh3VNrrdpFDNwmx8mUJ4xpSF5voclBlH6v9D7actzIEL7d1w7bo+6zlP
AT91AXVhUZMCoTGMG/i9Afe/nxlZUG6nquI6knDOhZxl5CmGDjKmeuopEIi0Fetg
06thQC/Q7qf/0zJTlx9tY3VdVYCJ8PitsAzb0/u+ZkVvzNQ5jWYfKpA7cGu1Mv9Z
0PL6FV082hIKkkC3rDMqoEOMi2ehpjOTDEW88ZSiuWX0wZuGJWOjaBTWJhuZpuLc
kp3WPFEiad6NHr6LRasi8FhVzGvMFhbvaYWTLJWKw3PVUMHDIfXQlrMhi+wpsGaE
I51Gcbng6EZ1l5OpVooDg9GmAFESvFdF7cA6pTIJWnIRqBUtAfdk/gXxkDN5vuvn
khkiOcmwLMhrEyJ+HShOhut9Lv7ry5XhVaFAcLq4ZmkB/zNI98zoCc9KTI8u0+XQ
oEe150VhmgShuOJprYtRU1I52A3N6eXtJevYmyal2RpThgWgoB8YTy2PU2o/7Gy1
rFQebUnQiCoOJFPzXXeB1LE4UCG3QFhuyE+g7QSHivktuQ2db/GiUarwzdRCQGZn
19qwVihMdCTw4ZzKDJAf
=8rEe
-----END PGP SIGNATURE-----

--nINbrqEQCjTcHrVr0Q6DVSNNqBtppogRO--
