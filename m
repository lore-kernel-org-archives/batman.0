Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:57:43 +0800
Message-ID: <5361262.4S9RTfX7zp@voltaire>
In-Reply-To: <1467545508-7333-5-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart112968665.kMD62x65j8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 04/16] batman-adv: netlink: hardif
	query
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

--nextPart112968665.kMD62x65j8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:36 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> BATADV_CMD_GET_HARDIFS will return the list of hardifs (including index,
> name and MAC address) of all hardifs for a given softif.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: Reduce the number of changes to
> BATADV_CMD_GET_HARDIFS, add policy for attributes]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batman_adv.h |   4 ++
>  net/batman-adv/netlink.c        | 128
> +++++++++++++++++++++++++++++++++++++++- 2 files changed, 130
> insertions(+), 2 deletions(-)

Applied in revision 55d368c.

Thanks,
Marek

--nextPart112968665.kMD62x65j8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKWHAAoJEFNVTo/uthzAbHMH/i89m1eLxAcmwbeOXN62K1+O
6NfiDaVBYtETKZghrxkbPuD7d59AXULhA1zA6l9DztFfayTxAjcGqWWXQGwtQ0td
SWkJ+2gEeX49qQK2n/Ns7NcueNyiZ6lZNOIwqTIs7dNiM2bA0IR+4SAIM8FBgtWd
djLUszC+tqTodIres8FKPaK6BzHHsSLSuOdo5veFaFw3+N/OfR8RkzSreCglZjvB
uDzhkB+J/Z4UyCiLbPHwJ0hT/jNdPvEBA+3Hln7q1BB+qk/eFNzWiHl7JQKmWHgc
NOAPuUS8Hg9UntHg8cM8m41o5TPXTHo3Ao00tHGaTSbfpav45tBl1HZmTd5YK9Q=
=LzHH
-----END PGP SIGNATURE-----

--nextPart112968665.kMD62x65j8--

