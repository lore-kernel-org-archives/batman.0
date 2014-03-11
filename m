Return-Path: <antonio@meshcoding.com>
Message-ID: <531F7222.2050401@meshcoding.com>
Date: Tue, 11 Mar 2014 21:29:22 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1394526073.90768.YahooMailNeo@web142501.mail.bf1.yahoo.com>
 <1394540404.89540.YahooMailNeo@web142502.mail.bf1.yahoo.com>
In-Reply-To: <1394540404.89540.YahooMailNeo@web142502.mail.bf1.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c0eWPX3js2Mx7Ed69NotGXFlQBjFPnGUL"
Subject: Re: [B.A.T.M.A.N.] batman over wireless bridges
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
To: Tom Sparks <tom_a_sparks@yahoo.com.au>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c0eWPX3js2Mx7Ed69NotGXFlQBjFPnGUL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 11/03/14 13:20, Tom Sparks wrote:
>=20
>=20
> I am wondering how well batman works over wireless bridges
> like this:
>=20
> batR <--> wifiB <--> wifiB <--> batR
>=20
>=20
> meanings:
> BatR: openwrt router with batman installed
> wifiB: wifi bridge


What is a wifi bridge? How is it configured?

batman-adv uses the MAC addresses in the 802.11 header to understand
which node is a direct neighbour, therefore the bridge in the middle may
screw up this mechanism. It really depends on how the bridge is
implemented (it is not a standard component).


Cheers,

--=20
Antonio Quartulli


--c0eWPX3js2Mx7Ed69NotGXFlQBjFPnGUL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTH3I6AAoJEEKTMo6mOh1V7qoP/A1JLhVAM52SeeWeOXVYPX/B
qitY1DcRy0E58UEJ9UpBdBpYZzj5XLHPmlm0QrZA0jWOpqzV8PTQTs/cyFhiS98t
DqMApwfNL+jeDrsV/dGwyiaHn1DN41UrYADdr6j8IwsjFi2sDTwCNI+MgWgxbNVz
V0z0cb65raJGt7gG1GqshYRuGtXzNUs0OTYYEvPc0ezWD0KAyd1OiE1ysUcfNuz1
MTkcao3dFF34ukDwTNyE7vPbr/CyyxYkRTpEbDpQ/BS52I2lBGlbMupTWMj9dZEp
WYaKr3KCUeE61oZtFiTWZdAg1RGtKf8fVGLdZ+s39rR14l17/hXvQuw4YbsFn6dU
b8uO0yD9kpdDHJ+HzLM4JQinrFHziG1dLaxvWDRwm4PtX5hQwGhkswQb06pXyE47
iuu6UewauIh50l+SAt9ZYFyERAhGtTz+xL13IElkNxXzA6Uzlx1Py6kPK/pyimdH
M/eT6zxfldY4CpB+tgnf6NiTFJrVhDsrCqOGMezZ9jvhJ8bvoV1d+9/25LGD0Yl6
Vnm7JWW8QWWWEsQKMJNOugbkgxE3/vsUdOcr07sqIzAcuMJmjeLdSL6ZBhyy9o5g
bJ6pnvKQYmr/VguMoRN2e/DYED9emWWJUKFd+T16NAoNnzAKu5uWzhROSpWQ0/zd
axGQ59FhqHyQ5q0GzeOV
=t29c
-----END PGP SIGNATURE-----

--c0eWPX3js2Mx7Ed69NotGXFlQBjFPnGUL--
