Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 19:42:09 +0200
Message-ID: <1646180.Hz16yHrbtt@sven-edge>
In-Reply-To: <1463414932-1152-1-git-send-email-andrew@lunn.ch>
References: <1463414932-1152-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1599508.bf2qfdCS5z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 00/11] netns and netlink support
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

--nextPart1599508.bf2qfdCS5z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 18:08:41 Andrew Lunn wrote:
> * Complete all the kerneldoc cut/paste work requested by Sven.

Hihi, thank you :)

It would have been nice when you would also have added a comment about =
all the=20
other changes. I've noticed:

 * added missing attribute BATADV_ATTR_THROUGHPUT to the policy (thanks=
)
 * batadv_netlink_get_ifindex was moved from netlink.h to netlink.c

here some more detailed things (not really relevant)

 * added originator.h to the wrong place in netlink.c
 * some different line breaks in  batadv_iv_ogm_neigh_dump_neigh
   ("genlmsg_put(msg, portid, seq, ....").
 * similar changes was done in batadv_algo_dump_entry
 * extra linebreak in batadv_netlink_dump_hardifs for
   batadv_netlink_get_ifindex
 * extra linebreak in batadv_tt_local_dump_entry for genlmsg_put
 * extra linebreak in batadv_tt_global_dump_subentry for genlmsg_put


Name of failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * bracket_align ecsv/netlink ./net/batman-adv/bat_iv_ogm.c
 * headers ecsv/netlink

Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

bracket_align ecsv/netlink ./net/batman-adv/bat_iv_ogm.c
=2D-------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bat_iv_ogm.c:2375, was 37=
 but expected 61
    Found wrong alignment at ./net/batman-adv/bat_iv_ogm.c:2376, was 37=
 but expected 61


headers ecsv/netlink
=2D-------------------

    diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
    index 25fd4be..c5e6db5 100644
    --- a/net/batman-adv/bat_v.c
    +++ b/net/batman-adv/bat_v.c
    @@ -19,9 +19,9 @@
     #include "main.h"
    =20
     #include <linux/bug.h>
    +#include <linux/cache.h>
     #include <linux/errno.h>
     #include <linux/if_ether.h>
    -#include <linux/cache.h>
     #include <linux/init.h>
     #include <linux/jiffies.h>
     #include <linux/netdevice.h>
    diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
    index 949a048..e0fd914 100644
    --- a/net/batman-adv/netlink.c
    +++ b/net/batman-adv/netlink.c
    @@ -36,10 +36,10 @@
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    =20
    -#include "originator.h"
     #include "bridge_loop_avoidance.h"
     #include "gateway_client.h"
     #include "hard-interface.h"
    +#include "originator.h"
     #include "soft-interface.h"
     #include "translation-table.h"
    =20
    diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
    index ef861db..fac7d91 100644
    --- a/net/batman-adv/netlink.h
    +++ b/net/batman-adv/netlink.h
    @@ -18,12 +18,9 @@
     #ifndef _NET_BATMAN_ADV_NETLINK_H_
     #define _NET_BATMAN_ADV_NETLINK_H_
    =20
     #include "main.h"
    =20
    -#include <linux/compiler.h>
    -#include <linux/genetlink.h>
     #include <net/genetlink.h>
    -#include <net/netlink.h>
    =20
     struct nlmsghdr;
--nextPart1599508.bf2qfdCS5z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOgZxAAoJEF2HCgfBJntGI1YQAJGjdH4NwmEhp+mIKeL3eRc/
LUXOZvqJzGlal3M7fKM0L2Q8vOiLa7rHEDeFRObJT7xJl63GEtGBO4FuUncyCYD6
wpDGIxq9mO0nPYQlJQgQhNfLVMrEU/iGXWLYdqnsXro1fzCnvM2/CGl0IXAJ/ps1
OBaKO6UgyfLD/9P5held+tsI9X+3z8VwpJM1RCFavZt3yUIAa9bDQoAP1Y/X9Dwf
Te076QyKuKij0Yb/hZ/Fw+iQesSzL9JKQkz8PxosXNpcFw9clTGcuftLV7DJy9d+
BqbEUU1MKbdY5SYrSv4dULyXlg9xj5SZ16GHi4WRh3tcwNBD5cD2Eo/WMTvVjUd8
aGv0AlLZF7c8bxqzMIq25Zu5ZU1fW5VygaB4N4SykCPPUoe7hKo9aSYmZwFHLTGu
Dr+pbx5PNo56guBQ6qtvxd7k/14FDc3RX2P171qdppCzCj12j1XQzJXcHeVBFe7X
0gz0P0Fl195jUJ8gYQ9f6crnhGo0IibmF8fviwQDnIkEGDbjykjZuW/6EBMJs/xx
BhKjx/f4nVTexopSsfVnHd7M8aqmRlQZmKn+ai42vJYO+nFQisgQM21BxS38vWk7
ZO0iuuW3YnX3P9DTh8o3cpSwen3DivliRXX1OTkxHgbQnEJa13G8rXBInXopl8qv
2aCnH7xDQs0F6fVWD59Z
=46qM
-----END PGP SIGNATURE-----

--nextPart1599508.bf2qfdCS5z--

