Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Nov 2015 05:41:11 +0800
Message-ID: <9404731.X0O5MAURfE@voltaire>
In-Reply-To: <1447765886-5743-1-git-send-email-sw@simonwunderlich.de>
References: <1447765886-5743-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1641237.pvlYvlYqYJ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: only call post function if
	something changed
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart1641237.pvlYvlYqYJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, November 17, 2015 14:11:26 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Currently, the post function is also called on errors or if there were
> no changes, which is redundant for the functions currently using these
> facilities.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  net/batman-adv/sysfs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied in revision 743df46.

Thanks,
Marek

--nextPart1641237.pvlYvlYqYJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWUOT3AAoJEFNVTo/uthzAzx8H/iqaJSSYFExk3DEjA69enbE9
nP0KCoV60Dao8P2FWpwXMkA45dLp1bLiWW+8naQd6wYijCwJE+oxkV2ZYL8pql7y
zi/bI1j775JxHI/mJthmnXNk23rDbN8vZY4gyDJTWd8ILPve8/Qtsr6C3UamgohW
pxmerGwvUwDKFPZyfe4NfYOc1RzHxw1ChY9RAQwB729OVfOGCs9Xi4cCmtJJV8kx
WyfEMom4F5U02qvanniU8NKV7VYdNVYoBe6Rynzbonwzi6gj2Kx0We0TLfix07GH
g4UNPkHVidQCbz1Y1v/M11jmThJ+4cOt3CgbeZr4aauRd8FXSVG76gCeIe9Fa4A=
=gCH8
-----END PGP SIGNATURE-----

--nextPart1641237.pvlYvlYqYJ--

