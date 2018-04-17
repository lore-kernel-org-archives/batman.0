Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Apr 2018 10:35:15 +0200
Message-ID: <6026006.aG0Bno4Z56@bentobox>
In-Reply-To: <20180413181618.24144-1-sven@narfation.org>
References: <20180413181618.24144-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1714779.KUJ6TP1Sej";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
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
Cc: Andre Kasper <Andre.Kasper@gmx.de>

--nextPart1714779.KUJ6TP1Sej
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 13. April 2018 20:16:18 CEST Sven Eckelmann wrote:
> The IP translation layer is using the neighbor table of the kernel to get
> the unicast link layer (mac) address for IP(v4|v6) addresses. The kernel
> can not only return unicast mac addresses to such an RTM_GETNEIGH request
> but also zero mac address. Such an address must be considered invalid
> because the global translation table may not only contain a unique client
> mac address entry for it. The translation from client mac to originator
> will therefore most likely return an unexpected originator.
> 
> Dropping these kind of (bogus) results avoids confusions while using things
> like batctl's ping or traceroute.
> 
> Reported-by: Andre Kasper <Andre.Kasper@gmx.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Andre Kasper <Andre.Kasper@gmx.de>
> 
> See https://www.open-mesh.org/issues/353

Applied in 9f22e3d0ed2a [1]. But the ticket is not marked as resolved but it 
seems like the reporter wants a different behavior.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/9f22e3d0ed2a3d83479f3db3b570f49218024249
--nextPart1714779.KUJ6TP1Sej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrVscMACgkQXYcKB8Em
e0bLyw/+M/fP4wQjKxl79zpovuDQ7XFMJ3xdQ9tdJtRXy8fwH9/bBvv8gBRPwhQC
nxp7Xhmu+NTB7S1Ak+xLIeUtb36dRlpTqjh0xYaLMUoMk+0w8AyLmvVe2jyKkUyk
vebe1UlEHBlAoSUD5AqcyGg4ikuLLuvLUp1kGcqU9KDiu1J99Os/XgDDzGtNslhB
gsrSKNvXG9wUzeForeZOM9Jd5ovbn1wYtyT2zIMPlpdSe9fLBpgfHoB0UMOt6702
az8vc7AH35mRBxrnoX9501Ttlvr44GJap7AQW/fP0Ef4yITfGaXOc9UbWVkpoAN2
4SGFn5APAvuEqXbvzfNlWsa4/1mPp6uo3Mt5/YT/L2A3PxJDcKoya0bFgAaPamTq
98UOu6PFmpzRkjkh8KArvAHJQD6AMzX2ceykN96RWyHJYtxI7d63+FbFHjQ1/k1V
vgNh1FHLEHWNwMej4Bxa1yXyFyQtyY005EUy3R4KAypc+bvpXQ+u1yS/lPJIZo44
P3cEugEP+S6N4DpYoblsbNGc1DGtLrOSueH7GYwoDG/4y9rToz1jNsW+iiL5sVtD
mmV0ZNHfDMjuFHb3hpcOPImBvckLg8dyHxUvx6Hi7YkMMBxzYhsHPsu7ifM9hF/m
6L5BUhxHbzspEw7zYlDrJGmCukufy8svueKajlxvTdS9U7axVRE=
=D82s
-----END PGP SIGNATURE-----

--nextPart1714779.KUJ6TP1Sej--

