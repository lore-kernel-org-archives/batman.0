Return-Path: <antonio@meshcoding.com>
Message-ID: <52A813C1.8070404@meshcoding.com>
Date: Wed, 11 Dec 2013 08:26:57 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <cover.1386738050.git.joe@perches.com>
 <e7104b35287b1e1ec456734c1b5e1aa98dac99f8.1386738050.git.joe@perches.com>
In-Reply-To: <e7104b35287b1e1ec456734c1b5e1aa98dac99f8.1386738050.git.joe@perches.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T9RiPpL6d9kUP2kj5H5iCLKUgUwIs1p7M"
Subject: Re: [B.A.T.M.A.N.] [PATCH -next 2/3] batman-adv: Use seq_overflow
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
To: Joe Perches <joe@perches.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T9RiPpL6d9kUP2kj5H5iCLKUgUwIs1p7M
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/12/13 06:12, Joe Perches wrote:
> Convert the uses of the return of seq_printf to
> instead check seq_overflow to determine if a buffer
> overflow has occurred.
>=20
> This will eventually allow seq_printf & seq_puts to
> be converted to a void return instead of the often
> misused return that is often assumed to be an int for
> the number of bytes emitted ala printk.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

I assume this patch is going to be merged with the others in some tree.
In that case:

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Thanks,

--=20
Antonio Quartulli


--T9RiPpL6d9kUP2kj5H5iCLKUgUwIs1p7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSqBPKAAoJEEKTMo6mOh1VHyAP/jCSeWzDq+NDUQzZ7l2Wf9Or
2iIN0wzyHpEy8YJxZb7Lzbpr78zaROWZPYAyIwqGHTi4fuOGXvYAAA61PpQyzfIH
gA7m7iqp3D95SFN2Dn47ymQKJBTsoaMty6iCA1wElk9xaD+jBLXAQsg1VTD0eYjk
qCoNLUqyznNh3yMlid+eGckwdlaiispZBl9Qgm2nVZBD0/crWMPdM/K+nwIrE7su
zQ3LTIMkjMt0+Qqp8MwKK0QOL/nzl+lauwyb7biLSeX9bpaWWkxicuzOfNgmeJ5R
rbLy42esJDhgJLyDb2zWTW9q+WAFBVvf/kmWXgi2wrIuThZmRdkhAZhAsv44IjSX
gdJ0EANYVOXzEaV15hnP87ykHxSqfHQRyzdiEgUumeh5dWi9cW7u2o5o6j8CCvs2
RVDS/hz/ous5VTljuiCACbo23SWi7UATh84xOMsrAY59RTXhbfX0nd4r1vgALOwv
W/mja1z6G0aL5wYV+3jn07oqKcPXhfnpfoGq9pM+W6uxgzXWgHVomFWVFvfXBfzO
qgowRpgHSJf5quthncFnQ5PrMX6FfQgAqbswsJfzZX1nulgbHwmB3D/9tpKaFut5
qlFnGMOOsXib+ntdZlaTI+mVM3nRY7ThErCezcMGDW4ChMRkQc/Xb04Wf+1UhGAS
8iez/gKHwAiMpB5drjQU
=Qmot
-----END PGP SIGNATURE-----

--T9RiPpL6d9kUP2kj5H5iCLKUgUwIs1p7M--
