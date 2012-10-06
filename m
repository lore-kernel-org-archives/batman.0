Return-Path: <ordex@autistici.org>
Date: Sat, 6 Oct 2012 21:29:53 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121006192953.GR10663@ritirata.org>
References: <1349550683-22892-1-git-send-email-ordex@autistici.org>
 <201210070322.09980.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LXqH7sWsIplhrbjF"
Content-Disposition: inline
In-Reply-To: <201210070322.09980.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batctl: add support for the DAT
 local table
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


--LXqH7sWsIplhrbjF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2012 at 03:22:06AM +0800, Marek Lindner wrote:
> On Sunday, October 07, 2012 03:11:21 Antonio Quartulli wrote:
> > --- a/debug.c
> > +++ b/debug.c
> > @@ -64,6 +64,11 @@ const struct debug_table_data
> > batctl_debug_tables[BATCTL_TABLE_NUM] =3D { .opt_short =3D "bbt",
> >                 .debugfs_name =3D "bla_backbone_table",
> >         },
> > +       {
> > +               .opt_long =3D "datcache",
> > +               .opt_short =3D "dc",
> > +               .debugfs_name =3D "dat_cache",
> > +       },
> >  };
>=20
> How about adding this entry to the "can be compiled out" parameter list ?=
=20
> Check "fs_compile_out_param" list in functions.c. Same applies to patch3.

Oh right! Bactl is getting better every day! :-)

Will send v2.

thanks!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--LXqH7sWsIplhrbjF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBwhrEACgkQpGgxIkP9cwdjfgCeN6mvqUTN58vizd6KDjAkJmt6
SiMAmwULZHYJnh6pM5ArKF/bTSL+xY7m
=aaX5
-----END PGP SIGNATURE-----

--LXqH7sWsIplhrbjF--
