Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 10:19:54 +0200
References: <1284589835-26617-1-git-send-email-sven.eckelmann@gmx.de>
	<20100915234416.GB21479@lunn.ch>
In-Reply-To: <20100915234416.GB21479@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2546673.YjrJ7SAKL2";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009161019.55044.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-ad: automatically add .llseek fop
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

--nextPart2546673.YjrJ7SAKL2
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> On Thu, Sep 16, 2010 at 12:30:35AM +0200, Sven Eckelmann wrote:
[...]
> Would it not be better to wait for the final version which has the
> indentation fixed and probably no comment? If you commit this version
> now, won't you get a conflict later?

I don't decide what goes in and I don't have commit access to trunk. So thi=
s=20
is just what came in that day in linux-next and is currently part of it.

My opinion is to check what it does, create a clean version of it, test it=
=20
against 2.6.21-2.6.36, Cc: Arnd Bergmann <arnd@arndb.de> and submit it to G=
reg=20
later.

Best regards,
	Sven

--nextPart2546673.YjrJ7SAKL2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMkdMqAAoJEF2HCgfBJntGXo4P/34Gg/rInusaQyyh7OVkTVLq
5PbxJJZ7z0uqFKf6mGa7z3q0gpaYqNeWSWLUlegso7hyjY8wCwdPsdCAioCOdXZP
QeW6NU+/pWlWcZDGGiIxfq0jo0FaKVqpwJ1ezXGAmqVpy5e+l1wnkvGmjIuwCmJI
WSfoA7b+1ksAhSlbf0JTByXjB/rXlR/aChkOeLr48NPL5421/R7pUVhS8IvFdkU6
hIMYLT5C4ZXjrXKC4PA3i55R+P9RsCqSXYDKuK/KZsX5jLpahmRECRghb+yKNY8L
GuC42EYb2bs9ZAHOxrgy2OONkJoc05kKi3vPtahBFgGQ6UvbLavaQRr5gc6Ni2ky
5q59d977IWuYIU3L+3Ei8sbAXy3fVTbGJiOWw2XSvvtvs+Ngen0tgoFeUU0EtjZI
riZfbzjmIQCPxEqWPQGeRGWSm4L1jIh9oSESl+km/B71JPXQFLTU4yPWS1USv+eP
1rMQv+4QtvB0/4AA7KXKjW3TRDbIpzfltPOzfvaOw5FmV2MRp8Hp8e8Uo/AaeobR
jU58GbWRq7ffO+g9RlVf78AqQ408IpWJWmiOlwWsg1vbThCYZxT1VEiTsPQcn18N
5lohH2zpAgvU1oqHBJC8FIs3N9PUVvpqRQ/9DmuABA3KoSfstcWGPK2qCf6bWJ1q
/68/OjGJwco6W8pKH+ta
=mvkJ
-----END PGP SIGNATURE-----

--nextPart2546673.YjrJ7SAKL2--
