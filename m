Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 30 Aug 2015 17:56:36 +0800
Message-ID: <5610936.OWXkkxkm5r@voltaire>
In-Reply-To: <1440577481-14719-1-git-send-email-sven@narfation.org>
References: <4340969.K0PsB6WH4o@bentobox>
 <1440577481-14719-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1480571.izaqKQNXfe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert to using IFF_NO_QUEUE
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


--nextPart1480571.izaqKQNXfe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, August 26, 2015 10:24:41 Sven Eckelmann wrote:
> From: Phil Sutter <phil@nwl.cc>
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: added compat hack]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Yes, I go the "route of shame" and added this weird hack. But at least I
> don't substract functions from each other.
> ---
>  compat.h                        | 6 ++++++
>  net/batman-adv/soft-interface.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Applied in revision 071aadb.

Thanks,
Marek

--nextPart1480571.izaqKQNXfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV4tNYAAoJEFNVTo/uthzAfWcH/iCNpyEVDUVLez6MJGi3w7nD
gsTzTovTRuL4GAL4PbDfMv+pc7EPWBiqrc/CmFofSBXlPRzkgKKrK8ut0f0DmsTl
Ff9Qz8d3xASx7F5kkrwSmRwzdPCSLdhWXDmL/falv1eVhHKRoKr9jFVIKeOW4Hh/
i6bwRH4hAeAGMjyaGoBH1jJPLsT3lKxmGK0s3iErpV0kxgf7FVR+ll5uQ1t3l9G4
hkRCsWbdsmbdU9UePM9S0EuLEPEm/Jz6AzIBpZa3t3xwzbNN5fvCb39BujNtgouB
zbx1tKq7O6PTGTHivQL/4ogQoadO9xpdBuUOLv0ciwPR/PkHJEj/4FbO29c0g8U=
=+3yi
-----END PGP SIGNATURE-----

--nextPart1480571.izaqKQNXfe--

