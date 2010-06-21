Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 21 Jun 2010 11:04:53 +0200
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
	<1276908713-28365-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276908713-28365-7-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2320577.LQtM4tdsO6";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006211104.54197.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/8] Staging: batman-adv: Add bonding
	functionality
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
To: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, b.a.t.m.a.n@lists.open-mesh.net
Cc: Greg KH <greg@kroah.com>

--nextPart2320577.LQtM4tdsO6
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>=20
[...]
> Bonding is deactivated by default, and can be activated by
>=20
> echo 1 > /sys/class/net/bat0/mesh/bonding
>=20
> for each individual node.
>=20
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> [sven.eckelmann@gmx.de: Rework on top of current version]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---

I noticed that the bonding file in sysfs is not documented while working on
batctl yesterday. Can you please provide a short text for
 http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dblob;f=
=3Ddrivers/staging/batman-adv/sysfs-class-net-mesh

It would be nice to have that on Friday because I wanted to submit some
remaining patches for 2.6.36 on that date.

thanks,
	Sven

--nextPart2320577.LQtM4tdsO6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMHys1AAoJEF2HCgfBJntGzocQAJel85ikpwj83rc+c7zfX0P8
Ehk2V9uTbd0Zdvjv3pwyeeIEYZOIZk86gXfdnG0d2OFxUBInsEcUNakc0BzwMs5E
JxZKdgYI7j7xU7nQw4hnmcJK+VYTiL/80bsBpRnZEaom5I2SsnTprPwab/PLqwws
r3Yoz7t8lsetBzXEY82tNTqkoLsi1axCaNAgTBYoh4Y5n1duYxPh1Wk3vJ0nXWKX
Idow31pIa1UNRYcdNaa063CWe/FGaIZviTvSFblDZXobMe/qzmdwAXKWl1hfKEbN
jET8GVonP4DLzYOb0HIG8MomgkXPB/8VQls6M0Te0PVLzxFBc23nqqtLlfjaoREB
/VEJQsBbjm5ZzRLfG2X796LYzyAe5srN6aidxA7Buzby8Gkv9xgyEK7YVHULq8Z1
DS5SsxHuhwDbcRbiVyVwWxq/bKxgHx1a0QCzjVwUsxPkWO3xm60Rz4q/rqu3fnoC
Ge/X6j9CQBwtDv/5aC12D0Zm5wcaODmU3Um/05nht+Zz7+Ql1O1PV8IlSaQ897rB
8Weo1bvvECZS5D92vATnppkzvYGi1J4Zo9bvs79zXgIVSenw2/NLihbg7RJk7/mu
HwHT8xA7/w2xAQVY62ePYg1N7THE2BneLdq73TKNV1xL8w0N5m88F+MYYIvdWJM2
wWrnyVtUWRDh/jD3jLqx
=eZVL
-----END PGP SIGNATURE-----

--nextPart2320577.LQtM4tdsO6--
