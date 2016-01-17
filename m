Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 13:22:33 +0800
Message-ID: <3775327.giChty1sZV@voltaire>
In-Reply-To: <1452936598-28619-3-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5081728.4JlL1UHnrR";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 03/20] batman-adv: Convert
	batadv_gw_node to kref
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

--nextPart5081728.4JlL1UHnrR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:41 Sven Eckelmann wrote:
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
>  net/batman-adv/gateway_client.c | 40
> +++++++++++++++++++++++++++++-----------
> net/batman-adv/types.h          |  2 +-
>  2 files changed, 30 insertions(+), 12 deletions(-)

Applied in revision 1faa4d8.

Thanks,
Marek

--nextPart5081728.4JlL1UHnrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmyUZAAoJEFNVTo/uthzAC3AIAKXGYNYK1ISKOHJ1DgkoL8iw
PS2sWgA98PpyHGT4ucz8Z935OmVyRXk8AJzrJ/qCuCrDtHKnKkWsLwak7W7tZj1K
DN0QwI2H9mXD70w1rWSu4n4jbJ9SdOEKQcAiYyUrSM/ucg5qXKS2lA2gev6OjZ2v
ZOVanDRoKouTY+8rRSBnckptfhvFe7TpPYsDlDWlmrLybKlQwuF6zCEBk1B921oV
EFVGQIQj1PlSzKe77ih1YxFuJn6td2h4pSmAdH1bHrrTml1FOGzr+AQThUB8RkaT
C9ObjeOapMI2Ufog6Hns1bgwpseKnrMyRpEBR74OFdCrzHoqlo+ShKVWAS0/TG4=
=eMsV
-----END PGP SIGNATURE-----

--nextPart5081728.4JlL1UHnrR--

