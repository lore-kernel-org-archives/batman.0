Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Jun 2017 21:41:56 +0200
Message-ID: <2028385.iHyglIbUJM@sven-edge>
In-Reply-To: <c3693cdd478c68f078f105f55972a4406b333e69.1497432565.git.joe@perches.com>
References: <5300874.nPgxNW8UST@bentobox>
 <c3693cdd478c68f078f105f55972a4406b333e69.1497432565.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13492754.E2cbH7caMq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unnecessary length
 qualifier in %14pM
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart13492754.E2cbH7caMq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 14. Juni 2017 02:33:52 CEST Joe Perches wrote:
> It's misleading and unnecessary.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The patch was applied and is currently queued up as 
454ea1866ef45c6f1b747bd27a8203318be72b5d in batadv/net-next.

Thanks,
	Sven
--nextPart13492754.E2cbH7caMq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAllBkYQACgkQXYcKB8Em
e0YTgg//fGwGz+F0a3HpSTMOa8UCkn2Dj4IRL7+E8Lyix4BjjeF0Yu60q0s+5wGG
KLJkjWtn2mdfXjPo8Z8qlay+O3H6OBQGnCJ8n0YnvdmYlfl2bp+oY8jPOhOQ6ILN
btZ/6VqQBODZB+ueFNtL+7iLA2z1khRD8H5hMnLH6A8IE520q8O4PU/SNYF5Hxvg
z5QgpRp4IDLSC0lTHpyKYQEsEKY+w0k7pcBFTr7iCZO5BWidy6H2wLK+oe7l+OGN
527Dra9vsQVEuvd8cVKGiwFBInH0UpoBze5tYrOq70CyYDy9mo//7/ypTVPQQOs3
/V/167F34lUmdTnLZTdaQCEqhKuAcar4CdrzxZc801Wonm2+F7sM2awKkZySiQPd
GzYAizqVnigmO6nDGRYRFmqFNcS4mM1ltbACg+jGXezln3wTTSqyP4HXCpVd2t8a
LgAp53wQaEfEnYSvtoaSnInKGKhf0jcfjazi0aY7gwZghfMshgTYalDHdv9AMDxP
lIzOzKDXWtJzwsOyOSutFtf3CtKds8wy5DxrjP7NEhUasNKjg8EmadRmZUibuTYg
dbTQKWrlMA01MUbAxiQ1KBEg2nWMhV45E5GUgR7KoFMhU7xS8HCvhgvTWBPM1Pf2
KQCQ12puwPJhTU20sesW7l2fgs/r1oWa0J8k6ajz64sfsmfW7Ww=
=wuow
-----END PGP SIGNATURE-----

--nextPart13492754.E2cbH7caMq--

