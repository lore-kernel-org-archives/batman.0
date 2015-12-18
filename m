Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 18 Dec 2015 22:19:19 +0800
Message-ID: <2118974.AZIkCmtkXL@voltaire>
In-Reply-To: <1449414976-21770-1-git-send-email-sven@narfation.org>
References: <1449414976-21770-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1617652.mehQvADoIq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] openwrt-feed-batman-adv: Switch to HTTPS
	version of links
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

--nextPart1617652.mehQvADoIq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, December 06, 2015 16:16:16 Sven Eckelmann wrote:
> open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
> requests are currently redirected automatically to HTTPS but references
> to it should be only https.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  batctl-devel/Makefile     | 4 ++--
>  batman-adv-devel/Makefile | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied in revision a635b9b.

Thanks,
Marek

--nextPart1617652.mehQvADoIq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWdBXnAAoJEFNVTo/uthzAw8EIAI4013PwFEgoB/v8m9z4iCjr
vYomgtwTh2/BT+gxSwmDTcLYf1BAP1rO6Qlup7JUt0uhFrcrNabAjXMzstYmpEgI
NbdoUlcB5ads0yGvXSXHtMMGzDPucUDcYB+TpvuiJ4LzsqKC7qcMbdkGB6bxYFnr
sFFcV2LYLmH6J20a/mgWWw8vgzHN7K4vA1pS0sRLVPaU83ofkcwHjNTpdrd6WklX
Jr/+1f06mUbieznLLSNGeyfwDELmqn2GIFCVYZPCn1J8RAthe4xM1aaUfpggJjqI
1iF6QkmdOGHCkbps7uOJnvTlLO38gKedr9+82tlkpI+J8Hc/Jx6Sj2cB7BIrD+c=
=P8nc
-----END PGP SIGNATURE-----

--nextPart1617652.mehQvADoIq--

