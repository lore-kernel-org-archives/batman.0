Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 3 May 2010 00:12:09 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5650455.0rTKAUXlgh";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005030012.18621.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Merging of changes only in maint back to trunk
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

--nextPart5650455.0rTKAUXlgh
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I worked today on a small project [1] to recreated all current features for=
=20
0.3 on top of the current changeset in maint. This would be handy when Andr=
ew=20
Lunn will send them to the kernel folks.

I discovered several small differences between maint and master which resul=
ts=20
in slightly different content in the rebase branch. This comes from the=20
missing merged README and CHANGELOG and some inconsistent changes in my "80=
=20
chars per line" patch. I would like to encourage to merge that changes even=
 if=20
the README has currently some outdated information.

I would also want to ask Daniel Seither, Simon Wunderlich and Marek Lindner=
 to=20
check if I accidentally changed their patches in a way they don't want to=20
support. I know that the commit messages aren't up to date, but would like =
to=20
receive any kind of corrections for them.

Best regards,
	Sven

[1] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dsummary

--nextPart5650455.0rTKAUXlgh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3fi6AAoJEF2HCgfBJntGRWMP/1Qldl5ap9VWh+WHmSyh5wg2
k4f1iTThCzRRYVkUpAZJGR8s1TY9EG7WVVb90cygDqenkihLLTCb5xWqt3X4v+7e
x0QmFUJgbOGIvU3SqgUo1EvteP0Hh2Uc4wHCaKYWRk8P0vRJE/A2wcX2B4HkjS+/
x3Gj3LPcSEjnum+w3TnPsyRBUulYPGm0viAH1NTAQE7IAIklyNd2+COE9eFhMdYl
ogKxGpnxUzk4K5lRrJ3vGOwY9i+g4Y4ovVdXo4CZNOOZK2BEEtZoE66kdDp4UBse
6EoiBt6ha+m9bW/WoDPfhBwRHZ3QqTG8J18zZnKcKoSwzpNLAukxKb1JQYH5tjXD
vsv2NumHHiDFAWXJTO2kU5OqMC9HFWTMXA/jcvZRfJfjq/BGI8duJu1/cP3kiVmu
Yv+Ozz7f6m7TgqP5a13MS7rJeLtI+7ehna/TuBtb+7D4W+L9EvTudT5HHbiN/10E
9/qOJiJMLc0V3Bf0jGFCSHof4wekygp6GUQVfu5mQRIVV9LzTxxeZFS9DWBgUKVE
0PpNPfrTL7/+YGxslz8MxjBmTUNamAzsH39tNxeS1hECJafEt1Qt8Nzjlj0gyZyN
P6YklZN0Y5fLE6N9xNsFg5djdtGOEGAZPyGfGQ4qYZdNbSX7Tb0+I3Dozt9LYqnl
wbGdodphJIHa7vWA1rmU
=rOPi
-----END PGP SIGNATURE-----

--nextPart5650455.0rTKAUXlgh--
