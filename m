Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 12 Aug 2010 11:50:31 +0200
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008121131.23425.lindner_marek@yahoo.de>
	<AANLkTim8cNH29kS=VM+m18OeexHaxwo19ug6Yu04Q6wx@mail.gmail.com>
In-Reply-To: <AANLkTim8cNH29kS=VM+m18OeexHaxwo19ug6Yu04Q6wx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3229696.79O0PMsP2s";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008121150.33820.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
Cc: David Beaumont <djb31st@gmail.com>

--nextPart3229696.79O0PMsP2s
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

David Beaumont wrote:
> The bat0 interface is currently bridged as follows
>=20
> On the router with internet going into the WAN port (ETH1), BAT0 is
> bridged with the LAN (ETH0)  Internet works correctly though the lan,
> so i would assume NAT routing to the WAN is setup correctly?

so you have eth0 and bat0(ath0) in a bridge br0 -> eth1 uses nat to transla=
te=20
packets for/from eth1?

> On the router on the other end of the mesh, BAT0 is bridged with the
> WAN port (ETH1) so that the router will route WAN traffic though BAT0?

What? Why a different internet gateway and why do you bridge the bat0(ath0)=
=20
interface with the wan interface instead of using nat here?

Maybe there is a misunderstanding somewhere... At least I am extremely=20
confused about your setup.

Best regards,
	Sven

--nextPart3229696.79O0PMsP2s
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMY8PoAAoJEF2HCgfBJntGdIAQAJynASZAkLmw8tG7nHQEQcAj
rTR1Lqf6AW6ZHJ6FZ3n7dVBnLmMb0AlGmIRsxkt/phV+iuoDwMJtae0FYvZLwT8D
5K3AHIrxRTBdXJjC0UNTNXXapR1KqCq20+6damb71bfnFxrrsHMLCwa7C0fpWbef
Ywt4xDugztzjZDw/HzcKIAySGfV5ik6synh7kKg0aCi9VnVqeRy3LTCTluqFk/4q
Pp95Jn371i/vLP8UA25TX8BSjH2DZbbTqK9yojPoFbUh8M9AwoV/cl2+Y7gWONci
kDrNkXFd1a81t9QxSE93QYz5uBt6dMEQOv8YcU7URYelU6UUyPJnp211nV9zQPcQ
pWkCf5z51WQ7sQxmQAAQyfnxQGUz+/DWYlg1T34N2fHpfDEJ/4sweenooQD1oll6
zgDWRB19SHh20ajZhbBmZvVM/74dmIuPG/cOD5pIKNpY8tyEVBT64RwPBBQOsbiG
yACBpFTCqPsILca0859USKpjykNFShXpl07h7mt5XjWDY3rchl/zAmnNEt5qDPF7
B7ihafGiBGHU9uh+75oOhwdw8NZQ8az+qLfr5dGbvLZV+E1RsibTv+Qu51dYYjtG
Rt6+Fn1QENVjSCCdlqV6Fu5xXYNLtdc4IJtXj08v/j9jhBTZXj7Yk4QcUlhco+On
FQWD3WMZYKDj0peST0o1
=rJUq
-----END PGP SIGNATURE-----

--nextPart3229696.79O0PMsP2s--
