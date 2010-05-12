Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 12 May 2010 21:47:41 +0200
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005130119.39204.lindner_marek@yahoo.de>
	<20100512194309.GE4946@lunn.ch>
In-Reply-To: <20100512194309.GE4946@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart127386104.lNgrEOVlpf";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005122147.48348.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv: convert
	multiple /proc files to use sysfs
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
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net, Greg KH <greg@kroah.com>

--nextPart127386104.lNgrEOVlpf
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> > Regarding the question which kernel configuration interface to use,
> > we would be more than happy to receive some guidance. At this point
> > we are rather unsure which of the many (procfs/sysfs/configfs/etc)
> > filesystems are we supposed to go forward with.
>=20
> Does it even need to be a filesystem?
>=20
> cfg80211 uses netlink.
> ifconfig seems to use ioctl calls.
>=20
> What over APIs are available for passing configuration and tables of
> status information back and forth?
>=20
> Tomorrow is a holiday in the part of the world i live in, and it is
> supposed to be raining. Sounds like ideal conditions for doing a bit
> of research and then comparing and contrasting our options...

Top priority in the conversation from proc to something else was to allow=20
configuration/debugging with simple file operations (read, write) and not t=
o=20
depend on a special tool like batctl.

Best regards,
	Sven Eckelmann

--nextPart127386104.lNgrEOVlpf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL6wXeAAoJEF2HCgfBJntGgIUQAMRK4hMv5vg4gT/zX+0IGI7o
l9k8Jcvu0KdECxH9avHSlrcoF+W7+l/UGn7KsRG4eAjMz+MKR6HTO4DMOfZrv7z4
rf7UMOl/zODaLD7QWUSpFDhIu7IrLWU2iy4L+PQL4TgBEqRx2C4k82g15hx2JaNa
dBOvmw6RFfLlsG1jzj9KRpdhxMwx2kL243t251GBPHCqWlmUFmhqpz+OUihWuOlg
BhnTMwz2vybh8/ennqFUrtcIYFODzwLqx9JYOC49qafnak3B5xuy30c5+W+6TwJa
PsEkh5dD1saesVWNWweOnKNEYzwfrF59KTCOdz7Ec/zOFcs2n/R8eGXaoUSQCMWT
CfY45g5a82/KQefew1TDI8zxY6MKmNPHycdcesakhRknEeL4HMvhh+CZqVa9VX6w
E81j/Nf5/xnrUnt0gGhXNe86XGckn43CHHaAoRlFcJdK9FCMMjljIodDOzeyw3Cw
8W0UtTnC5yZym64rNoxbZJfvWLYhkKvNrgQSwf90MJtVhwrUjBrG4qs5EKDeb+Sw
E+c+gwpWMEpLsO96hVPIKFJilgj63z8/JL178WFiSSE0TobbpMxnOPIJSjMnxmP9
t8X3j5aFIvHTNgektWC4sJ7Y3EabWL5AW2XNQ/BXLjG1Lh15X6YV9r+khGbjw33I
N7fk9HlPR/ZF13mbsRsO
=9Rm1
-----END PGP SIGNATURE-----

--nextPart127386104.lNgrEOVlpf--
