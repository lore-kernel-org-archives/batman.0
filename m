Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 3 Apr 2010 11:54:13 +0200
References: <4BB70C4B.5000909@nord-west.org>
In-Reply-To: <4BB70C4B.5000909@nord-west.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3685249.gx6mA4Z4OY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004031154.19191.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] running batman-adv in a openvz VE
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

--nextPart3685249.gx6mA4Z4OY
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Saturday 03 April 2010 11:37:15 Bjoern Franke wrote:
> is there any possibility to run batman-adv in a openvz VE?

I have never used openvz, but adjusted some protocols to deal with openvz=20
aware kernels (which means that they used and checked their namespace - so=
=20
nothing really fancy).

What must be done for device drivers to make them work on OpenVZ? Have you=
=20
tried it and where have found you problems?

> Must it run
> as kernel module or is there any way to run it in userspace?

There was a proof-of-concept version of batman-adv running in userland. Thi=
s=20
work was abandoned in favor of the in kernel implementation (better=20
integration/better latency/less overhead/.... - stuff which is even worse o=
n=20
embedded systems - see Linus comments on the tinc vpn throughput on DIR300).

Best regards,
	Sven

--nextPart3685249.gx6mA4Z4OY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLtxBIAAoJEF2HCgfBJntGqoMP/jdTGW2yGTwOfqOO72d17E+b
1N4AKtm4LG3An85oXMYAZR2eR9xVpO2kscTGhBzsNsluIp++P5RnwareguPyQcpb
Vit6pKBjdUWIKycNjG3+nCCjtMwoSgRD5e/Kv7IEXu9i93hvf6t/tmw3TsK5Z0n2
lM4HfBTQS2WNQL+/d7m+V86I+HdTvBCZygbB1x6qIzntyPyxpSmt7QDDfc129gJp
PJNKLwFKgqNpO9fPNqzJdSORxZOsVDjE9SzuMbnD0JAcPMRwSIfcJD0iW5Qad3Yl
y6AJRKcUaz76v9An5PS9PReYEGpIaXLHSd+OoNdb42XH1YLzw4pGywbliOXKhHDd
z6129GCOwf+lcybLCuQgzgHuge+UCggmZINle/XFaa95HU5IOeElvwRuxTFjx6BU
7magR+NIf7Sxk9Jvht+5Bw3o3F7rjq2+wmKfY2bFHPfGMp3an+9MY5Yhf+5eb46M
/fx893PQ/fAXZcuyla9mUlbmnWaQ4Uy6eoAphgPso+vtv8r0aC/SOt4S67rRZo+G
eDaMLDfX39Qdg7mD6hhVpe9SoTm9J6GJSiF6UvB363ZiJsJEF4QLn/kO/XhXF38n
T6nBCL0Bzy83KJY8xX5+Ellcn0G6olcEWZIVeJkVzygUsQHT2CYGh1WRNoOsAk7V
I/sQy9mWbwBvaCDuPjhc
=9gsU
-----END PGP SIGNATURE-----

--nextPart3685249.gx6mA4Z4OY--
