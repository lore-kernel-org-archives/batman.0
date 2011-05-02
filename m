Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 2 May 2011 17:22:33 +0200
References: <1304348024-11681-1-git-send-email-lindner_marek@yahoo.de>
	<201105021702.33522.sven@narfation.org>
	<201105021709.31468.lindner_marek@yahoo.de>
In-Reply-To: <201105021709.31468.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4469018.vBxhLAC4lc";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105021722.35616.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: purge unnecessary include
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

--nextPart4469018.vBxhLAC4lc
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 02 May 2011 17:09:31 Marek Lindner wrote:
> On Monday 02 May 2011 17:02:32 Sven Eckelmann wrote:
> > On Monday 02 May 2011 16:53:44 Marek Lindner wrote:
> > > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> >=20
> > [,,,,]
> >=20
> > >  #include <linux/version.h>   /* LINUX_VERSION_CODE */
> > >=20
> > > -#include "bat_sysfs.h"               /* struct bat_attribute */
> >=20
> > This is necessary for kernels older than 2.6.24
>=20
> Aarrrgh, I was afraid of something like that. We are running into an
> include dependency issue as soon as bat_sysfs.h contains something like
> "struct bat_priv" which is likely to come soon ...
> Any better idea how to fix this ?

Declaring everything below 2.6.24 as obsolete? Other solutions can be=20
developed after arriving at home.

Kind regards,
	Sven

--nextPart4469018.vBxhLAC4lc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNvsw5AAoJEF2HCgfBJntGyBMQAJzdt5DLCN+3BuW/BxYVY2YR
CNGF2IM4N5IO3oQ36VK/V3ENuen44MiSKdEMT0lav8sSQoVUT41G56BxR2tYmXS7
S9rcv8MFKzsW22DQGKfAAn9trrFVWvt8aPb4l9uK4xCroTaN3VOdb2CibSp2eQfQ
8CdmTVYwe4u/fESGuD1p5LdIgARIb87D2u3mDLwzcslftzpJrpV7recusxU7mnrh
k1YbAMby3aPME6QVp5dqnVA16XH0hinTm7I9FKkKwz0E76kKENtj9SQWzVTeM2UX
M79DrxDb+kL1/miBM5WTpvEtcoXUx/PDT8bKHTsteUzzcncDoDntZL6iE3n372YC
hcQuaNGYhZWtV5uuTckLvXbSs11e+1ZALXjspkcd8r48RbD0f6/yM6KN4UPJyxfI
HRDH8IdIFwJWz/nfBQrk49BSp5CwAsA6OeFALlG/nUQVwXRQHBi2/bx4WyKSNMFS
QxX6peSp0srLnyasQHeMKSI1ntfSjB0Cv1Wd26gQ5VwC3X43taBsO4gQgbMNmDUT
YZzGbSZ9//QCM+NO3MM37ptDXywvpxZuqWWQEKMdTyTzp5m4XV/GTu91zmu6Eguo
bu1G0qxYtrES6wp5DpsRNa4Y9rEkBQPo53BG2iujlcvXmSFnS3zgyLh3npELdjqp
qlf6P5TqOm+JnFiNSD8C
=AGU0
-----END PGP SIGNATURE-----

--nextPart4469018.vBxhLAC4lc--
