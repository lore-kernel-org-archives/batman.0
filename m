Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2012 15:08:38 +0200
Message-ID: <9663458.DgTmOPncVH@bentobox>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAFnqJHGU6SpApnvO3eJYq6ABAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<6725381.buXcpkeOMp@bentobox>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAFnqJHGU6SpApnvO3eJYq6ABAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4003708.PNgEq1qU3H";
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


--nextPart4003708.PNgEq1qU3H
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 06 June 2012 14:59:32 Walter Robert Ditzler wrote:
> sven,
> 
> root@srv-ldeb-basic1:/etc/hostapd# ifconfig wlan0 down hw ether
> 02:34:56:78:9a:bc up
> SIOCSIFFLAGS: Link number out of range
> root@srv-ldeb-basic1:/etc/hostapd#

Ok, this confuses me slightly can you just try to change the mesh0 hwaddr to 
wlan0 + 1?

Kind regards,
	Sven
--nextPart4003708.PNgEq1qU3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPz1ZWAAoJEF2HCgfBJntG2uYQAKRHeHAZo6351eIt2jrwG3fi
wXH626NP9FNzKG2tnZa4YgnxzMtFLYwKqz9Yhg92ag7jz3GN2hTSY4sVJKqqdR4I
vg/ev60ts8qTlXhqQbtVw7xsHu303XnVXjsBTS2f6f3vjjI+JGOS98cPfPpbQLyC
TeP6nrrG78xXMHMc3Z9t50sxRh2Gxz9vz73c1Yi7ELlg+cS9+ZfERVIzUlveUkQs
TRDogY5cbjj7x7tGgfE9oMLXWHkJTXDiOGAh6CBnKGCGxz1ZNGNascvf5FBV4Nbg
3tfP8w5+l5cfVmxUs6oKzTck0tW5PrtiCx4Xr0Cta49NbyQ5J2GqwwDibClBFSgA
UqXqu97av198ZfLeAvwN6WxFJjuAPtT75K5Oj69B9DBzk3QUFOSb2EE3SKEHyhTA
a489FeOfJ03JsW9hzT9f/psidOjPJnXXSP5sz2gRhAIe90mzP1TCNDIwR1MWfPtY
RDmj7rSDqXkgwNYeXy9VqhA5UJZiR+srGfIpviJ1CXEvsxAXye6y0cMaCAf2OGxb
eVJr0pR0cDH5/Nyv6KGuKwDAt5Tctx6LM5DTPn/vYwmf4tDTVgSjgw3gHP0wlOBn
Aw8+MwtqT57/xMYYCcPzcAJkkco63Jch7IDww8sKUb/NXSy4XcWmhxf95pefWXKi
Og+EDdpDBtBZVH8jLrJ3
=zVHH
-----END PGP SIGNATURE-----

--nextPart4003708.PNgEq1qU3H--

