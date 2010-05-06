Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 6 May 2010 23:44:06 +0200
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1845311.dgafzuLeyx";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005062344.57242.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] staging:batman-adv
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

--nextPart1845311.dgafzuLeyx
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
>=20
> Marek Lindner (9):
>   staging:batman-adv: fix aggregation timing bug
>   staging:batman-adv: fix whitespace style issues
>   staging:batman-adv: convert multiple /proc files to use sysfs
>   staging:batman-adv: convert more files from /proc to /sys
>   staging:batman-adv: move originator interval setting from /proc to
>     /sys
>   staging:batman-adv: remove redundant pointer to originator interface
>   staging:batman-adv: move /proc interface handling to /sys
>   staging:batman-adv: Fix whitespace problems criticized by
>     checkpatch.pl
>   staging:batman-adv: Reduce max characters on a line to 80

Am I the only one who thinks that Marek takes credits for too many patches?=
=20
Yes, we all have to praise him for his work, but just noticed those minor=20
glitches:
 * fix whitespace style issues
   - work from Luis de Bethencourt <luisbg@ubuntu.com>
 * Fix whitespace problems criticized by
   Reduce max characters on a line to 80
   - work from me... somewhat

Not that I really want credit for those patches (maybe I should have submit=
ted=20
them under a different name.....), but that didn't happen in the past and n=
ow=20
more than one time in a row. What happened here? git-am's fault?

And thanks to Andrew for the preparation and submission of that huge patchs=
et.=20
Some patches are missing the signed-off-by line from you or have typos insi=
de=20
that line. Maybe you can use `git format-patch --signoff` to get that=20
automatically added if it is missing.

Best regards,
	Sven

--nextPart1845311.dgafzuLeyx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL4zgnAAoJEF2HCgfBJntGeIUP/0/hNW4QNGxD5dtl/Rhtd2pP
92Wrh0PRn70P0YkP2XGVac2lt1d4zLUmzm6NHG6Chq0Fz4xjnEd1eGLgTJuIjjQD
AUMciEKsS39zh/CyYXm3ZSziU8MMaXADw4oPgkpIbO5Dgt7A8aVM0UyQq0RWArKT
k8BJszR96CsJenYU+SNhrhjZlSjfeM3Op5541aN47yuz3oTHuyYgZwUxrhb/UPsh
iUDzHFAkN9KeoCFJ7I1j4X7vOok775Ss45TgU5qOYEkFpA1BREKnI7AVlM1LhWfj
mGAFY404pSbX5uZyEwekqu+tbf/2nrkxl5M9gBTnq5HRc9JceSkKx1jvUbtb4c9X
Eieg6cwLR7q8bkvL1AfGmjawbR6r/5yN9S2c/IEnG3WdkpOnxKw7+m0vM2Kn0jJC
0jfpFNe5MsFsUDeMJ8dzXWtKto7LKep/BAAxld7cNpQubflVh54DNzAQHY9Ovl2Z
KhHzn1wyrm+AEeG+axHf7t127oNEJ4WNu/b9ojB/jRjKszUtpR2FUMeZ252TwFAR
tu/267bQeAJM2VtP6JxmLgUj1gwdDl4+A8Zt8/D/GUEtIo2G6iHAHhLY5hlmdmR0
C5WCOFE85YFNlhDRYvhGuESFFNRmy4xpSOtPV8y883lISImRqLKG3ZtFkhoydM4Z
KBRkR53+GtO91V053W6n
=iAri
-----END PGP SIGNATURE-----

--nextPart1845311.dgafzuLeyx--
