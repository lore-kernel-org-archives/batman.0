Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 18 Jan 2016 13:51:17 +0800
Message-ID: <40365065.qp5bX4xiHF@voltaire>
In-Reply-To: <1453024887-7215-19-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
 <1453024887-7215-19-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6346678.4OL4uWt8HH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 19/19] batman-adv: Rename
	batadv_tt_orig_list_entry *_free_ref function to *_put
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

--nextPart6346678.4OL4uWt8HH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 17, 2016 11:01:27 Sven Eckelmann wrote:
> The batman-adv source code is the only place in the kernel which uses the
> *_free_ref naming scheme for the *_put functions. Changing it to *_put
> makes it more consistent and makes it easier to understand the connection
> to the *_get functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v7:
>  - removed patches which are now applied in the branch master
>  - split *_get -> *_put rename patches into smaller patches only renaming
> single functions
> v6:
>  - removed patches which are now applied in the branch next
>  - rebased remaining patches on the patch
>    "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
>    modified by Marek while he applied the patches (this unfortunately made
>    some of the remaining patches slightly harder to apply)
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
>  net/batman-adv/translation-table.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied in revision dcd61a7.

Thanks,
Marek

--nextPart6346678.4OL4uWt8HH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnH1VAAoJEFNVTo/uthzALmsH/1nRGMSrXjDqrTjqRcPVtbwS
tX1YgvCkCXB5WWxYRMWnGjtoH0YTOjxU/gCDICJe2gO5tuUdcOTICNgDcaDhrDYv
5uo80F6BLxrEnSYC7b1XPM/vd4/TKqIqvkF10TyCFlOm3uQpndev4K8WVLP/IDy4
od0GlEBVbB02BV0zzuBg4I6WfL378iEuWktD6CfkBEwkLM1Hqz4D1ZLxYOq2YS2T
ye1OvSE5B1rL+LTt1eAkiZhlghhRJeLyj1JkSJYu/ohuCB73tcKg19/cYsXV9oqN
7KhEaFuSiT9ymlZSrITI1XPX+C/uHjLSuI1ss28oxqadHseeitimXhfd+9fX4Sg=
=3H6V
-----END PGP SIGNATURE-----

--nextPart6346678.4OL4uWt8HH--

