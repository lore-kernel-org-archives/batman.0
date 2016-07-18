Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 18 Jul 2016 10:15:58 +0800
Message-ID: <1657435.3NNlWPGQ0a@voltaire>
In-Reply-To: <1467545508-7333-10-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-10-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1511073.Tuzj2H357y";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 09/16] batman-adv: add B.A.T.M.A.N. V
	bat_{orig, neigh}_dump implementations
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

--nextPart1511073.Tuzj2H357y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:41 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Dump the algo V originators and neighbours.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven@narfation.org: Fix includes, fix algo_ops integration]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batman_adv.h |   2 +
>  net/batman-adv/bat_v.c          | 340
> ++++++++++++++++++++++++++++++++++++++++
> net/batman-adv/netlink.c        |   1 +
>  3 files changed, 343 insertions(+)

Applied in revision 2ec4acd.

Thanks,
Marek

--nextPart1511073.Tuzj2H357y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjDvfAAoJEFNVTo/uthzAcyQH/0GFKgvpNAErAtIqIwGl03DZ
GMSUFFv/BgnEBQkIcxy/Y50gzTkr4UtZjouBPbnPKVnXCfHwAZumEZSpXYgfPD7D
lCXtcAoy6BbIWKVJ5L+8g2vyvjh7968sYrbDnPEIOZMuVT2kAZE8XDDErWFt5kpY
yT4tS+OktZwtcRstbhX7npOyRKtC6j7vZLUwQG0cuhz/b+6kkAURG8482kSzgEdr
ysFdnD3dZCjvHjKJ4yUHJDDVJoBO3I5QAIqaP3fD7oollAY8SqmR2t4uU/6jhOGc
cuaWmBR4DBy/WFBITGQYCKExpP1vor6tSSBzWyq1I/+sIW3LOKdmM7JlvK+mGZw=
=SkbP
-----END PGP SIGNATURE-----

--nextPart1511073.Tuzj2H357y--

