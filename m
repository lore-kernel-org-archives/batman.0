Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 28 May 2013 17:31:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130528153107.GB14466@pandem0nium>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
 <1369382549-8787-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <1369382549-8787-3-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: Announce new
 capability via multicast TVLV
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


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2013 at 10:02:27AM +0200, Linus L=C3=BCssing wrote:
> If the soft interface of a node is not part of a bridge then a node
> announces a new multicast TVLV: The according flag
> (BATADV_MCAST_LISTENER_ANNOUNCEMENT) signalizes that this node is
> announcing all of its multicast listeners via the translation table
> infrastructure. More precisely, all multicast listeners of scope greater
> than link-local for IPv4 and of scope greater
> or equal to link-local for IPv6.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  main.c           |    4 ++++
>  multicast.c      |   62 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  multicast.h      |    7 ++++++
>  originator.c     |    3 +++
>  packet.h         |    7 ++++++
>  soft-interface.c |    1 +
>  types.h          |    4 ++++
>  7 files changed, 86 insertions(+), 2 deletions(-)
>=20
> diff --git a/main.c b/main.c
> index 1c82c18..6ab5b2d 100644
> --- a/main.c
> +++ b/main.c
> @@ -145,6 +145,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
>  	if (ret < 0)
>  		goto err;
> =20
> +	ret =3D batadv_mcast_init(bat_priv);
> +	if (ret < 0)
> +		goto err;
> +
>  	ret =3D batadv_gw_init(bat_priv);
>  	if (ret < 0)
>  		goto err;
> diff --git a/multicast.c b/multicast.c
> index 56a1128..36e4c59 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -204,10 +213,59 @@ out:
>  }
> =20
>  /**
> + * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv co=
ntainer
> + * @bat_priv: the bat priv with all the soft interface information
> + * @orig: the orig_node of the ogm
> + * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flag=
s)
> + * @tvlv_value: tvlv buffer containing the multicast data
> + * @tvlv_value_len: tvlv buffer length
> + */
> +static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_pri=
v,
> +					     struct batadv_orig_node *orig,
> +					     uint8_t flags,
> +					     void *tvlv_value,
> +					     uint16_t tvlv_value_len)
> +{
> +	uint8_t mcast_flags =3D BATADV_NO_FLAGS;
> +
> +	/* only fetch the tvlv value if the handler wasn't called via the
> +	 * CIFNOTFND flag and if there is data to fetch
> +	 */
> +	if (!(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
> +	    (tvlv_value) && (tvlv_value_len =3D=3D sizeof(mcast_flags)))
> +		mcast_flags =3D *(uint8_t *)tvlv_value;
> +
> +	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
> +	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
> +		atomic_inc(&bat_priv->mcast.num_non_aware);
> +	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
> +		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
> +		atomic_dec(&bat_priv->mcast.num_non_aware);
> +	}

What happens if the orig_node is removed/times out? I can't see where num_n=
on_aware
is updated in this case.

We do have a work struct touch every orig every second anyway (batadv_purge=
_orig), maybe
put counting multicast aware routers there? Then you don't have to care abo=
ut
synchronizing stuff ...

> +
> +	orig->mcast_flags =3D mcast_flags;
> +}
> +
> +/**
> + * batadv_mcast_init - initialize the multicast optimizations structures
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +int batadv_mcast_init(struct batadv_priv *bat_priv)
> +{
> +	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler_v1,
> +				     NULL, BATADV_TVLV_MCAST, 1,
> +				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
> +	return 0;
> +}
> +
> +/**
>   * batadv_mcast_free - free the multicast optimizations structures
>   * @bat_priv: the bat priv with all the soft interface information
>   */
>  void batadv_mcast_free(struct batadv_priv *bat_priv)
>  {
> +	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
> +	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
> +
>  	batadv_mcast_mla_tt_clean(bat_priv, NULL);
>  }

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGkzbsACgkQrzg/fFk7axZpsgCg8A9G7chJuxcUjn3FsLOCtemn
5JMAoL19XE85A9X/7CuFmvmTiaYsjJuj
=0m7T
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
