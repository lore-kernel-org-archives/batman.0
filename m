Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 29 Apr 2010 16:21:01 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3328355.SppiX5N4jC";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004291621.08579.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Checkpatch cleanups
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

--nextPart3328355.SppiX5N4jC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

last year in December we decided that it is not worth to strictly follow the
80 chars per line rule in the linux coding style document. But after receiv=
ing
3 patches in the last month to fix such or similar problems (which could not
be merged due to other changes already applied to both branches) I want to
propose following patches which try to resolve these problems in files which
get submitted to the mainline kernel.

=46or trunk:
[PATCH-trunk 1/2] batman-adv: Fix whitespace problems criticized by checkpa=
tch.pl                                                                     =
                                          =20
[PATCH-trunk 2/2] batman-adv: Reduce max characters on a line to 80        =
                                                                           =
                                          =20

=46or maint branch:
[PATCH-maint 1/2] batman-adv: Fix whitespace problems criticized by checkpa=
tch.pl                                                                     =
                                          =20
[PATCH-maint 2/2] batman-adv: Reduce max characters on a line to 80

Best regards,
	Sven

--nextPart3328355.SppiX5N4jC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL2ZXOAAoJEF2HCgfBJntG65gP/j2dRs9p2DzfrhQ+FaBbfoVt
jeolEUNFGNry7m7aZtvNvez1qssIAHsHOpeYkztHzK8YY+AgjhPA/Y+emCitMGZS
l728so2byMFS33A/nsMgzMH12DJ68LB3wYjgyfXeFHnEIZDgvpaDNZ6XlP+px4ea
7/0xbs385rqUQJc1eV3YyEGSlCpQRzRdrnxahs297VWDJBAbDIypGo2r2NjZFgUT
BiaaG4vmsUDmErURCfwbXGIUIwaYsViMyiHAxbYzNIxPIKDBHGIGhPAoSzy/NHIg
Rhrt5TsiR9DvXugX69gBI9XksVwOTMOEfDz6MlC+VNHG/kpcmB38oK4VgoFSVecH
QJ3cs9bdmJgMa6PUWV1coz4iHSkcf9Yunnq3YJarkVZpcgL35JYe0PpmYaLrXI1Z
L3J/S2rK5dhqKRsRaOE3O3eA597PMckGr/4JEzqwQevgnpZ1N9+umMG03M9SlSQO
dGm4rTIhrFEXjajED1O/POkNbzZFEZLIhXxStm0NwDSZ3XwM+NC0bMSF99y3Qy9m
mlIgpscAtD7T+vBv4gZxMBmuIcVotYQwzHzjFiMZVWMjj4NITuwanbCvBuA0fkQY
zv2EfeYt8Pt6oOXh+bVJkuSzs027Cm3/tKA7sGoEb7UG+tbA5K+CPOLj3ydV076H
jh1r72dNnBN+JjlGoXry
=fAxa
-----END PGP SIGNATURE-----

--nextPart3328355.SppiX5N4jC--
