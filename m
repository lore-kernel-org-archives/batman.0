Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jul 2015 16:46:32 +0800
Message-ID: <1789652.lUyESWiWDH@voltaire>
In-Reply-To: <1435940999-3829-4-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
 <1435940999-3829-4-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3875212.T4Cq7GdsWX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint 3/4] batman-adv: Fix broken TT
	capability check
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


--nextPart3875212.T4Cq7GdsWX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, July 03, 2015 18:29:58 Linus L=FCssing wrote:
> The introduction of set_bit() and clear_bit() calls in batman-adv
> wrongly passed bitmasks and not the bit numbers to these functions.
> This leads to broken capability checks.
>=20
> Fixing this by making the capability enum a non-bitmasked one and by
> that passing non-masked values to set_bit()/clear_bit().
>=20
> Fixes: a51fa16ecf3f ("batman-adv: Make TT capability changes atomic")=

> Reported-by: Def <def@laposte.net>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  translation-table.c |    3 ++-
>  types.h             |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applied in revision a4824ff.

Thanks,
Marek

--nextPart3875212.T4Cq7GdsWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVm5HpAAoJEFNVTo/uthzAnS8H/Ruoy10AZd7sDZryKa6ng59g
s+WsnsAd7dkdj5SVY0JVQTAqa7XVR3Vwi0b5361w48yjOXST0bT3jXBVPXCXCcsM
PhwJ7Ioup0x9Z3zXL49u1ZDQ2U9Euc4TW/AJBzOAfqiUGT8oX6S9iSChhSHe9l8t
OeAr0aQSAhWengJRYG41dwURCYGg658XJqCrRHvbLQr/RFL1QQREdJj+3n8Vmm8S
h2KW9lXYCh9E6Wv7WgSUujNsidZ6aEfPefEVJ3PLiDSrU95ccnRD8EMYS3HlLldN
QGGm1Y+mrPO+awlyJ+oC2CTJ5gqoBWZJV5bQWwlilh3Ks2Fsp7pBwc1k8dy5qzU=
=VBMH
-----END PGP SIGNATURE-----

--nextPart3875212.T4Cq7GdsWX--

