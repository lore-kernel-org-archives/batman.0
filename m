Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 13:46:22 +0200
References: <201105280926.32059.sven@narfation.org>
	<1306572183-25950-1-git-send-email-sven@narfation.org>
In-Reply-To: <1306572183-25950-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1932087.Ezlip7FE2n";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105281346.26760.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH-sven] batman-adv: Unify the first 4 bytes
	in each packet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1932087.Ezlip7FE2n
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 May 2011 10:43:03 Sven Eckelmann wrote:
> From: Antonio Quartulli <ordex@autistici.org>
>=20
> The amount of duplicated code in the receive and routing code can be
> reduced when all headers provide the packet type, version and ttl in the
> same first bytes.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> just my suggestion


Hm, forgot vis_packet and the 4 byte header is ugly. Maybe reordering=20
everything is better....

Kind regards,
	Sven

--nextPart1932087.Ezlip7FE2n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN4OCRAAoJEF2HCgfBJntG+y0QALuQB0GTdf+IInekz0SHnl1K
VW9E8L7Wgr9PVEeG+OgM2zl0Th4UKP2eU7x+LMygKXAFimYWHDvoCkOIs7VwLOR+
azhJeAHZ4DVsdygXHuGrzDtmpGhtWGZmZ7dVNt51S4pUj0DrQ3I81+eztfktSvss
tjqtApf9DU5Hqt5+8Vo4e2Ctb+z07IdY10B7wEqzeNk39H5jKkXJ3jBduWM/j3hx
q4gqMYn40U97quV3StwfwCnTUBiPv+5k++i+Y7l/psdcdTiy/bneOC0f1CYr3Bct
n6B1yBJUEac6p8IYXFK9jUPNsWZurcTxgHHlYUXaH6hLCVZwCt/WpY22k7696k/S
atA6uBsZcwKBkZag2GvZfuJ9r8sCEPli4XQcpBV9mxndrw6GLU8gBPjeyiY+c8hi
QfGJzuxfPGiRcvOyY1oaTsj7czwAMhaDvuHA+vLVny5Ou0jLoUQ3Gf2PNzhWsQ8l
PO4QYzeWIXq/5QapRh1nC174z7cmt7vXYEqyqZYImRzf5pPsit9KjllEcStqNYQB
zJ2nl71eYKV9V0u/Z89p2RLQiBCxnSFgjZeSznXt3yXrRe1Z4KqXAwEbO0qd3uJR
5fL9dXbnea1AaNpsJNyum/dwyNviqHTiP8FnAEToVPuZeEyGq6FQ5gsdeVGnHziw
cITZAnzn56AHJPZnEA/j
=bGED
-----END PGP SIGNATURE-----

--nextPart1932087.Ezlip7FE2n--
