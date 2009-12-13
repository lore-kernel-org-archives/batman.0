Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 13 Dec 2009 22:17:46 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091213211746.GA24826@pandem0nium>
References: <20091129200950.GA19275@pandem0nium>
	<20091130100902.GE10269@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20091130100902.GE10269@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Removing the big batman lock
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

sorry for the late answer and thank you for your remarks.

I like your idea of the static hash iterator and have got this implemented =
in
svn revision 1499. This should remove the problems about the memory leaks
with dangling hash iterators. What do you think?

As the patch obviously has some more severe problems (deadlocks etc) i will
have to review this seperately ... :(

On Mon, Nov 30, 2009 at 11:09:02AM +0100, Andrew Lunn wrote:
> On Sun, Nov 29, 2009 at 09:09:50PM +0100, Simon Wunderlich wrote:
>=20
> > I did some testing, including loading, unloading, killing individual
> > nodes etc, which seems to be clean so far. However there might be=20
> > more race conditions introduced by this large patch, and i'm therefore
> > requesting a careful review before committing.
>=20
> Hi Simon
>=20
> I've not done a careful review yet, just a quick look.
>=20
> Two idea for improvements:
>=20
> In the purge code, add some debug code which looks at the refcount
> value. If it is not between 1 and 5, prinkt() a warning what there is
> probably a missing refcount operation. Since the purge code does not
> run very often, it should not add much overhead, yet it is still a
> useful debug tool.
>=20
> The following bit of code happens quite a lot:
>=20
> while (NULL !=3D (orig_node =3D orig_hash_iterate(&hashit, orig_node))) {
>=20
>=20
> There is also a comment about having to free hashit, if you don't
> iterate to the end of the hash. How about refactoring this, more like
> the linux list.h.
>=20
> Make hashit a stack variable, with an init macro:
>=20
> #define HASHIT(name) struct hash_it_t name =3D { .index =3D -1, .bucket =
=3D NULL, \
> 	                                       .prev_bucket=3DNULL,           \
>  					       .first_bucket=3DNULL }
>=20
> and a macro for iterating over the hash
>    =20
>     HASHIT(hashit);
>=20
>     orig_hash_for_each(orig_node, hashit) {
>=20
>     foo(orig_node);
>     }
>=20
>=20
>     Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkslWfoACgkQrzg/fFk7axYKTQCgvmACwQUgA4UQwpIrfnmLowhc
JV4AoOf98fijxhulcu33WN8iffFBGFDo
=OaRS
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
