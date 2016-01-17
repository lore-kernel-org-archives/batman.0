Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 13:17:42 +0800
Message-ID: <1555299.ZJeQWqFvc2@voltaire>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1485455.DERrIINvaP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 01/20] batman-adv: Add compatibility
	code for kref_get_unless_zero
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

--nextPart1485455.DERrIINvaP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:39 Sven Eckelmann wrote:
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
>  compat-include/linux/kref.h | 46
> +++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 46
> insertions(+)
>  create mode 100644 compat-include/linux/kref.h

Applied in revision c7387df.

Thanks,
Marek

--nextPart1485455.DERrIINvaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmyP2AAoJEFNVTo/uthzADxcIAJ2aI0Adh27YYI3AMYij7kt3
NZdTYAEXUBwrvbxmFZskh/nzPp1Af3tAapTLfdAoX0+aRk+mcDPnPfkevwFqXy9u
7++Y8CVBBD7A3+i7aJ9zf5dkRZQyL2Sc+2dBu1371b9yN9t4UC2FlrHnTscr1bMe
Cy49ZncTEP5j6aBsngOfB5Pu8WMtWBZIXaNr5JPglglNV3uK6imGouKuyAiBzSpr
cri/HoM5sDQVHERiYsZnfPa+uq5J5DjYYFZ02DvNJdcs8mXQSfL5g0RMA//ZUXnF
6PVdhwsfrsBX0CpZfDPDw7IXtdSegbeeoM9op22N8Llv07L1vHxP7dxlZSo9De4=
=mZnk
-----END PGP SIGNATURE-----

--nextPart1485455.DERrIINvaP--

