Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 1 Oct 2011 00:35:05 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110930223505.GA30938@pandem0nium>
References: <1317382322-6922-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <1317382322-6922-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't use EXTRA_CFLAGS
 to add source version
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there,=20

I've applied it and tested on kernel releases 2.6.29 - 3.1-rc2, and
it compiled just fine. EXTRA_CFLAGS is still applied when set.=20

I can Ack this. ;)

Cheers,
	Simon


On Fri, Sep 30, 2011 at 01:32:00PM +0200, Sven Eckelmann wrote:
> EXTRA_CFLAGS is deprecated since v2.6.23-2309-gf77bf01 and should not be =
used
> anymore to add additional flags for the c compiler.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile.kbuild |    4 ++--
>  README          |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile.kbuild b/Makefile.kbuild
> index 6377c17..bd7e93c 100644
> --- a/Makefile.kbuild
> +++ b/Makefile.kbuild
> @@ -25,10 +25,10 @@ ifeq ($(MAKING_MODULES),1)
>  -include $(TOPDIR)/Rules.make
>  endif
> =20
> -# EXTRA_CFLAGS +=3D -DCONFIG_BATMAN_ADV_DEBUG
> +# ccflags-y +=3D -DCONFIG_BATMAN_ADV_DEBUG
> =20
>  ifneq ($(REVISION),)
> -EXTRA_CFLAGS +=3D -DSOURCE_VERSION=3D\"$(REVISION)\"
> +ccflags-y +=3D -DSOURCE_VERSION=3D\"$(REVISION)\"
>  endif
> =20
>  obj-m +=3D batman-adv.o
> diff --git a/README b/README
> index 1e000ee..5ba56b5 100644
> --- a/README
> +++ b/README
> @@ -1,4 +1,4 @@
> -[state: 21-08-2011]
> +[state: 30-09-2011]
> =20
>  BATMAN-ADV
>  ----------
> @@ -206,7 +206,7 @@ option "B.A.T.M.A.N. debugging". When compiling  outs=
ide  of  the
>  kernel  tree it is necessary to edit the file Makefile.kbuild and
>  uncomment the line
> =20
> -#EXTRA_CFLAGS +=3D -DCONFIG_BATMAN_ADV_DEBUG
> +#ccflags-y +=3D -DCONFIG_BATMAN_ADV_DEBUG
> =20
>  Those additional  debug messages can be accessed  using a special
>  file in debugfs
> --=20
> 1.7.6.3
>=20
>=20

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6GRBkACgkQrzg/fFk7axb33ACgkiCsdb4EpqZbSNyJW2JrVzHf
HAsAoNTN+af68je5ClrIyRaxNX7jeMDr
=673o
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
