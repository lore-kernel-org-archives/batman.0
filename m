Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:42:01 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031004201.GH10726@pandem0nium>
References: <1320001741-18351-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Content-Disposition: inline
In-Reply-To: <1320001741-18351-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise
 tt_local_reset_flags()
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


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

I don't quite understand what this patch is good for - it generalises the f=
unction,
but does not use the function at another point. So what it is good for (nex=
t to
add more complexity to batman ;] ).

Furthermore it counts the changes and adds it to num_local_tt, is there a b=
ug fix
hidden in this patch somewhere? :)

Cheers,
	Simon

On Sun, Oct 30, 2011 at 08:09:01PM +0100, Antonio Quartulli wrote:
> The tt_local_reset_flags() is actually used for one use case only. It is =
not
> generalised enough to be used indifferent situations. This patch make it =
general
> enough in order to let other code use it whenever a flag flip is requeste=
d over
> the whole hash table (passed as parameter).
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
> This patch depends on:
>=20
> batman-adv: create a common substructure for tt_global/local_entry
>=20
>=20
>  translation-table.c |   31 ++++++++++++++++++++-----------
>  1 files changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index 76134bc..5b60aba 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -1695,19 +1695,20 @@ void tt_free(struct bat_priv *bat_priv)
>  	kfree(bat_priv->tt_buff);
>  }
> =20
> -/* This function will reset the specified flags from all the entries in
> - * the given hash table and will increment num_local_tt for each involved
> - * entry */
> -static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t fla=
gs)
> +/* This function will flip to new_value (if not already) the specified f=
lags for
> + * all the entries in the given hash table and returns the number of mod=
ified
> + * entries */
> +static uint16_t tt_flip_flags(struct hashtable_t *hash, uint16_t flags,
> +			     uint8_t new_value)
>  {
>  	uint32_t i;
> -	struct hashtable_t *hash =3D bat_priv->tt_local_hash;
> +	uint16_t changed_num =3D 0;
>  	struct hlist_head *head;
>  	struct hlist_node *node;
>  	struct tt_common_entry *tt_common_entry;
> =20
>  	if (!hash)
> -		return;
> +		goto out;
> =20
>  	for (i =3D 0; i < hash->size; i++) {
>  		head =3D &hash->table[i];
> @@ -1715,14 +1716,18 @@ static void tt_local_reset_flags(struct bat_priv =
*bat_priv, uint16_t flags)
>  		rcu_read_lock();
>  		hlist_for_each_entry_rcu(tt_common_entry, node,
>  					 head, hash_entry) {
> -			if (!(tt_common_entry->flags & flags))
> +			if ((tt_common_entry->flags & flags) !=3D new_value)
>  				continue;
> -			tt_common_entry->flags &=3D ~flags;
> -			atomic_inc(&bat_priv->num_local_tt);
> +			/* depending on 'new_value', enable or disable the flags
> +			 * pointed by 'flags' */
> +			tt_common_entry->flags &=3D
> +				(~flags | (new_value ? flags : NO_FLAGS));
> +			changed_num++;
>  		}
>  		rcu_read_unlock();
>  	}
> -
> +out:
> +	return changed_num;
>  }
> =20
>  /* Purge out all the tt local entries marked with TT_CLIENT_PENDING */
> @@ -1766,7 +1771,11 @@ static void tt_local_purge_pending_clients(struct =
bat_priv *bat_priv)
> =20
>  void tt_commit_changes(struct bat_priv *bat_priv)
>  {
> -	tt_local_reset_flags(bat_priv, TT_CLIENT_NEW);
> +	uint16_t changed_num =3D tt_flip_flags(bat_priv->tt_local_hash,
> +					    TT_CLIENT_NEW, 0);
> +	/* all the reset entries have now to be effectively counted as local
> +	 * entries */
> +	atomic_add(changed_num, &bat_priv->num_local_tt);
>  	tt_local_purge_pending_clients(bat_priv);
> =20
>  	/* Increment the TTVN only once per OGM interval */
> --=20
> 1.7.3.4
>=20
>=20

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t7tkACgkQrzg/fFk7axYxAgCfejX4m1Qn65JQWXADkADGaHx2
X3oAoMQUeu4G7uPu9VP80ostAi9UIy98
=xfyE
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
