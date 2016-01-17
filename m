Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 16:38:40 +0800
Message-ID: <1735193.DO0vCsAMTi@voltaire>
In-Reply-To: <1452936598-28619-17-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-17-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1708706.8AAdDmukjN";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 17/20] batman-adv: Convert
	batadv_orig_node_vlan to kref
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

--nextPart1708706.8AAdDmukjN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:55 Sven Eckelmann wrote:
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
>  net/batman-adv/originator.c | 26 ++++++++++++++++++++------
>  net/batman-adv/types.h      |  2 +-
>  2 files changed, 21 insertions(+), 7 deletions(-)

Applied in revision 33b1d7c.

Thanks,
Marek

--nextPart1708706.8AAdDmukjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWm1MQAAoJEFNVTo/uthzAxgcIAL4q72NePdPieT9UgyBMJMWk
S6Y4aIYSxzvEBqh0klTvD0QugfFiDv+NAwyBEOQqNgCBZ4aFObRskqlgs8BEiLrW
Y5q31m+Zp+hmI3Vv9gxYr+Vz+ce9RMK5MCCeIn7yQByYgfL+hT4xUccT18rQiUbR
Dy7UhuKXtU3pW42IcCKcQDkwhdKYiOsusp9RvYUpt1LMPRFS5URzIqCpUphsbqlc
7WYbLjxxGAs0h0r1VjMr+5olzJcWHHuyIW+3lBLP7j6EFvW6LsHpoH2Kc8S0hWr8
fDkRlZ1r2gRguPQF0zJTGYemcHvvEtF0GfBVkAAdYHSsuG9MlxkpIs4VVydKzno=
=bQBN
-----END PGP SIGNATURE-----

--nextPart1708706.8AAdDmukjN--

