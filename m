Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 13:33:04 +0800
Message-ID: <60558472.eeTT6oFW1f@voltaire>
In-Reply-To: <1451992006-13191-11-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-11-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5303394.frq4KvBhnE";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 11/31] batman-adv: Drop reference to
	netdevice on last reference
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

--nextPart5303394.frq4KvBhnE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:26 Sven Eckelmann wrote:
> The references to the network device should be dropped inside the release
> function for batadv_hard_iface similar to what is done with the batman-adv
> internal datastructures.
> 
> Fixes: b25cb3ddcccd ("batman-adv: use rcu callbacks when freeing batman_if")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
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
>  net/batman-adv/hard-interface.c | 13 ++++++++-----
>  net/batman-adv/hard-interface.h |  6 +++---
>  2 files changed, 11 insertions(+), 8 deletions(-)

Applied in revision 42bf18a.

Thanks,
Marek

--nextPart5303394.frq4KvBhnE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmdYQAAoJEFNVTo/uthzAJAEH/j0cds0de65dLAAmFUQMFDLb
xQYvvtu272e2Hum7+QiyNojY+VLW0MWTaTC2RcIzpcl3ubHDSeMznP+cOWkFmdEN
4aLlZk+t4eFEG+TH4xejLAJoDdm1L9YcC803x/l/txsg+8YWeJasZ30VsHJfMN3m
vsWC9dCQmvCP6wMZEWTrDvMYHSpbaZI6gWGlendAUHd9+yTElh1YkTdonUYIIL4U
r9+CYiEVZZpqU1lrfbu9yP3Ct5Ske2kR+oAV8d9aSbIavS68fAw3SS0OeJdlEM8s
bM1oUFCbvn19sQMLTKKWxXCdJE6JD3+nLjzuc/XAZtY5evKUa1H4jFyxaRTrExY=
=khmq
-----END PGP SIGNATURE-----

--nextPart5303394.frq4KvBhnE--

