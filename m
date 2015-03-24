Return-Path: <mpa@pengutronix.de>
Date: Tue, 24 Mar 2015 12:41:07 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20150324114107.GD28604@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <2950150.4H3sVLA1nB@sven-edge> <2376189.i7svKM7Q39@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <2376189.i7svKM7Q39@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 00/26] batman-adv: Cleanups
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On Sun, Mar 22, 2015 at 02:34:33AM +0100, Sven Eckelmann wrote:
> On Sunday 22 March 2015 01:52:40 Sven Eckelmann wrote:
> > On Friday 26 December 2014 12:41:17 Markus Pargmann wrote:
> > > Markus Pargmann (26):
> > [...]
> >=20
> > >   batman-adv: packet.h, add some missing includes
> > >   batman-adv: types.h, add missing include
> >=20
> > Just went through the includes and noticed that a lot more are missing =
(also
> > in the files which you are already touched). I have attached the current
> > state of my analysis so you can compare it with your notes.

Do you have any tool which makes this include analysis easier?

>=20
> Small disclaimer I forgot:
>=20
> The patch is currently not finished. Following things are missing:
>=20
>  * #include "types.h" in main.h after "compat.h" (may be removed in the f=
uture=20
>    when I can drop it somehow... but it will most likely be added again e=
ven
>    when there is a dependency circle with types.h)

I hope that types.h can be split up into appropriate topic headers
which are selectively included by the files which need it. However I
didn't have a deeper look into this yet so it may be more complicated.

>  * tests with older kernels

I will test your series with an arm build, but I don't think that
anything breaks there.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEU1TAAoJEEpcgKtcEGQQaMMQAIfwNAr3k5G5gj6id2ALLpKe
gKQXE7+njj4Jw57pzIo2WJaskdZSTK8Sob1Rg6utIAuZ6j3/DeUI5lqjWXJverTW
/z3ypMz63fXz9KCieE11BhJhgo8J/SDhfnFa1ZjxjMxxc45qLzxikjMwy0MwdCqL
G4QnUhGYLxW06XaaS2VU+fIALP0dhV2/5jbSSjqJPQTq4lEl/0Hp1KAsq8vY6KxP
H5P09WWlL10RwiLZNLr40YRBD05PvTfhQnIJ+XF5Do04zHWY0v4Kk3tqlGySpf9I
BTxLu/SwqlIVjtpPOopvZXPvSHMt5bHFm5NL4EbrV3GRLVU2+ExmsgMSBr/IRVio
9wvrQtuIT45s6UH4c8Jw35vWbSBGiQObN4tSEAwzsQglkqiPnY0zESEwbcxbmJZ8
5bV0zCgN5IP8Z+kiO+lE2LcxaWgDamDuxevajeVWHwe9yBUgvyoTq250UBGFIFTI
yFf7aUD6mowSISVr8Ni6PUgiOpxbEhN6YDWzIOzxg8wDIZOK0El3fZd9pde543q4
0Uz7XEA0UwD0ads+j2W1I7YVbWBV8i/C3ZgCLI3ZkvQZbkHHJ7wrxo4h9vh/e7wH
ANDv/c39SKjYWJBCA2w0ucIdSZ8GYezOr7c7L2jHqZYWTuC+VeiCtw/NSJwaJ5Hx
lkqX5sFVqIdzBIEWzvTE
=+pcY
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
