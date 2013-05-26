Return-Path: <ordex@autistici.org>
Date: Sun, 26 May 2013 15:57:46 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130526135746.GM1679@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-2-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
In-Reply-To: <1368793673-27539-2-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/4] batman-adv: added IPv6 to DAT and
 generic functions in distributed-arp-table.c
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2013 at 03:27:50PM +0300, Mihail wrote:
> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>=20
> Added IPv6 functionality to generic functions implemented in the first
> patch.

avoid references to "first"/"second"/"third" patch. Once committed, they wi=
ll
just be some patches in the list. You can either explicitly mention the nam=
e of
the patch ("writing the subject in this way") or just saying
previously/whatever else.


>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20
> ---
>  distributed-arp-table.c |   30 ++++++++++++++++++++++++++----
>  types.h                 |    6 +++++-
>  2 files changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index b2ca7e0..42118be 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -32,7 +32,7 @@
>  #include "unicast.h"
> =20
>  static char *batadv_dat_types_str_fmt[] =3D {
> -	"%pI4",
> +	"%pI4", "%pI6c",

better going on a new line rather than putting both on the same one (like t=
he
array declared in the gateway code).

>  };
> =20
>  static void batadv_dat_purge(struct work_struct *work);
> @@ -173,6 +173,10 @@ static size_t batadv_sizeof_dat_data(uint8_t data_ty=
pe)
>  	switch (data_type) {
>  	case BATADV_DAT_IPV4:
>  		return sizeof(__be32);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case BATADV_DAT_IPV6:
> +		return sizeof(struct in6_addr);
> +#endif
>  	default:
>  		return 0;
>  	}
> @@ -295,6 +299,12 @@ static uint32_t batadv_hash_dat_ipv4(const void *dat=
a, uint32_t size)
>  	return batadv_hash_dat(data, BATADV_DAT_IPV4, size);
>  }
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +static uint32_t batadv_hash_dat_ipv6(const void *data, uint32_t size)
> +{
> +	return batadv_hash_dat(data, BATADV_DAT_IPV6, size);
> +}
> +#endif
> =20
>  /**
>   * batadv_dat_entry_hash_find - look for a given dat_entry in the local =
hash
> @@ -393,6 +403,11 @@ static void batadv_dat_entry_add(struct batadv_priv =
*bat_priv, void *data,
>  	case BATADV_DAT_IPV4:
>  		choose =3D batadv_hash_dat_ipv4;
>  		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case BATADV_DAT_IPV6:
> +		choose =3D batadv_hash_dat_ipv6;
> +		break;
> +#endif

mh...I was just wondering: for the hash functions it would be nice to re-us=
e the
same "array approach" that you used for the printing format.

So we would have an array of function pointers to reference rather than hav=
ing
this switch block...What do you think?

I think it would be possible to do this for many other "variable" parameter=
s if
required.

>  	default:
>  		goto out;
>  	}
> @@ -872,8 +887,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *=
seq, void *offset)
>  		goto out;
> =20
>  	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
> -	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
> -		   "last-seen");
> +	seq_printf(seq, "                       %-26s %-15s %5s\n",
> +		   "IPv4/IPv6", "MAC", "last-seen");
> =20
>  	for (i =3D 0; i < hash->size; i++) {
>  		head =3D &hash->table[i];
> @@ -888,10 +903,17 @@ int batadv_dat_cache_seq_print_text(struct seq_file=
 *seq, void *offset)
> =20
>  			switch (dat_entry->type) {
>  			case BATADV_DAT_IPV4:
> -				seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
> +				seq_printf(seq, " * %-40pI4 %15pM %6i:%02i\n",
>  					   dat_entry->data, dat_entry->mac_addr,
>  					   last_seen_mins, last_seen_secs);
>  				break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +			case BATADV_DAT_IPV6:
> +				seq_printf(seq, " * %-40pI6c %15pM %6i:%02i\n",

can't you generalise this using the printing format array defined at the
top of this patch?

> +					   dat_entry->data, dat_entry->mac_addr,
> +					   last_seen_mins, last_seen_secs);
> +				break;
> +#endif
>  			}
>  		}
>  		rcu_read_unlock();
> diff --git a/types.h b/types.h
> index 284e3d2..74c7091 100644
> --- a/types.h
> +++ b/types.h
> @@ -931,10 +931,14 @@ struct batadv_dat_entry {
> =20
>  /**
>   * batadv_dat_types - types used in batadv_dat_entry for IP
> - * @BATADV_DAT_IPv4: IPv4 address type
> + * @BATADV_DAT_IPV4: IPv4 address type

I guess this is a mistake. In the last version of your last patch you are u=
sing
IPV4 and therefore it is impossible that you have IPv4 here (or maybe you f=
orgot
to fix this comment...in this case, this fix should go direclty in the prev=
ious
patch).

> + * @BATADV_DAT_IPV4: IPv6 address type
>   */
>  enum batadv_dat_types {
>  	BATADV_DAT_IPV4 =3D 0,
> +#if IS_ENABLED(CONFIG_IPV6)
> +	BATADV_DAT_IPV6 =3D 1,
> +#endif
>  };
> =20
>  /**
> --=20
> 1.7.10.4

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRohTaAAoJEADl0hg6qKeOEO8QALTHB+0wc4ITARtLrkwXSkuf
3B+LWniKqbaHr1aHiBpxOR2KKrmMk+NMUl0USuvY5LlbT7d40xZPq8TzUypNd8oT
HRQ77bhHIcancMQPVUqtqq5jL7JuODf4JDGNyVKi0H+2h/ZVzb+N2gp4Qwgh8MhK
+DXWxBGimZPoVdN0lmfqEVRgcI2U8vLuXTa4MxuCXHqPAQYJTnxTWE4iE3YRgKT4
pBlxRPj/TUBjenHo7aCpSITXevX9artX151cJ8E5h7qTbCs2p1RPJ2ww9uvazNzZ
HpsiGgk5LGd5VcH/ou/rzxJuqSwlJvZhq75wPEUo7G0w6bknU3+I4UKE0b5QxS2X
N6MnIudg0ugoU0x0b3pPN4kI153VSQLUISMScoHKeHZJ/33BsLeNXGFdYcb93w9J
RlXSvGOdQp89Ou6UV4gd49jfoGg21qIe/sHdocJhMIlEy5yelg5tCO1Me7vgiUkI
CCDU7kLZdU5LmYXCYS13H7OqKTAlJcPAHkRA3Ii1QdGsPu3fFbwkSswGY48RpUCg
gGgM/igXmFAz3x2b5zB7IO1PbuZg4ZCdLe01u755jsBmvoM3q0Oyn8nyfDvvP+sE
tedclIL05o/kDTlIfnjf8Oyc+RfGmxkzx1w7Tx1Ml0LxzMTQQYPOZOQm2NJRGsX1
ykuXl3Wpqsm9Sy7qJWS+
=bxo8
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
