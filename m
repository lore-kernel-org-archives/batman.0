Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 23:04:31 +0200
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906222224.43917.sven.eckelmann@gmx.de>
	<5161afcd0906221347p4125aac4kb8efed0bc1cfd01@mail.gmail.com>
In-Reply-To: <5161afcd0906221347p4125aac4kb8efed0bc1cfd01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1535419.x42U0FiKk3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906222304.32150.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
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
To: Jacob Marble <jacobmarble@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1535419.x42U0FiKk3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 June 2009 22:47:30 Jacob Marble wrote:
> Yes.  However, I can't set the MTU any higher than 1476 on the bat0
> interface:
>
> root@OpenWrt:~# ifconfig bat0 mtu 1500
> ifconfig: SIOCSIFMTU: Invalid argument
> root@OpenWrt:~# ifconfig bat0 mtu 1477
> ifconfig: SIOCSIFMTU: Invalid argument
> root@OpenWrt:~# ifconfig bat0 mtu 1476
> root@OpenWrt:~#
Have you set the mtu of all included interfaces in the bat0 interface to mt=
u=20
1500 before? I mean all interfaces in /proc/net/batman-adv/interfaces

Regards,
Sven

--nextPart1535419.x42U0FiKk3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKP/HfAAoJEF2HCgfBJntGXbYP/3tnldZi7l4WEuQ3yrCmL6UA
W4ppRNGsyaCID4eF02+bjh44LhJ1LsyVcrCC+W66vk5BfTpPjpcgOVnB4CWH01ve
IujPrCSGOmFOPuK8DNQ+DffXrlSnOnfMIO9ua42SxanmIyDBwyJnkTSy66e8WeCY
Ci5w0X/1e1bG5YDYu9eKfF+kdXjQRj5aNOAwU81G1olOfVNBDOZeWWl/EkPjbOSj
oTrN01xT1x4Ca9D4MMAZgxv1Gt7qtB3ABLon9YXfU6F2xJvXDtR3bU7sPlyP5IYp
1yJznUoywlrbLqVaZNyd0s8n3PM0uHBpNvxgvKgoPyMFXKhxoU5BT5gb+OBwqIVl
J8Z+W+Mqewfz/vlujzLY0BQzpQGJ6kVI7Eig8ZXeekK04diVzU/qaDKt2voVe5xO
DO6TIqfCQoaAuNxE8M4RxvCPOzqJc7kTBy5c0PGjBQngv4GzJ/LXM9WetHcUHX4A
HOcO6zkXSx+eunMgr/d+knXTJ08Ntwa6ydKHNdi93A7FpfFDxFuDolLvnsOk/bnf
W7poiBUeqxKVNOb5UmDmcjX7jTqBvRAJbN31+Srcn6qPfeY2Ix2HkMyJ84HgSm4b
cwOUQjKrsX/DOB8yo1M7Sn4T/Cbi4jtHfDgq7vJfC7kHkbYCDRaU0ImCeMe7nLSE
7pQnorXF5CMAKEdWiHrT
=IBgU
-----END PGP SIGNATURE-----

--nextPart1535419.x42U0FiKk3--
