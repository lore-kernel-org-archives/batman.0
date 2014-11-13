Return-Path: <antonio@meshcoding.com>
Message-ID: <54647E04.1070004@meshcoding.com>
Date: Thu, 13 Nov 2014 10:46:44 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
In-Reply-To: <1415815109-17111-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vJhKRanlMncOlxnjcObjQXTeoS6l3FG7L"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batctl: Fix crash when parsing
 unknown TVLVs
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vJhKRanlMncOlxnjcObjQXTeoS6l3FG7L
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/11/14 18:58, Sven Eckelmann wrote:
> batctl tcpdump has an array with all known TVLVs and versions. The corr=
ect
> parser for the TVLV is chosen by getting the pointer from the address
> calculated by version and type. Unfortunately, the version and type was=
 never
> validated to ensure that not an unknown TVLV (like mcast) was received.=

>=20
> This missing validation makes it possible to crash batctl by injecting =
packets
> with an unknown type and/or version. batctl will try to get the parser,=
 fetch a
> NULL pointer or random data and then try to dereferenced it. This is us=
ually
> handled by the operating system with a segfault. But this might be expl=
oitable
> in rare situations.
>=20
> An approach to handle this problem is by combining the simple selection=
 step
> with the validation step. Only valid version+type will return a parser =
function
> pointer and the requesting function will only call the parser function =
pointer
> when it got one.
>=20
> This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c2=
8ef
> ("batctl: tcpdump - parse TVLV containers").
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>


For the whole series:

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Thank you very much for your work Sven!

@Marek: the offending patch is in next, therefore this patchset should
be merged there as well.


Cheers,

--=20
Antonio Quartulli


--vJhKRanlMncOlxnjcObjQXTeoS6l3FG7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUZH4IAAoJEJgn97Bh2u9e8QsP/iWVpNopoOjJ68hIWxiJqAyY
c0im7lPlFilK+DwHYFw3XuuSU8z94f9H9PIUHNvdWmhV/Eg+lFof8+0CE3q6W+W9
h9v1mIoTOVoTd4cC++U78dy4k3LczO9HqliPq1cD0nmN12v37cUeUva6LOp7jd0a
zN22KsjMlIx8nzNrx4d8zxuydX7acxZaAsgUUzMoUECU80FTJtRCWI5cWLhfOo8A
bcl6EutLHYeEGU9CvEBU8wVULRt5iyVfJce9/2SvuoO3I0ajUpNY5UPXwCnY7/Yh
qwCTh25bfhTiHVQzuZy6xUaXbovs+Ca96+e4hJVJRXMIKJa+U0i0gMfci9zOX0R7
FukSvYeQi6eUoB41fxDi4Yzu1z6FlFIvd54vzhpStpp1FKV8cT2TfPFtae48BZYH
XZuN8G7gFQHWjks/hAA6XDyJx1J/tQ+0xychTOOCt/U7rvxu8dlrxzC/kHHTh5+B
xeC4o527nom7Xxe7qkxZOcXgYvCokA1fTye2mYoC9GOIcPjnOyjuMN20Xucoyr6n
jQy4Esmo6zvyItsfryF24a00LUVUwPQwG/pac/bQSNTV1PiH2RlbZfeT95x9iqWt
R4XJEBj9j9V9dn96dB9yjn+Eo9iqCfHxkYOR5/beFg9gSmo0ZL1tCn0f/Rb4mAC1
32rvkDaFc1NS3Lvrv7ky
=XV/3
-----END PGP SIGNATURE-----

--vJhKRanlMncOlxnjcObjQXTeoS6l3FG7L--
