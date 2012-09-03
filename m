Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 03 Sep 2012 23:13:41 +0200
Message-ID: <1490055.1D0A7yRGtZ@sven-laptop.home.narfation.org>
In-Reply-To: <2787714.Hq4L2aOJPu@sven-laptop.home.narfation.org>
References: <1346703631-17948-1-git-send-email-linus.luessing@web.de>
 <2787714.Hq4L2aOJPu@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2799260.gPFYvnVdWU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: make batadv_test_bit()
	return 0 or 1 only
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2799260.gPFYvnVdWU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 03 September 2012 23:11:39 Sven Eckelmann wrote:
> On Monday 03 September 2012 22:20:31 Linus L=FCssing wrote:
> > On some architectures test_bit() can return other values than 0 or =
1:
> >=20
> > With a generic x86 OpenWrt image in a kvm setup (batadv_)test_bit()=

> > frequently returns -1 for me, leading to batadv_iv_ogm_update_seqno=
s()
> > wrongly signaling a protected seqno window.
> >=20
> > This patch tries to fix this issue by making batadv_test_bit() retu=
rn 0
> > or 1 only.
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
>=20
> Weird, I couldn't find the code that would cause a -1 here (but I jus=
t
> checked recent kernel versions). Most of them already added the "!=3D=
 0" in
> the function itself. And the both version of the variable_test_bit se=
em to
> return 0 and -1 (at least my quick interpretation of the asm listings=
).

Just checked a asm reference and noticed that I remembered sbb wrong. T=
he=20
calculation behind it is: op2 - (op1 + CF).
I thought that it was: op2 - op1 + CF
--nextPart2799260.gPFYvnVdWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQRR2FAAoJEF2HCgfBJntGKwAP/i5xHKDOOj5cnhpfTCAO9oTx
jdAQu3ruUqjj2jrleIUnsseuhTSRN5wl9gNnCwyTO1bnxYDcnKV50Nls6rEGvuuA
n2Zx0qrMdxGKr0ZufX1zHCpaFfvA7TEZ7ieZ5Gai2GNm4dDjA4M4eqOtKl2zKRZU
8GaEpk1HZJT7ApwgXMiLFY/o/gAxb/TX49UZYo4JbeitQydoQV2H+QaWpL3iTpuv
rI7NY5D0Sg2k6ilQYoYdR91hGPAi/i+Z/ii00161t8KbQiIR31+D4p9g1jiKFRar
T6cwqp/bK+uWVNzjqJAUwYiH7uNxWi5VZgGA+r1GmYQFt536Z021oiivPLmD9oGE
YZOlCuh8+LEK/75CHDXjDoRamkPFxUmRCYN85uYL8mdcdsgIs513fc0DaHedxS1R
x2foF3K6921Xl18CjYbYlnJPlvYsLnuhBRjWg77IgQzUJTmfxYyTlFT5g9igBbkt
8T823kXR/0jZKtlta93eYej93xqHznf4yPU+JDc5aukMda+oLrMzTKUBiqd2AL7k
gW2PeOs1o638eRFPkm4Aj7Rj4tDKhSe7f57ADIFEsbxlu9bKuRMAiGllQ83BIGYZ
j/yMLqGrOfRcbQMrNYLeqBysb3l8nzmjIYNaJTGteOy67csyPOXkwrETCm3eF8hK
/p2yy5fxvrEEWNTZn0IV
=2KIi
-----END PGP SIGNATURE-----

--nextPart2799260.gPFYvnVdWU--

