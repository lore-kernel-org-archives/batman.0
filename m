Return-Path: <ordex@autistici.org>
Date: Sat, 10 Aug 2013 13:14:35 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130810111434.GB849@ritirata.org>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <1373242365-763-3-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <1373242365-763-3-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 3/6] batman-adv: Adds IPv6 to DAT and
 generic struct in distributed-arp-table.c
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


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 03:12:42AM +0300, mihail.costea2005@gmail.com wrote:
> From: Mihail Costea <mihail.costea90@gmail.com>
>=20
> Adds IPv6 functionality to the generic struct.

You can be a bit more verbose here :)
Not everybody will understand what this patch is meant for.

>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20
> ---
>  distributed-arp-table.c |   12 +++++++++---
>  distributed-arp-table.h |    2 +-
>  types.h                 |    6 +++++-
>  3 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index b2a4fe5..f941913 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -36,6 +36,12 @@ static struct batadv_dat_type_info batadv_dat_types_in=
fo[] =3D {
>  		.size =3D sizeof(__be32),
>  		.str_fmt =3D "%pI4",
>  	},
> +#if IS_ENABLED(CONFIG_IPV6)
> +	{
> +		.size =3D sizeof(struct in6_addr),
> +		.str_fmt =3D "%pI6c",
> +	},
> +#endif
>  };
> =20
>  static void batadv_dat_purge(struct work_struct *work);
> @@ -845,8 +851,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *=
seq, void *offset)
>  		goto out;
> =20
>  	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
> -	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
> -		   "last-seen");
> +	seq_printf(seq, "                       %-26s %-15s %5s\n",
> +		   "IPv4/IPv6", "MAC", "last-seen");
> =20

At this point I'd suggest to switch from "IPv4/IPv6" to "Key".

>  	for (i =3D 0; i < hash->size; i++) {
>  		head =3D &hash->table[i];
> @@ -859,7 +865,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *=
seq, void *offset)
>  			last_seen_msecs =3D last_seen_msecs % 60000;
>  			last_seen_secs =3D last_seen_msecs / 1000;
> =20
> -			seq_printf(seq, " * %15s %14pM %6i:%02i\n",
> +			seq_printf(seq, " * %40s %15pM %6i:%02i\n",
>  				   batadv_dat_data_to_str(dat_entry->data,
>  							  dat_entry->type,
>  							  dbg_data,
> diff --git a/distributed-arp-table.h b/distributed-arp-table.h
> index 21d7b24..d029b4b 100644
> --- a/distributed-arp-table.h
> +++ b/distributed-arp-table.h
> @@ -28,7 +28,7 @@
>  #include <linux/if_arp.h>
> =20
>  #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
> -#define BATADV_DAT_DATA_MAX_LEN 16
> +#define BATADV_DAT_DATA_MAX_LEN 40
> =20
>  void batadv_dat_status_update(struct net_device *net_dev);
>  bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
> diff --git a/types.h b/types.h
> index 69c187e..60d2d64 100644
> --- a/types.h
> +++ b/types.h
> @@ -953,10 +953,14 @@ struct batadv_dat_entry {
> =20
>  /**
>   * batadv_dat_types - types used in batadv_dat_entry for IP
> - * @BATADV_DAT_IPv4: IPv4 address type
> + * @BATADV_DAT_IPV4: IPv4 address type

You should use the correct string in the previous patch already (I think you
overlooked the comment while fixing the var names).

> + * @BATADV_DAT_IPV6: IPv6 address type
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

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSBiCaAAoJEADl0hg6qKeOolAQAIz8VJwwnJS06L8hWHxh4tuH
rotYM8i9es/OI8sViVh3tqNYeX0jdLjiqI6jeb05QiJskw4oLE+qmr7mnhzKaBFs
hYXo4+cExB/4VD3Q8aii/xtfnma6x9Itdt9iDGemfSf2mXkmCvitEc5FaJmPBbF+
o5Nny1VZHu1GGd3/NjiQUlg1KaijiEXbOHSXL+o8LmETXLZ53FbVdVjJPNjMuq64
RFMDwzvcrf4bDWtnAaKf/pFC4/JaBXsMfmRrbCyzkVhox22w7VTyRtbXAxl44O7p
n8jfHWJDttpJQizsGPt2YUkIVcYHCCVYkN49+W8G6//QMG9M8nOOUQ4whGsy9QRF
OmHjLgQnsJ0+f5AUS6NpHYzX+w20rwtKBqo3dIV10uc6n74ODA6agbA3eC1Z0T4h
lKR7qe2dAvO1FGKJEEV07T2kdn99SRKnuPjlTuelaAcZMHShEfg0v4Y1V50P0ElZ
Zn2kqy/GTbkDviVRIcDHkadFNIM117vRQZwo2k6McLYMI+hJTVkwTojuJrv0uVHa
be60OU5wXNf8ZSmA9LqlsPg8O5QCvN7qCXp7+vbUCV6vPiHJ9Syj6Wx/FhUW+2Re
VQzro7cDN+5MWt+9H95fokQaqJbxh4ZTkZ+dG0iaS4XF6Ixqx270eO9U6JQTlhDn
KKb4O7Ti7yyLC4jDZR0C
=GxC+
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
