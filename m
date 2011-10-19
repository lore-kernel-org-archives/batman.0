Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Oct 2011 09:45:12 +0200
Message-ID: <1378702.GiY0aRojPS@sven-desktop.home.narfation.org>
In-Reply-To: <4E9E1A8A.6000902@gmail.com>
References: <201110190044.38983.lindner_marek@yahoo.de>
	<4E9E1A8A.6000902@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1778550.GoxRIZglKi";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.3.1 released
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
Cc: Michael =?ISO-8859-1?Q?St=F6cker?= <michael.stoecker@googlemail.com>


--nextPart1778550.GoxRIZglKi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 19 October 2011 02:32:10 Michael St=F6cker wrote:
> Am 19.10.2011 00:44, schrieb Marek Lindner:
>=20
> hallo,
>=20
> even if the batctl remains unchanged, could you please "update" the
> packagename to 2011.3.1? I would like to update my
> openwrtbuildroot-batman-adv-makefile to use the new release but it
> relies on the same version-string.

What do you think would happen when you ask the xorg people to change t=
heir=20
tarball names because your Makefile doesn't work?

We already provide a release folder that contains compatible versions o=
f=20
batman-adv and batctl [1]. Maybe you can change your Makefile+scripts t=
o use=20
that folder. Or introduce a (release,) batman-adv and batctl version fo=
r a=20
quick workaround.

Kind regards,
=09Sven

[1] http://downloads.open-mesh.org/batman/releases/batman-adv-2011.3.1/
--nextPart1778550.GoxRIZglKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOnoAJAAoJEF2HCgfBJntGOeoQAI81s0fDtNeUjzmzhybE2eoz
zWRrTf8SHu1gmE9HcnT0SdYQd4jC5LRvgPI2w2mgG1R6W1e6Eq+o9QI7gsd2CFEY
cCmletrgX0dBCoBYPyIXWBDwr4CnH2J1UbT8K0FfZzUlakEiDhszGPg6Rjz5YjkS
jdvNn0TfC6fySaJg8hyfR2LeyDn8dQpsmNjwrN5/OeTaL36Wd9Xi0xAjaTJS9XOe
QFeD0wOG+cEcl/nbScfVwbP29ST4WJlh6kaMm9JR7phItnC0J5pvHacdV+VZcaTb
N+5eJRNgP3rj7mScTc07TrCnGwo/e08pEsE7HYsKReGurjoz2WA6S/j3UCAcSgw7
fLwUP6sKbiw+9W8choCNkHZ33+1ZturkhpY5u6OIMcR2KynZdJ73Oy+CpvVMfaTu
2XnnK/ruKGJ5cF+BJWZPYBJD1+oDWNEor6QzSWwaCve2vXx9gjK4b80ICgJEbSrl
OmITfwLc0OgGWAQEyXmNBqr5rlIlEA76SU/1GIQ2KxcPCsHEOLk03fZxGerwXGbk
adNf4/Fdfm1P9HEmHb1/rZIyZhwEWvwa7V8YyQU6NWYIu4wiKHKr8PEMqIjGi2Zq
U/0qIPiuo4sh6DX9a7BLDCklZgHTcsrLXLNOTJQrwEqvMLsBVUrhx1MrK7D+ezb1
dLasBHK+mTK8iolmr2Q4
=zR+d
-----END PGP SIGNATURE-----

--nextPart1778550.GoxRIZglKi--

