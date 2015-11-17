Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 15:36:29 +0800
Message-ID: <7313059.GSjtyzsGXR@voltaire>
In-Reply-To: <1446803119-3392-1-git-send-email-sw@simonwunderlich.de>
References: <1446803119-3392-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2317605.hOvbcyOqLC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Update/repair bridge loop
	avoidance kerneldoc
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

--nextPart2317605.hOvbcyOqLC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, November 06, 2015 10:45:19 Simon Wunderlich wrote:
> Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
> Changes to PATCH:
>  * add bla_init return description
>  * fix backbone find return (it returns a backbone, not a claim)
>  * remove Svens attribution per his request
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 177
> ++++++++++++++++++++++++--------- 1 file changed, 129 insertions(+), 48
> deletions(-)

Applied in revision eb90dff.

Thanks,
Marek

--nextPart2317605.hOvbcyOqLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWStj9AAoJEFNVTo/uthzA380IAI4ODgSrvapfrGsE4wVU+Sg6
lHsdWiQJzsBpnHHhUpmYJ9jvi4AHGm26TGrmvHmsjBR0xTcyIoQcXvfR1yJOLyty
0YJzlwGN+uWzlOQSITqsZ/y1kL/fGBZwPoTeRSb9uGcy2leJ7ND3yB8NNPG0Uvwj
5V71ss2cMi1XdU8Q2Pzk8dP4/4ngWtAe6WscEIzU2pf6wEBZ+zddlsr1pYqD/mWp
0iunaqAxlQ32gYHHB/nhnnN+Hn2Qw3B1rA0QuKXtcMuwUh0gCprjDoYJPzeDLJ+5
ecmIrmf/WEOC7XXzu6ZVaDYHwFe72ZcSCO7j24g2HURYeVVEAU3z+k4LE3B+1QA=
=CAu/
-----END PGP SIGNATURE-----

--nextPart2317605.hOvbcyOqLC--

