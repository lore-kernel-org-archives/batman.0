Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 18 Sep 2009 10:19:07 +0200
References: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3>
	<4AB28C2D.7060600@tiwoc.de>
	<B32C944A35244A19A20707D36198AFEE@youillmlpt3>
In-Reply-To: <B32C944A35244A19A20707D36198AFEE@youillmlpt3>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2875118.Zlu2bgru6Q";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200909181019.11099.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] IP from MAC
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart2875118.Zlu2bgru6Q
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Batman-adv does indeed seem like the way forward. So, on top of batman-ad=
v,
> what solutions are there for IP address distribution? What might you try =
in
> a situation where there is no obvious central coordinator to put a DHCP
> server on?
Just do a quick search for "ip autoconfiguration"/"address=20
autoconfiguration"[1,2] and you will find different solutions like=20
zeroconf[3]/APIPA[4]. These are of course only link-local/point-to-point=20
solutions.

Best regards,
	Sven

[1] http://tools.ietf.org/html/rfc3927
[2] http://tools.ietf.org/html/rfc4862
[3] http://www.zeroconf.org/
[4] http://msdn.microsoft.com/en-us/library/aa505918.aspx

--nextPart2875118.Zlu2bgru6Q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJKs0J8AAoJEF2HCgfBJntGRC4P/2BRIbUX0ypvCECD642cEBjK
8EofWSiCijH483TXkDxyIVbLRzYDMaZfJ0gL7s8YR88rxKuv176hAncIJnYNse4k
VESyZYwQG4wbm7Te7yhq2mT3M0H6y4JY2lqIfvcxFZ9sRE1FOp7j2mGK8H0mxQ1p
TcRCL9E8a4pJWJHk0uACGQxUPrJi9dPRcnt0ZT9ianH1T+KGNWy70ZJAYhbVhZu0
IKkkiTtFCmLbXVc+ZFiusCJ+aWGHe6MxsMjC4gDniEWKAXuSAPyHCWJCazyHUhIO
ozbGUoctlsiSYivitwP12UmHxtuBBAxelPm1wPelNQoYpz0BMyAN2hQioHffxyBR
K/PdyyEM432U4ft9741hFUlqOoaYuPHJuUEon9ca7gP9Phh/YjPaKidVSMyOrHZ5
WqYo7i7EGCa5VVIazTMA1SLxAaBeJA9CX0ST2t2FZQjtGSIlcfpqFeoPsF/V9f7o
Ac6yQCzb1dsIQgBFmCb00lVUBuBYHY3D6GiAW8N8lGhnkRrQzXFeCB6c/Dg8nxA4
VEuKTf1EmPbMh7E+Y7Pgj/KbWVyOhbNgy06kG0xTn73ljrNNN6x7kFUtJlUyg/oX
lPN1rCFrCdqApV2sJyAUF3BTX/YMr4tareD8BP6lCPQ7UiW4klwlZBbPOkkz5ils
ItwmaKjFk5oNrN33FoXj
=ynE2
-----END PGP SIGNATURE-----

--nextPart2875118.Zlu2bgru6Q--
