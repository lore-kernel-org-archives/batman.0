Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 20 Aug 2010 11:00:36 +0200
References: <4C6437BF.9080909@web.de>
	<201008130524.24059.sven.eckelmann@gmx.de>
	<4C6E2EF6.6000407@bb.banban.jp>
In-Reply-To: <4C6E2EF6.6000407@bb.banban.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3290333.zGtmHeYclj";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008201100.41993.sven.eckelmann@gmx.de>
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

--nextPart3290333.zGtmHeYclj
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Friday 20 August 2010 09:29:58 Lemonde wrote:
>   Hi, batman community members.
>=20
> I also met problem similar to Tim's case.
> My environment is,
> board: gateworks avila gw2348-4
> wlan module: wistron dcma-82(ar5414)
> firmware: openwrt trunk r22692
> wlan driver: ath5k
> batman version: batman-adv-devel (refered to
> http://www.open-mesh.org/wiki/building-batman-adv-with-openwrt) (for
> trial of multi interface altering)
>=20
> I built firmware image with symbol table option. Is it helpful?


Please apply
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-August/003236.html +
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-August/003242.html =
and=20
try again.

Best regards,
	Sven

--nextPart3290333.zGtmHeYclj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMbkQ0AAoJEF2HCgfBJntGC00QAJ6YOF0Dsx0Px55WP7P9pNrn
LloGd2SnxMqeLjMeeXGNXGd9Q2TwOF+P1dkfaOn5P+I3TcWyix49BSEA23+oSLK5
/ZA72YSQ5jjVgc/idGQ/nQK5o+y8iaxgeivb7H9elipQBZrDUlXNmxwCJ/Jilz/h
YS/MemiZtQ+6m+XyjoBiPDMfN3n31jl4MseczGCnphscc7bfanquGCq4n8pgQ0g1
sH8QUHRDthDHKBO8TR6s/rBllV/prcqZeJywDtVEPZl4gYbnaVFC9Lfn5w4jdIff
Hmavc5tBzSI5P5tUWk3Svhl2RVhguccx7JWyZha+iCyOPmGU5Huwzpsi3eOBfeoQ
7eMl+npz5IzGr4p3m1UiQ/0b7Cg4TXC1dWUDttdc9o+m90UzV3lcr/Eku/Jiyf3Z
sSmfam7/qYKfUZGCB2mReQ5Ac/xIskCLeuXK2hm3ZooSCE0XuGlLs5b28IUbyCDJ
Dgz84fuu+soaqK2XT8xO05s4UgbHRJksr+mj2DzwiU9iC1+J4oqa8o751WSd0GP6
H2PuR7YvUdkoHWTqosT/RjHk2akAnYUvmp1x0TfgeB2Fh2FS9NsUlxtkahsM9M5f
sJYvLRv56BAl+zkI0gXBwYswfByWxMOo0Py/UTiijCUit03TcsFkRpbt1tlftfAs
rEnZlbfexToIXdouNBqa
=kbZl
-----END PGP SIGNATURE-----

--nextPart3290333.zGtmHeYclj--
