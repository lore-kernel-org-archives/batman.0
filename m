Return-Path: <ordex@autistici.org>
Date: Sun, 12 May 2013 01:11:13 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130511231113.GE901@ritirata.org>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <1368293014-30742-3-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Announce new capability
 via multicast TVLV
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


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2013 at 07:23:26PM +0200, Linus L=C3=BCssing wrote:
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
> +	    (tvlv_value) && (tvlv_value_len =3D=3D 1))
		just for style reason I'd suggest to use sizeof(mcast_flags)
		instead of 1. and there is no need for parentheses around
		tvlv_value.

> +		mcast_flags =3D *(unsigned char *)tvlv_value;

mcast_flags is uint8_t, therefore (even if it may practically be the same) =
you
should use the same type for the cast.

> +
> +	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
> +	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
> +		atomic_inc(&bat_priv->mcast_num_non_aware);
> +	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
> +		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
> +		atomic_dec(&bat_priv->mcast_num_non_aware);
> +	}
> +
> +	orig->mcast_flags =3D mcast_flags;
> +}

> diff --git a/originator.c b/originator.c
> index 5d53d2f..acc0c2d 100644
> --- a/originator.c
> +++ b/originator.c
> @@ -257,6 +257,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct =
batadv_priv *bat_priv,
>  	reset_time =3D jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_M=
S);
>  	orig_node->bcast_seqno_reset =3D reset_time;
>  	orig_node->batman_seqno_reset =3D reset_time;
> +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> +	orig_node->mcast_flags =3D BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> +#endif

why do you start assuming that an originator has the optimisation enabled? =
would
it be better to wait for the first mcast tvlv from it to claim this?

> +/* multicast capabilities */
> +enum batadv_mcast_flags {
> +	BATADV_MCAST_LISTENER_ANNOUNCEMENT =3D BIT(0),
> +};
> +

> diff --git a/types.h b/types.h
> index 5d73a75..4ef5fb9 100644
> --- a/types.h
> +++ b/types.h
> @@ -146,6 +146,9 @@ struct batadv_orig_node {
>  	unsigned long last_seen;
>  	unsigned long bcast_seqno_reset;
>  	unsigned long batman_seqno_reset;
> +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> +	uint8_t mcast_flags;
> +#endif
>  	uint8_t capabilities;
>  	atomic_t last_ttvn;
>  	uint32_t tt_crc;
> @@ -569,6 +572,7 @@ struct batadv_priv {
>  #endif
>  #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
>  	atomic_t mcast_group_awareness;
> +	atomic_t mcast_num_non_aware;

why isn't this variable in the mcast_priv struct? It is not a user knob (as=
 far
as I can see)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRjtARAAoJEADl0hg6qKeOsFYP/RbEDhGLnsOTgvd2Z8G5cFfl
oci8DkPiaL/gVgG/ycvzYTtmIrenglL0l8mtO34LW3HrHIkdewlC575FX5Az28ce
p9YWbLSmz6zN+YI2+KOs1vwXlJDqfBhk8xyXg6IraIBRR33iqJ4OTKcBrXp0wlgU
aYKZU3PH3jZztHqAs7QrroYDAci/ZmdZxPbY0nx0CCgfNAOnYOdvlAj0Qefd2xXV
YFdkKYZTcqQdADwoTtQlDN7cYE2990OVI/sZT0FP/WHSZlHjRGsLLhCxDgjJhb0A
Kb6Uz37adQCHgBcIUI4UBtNke9DNHZ8YvrB3aTpTo7pItwMHyRzY873w99deYN3d
wfJFsYxS/EejmYLWnHo6tH2Re4YRLB5Ll1mGcjEWqQ3YsrK6GyENrRiSZGSvx2YY
lacuGmv/KNcu3abkc5nWWDr39xD+CTQNeiGVceK76yKUkIkLuaqvTppC/y8vCMbo
6zTaZJLCd0JLymUt4idvS1B5ZH8huqGwZt95PxRyFf9KMQn+T2Nrq07v42FDzHNe
c6s4P42abOVm0leTB4N6n2rg7Sbq1BvA8T2nuuM7rMmQ3pL7AlDuuO5M1mEHNND0
ErXeu/i6Op/++aP3g4Zc+uZMk04KXx45P9MOCFQN2qEvVhaniTRhluT7NXOt8Fan
69mfrtfxtQb9ZfU59M7b
=yv8C
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
