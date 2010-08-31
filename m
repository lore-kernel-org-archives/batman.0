Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 31 Aug 2010 11:32:16 +0200
References: <4C6437BF.9080909@web.de>
	<201008271159.28345.sven.eckelmann@gmx.de>
	<4C7CA94A.7020103@bb.banban.jp>
In-Reply-To: <4C7CA94A.7020103@bb.banban.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7973746.uJPnDA6cDf";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008311132.17198.sven.eckelmann@gmx.de>
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

--nextPart7973746.uJPnDA6cDf
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kazuki Shimada wrote:
> P.S.
> When activating network interfaces under bat0, What about forcing their
> mtu value to 1527?

Why? Everybody should be able to use it in a environment where he can decid=
e=20
how the mtu looks like. If he thinks that the mtu should be 1337 or 2342 th=
en=20
it is fine for us. He can even (he should not, but he can) use that mtu in =
a=20
environment where the mtu of the underlying hardware is only 1300 (for exam=
ple=20
a switch or other hardware only allows that) - thanks goes to Andreas'=20
fragmentation patch for that. There are some restrictions, but as said on=20
different posts: get your mtus right and everything will be fine. :)

So we do it the net/bridge/ way and just accept every mtu and use the minim=
al=20
mtu of all devices (that's why some patches from me were rejected). It woul=
d=20
also be a little bit confusing if a interface used by batman-adv would be=20
change its mtu and silently dropped - or more evil when we try to change th=
e=20
mtu of the used device and the underlying hardware would not support that m=
tu=20
and everything would start to break.

Best regards,
	Sven

--nextPart7973746.uJPnDA6cDf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMfMwgAAoJEF2HCgfBJntGMkIQAJExDbUMA0vattxWB/YnlGx2
oSLvFw5jmhjtBxIbikR4KZWAeqG6M7C0eGXibmlLcYWnM5NLatuqq3/2yYT0VD/e
radLK0IWtDoPypNWtagGXp7DPQPME2ZueBwbaEHEX1/EvQ2CSbswhVq5EHPRlweL
cG7oJRxitdUw7bs3RLr8i5XP4sdSMHwyvuxn6Unm0gmkrEIClbY7VS5vPVNp1uTr
IUo7qufOv+cuXOBH6C1BKGci2J26UiilF0bQBnfx+WtC+W/AfCjIWjnhqUlbokYJ
h5pQgdqosIFahwYFKvoIAJwkRI/FB6MdyCosEOSS+onUZigWMsqtnsDMyqLf2zMd
u74L2iHsHK4INMZPFoguBJNrNO1/KSbWfnRNlrFYiLQCjklTahYIydrohjm/FjFs
Yf7RdCzYU9dw8QWcVUVZiI/2sJrjBq4WQ1X2It9YpkNqSdKOwR9gVZ6sAKliJtmR
SyS8COCQQ93Wy26GAhfkFwFRjjjr1GCDQ7dHRvIwMxWsNmn7+TkB9hVP/5qy8tbC
8bYa7Cg7ZCWiduFYFOiDDovCp58926wwUNvAOCIzdpfpQyMCguCMxtnkNU39wujL
QTqi40BBUaWCH80G/RLL6g9uZKQXEgGlUT3WgkpuzMc6nNiUCNHGDMLg3K/VNHY+
BGwXSNvP5Det9Ozgr8PK
=z4Z1
-----END PGP SIGNATURE-----

--nextPart7973746.uJPnDA6cDf--
