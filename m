Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 15:54:49 +0800
Message-ID: <5080037.FAmTTRzGj4@voltaire>
In-Reply-To: <1467542795-29647-3-git-send-email-sven@narfation.org>
References: <1467542795-29647-1-git-send-email-sven@narfation.org>
 <1467542795-29647-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2116321.nja0CsbRgp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 2/4] batman-adv: make GW election code
	protocol specific
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2116321.nja0CsbRgp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 12:46:33 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> Each routing protocol may have its own specific logic about
> gateway election which is potentially based on the metric being
> used.
> 
> Create two GW specific API functions and move the current election
> logic in the B.A.T.M.A.N. IV specific code.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v6:
>  - added "(optional)" to the kerneldoc of get_best_gw_node, is_eligible
>  - use seq_puts in batadv_iv_gw_print
>  - add comment for get_best_gw_node in batadv_gw_election (removed from
>    patch 3)
> ---
>  net/batman-adv/bat_iv_ogm.c     | 219
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/gateway_client.c |
> 217 +++++---------------------------------- net/batman-adv/gateway_client.h
> |   3 +
>  net/batman-adv/gateway_common.c |   5 +-
>  net/batman-adv/types.h          |  11 ++
>  5 files changed, 263 insertions(+), 192 deletions(-)

Applied in revision 7d94776.

Thanks,
Marek

--nextPart2116321.nja0CsbRgp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe2fJAAoJEFNVTo/uthzAHi8H/36SI19HfOIMFmr3wxCwwdpW
hwtGClIITSYT6G0NGTnsYAwuNdOsnuT4VOkVnFAx0c3X3P319GxYMiANQd8L04jB
yi0+wFa9o/px9iGfKsXFDdALcWCTO46xM0Bx9ahUOngbP8JNiXtZO8YQOyribrdJ
zSjbI3+dAacrEptM2Iiv3h9XjfJ/oT/f//wRhEUipxXPVQeUrP57vlKmJ9GneJn5
0fxTa0vNrfj6fiZKX255LvgHOnHk7PKXvd4CCX/AFeXnS13nK1SIauBQXkZFX/1M
NLA4IoMO2N83LfuY8/zBsWd1Br+C6zI79PncwDD+qHe77FBxU/G5pBqLaIksD3U=
=OfbH
-----END PGP SIGNATURE-----

--nextPart2116321.nja0CsbRgp--

