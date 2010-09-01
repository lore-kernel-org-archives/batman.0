Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 1 Sep 2010 12:48:11 +0200
References: <4C6437BF.9080909@web.de>
	<201008311132.17198.sven.eckelmann@gmx.de>
	<4C7E22B2.1000707@bb.banban.jp>
In-Reply-To: <4C7E22B2.1000707@bb.banban.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1482901.oN1Mt8ZASg";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009011248.12227.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
	in my case
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

--nextPart1482901.oN1Mt8ZASg
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kazuki Shimada wrote:
>   Hi, Sven.
>=20
> >> P.S.
> >> When activating network interfaces under bat0, What about forcing their
> >> mtu value to 1527?
> >=20
> > Why?
>=20
> Because batman-adv says
> "The MTU of interface wlan0 is too small 1500 to handle the transport of
> batman-adv packets. Packets going over this interface will be fragmented
> on layer2 which could impact the performance. Setting the MTU to 1527
> would solve the problem."
>=20
> I thought batman-adv need 1527 as mtu value.
> OK, I've understood.

You don't need it for unicast packets, but it is highly recommended due to=
=20
performance penalties. Do you think that we should change that warning to m=
ake=20
it more clear? Is there anything special which we should add/change?

Thanks,
	Sven

--nextPart1482901.oN1Mt8ZASg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMfi9rAAoJEF2HCgfBJntGDeYP/209EKfaeB5zyQynzrGYG/Sf
I8qH3I1lg13WyQEmHi42wyMa1lZWzBHkAsHiTdHn/PagXcCT81Xmn+5TnJlH49rK
ulMFq5ML5Mc/5lnwaPwq+FtKoce1ovP1imnRl1Oe1ILCBFMQpfKb78f3e5pJn8MO
GyEbQWpVR+jgl++6XtOrHTsQngU7xGwQn6ueLNhPt4Kb1LeyPVO8S8Sw7IIk1RQL
SSBU4bD0HiewkreZKTRawMXWBt+Sr3DQ5krC18AajHp+9EVncsy7oXuPNNJflZp1
LJ8FZORC+m7KiasE9U+BAI4vkd43ySgJrWIiGAOhYA7c5/hsinZFh/UHLDn7mzki
vYVjfjwVCiWHzoUP3rd2esCvBA8jRWVUHfaUTCVfWXxHJpJWbG1PPn5XfoCq7XB/
bKG/F9RTYe08NHsGrr04kaW2wlVcaVZTpSHqKdJNPQ784kDq36r/QoNm54Y3yfQr
oW4okpEDIKF6XXEzO60u/HL1gGT4DRNA0gZlXP1aggCYN678sG00pj9lCkRCmQho
9DBL5qXDvg51Zz6GFhWrsUj3fCd2/L90FESvZA3cd9zsb+fxCLLunjK+GTzfJwu4
CxDhfvMowS+S7GX71AJ/f17ODDmdPDSMXY4b/c5nBzzAF3ObG5GEZtLDdOlShtXB
PH8YItSaXqVcONRdfHww
=zvXv
-----END PGP SIGNATURE-----

--nextPart1482901.oN1Mt8ZASg--
