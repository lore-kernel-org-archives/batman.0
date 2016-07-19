Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:03:26 +0800
Message-ID: <1839916.e4U6hRMgOA@voltaire>
In-Reply-To: <1467545508-7333-17-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-17-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1750182.Isjt2OM8tD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 16/16] batman-adv: Indicate netlink
	socket can be used with netns.
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

--nextPart1750182.Isjt2OM8tD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:48 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Set the netnsof flag on the family structure, indicating it can
> be used with different network name spaces.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/netlink.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 5f4c6eb.

Thanks,
Marek

--nextPart1750182.Isjt2OM8tD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjd7OAAoJEFNVTo/uthzAjqQH/j24JW+89Q3LId/C+8XGPwbL
zYdrn2aJaI1B+ETgOYRdwDVTUhKM7m6nv9w+uZv/sQOZpCCFNv+sN4T18KUOhrgx
pb7nH3Y+o4lxTurk6gof114qYvzmiJDpTI3ZsSts38KHbUsSnGhNLe/hMfvI7JMs
X51QTGnh1vC61I3q4us/vQRbpQPNRXDSHUifeyatgl903A04korAYnjeuLFum7ir
jia6L/pZKgfeiVhaZn3yLcSGqHr6D94wQAm2mDqpJfg+ldyBSfpwEyPgzkRZWp1w
lsluYdeGSEiiiGYI7qMxqdPjmD/ZkEddO6TeY60ihFWcqX4LeFTj4W5ITgfL5wA=
=2Hvo
-----END PGP SIGNATURE-----

--nextPart1750182.Isjt2OM8tD--

