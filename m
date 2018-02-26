Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 26 Feb 2018 17:34:20 +0100
Message-ID: <1590623.xibrY8hj9p@prime>
In-Reply-To: <20180224110337.11985-1-sven@narfation.org>
References: <20180224110337.11985-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21712148.KCTdsoDomd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix netlink
 dumping of BLA claims
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

--nextPart21712148.KCTdsoDomd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, February 24, 2018 12:03:36 PM CET Sven Eckelmann wrote:
> The function batadv_bla_claim_dump_bucket must be able to handle
> non-complete dumps of a single bucket. It tries to do that by saving the
> latest dumped index in *idx_skip to inform the caller about the current
> state.
> 
> But the caller only assumes that buckets were not completely dumped when
> the return code is non-zero. This function must therefore also return a
> non-zero index when the dumping of an entry failed. Otherwise the caller
> will just skip all remaining buckets.
> 
> And the function must also reset *idx_skip back to zero when it finished a
> bucket. Otherwise it will skip the same number of entries in the next
> bucket as the previous one had.

I've applied both patches in this series in 49197c00 and 29e4759e.

Thank you!
      Simon
--nextPart21712148.KCTdsoDomd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlqUNwwACgkQoSvjmEKS
nqF3MBAAoB/87uq6l1PAOGpa8/y/CVZo4CyuvTi4Q0UlbbZh/Jp5rRBanQRlUGZJ
9EdPtizfYRFYfOWbDO0jzUPs7Y/180+6f15F2OJ7fZEOvjzMWISk98/Oc2q9km3a
vdBfTDl24VkZB7zW/vGN8gbqlUkleIW+oBrxkOJzW485LzKAkuJqmhAhZhwvzr7q
oocjEHeQULXoOWBziIc7G+j9YitHMxKavVe5n+f8SG8s37YbDh6NoIqrUKo6KXxA
sXMSeEnwjd5p6AaExcIMZSAY3Ll4AzefM+zD+7Tj+m93IO+kb7budn6ajKdZIKCZ
oFvqvDEAwicNWzK3BzhaEintHjWtgVIgCrc1wGEsyHVqO7rB/jj0M4P5Ds7kru2W
ea6qcg1GNOUvrFhzZ2e8ui9RJpmQrMHrv4wbz/jd+ATvShyAFxNbpFWx/zrnPkfo
q5iTPvzGUS9s9vBTYR4LDC7AMdT5i7G5lGajO8kc7X3v9p1CNtZ6gnEO54U0iWZs
CdWTpb0Y7AAQsj9RJH09iqCOb3Ffou0QzyzhzcldKpAX7NXRhl6OCyiyreuhI279
uUTzy7GST166KEevYvlMdCB2oOBEw4neB1yaFcPDv73vF7U+xqe6pFnPYSu6Jv2F
805TdxjMc7u3REEbrclA5jlqgB2ZjIZjHbZnB/7R+S/X6Dr/2ZQ=
=z3C6
-----END PGP SIGNATURE-----

--nextPart21712148.KCTdsoDomd--

