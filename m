Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 3 Nov 2010 12:04:37 +0100
References: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
	<20101103102512.GD10579@distanz.ch>
	<201011031156.28683.sven.eckelmann@gmx.de>
In-Reply-To: <201011031156.28683.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2611374.KTe8h7geEC";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011031204.39478.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] staging: batman-adv: Use
	linux/etherdevice.h address helper functions
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
To: Tobias Klauser <tklauser@distanz.ch>
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.org, Greg Kroah-Hartman <gregkh@suse.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart2611374.KTe8h7geEC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 03 November 2010 11:56:19 Sven Eckelmann wrote:
> On Wednesday 03 November 2010 11:25:12 Tobias Klauser wrote:
> > On 2010-11-03 at 11:12:12 +0100, Sven Eckelmann <sven.eckelmann@gmx.de>
>=20
> wrote:
> > > On Wednesday 03 November 2010 10:59:02 you wrote:
> > > > Replace custom ethernet address check functions by calls to the
> > > > helpers in linux/etherdevice.h
> > >=20
> > > Have you proven that the addresses are always two bytes aligned in
> > > memory? Afaik this function needs it.
> >=20
> > I don't think they need to be two bytes aligned, but I might be wrong.
>=20
> compare_ether_addr uses a two byte pointer to access 3x two bytes. This
> makes it necessary to have all those 3 bytes aligned to 2 byte boundaries.

3x two bytes for each ethernet address =3D=3D 6x two bytes and not 3 bytes.=
=2E. I=20
don't know why I wrote that.

Best regards,
	Sven

--nextPart2611374.KTe8h7geEC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM0UHGAAoJEF2HCgfBJntGJJ0QALk6xo3hfB6eVvtrd247t6fr
lXf/knlDPFwvdhrTlNDskHoK8LHs82YWSNhTgeNaYz3J5XT9iDQ40Jrcvf4+YQF7
L0eBp8w2OJYUmwuvcYfT/OpixS+qn0FSAvY574htZQpXIDpG7QFT6vvKJpOicfk+
T4Qaw792i3lXXuWUQ5YwWOfpCVxcDGZFVCMKRH8EUEHQBQgHxfnfch6aLTJfZfOj
CxquAFJJQND1erxOyVtIm8BaBy0X7n4b7lECyNd0D2Xo1JUuM/4HJDruAE+4VBYB
e+7WYWa+XFbeBrLfNcgj+CvWmGBa0+nbKc/j8e00pMZaQUSmXq1Ut8G70Qt4Trf/
qensKxRUYNRJnqw521sZa7uXgvY7X3MXPPzmrmxfRBXZKws/oSgM5f8wTOdVAYW+
SKjyDMP9WWCdvY0CBo+nT0zarXGg7FaOlT+xZcmh9x2+GFY9wM5oW+wcbgUfLba9
4yQgDpt6NMpyZnAdb21IAlWm6rlkN8SwTHR+IVuaHjSvii+FzBQYcQEDj0xgepot
z0U0TPW83HiA7FRY3lHw95uBt/GqzFI4CwtVFtYvpbSTv5+aV0M1HnQv5Ru8Gdyo
e8x/d+O6EgQ4mbzudbLIw3zid94j6LwGAX+JvwlO4UNLonhz+9DjM7LQChB0OluZ
wFCM8tNiLZGlkMc9669L
=Gutd
-----END PGP SIGNATURE-----

--nextPart2611374.KTe8h7geEC--
