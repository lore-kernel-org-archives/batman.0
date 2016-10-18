Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:48:35 +0200
Message-ID: <4320327.oZSxYfLhFA@bentobox>
In-Reply-To: <20160921072350.13823-1-sven@narfation.org>
References: <20160921072350.13823-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1553469.l20e364RvC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Avoid precedence issues in macros
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

--nextPart1553469.l20e364RvC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 21. September 2016 09:23:50 CEST Sven Eckelmann wrote:
> It must be avoided that arguments to a macro are evaluated ungrouped (which
> enforces normal operator precendence). Otherwise the result of the macro
> is not well defined.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/log.h    | 12 ++++++------
>  net/batman-adv/main.h   |  4 ++--
>  net/batman-adv/packet.h |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)

Applied in aaf289c83d63bfa43665bd76cd0b96658d2746b2 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/aaf289c83d63bfa43665bd76cd0b96658d2746b2
--nextPart1553469.l20e364RvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhojAAoJEF2HCgfBJntGe0EP/j5Kn8RBg1NcS9OKGRydFFuG
D0IauuhLlJCo2apfg6eaFpz/kwUfLfbEetHkbOj1frM/Gj92jkyp5EPS1EZUt3Ib
zoXYOtoPXzTgSR6DhwNmGYWaf6msW1Dzi/EWnjDCAuAn8GkSdhDthfLoOeD08JPC
LPMuyDH7C/mn/9C0zCsH7lL4lJE5ptuN69hNrHG81fON13URevdNLRW/Hq29bTBs
UD0pJTIFEaGYjL6JUpEFcgLyreQVbuG+DZqjHivDv0YoFXZSNe0dlBDVJ/rRHz/h
G9nerLOW/9UZ05J8MdYcaLowp6rjfvgkiSU7vc1ZbAitOIUw5zLjVLvL95DRKPNA
9vZR6YNYjrvsOidfdag18lm07Dy4XNPVlsIbSfrJAqRqJKlU5cE9AdA25nwhSuVS
vgvT7F4Q0fY/ZmmxlVkyzzAIQ/tZIAln8FyBvMjn/cOX68pYYlRxbnbqGWuJjuYL
OKBQ9cNDxcQk5WvkLX0nu5M9oqDapWAdBRcQib+t/Q/r8J5dCBHDWE9XC+Jj6/te
/xEXGpDN1nVBgX4T7NPAyDd50gNk+nYTIDYtj9SdNmksrJ+DT36rFpXVhEUfAnOP
xDTtxEwqDpZfmiwQci8626sxB/6i3vXg4etUhPqVdhdKiekygAaFiKCSq9N+X7Kg
NiEPvrBCtpeBh0wcunQm
=/H9M
-----END PGP SIGNATURE-----

--nextPart1553469.l20e364RvC--

