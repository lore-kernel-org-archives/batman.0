Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 16:40:05 +0800
Message-ID: <11533184.QAJj9ucsll@voltaire>
In-Reply-To: <1452936598-28619-18-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-18-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27943972.WzGi31DRhi";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 18/20] batman-adv: Convert
	batadv_orig_node to kref
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

--nextPart27943972.WzGi31DRhi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:56 Sven Eckelmann wrote:
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
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/gateway_client.c        |  4 ++--
>  net/batman-adv/multicast.c             |  7 ++++---
>  net/batman-adv/network-coding.c        |  2 +-
>  net/batman-adv/originator.c            | 14 +++++++++-----
>  net/batman-adv/originator.h            |  4 ++--
>  net/batman-adv/translation-table.c     |  4 ++--
>  net/batman-adv/types.h                 |  2 +-
>  8 files changed, 22 insertions(+), 17 deletions(-)

Applied in revision 090a800.

Thanks,
Marek

--nextPart27943972.WzGi31DRhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWm1NlAAoJEFNVTo/uthzAR9UIAJZ4EZosNluCKqBBJnn4t4qO
xxl4YJ2sZ0VEqCwQ2KzXyKc6Us4U/LcgZU2741a8gIQlUPCE7ntfu0xseJMYFg0e
oRFiLwhKkcYL+25RUoPkAkYP0g/SeRXbh2kdTYLRbLi+0X8qGo3tsfz05aF0Uo7Q
5N68SSxnGgNB5Kj+gT4f0UgpI9zB/3Dao0uFGcVjfGCHkNl2rAssz8s3ueWE7eBE
zlCJ8OjGDqN3XF5yD24ED//yHs+P6WRab0vIjY+xooGjH+K523aJLvSvnGQK+p9w
sP3VmYemr2+mOTk6gPA+ot6W5PWc7Z20+aQUXrxnydMYyz2vfMRdV4DAdRzyKvA=
=1s51
-----END PGP SIGNATURE-----

--nextPart27943972.WzGi31DRhi--

