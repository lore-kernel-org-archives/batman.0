Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 22:16:58 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121017201658.GA31782@pandem0nium>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1350503758-20685-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] alfred: Prepare makefile for
 distibutions
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


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied in revision fd9df5a.

Thanks,
	Simon

On Wed, Oct 17, 2012 at 09:55:55PM +0200, Sven Eckelmann wrote:
> Distributions must be able to easily set CPPFLAGS, CFLAGS and LDFLAGS to =
have
> full control about optimization or security related flags. It is also nec=
essary
> to be able to install all files.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 80 insertions(+), 11 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 92299ac..9796528 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,12 +1,81 @@
> -LDFLAGS=3D-ggdb -static
> -CFLAGS=3D-O2 -Wall -ggdb
> -BIN=3Dalfred
> -OBJS=3Dmain.o server.o client.o netsock.o send.o recv.o hash.o unix_sock=
=2Eo util.o
> -default:	all
> -all:		$(BIN)
> -$(BIN):	$(OBJS)
> -	gcc $(LDFLAGS) $(OBJS) -o $(BIN)
> -.c.o:=09
> -	gcc $(CFLAGS) -o $@ -c $<
> +#!/usr/bin/make -f
> +# -*- makefile -*-
> +#
> +# Copyright (C) 2012 B.A.T.M.A.N. contributors
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
> +BINARY_NAME =3D alfred
> +OBJ =3D main.o server.o client.o netsock.o send.o recv.o hash.o unix_soc=
k.o util.o
> +
> +# alfred flags and options
> +CFLAGS +=3D -pedantic -Wall -W -std=3Dgnu99 -fno-strict-aliasing -MD
> +LDLIBS +=3D
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
> +
> +# standard build tools
> +CC ?=3D gcc
> +RM ?=3D rm -f
> +INSTALL ?=3D install
> +MKDIR ?=3D mkdir -p
> +COMPILE.c =3D $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
> +LINK.o =3D $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
> +
> +# standard install paths
> +PREFIX =3D /usr/local
> +SBINDIR =3D $(PREFIX)/sbin
> +
> +# try to generate revision
> +REVISION=3D $(shell	if [ -d .git ]; then \
> +				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> =
/dev/null || echo "[unknown]"); \
> +			fi)
> +ifneq ($(REVISION),)
> +CPPFLAGS +=3D -DSOURCE_VERSION=3D\"$(REVISION)\"
> +endif
> +
> +# default target
> +all: $(BINARY_NAME)
> +
> +# standard build rules
> +.SUFFIXES: .o .c
> +.c.o:
> +	$(COMPILE.c) -o $@ $<
> +
> +$(BINARY_NAME): $(OBJ)
> +	$(LINK.o) $^ $(LDLIBS) -o $@
> +
>  clean:
> -	rm -f $(BIN) $(OBJS)
> +	$(RM) $(BINARY_NAME) $(OBJ) $(DEP)
> +
> +install: $(BINARY_NAME)
> +	$(MKDIR) $(DESTDIR)$(SBINDIR)
> +	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)
> +
> +# load dependencies
> +DEP =3D $(OBJ:.o=3D.d)
> +-include $(DEP)
> +
> +.PHONY: all clean install
> --=20
> 1.7.10.4
>=20
>=20

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlB/EjoACgkQrzg/fFk7axbpFACg2DeYnYTBFx4OSOO7r5jLjyU8
Y+8AoLzqcfWaOdEgPRsllk/vDYETnWkT
=o2Q/
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
