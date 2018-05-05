Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 May 2018 22:23:37 +0200
Message-ID: <4312006.8fiAyFea1e@sven-edge>
In-Reply-To: <20180505153020.29636-1-linus.luessing@c0d3.blue>
References: <20180505153020.29636-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8525173.HkEjPzjcWO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Antonio Quartulli <a@unstable.cc>

--nextPart8525173.HkEjPzjcWO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 5. Mai 2018 17:30:20 CEST Linus L=FCssing wrote:
[...]
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translat=
ion-table.c
> index 0225616d..a95724ea 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -2914,6 +2914,41 @@ static bool batadv_tt_global_valid(const void *ent=
ry_ptr,
>  }
> =20
>  /**
> + * batadv_tt_get_flags() - get TT flags for a given entry
> + * @tt_common_entry: the TT entry to get the flags for
> + * @orig: for a TT global entry the specific node to get the flags for
> + *
> + * Return: -ENOENT on error or the TT flags otherwise.
> + */
> +static int
> +batadv_tt_get_flags(struct batadv_tt_common_entry *tt_common_entry,
> +		    struct batadv_orig_node *orig)

Not sure whether it is a good idea to use the return here for the error cod=
e=20
(< 0) and the flags (__u8/enum batadv_tt_client_flags). I will leave the=20
decision here to Antonio.

[...]
>   * batadv_tt_tvlv_generate() - fill the tvlv buff with the tt entries fr=
om the
>   *  specified tt hash
>   * @bat_priv: the bat priv with all the soft interface information
> @@ -2934,6 +2969,7 @@ static void batadv_tt_tvlv_generate(struct batadv_p=
riv *bat_priv,
>  	struct batadv_tvlv_tt_change *tt_change;
>  	struct hlist_head *head;
>  	u16 tt_tot, tt_num_entries =3D 0;
> +	int flags;
>  	u32 i;
> =20
>  	tt_tot =3D batadv_tt_entries(tt_len);
> @@ -2951,8 +2987,12 @@ static void batadv_tt_tvlv_generate(struct batadv_=
priv *bat_priv,
>  			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
>  				continue;
> =20
> +			flags =3D batadv_tt_get_flags(tt_common_entry, cb_data);
> +			if (flags < 0)
> +				continue;

The second argument of batadv_tt_get_flags is a little bit tricky here. The=
=20
kernel-doc says that cb_data is "data passed to the filter function as=20
argument" and is of type "void *". But you are now using it here as if woul=
d=20
always be of type "struct batadv_orig_node *". This doesn't make problem  f=
or=20
now because only two functions are using this argument - luckily they are=20
either set it to NULL or to "batadv_orig_node *".

I would propose to make it clear that this argument must be=20
"struct batadv_orig_node *" and not an arbitrary argument which is only use=
d=20
by the valid_cb callback.

Kind regards,
	Sven
--nextPart8525173.HkEjPzjcWO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlruEskACgkQXYcKB8Em
e0bYJxAAzAuuO8qLLfIqPejLanm2hw1ty9B9L4eou0/t2TIiTMhWKuOVFJQMgzz6
vCagFY+th9AFDFA39lb/MjraZ11YUibNjKg+BrW0Ol64IjmbZ2n+r0zXsgKuIP0i
QRR5MBxFef/XRUqqR/0aBEP6rDQTOwmAiqI+IWl2ZjduflxV7dygvSMlBI90nktq
+ekeW8s9IMPWCk8ih8zUpwl2Bs4ISSrIz0rfrTfB+md49SinyrJfzmlsAIgNu1eW
u+nbXWTa1b620l8If6lIeFqSKpI0A53TVhCrMREVr8sPKHfSVP19soJXZR3BN2p+
DGq07ie0ePm6JMiUbafZlPGrvA0DYbE++UlMYQF3SVXxvzVno90lpr6jzqwXaO9R
KFVG+V6wzV9f2I3eCBTwOrEYH/svyTONN/HTkhnfBnZynqofXeBkpZ/2aX2dTI/6
Ke9fc7FYtlq8/6EgQiRZFls5y1IY0u4yVS5fEiguQfS6Bk9s+63ycPj/nltHU8PG
1G5el1lyUJ3wETARkxSp+zQxmDr/A1pFMdVkXRR4ZkaHfdSfxcu9R4ju+Srp52cp
5G+MNyLYAjwvjIv5PoeCf6n1yZy0Q97oscV5vgV+Hb1fvOSylO6pQiz5kI63st53
y+9e+tSqM9GsAZ4+lus8A40o7hFa2gR/fvgaH6eJLalTUIsxFhs=
=cful
-----END PGP SIGNATURE-----

--nextPart8525173.HkEjPzjcWO--



