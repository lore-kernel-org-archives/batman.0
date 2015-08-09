Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Aug 2015 08:26:44 +0800
Message-ID: <1883652.P2JEACJQeD@voltaire>
In-Reply-To: <1438994805-5174-1-git-send-email-sven@narfation.org>
References: <1438994805-5174-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1657173.qU5POu8Onm";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark
	batadv_hardif_neigh_free_now as static
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


--nextPart1657173.qU5POu8Onm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 08, 2015 02:46:45 Sven Eckelmann wrote:
> batadv_hardif_neigh_free_now is not used outside of originator.c and should
> thus be marked as static.
> 
> Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors
> per hard-interface") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/originator.c | 3 ++-
>  net/batman-adv/originator.h | 2 --
>  2 files changed, 2 insertions(+), 3 deletions(-)

Applied in revision e821b76.

Thanks,
Marek

--nextPart1657173.qU5POu8Onm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVxp6VAAoJEFNVTo/uthzAOWIIAI5xpt/cXixwLNCWgFQ3AayC
UfJaQmLQlMUn+zMrkfo7gdGAsAKV+Afhpz24g/YU2hNjyiJvtrmw6mKFsTcWQr2i
SxLLzwD6HRnFdiza/oEkNQjayXreBzFhoStCl3DwE3qPMtBOTibAws0suDNEb5Yc
fZfVfGqzaDe3DCW1z8dHHvql6/vglY8yYpff95O6XJDxvM01c4WMAWnFIliLMNiA
9W1eX7v+QbpYhodd8hm3YOX5bCQjQ80e20MRNJTwEHgy39OSPZxnyBbpyFHqymEd
yIBaXRz3rzxkBAj+tSI9q0A5HECNBSPZo60Z/wKcxWQe9jpoehwEOwHUFwE0u7c=
=kLy3
-----END PGP SIGNATURE-----

--nextPart1657173.qU5POu8Onm--

