Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 2 Oct 2013 15:19:15 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131002131915.GB24077@pandem0nium>
References: <1380659032-14488-1-git-send-email-andrew@lunn.ch>
 <1380659032-14488-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <1380659032-14488-2-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv1] alfred: Add support for passing
 location information over alfred.
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Janne.Paatero@ruag.com, sven@open-mesh.com, siwu@hrz.tu-chmnitz.de


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 10:23:52PM +0200, Andrew Lunn wrote:
> ---
>  CHANGELOG          |   3 +
>  Makefile           |  24 ++-
>  README             |  52 +++++-
>  gpsd/Makefile      |  81 ++++++++
>  gpsd/alfred-gpsd.c | 529 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  gpsd/alfred-gpsd.h | 102 +++++++++++
>  6 files changed, 784 insertions(+), 7 deletions(-)
>  create mode 100644 gpsd/Makefile
>  create mode 100644 gpsd/alfred-gpsd.c
>  create mode 100644 gpsd/alfred-gpsd.h
>=20
> diff --git a/CHANGELOG b/CHANGELOG
> index aa0371f..404f3f3 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -11,3 +11,6 @@ alfred 2013.3.0:
>   * exchanges data via IPv6 unicast/multicast
> =20
>   -- Sun, 28 Jul 2013 18:56:52 +0200
> +
> + * Add support for distributing geographic location information,=20
> +   either fixed, or read from gpsd.

I'd like to do the CHANGELOG the other way around, e.g. newest entries come
first - and your changes will not be released in 2013.3.0 or before. :)

Please just drop this change as I'll compile the CHANGELOG when releasing
myself anyway. No need to bother. :)

> \ No newline at end of file
> [...]
> --- /dev/null
> +++ b/gpsd/Makefile
> @@ -0,0 +1,81 @@
> +#!/usr/bin/make -f
> +# -*- makefile -*-
> +#
> +# Copyright (C) 2013 B.A.T.M.A.N. contributors
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of version 2 of the GNU General Public
> +# License as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> +# General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> +# 02110-1301, USA
> +#
> +
> +# alfred build
> +BINARY_NAME =3D alfred-gpsd
> +OBJ =3D alfred-gpsd.o
> +
> +# alfred flags and options
> +CFLAGS +=3D -pedantic -Wall -W -std=3Dgnu99 -fno-strict-aliasing -MD -MP
> +LDLIBS +=3D -lgps

I have no idea if we need some special handling for this to let it work
for crosscompiling, OpenWRT etc?=20
> +
> +# disable verbose output
> +ifneq ($(findstring $(MAKEFLAGS),s),s)
> +ifndef V
> +	Q_CC =3D @echo '   ' CC $@;
> +	Q_LD =3D @echo '   ' LD $@;
> +	export Q_CC
> +	export Q_LD
> +endif
> +endif
> [...]
> +
> +	if ((alt < -1000) || (lon > 9000)) {
> +		/* No support for aircraft or submarines! */

Too bad :D

I haven't tested this, but I like the idea to transport the gpsd informatio=
n.
We will probably seperate the package to let OpenWRT users choose if they
want to have this feature (because it comes with gpsd dependency), just as
we have done with vis. TBH I didn't expect to fill the alfred repository
with feature daemons, but as long as it is maintained, why not. :)

Thanks,
	Simon

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJMHVMACgkQrzg/fFk7axa+YgCgsyMEU/O5SAXAbjGeY4wif9xb
CvUAoO/4n9VVujYoaN35DGvXOCiOv81I
=a5Yp
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
