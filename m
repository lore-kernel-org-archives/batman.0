Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Nov 2012 16:39:04 +0100
Message-ID: <1940735.62JGhZVJKt@sven-laptop.home.narfation.org>
In-Reply-To: <CAJZtC_=Hjdiu=ZR3EiFuUaPCFu_BoDv9X=frQLqGg9hrSx7kQw@mail.gmail.com>
References: <CAJZtC_=Hjdiu=ZR3EiFuUaPCFu_BoDv9X=frQLqGg9hrSx7kQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2166979.4P3TD7XND8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Broadcasting of GPS-coordinates?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart2166979.4P3TD7XND8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Sunday 04 November 2012 16:32:00 Rene Bartsch wrote:
> Does B.A.T.M.A.N support some kind of broadcasting node positions?
> 
> The idea is to broadcast TX-Power/RX-Gain and the position of a node
> determined by a GPS-device to create maps with network coverage.

No, batman-adv and batmand don't support this kind of semantic data exchange. 
But the new daemon alfred is (will be?) flexibible enough to do these kind of 
things together with batman-adv. Maybe you can ask Simon and help him to 
create alfred.

Kind regards,
	Sven
--nextPart2166979.4P3TD7XND8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQlowYAAoJEF2HCgfBJntG3zEQALjbHMIPL4xNssZl2psH1sF0
PxMeBn5UMRJFXBQtCzn7uPhCcwbjomw3TjoVPm14Kmf4+xeOTDrTBB5h1ABoJhQz
gUf/sTEwI9QIo7zBo6XZuIKQcU9D/CiG3wpeQYVhFYaCgvkF1uKmJi64z0EXVk8/
3ywNXk2HOS5e/TANCQ7QLqC6zsKaCWLSsuW0QRNT71bxS3HybzcNe0Jqx/pK5Lat
drTpve1fabr7csZH3fEEEllKmKF77lfhJJMywBU6Ztnm91KVyxyXWMo43uWWYmqs
GO/C9Qvx7NH51mZMyvcxp9nd6fGv5dCjs9ksaAGieJdbjZW3M5Qry0ny+Rv5rOR+
Dgi0RXSPM8EXsSac7E+lniAFlHIq0ktvyKDJy6wW9K1H8rWPo3GC68bLpNEGFoqX
ygubpus8u+bisLA6Dx+gquIsQ7ktVXY3d7j3EobkTi4Wwh+i6Qsls3doyJjzzogh
vpA9dC3ppj+5i6JdF5h4JBwL7lBpB18F45rxyGLxoAbiKHJDDkh7R+hJDcbpcX2S
o5bBjWjJtz6veHOIJldQ8TRx+U0ch16HWxu0Yr+5ckyiK3SMtQXX2E2vpKi7nvSu
gVAjggMxpay8mDLwcRk5gLmsGPItWRwxNoeY6jyaeZRJRWTromzcflaeo6eiJF+U
Mc5GAdWbesJTwqgro7V+
=Yrf2
-----END PGP SIGNATURE-----

--nextPart2166979.4P3TD7XND8--

