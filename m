Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 06 Jan 2016 23:53:43 +0800
Message-ID: <72605939.XplQXKZxHp@voltaire>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4762127.KoQ1aO1ZHs";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 01/31] batman-adv: Fix kernel-doc for
	batadv_claim_free_ref
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart4762127.KoQ1aO1ZHs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:16 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  - fix function names in commit messages
>  - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
>  - add extra patch for batadv_claim_free_ref kerneldoc fix
>  - change the phrase "free it" in all *_free_ref/*_put functions to "release
> it" v3:
>  - update copyright year
> v2:
>  - split patchset into fixes and kref migration to make it easier when the
>    decision is made where each patch will be applied
> 
>  net/batman-adv/bridge_loop_avoidance.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision ab08dfe.

Thanks,
Marek

--nextPart4762127.KoQ1aO1ZHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWjTiHAAoJEFNVTo/uthzAAJIIAJxnix3CkHU0hrnO+Dbg8gwv
xRezVt4YpYIV4SQxuw9UaobYErFExf5VP7Rp+FcFlPg2qj+It+bwjc5pG4WjMtmb
cqgZormW5JGlEduOZgbTTryUk7PRnVt5a4brYY6FTdIQZG6uYUsKkJZrjxZUXgDO
SEyFwewFWwMCt+GJd3weG6OjJHfIiS3nfGeOi80dXL6GfXte6IVUZR0is0rUEU4e
6oLoqqA3hZRP6XvBph79GK9cENHQB6pUlsrrKDMu/d0cJboRkCDRa/zyuyT9gE2O
J5uBHkQ/7p2YRnN4J7Jrfr24lqqIvWag1EhvyfBNGf4KVHfVJVcVo7X/n7s314A=
=CLjl
-----END PGP SIGNATURE-----

--nextPart4762127.KoQ1aO1ZHs--

