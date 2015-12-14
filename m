Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 Dec 2015 20:48:52 +0800
Message-ID: <2192336.pzPdSVonT0@voltaire>
In-Reply-To: <1450082911-3976-1-git-send-email-sven@narfation.org>
References: <1450082911-3976-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2695306.RAScLSigol";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix build with linux < 3.9.0
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

--nextPart2695306.RAScLSigol
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, December 14, 2015 09:48:31 Sven Eckelmann wrote:
> netdev_master_upper_dev_link already had a compat layer definition for
> linux < 3.9. Move these two different definitions to the same block to
> avoid using redefinitions which can break the build.
> 
> Fixes: e19f387b9538 ("batman-adv: add possibility to pass information about
> upper device via notifier") Fixes: d794c1cd9d4f ("batman-adv: propagate
> upper priv via netdev_master_upper_dev_link") Signed-off-by: Sven Eckelmann
> <sven@narfation.org>
> ---
>  compat-include/linux/netdevice.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied in revision 84e11be.

Thanks,
Marek

--nextPart2695306.RAScLSigol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWbrq0AAoJEFNVTo/uthzABU8IALgnAuLMAiRJWhZSLRLfO10v
AuEHgbWzj672cZLd34BZ4BgxAYTxcF3p81N7jO8+ZU/H6JkDee/Po5U7HCMCdABf
5mDSR/Vp4J57+rVXTGIVDFpgOyxFhx0gYln/wLI9WhdH33Mg1xwIG+lJ25ODv+mL
wuKJbs+V5oS30bfqWLUrXL8QxOfM8wz1yA2Z3mgiXxKjR4EQ//tfPn9/FkMjTSRX
+WPcLMgGf0OGlnX3axr4xIR7h4FD14NpZeCZW3PhYzLFbIuuFtEW+PJkf1R3eq5K
tnEKtnj1L0kFSF+/HWIf9WM9/J3IAtDhSukeirT0lV5kBPohFy6jMuZhT8Eds0c=
=W5ym
-----END PGP SIGNATURE-----

--nextPart2695306.RAScLSigol--

