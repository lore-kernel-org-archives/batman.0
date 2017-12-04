Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 04 Dec 2017 12:59:50 +0100
Message-ID: <2742240.Flf4YFj6lS@prime>
In-Reply-To: <20171203102645.5490-1-sven@narfation.org>
References: <20171203102645.5490-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1632135.s4W0t90Mje";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix lock for ogm cnt access
 in batadv_iv_ogm_calc_tq
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
Cc: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1632135.s4W0t90Mje
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, December 3, 2017 11:26:45 AM CET Sven Eckelmann wrote:
> The originator node object orig_neigh_node is used to when accessing the
> bcast_own(_sum) and real_packet_count information. The access to them has
> to be protected with the spinlock in orig_neigh_node.
> 
> But the function uses the lock in orig_node instead. This is incorrect
> because they could be two different originator node objects.
> 
> Fixes: f14416760b62 ("batman-adv: protect bit operations to count OGMs with
> spinlock") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 9a3b1954.

Thank you,
      Simon
--nextPart1632135.s4W0t90Mje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlolOLYACgkQoSvjmEKS
nqFTVhAAg55iczO1AtUWVCpRwgHw1SFe+D7ykqN2Mtuy3cdBmADJvCM9BeD5AaG8
3e2fclDdxfpgdljjRVKZLShj63Kwp+nKEQBtc/leBtA1z8dsac/h7+WTrdDJf2w7
VIQw/t4R9pZvs7JtyBVHGwvt1uBxIdpt0XPFTDxEe9TSnArlfUnUJINYVFMtAutp
fkTXSvT0bDpWu7UdBc+Y4DpYE/r1MdzFKxaNP09aCcrXQfN1427qw5r7fAfqkIAH
OTirFJ/+R0DgJjnnwcMTDnocT2dzr+fHDRfE2mBzqRdjoS9HlSnAg+OK6war0vs5
toLpgyIP4Vs6AfXO+/yJKbSPNjTStJRIZ4vTSmSSKNq+gySddufYO/XIiltUjqmb
7tSIILLYqdXwR3VDqnylneiZRoikQ5DymKOZ4DKtrdw4Dq38CebG4GhzyFQIil1r
3j0tf98xWObSJQ1d4X/moorSnA6SR/98IkRrGQM0f0ub0Ev1A+hg/cWN9MW9hGC3
1H3jPP77U8cS/HcrEPlpVTKSSnqHKer8u8m7IqKiivwPDkN6cdlduA5tRSFKQKdo
RQHV80CJ99g6K0sC56XK+rzwdNsYKKIQlCKUSCTYAfkYCp8he2DKv8QYEJ4BBUmE
0M0quEt6WBCCTLg0W0xFyEgkmzzxDji9CTvrOlyVp9zs+ibv5hI=
=FCFI
-----END PGP SIGNATURE-----

--nextPart1632135.s4W0t90Mje--

