Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 5 Jun 2010 13:19:12 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100605111912.GA8249@pandem0nium>
References: <20100525225411.GA23108@pandem0nium>
	<201005261239.35972.sven.eckelmann@gmx.de>
	<20100604163704.GA5425@pandem0nium>
	<201006042256.51777.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <201006042256.51777.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: bonding
	and	interface alternating
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sven,

On Fri, Jun 04, 2010 at 10:56:50PM +0200, Sven Eckelmann wrote:
> Simon Wunderlich wrote:
> > I've also followed your other comments (hopefully correctly), so thank
> > you very much for the review.
> [...]
> > > > This is an experimental patch and targeted for upcoming experiments=
 at
> > > > Wireless Battle Mesh v3 in Bracciano/Italy.
> > > >=20
> > > > Feedback, comments and reviews appreciated!
> > >=20
> > > That part is quite interesting for the mailinglist but should not be =
part
> > > of the commit message, or am I wrong? In that situation such informat=
ion
> > > should be appended after the "---". git-am or similar tools should
> > > automatically ignore that parts, but the receiver can still read that
> > > comment.
>=20
> That "---" part was actually meant for the mail and not for the svn commi=
t=20
> messages. It will not be stripped from commit messages by git-svn - so it=
=20
> remains in the git master branch. I have removed it manually from my reba=
se=20
> branch - please tell me if that wasn't what you wanted and I will re-add =
it.

Oh, okay. We don't actually need it in the commit message, this was more an
internal notice, so it is fine to keep it out.
>=20
> I noticed the "The patch also includes a bug fix...". What exactly do you=
 mean=20
> here? I would guess that it is only this part:
>=20
> > +			/* we only care if the other candidate is even
> > +			 * considered as candidate. */
> > +			if (tmp_neigh_node2->next_bond_candidate =3D=3D NULL)
> > +				continue;
> > +
> > +

Yep, that is the bug fix. ;)

>=20
> But nice to see that the testing resulted in an even more compact patch w=
hich=20
> is better readable. :)

thank you. I'm also happier with this version. ;)

best regards,
	Simon

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwKMrAACgkQrzg/fFk7axa+2gCg0dKgcNfHDTi5z2VdHXgH0hrm
0doAoPBj9h0C3MA96zJvi4XQNP3GFm2b
=PTul
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
