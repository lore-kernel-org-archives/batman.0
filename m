Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2012 18:33:23 +0200
Message-ID: <1985661.v65lBQFsqO@sven-desktop.home.narfation.org>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAJ8P9S1hURlDutIgnj5PzCIBAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<9663458.DgTmOPncVH@bentobox>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAJ8P9S1hURlDutIgnj5PzCIBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1494325.FK2zg8CtbV";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] bridging problem
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
To: Walter Robert Ditzler <ditwal001@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1494325.FK2zg8CtbV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 06 June 2012 18:13:57 Walter Robert Ditzler wrote:
> hi sven,
> 
> just not to mix many things my procedure bellow. i could change the mac of
> my mesh0
> but i saw that there is a problem to bring up wlan0!

The problem is that you have to change the mac of mesh0 before bringing up 
wlan0. Actually you should change it directly after creating it and before 
doing anything else. So somewhere between `iw phy phy0 interface add mesh0 
type adhoc` and `ifconfig mesh0 mtu 1528`

Kind regards,
	Sven
--nextPart1494325.FK2zg8CtbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPz4ZTAAoJEF2HCgfBJntGp8EP/1tiB3GgUk7FDPvHDvVWuySh
BNDVd5YDOhJNx2uSxuCG3Jk/KsHSBN3t+6Qo2BtXuPtRZHx2DH1Ei2A+NM2L79A+
5fACpcVmtIDhxg/sMM4BRcasYinLtx1YlgI0TJa9AicKx8bfPTeRCQYU6RSpMV7n
Rd0qcOsyXLpr/MDJXxKwomtL8xzHaHeOKMeKNGsglJhAH6zCOPlTbDFDRSPkvNdM
3j6BfMvO4OSSJar590O1DvYrhcpX2a1QZDpBSk98RL1U2wkM59VO2m7NiZ4BYrEk
1TKXPhgdPZHgruvz8/dIBfKt4zMN3TTwsDbjp01nDBrJR1p90XBSdYO5+jPSV6Lf
/Vso36m4iNUMmGJSlUg6x7eqrwnpDIab1lHXB9KwOcEAF6Ktz9QlLrSCp7JTebEr
L7SUBXXzQQxzZxNomkpH9LwEpsvmmCpV2RFpJiJJWTSFX8tvlEsIdwUmAIGzxjZL
CNtWQ77++MfqODeJvMn3VILCDB4Kxj8XhmgzzbL+Lvn+3+NaR2JQHamYDY0O17NR
yLsLy6h6ZGbHfjTk4lpBZ1fXe8lXFnWa5jJXwp9MsXflkQK75gEeZdZlZUj1ejVo
hknmwyjjgzpSRonbLe1wTEvpCRRpBva0gJW6hJLHnZ1FdFNF837GEvv6nfnHNb1l
fMvqWwdCvDYHMZ5iUcfC
=etX1
-----END PGP SIGNATURE-----

--nextPart1494325.FK2zg8CtbV--

