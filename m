Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 15:51:17 +0800
Message-ID: <3042705.kv0HB0rhHr@voltaire>
In-Reply-To: <1467545508-7333-12-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-12-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3646423.khUWAZ2gok";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 11/16] batman-adv: add B.A.T.M.A.N.
	IV bat_gw_dump implementations
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

--nextPart3646423.khUWAZ2gok
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:43 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Dump the list of gateways via the netlink socket.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: integrate in batadv_algo_ops]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/bat_iv_ogm.c | 105
> ++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 105
> insertions(+)

Applied in revision fa32289.

Thanks,
Marek

--nextPart3646423.khUWAZ2gok
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjdv1AAoJEFNVTo/uthzAg8YIAI5LH4URuLBd7PP36Imphqx1
2hp2LOTUT/tvM+fREm47KGJxvi8GEYJRvnQdcE9JI2eXv27YLZla1WL/BytF8wkq
QX9/OCoJFKMxXuqyLELjbIKs9atva43+JISxbRknfXLK1UqjQ2SncuDKiBVucdpb
IRsuPRA71cL2ZDNEOSRCDalCgYNApmc7A6UUfKPf+ayjvkagkmwr+z3vQ37my8Hr
YbNrMoLAsTK7y9cs5lX1ZPDodraC6EaeC+zdnKBteG4lfsZn6As0018yMVf3upq8
Wmh978Pi+BqZhypMhgZMcZu6daKUyrijja5PLY+eXv6TWRe0cxjf0elcS+nCR6c=
=5L9Y
-----END PGP SIGNATURE-----

--nextPart3646423.khUWAZ2gok--

