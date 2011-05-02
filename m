Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 2 May 2011 17:02:32 +0200
References: <1304348024-11681-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1304348024-11681-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart652176343.xg0qq9GmUv";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105021702.33522.sven@narfation.org>
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

--nextPart652176343.xg0qq9GmUv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 May 2011 16:53:44 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[,,,,]
>  #include <linux/version.h>	/* LINUX_VERSION_CODE */
> -#include "bat_sysfs.h"		/* struct bat_attribute */

This is necessary for kernels older than 2.6.24

make -C /home/batman/build_test/linux-build/linux-2.6.23/ REVISION=3Dv2011.=
1.0-81-g89079ae-dirty M=3D/home/batman/batman-adv=20
PWD=3D/home/batman/batman-adv -j 1 modules
make[1]: Entering directory `/home/batman/build_test/linux-build/linux-2.6.=
23'
  CC [M]  /home/batman/batman-adv/aggregation.o
In file included from /home/batman/batman-adv/main.h:117,
                 from /home/batman/batman-adv/aggregation.c:22:
/home/batman/batman-adv/compat.h: In function =E2=80=98bat_wrapper_show=E2=
=80=99:
/home/batman/batman-adv/compat.h:112: error: dereferencing pointer to incom=
plete type
/home/batman/batman-adv/compat.h:112: warning: type defaults to =E2=80=98in=
t=E2=80=99 in declaration of =E2=80=98__mptr=E2=80=99
/home/batman/batman-adv/compat.h:112: warning: initialization from incompat=
ible pointer type
/home/batman/batman-adv/compat.h:112: error: invalid use of undefined type =
=E2=80=98struct bat_attribute=E2=80=99
/home/batman/batman-adv/compat.h:114: error: dereferencing pointer to incom=
plete type
/home/batman/batman-adv/compat.h:115: error: dereferencing pointer to incom=
plete type
/home/batman/batman-adv/compat.h: In function =E2=80=98bat_wrapper_store=E2=
=80=99:
/home/batman/batman-adv/compat.h:124: error: dereferencing pointer to incom=
plete type
/home/batman/batman-adv/compat.h:124: warning: type defaults to =E2=80=98in=
t=E2=80=99 in declaration of =E2=80=98__mptr=E2=80=99
/home/batman/batman-adv/compat.h:124: warning: initialization from incompat=
ible pointer type
/home/batman/batman-adv/compat.h:124: error: invalid use of undefined type =
=E2=80=98struct bat_attribute=E2=80=99
/home/batman/batman-adv/compat.h:126: error: dereferencing pointer to incom=
plete type
/home/batman/batman-adv/compat.h:127: error: dereferencing pointer to incom=
plete type
make[2]: *** [/home/batman/batman-adv/aggregation.o] Error 1
make[1]: *** [_module_/home/batman/batman-adv] Error 2
make[1]: Leaving directory `/home/batman/build_test/linux-build/linux-2.6.2=
3'
make: *** [all] Error 2

--nextPart652176343.xg0qq9GmUv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNvseIAAoJEF2HCgfBJntGprYP/isvklA08R1THZCr63Fv3gCy
m1A9DYqTGZWz8bACvah7gTKZMXTqVaa5bJpoSPiTct43/oqYz+1B38uXlcMdfnpa
sJZsCKhn7b2UJH4TK7GqHyw8TdRMoR1+lTCHKHKhFsibO/H7crOIq5lkvlQhZ9ey
UVtfJ/y759prDi8xawqhJwLEjfR+sYypwblnOIaCznFTTJYeKbTM7eqrmwY9fsjz
x/FwnABEPiVjKJYZmP+uNMlhl0TRa4RP0BO7emurclUvDW1B/cq1ltvu68kiZTZy
1riISiA0vSkA4ZqEA2EzwBVNUyizLz0gfLzlrmzZsY7Bm0CxxkwGj74bQCpuvCq1
L0joskz3pw5vPIjvndR/W/iIPIacSPITmzCsRvUzklVjhKsGJq9RFiXtpCkEhCfZ
fyDo0B8QLRG96x0nDSizPXZzlRN2k5BN7FnKhF7+IDve5FAcPichuYoEB6P5jXJd
MuewC+4/IzR+XLUbnbpg7BR5h+6pHPLZ0EJgcIxSfi5lJ07vHrxNT8FwXRutdIht
Lm/SnN9G53+xHePM+H57Ny7BxTupobilFCXwXCS8FcQZwBXIlJg3L+DwNGcbJpdg
EknsyTfwtIaXvp4h/pQjhJOcDufVjb4nkABikN1JXr+Wi1nhLSQaF8oY9OcaMh80
M4TbD25UEu2p+yJpGqaO
=BHQ+
-----END PGP SIGNATURE-----

--nextPart652176343.xg0qq9GmUv--
