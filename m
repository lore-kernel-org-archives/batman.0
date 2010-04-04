Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 4 Apr 2010 13:30:33 +0200
References: <1270341625-28764-1-git-send-email-luisbg@ubuntu.com>
	<201004041246.38682.sven.eckelmann@gmx.de>
	<t2v506b70dc1004040410qbae117b7r3e6c02ccb616c73a@mail.gmail.com>
In-Reply-To: <t2v506b70dc1004040410qbae117b7r3e6c02ccb616c73a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1562003.AVAlhzh5RH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004041330.37112.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] Staging: batman-adv: fix whitespace
	style issues
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
To: Luis de Bethencourt <luisbg@ubuntu.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1562003.AVAlhzh5RH
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Sunday 04 April 2010 13:10:12 you wrote:

> Thanks a lot for the help Sven.
>=20
> My patch didn't include changes to bat_sysfs.c, where are this changes
> coming from? Sorry if I'm missing something obvious.

Correct, that was part of the redoing of your changes. bat_sysfs.c is only=
=20
part of the current development version and not in your patch (you still ha=
d=20
the /proc stuff).

But maybe you could explain to Marek why it is important/correct/good/... t=
o=20
have no whitespaces before \n or if the part for /proc or /sys files can be=
=20
ignored.

Best regards,
	Sven

--nextPart1562003.AVAlhzh5RH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLuHhcAAoJEF2HCgfBJntGXZUP/2D2DOeCIqOHg1Rj1l02GUhr
D/+bK/Am57nI0jALQj8X0USsA4O5oELUDOTrL+Fk2em+y7wGXdrEgXvU0Q3St87x
dPqljQuyMLXYPj4OI0Otvni70lXB8kwQMUfZXnyJsAULmTlhZKCAEhZodnaT6lep
T/kPs4/8qQeGEJP4QiKBNnYbp+xsbe4TJKYOAJc3gsEHgNGseMYfsKnA/MwFMPEW
1jvgGLkX1L6/9k+5GPkbooCK552NPwRyXmzoqEVKerOOp5Ivkj0v+N0DTWeP0K6O
v9m+kO3s1eoA9FSpuND2xIGR4fgK4qkxzdw2Tc8yEuLOi8FRgDkZmGRzjFh+/X2S
A4zOVxrzKtIYdEOM8rwxxiaJCD2fgF+uU4MYFok9It2k9WlEKbdRLwp8f5CmriHE
iUHtqFhz892LPlPqvgyfMn0hScfK3MPkd3KG0iahGnULZGWz9jM36v7N1thS6d1k
46fap2eU3FRdgcWG2GC3sP7tG7+IAqf95wMEFiEAXf+EZ2yzg96sWj08oyXozjDg
21V2h8zXWoQZ2ZozBLz0YGQ7f8gejKkWJldjJ/G/hqfPMoMPVdrDuXx4G/EiAaOc
VLmUYQfc6nrcJ5fs78AQIs/l9TsKu1EMp2AWE4Jp6o89BntXnDePBMmUu5ira1cF
pSEZwwG8tqaH8dBUaTR9
=QXZd
-----END PGP SIGNATURE-----

--nextPart1562003.AVAlhzh5RH--
