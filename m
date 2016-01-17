Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 20:03:25 +0800
Message-ID: <4749751.TYUGV3NsbY@voltaire>
In-Reply-To: <1453024887-7215-7-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
 <1453024887-7215-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9953555.USpZz5GXxs";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 07/19] batman-adv: Rename
	batadv_backbone_gw *_free_ref function to *_put
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

--nextPart9953555.USpZz5GXxs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 17, 2016 11:01:15 Sven Eckelmann wrote:
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
>  net/batman-adv/bridge_loop_avoidance.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Applied in revision b66a782.

Thanks,
Marek

--nextPart9953555.USpZz5GXxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWm4MNAAoJEFNVTo/uthzANRAH/jj03DyLWQ5lkLkf8J7INOws
BQJPDxpkbLkoVzxTh+O2NU8vAybRD9GhfNE3xnXnSYjojEZqva4qkzb3/HxzioyM
jgH+8mkdTHYGP3KMJAy/CoVmPQtuAW9ukiQZxB3AxdfDiLa6fK6PdyTUa08vef9T
YhajyOQCi6CnSBZrCDsd85hjH3ahVsxdnlsFscca5r+J4a9WZITXypACernngB3I
Mayed4+dA4Ldr+a1eCCpxtQ+zDW0XcWAzKc8dXp+wDTRnqM8DaG8Ls7TUB/ug2zM
I6RIbqECcYInLmDlas8c4V79raq+EYf2lEJb0nMFsu8RaXlRLMv+v8ymUeuv1X0=
=+T2Y
-----END PGP SIGNATURE-----

--nextPart9953555.USpZz5GXxs--

