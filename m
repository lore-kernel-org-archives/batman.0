Return-Path: <ordex@autistici.org>
Date: Wed, 2 May 2012 23:16:13 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120502211612.GB2093@ritirata.org>
References: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Change "make install" path
 and run depmod
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2012 at 08:50:51 +0200, Martin Hundeb=C3=B8ll wrote:
> Currently, when installing the out-of-tree module on distributions that
> use gzipped modules, batman-adv.ko will be installed next to
> batman-adv.ko.gz, which is selected by kmod.
>=20
> By changing the install path to
> /lib/modules/`uname -r`/updates/net/batman-adv/
> and running "depmod -ae", we make the newly installed module used by
> kmod.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  Makefile |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index ac84fba..c68937d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -55,7 +55,8 @@ clean:
>  	$(MAKE) -C $(KERNELPATH) M=3D$(PWD) PWD=3D$(PWD) clean
> =20
>  install: config
> -	$(MAKE) -C $(KERNELPATH) M=3D$(PWD) PWD=3D$(PWD) INSTALL_MOD_DIR=3Dkern=
el/net/batman-adv/ modules_install
> +	$(MAKE) -C $(KERNELPATH) M=3D$(PWD) PWD=3D$(PWD) INSTALL_MOD_DIR=3Dupda=
tes/net/batman-adv/ modules_install
> +	depmod -ae

would it be cleaner to run depmod -e $(uname -r) instead of using -a ?

Cheers,

> =20
>  config:
>  	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
> --=20
> 1.7.10

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPoaQcAAoJEFMQTLzJFOZFcscIAIOQNGMvaSu3vv4D41lpkRrE
Af5Qkk15t/RINy53BquHdgTxspnYX7Q1Wdp481aykI1cOBJfvT6xGasiTaYqnr5n
YSy84VfczQmEecJTjxsmDuPNZ7rQHcHcfremmpjRY+8w2LNhlgg8yt2FW4Lpc3n+
goaczx+e53eYeWFR23QQwe/gV+1rrrZ8iX1uNdMVupOfdvi1n4+nG//otgHtHOzt
rZAbAIS57KP77Bu2l/fuElfnZmXdT6T/5cLx6YDXivFVm8h0cZ+zRZr2h4HxBs1Q
x1G7le057E3skyg4DHw7lWKutEaAZgReIcmS+22lHOmXPNBblpRUcw83rgvHIWw=
=lxsn
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
