Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Jul 2010 16:54:10 +0200
References: <1279616589-3086-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279616589-3086-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19708138.cnK4QbtKoi";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007201654.12258.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Calculate hamming weight
	using optimized kernel functions
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

--nextPart19708138.cnK4QbtKoi
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> The Kernighan algorithm is not able to calculate the number of set bits
> in parallel and the compiler cannot replace it with optimized
> instructions.
>=20
> The kernel provides specialised functions for each cpu which can either
> use a software implementation or hardware instruction depending on the
> target cpu.
>=20
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---

Maybe someone could do me the favor and add before the Signed-off-by: line =
one=20
that mentions that David S. Miller is the actual reporter. This would look=
=20
something like this:

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

thanks,
	Sven

--nextPart19708138.cnK4QbtKoi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMRbiTAAoJEF2HCgfBJntGfloQAMM79FJLy1jeYuHaYmCL+cfj
D533DGDZ2MrLIqWK0YGtoeZuTXA2d2/67a1Jux/xrF+dyKjC8gg+WOrIDDkgXrzE
j0+pmDZc3s27N4Rg83CYN/RCRLisu0XOSE+1lat1U9mS4bcXMq5JClfmPG6IIs+z
dIZrL8VejAkuA1R12PGCg/UA0Wc9a7NF5A9mXACEBC/XcfCuCZhocrTm+GujtEPg
6SEVSVKPCqSEj4jY+M7EREQpp9GPPJQmoV8cKwDCFfDkuXCEvODsDsRqLVl1Y0JP
ykP2vxfji3F8oFqZx+mO9iopaYlm+j9nuzZh80tTQ6iiS0sQBUqI+Yj05SouUKq4
EOOJN+OmFZqQrCjwt5WQGXycDJmaHzQX74KCO4mK10oHcDub4P4rz0JWNzq7amOd
K4C+6z3fanCZNs2GjJuKSt3rSv1/AqYFsW06cpRJdGGJx5H1MXSJ7hiBrnoyvuXN
QlDXtJ3uYhOJYXuhpCsxsrcUU3xu31aOUml9AgoYzTNnBpYmqVHtFBu7cS2qFKpp
YpCewGD/ehlVnL5U3jSeDivuqU4EX6pBA54jhaPwCj1Keev/aSjDKA7OpNokTytD
gHRJ698VVEtt2YGzYUXGX3+mw3fGDxJJ3G0O5AP4NMzjGHClbGOhrSH384jnq3Va
ifXlJmjFWik2Y21ZT5za
=HEGN
-----END PGP SIGNATURE-----

--nextPart19708138.cnK4QbtKoi--
