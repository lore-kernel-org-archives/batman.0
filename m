Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 15:58:46 +0800
Message-ID: <1729609.XgNj73ylAR@voltaire>
In-Reply-To: <1467545508-7333-15-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-15-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1762763.NM18zV4VRH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 14/16] batman-adv: Provide bla group
	in the mesh_info netlink msg
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

--nextPart1762763.NM18zV4VRH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:46 Sven Eckelmann wrote:
> The bridge loop avoidange is the main information for the debugging of of
> bridge loop detection problems. It is therefore necessary when comparing
> the bla claim tables.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/netlink.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied in revision 28489de.

Thanks,
Marek

--nextPart1762763.NM18zV4VRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjd22AAoJEFNVTo/uthzACEoH/jrB8lm7wk/AgO+os9zVkLmv
BC+wuIn22qcdSc7wCrMbpjR6K4ZNMtEBT+NbS6O+NWLEEO7A9hyb74W7meYrbELt
mXPe7qsVHm25klVD7pS/PrHoVKdYvQ96jYzPhSH666qnn4bsQWKdd6vGijD+HyXY
aH/IEc1imonzqy4fDXqprrJc6NmZeDMftWmIjeRNk0rG4oT7XunR+hiXycRgoheR
PdFhqNTNPYwb4bS9YlM7sEUgZ6xZvGCFJE4QVAOUsFzqYk9fpV+nhM9uZiJ8jJdA
wXKIXsvQvSJuszKApmOjDrJlLmqOVh6pnkzRU7rpjvOCqkxuftSmZvF03UpwP60=
=3mkH
-----END PGP SIGNATURE-----

--nextPart1762763.NM18zV4VRH--

