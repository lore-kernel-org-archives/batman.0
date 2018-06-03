Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jun 2018 15:15:29 +0200
Message-ID: <1734570.Fz6KSbJefZ@sven-edge>
In-Reply-To: <20180602152635.2923-2-sven@narfation.org>
References: <20180602152635.2923-1-sven@narfation.org>
 <20180602152635.2923-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1872403.TD00X2lkLm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix bat_v best gw
 refcnt after netlink dump
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
Cc: Andreas Ziegler <github@andreas-ziegler.de>

--nextPart1872403.TD00X2lkLm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 2. Juni 2018 17:26:35 CEST Sven Eckelmann wrote:
> A reference to the best gateway is taken when the list of gateways in the
> mesh is sent via netlink. This is necessary to check whether the currently
> dumped entry is the currently selected gateway or not. This information is
> then transferred as flag BATADV_ATTR_FLAG_BEST.
> 
> After the comparison of the current entry is done,
> batadv_v_gw_dump_entry() has to decrease the reference counter again.
> Otherwise the reference will be held and thus prevents a proper shutdown of
> the batman-adv interfaces (and some of the interfaces enslaved in it).
> 
> Fixes: 15315a94ad98 ("batman-adv: add B.A.T.M.A.N. V bat_gw_dump implementations")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Andreas Ziegler <github@andreas-ziegler.de>

Added as 2b422b580818 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/2b422b5808183d1084b450b89d9a085a13dd6d2c

--nextPart1872403.TD00X2lkLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsT6fEACgkQXYcKB8Em
e0ZJCxAAjgasvtYX8EuUN5XYnzCG/echo1+0N3jPzVI5Xw/XgXVfsNAqRJ7LDShY
M1+OP7Wcsv5c/Fjc5mVlg3crVQIGijm3fSuK+g9e4+ZlTX61MSogRt7hyjqfW7n8
dpZB9wH95ReakBSJopRG2EiT9OCgJFfpe/tJA+673ZbdJXyYzTkWSKg/buzk2PrV
cxtQ2CtV3eowQy9TzI1wFfYZBd1DIANruoRfiDtvlzjZ0UdRHbbnNqPuCJA6XXCy
gZQJeHPmKHvNe+dlVY7jF3CUDKhHuUZHYDzzpHwQVPgrxn1tMJNJU6FElCNSq0hx
guTOL5uNPgwrwoOMMtxDxN2pHpL4TsxMxfr3/V5A8fu05MxcW/3EVwnqq0rVSI7Y
pBRq7BDRZdW49dICu+CLWPREOJs1oxQNjeNOtwZ42WNE8bWdejbt9Fw+Yk+lZdhI
kM05HmBpMTH3yFgzg70hS7Eyn+C7GElEDPrxGcp53u2EisC2svxPsnfrjJsV6Yiy
VUTb9FLTT0zDm9Yckc8/VeVhLVB+3TrprbkQbHyPg1JAjlL78I/RyQfZdRtyigY8
+BPHhPI3Bis1RZyShSYfjbhZI0E5i7bUreXTstdWDRdNC6byxZ8cJF4RpcXM/Ar6
hDhieIuI5rzcQ2ZM7RSbe+sMulchpsgJi+ALFx3pbgMbC4pX6YM=
=8m1e
-----END PGP SIGNATURE-----

--nextPart1872403.TD00X2lkLm--



