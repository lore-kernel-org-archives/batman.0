Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 13:23:52 +0800
Message-ID: <4200725.iomLoh3t1o@voltaire>
In-Reply-To: <1452936598-28619-4-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6158094.3jWrMNdufg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 04/20] batman-adv: Convert
	batadv_softif_vlan to kref
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

--nextPart6158094.3jWrMNdufg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:42 Sven Eckelmann wrote:
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
>  net/batman-adv/soft-interface.c | 33 +++++++++++++++++++++++----------
>  net/batman-adv/sysfs.c          |  3 ++-
>  net/batman-adv/types.h          |  2 +-
>  3 files changed, 26 insertions(+), 12 deletions(-)

Applied in revision 395c567.

Thanks,
Marek

--nextPart6158094.3jWrMNdufg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmyVoAAoJEFNVTo/uthzAND4H/R0RfKC5ViWnDWi3O6uY5ufv
jUIY65IAAL9W5cf66cPmvcFygDqQGORN4dgC22lavP8ahZ6Z/WB5f98gM57oYoCR
ITcImlSmSIi1H72RXF0Q4rdsUBMDn2fW868E+Z8DFHiGhKV6I4gBOxnu77A7o+YA
BNMAXY2hXH5ndK8UJfkMTg2nfjPldXyzED8xC2WyrCouHzK432thCTheB371xiUZ
xjvGKmNh8fEM3raYgFh1/Kbq5GFhzGv6Ci4fXud97/L8k12L5LGw5Kk/D186kYKF
+DS6ZsfcbZakNRoCvN3v9X7wjK39pxCNyDPJyrsuuZJxuTIy7bLr2e/46A72Z5A=
=DAP8
-----END PGP SIGNATURE-----

--nextPart6158094.3jWrMNdufg--

