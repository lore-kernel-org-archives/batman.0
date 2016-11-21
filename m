Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 Nov 2016 09:16:29 +0100
Message-ID: <1926952.1nDu9mPud9@bentobox>
In-Reply-To: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
References: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2758267.zZRM4Q37Y7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH net 1/1] net: batman-adv: Treat
	NET_XMIT_CN as transmit successfully
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
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, a@unstable.cc, fgao@ikuai8.com, gfree.wind@gmail.com, davem@davemloft.net

--nextPart2758267.zZRM4Q37Y7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 21. November 2016 08:39:39 CET fgao@ikuai8.com wrote:
> From: Gao Feng <fgao@ikuai8.com>
> 
> The tc could return NET_XMIT_CN as one congestion notification, but
> it does not mean the packe is lost. Other modules like ipvlan,

s/packe/packet/

> macvlan, and others treat NET_XMIT_CN as success too.
> 
> So batman-adv should add the NET_XMIT_CN check.
> 
> Signed-off-by: Gao Feng <fgao@ikuai8.com>
> ---
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/fragmentation.c         | 2 +-
>  net/batman-adv/routing.c               | 2 +-
>  net/batman-adv/tp_meter.c              | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
[...]

Not sure how the batman-adv maintainers see this - but this patch needs
an additional patch for net-next to also add it to the parts which were
rewritten.

Kind regards,
	Sven
--nextPart2758267.zZRM4Q37Y7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYMq1dAAoJEF2HCgfBJntGZDwP/1baUnEQm26qbg9O+EfB0jCd
Wd1ncQ2KhdZ+OrPwclYJ0KnA15b+ZHNLYkfX4Aec6vwlHu8KkLgQfQS74sxFWt+O
nDxP5P50hcEQc+FXdqa5uGIf7C+Xt1SNL3e9imshu0PRC9tIrRBMdhuizFZtIBAE
4DvQlArNdhkNHto4ZJxLYrvmtXnJPsjY+fDmSBSSYLX3bKzNy+c7Gd92tRstHFJc
1J8vG1h5WGbVWHjijDjp6tXkUKWr8cxxbBYnTpaddNSPCbYsOCFCKc5kx+YO/0Ie
L14MKJLp44RluPCNLGLr/hqERTBgXzf7g7kwWr8xx+euaq0Vqsity/g3SKpEwGdP
ixRgGmGFuTMlkEWPE6PM7+DETJ7vd5NbF9rEXP1xYU70smZnKIR8mIRbafywUx2Z
72YEYg29m8COLgJQjaS1cvEsQQzNYcucYFYZAre8yTdjOk6ZKRcNb3+kK7M/zVb9
9u8ePfu2b1Np1Qve6asTZnoDB8+49kyRWh3/L+FZFRwOeBaCRmVNKJBLCrTl66nO
emrFqxVfWh+9FAWBmohKmNAsmpB8IoZ9O39vV4QS2E2SEjByG9QhownDYrRBSDzH
i+rRsyG9vDN8ixA1lZ8UzcXufxZgSBz9Mz8UHpSkyMtP41/wOKltOeyEb6YQCyul
M/Qs1AGcR3DKOQDAKnDd
=rUe2
-----END PGP SIGNATURE-----

--nextPart2758267.zZRM4Q37Y7--

