Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Mar 2017 12:55:37 +0100
Message-ID: <22921287.EDBOfWLgxC@bentobox>
In-Reply-To: <20170308114359.26916-1-sven@narfation.org>
References: <20170308114359.26916-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2232197.HjOGGuYrDW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use __func__ to add function
	names to messages
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

--nextPart2232197.HjOGGuYrDW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 8. M=E4rz 2017 12:43:59 CET Sven Eckelmann wrote:
> The name of the function might change in which these messages are printed.
> It is therefore better to let the compiler handle the insertion of the
> correct function name.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/tp_meter.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied in 9f363d7edd25ae73fa7dc5fef30db71a55c27c32 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/9f363d7edd25ae73fa7dc5f=
ef30db71a55c27c32
--nextPart2232197.HjOGGuYrDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljLzrkACgkQXYcKB8Em
e0aXMA/+IECzvF2VHq7K2lf1yW9+78zAfSbqwpDbHxLUOCaMEr4c6joKnN3zYPUR
lCM5RU7CkQzXXiLvCjp+oWSQLjCJWBi7i7H8u9BG5VLCDfFFnIo6SobS5wBMRiYD
UYbed9JRufU8rO5g03sDGV8cEHzHfv4mhugAJPI431tJjcZ+US1BM0+Qt8o7+BgD
GZC1FQgJ1syBwa8U1n/oKS8xbUwqoTnPQRYEWttR5PHR3owKeQ+KhQQiO+aIVWnV
ZROXHCeuMZnQhHTNiZK7fSq2LZdHvXlRwD2delUttQMSkcadp9+eLmQof+3BnGQy
sZosO82Qma2qxG1IuXcTOzcvIaxoPGzkE1f79InODoUhYM5PGlV476SUE5//doZ+
WrWTK2cm7Yv9XgqXb6mBVVUTW+sszMnlHVqvANm66b7O7urX+B+qHwVVIyrTXIBe
K4sgxbfIk025eoOox2CN5/8KVcQnF1CglJwdhg8oJ4J/cISMe6Rhjqb4r8bqoL3q
peUtbbKtQ14Q9dJdUpwQDtTqp3eJzvhCwghsvyg1Yl+qtwMwgwXzCxojPnY8jJI0
7MQD2bNa6ukbc/099SsmGJSvLtX6QKKzSU3ZI77asAS5PQkcoAeSwaAaTF8XSDv8
9qhqkxUeg25C3vhye9N2tg6/JOaMMSuigWuYimD/EkYbb+Nvmqc=
=/WaV
-----END PGP SIGNATURE-----

--nextPart2232197.HjOGGuYrDW--

