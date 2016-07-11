Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Jul 2016 11:38:19 +0200
Message-ID: <12344489.b6hFVBHYRz@bentobox>
In-Reply-To: <1468228596-18690-1-git-send-email-linus.luessing@c0d3.blue>
References: <1468228596-18690-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7693490.syTgnnCCEj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use bitwise instead of
	arithmetic operator for flags
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

--nextPart7693490.syTgnnCCEj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 11. Juli 2016 11:16:36 CEST Linus L=FCssing wrote:
> This silences the following coccinelle warning:
>=20
> "WARNING: sum of probable bitmasks, consider |"
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart7693490.syTgnnCCEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXg2kLAAoJEF2HCgfBJntGYkgP/1bf4PsxdFVpiSetCP4dhwFn
ZkC8NNXIXU8dqjjNqmaMnpjxnX9MUwtoNrJmo8ixUQcWNI7ypl0TH5QJiCGi0o/n
7oUbycYv7ZGqWL0z19FqpL8g1YR3TaRoRQew2HHTBz4rYH3PuYm2IKAEsIFDSttg
PdQMR5Ez0ycUaPvc1YuU6zBQ1I/KbtCMNof/eSntKs256ykhXozubUT2bZvjUU3v
dwpwP5YoDXWX+gJn6bTo4LjFdV8ljldXyu1p3FiaTQWFaYio1AwR7iL9ZKolpR8D
Cy+4Bhjhn/5vun3/4Jay7Mw52LdhRgCD/fhAy1rEUrIVRJZgYDEtRfhC0Ti8KWvx
Mq0a9gZyuUR65P9ViG4tldV5gH+oEHMKKN0/EDN1lwoJoThU2qbOzUDwkd+RsQGQ
R+8R4/e7FE6shCgrGqtZyf/RSgjjtqGTCqtaGRlGZuuEoUjCY7qEzbSJhjE90gy1
7TgVu9i2Dx73ko4iWNuAKsbAfYw5+V2wVrBnE28DxjAwJC1Fe25JFCtWvlM9gnYe
JGiFhLFaa6p/J4/C17IqRsaBFsTbrMCgA6Aus/zWCc4tBv3BYoqSHA960lGoIfFi
A053uqJx7TKvhnjBRiz+vWEwTfE/uv5JEsxaCXhDB8nHxyrjX0Lf8kyJk1Vr2EKw
nN/fKL0tVZI0HgNXJ8ck
=ShgW
-----END PGP SIGNATURE-----

--nextPart7693490.syTgnnCCEj--

