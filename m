Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 14:57:37 +0800
Message-ID: <3153153.Z6SvmDczQI@voltaire>
In-Reply-To: <1452936598-28619-13-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-13-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2387181.cBeHnIbxmv";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 13/20] batman-adv: Convert
	batadv_neigh_ifinfo to kref
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

--nextPart2387181.cBeHnIbxmv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:51 Sven Eckelmann wrote:
> batman-adv uses a self-written reference implementation which is just based
> on atomic_t. This is less obvious when reading the code than kref and
> therefore increases the change that the reference counting will be missed.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v6:
>  - removed patches which are now applied in the branch next
>  - rebased remaining patches on the patch
>    "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
>    modified by Marek while he applied the patches (this unfortunately made
>    some of the remaining patches "hard" to apply)
> v5:
>  - add hack which allows to compile against stable kernel like 3.2.44 which
>    also added the kref_get_unless_zero function
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
>  net/batman-adv/originator.c | 17 ++++++++++-------
>  net/batman-adv/types.h      |  2 +-
>  2 files changed, 11 insertions(+), 8 deletions(-)

Applied in revision c12b7f8.

Thanks,
Marek

--nextPart2387181.cBeHnIbxmv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmzthAAoJEFNVTo/uthzAcQ4H/A6Zg9bKSFTC3ZKEsKT3q7Qw
lkuu4c29YpPUs6XO5vU4A0mMhN9bowLsmL/fW1v/aw2fiP8YAeedE63TicqPs0qU
dkRW8dzutyTOI1sc0YFI/lJneAPCcCpV9cGDs0bnM9Dir47BhgniDtFYwHc4kWnp
zwiOTkhDE82DsxSJlWixU3yzZhE3PulmYoFH5qMYC4vagFTH1mmOfv/9Qfn/4G6Z
uLr0PUuVsgKMKYHuSFZupXr4X34M1EpUcOP8GD85Yuq0ovYkgz4Kg0ePIzI+F+pk
TUWXETivoX0HCpiQFJ2CZiVZlsqwvLVjWNJy8ce2c1JZf6gzVW1vJxe78d4gNT8=
=Gsz4
-----END PGP SIGNATURE-----

--nextPart2387181.cBeHnIbxmv--

