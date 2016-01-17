Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 15:01:03 +0800
Message-ID: <1482436.SLX9s98y4i@voltaire>
In-Reply-To: <1452936598-28619-15-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-15-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8650173.mYFUOzEQK3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 15/20] batman-adv: Convert
	batadv_neigh_node to kref
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

--nextPart8650173.mYFUOzEQK3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:53 Sven Eckelmann wrote:
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
>  net/batman-adv/bat_iv_ogm.c |  5 +++--
>  net/batman-adv/originator.c | 22 ++++++++++++----------
>  net/batman-adv/routing.c    |  8 ++++----
>  net/batman-adv/types.h      |  2 +-
>  4 files changed, 20 insertions(+), 17 deletions(-)

Applied in revision b4dc027.

Thanks,
Marek

--nextPart8650173.mYFUOzEQK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmzwvAAoJEFNVTo/uthzAHPsIAJhLu68MpCuF9m+qOItVQJnG
ODC49Y3jl34MHbTY0E/yAo4L7O8HOy2me/8SMyYu20w3Z2nDK1ZYx/R3LnKqXZkI
buYE1NGQEMGE4HJMRl4l497AM8U62eUoWMOmUMoHpkxGosZ0jkIT4uQj3eM6dOcx
up5fC35TXuCi8jbIp8kdhZvSOZ7VV4PW4U3Die9o3eT38/aHvbxtxky/+BsYM9ro
SWDypxoyhM+QUdpFJZgQIl+7YnY21tERcjX6W5xE6pK46Cgackd0h6SG/woVGvog
h21CAYYa0kHBMy8ZIbAgj+EARpbjvtrnN5Yn6QYlJSIoxWG+a9ARVKfjQcMgokc=
=qHAi
-----END PGP SIGNATURE-----

--nextPart8650173.mYFUOzEQK3--

