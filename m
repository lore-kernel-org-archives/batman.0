Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2015 18:46:05 +0200
Message-ID: <1896633.nVVJZKsOqy@sven-edge>
In-Reply-To: <94F9A17D-72A5-473F-8FF0-1C843724BB6A@heidler.eu>
References: <56113660.8080506@heidler.eu> <4946773.CRg2Vnx3gp@sven-edge>
 <94F9A17D-72A5-473F-8FF0-1C843724BB6A@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2160061.di87K49FVS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred update-command
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Dominik Heidler <dominik@heidler.eu>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2160061.di87K49FVS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 October 2015 18:30:48 Dominik Heidler wrote:
> Is the hook executed as well when the data is pushed from another master
> node?

Master-2-Master syncs also go through the function finish_alfred_push_data 
when the sync was completed successfully. So this hook should also be called 
in Anatoliy's implementation. It is basically the idea behind it.

Kind regards,
	Sven
--nextPart2160061.di87K49FVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWEVfNAAoJEF2HCgfBJntGzMQP/A8iXZ7m4afnh5n6XH4YdJKW
mavbBUs3CQqTvorO8njGzA4e1OXm0ZRlS9MBHMygwoIlr4VG0yGkcgcdqPNOpsql
Sz7IW0d+yXFMlpsD74mVOjqzs/sf9MSxkaqUa/d7kqSX9BH7kLIOuNwh5mcksNm4
oiBPT3d2NYb6GqFADp9f2fa/pCfgmyO6Gj02vO+VSwLkdMoK6m83kssmXNOGfoJH
+uDz5aZQpAAbOmI1Elur9VfWxuMeu4YkPrKfxm7q+psk39cCeosMCQ4bzhZaInr0
Msae+Xf+xjpbpjibAysbevjJCGlj17Wefg48MDcUX4EVNiRcXoCVu1xMKpjdQ85b
9q1W7dV/bu0PMFsf/U9J1r9AZnQOc+unT1TNBQj+IbIzK666AMCV9gN02KP2BJD3
wD1TK5uS9xNd7wCyF2VhoCDLE9RmXROcOqFhPJ2SJ/bmTakM/D9iMzuguB1TIInJ
PpBQTBIQ6FEjKXSv16R5AQ5o6g7Q/uLWWU0Bb6axd3rghLh38dnQLDBJVDnQkJx9
E8jcTX31djVeHszXu4B0bFDF4clPjNAf/W64G/JGAhBDRkaLEBAKmgQD5y5lv/Iw
O+QYt38vjqxwS3Bk4xDeoU5J615CPMwBjR2z6EbFZmnYyUiDE2/ESY2SP6MnJi+2
WcDGHNVWPTzJJKpPeyom
=L73t
-----END PGP SIGNATURE-----

--nextPart2160061.di87K49FVS--

