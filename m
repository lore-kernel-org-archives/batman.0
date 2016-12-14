Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 20:23:19 +0100
Message-ID: <2848761.xHKJYXNK64@sven-edge>
In-Reply-To: <7229903.vTJUiGXDOz@sven-edge>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-2-linus.luessing@c0d3.blue>
 <7229903.vTJUiGXDOz@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1664011.mWJRuPNqyh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Keep hard interface
	neighbor list sorted
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

--nextPart1664011.mWJRuPNqyh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 14. Dezember 2016 19:48:19 CET Sven Eckelmann wrote:
> On Donnerstag, 6. Oktober 2016 08:41:38 CET Linus L=FCssing wrote:
> > +               hlist_add_behind_rcu(&hardif_neigh->list, &pre_neigh->l=
ist);
>=20
> Compat code is missing for this function
>=20
> ecsv/pu: sparse linux-3.16 cfg: BLA=3Dn DAT=3Dn DEBUGFS=3Dy DEBUG=3Dy NC=
=3Dn MCAST=3Dn BATMAN_V=3Dy
> -------------------------------------------------------------------------=
=2D-
>=20
>     /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/bat_v_=
elp.c:96:9: warning: Variable length array is used.
>     /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/origin=
ator.c:594:17: error: undefined identifier 'hlist_add_behind_rcu'
>     /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/origin=
ator.c: In function 'batadv_hardif_neigh_create':
>     /home/build_test/build_env/tmp.YwQkM10Q6k/build/net/batman-adv/origin=
ator.c:594:3: error: implicit declaration of function 'hlist_add_behind_rcu=
' [-Werror=3Dimplicit-function-declaration]
>        hlist_add_behind_rcu(&hardif_neigh->list, &pre_neigh->list);

I have now added the compat code together with some include fixes to ecsv/pu

    diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rcul=
ist.h
    index d432bc65..3c7ae76b 100644
    --- a/compat-include/linux/rculist.h
    +++ b/compat-include/linux/rculist.h
    @@ -36,4 +36,10 @@
    =20
     #endif
    =20
    +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
    +
    +#define hlist_add_behind_rcu(n, prev) hlist_add_after_rcu(prev, n)
    +
    +#endif /* < KERNEL_VERSION(3, 17, 0) */
    +
     #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_ */
    diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
    index 712bd428..a69614f5 100644
    --- a/net/batman-adv/bat_v_elp.c
    +++ b/net/batman-adv/bat_v_elp.c
    @@ -19,10 +19,10 @@
     #include "main.h"
    =20
     #include <crypto/hash.h>
    -#include <crypto/sha.h>
     #include <linux/atomic.h>
    +#include <linux/bug.h>
     #include <linux/byteorder/generic.h>
    -#include <linux/err.h>
    +#include <linux/device.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/ethtool.h>

Kind regards,
	Sven

--nextPart1664011.mWJRuPNqyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRnCcACgkQXYcKB8Em
e0Z5QhAAzffxSWSqrlOSg06kz+VzIgrFWKU7WewzFmSPQnMfs9Er7HAa6hhyXE3I
2h/tlRp1y2uf9JBVizgrNTUabw6r+cT9+5AE1Xd2Z9RfFmwPs5YMjWefx2TteGBn
ppvWzctzu/LWrY/92UZsoHtJaRXZK5EDnI2z33BLXtD3zH1hUp1QYb0v6dBGRUVb
/SmLKs66GOutdRcfXMGsLm2B0nsV6gaiZn+am0z1ujdfPSSPnis0ZUaIlsFJ9U9j
MHlZx7mVDFwTrzV0wOU5XCb+rHBcnLOEFmbe/XMQqNcjoLUS09u0KphcylhokZyi
K/qW6sDSZTI16TwJqqzNnhBTIRDOEL20MqhxO+NJYEKOV/3+soJ2DQBf8TdcL1HI
3e9R7p9FXVY/MuuRXWZhKMtq/OqDszgqsdtYV46ttqdF4gb9eA7+cpLaLvmg/zNW
G5c+S7IsBGnZxVmpoTBAUnnYPO6IMdn/biUsc5aJaXe8CAkT7ec1tN9t4TJT1OLz
zG0Hyn6IwwQt9djNxC6b8cO68XIMvzOp2P0UC8JsYGuqLpp0e3hnVlX5KzT9X9xE
GlX5UQlhjozcKeJymHWGrIeRD5FFBeboRwK+oa28/dn11O09tTUwPyDj9JYSJpyH
BYSSLJHag+5LjRL/jTKORsSg9uqMEG867dVGp8k51uYC5P+EdvQ=
=ulXn
-----END PGP SIGNATURE-----

--nextPart1664011.mWJRuPNqyh--

