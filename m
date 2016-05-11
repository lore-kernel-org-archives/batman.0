Return-Path: <a@unstable.cc>
Date: Thu, 12 May 2016 05:14:29 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160511211429.GD21549@prodigo.lan>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
 <1462962557-23950-2-git-send-email-a@unstable.cc>
 <2682043.NtWpdVDLGQ@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <2682043.NtWpdVDLGQ@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: B.A.T.M.A.N. V -
 implement hard-iface init function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 03:11:53PM +0200, Sven Eckelmann wrote:
> On Wednesday 11 May 2016 18:29:17 Antonio Quartulli wrote:
> > diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-inte=
rface.c
> > index a8cda76..a757229 100644
> > --- a/net/batman-adv/hard-interface.c
> > +++ b/net/batman-adv/hard-interface.c
> > @@ -15,6 +15,7 @@
> >   * along with this program; if not, see <http://www.gnu.org/licenses/>.
> >   */
> > =20
> > +#include "bat_algo.h"
> >  #include "hard-interface.h"
> >  #include "main.h"
>=20
> Can you please use the same order as described in
>=20
>  https://git.open-mesh.org/batman-adv.git/commit/7df6200927271862dea5b66e=
24b2b08fa6ea7739


Oh sure I can. Thanks for pointing this out !


Cheers,


--=20
Antonio Quartulli

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXM6C1AAoJEJ4aZjxxc6bKXegQAL/c0lQ5st56Mof2P3TSOQyn
rfRV7If+RpHJGSD6f0p9SvYB8zfZV6upXfQxOexUY01tD8aceicYlu7I5akhXw7/
5II+6DH+lhuaeGg5bRMIvL1M+rmOM4ecygLbzB24XmtNtrDd41zaHXXbbN5q9tGK
CHpbXqw8yuwGJf8fHlHAEmm1Tw7yxpSroLuZ8o+2oydm01mb/NIg/8rxi5KEelIa
sd3MXoqJ5Cep5c8satda8eno4plsfIPMg2nrAuj2yewSYy2VpVaGbJklpxqq5Ya9
T234hXbwf/2PMWe3RFrWvBIoqeYs46YcdE140X3+KdDVrb0WVE4huoLzTgdfy1QR
RbX06+r4lTlqBxJ7AT690+hJQEYzdNwoNgtebO1tomwF0nXE8MC7w1frar2UrYMG
sBwDjPha+vdbGxtMXGIMftMviySEfTQUzaZ2s2SSI9KApazJJ0FLfZvWKVpcsaYn
myxBiyOAvJHYNcTlApgggPWRkyEn8FLPYAu7RqRYmv2NRs+IjOn+oaLbvO2QlmpL
zXFLcBj6j7L27UxScqRc7AI3Jrxy9ZYw0o719+LMGfOA3d6eYc7BbPdaJi9kAkzg
bt+/n2NQ9I1suGOiniiDOM9gbkEDgNopxMqfIjmwOJILIJT8GCNX8fBq2On5IW/Q
n9SqGzNgn2bKdj4WvqjH
=z6/y
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
