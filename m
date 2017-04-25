Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 25 Apr 2017 08:28:05 +0200
Message-ID: <2078695.3vj4edr7gq@bentobox>
In-Reply-To: <20170424200331.21660-1-linus.luessing@c0d3.blue>
References: <20170424200331.21660-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3418767.XNdOnFvnvy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix compilation for
	kernels >= 4.11 on Debian
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
Cc: "Dmitry V . Levin" <ldv@altlinux.org>, Manoj Srivastava <srivasta@debian.org>

--nextPart3418767.XNdOnFvnvy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 24. April 2017 22:03:31 CEST Linus L=FCssing wrote:
[...]
> It seems to occur since:
>=20
>   "uapi: fix linux/if.h userspace compilation errors"
>   (2618be7dcc, Linux 4.11-rc1)
>=20
> Simply including an empty sys/socket.h makes the kernel module compile
> again. (The #ifndef __KERNEL__, which kernel-package / make-kpkg
> stripped, should have removed this include for kernel modules anyway.)

Hm, sounds again like something which should be fixed somewhere else
(not by batman-adv), right?

Kind regards,
	Sven
--nextPart3418767.XNdOnFvnvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlj+7HUACgkQXYcKB8Em
e0Yx2xAAxqgN+/8MxIeSbbeXqfmU2BjIrZHwnS3C6P/0UjaObYUbUFZmhW8Qsmrj
4rfy8qSWfilIZlHZwWc+StEG045SgL3cYTVUunPKOOYv9l6HHdmZ10JzxlnC3I7C
8q3Ae5lLhUReRrOZgm/Ijanfp9YE0SCTXHZu6xL0yBrCThQHC26DQPgGn/b8Ulwo
v9IRozmL0+eXwxX6BKBt1HhR3J3csHNY2YGUfvKd/ocpO6D2BIMa3XNCl/gDqkQ3
7mZ+g5zUJ3TATYJR3aZ/VWq8ZX6XQGwn0UexJvFBePC+ucFwK9YeH5BPvnRsPhRn
ukaJ/RsY8b86K0Kz5ADteK52Doc2y2TusNmDT+7RiO8y44/lUebyEbNM+UpLjV+Y
v+FZqpNAkzpW0i47AAsKIgOI4bf9qpKpoHZIzN3KHu8Bip9cV2VLvRpfV/QGuTjw
BG0ZFwbl3n+LO7LcTAwH5rIAW5zb/bwCU+DVGj78u4Pi7yKIFRMMea0MtLSD8gFD
5POR8p/gDWkjotX8x7HX+aQGXQPCsxI/gGkS7uH0H6kFFBpsksvY7mDTOVE3gs4X
cmL63FxqUErpclxW/YMwnEovepUOHMc3n4OzIxNsftHmtsEV55PKYosWzG48vP5F
DzzdxHjjIjAWcs27KzMKyYfGg4FzsQOnz5cZfkC6rbfE5yMU91s=
=OJfO
-----END PGP SIGNATURE-----

--nextPart3418767.XNdOnFvnvy--

