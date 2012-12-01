Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 14:11:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201131108.GL24115@ritirata.org>
References: <1353715332-4284-1-git-send-email-sven@narfation.org>
 <1353715332-4284-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8kI7hWEHMS8Z+7/0"
Content-Disposition: inline
In-Reply-To: <1353715332-4284-6-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: Allow to use rntl_link
 for device creation/deletion
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>


--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 24, 2012 at 01:02:11AM +0100, Sven Eckelmann wrote:
> The sysfs configuration interface of batman-adv to add/remove soft-interf=
aces
> is not deadlock free and doesn't follow the currently common way to creat=
e new
> virtual interfaces.
>=20
> An additional interface though rtnl_link is introduced which provides eas=
y device
> creation/deletion with tools like "ip":
>=20
> $ ip link add dev bat0 type batadv
> $ ip link del dev bat0
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Hello Sven,

why are we adding yet another API? What's the purpose? Is this intended to =
fix
the lock bug we get while using sysfs?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8kI7hWEHMS8Z+7/0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQugHsAAoJEADl0hg6qKeO/sEP+gIHQAeCWX2R3R3H1FjQ3Kzi
U7BxJ0BgAhqWbOiGmT3BPJZhsYQy/pDtQ3C0GJaTVl0lGlakm/5/F8m8rkckg0Ky
7VBfRsppgmwz+dbkJO4vZoIE0oiSJ5Rjsclsnor03g2M8GHdqsmTJUMUlBp8/kAE
0t3UVpgGlL44xHJUz76mqhHYLwd7wQaPiwLQ+njP9adtPiC157wJJlPGJMjjwXT7
pYseZOX5WjlbZfZI0uNeUOIgEDGFemeuCrC+/pr1UWWjBTM3m0nvUDAUQelvSvVI
yrrr7fQFa1FjMjXOQlC3pzYFVWvRioOVAvKPhwEFN3M2BPYPcyVIgqbb66/9T7a4
BJ9a0fRzpFGY4+XUgT2Eaxe4nfAmtrLcoxxUZCfrstgVrK4RzbA5SLybIX4HUAXQ
4uA53pJylic5luEK5JEV4BaLWaLxy8Q0eyPPlwhViOJ6os8XeOqjU5Ylb+Pc+a8c
OWa3s8Hma0rrMStjTNEmKbB0zOOYiQoL9auIfvz3g7CVvnH3xggwrVLrkFGj1bUg
FISqbTClbhmAUiHBVfkQu6jKh37IpHMOMEjMG6PPGb8RApkOgq5Ob4wJPu4ZOg2r
e4OclRJCjnPfksDq4zfNZHFWZp7KJbJbv3dfZOoJaM7Zd69yOFGH8l2PjgrIHX4d
De5iYtB3zgvXltSZRD3v
=dQFY
-----END PGP SIGNATURE-----

--8kI7hWEHMS8Z+7/0--
