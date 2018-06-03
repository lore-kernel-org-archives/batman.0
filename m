Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jun 2018 15:14:44 +0200
Message-ID: <4457010.MKAyd5j4Ym@sven-edge>
In-Reply-To: <20180602152635.2923-1-sven@narfation.org>
References: <20180602152635.2923-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21224770.fADEb7j2kn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix bat_ogm_iv
 best gw refcnt after netlink dump
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

--nextPart21224770.fADEb7j2kn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 2. Juni 2018 17:26:34 CEST Sven Eckelmann wrote:
> A reference to the best gateway is taken when the list of gateways in the
> mesh is sent via netlink. This is necessary to check whether the currently
> dumped entry is the currently selected gateway or not. This information is
> then transferred as flag BATADV_ATTR_FLAG_BEST.
> 
> After the comparison of the current entry is done,
> batadv_iv_gw_dump_entry() has to decrease the reference counter again.
> Otherwise the reference will be held and thus prevents a proper shutdown of
> the batman-adv interfaces (and some of the interfaces enslaved in it).
> 
> Fixes: fa3228924152 ("batman-adv: add B.A.T.M.A.N. IV bat_gw_dump implementations")
> Reported-by: Andreas Ziegler <github@andreas-ziegler.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Andreas Ziegler <github@andreas-ziegler.de>

Added as 46360d203c62 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/46360d203c627e71a27d1f8f551c819c7f2353fd


--nextPart21224770.fADEb7j2kn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsT6cQACgkQXYcKB8Em
e0Z72A/+PSfSRJOQnieQea+kXRjJEp7KeLpDH0kC2psrFOqaZkZ/hERUl7ob0tNd
V8pHeJcWgKXiNGWPWs3nbtdoDgVsnmOe/rqj1dTtJIImriwWAKQc89KFxwbKZOeu
3jmChUQmSYTgao1WskCEPmi0QVMmS+TDFejfZFUFc9T7i3Mm10ofWWby40WwZeo9
cXwRPET3Bu5hUyFZU/OR8grl8IvvtU1YIsPm5nU9+7JQTmR2fB95i9HR0VtgkA3Z
GeRkjL6Sm5AStetRQ38b5b5+B2WvdGtFjdKfMrVJ/IAgsBfRx7+bFAQOE5nghSzZ
gZ59Bz81bzPgKnmphD8T7Ey4b5SLUIdqs0lrF0wHM94lm6AgRQcWoUGYm/VH+DB+
LsqvUHhMkVMZchvmUW2fSsZ73z+23LoC2bO4Ep3keNILDmiF89P17fNB9VlU5nsl
4gzNbPnHO6Pm26+79YZl3qi99OHL2Yre653upjRaOaXLkJ2fP1QbtTI4bAiHUnsk
6x6U80qlYZE8lLtO9L5DOf57Z7UydyMkqgeQkcmNSlh91B0NE2ADHYh/zc36cdPS
cFy1gW4GiZXbYuvrLfLSR3EyNyNxwP821q1oetF/MRsdoqcetYDo40KdvdY1gMPv
sXAQgj6fb2b9b0u3srkiUk03kLcZ45ajcIEMth6b9D6h/RfnsAA=
=UKCp
-----END PGP SIGNATURE-----

--nextPart21224770.fADEb7j2kn--



