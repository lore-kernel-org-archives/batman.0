Return-Path: <a@unstable.cc>
Date: Mon, 23 May 2016 22:16:49 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160523141649.GF23226@prodigo.lan>
References: <20160523090037.26896-1-a@unstable.cc>
 <20160523090037.26896-2-a@unstable.cc>
 <20160523140912.GE23226@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <20160523140912.GE23226@prodigo.lan>
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


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 10:09:12PM +0800, Antonio Quartulli wrote:
> On Mon, May 23, 2016 at 05:00:33PM +0800, Antonio Quartulli wrote:
> > +static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
> > +					 struct attribute *attr, char *buff,
> > +					 size_t count)
> > +{
> > +	struct batadv_priv *bat_priv =3D batadv_kobj_to_batpriv(kobj);
> > +
> > +	if (buff[count - 1] =3D=3D '\n')
> > +		buff[count - 1] =3D '\0';
> > +
> > +	if (bat_priv->bat_algo_ops->gw.bat_store_sel_class)
> > +		return bat_priv->bat_algo_ops->gw.bat_store_sel_class(bat_priv,
> > +								      buff,
> > +								      count);
> > +
> > +	return __batadv_store_uint_attr(buff, count, 0, BATADV_TQ_MAX_VALUE,
>=20
> unfortunately the min value is still 0 - it should be kept to 1 as it was=
 in the
> original code.
>=20
> > +					batadv_post_gw_reselect, attr,
> > +					&bat_priv->gw.sel_class,
> > +					bat_priv->soft_iface);
> > +}
>=20
>=20
> I just realized that no post function is invoked here, thus changing the
> expected behaviour.

ah no - this is just wine effect...__batadv_store_uint_attr() takes care of
calling batadv_post_gw_reselect().

Only one fix needed then :)

Cheers,


--=20
Antonio Quartulli

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQxDRAAoJEJ4aZjxxc6bKPm4QAIUQ1hqg5S32/vONXEcA9Jvb
vm9uHFrgdUpy14i5MrXfmxrwW+C7CU7DRDBC9XX3SlIdSEzNY5rvo+TQ6zLJXhMZ
Xti6MWahmSU+uWElHNVQizic/MJMVqMNCvfbQvx3iVFaggJCqrE5MNHj8P+QX1Pi
MLJMFW7ZfXa1Je1N0CB443Di/rflijDmvwxi2rbvNMYf7f7/WPqxOiZcAAyg+LQ6
e7F8NsrDe1K6xb0QoWmMHa5frWT1Na/g9fZXJ7cAHgiAvq2jMd5qK/PCQPqxuCNF
QWKzkKosbPRnEXIJSbGkE5kb/o1KDBNsn4egvBt6kslXzNlsvqZtzCKP/NX46Ugv
/HsocZ5PRal7n3gwVMWO5Ndn8DlfmRSsLAsI14Gq7b7mR5LXzSJLfyakfKd6SNKX
eU8fqsiCjzOkbsJ0kWnYcBPgl2b0kjg05Rq0eaSF+i8yeM5MDmaJFBUEa4h8HweY
8B+4uKBiRqnX4bp6+PuMmh/SMdkSEnn35xCjgMeZh5M9KJL9ydT5SJSIMaohcopn
8UsuFOiP6NU2W/iteIz+de3TCt0oycXFGoxQ+CdLNyGUg+Y9EmyqRA1hH0Gg5LzN
abrld3+oI9FSaduqYZvTS1XFE3epKoCCcsUogzVTKDMWY20bRCnA4SFvmXdNj7jI
YiRd9GqhcvIdsFfp/BKP
=Jn0Q
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
