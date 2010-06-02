Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 3 Jun 2010 01:56:40 +0200
References: <1275509418.23599.42.camel@Joe-Laptop.home>
	<201006030133.25522.sven.eckelmann@gmx.de>
	<1275522450.23599.101.camel@Joe-Laptop.home>
In-Reply-To: <1275522450.23599.101.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart53176503.cDWZoxzaLp";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006030156.42370.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Convert
	MAC_FMT to %pM
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
To: Joe Perches <joe@perches.com>
Cc: devel <devel@driverdev.osuosl.org>, Greg Kroah-Hartman <gregkh@suse.de>, b.a.t.m.a.n@lists.open-mesh.net, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart53176503.cDWZoxzaLp
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Joe Perches wrote:
> On Thu, 2010-06-03 at 01:33 +0200, Sven Eckelmann wrote:
> > Joe Perches wrote:
> > > On Thu, 2010-06-03 at 01:23 +0200, Sven Eckelmann wrote:
> > > > You've also changed the output. So you may partly broke batctl too
> > > > (have to check that first).
> > >=20
> > > There was no change in output.
> > > MAC_FMT output is the same as %pM
> >=20
> > I meant the other patch :)
>=20
> batctl is parsing dmesg or equivalent?  ouch.

It has functionality to parse logfiles which for example could come from=20
dmesg.

> If so, may I suggest you consider using something other than
> a message logging parser for batctl?
>=20
> I glanced at the source and don't see any such use.
> It looks like it's only /sys, /proc and debugfs,
> but I only spent a few seconds at it.
>=20
> http://www.open-mesh.net/changeset/1682/trunk?old_path=3D%2F&format=3Dzip

see sys.c -> log_print
and read_file -> read_file

Best regards,
	Sven

--nextPart53176503.cDWZoxzaLp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMBu+5AAoJEF2HCgfBJntGc6kQAMEbvDUARcX5A+wcMJ7FjrBG
BhzEnlqYf8ylKz+4y0x+mfLo704ggVZnFiYtYcm5SNGFkoau5rdFcPpu2fUOG3R9
+Rh+52iu5xg5ra4OkCL02j68ziWBXCzhym9AgSWkPe7ZgS2j+pKd4tly0pvkVRFR
UXeJNlpUVYplSeI3BziWNNU0IPCVZrhw2WyYutEqloYx5c9EYOMJNlHABUd4ELJx
1kfKMFEP5zb1Z5tGC/jtmIjqMBIv3inLZUtOVq6Taj4jLJ83ze6KvZT1Q6SbtLtG
yrHNigWq6BH5lLWAlpU2RDwSczTp259lT6Hm5TUai+/JlP+jpU9Q7TXYrSumt8g/
k74a9JTEujMJRA8AmNM2wPcTmvWLC4s8nKUoJ/BLZUu65u3SzdAuJzBgwG/zU6sc
/ov6dcCXkKuQ8QMQ67bxsMBA2G9fb71NOFTOrN2SXLLGUSS/BFgDp4C4V2rJKTx2
t4mubbMGzHWburkglvwfqv3DL34MO0+qvrJrGjGh6VNeE6vHM5YZha3t7EHdLAE0
/QXPstthd43c90N300rK4C/aAU+XPmhyEtovYDDojp/bEAXFtYhhuxgWKnfV3ze0
Nv7D2nmn9/Ie/Vi9QY9a2Z19ZT+294BP3jrmUWV7WBgUIEypK9kL5NjztSYc4JSR
E2XjnR86wGqFQvKZ8s26
=/kdk
-----END PGP SIGNATURE-----

--nextPart53176503.cDWZoxzaLp--
