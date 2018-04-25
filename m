Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Apr 2018 19:23:21 +0200
Message-ID: <6964695.auRBVytUBx@sven-edge>
In-Reply-To: <20180419190108.11396-1-sven@narfation.org>
References: <20180419190108.11396-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6574583.Tq0BtXA8Ti";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Avoid bool in structures
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

--nextPart6574583.Tq0BtXA8Ti
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 19. April 2018 21:01:07 CEST Sven Eckelmann wrote:
> Using the bool type for structure member is considered inappropriate [1]
> for the kernel. Its size is not well defined (but usually 1 byte but maybe
> also 4 byte).
> 
> [1] https://lkml.org/lkml/2017/11/21/384
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/types.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Both patches added as b8f25ee5d426 [1] and 566b52be5f23 [2]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/b8f25ee5d4263d4eab3a66cae338037f1645c427
[2] https://git.open-mesh.org/batman-adv.git/commit/566b52be5f23eb5ffe94dd40f956c9a473129251
--nextPart6574583.Tq0BtXA8Ti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrguYkACgkQXYcKB8Em
e0aWrA//ajPVU2H/aunuo05MmpP1i839RHpaAVHjd4Jn3kvgzUS+jXp2koDodvr0
BtyYYI3xWWjHMc1+x3lmmTpCINd8rCnp+3aEn1+WR2GZLlhk0d6YJhZKxMZwleIj
hxdZwgGnp12hGqzOp0hsMQgWYGl1Lst9n31wOC4SSEkpFVagzTzST5xxaibEg1kQ
xMv8c/9Sc7GEfpFs/zXlcedA39nMYHJEU6ZxDcc2DfNdRfcTAjS+XmObCPOFOjEp
N6ljtM2IKIkBoydalCi2+/NfQLRej6blb0wkVLwcwHk5xq1lb5ByJZRpm/9DwooK
98/ksi6w9xTe2xlbk/anhJrX3diOnMK3PSeYTOVls5jblIrKxFReVdKRzZECWTLA
2+hyG/KpdZ4W2L4y8vFNSKs4Lgwue4QdOhTDG45UpPnWGHWZyIIAu8wxkMzVRdP7
ukiyREypWVIRTGKXU8hccqodtr0N6RtxA7VUZDA2O2rMsGkzPthQYusa6JOJiKL3
+D2SGWKN2ps+XFUa5SA4tBHQm3Be2CQI/fH7V9dTqsF0nl47F4CoYCmWJugvjFlH
dfuNiILqFEaTSWgwETRDhh2s+yal4J1YoPsssMkeTy9L8zMsuI5LwMZcLwUOkeNH
qtd/Qm9F/WKYyHX0/Q25JNCswyuDv8RaS0wkieZVWelCs2PKKyI=
=0X6S
-----END PGP SIGNATURE-----

--nextPart6574583.Tq0BtXA8Ti--



