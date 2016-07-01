Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Jul 2016 15:34:24 +0200
Message-ID: <1569263.Zj2Iic9t9P@prime>
In-Reply-To: <1467310294-5892-1-git-send-email-sven@narfation.org>
References: <1467310246-5820-1-git-send-email-sven@narfation.org>
 <1467310294-5892-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2703907.YDLzbXu3mH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/3] batman-adv: Fix non-atomic
	bla_claim::backbone_gw access
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2703907.YDLzbXu3mH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 30 June 2016 20:11:33 Sven Eckelmann wrote:
> The pointer batadv_bla_claim::backbone_gw can be changed at any time.
> Therefore, access to it must be protected to ensure that two function
> accessing the same backbone_gw are actually accessing the same. This is
> especially important when the crc_lock is used or when the backbone_gw of a
> claim is exchanged.
> 
> Not doing so leads to invalid memory access and/or reference leaks.
> 
> Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> Fixes: b307e72d119f ("batman-adv: lock crc access in bridge loop avoidance")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Technically, you can already add my "Acked-by". However I'd like to suggest 
one style change: Could you please rename batadv_bla_claim_backbone_gw into 
batadv_bla_claim_get_backbone_gw? I think this would make it clearer what the 
function does and also shows get/put pairs clearly in the code.

Thanks!
     Simon
--nextPart2703907.YDLzbXu3mH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdnFgAAoJEKEr45hCkp6hn3cP/jORmS/FQBANekuNpJudTMvJ
XMaDdI8kCmfz9pTKRmnF9LmQWZ47/Dq6XiE6pOc6/LcNq9NAfk8kf4ep6J7IAv9S
Cqgx+JZQfRwzfjqug9/B+F6pORytkSv63wnirIVOYjCXXCxK36/uJDLcxbsZJJTr
MUY3AioE52T6N5ptKbHXWdB6fE5YC/fY0wPEcvVREbXGE7weP9ig3BM0VR2XSwLN
70ipR6YCZhdJiHzYxAJoOYVtzaOSFxAJivMS5OpTo9adqRko+oigk1Vv/FELAYIc
tDJFxVowMloEcJ0mhLLWrmm8PwDYTIgEXTyNUOIGVS2+pUoMzql6zlLE4zfmhUy8
+8G0Sab0G+tjLvxAheSoFmbk3jBFi+P6X35tYTFwrtjmQLGcol8s/hNl1e/Vd35D
kC2WYgKOtalF5yZaCtRrUfSxonh9A2eAL4kwm9OMkOVcW9pExZki/IJxXnmlgG6i
kpYWL8bz18zVYEPczYd4f9YzNrUyYLqdHXAhXcvJvOaMn/IoSjz9TcsJMGenEjct
7jZd4OnF6xD7M7TJIJw2BOq0siFKXzNxmvxcvZ8h6CgYBBymZ9h6TyuCYa2l1G95
SYWy73oh9Bsn0t16Slqlaz5IWl1fvI3YGnk5QL1cA5aUJeSa9L7KTpXeQsCi5SYR
XcoH6cgEEiqwYM8t0rJi
=WHzQ
-----END PGP SIGNATURE-----

--nextPart2703907.YDLzbXu3mH--

