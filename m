Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Jul 2017 17:35:06 +0200
Message-ID: <2799027.uM53SshECi@bentobox>
In-Reply-To: <20170618072032.23937-1-sven@narfation.org>
References: <20170618072032.23937-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2618419.yZtinXhfae";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: convert many more places
 to skb_put_zero()
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

--nextPart2618419.yZtinXhfae
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 18. Juni 2017 09:20:30 CEST Sven Eckelmann wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There were many places that my previous spatch didn't find,
> as pointed out by yuan linyu in various patches.
> 
> The following spatch found many more and also removes the
> now unnecessary casts:
[...]
> Apply it to the tree (with one manual fixup to keep the
> comment in vxlan.c, which spatch removed.)
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: Add compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is already part of net-next. Only the compat code is new.

All patches were now applied because they will be submitted soon (by David
Miller) to Linus for 4.13

 * https://git.open-mesh.org/batman-adv.git/commit/3acf2107a025a333d4b28950bfbfe5a8adb9d175
 * https://git.open-mesh.org/batman-adv.git/commit/f05af5ac212f75bc24a419ae6446646b20156496
 * https://git.open-mesh.org/batman-adv.git/commit/e66e975fc252cbad49f4a65cb5cdc60018c0008b

Kind regards,
	Sven
--nextPart2618419.yZtinXhfae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAllbtasACgkQXYcKB8Em
e0bS3hAAsqz8BvW0f+vkCuzClXmjjdurfLmo0YNahqCSyfZE2GaCtAsP7m7O0919
RsmdCJu4XinIHyUQQKc+3MX2P+xb82t5rGI8oqToDPzHuh5IltM+lsBGrRVPMoka
V7b8E0T8R5rSmLfphnQiol6nEK/cqYuQq+2/JP26ba3qg8yxyA+/WUfE5sO468BL
M5V5hiPxYLjMxLcQOKGfWqPLFuQYQEbrP2/rhN6ztV1e8rBtESHLvhpZ7TtFmtxI
AuUz5At8acYeHK7TcPsFQkIzM2+kEthpEdkHggfRix2El1uvayAeRvwNftuW49CG
YWlAbKyz0V+0z3Gy6YOYEK+2pyB7T/tpEWSTzq8wtcsM3d9WnHhhkavOoVuBJ0N3
atB9mhZfqmez//y6l9qzfUIHPEZWSpxvGA3KpdFwMMkVomxuTNAlOdo31gK1H1KJ
MOrWq4KAhJZlBY4mQadEZxKe8+hLFP6JKtxwf3INKim3yWX6URdbLhpC+aMTu4Pw
7yPcDaAO5vjqYj6P/i4VWsapOoar91zQnfARCr+2Rk35Rcpy26rIHCjwQapsgFxx
xW04WOmv+XBc038RvqAZdG//Bl0iNtyMyiWCBIbhHrU4I2guao0SaG1m7ipgd6sW
BVjlSAKblVRupXFD1eLWijVbQl/04WygGpOpFPazjlJ+bXsnaNM=
=Sn3Z
-----END PGP SIGNATURE-----

--nextPart2618419.yZtinXhfae--

