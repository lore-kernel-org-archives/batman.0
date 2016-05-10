Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 May 2016 23:54:07 +0800
Message-ID: <8658751.7b1qMqDYe2@voltaire>
In-Reply-To: <1462812071-16467-2-git-send-email-sven@open-mesh.com>
References: <6307812.WAqRcEYAvX@bentobox>
 <1462812071-16467-2-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1544076.gapzAhazds";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 2/4] batman-adv: add netlink command
	to query generic mesh information files
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1544076.gapzAhazds
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 18:41:09 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> BATADV_CMD_GET_MESH_INFO is used to query basic information about a
> batman-adv softif (name, index and MAC address for both the softif and
> the primary hardif; routing algorithm; batman-adv version).
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: Reduce the number of changes to
> BATADV_CMD_GET_MESH_INFO, add missing kerneldoc, add policy for attributes]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
>  compat.h                        |   6 ++
>  include/uapi/linux/batman_adv.h |  18 ++++++
>  net/batman-adv/netlink.c        | 135
> ++++++++++++++++++++++++++++++++++++++++ 3 files changed, 159 insertions(+)

Applied in revision 58b0bf5.

Thanks,
Marek

--nextPart1544076.gapzAhazds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMgQfAAoJEFNVTo/uthzAnZQH/2PnGZ2dYylqLFVWO6V84Oic
9f+JQqYZf8ZeKMKIY1mKV3G9UCxb7a6j/35mdw/QWYM3oXf3+6hyvYXVyYDP2Q0O
5i3mKY6QjPn39lvWOUQu2B3SvlbPWymSspPHem4soR3DwT1mkKmwc8Dyzbja1W/k
tLKfzKQE8JBINBx/kJTFs9e2ujcSOa8X0PSU1QFE6n5FDGuxkscp2a3pYn0205Y6
8IeBtuBdlbxN0sjUsMwLdV5QwOOiSw7HpbvZfIkTd029nirT86NWxP2DZqoiTsfd
kTWGNm9uQTzXpw46zUn0vQxqjyYVC1WiNFVSrM1CvTHMc1SS6jiJPgM9geE2h7Q=
=COjz
-----END PGP SIGNATURE-----

--nextPart1544076.gapzAhazds--

