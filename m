Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:29:46 +0200
Message-ID: <2997731.IzpFeo2qdJ@bentobox>
In-Reply-To: <20160823011316.18602-1-linus.luessing@c0d3.blue>
References: <20160823011316.18602-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1476792400.9qfQoBkifr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v2] batman-adv: fix batadv_forw_packet
	kerneldoc for list attribute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1476792400.9qfQoBkifr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 23. August 2016 03:13:16 CEST Linus L=FCssing wrote:
> The forw_packet list node is wrongly attributed to the icmp socket code.
>=20
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v2:
> * "Reviewed-by:" added
> * detached from patchset
>=20
>  net/batman-adv/types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in 06dc56bb9db09c0967066b7d6d1783436a53c23c [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/06dc56bb9db09c0967066b7=
d6d1783436a53c23c
--nextPart1476792400.9qfQoBkifr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgeqAAoJEF2HCgfBJntG80gP/0d8ZSVhQ51qK4MrbBzB25yC
dhN5WBWA4VSOoDkFg8GiKnsrL4fotTnY622Vok/t0STt5LEbhh1VCXeiRB30VRrd
RaplTefJh8huCt1dKi7eA14ecRvtQnH4b1DAmKZ0c7kKX9cFoM2JyQ09siW2NHpa
fU8gvtH53sm3lCuH71c8XvlFz9A0ROHjYO57wxCs5VwwVnDEDVSx7K2/HTbweQUx
ywiujAOMmT5OgXmjAHi28qwswRQ0LxsVbl14F/fFb1/IThEgGf+YUzJ+1HYmY7PO
N9GKKhqTp2Da7sxYffqVnHS9Dcf4WfsS4goUL3gLxGd4L62usxjyORk/nhs/VQ7A
IXcc6ks9g5476hAebE9h++V/JOFMrNE1wKhG4CIeh4Lc++qq39DZFJmuIzVUJ2Zs
1NywXRw1ZaMlkcAQAc29dP3iCldHjUx9IxCWOLx93pMWesu1GgXr5afmIMM3E9xR
Us2NL0sl3m2BDxODIOLHYhPpCvWd7s7za0bbQutnBgCZr8aldKgAa2F6V2DQLpax
NUAb2n3l1X/XP0hn0g03B1o737VvuQDhLJ1lHk+4SbynrAZ8mV3cLsDOS2YNOG6H
s+XZzF9eV95iJEDtR3maneIr0ugZk3mxYGr6sfuVQdybnvvPpxP5oLETKGyfF/8n
sZdS24t3XDnK6oBtd4HQ
=w5tq
-----END PGP SIGNATURE-----

--nextPart1476792400.9qfQoBkifr--

