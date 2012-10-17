Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 16:17:05 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121017141705.GA30441@pandem0nium>
References: <1350478385-676-1-git-send-email-linus.luessing@web.de>
 <1350478385-676-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1350478385-676-2-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Fix potential
 broadcast BLA-duplicate-check race condition
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


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looks good, although I don't think this will happen very often - it
is only called when receiving packets, and AFAIK there can only be
multiple threads when using multiple interfaces.

Anyway, doing the spinlock shouldn't hurt and might save us some pain
when this function is used more often, or with multiple interfaces, or
cases I don't see now. :)

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


On Wed, Oct 17, 2012 at 02:53:05PM +0200, Linus L=C3=BCssing wrote:
> Threads in the bottom half of batadv_bla_check_bcast_duplist() might
> otherwise for instance overwrite variables which other threads might
> be using/reading at the same time in the top half, potentially
> leading to messing up the bcast_duplist, possibly resulting in false
> bridge loop avoidance duplicate check decisions.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> Note: I didn't observe such issues yet, probably because of the=20
> usually quite low broadcast data throughput - and on high broadcast
> throughput, then packet loss is usually caused by the limited capacity
> for broadcast packets on 802.11 media anyway.
>=20
>  bridge_loop_avoidance.c |   16 +++++++++++-----
>  main.c                  |    1 +
>  types.h                 |    2 ++
>  3 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index b828875..c6c1c59 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -1263,7 +1263,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_pr=
iv *bat_priv,
>  				   struct batadv_bcast_packet *bcast_packet,
>  				   int bcast_packet_len)
>  {
> -	int i, length, curr;
> +	int i, length, curr, ret =3D 0;
>  	uint8_t *content;
>  	uint16_t crc;
>  	struct batadv_bcast_duplist_entry *entry;
> @@ -1275,6 +1275,8 @@ int batadv_bla_check_bcast_duplist(struct batadv_pr=
iv *bat_priv,
>  	/* calculate the crc ... */
>  	crc =3D crc16(0, content, length);
> =20
> +	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
> +
>  	for (i =3D 0; i < BATADV_DUPLIST_SIZE; i++) {
>  		curr =3D (bat_priv->bla.bcast_duplist_curr + i);
>  		curr %=3D BATADV_DUPLIST_SIZE;
> @@ -1296,9 +1298,11 @@ int batadv_bla_check_bcast_duplist(struct batadv_p=
riv *bat_priv,
>  		/* this entry seems to match: same crc, not too old,
>  		 * and from another gw. therefore return 1 to forbid it.
>  		 */
> -		return 1;
> +		ret =3D 1;
> +		goto out;
>  	}
> -	/* not found, add a new entry (overwrite the oldest entry) */
> +	/* not found, add a new entry (overwrite the oldest entry)
> +	 * and allow it, its the first occurence. */
>  	curr =3D (bat_priv->bla.bcast_duplist_curr + BATADV_DUPLIST_SIZE - 1);
>  	curr %=3D BATADV_DUPLIST_SIZE;
>  	entry =3D &bat_priv->bla.bcast_duplist[curr];
> @@ -1307,8 +1311,10 @@ int batadv_bla_check_bcast_duplist(struct batadv_p=
riv *bat_priv,
>  	memcpy(entry->orig, bcast_packet->orig, ETH_ALEN);
>  	bat_priv->bla.bcast_duplist_curr =3D curr;
> =20
> -	/* allow it, its the first occurence. */
> -	return 0;
> +out:
> +	spin_unlock_bh(&bat_priv->bla.bcast_duplist_lock);
> +
> +	return ret;
>  }
> =20
> =20
> diff --git a/main.c b/main.c
> index 70797de..f54efe9 100644
> --- a/main.c
> +++ b/main.c
> @@ -102,6 +102,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
>  	spin_lock_init(&bat_priv->gw.list_lock);
>  	spin_lock_init(&bat_priv->vis.hash_lock);
>  	spin_lock_init(&bat_priv->vis.list_lock);
> +	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
> =20
>  	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
>  	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
> diff --git a/types.h b/types.h
> index 8a5d84c..7b3d0d7 100644
> --- a/types.h
> +++ b/types.h
> @@ -228,6 +228,8 @@ struct batadv_priv_bla {
>  	struct batadv_hashtable *backbone_hash;
>  	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
>  	int bcast_duplist_curr;
> +	/* protects bcast_duplist and bcast_duplist_curr */
> +	spinlock_t bcast_duplist_lock;
>  	struct batadv_bla_claim_dst claim_dest;
>  	struct delayed_work work;
>  };
> --=20
> 1.7.10.4
>=20
>=20

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlB+veEACgkQrzg/fFk7axayAgCfZ8QS5Omf5eeyRCKZFlgahs6S
ffsAnA91mqaxKrzeKm+X/3ZmAY0RC9si
=6HkM
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
