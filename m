Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 20:10:35 +0800
Message-ID: <22016925.aSzJM2qBoz@voltaire>
In-Reply-To: <1453024887-7215-9-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
 <1453024887-7215-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3502563.jMUbvRuqUQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 09/19] batman-adv: Rename
	batadv_dat_entry *_free_ref function to *_put
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

--nextPart3502563.jMUbvRuqUQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 17, 2016 11:01:17 Sven Eckelmann wrote:
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
>  net/batman-adv/distributed-arp-table.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied in revision 5491a0b.

Thanks,
Marek

--nextPart3502563.jMUbvRuqUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWm4S7AAoJEFNVTo/uthzASP8H/2eg+UjpCQsgBaZmiVmDT7FA
1kDHOe85J7GPJ+C97s9VuDXUFGCkLMPZQ6Oj6KWkW5K6PQOVk0Hj/fozbBAw08Gu
T7ZZDbZQd64IenWW8BN9UvHiCrzPuO2eayW1v4UKWQkunmkAyzJGueZOwuTe2oXa
zw47WXStaH8OYnka2eVLk2tZfmMreZIwPNg8ILt2AvjohwPsff4dv/DEFsnqZ7wG
Pt2A3cKNA5XHsz1uP9r4Zr1hWAAdJZonieUk7oy7RzzwiwEAbgXA/LNrs12fxb+d
jKCFGgRIqtqxcR4OYyAXE0PoHTHXyBUTAK/9EVfEN4JSynZYOWZk5Dz9n09LB/4=
=0zuO
-----END PGP SIGNATURE-----

--nextPart3502563.jMUbvRuqUQ--

