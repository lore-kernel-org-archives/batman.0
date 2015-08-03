Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 04 Aug 2015 03:55:23 +0800
Message-ID: <2032768.UOYYEXcRd2@voltaire>
In-Reply-To: <5452191.QYeD16rJZz@prime>
References: <1437856667-27139-1-git-send-email-mareklindner@neomailbox.ch>
 <5452191.QYeD16rJZz@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1669537.Rm3ZJ1qWTU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove redundant hard_iface
	assignment
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


--nextPart1669537.Rm3ZJ1qWTU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, August 03, 2015 20:01:03 Simon Wunderlich wrote:
> On Sunday 26 July 2015 04:37:47 Marek Lindner wrote:
> > The batadv_neigh_node_new() function already sets the hard_iface pointer.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Applied in revision f645ed9.

Regards,
Marek

--nextPart1669537.Rm3ZJ1qWTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVv8cvAAoJEFNVTo/uthzAifAIAIO3nDXj5ZjPXjPWVa4BDzIp
oZwKIC0OMgk0ptp3YU0QRPcVxTiKK+fixv1Lm1+TiBuPf3MgqEe7cl5DRtEBhCw5
dLbv79/W9RLOnc4vcJdrwKCbOkPzPJ61RqGzxRYFeyuUCrBqcWQ+a+CsQwFq1cCd
iwkqeSZPlSH7G2qYuavpye9f63Tl1VbSWV2xV4x7HvlHFpWpoVptMoMBe0Rz1kva
ulIpaFKoswS8EBq+mbCdoF1aR2V9DeqEfVUIpVZZaWpzNf9CqP6F/Y4/KpuGfdGN
11webpFQDlRQ/LBIil5snxvvUGgBvNejEL3/96SDUYs+I9E3npaXawNF8G/HHQI=
=/pNK
-----END PGP SIGNATURE-----

--nextPart1669537.Rm3ZJ1qWTU--

