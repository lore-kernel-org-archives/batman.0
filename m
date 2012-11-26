Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 10:34:28 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126093428.GC22729@ritirata.org>
References: <cover.1353331252.git.martin@hundeboll.net>
 <e0944b8b9fcc9f288f11789a5f7f499b266caa2a.1353331252.git.martin@hundeboll.net>
 <20121126004117.GI14547@ritirata.org>
 <201211260915.44897.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <201211260915.44897.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/6] batman-adv: Detect coding nodes and
 remove these after timeout
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 09:15:44AM +0800, Marek Lindner wrote:
> On Monday, November 26, 2012 08:41:17 Antonio Quartulli wrote:
> > >  struct batadv_priv_nc {
> > > =20
> > >  	struct delayed_work work;
> > >=20
> > > +	struct dentry *debug_dir;
> > > +	u8 min_tq;
> >=20
> > If I am not mistaken min_tq is never modified. Why do we need to store =
it
> > in a bat_priv field? And being a constant is it worth a define? In this
> > way it an be easily found and tuned like the other constant params.
>=20
> It can be modified via debugfs:
>=20
> +       file =3D debugfs_create_u8("min_tq", S_IRUGO | S_IWUSR, nc_dir,
> +                                &bat_priv->nc.min_tq);

Oh, ok! I hadn't seen the "W" in the mode.
Thanks.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCzN6QACgkQpGgxIkP9cwdA9gCeNSMFT8fmD9pykQeew7duJfp0
GX0An2Joo/mS/E1T4s2R6D2R0UynxKMK
=vxTG
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
