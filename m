Return-Path: <antonio@meshcoding.com>
Message-ID: <558839E0.50201@meshcoding.com>
Date: Mon, 22 Jun 2015 18:37:52 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434904223-10227-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434904223-10227-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8NW9LVp5M30DpxlwFK6xVrjwFtN9EtNPe"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert
 orig_node->vlan_list to hlist
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8NW9LVp5M30DpxlwFK6xVrjwFtN9EtNPe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/06/15 18:30, Marek Lindner wrote:
> Since the list's tail is never accessed using a double linked list head=

> wastes memory.
>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--8NW9LVp5M30DpxlwFK6xVrjwFtN9EtNPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViDnkAAoJEOb/4TMchkvfuCgP/AiBNYw7+v/tDLhlldg44H1r
Xjbkm5IXdoZrFCtPi9l8uyJqBXQlo6arXHTiDyUfEKYneZUyEXKZvzrXWq2XnmqW
JSf5+Fk8WUtY90JMNz9VL877UoNpD9WzIhK2w7wEQbBhng7DsQrsoFkvaQrnXP/N
O9/mzVBzyNb5Ac4dMTv/3dMIBxCTchm3/qEST5W7I6YJxDi9Y+oN7ZNnVaY8XiZs
MaeQxpYMzbvsKea9fnOEfEC63F+PgfJa1JVj023YBAGMpBwd2ah2JqJHNt1td7E6
j14tE2rmuDYwSMCa7mYIwHry6iH/Yx3z7xGUayqpVS+8LdqUQuPg8MfxZ4+1Vk6b
OkZtvQN86/f1a5suddoW3VtOQiuQxKvagfd7le7TcsxMGad7TmGxZcZ6mB6vXKbO
8XF0268fr9/I2KxabpSrFcCJ5GMy/kBSicOODmirGfSzwuabXTM66NINVN5sQyat
ZrBFjOxwfN9KGYy1gBK9W9jQRqmRaLKeI7THEgffHHDXA+vgthUT7Y0DPk0cJK/z
U5pFL6a8vI1aA7S45UxIN2U1I0i03WQhoVqzYVDNz70AKLQ81R9Fgp5X4BA+qPBE
GZEkYGbYM8AYVXQuO/BWJSkFhS4LYHc2XpIXHIFiafuZbXtwZVS5xS+YBtFuPZKX
Wo2ufriX8hySy1fHxwcd
=pbq2
-----END PGP SIGNATURE-----

--8NW9LVp5M30DpxlwFK6xVrjwFtN9EtNPe--
