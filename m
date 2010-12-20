Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Dec 2010 13:17:51 +0100
References: <201012181801.14616.neumann@cgws.de>
	<201012191009.09941.sven@narfation.org>
	<201012201245.16891.neumann@cgws.de>
In-Reply-To: <201012201245.16891.neumann@cgws.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1673831.fMbB6WoPms";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012201317.52706.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] New BMX website at www.bmx6.net
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
To: Axel Neumann <neumann@cgws.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1673831.fMbB6WoPms
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Axel Neumann wrote:
> > Does that mean that your svn directories and git repositories at
> > open-mesh.org can be dropped
>=20
> In the long term yes! But please not right now. I want to update links in
> other repositories like openWrt first and give users some time to update
> their checkout as well so that the build process does not fail. Lets say
> in February.

Ok, sounds good.

> > (at least it seems that no branch has common
> > ancestors with your branches)?
>=20
> For branches/bmx-0.3.x/ I used git-svn to create the git repository  which
> I expected to create common ancestors. Some confusion leaked in when I
> moved the directory from trunk/batman-experimental to branches/bmx-0.3.x
> (some deleted files like LIESMICH,.. were not deleted which I fixed with
> the last git commit).

The problem is that you (sry, no offence meant) did a quite bad job to conv=
ert=20
it. bmxd.git has these weird git-svn-id lines in the commit messages, "rand=
om"=20
commiter names+mails, missing parts of the history, dangling symlinks, ...

Please take a look at git://git.open-mesh.org/ecsv/test/bmx.git
I don't say that it is the holy grail of svn-to-git conversation, but I thi=
nk=20
it could be a better conversation than your bmxd.git

Best regards,
	Sven

--nextPart1673831.fMbB6WoPms
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJND0lvAAoJEF2HCgfBJntGsAsP/3DJREZHRZOL9lU7lkdK7oX8
QGoRM3b1OSeugcRZ0nP9E0lHpCsh5ycLXleFbdC6MA6pIk2hjwOPvlIaiy8CaOLp
23JbxGHmtoOiTyYNcX8NmSf66SFDBKSxbyVeoDlle8zHP9ONxQazTGiOP41KRbph
1rx2KJ88UFWuUy8RwKn3oBu5eOIjFD8ZftNsrcvBd1HY3e/Fk9XD17kPMAHgDLzH
lk1fL0YlJlHeNCEA6Zi+8xs55GOrhhyp+YVGlEeG+PWMnGxlyZNF1rGCmmGsd6qX
ZTjDBRy337ywTNNG7ejXqsakiWgwhwBfx0ibWKYzLG8WAbeYOe9LKKrlkZmYPieE
e1S1YXNrhJqjQFMmJk7dXNRL51aQpyGSwH+F8KVVgL5De7FmOzsocqVEPaGZkq5V
DKjcCj6NVGwAhPHCPeO2b5sO9BbWujlR/ZBOEv5NCKEEVm7srHsyx9z2UkaJUTXZ
9ZqHLCtKbsxgO0CStAP2PzLBzDtjwJzPW/+pEcXLKCD4izlPDCXptXJP7CYNhoAZ
6mWj4CV61DeCKFQmSYi4wxAUHAn8erWHWJpleGx15H6WAnSyr/M9xjD3q0+YnR4s
BaB6Vtd8Rceb+GriAqEiwpWW14nDlW04RiFvgZV5ZucV6LP0TuzJFnHlAcsakAMH
S8tHjclqnJZlgb+RWOk/
=6zBw
-----END PGP SIGNATURE-----

--nextPart1673831.fMbB6WoPms--
