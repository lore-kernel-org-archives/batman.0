Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 28 May 2013 17:26:14 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130528152614.GA14466@pandem0nium>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
 <1369382549-8787-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1369382549-8787-2-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: Multicast Listener
 Announcements via Translation Table
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


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2013 at 10:02:26AM +0200, Linus L=C3=BCssing wrote:
> With this patch a node which has no bridge interface on top of its soft
> interface announces its local multicast listeners via the translation
> table.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  Makefile               |    2 +
>  Makefile.kbuild        |    1 +
>  compat.c               |   21 +++++
>  compat.h               |   18 ++++
>  gen-compat-autoconf.sh |    1 +
>  main.c                 |    6 ++
>  main.h                 |    9 ++
>  multicast.c            |  213 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  multicast.h            |   43 ++++++++++
>  soft-interface.c       |    3 +
>  sysfs.c                |    6 ++
>  translation-table.c    |   22 ++++-
>  types.h                |   12 +++
>  13 files changed, 353 insertions(+), 4 deletions(-)
>  create mode 100644 multicast.c
>  create mode 100644 multicast.h
>=20
> diff --git a/Makefile b/Makefile
> index 407cdc4..d7c6fa6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,6 +27,8 @@ export CONFIG_BATMAN_ADV_BLA=3Dy
>  export CONFIG_BATMAN_ADV_DAT=3Dy
>  # B.A.T.M.A.N network coding (catwoman):
>  export CONFIG_BATMAN_ADV_NC=3Dn
> +# B.A.T.M.A.N. multicast optimizations:
> +export CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS=3Dy
> =20
>  PWD:=3D$(shell pwd)
>  KERNELPATH ?=3D /lib/modules/$(shell uname -r)/build
> diff --git a/Makefile.kbuild b/Makefile.kbuild
> index 8ddbfe6..d3efe3a 100644
> --- a/Makefile.kbuild
> +++ b/Makefile.kbuild
> @@ -38,3 +38,4 @@ batman-adv-y +=3D soft-interface.o
>  batman-adv-y +=3D sysfs.o
>  batman-adv-y +=3D translation-table.o
>  batman-adv-y +=3D unicast.o
> +batman-adv-$(CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS) +=3D multicast.o
> diff --git a/compat.c b/compat.c
> index 1f3a39d..27df197 100644
> --- a/compat.c
> +++ b/compat.c
> @@ -25,6 +25,27 @@
>  #include <linux/version.h>
>  #include "main.h"
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 38)
> +
> +void batadv_for_each_pmc_rcu_init(struct in_device *in_dev,
> +				  struct ip_mc_list **pmc)
> +{
> +	read_lock(&in_dev->mc_list_lock);
> +	*pmc =3D in_dev->mc_list;
> +}
> +
> +bool batadv_for_each_pmc_rcu_check(struct in_device *in_dev,
> +				   struct ip_mc_list *pmc)
> +{
> +	if (pmc =3D=3D NULL)
> +		read_unlock(&in_dev->mc_list_lock);
> +
> +	return (pmc !=3D NULL);
> +}
> +
> +#endif /* < KERNEL_VERSION(2, 6, 38) */


I guess there is some more compat code required here.

For kernel 2.6.32 I get

compat.h:159:14: warning: =E2=80=98struct ip_mc_list=E2=80=99 declared insi=
de parameter list [enabled by default]
compat.h:159:14: warning: its scope is only this definition or declaration,=
 which is probably not what you want [enabled by default]
compat.h:159:14: warning: =E2=80=98struct in_device=E2=80=99 declared insid=
e parameter list [enabled by default]
compat.h:161:15: warning: =E2=80=98struct ip_mc_list=E2=80=99 declared insi=
de parameter list [enabled by default]
compat.h:161:15: warning: =E2=80=98struct in_device=E2=80=99 declared insid=
e parameter list [enabled by default]

Am I missing config options? These structs are defined in linux/igmp.h thou=
gh ...

Cheers,
	Simon

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGkzJYACgkQrzg/fFk7axbI/ACdEIqirukYN5mM+PzRCI/6XsNG
KUAAniaMvD8kox0STLQeFii+vaRfJkP1
=4Woh
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
