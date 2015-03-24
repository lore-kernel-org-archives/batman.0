Return-Path: <mpa@pengutronix.de>
Date: Tue, 24 Mar 2015 12:10:06 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20150324111006.GB28604@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
 <13855982.zheniJVJDB@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <13855982.zheniJVJDB@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 25/26] batman-adv: packet.h,
	add some missing includes
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


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2015 at 11:36:10PM +0100, Sven Eckelmann wrote:
> > --- a/packet.h
> > +++ b/packet.h
> > @@ -18,6 +18,11 @@
> >  #ifndef _NET_BATMAN_ADV_PACKET_H_
> >  #define _NET_BATMAN_ADV_PACKET_H_
> >=20
> > +#ifdef __KERNEL__
> > +#include <linux/bitops.h>
> > +#include <uapi/linux/if_ether.h>
> > +#endif /* __KERNEL__ */
> > +
> >  /**
> >   * enum batadv_packettype - types for batman-adv encapsulated packets
> >   * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
>=20
> Ok, so you are including linux/bitops.h for BIT(...) and uapi/linux/if_et=
her.h=20
> for ETH_ALEN? You are missing:
>=20
>  * linux/types.h for uint8_t, __be16 and so on
>  * define for the bitfield byteorder comes from asm/byteorder.h
>=20
> Most of these files are part of linux-libc-dev. The rest requires some ki=
nd of=20
> hack. A way to still work in the batctl build would be to include dummy f=
iles.=20
> An example patch is attached. This builds at least on my Debian system an=
d my=20
> OpenWrt build environment.

Thanks, I like the idea of dummy files. The patch also looks fine.

Best Regards,

Markus

>=20
> Kind regards,
> 	Sven

> diff --git a/Makefile b/Makefile
> index 0eb71a1..ffbbf72 100755
> --- a/Makefile
> +++ b/Makefile
> @@ -30,7 +30,7 @@ MANPAGE =3D man/batctl.8
> =20
>  # batctl flags and options
>  CFLAGS +=3D -Wall -W -std=3Dgnu99 -fno-strict-aliasing -MD -MP
> -CPPFLAGS +=3D -D_GNU_SOURCE
> +CPPFLAGS +=3D -D_GNU_SOURCE -Ikernelinc
>  LDLIBS +=3D -lm
> =20
>  # disable verbose output
> diff --git a/kernelinc/linux/bitops.h b/kernelinc/linux/bitops.h
> new file mode 100644
> index 0000000..d41db10
> --- /dev/null
> +++ b/kernelinc/linux/bitops.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
> + *
> + * Marek Lindner <mareklindner@neomailbox.ch>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA
> + *
> + */
> +
> +#ifndef _BATCTL_KERNELINC_LINUX_BITOPS_H
> +#define _BATCTL_KERNELINC_LINUX_BITOPS_H
> +
> +#define BIT(nr) (1UL << (nr))
> +
> +#endif
> diff --git a/main.h b/main.h
> index 461f3e3..248467c 100644
> --- a/main.h
> +++ b/main.h
> @@ -36,17 +36,6 @@
>  #define DEBUG_TABLE_PATH_MAX_LEN 20
>  #define SETTINGS_PATH_MAX_LEN 25
> =20
> -#if BYTE_ORDER =3D=3D BIG_ENDIAN
> -#define __BIG_ENDIAN_BITFIELD
> -#elif BYTE_ORDER =3D=3D LITTLE_ENDIAN
> -#define __LITTLE_ENDIAN_BITFIELD
> -#else
> -#error "unknown endianess"
> -#endif
> -
> -#define __packed __attribute((packed))   /* linux kernel compat */
> -#define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
> -
>  extern char module_ver_path[];
> =20
>  #ifndef VLAN_VID_MASK
> diff --git a/packet.h b/packet.h
> index b81fbbf..27b4003 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -18,6 +18,11 @@
>  #ifndef _NET_BATMAN_ADV_PACKET_H_
>  #define _NET_BATMAN_ADV_PACKET_H_
> =20
> +#include <asm/byteorder.h>
> +#include <linux/bitops.h>
> +#include <linux/if_ether.h>
> +#include <linux/types.h>
> +
>  /**
>   * enum batadv_packettype - types for batman-adv encapsulated packets
>   * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
> diff --git a/sys.c b/sys.c
> index 676bef1..6c0cab4 100644
> --- a/sys.c
> +++ b/sys.c
> @@ -26,6 +26,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <dirent.h>
> +#include <linux/bitops.h>
> =20
>  #include "main.h"
>  #include "sys.h"




--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEUYOAAoJEEpcgKtcEGQQIsYQAKjcx2dsnZz5inYRzvih6D5Z
D0RDibHAMMXWN4pitshoOacAdDCr+2lilF9KEqLjcbwiTv4j+RwVTyEDAPqrD14M
KGQ/3Mb+KCnrzAmVHf0PR/56NDL7eGytwLglKVfAREiTZXB59VnWOIlW5iaBXOmG
3lLs8LL/oEOcONVyxQMzCcN7+X5gnqaJwww8+WZ/vHehhJDF4wLs6y4a84+I/Fdl
LnQPgDNxjcxGoXFdsgnM76coBAWwqH6nLXCRccGCsrcuxFlusANAAgH13WiFZIe5
io+yqQUOZ8Nh/eJAMOT5JTNLVB3sSiIgAArZe3RT6dvqZHWh2C8ioBLixQp5N7kO
8ymW1+oAyAeaWqClaaioxZ2axaio0Ut1hqWAuT5EVNGiY2LpjT+7li3phQpSp4Y2
EdHsXYUmK+wC+qAo8l/3/W7oJIKToSodu4Kgh7QnTGzVw7Y1euh2yczHmM/4k5Ye
Sa2gu64fozRD8LQWIXj6C5xdgQ6oSrBPTpLGSrckqhSP8cPOBE4bct6Q5mqklAWN
tAV+hYgXfZnSdKGt350LwPDYRESPsEURynam57ar3/zuoG8IbmqIHDolqx+e2f45
WODKGld3d2a/ZdkPbLUkqfndjhQBD/w/ImRlURCRAgsxCKbRRBhgtfzXK9OjUyO6
R2C/wH+L5iyYZf0v1H9/
=Q653
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
