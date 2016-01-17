Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 14:59:40 +0800
Message-ID: <5980761.nm56YhHcY4@voltaire>
In-Reply-To: <1452936598-28619-14-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-14-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1584083.9ChGuyPTJ2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 14/20] batman-adv: Convert
	batadv_orig_ifinfo to kref
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

--nextPart1584083.9ChGuyPTJ2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:52 Sven Eckelmann wrote:
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
>  net/batman-adv/originator.c | 15 +++++++++------
>  net/batman-adv/routing.c    |  5 +++--
>  net/batman-adv/types.h      |  2 +-
>  3 files changed, 13 insertions(+), 9 deletions(-)

Applied in revision 0d559d4.

Thanks,
Marek

--nextPart1584083.9ChGuyPTJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmzvcAAoJEFNVTo/uthzATgMH/3ar/0YRWvBe2DSelP6fWwM1
/EnzoYq036QzAY/VmooiHk+L2TQEBkjRhlEfy5u2gWOkGMQyipDPj7HFDcExjjAu
PAXQ0IbPm+1SmMIZU9coX1P9iQo+drqRO1mPSdzOb4QPxRpFmq4FziSbv/DDE564
fw9BABkq0iq0fWC0KR1HzuCPbgPXAGR+r3vFSTtgyFDpQT63dRpYfKJL9WzMazjZ
d14gkjZ6k03p6WDJEf4MTodaLDI3z0wHd6TVy+ytDTeZQLfS4wloJOfWfQ+qegJY
n+foPcJEyvO9qxbZ34iFpPhS+FTU1RWsFuNw/LBUwJPOtFXOwTritK32gilVqh4=
=lNlh
-----END PGP SIGNATURE-----

--nextPart1584083.9ChGuyPTJ2--

