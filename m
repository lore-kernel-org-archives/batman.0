Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 18:55:53 +0200
Message-ID: <1605649.xVWE7yazKe@sven-edge>
In-Reply-To: <572E1D1C.7010505@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <1916326.J0HcRb74sF@sven-edge>
 <572E1D1C.7010505@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1970437.JCVX5PpjF0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: contact <contact@wifibot.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1970437.JCVX5PpjF0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 May 2016 18:51:40 contact wrote:
> yes it is in the routing feed I did not change anything from the openwrt
> files.
> 
> Ok, so you suggest to use the devel feed with thye last commit ?

No, not yet. Maybe you could update openwrt-routing and run:

   make package/batman-adv/clean
   make

to rebuild the the image with a new batman-adv version. You should also check 
that you are using the right openwrt-routing version:

    git -C feeds/routing log

Should be a3cd8a1729779b8a39336a863ba7f97481e81f5c for 15.05 and 
8dec3dc38b514ed8f1212b51f9f6039af3fb0e04 for trunk (at the moment).

Kind regards,
	Sven
--nextPart1970437.JCVX5PpjF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLh4ZAAoJEF2HCgfBJntGQcUP/RttG7I/wkF45uSXcjR8CRa5
izb/zBF8nnHBKjocrH6648eU/2AfSHpmqKKiACdV1BWNe94Rl3tkRSYx6uBWq21k
loqeF9/QFhc/MVs8o4IMfEja6Atgi2qd8zTiBxB56QSKzSkpBe3dx6xoFBZPkhHL
vrQ6+0EdhkSn0EsgjVvWKpJBxKNFi2RSmBSnuAakus/chIKzWm7tQ2+L8Wf18U7E
7d2eJwdzyAm7rVTuLwDUxJn/wIqsguW09UaZvRdgVWYkfrNFiLsmYTzq89ae8I5Q
jNnUhaqnGRaP4tgm04ZD2uP7+PhHks6dP9+AMmK3bHUyxBg1B/t+efrMLBSqz5t0
NGGCt81wyXJJ4cmDUqlfMKS45H6UawWYQkZ0Q5L0a4UfUaWfwaWGdcFAiWH0uzFg
Ir2wEuZnv1Ji10YLnTrOBJV/nEy2v1wkemJNEx1pooCkI2CSpN35P8Q05AfTwybb
Hl7yXAtF8vAAWMd+UnfRUxdF3bxqooVwUVU6WTYGunGK0K4r2ZrldzNj/nEOO5B7
UJ3t+XRVTx5yJdJ6Sf7/j2vrY00ReHmDmKsgtMPybp2BtfCR4lBkAB5Krpo1MQ5w
Twg5EfjKSa5myZkrERQa5e/D5lEpzrm7EkWU71P3lPLghZ+GLGEPfzYZXy0hcawX
sfnSPPVWNjOdmypnrI4x
=DZl2
-----END PGP SIGNATURE-----

--nextPart1970437.JCVX5PpjF0--

