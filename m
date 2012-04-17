Return-Path: <ordex@autistici.org>
Date: Tue, 17 Apr 2012 09:12:42 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120417071241.GA32239@ritirata.org>
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add get_ethtool_stats()
 support
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 01:24:55 +0200, Martin Hundeb=C3=B8ll wrote:
> @@ -488,6 +492,8 @@ bool dat_snoop_outgoing_arp_reply(struct bat_priv *ba=
t_priv,
>  	arp_neigh_update(bat_priv, ip_src, hw_src);
>  	arp_neigh_update(bat_priv, ip_dst, hw_dst);
> =20
> +	bat_priv->bat_stats.dat_reply_tx++;
> +
>  	/* Send the ARP reply to the candidates for both the IP addresses we
>  	 * fetched from the ARP reply */
>  	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);

Actually in dht_send_data() the skb is cloned and sent multiple times.
Should we count all the skbs that we send out?



> @@ -498,3 +505,57 @@ static u32 bat_get_link(struct net_device *dev)
>  {
>  	return 1;
>  }
> +
> +/* Inspired by drivers/net/ethernet/dlink/sundance.c:1702 */
> +static const struct {
> +	const char name[ETH_GSTRING_LEN];
> +} bat_stats_strings[] =3D {
> +	{ "forward" },
> +	{ "mgmt_tx" },
> +	{ "mgmt_rx" },
> +	{ "tt_request_tx" },
> +	{ "tt_request_rx" },
> +	{ "tt_response_tx" },
> +	{ "tt_response_rx" },
> +	{ "tt_roam_adv_tx" },
> +	{ "tt_roam_adv_rx" },
> +	{ "dat_request_tx" },
> +	{ "dat_request_rx" },
> +	{ "dat_reply_tx" },
> +	{ "dat_reply_rx" },
> +};
> +#define BAT_STATS_NUM 13

Do you really need internal { } ?
And why not using const char name* instead of name[N] ? All the strings are
const char * and they are already in the constant space (however it is call=
ed).

> +
> +static void bat_get_ethtool_stats(struct net_device *dev,
> +				  struct ethtool_stats *stats, u64 *data)
> +{
> +	struct bat_priv *bat_priv =3D netdev_priv(dev);
> +
> +	data[0] =3D bat_priv->bat_stats.forward;
> +	data[1] =3D bat_priv->bat_stats.mgmt_tx;
> +	data[2] =3D bat_priv->bat_stats.mgmt_rx;
> +	data[3] =3D bat_priv->bat_stats.tt_request_tx;
> +	data[4] =3D bat_priv->bat_stats.tt_request_rx;
> +	data[5] =3D bat_priv->bat_stats.tt_response_tx;
> +	data[6] =3D bat_priv->bat_stats.tt_response_rx;
> +	data[7] =3D bat_priv->bat_stats.tt_roam_adv_tx;
> +	data[8] =3D bat_priv->bat_stats.tt_roam_adv_rx;
> +	data[9] =3D bat_priv->bat_stats.dat_request_tx;
> +	data[10] =3D bat_priv->bat_stats.dat_request_rx;
> +	data[11] =3D bat_priv->bat_stats.dat_reply_tx;
> +	data[12] =3D bat_priv->bat_stats.dat_reply_rx;
> +}

(guess mode ON) why using u64? what if the arch is 32bit? are the values
correctly assigned anyway? what about longer addresses (do they exist?)?
As Sven suggested on IRC, you probably want to use uintptr_t instead.

> --- a/types.h
> +++ b/types.h
> @@ -162,9 +162,26 @@ struct bcast_duplist_entry {
>  };
>  #endif
> =20
> +struct bat_stats {
> +	uint64_t forward;
> +	uint64_t mgmt_tx;
> +	uint64_t mgmt_rx;
> +	uint64_t tt_request_tx;
> +	uint64_t tt_request_rx;
> +	uint64_t tt_response_tx;
> +	uint64_t tt_response_rx;
> +	uint64_t tt_roam_adv_tx;
> +	uint64_t tt_roam_adv_rx;
> +	uint64_t dat_request_tx;
> +	uint64_t dat_request_rx;
> +	uint64_t dat_reply_tx;
> +	uint64_t dat_reply_rx;
> +};

see previous comment.


One general comment: be consistent with integer types. I would suggest to u=
se
uint*_t only, instead of mixing u* and uint*_t.

The last stuff we have to understand is if we can really use shared counters
without having them as atomic_t or per_cpu variable...

Sven linked me this page: http://lwn.net/Articles/22911/
it seems that per_cpu variables should be used for network stats..but the e=
ffort
to use them seems to be not negligible :-P


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjRfpAAoJEFMQTLzJFOZFFakH/RY4U6GflfJLpL4K+W3a6SEp
v5dwbTtHGO8bT93X12InTDIxBTwlcd1Awj7nQ77MAFgjVWXNZJsPlbdFVh2WO3UX
5++bw+EN2rHZVt2P3IoAitgz1eUkbAuKsCNm2Q9MsVmYia2cKGrmN+bJ5VITI7YE
nDK8nqwNvqto7h/0UYTz80cdi2eXhbSNEXJsBJE61mBZ0P5QCWt2R6z0ljB9m6RY
66aNeOmdvuDLk+HnANKZSiOfllVfkE0CrlD7vsCVEX4xKdt8B//8U9CtiYPFUVNz
AGgpv/EGo0e6S2LZ0rBiA7Duz4XZfIbWpY0072YBY0fYGEB3TXSIo3r5VyuL8eY=
=Ox+g
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
