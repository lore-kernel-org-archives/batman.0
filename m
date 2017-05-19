Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 May 2017 12:40:54 +0200
Message-ID: <59809624.zFUzTyTsEQ@bentobox>
In-Reply-To: <20170519080142.21070-1-sven@narfation.org>
References: <20170519080142.21070-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart83068142.SYJY1117p4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory leak when
	dropping packet from other gateway
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

--nextPart83068142.SYJY1117p4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 19. Mai 2017 10:01:42 CEST Sven Eckelmann wrote:
> From: Andreas Pape <apape@phoenixcontact.com>
> 
> This patch fixes a memory leak introduced with commit "batman-adv:
> drop unicast packets from other backbone gw".
> 
> Fixes: bfe2a1971f43 ("batman-adv: drop unicast packets from other backbone gw")
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/routing.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Patch applied as a58feb79ed1447e3e83f3b0b1a23779886869f39 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/a58feb79ed1447e3e83f3b0b1a23779886869f39
--nextPart83068142.SYJY1117p4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlkey7YACgkQXYcKB8Em
e0YzMA/9EAB1dGVn6WvoWH22HP2mrDvja33zoPqgURR/3qgoWf6gallT/pzithrB
+bbnF9r6r76O1Xoiuvrlu/H2Oe1kydf9b8Getnt7+k3TlAoVwb5/Eb8uQlj0W4kt
VCHWmMGP9AXd3TIpJ2ISi7SVI4ObKdrOuLQ/j2P4zR/JtfzcKcNagmM1bNTjQCd+
dNLbM8w3MGi3l2ed/Plm5b0iBY+DpkQGZkw1pSd60UbZqwaCg9jJ81RIMi4+r0yh
uwH2XxT6QoIHrgPuvsNH8ZtX5NuqZg1bzkbQ1LjWRBWxGg73AxqqL8XYG0jDl2T/
ATGibHUidVml9DNC/Jhzd6G2c1HZQL2MlWU6JaTkYWH5x+8JBiRA5jYzGths7nsb
uLbYu+wUYF/48/Au3ySgDdxUdOY6WIUBGG+72db1WMnxKmGBz9kr5t5BGE5vphWV
RTWr0vA0VGr9xo7YcUH3HBEGKUT8F0C4JnkmIfH+wojuj6SCaXWOrMbYTLSJ/esq
hHIsO4L4mMM4vG38FRM9t+Xknb321X8mffUndP6HKMSFlFLY4IPltB+t//7b2YQW
7XzulNtSVUIQ76UL0sF0jRkEcBTVCW5L0HnYKeaNiBfY9X4YmQM+VWRSQ1TupUyO
MQq2uvsCvXNp95dav4K2HVVxkd0/vCPDqDt0+4npDAeNjNb7nuY=
=E+H/
-----END PGP SIGNATURE-----

--nextPart83068142.SYJY1117p4--

