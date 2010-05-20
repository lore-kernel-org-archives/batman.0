Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 20 May 2010 18:51:46 +0200
References: <4BF56357.3000208@tiwoc.de>
In-Reply-To: <4BF56357.3000208@tiwoc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2018573.KhmultgirD";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005201851.54709.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Correct mdev calculation in
	ping subcommand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2018573.KhmultgirD
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Daniel Seither wrote:
> Fixes the calculation of the mean absolute deviation (mdev)
> of the roundtrip times. mdev was previously calculated by
> computing the difference of maximum and minimum round trip times.
>=20
> The calculation is now done using the same formula as in the iputils
> ping program.
>=20
> Signed-off-by: Daniel Seither <post@tiwoc.de>

Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Thanks a lot for your contributions,
	Sven

--nextPart2018573.KhmultgirD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9WijAAoJEF2HCgfBJntGvpgQALTvmBARF00Ju9Dhdnww4mbT
WBAJqynqzndNZdzfQ8pgqLZmbCXqs+odIAsJwRZ6HM81JejTu5mZS4Ukd7mxbhfd
W3hrOtjGoJbcMrXHYrcxX8Ys554L3aGjq/EkmGaz56fZq5nOcT03Jg/KITzuF0el
jmEhoVNzNPJq8B8D4nCVX0hZZprPkrbvVszR2jxoqild1tmeRuHTGvDQiR36jKXG
kvN+ksN425N9Hl+NQSq0KnXzruog5aioMX4i4fz9RAfZMD/7CekbgcFXi8h1NNaq
A508Q5LN/XKpHSpYXsQQw/JsXgQk/NF9iE3qtPcE6qXW+Fh7U9WAFXyMoqo6MF1C
qWBdBvLQ1FVCjpVexvxDIT0tkWsse0G91MstCtGZflIo/qhlwj9wdQL4OByVpD3H
ZitcEY64HsUyEBMTq1l4szq4ri438eGxFAgEikAuAtFc8+CqAzd+DYA76Kf7MRMk
FQWqmXLLhFG0E4MJxRqV6VFTZy9ZS82vKjrk2EhVONiIOVvVbpwGdbvASNVDuxKT
HXRef6oI3S6X5yq3pt0Zz9VFFdCb5QtWiltB/A5MpIQZ8smD8Zf5ic9dqyz46HWq
pzK9AMZABDcbelp5niI+JbKoCzLQADBNeYSmT3YLMuP9QKDedG+wJCRvHPjTZl9P
O0CGKKXZTRs8VimEszBu
=4z+i
-----END PGP SIGNATURE-----

--nextPart2018573.KhmultgirD--
