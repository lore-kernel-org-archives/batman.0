Return-Path: <ordex@autistici.org>
Date: Wed, 3 Oct 2012 23:18:00 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121003211800.GH10663@ritirata.org>
References: <1349282136-23059-1-git-send-email-ordex@autistici.org>
 <201210040106.55685.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
Content-Disposition: inline
In-Reply-To: <201210040106.55685.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: export compatibility version
 via debugfs
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


--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2012 at 01:06:55AM +0800, Marek Lindner wrote:
> On Thursday, October 04, 2012 00:35:36 Antonio Quartulli wrote:
> > @@ -355,6 +366,13 @@ void batadv_debugfs_init(void)
> >         if (!file)
> >                 pr_err("Can't add debugfs file: %s\n",
> > bat_debug->attr.name);=20
> > +       bat_debug =3D &batadv_debuginfo_compat_version;
> > +       file =3D debugfs_create_file(bat_debug->attr.name,
> > +                                  S_IFREG | bat_debug->attr.mode,
> > +                                  batadv_debugfs, NULL, &bat_debug->fo=
ps);
> > +       if (!file)
> > +               pr_err("Can't add debugfs file: %s\n",
> > bat_debug->attr.name); +
> >  out:
> >         return;
> >  }
>=20
> If we start to create more files here you should add a a loop like in=20
> batadv_debugfs_add_meshif() to avoid duplicate code.

do you think we should do that for two files already?
I do not think there will be so much to add in this debugfs folder. Maybe
we can add a loop as soon as add the next one, but for two I think we can s=
till
leave with this implementation.

Don't you think so?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBsq4gACgkQpGgxIkP9cwfnuACeJGYM0IC2D6UWKL6ARk1wMATm
6KQAn0WLZsT6OtuV68ac23d3ucRcsehk
=alaf
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--
