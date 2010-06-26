Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 02:36:09 +0200
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1955167.eSaf1ErgWp";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006260236.10217.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
Cc: greg@kroah.com, b.a.t.m.a.n@lists.open-mesh.net

--nextPart1955167.eSaf1ErgWp
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Eckelmann wrote:
> here are patches targetted for 2.6.36. All patches needed for that patchs=
et
> are already part of your staging-next tree.
>=20
> All patches are cleanup patches and no new feature is added.

It seems that I forgot two smaller changes. Please add them to the list of=
=20
patches I send to you today.

thanks,
	Sven

Sven Eckelmann (2):
      Staging: batman-adv: Allow to build it inside the kernel
      Staging: batman-adv: Remove dependency to PROCFS

 drivers/staging/batman-adv/Kconfig  |    2 +-
 drivers/staging/batman-adv/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--nextPart1955167.eSaf1ErgWp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMJUt5AAoJEF2HCgfBJntGyXgQALppScfCYVVrV4eQPtWs0j5y
LveHrzCO2ro5gMIOrSsQL3/IkyC9EUsJTt2xyVnABtWO3eTzPEEgN9bQPOiy06mN
NUxEMpBZNiN4ZtppfIXQpy7IfXsNRizubGAqzwzkusvwOOzdz8oEhNfao10c35x/
cjbL13jPFdtJx4vAuF9z07CsdA2/ecuGpVBiKWDzcoX5RRMnEkEkbDgSEmQpAJBf
691SiHrUMk9i2kCjrl6+wXjA68henbTm0Vqe7ehO3HajQsflBaEWNBsg0Q7bGEgH
SEqmu9LReUxpcYC2u77xBMVFLzcF0vF0jJB35xn8GLqDfnc4dvZrjJZpwU3XP3ZJ
stKD/OzHIZa4v/puzgD6MD0IAuHJPbs/IVB9YohipI+3w/FFZjQzNE14fAc939ck
lp0FE0nOGkxueDWTBVRTxYS/K0QFaEotoReAlRWkGGiUy2hsSmwTA82xiChkzKrk
Tj7dKzK9TZhYZhQUYDbr62PYXMcDB7s11cFMpgs/Le7lb2sTN0RO+xFDiDaZ+Dj0
af0c/8gSfJFw1G2OBX77ZijJ1sJSAGJDutwcqFa8Xf6CrwDI0M65P9+nBoXXeMT8
MATxb+vEZFNd/VLrLTuRP6GfBEt+pFcC/6gvLWvc/hBO0LtUg8Jd5gwLTE83FGa8
xRj1tdBNx/hp9k+29b+2
=oAMf
-----END PGP SIGNATURE-----

--nextPart1955167.eSaf1ErgWp--
