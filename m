Return-Path: <ordex@autistici.org>
Date: Wed, 5 Dec 2012 12:32:25 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121205113225.GF27828@ritirata.org>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch>
 <20121205110642.GD27828@ritirata.org>
 <20121205112435.GE26922@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O9uFcEIpmYvy18ul"
Content-Disposition: inline
In-Reply-To: <20121205112435.GE26922@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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


--O9uFcEIpmYvy18ul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2012 at 12:24:35PM +0100, Andrew Lunn wrote:
> > I think the major advantage here is that, whenever a person sends a
> > patch which is not going to work on older kernels, he must also send
> > a patch for compat.h/c.
>=20
> Hi Antonio
>=20
> This is where you are fighting again the kernel process. The kernel
> process does not care about older kernels, expect for patches flowing
> into stable as bug fixes. So anybody from outside of BATMAN will not
> supply such compat.[ch] changes.
>=20
> Maybe its also time to evaluate the value of older kernels with newest
> BATMAN? Is the pain worth the gain?=20

Well, at least we have to keep compatibility with some releases: most of our
users are Openwrt users, which means that we have to provide at least provi=
de a
package (with all the bugfixes) that runs on some of the openwrt distributi=
ons.
Maybe, to alleviate this, we can think about dropping some kernel versions =
and
support only the most recent.

However, as stated before, this is more or less orthogonal to what we Sven =
is
proposing and we want to change now, but still it is a valuable suggestion =
that
we may want to keep for the next step.

Cheers,

>=20
> 	Andrew

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--O9uFcEIpmYvy18ul
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvzDJAAoJEADl0hg6qKeOuE8QAIvceBUZ3s9vRFzmpXlcHCRz
r1ksflnnxGuGRHfS3mp7JBdkRTmOc3nYcuF4M6zBHsDX5rEJpuIELR1jiBPE7Fq2
UBm8cligJRZanSvK1iWyAgRmUAA347S1m6phi5Od8vj77z3fqLdpHr23dy96Kj/R
3eL6b9d1w+9aECXf3DgIMBpznRuOWpQEy45Qi9NsBPjjRluztmT6C69WKlN64Xw7
TbugXcM9SribY+9F5SkKOU6JDTXTJ456O3UT8fLxyaCYcaVlsN+8/iZvzdKEJ0JP
PAgeQdJ47QAtv2x4QN01dJHBYPHI84HEuOUwuw7dglgt/sluAgE6amhAf/B9y1uM
dKoSNrXwaMzgUvCZ/Xe246CGJSPos8TvzEUvdGIJv+dV+gkU8Rkh+td33dK5YRHG
1QF+F2zq70WXvSL29kwykCBVb+53G9j0tnFXKJ85nY3MZ1jDAtxQeJbLwDRF105Q
EE4TsxCkFYKdardV6AdEmkin+fUUCL57J1cuP9/nq0fA4oufjRWqkNB6S7MQhPVK
jXW3Faw6VFu9LG94+NvyIpXYWc/lteDsCKl5MLJ1G4Rtro0uoVx2weh1kU1nioy7
d0EYqjFzEKoETXILCPkAWyRRhVvDb9VYA/QnQcjB2BrMi5LMCmSi+TGqw7rAcISf
1tEgYzkR0MT0Px9aJq7p
=w3dw
-----END PGP SIGNATURE-----

--O9uFcEIpmYvy18ul--
