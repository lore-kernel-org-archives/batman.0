Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: Add routeable multicast
 optimizations
Date: Sun, 05 May 2019 19:37:48 +0200
Message-ID: <12977711.pgt7cpdoR5@sven-edge>
In-Reply-To: <20190424011919.9821-1-linus.luessing@c0d3.blue>
References: <20190424011919.9821-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2792525.6IniqGzT5q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2792525.6IniqGzT5q
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 24 April 2019 03:19:13 CEST Linus L=C3=BCssing wrote:
> The following patchset fills the next gaps in the multicast address
> rules page by adding support for group-aware optimizations for
> multicast addresses of scope greater than link-local. So far, only
> link-local addresses were optimized as packets with routeable
> addresses not only need to be forwarded to local multicast listeners
> but also multicast routers.
[...]

I get a lot of build errors when trying to build these patches. Here is the=
=20
complete list, including warnings of other build tests:

Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

ecsv/pu: checkpatch ./net/batman-adv/multicast.c
=2D-----------------------------------------------

    CHECK: Blank lines aren't necessary before a close brace '}'
    #791: FILE: ./net/batman-adv/multicast.c:791:
    +
    +}
   =20
    WARNING: Block comments should align the * on each line
    #799: FILE: ./net/batman-adv/multicast.c:799:
    + * capabilities and inabilities.
    +  */
   =20
    total: 0 errors, 1 warnings, 1 checks, 2368 lines checked

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
    index ca4898d3..f106728b 100644
    --- a/net/batman-adv/multicast.c
    +++ b/net/batman-adv/multicast.c
    @@ -23,7 +23,6 @@
     #include <linux/inetdevice.h>
     #include <linux/ip.h>
     #include <linux/ipv6.h>
    -#include <linux/jiffies.h>
     #include <linux/kernel.h>
     #include <linux/kref.h>
     #include <linux/list.h>

ecsv/pu: kerneldoc ./net/batman-adv/multicast.c
=2D----------------------------------------------

    ./net/batman-adv/multicast.c:803: warning: Function parameter or member=
 'flags' not described in 'batadv_mcast_mla_flags_update'

ecsv/pu: kerneldoc ./net/batman-adv/types.h
=2D------------------------------------------

    ./net/batman-adv/types.h:1200: warning: Function parameter or member 't=
vlv_flags' not described in 'batadv_mcast_mla_flags'

ecsv/pu: kerneldoc include/uapi/linux/batadv_packet.h
=2D----------------------------------------------------

    include/uapi/linux/batadv_packet.h:124: warning: Enum value 'BATADV_MCA=
ST_WANT_ALL_RTR6' not described in enum 'batadv_mcast_flags'
    include/uapi/linux/batadv_packet.h:124: warning: Excess enum value 'BAT=
ADV_MCAST_NO_WANT_ALL_RTR6' description in 'batadv_mcast_flags'

ecsv/pu: sparse linux-3.18 cfg: BLA=3Dy DAT=3Dy DEBUGFS=3Dy DEBUG=3Dy TRACI=
NG=3Dn NC=3Dn MCAST=3Dy BATMAN_V=3Dn SYSFS=3Dn
=2D------------------------------------------------------------------------=
=2D-

    In file included from /home/build_test/build_env/tmp.2gwYBLVNdO/net/bat=
man-adv/main.h:216:0,
                     from /home/build_test/build_env/tmp.2gwYBLVNdO/net/bat=
man-adv/bat_algo.c:7:
    /home/build_test/build_env/tmp.2gwYBLVNdO/net/batman-adv/types.h:1255:1=
3: error: duplicate member =E2=80=98mla_lock=E2=80=99
      spinlock_t mla_lock;
                 ^~~~~~~~
    make[3]: *** [/home/build_test/build_env/tmp.2gwYBLVNdO/net/batman-adv/=
bat_algo.o] Error 1
    make[2]: *** [/home/build_test/build_env/tmp.2gwYBLVNdO/net/batman-adv]=
 Error 2
    make[1]: *** [_module_/home/build_test/build_env/tmp.2gwYBLVNdO] Error 2
    make: *** [all] Error 2

ecsv/pu: sparse linux-4.14.104 cfg: BLA=3Dy DAT=3Dy DEBUGFS=3Dy DEBUG=3Dn T=
RACING=3Dy NC=3Dn MCAST=3Dy BATMAN_V=3Dy SYSFS=3Dy
=2D------------------------------------------------------------------------=
=2D-

    In file included from /home/build_test/build_env/tmp.2gwYBLVNdO/net/bat=
man-adv/main.h:216:0,
                     from /home/build_test/build_env/tmp.2gwYBLVNdO/net/bat=
man-adv/bat_algo.c:7:
    /home/build_test/build_env/tmp.2gwYBLVNdO/net/batman-adv/types.h:1255:1=
3: error: duplicate member =E2=80=98mla_lock=E2=80=99
      spinlock_t mla_lock;
                 ^~~~~~~~
    make[3]: *** [/home/build_test/build_env/tmp.2gwYBLVNdO/net/batman-adv/=
bat_algo.o] Error 1
    make[2]: *** [/home/build_test/build_env/tmp.2gwYBLVNdO/net/batman-adv]=
 Error 2
    make[1]: *** [_module_/home/build_test/build_env/tmp.2gwYBLVNdO] Error 2
    make: *** [all] Error 2

Kind regards,
	Sven
--nextPart2792525.6IniqGzT5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzPH2wACgkQXYcKB8Em
e0YXhBAAqO2ctYxF3KCCq6QUwaK+42f+vlnjWr4Pznoq9z2XJm2YoIRTP8mngXWR
tOK71Xt2Zc//nW/zs9XEAhvgpzumT+5lO60qp1jkqK608S0JFQUqJeZt19Rc9oB1
Wahg5SaSY6LLRDci+XuYWwGne89vhYXM3mA5mWdo7fT4f6WIHGsIbuzE/fIvKn/5
s9Ze8szMLLV5SoQLyC+pxQumezv0OsUdye5KgdO5DM7+NhBmm7SSld4H+5mAy9zE
UAzXMFJ1yEu7EYobVJuAFMsUnUHSeCo03A8DvcJ3FJ5/8GXARmxQweF6iLnBinjK
nXOVsgNVfEUdNJQObcldMmUAn8ao8Vo5BgYW4USUwY7t6t/Jx9DmY1vcF0drCR/U
kBnNkJec9EzXten8apRpj8KHTFc9D33ljHqLSmuHZHrhX69HbgsLgDTDNRwVBiL1
sGO8xnhfMAQlllExBQCAOSw24kHcDKU6RCap7IDOySEJCkj63BhvzaOS/0kH5DEL
eqfgj1EY7NMjU2bTjrazdKWVPP7BS9XoO8jSKylO/XfXcwLLp87uLPQLTRapfY4y
bKsitTmsNNmNWX2RdF7rhm2lOLw9hET/yFMRWBn9VlHQVHxpgoj4pH6kzB8f+gih
34XvyB6P7yypnFPJtcCHNbc1kPB3Y7q6x7aMIGiFiJOpRhTabFU=
=epkD
-----END PGP SIGNATURE-----

--nextPart2792525.6IniqGzT5q--



