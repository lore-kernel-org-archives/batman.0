Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 14:43:34 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2050210.KtUC2VHfPU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906221443.38100.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Clarification of version number in batctl/main.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart2050210.KtUC2VHfPU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I just wanted to ask how to interpret the current version number of batctl.=
=20
Does it mean that the current version in svn is before or after a possible=
=20
0.2-beta release? Is it important for me because debian differentiates betw=
een=20
before and after something. For example 0.2~beta would mean that there is a=
=20
beta version before the 0.2 release. So I wanted to know if should call a s=
vn=20
snapshot of the current batctl 0.2~beta~svn1317 (svn1317 snapshot before a=
=20
possible 0.2~beta release) or 0.2~beta+svn1317 (svn1317 snapshot after the=
=20
beta phase has started - no beta version will ever be made available or has=
=20
been released already).
It seems that the 0.2~beta~svn1317 is the more "correct" version as it has=
=20
less extra rules than 0.2~beta+svn1317. For example there must not be an ex=
tra=20
rule for events like the release of 0.3.1 of batman when Simon changed the=
=20
version string to 0.3.1 in 1177 which was before the release of 0.3.1 and t=
hus=20
shouldn't be called 0.3.1+svn1177.
Can this be interpreted the same way for all other on open-mesh.net publish=
ed=20
hosted projects? So if I would create a snapshot version of batman it would=
=20
have the version number 0.4~beta~svn1309?

Regards,
Sven

--nextPart2050210.KtUC2VHfPU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKP3x3AAoJEF2HCgfBJntG0tUQAJj2r7SZAmgVW0tIwgWH780C
HVJqEKOcid5Uj7fXRXBeNYBeRI5JntNzozAJDwHt2RJSN19JZ0Qeim7MppiMhcfN
v/rhdEbpYwEChrXS0wYp9ENFSQK9jXzrv2xIoiZw3GKPyHaahf7t39KkwideBFrQ
0d0HhkwSEoe4YqF8QP0OMQOTNCA8P9rwIMUJ7Z5UM3lLC09UO55uo0fDKX2buPjc
CJZWPMndP+a/NNSkPIG5Q8KgqTxBORrlYXJr+FMutRn32wgcCPMYRR8kBbDJnTlX
2P1n7tNrhiXPsvqp9ydH3uEagmxKRdZdIYZvgNwaqrD3STnMpQ8dYNfuNt+N5aQi
ycA8XC2Y7XTdMHeN1aXU/ysQHd+WGzNrfN13kN51M6SPh/zR0JyDUGqw9xyoQTEQ
r6LA4WoMBxA0qrEjTPoxPYefFtBzR1OwNZMw9HJ1JXeLZgl1Bp7xUG7fAayDG1/9
tHLutRWVFrYrB+6EaTAIvmpOFx6MKFhpofHsiVCEpA48jUvFfqdThZy+GSgk3oeS
4ENrYLvW3sAT8RXTgF7AoltxDwf4EUlmzSyx4vccersYyQWoe3Ul6K9YhJD0qQR1
pcU9K3YmuKnqiuSvbByzRrrQLVS9lGx5HsEG10QMJpKXBr15xAWpGYaC4vkylTF0
Fa6gjcRVaUsr9HkmxR4G
=NGyq
-----END PGP SIGNATURE-----

--nextPart2050210.KtUC2VHfPU--
