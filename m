Return-Path: <a@unstable.cc>
References: <20180510160804.6632-1-linus.luessing@c0d3.blue>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <ffecbcdc-48c9-8acb-3ba6-7ab05cee5aa1@unstable.cc>
Date: Fri, 11 May 2018 00:18:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180510160804.6632-1-linus.luessing@c0d3.blue>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nfHm3M9e1O9x5nL1RlPX0G6lvjpcxbEPA"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 maint] batman-adv: Fix TT sync flags
 for intermediate TT responses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nfHm3M9e1O9x5nL1RlPX0G6lvjpcxbEPA
Content-Type: multipart/mixed; boundary="T2Dd0kXDrwkKblgGgJ0Y5C7S4GlNP9isU";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Message-ID: <ffecbcdc-48c9-8acb-3ba6-7ab05cee5aa1@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
References: <20180510160804.6632-1-linus.luessing@c0d3.blue>
In-Reply-To: <20180510160804.6632-1-linus.luessing@c0d3.blue>

--T2Dd0kXDrwkKblgGgJ0Y5C7S4GlNP9isU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/05/18 00:08, Linus L=C3=BCssing wrote:
> The previous TT sync fix so far only fixed TT responses issued by the
> target node directly. So far, TT responses issued by intermediate nodes=

> still lead to the wrong flags being added, leading to CRC mismatches.
>=20
> This behaviour was observed at Freifunk Hannover in a 800 nodes setup
> where a considerable amount of nodes were still infected with 'WI'
> TT flags even with (most) nodes having the previous TT sync fix applied=
=2E
>=20
> I was able to reproduce the issue with intermediate TT responses in a
> four node test setup and this patch fixes this issue by ensuring to
> use the per originator instead of the summarized, OR'd ones.
>=20
> Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
>=20
> ---
> Changes v2:
> - repurpose current valid_cb callback to get the flags
>   -> saves us a second, duplicate orig-entry hash table lookup
>   -> avoids the "guessing" of TT local vs. TT global / cb_data type
> ---
>  net/batman-adv/translation-table.c | 62 +++++++++++++++++++++++++++++-=
--------
>  1 file changed, 47 insertions(+), 15 deletions(-)
>=20
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> index 78993dd7..511cad0e 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1538,6 +1538,7 @@ batadv_tt_global_orig_entry_find(const struct bat=
adv_tt_global_entry *entry,
>   *  handled by a given originator
>   * @entry: the TT global entry to check
>   * @orig_node: the originator to search in the list
> + * @flags: a pointer to store flags to (may be NULL)

I'd suggest to make the doc at the line above a bit more specific.
"Flags" is very generic and by reading the kerneldoc of this function it
may not be obvious to grasp what flags we are talking about. Something
like "TT flags forwarded by @orig for this global @entry" or similar..

>   *
>   * find out if an orig_node is already in the list of a tt_global_entr=
y.
>   *
> @@ -1545,7 +1546,8 @@ batadv_tt_global_orig_entry_find(const struct bat=
adv_tt_global_entry *entry,
>   */
>  static bool
>  batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *e=
ntry,
> -				const struct batadv_orig_node *orig_node)
> +				const struct batadv_orig_node *orig_node,
> +				u8 *flags)
>  {
>  	struct batadv_tt_orig_list_entry *orig_entry;
>  	bool found =3D false;
> @@ -1553,6 +1555,10 @@ batadv_tt_global_entry_has_orig(const struct bat=
adv_tt_global_entry *entry,
>  	orig_entry =3D batadv_tt_global_orig_entry_find(entry, orig_node);
>  	if (orig_entry) {
>  		found =3D true;
> +
> +		if (flags)
> +			*flags =3D orig_entry->flags;
> +
>  		batadv_tt_orig_list_entry_put(orig_entry);
>  	}
> =20
> @@ -1731,7 +1737,7 @@ static bool batadv_tt_global_add(struct batadv_pr=
iv *bat_priv,
>  			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
>  				goto out;
>  			if (batadv_tt_global_entry_has_orig(tt_global_entry,
> -							    orig_node))
> +							    orig_node, NULL))
>  				goto out_remove;
>  			batadv_tt_global_del_orig_list(tt_global_entry);
>  			goto add_orig_entry;
> @@ -2880,27 +2886,49 @@ batadv_tt_req_node_new(struct batadv_priv *bat_=
priv,
>  }
> =20
>  /**
> - * batadv_tt_local_valid() - verify that given tt entry is a valid one=

> + * batadv_tt_local_get_flags() - verify local tt entry and get flags
>   * @entry_ptr: to be checked local tt entry
>   * @data_ptr: not used but definition required to satisfy the callback=
 prototype
> + * @flags: a pointer to store flags to

same here: maybe just mention "TT flags for this client"?

> + *
> + * Checks the validity of the given local TT entry. If it is, then the=
 provided
> + * flags pointer is updated.
>   *
>   * Return: true if the entry is a valid, false otherwise.
>   */
> -static bool batadv_tt_local_valid(const void *entry_ptr, const void *d=
ata_ptr)
> +static bool batadv_tt_local_get_flags(const void *entry_ptr,
> +				      const void *data_ptr,
> +				      u8 *flags)
>  {
>  	const struct batadv_tt_common_entry *tt_common_entry =3D entry_ptr;
> =20
>  	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
>  		return false;
> +
> +	*flags =3D tt_common_entry->flags;
> +
>  	return true;
>  }
> =20
> -static bool batadv_tt_global_valid(const void *entry_ptr,
> -				   const void *data_ptr)
> +/**
> + * batadv_tt_global_get_flags() - verify global tt entry and get flags=

> + * @entry_ptr: to be checked global tt entry
> + * @data_ptr: an orig_node object (may be NULL)
> + * @flags: a pointer to store flags to

same as above

> + *
> + * Checks the validity of the given global TT entry. If it is, then th=
e provided
> + * flags pointer is updated either with the common (summed) TT flags i=
f data_ptr
> + * is NULL or the specific, per originator TT flags otherwise.
> + *
> + * Return: true if the entry is a valid, false otherwise.
> + */
> +static bool batadv_tt_global_get_flags(const void *entry_ptr,
> +				       const void *data_ptr,
> +				       u8 *flags)
>  {
>  	const struct batadv_tt_common_entry *tt_common_entry =3D entry_ptr;
>  	const struct batadv_tt_global_entry *tt_global_entry;
> -	const struct batadv_orig_node *orig_node =3D data_ptr;
> +	const struct batadv_orig_node *orig =3D data_ptr;

why this free renaming? is it related to this patch?

> =20
>  	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
>  	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
> @@ -2910,7 +2938,7 @@ static bool batadv_tt_global_valid(const void *en=
try_ptr,
>  				       struct batadv_tt_global_entry,
>  				       common);
> =20
> -	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node);
> +	return batadv_tt_global_entry_has_orig(tt_global_entry, orig, flags);=

>  }
> =20
>  /**
> @@ -2920,20 +2948,23 @@ static bool batadv_tt_global_valid(const void *=
entry_ptr,
>   * @hash: hash table containing the tt entries
>   * @tt_len: expected tvlv tt data buffer length in number of bytes
>   * @tvlv_buff: pointer to the buffer to fill with the TT data
> - * @valid_cb: function to filter tt change entries
> + * @flags_cb: function to filter tt change entries and to return flags=


I personally don't like the name "flags_cb" because this cb is still
mainly used for filtering entries. maybe "filter_cb" is a better name?
or just "cb" (so we get rid of any ambiguity :P)?

>   * @cb_data: data passed to the filter function as argument
>   */
>  static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
>  				    struct batadv_hashtable *hash,
>  				    void *tvlv_buff, u16 tt_len,
> -				    bool (*valid_cb)(const void *,
> -						     const void *),
> +				    bool (*flags_cb)(const void *,
> +						     const void *,
> +						     u8 *flags),
>  				    void *cb_data)
>  {
>  	struct batadv_tt_common_entry *tt_common_entry;
>  	struct batadv_tvlv_tt_change *tt_change;
>  	struct hlist_head *head;
>  	u16 tt_tot, tt_num_entries =3D 0;
> +	u8 flags;
> +	bool ret;
>  	u32 i;
> =20
>  	tt_tot =3D batadv_tt_entries(tt_len);
> @@ -2948,11 +2979,12 @@ static void batadv_tt_tvlv_generate(struct bata=
dv_priv *bat_priv,
>  			if (tt_tot =3D=3D tt_num_entries)
>  				break;
> =20
> -			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
> +			ret =3D flags_cb(tt_common_entry, cb_data, &flags);

why changing the assumption to "flags_cb" is never NULL, while it was
not the case before your change?

> +			if (!ret)
>  				continue;
> =20
>  			ether_addr_copy(tt_change->addr, tt_common_entry->addr);
> -			tt_change->flags =3D tt_common_entry->flags;
> +			tt_change->flags =3D flags;
>  			tt_change->vid =3D htons(tt_common_entry->vid);
>  			memset(tt_change->reserved, 0,
>  			       sizeof(tt_change->reserved));
> @@ -3247,7 +3279,7 @@ static bool batadv_send_other_tt_response(struct =
batadv_priv *bat_priv,
>  		/* fill the rest of the tvlv with the real TT entries */
>  		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
>  					tt_change, tt_len,
> -					batadv_tt_global_valid,
> +					batadv_tt_global_get_flags,
>  					req_dst_orig_node);
>  	}
> =20
> @@ -3376,7 +3408,7 @@ static bool batadv_send_my_tt_response(struct bat=
adv_priv *bat_priv,
>  		/* fill the rest of the tvlv with the real TT entries */
>  		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
>  					tt_change, tt_len,
> -					batadv_tt_local_valid, NULL);
> +					batadv_tt_local_get_flags, NULL);
>  	}
> =20
>  	tvlv_tt_data->flags =3D BATADV_TT_RESPONSE;
>=20

The rest looks good! Thanks!

--=20
Antonio Quartulli


--T2Dd0kXDrwkKblgGgJ0Y5C7S4GlNP9isU--

--nfHm3M9e1O9x5nL1RlPX0G6lvjpcxbEPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr0cOYACgkQB6U8WA7y
zXST+A/+Pd3U4KcH2WlWANfu6KlAMiecehtQavbYRyLflqP8iGycTPSSzUqfgceE
Gqvkd3P/COL0CSGpZo7lzPw/HkMn6Kvs+oh/ACbkj9k4ypGQRDvlpYLdS/8vgih6
xM0DbQ5EVOTb/aZgOJA+flBj221jv60t2OdOEbu/tHJIkBtc5SF++BXuSeN4szhD
4tCJcwM0CfKSMoGQD3wi+4rs14F+zzhjWEyznR/VQVhznDKo1o2D+nJD7Xm4p+Yr
ZXy6Rl+X1iv6w7tZ0UGgc0wFc23sKsPuw5aENY0yNRWDaP+wyOzdacCcPZkF7eNr
dnXQMSPaOIhOReDSUEh6T8hfFJA78tCrljRgDrFOpnCQucGkXnydmVaImy8e6+PM
WmED77GIwalFfll84CCEoqAF2UFsII7e3c/q7OalmWd5unog7/l7vkdr8fXL2hWG
zROU+DYHMuAWA62bx7btKjZSlHCEdmOOQ2WovqWzfISqMuMyb+t0QbzrBdKkhw/r
C/H+2GU1M+XgglN5y1YwXio0zQl+fCkGsLmTt1L+xvmzR2xsWAUyqn+XM3tgfJow
uQyiaHF/BqA8Hg4xo8xvNdhdnZTpc1F6DuL5hCPlMqLugip16ogku+5QJE6Q1qNW
R+fBgZWEDnxzfoqCG1NevKLEfUVj9xJlMOMH9KcK5TRLbbsUoLM=
=llAY
-----END PGP SIGNATURE-----

--nfHm3M9e1O9x5nL1RlPX0G6lvjpcxbEPA--
