Return-Path: <a@unstable.cc>
Date: Mon, 23 May 2016 22:09:12 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160523140912.GE23226@prodigo.lan>
References: <20160523090037.26896-1-a@unstable.cc>
 <20160523090037.26896-2-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <20160523090037.26896-2-a@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/5] batman-adv: make the GW selection
 class algorithm specific
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


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 05:00:33PM +0800, Antonio Quartulli wrote:
> +static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
> +					 struct attribute *attr, char *buff,
> +					 size_t count)
> +{
> +	struct batadv_priv *bat_priv =3D batadv_kobj_to_batpriv(kobj);
> +
> +	if (buff[count - 1] =3D=3D '\n')
> +		buff[count - 1] =3D '\0';
> +
> +	if (bat_priv->bat_algo_ops->gw.bat_store_sel_class)
> +		return bat_priv->bat_algo_ops->gw.bat_store_sel_class(bat_priv,
> +								      buff,
> +								      count);
> +
> +	return __batadv_store_uint_attr(buff, count, 0, BATADV_TQ_MAX_VALUE,

unfortunately the min value is still 0 - it should be kept to 1 as it was i=
n the
original code.

> +					batadv_post_gw_reselect, attr,
> +					&bat_priv->gw.sel_class,
> +					bat_priv->soft_iface);
> +}


I just realized that no post function is invoked here, thus changing the
expected behaviour.


Both problems will be fixed in my next patchset.

Cheers,

--=20
Antonio Quartulli

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQw8IAAoJEJ4aZjxxc6bKn5IP/RFFEPWYZUd5cwULYW8/YUBK
iElPAK/mJgxDonjayeN+en6WAdIyRhnjPDTB5wbRe5UPb1El+1qb2/FPSvAq8amL
j0TPHyJS+dnqmi9iRQDPLtIA1wPkx0oLjovlbUWKy6cxW891kWrUKvfld6AA4RAk
rr9wKIHde7PsUX12+XkUxXhGMbJe+vPEMAUi0lL/SEObZgwrrhgVyF3JfLsJpWR6
2SzuTYkcQG5qxbGoLCUWQ9VLghdOFLh7TIbdaa0cMWUbc2B1wNlKHFthI4qm41a4
rZNXnRatuhWl1xrgyRX3FXnoOWTP5vOZQNI2w7tw9SKOfkaCE6BkkBehRUsGEUEP
yoyJPeFQRnS8q+LRaTTTZR2PmnLWkmox2qzkbhmN1klcs0SkEt/+xYK3Qduvv6NP
6gsiBZZeGKdoGogLUye/jOM7X6/Q8PDkwN3y6cKLLDSvbFzpCp7jvycvUnrGUzYm
XwpOWAnH4OEQ033+thZFS9SsVFnlN4K/9KpnfpNpG6JX0oFN8rL78EjWqb1+oD6A
3Atq2pw3XrgVQNGwk4qnG+04bLBZBooUYD7dZ5LmRZl00YY8sShKq1lLw7sj6OqD
sYE0bZx0F4ntL3Q1TZzET9DeO5sIh+M1uFgpiXvlKTXzVnCWPx+LzB0tNGLDL4dV
GrK7ebfEGnWr9MyZrg4/
=cW2d
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
