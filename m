Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Sep 2016 17:34:59 +0200
Message-ID: <2061158.GCOWOKitMp@sven-edge>
In-Reply-To: <20160915135249.1925-2-sven@narfation.org>
References: <20160915135249.1925-1-sven@narfation.org>
 <20160915135249.1925-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart122839117.VurmCI2yjQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 2/3] batman-adv: Use simple
	script to patch minor compat problems
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

--nextPart122839117.VurmCI2yjQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 15. September 2016 15:52:48 CEST Sven Eckelmann wrote:
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

We could also skip this step and directly use coccinelle. I started a branch
some examples to cleanup our compat hacks [1]. The change for the netlink
const change is also already available [2].

Kind regards,
	Sven


[1] https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/ecsv/buildpatch
[2] https://git.open-mesh.org/batman-adv.git/commitdiff/2895226999760f2f2b34b506d33dc54c3bb43ca4?hp=7582ba83a3c7870dcb00f166259fbbb65600566c

--nextPart122839117.VurmCI2yjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX3BEjAAoJEF2HCgfBJntGSmgP/3s6tSt/J10RrM5qOrIhbr0x
8fGPBbSoqUoAsjLkKSqHIVBn4pLXSwXMTTVPWzlvX/lPfKGmNNMW8REd1KKjzmGK
CQnpzHOZQmooc1/HtG3djGAFE5b1ZjL2Wl0edD7UGN6qg83lDZ8hOhKkj6hLhPNR
NOxXabvVfis3umVC7Q53Ro0i2E6cJ0UiqYfoQftgs81rhK1Lrl3lJTVr+cOH+e9G
qr64hy5dUPM4HlmZDuu5l0xjpnwGMkA+8sW/NyKYjlHVRG9KCqUyviYUD/4Vml9M
kSED/T7tIVuu9P7i404UCnYLFWmkPkcF/Vwol4CmBQGhR3YnqiZxeXCS6WGfOkYj
aSpzsTTtLvm0gkuIdgmAW9FxRxJ4M0Oa+lRU7Zp7+C846XIGsET8c3KupYmQS1Pw
y9Kx7py6qUPeB19YJj7jTurJKTUqpKzmDnW2mjS6TGSg5awwpTTOGWryvuicPRwa
FX2HRMz0i9FUK4urJInW77BkHPNrHS9rhNR/iYkU3bWJIlQ+PDLag6MMguk1wLjA
p2Ei6gWMYGQpqmJzGfMVVqwVTejLrGQgQxZk1rB/M5lB9lkff/7xrHgeq+cQEq6N
4eiWxE9ebIuXhUWIWasjDCiI8U3IaHh+9U3i21lUp/dakNO0GpNgFsGs9jUUoDe6
it3WET5NDsxFWRazV7yO
=D7js
-----END PGP SIGNATURE-----

--nextPart122839117.VurmCI2yjQ--

