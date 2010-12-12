Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Dec 2010 21:43:10 +0100
References: <1291233547-9437-1-git-send-email-sven.eckelmann@gmx.de>
	<201012122029.47019.lindner_marek@yahoo.de>
	<201012122133.56401.lindner_marek@yahoo.de>
In-Reply-To: <201012122133.56401.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22281951.33tpq0CIvG";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012122143.10618.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use kernel facilities for
	bit operations
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart22281951.33tpq0CIvG
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Sunday 12 December 2010 20:29:46 Marek Lindner wrote:
> > On Wednesday 01 December 2010 20:59:07 Sven Eckelmann wrote:
> > > set_bit and test_bit provide an efficient way to set and test bits of
> > > an unsigned long.
> >=20
> > Since test_bit() / set_bit() expect 32Bit values we should at least add=
 a
> > comment next to TYPE_OF_WORD, so that nobody changes this define ?!
>=20
> I applied the patch including a comment in revision 1889.

Ok, since there were a race condition, please ignore the v2 version of the=
=20
patches. v3 will be delivered in some minutes.

Best regards,
	Sven

--nextPart22281951.33tpq0CIvG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNBTPeAAoJEF2HCgfBJntGkCAQAJ4mO2v8Gl+0SDPMDAw8TR0c
+4QQ062x4Vbvg2eHTELcai7z2UjoSXkei872BtH8LyeCz/sSiAVVmdpCPGbnHmBe
43ydWKYjoiQ8amw7NLBgF9bkXMbfYWXCiFdZqIsNf58hyg6W/VGJ+pnLH1gx8ngI
LW2Hrpwmxd5IFdK2fR6aSd+0IDBAtZ6g3hriQKcDhQAGNTDxzIIwVfLGqwxQ2M42
j2VKr8fY095PW7te8Nkh29x2LEWVcN48P89myPLrmc7qXwYzGKfe0fiFjmJdRjne
nKDzXnb7A6PmB8/W8r2BiMGLH6nR8tmotlIJFVI7/Xne6C9O/6hND0UgvlIEUMpl
3V3drVtnEy8Q0u/XOvOzp+H/TABHGXYYlzE6XwXr3CShOrfmPP7y2hU7LvmZyu2l
OAaRLLPOnlAcaDLf9AiZgmo4hi/t0XDy9SeIhgg1aEIzb6rYghHqnZnuGNn8pDJy
XT8ioqsUT944s2UNTVAU9XQz+rz3sNr4gKT9GHq6wt6aBX0RraeaUGKuNs2WY/qy
9dmoPT9nHcRquERfVcSc5UIhI+qHfuaRJ1s9GG17cK2Fox66XLPOX6GI9WnwjIWd
1742XIKoFf00Bl41BFe4Y64VP6RKKVMD0MirVMNY3TfGrpVePckvx/i9Jt1YYUNY
7D1eZcXGb97bcUiwMO38
=2Bwn
-----END PGP SIGNATURE-----

--nextPart22281951.33tpq0CIvG--
