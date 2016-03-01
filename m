Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Mar 2016 17:54:43 +0100
Message-ID: <2589855.Wxd0lgVuKV@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8095816.PxLPp5CbeP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [RFC] EOL of kernels < 3.2 and removal of support in
	batman-adv
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

--nextPart8095816.PxLPp5CbeP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

the oldest kernel still supported via linux-stable reached its EOL [1].=
 It=20
looks like also the distribution releases with such an old kernel are s=
tarting=20
to die [2]. So I would propose to first disable the checks for kernels =
< 3.2=20
from=20the daily build_tests [3]. Then someone would have to change the o=
ldest=20
supported kernel in README.external and CHANGELOG. The last step would =
be to=20
remove the actual support from the compat files [4,5].

This would remove 13 of the ~38 supported kernels. Or to say it with ye=
ars:=20
The oldest kernel supported will only be 4 years old and not anymore ~7=
 years.

Any opinions about that?

Kind regards,
=09Sven

[1] https://lkml.org/lkml/2016/1/29/647
[2] Debian squeeze LTS ended on 2016-02-29
    https://wiki.debian.org/LTS/Using
[3] https://patchwork.open-mesh.org/patch/4588/
[4] https://patchwork.open-mesh.org/patch/4592/
[5] Yes, this should remove the really fantastic warning
    "subtraction of functions? Share your drugs"
--nextPart8095816.PxLPp5CbeP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW1clUAAoJEF2HCgfBJntG0h8P+wd4ciol3+6WsLnLF8gvzWu3
iEPpQ0d1Jpp+83UfR7oE42JMB+mNBhQDwLgfH5VyKgBNe45pIEsrTmyK5tNpQTtE
caVQXDLGlDqBeXmJ3mAbM9dxRPSkRsYWm4KVhpn7z9fHSwqze2mbUbMjAhVR9XQ7
GcDcGsPhFvB0rZsRUqGsGGtc/aANgiNpZbYQxu6qDkLK9rWDJenv+ppjXAkaTgYR
m5m+n9KRRCtalctvXqRGmXiMjVg7jOlXU6yZNVR5aEN0UuPJTx33WQ8NRKxY/Iyz
NOpuJm600WmzsiAgnyBrsyh74NNqYxK73d/q7MDB+yHW5EOJy6tYiiS0Wo8vw7Xn
SHlnTwpNFSN7Aaea7r7daOA80jIwWd4o/Qax6qzBPiI/bipWFWQn5Ct90fPZYGjk
A3ScB7JVBz0J31JEwesZ/aYqJ4fly35L6xJ4Hkg37V2q9QE2+VNUex6pGaT1y9OT
Th/UQ1NJ6HGi93n4uKetrYvcBqMZckpski3oBV6A0C2hCN1VhXIEmI3EfPP6FTUe
Bx1Ws1oseBsrmAhISdZ7YQGeqm0ExSvPZT1bHwW3LY0vcHaC7p4LA2net4r/u+nB
k/qx67pE++o4HHRRujFje+fpVvCK0DsgDhsYbvrhmfuUA0vpREFA88uTgAwsQ9oh
DIjFcsZGd0gbS10G1eKD
=FwEY
-----END PGP SIGNATURE-----

--nextPart8095816.PxLPp5CbeP--

