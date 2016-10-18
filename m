Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:35:06 +0200
Message-ID: <2298933.D8bghudbgG@bentobox>
In-Reply-To: <20161009065738.8279-2-sven@narfation.org>
References: <20161009065738.8279-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3878304.BdBCS5WWgf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [next, v2,
	02/11] batman-adv: Use simple script to patch minor compat problems
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

--nextPart3878304.BdBCS5WWgf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 9. Oktober 2016 08:57:29 CEST Sven Eckelmann wrote:
> Unified diff base patches have the problem that they fix only a single line
> and depend on the surrounding. This approach can fail relative often when
> the surrounding code will be changed often. Thus semantic patches (like
> spatch from coccinelle) or simple find+replace scripts are better for this
> approach.
> 
> Introduce a simple script file which will store these kind of find+replace
> instructions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - no change
> ---
>  Makefile                       | 3 ++-
>  compat-patches/replacements.sh | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>  create mode 100755 compat-patches/replacements.sh

Applied in 17018a99bc68f49ea1da199c9c1b290e3b2c42ed [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/17018a99bc68f49ea1da199c9c1b290e3b2c42ed
--nextPart3878304.BdBCS5WWgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgjqAAoJEF2HCgfBJntGLv4P/2QN2Te1ynRJKLBEQ0++3RKe
Mqwn48co8mNLPj4MGxlRQquA0nQIKNYDUVZ1dMWDbAQe6pQ9PrLmVO1/4lcunwez
mHwPz0pRGFSE4BEeLYZYFNw6zxkoRADCyMh+sIarQE5yw0gBoabA8SrtSpqfhG1I
+BGu2WlmNMoFztQW5Cn4XXYyBjs4D83uHR4d07csPwlIfbsUD085/E8yrdxL+Wi8
0MFyMDxNPa/UGWR+rwcz1kU4IS18l3ww2KlUy0JoemCaxzfnDbh7W2h5GQNviS1N
kPAbRbianV5WlJ5IuAKwM0KekDQjnvghm9rO5K5Glq7X4ssIbTH7Tg/xSgzeVh3s
i9OTE3ZEyUnopP7WADxll8M0ZQvZOysIY5xIAK5zO106b46pTiXnDYd9AoOT0fDV
ICWFhhCwXBdvAIGwM1wdbPNsx+ao1o014aTA29vO/bvRnKwXGEQI+JUx3Xqxyskq
QKL5ziVI31C3OLXThOjmd4U9EqzFWySxvdcklBMxlol8T1x5byIvkkZkDXgqRFxX
9/9cc0GMPf7qq13U6xs8DVldu9DO9Q+WUhIIQ2fQcZK3LZwi2+S8vrdOcopXHHH+
ASQxCbSeC9zkqLE+51nfLWyksCLOJfPNtWGbr7jfamAps9d5eHATyT9weLPBtvZP
FWJI6mNkrKxRMuLmKZde
=VzWW
-----END PGP SIGNATURE-----

--nextPart3878304.BdBCS5WWgf--

