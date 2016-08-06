Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 19:09:56 +0200
Message-ID: <5201292.9bhKurM9NC@sven-edge>
In-Reply-To: <1470457899-14517-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470457899-14517-1-git-send-email-linus.luessing@c0d3.blue>
 <1470457899-14517-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3294883.sBBDvuX1fN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Use own timer for
	multicast TT and TVLV updates
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

--nextPart3294883.sBBDvuX1fN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 06:31:39 CEST Linus L=FCssing wrote:
> Instead of latching onto the OGM period, this patch introduces a worker
> dedicated to multicast TT and TVLV updates.
>=20
> The reasoning is, that upon roaming especially the translation table
> should be updated timely to minimize connectivity issues.
>=20
> With BATMAN V, the idea is to greatly increase the OGM interval to
> reduce overhead. Unfortunately, right now this could lead to
> a bad user experience if multicast traffic is involved.
>=20
> Therefore this patch introduces a fixed 500ms update interval for
> multicast TT entries and the multicast TVLV.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v2:
> * updated kerneldoc regarding bat_priv->mcast.mla_list "locking"
[...]
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -60,6 +60,18 @@
>  #include "translation-table.h"
>  #include "tvlv.h"

I have some minor things but maybe you could also add the missing headers:

=2D-- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -33,6 +34,7 @@
 #include <linux/in6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -48,6 +50,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <net/addrconf.h>
 #include <net/if_inet6.h>
 #include <net/ip.h>

[...]
>  /**
> + * batadv_mcast_mla_update - update the own MLAs
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Updates the own multicast listener announcements in the translation
> + * table as well as the own, announced multicast tvlv container.
> + *
> + * In the end, reschedules the work timer.
> + */
> +static void batadv_mcast_mla_update(struct work_struct *work)

There is no parameter @bat_priv. Also the description for the parameter
work is missing.

Kind regards,
	Sven
--nextPart3294883.sBBDvuX1fN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXphnkAAoJEF2HCgfBJntGlisP/16mbGDgE6DrkTueyI+LO5gJ
aMD2xpiwHtFOmcgm+24p3XAHK242zvPIGqve5/ZGRHlz5zEv2M39hCU/OcJCiA+z
ifO9VcTCBWmrjLCXGveCyqb1WYoHDl2au8Hcum0OSx79GFKWgNcMwvR42dYiuVEl
fO+DY92IP4znTKaDxMDVRm8F26++cekPw3+PQlarUVVQgNQVfGVH8wrutCNpjd+0
EpcBjShi/3rYOH3IKAswAg6v/igTgq7RnosMlw8Ac4xkKBIwX5Fzqh+j0AUAdCNJ
qrrYfRZUkviUX7cGSFUOq4luyhaFlI4zPGTDDLJMhDXN159/xmgJ1E0TssyznLu+
Y/ydmuxpo0EahpJEk9h4qHWTuIbBALQjAgN2BmgecPe9Z/BWz7eyh3ApiuLFhtO7
Lszo3s6LXmTWpjf7+936KmQMe2uVIy4MbPk3Fl25/0I5GQrT7q2nV6Ymov7vRzk/
5LGmu5pgvL/B9Erplp0KKdBqm2M3qlccUklnIl0y4id6yUOijJR5ov3nJlS52AiO
RHNS6wZnp+GctLeUdyAk1Ffo3zKn+K1qtLcJGSyLMwbHgH5AXHX6GYan5OfvebEY
j3JsOjjnaG29sm5VVmu1+Bes9vVC60LQOpLjwmmaDBIsC/Sl04lRmKde8Xc1TS1M
UvGk1EZapn7tm//DUyBQ
=Ph1r
-----END PGP SIGNATURE-----

--nextPart3294883.sBBDvuX1fN--

