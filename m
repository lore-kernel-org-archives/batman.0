Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 04 May 2016 23:16:10 +0800
Message-ID: <4835987.pGmRxoQz1j@voltaire>
In-Reply-To: <1462211528-6680-1-git-send-email-mareklindner@neomailbox.ch>
References: <1462211528-6680-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2188820.Q6k3I38p2E";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: refactor batadv_neigh_node_*
	functions to follow common style
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2188820.Q6k3I38p2E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 03, 2016 01:52:08 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_iv_ogm.c |  3 ++-
>  net/batman-adv/bat_v_elp.c  |  3 ++-
>  net/batman-adv/bat_v_ogm.c  |  4 ++--
>  net/batman-adv/originator.c | 35 +++++++++++++++++++++++++++++------
>  net/batman-adv/originator.h |  6 +++---
>  5 files changed, 38 insertions(+), 13 deletions(-)

Applied in revision d3f00d4.

Cheers,
Marek

--nextPart2188820.Q6k3I38p2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXKhI6AAoJEFNVTo/uthzAS2UH/Ai2qUQXH3vMuvD6Me2sJZOA
CEf3cnz+TOnuShoxKdTv56IjbYptBX5uN7VmAAgPtgP4JBts+QvGL66ENdVD2BZT
lcMbEHgWNbwJEdcyh3iXu+l88FcsB/GqLvtd5qXfo8SVVgvRARlsdgzWJd2RhIw9
soeBCOhlhTIhmd4QGvU4dItkv4DGYnyIVRCdGNRm08fRggT+pTDJIX0hK9W2MQpr
QNkD0jvmP/s0PSOyc6pE/ZYIf8BH9kt4ubhnqiAP8nputqG85mnKtLIOmdDpmEeg
dHL6CJIExkwf/RP0w8/v4Kpb5HPGS2uKnhqKzIuQnFrfL/rAgeRel53TwXtG8v0=
=kFHO
-----END PGP SIGNATURE-----

--nextPart2188820.Q6k3I38p2E--

