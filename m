Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Oct 2017 17:27:27 +0200
Message-ID: <2821399.ddzZuDRYWf@prime>
In-Reply-To: <20171009153307.29245-1-sven@narfation.org>
References: <20171009153307.29245-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5507732.D2lX3cQiHf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Only query debugfs when
 netlink failed
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

--nextPart5507732.D2lX3cQiHf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, October 9, 2017 5:33:06 PM CEST Sven Eckelmann wrote:
> It is enough to just request the data from netlink and skip debugfs when
> netlink didn't return an error. The overwrite of the ret variable was only
> for testing purposes and should no longer be used.
> 
> Fixes: a7bc3d9a2b3f ("alfred: Cache the global translation table entries")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

I've applied this series (b5e24fc, 6084780).

Thank you!
     Simon
--nextPart5507732.D2lX3cQiHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlnuCl8ACgkQoSvjmEKS
nqFIzRAAsMz0OYrM4JOb8xhCCkslanpuKF50YPTeAR9r81f59tKhGOpPAIFk2eRa
J6m9Yo447/eYo1fjS3fxVBj6P86CfBOjDL9l+NisO3R+B5Fyniyc5+DuF1DvULbd
WqrGBn4RK+GxovOzDGGtobOz8R2Gb4ssMHH+I4871//a31Z7xORGIG5+OG46x4xH
r3HV5paKrizCcWeSIWzTJ7amE6ekd0J5nmwwXBMNtnPgsHFtkDd8Mp+iXa1Q+IaW
dW+9xP3fPDjrUd81MlXs4l+6sGBpyV/M7UmhMjYLaDrLkcO6pYahcCFRheG4H+1S
CxSVHtm14zWAe8FC77/kQpvL0ZgRd3+WRUssegXiU/unxE7zlFUj++NtjMVclUMB
+RCOE/x3LP9PoRxVVvaS17JBUwYD3zAS0xqEIYIbWlOkx2G6/Fby+zfYaHMI0ImM
Sg/VXjb+BGapVqX2B7w1ep/mNYVD1eS7/zt/LFtTGGIsjJiHCypO4paZRhPB1Pup
cuujqvcqVgepJTUBefFkYSDaJlZA4VmpocKIzC8skveDkyPhuOgbllE9A0SKzfJT
FOGEAVNvz6Z9NyliKCYPgcbMsrzMowZaZ1LolFdrkqn6YvM76m6LyD/ObMxhTrb/
sqlD+Ga70Zo+aX+kV6dyWSIt8g4cTFjwwZk+Ptb/IiZu1uObcw0=
=zfLS
-----END PGP SIGNATURE-----

--nextPart5507732.D2lX3cQiHf--

