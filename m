Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 13:32:07 +0800
Message-ID: <4749674.C1WtHlruJ6@voltaire>
In-Reply-To: <1452936598-28619-9-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3452607.YXDK4NhDmQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 09/20] batman-adv: Convert
	batadv_dat_entry to kref
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

--nextPart3452607.YXDK4NhDmQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:47 Sven Eckelmann wrote:
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
>  net/batman-adv/distributed-arp-table.c | 27 +++++++++++++++++++++------
>  net/batman-adv/types.h                 |  2 +-
>  2 files changed, 22 insertions(+), 7 deletions(-)

Applied in revision 4952250.

Thanks,
Marek

--nextPart3452607.YXDK4NhDmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmydXAAoJEFNVTo/uthzAAEsIAKtQH8pg7WlVVdKBgQIl9Zas
RTn6tCaNs/OgGzz5ctmSV08q0WToVIZ1lVrO1XgacB0iv080yX1VGsvfr4XJtyyn
Zuk4q23Pp58WBD5k/lgjEkf3w3z52lj0MQl9qWkRGE1rZzcP7/ojy/GsHQr2Rgm9
gUk1qnaXF0+CeiEXYnb9FqzbBGQG+nTNpJwVzj8LTho3rwHUKi73yAc1oXx5/dxS
YFzqvl2EpQlxZ0GPNa5B7s46tSAmJdKMyNvIng0lvrYgMceD3649Ky9eiU26WPMj
kJwa8iqE4lK4hPyj/bNP29OGnxPyNtnCBza6xMIzbCcN5wqR67c6cfbDMZL7jMQ=
=vj3W
-----END PGP SIGNATURE-----

--nextPart3452607.YXDK4NhDmQ--

