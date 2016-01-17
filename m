Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 14:51:32 +0800
Message-ID: <3824999.u9E7FWGzI0@voltaire>
In-Reply-To: <1452936598-28619-11-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-11-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2930742.hQujQP4tWL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 11/20] batman-adv: Convert
	batadv_tvlv_handler to kref
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

--nextPart2930742.hQujQP4tWL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:49 Sven Eckelmann wrote:
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
>  net/batman-adv/main.c  | 24 ++++++++++++++++++------
>  net/batman-adv/types.h |  2 +-
>  2 files changed, 19 insertions(+), 7 deletions(-)

Applied in revision 88c5eb2.

Thanks,
Marek

--nextPart2930742.hQujQP4tWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmzn0AAoJEFNVTo/uthzAKN8IAK5WAn4jLas17BdNrCwgf9XC
y2XI7a0IQDpi4HMwkj8YQVghSLVDxT6ozBqtO9OCj7simZ57c8WXp85Ow/D/SVsE
UhFK+kx8wF8L8kepdq9TENmKv2JVvqS1MOHTS4+bHJ8YpZsCv1Z/AfJtItU0pmgC
KhHzHlttraLUAttlX5BwRPgaPBpJyVdGS1ll+0oQoRypW8N2jvkjPQ4SN6ZJCbkn
VLwvbgfupQiTTZhyUVyWe+Ld0JxiqSuy5kdYTx4kYjV19pImMz3yHCfQNaJtfv/0
qvgJTCHbt7d2KZDatuVvPjM8KKAwAeBk/85lkf5Et2HTkTWEqTfo7AQHUFWt3Wo=
=d0Wy
-----END PGP SIGNATURE-----

--nextPart2930742.hQujQP4tWL--

