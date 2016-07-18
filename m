Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 18 Jul 2016 10:06:22 +0800
Message-ID: <1799313.ml6MyvNgHO@voltaire>
In-Reply-To: <1467545508-7333-7-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1596303.XGGIykyd0X";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 06/16] batman-adv: Provide TTVN in
	the mesh_info netlink msg
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

--nextPart1596303.XGGIykyd0X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:38 Sven Eckelmann wrote:
> The TTVN is the main information for the debugging of translation table
> problems. It is therefore necessary when comparing the global translation
> tables.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/netlink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied in revision a754c02.

Thanks,
Marek

--nextPart1596303.XGGIykyd0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjDmeAAoJEFNVTo/uthzAJukH/ip0fiJ4liv/QNe+Y0leoK92
DV4PS4XH3am6/Mj948Gx0HfO0NY6QXPp7Sp5+4dqqPfKq5LPkY1w1A0IQM/7QxMW
PVonWUlAj7+B2pIzHwj3wn3yjpzBOEgh/5FbeSzmy2Q0Swgq7ndGLCRwU7/0MBVM
wajsuOievSLlDpeBO/r8PMC1TxvHpwv5iEhcNMDHtwOun+FO+wisc17HUm2igdF8
Frp9HlV3ikdKQKsR+J7bgw5fHfHX+0Y7AkbhpIDOByqpA0isxL/wsp66zXIq4WwY
3TJNTknsxlyuKVTa3iT84s1/VsZ3ZJreonM5ZoJvICzW2ybiuBLXWerfrgECC7A=
=pVi6
-----END PGP SIGNATURE-----

--nextPart1596303.XGGIykyd0X--

