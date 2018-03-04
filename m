Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 13:36:37 +0100
Message-ID: <3117410.redly8gohO@sven-edge>
In-Reply-To: <20180227081016.13122-2-linus.luessing@c0d3.blue>
References: <20180227081016.13122-1-linus.luessing@c0d3.blue>
 <20180227081016.13122-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1811873.XbjfWosTEp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: add multicast flags
 netlink support
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

--nextPart1811873.XbjfWosTEp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 27. Februar 2018 09:10:16 CET Linus L=FCssing wrote:
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 6eaffe50..0578c1d6 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -52,14 +52,20 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <net/addrconf.h>
> +#include <net/genetlink.h>
>  #include <net/if_inet6.h>
>  #include <net/ip.h>
>  #include <net/ipv6.h>
> +#include <net/netlink.h>
> +#include <net/sock.h>
>  #include <uapi/linux/batadv_packet.h>
> +#include <uapi/linux/batman_adv.h>
> =20
>  #include "hard-interface.h"
>  #include "hash.h"
>  #include "log.h"
> +#include "netlink.h"
> +#include "soft-interface.h"
>  #include "translation-table.h"
>  #include "tvlv.h"

Please also add #include <linux/netlink.h> for netlink_callback and NETLINK=
_CB.

Kind regards,
	Sven

--nextPart1811873.XbjfWosTEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqb6FUACgkQXYcKB8Em
e0ar3xAAxRjSj/h61oE3RcUwIlxNWblzf94zKNE6NgC9VnOwFJjHouySblAgDmw1
8E4gkarMjefzbwT+IqMwYpQsbfkXS/LrJKFSm6dJ5wn0O3cAhyqktm/2E4wKncP4
3VzzGXhk2ECFxdNx29aoXN4fLABN9zRXp+QWdaVCYASqf/tRRrJMcG69Pd21wsbH
EH7cWGcoLXMBiAmoig+Tb9iZhbLmpZOnpb98+fLP+AxwIFtqSdutrEdrDW6QazzO
me7cqo5HCEbwijdusJbfKPgRHUY8dCiOyeY0XgBYDOoPo6Hk76Tr0hipq1sOMMVK
crsbpO5yEV2ZXeKpU2Cq3IoE0vFd2M4DksRDK25BZxiGgVZRcZuoSKFdfYNAxsYR
bz0yO83r4rK+yx7HAadNvuHbqd2k5/i11Y3Yag0IsVNLqCkvf8n2IOcintFwD2r1
8ZNuWBgwIPUXTdKqGK8QEhSEJQIzNpgWe4eNC1d0XyJnPI3IVEbIzesG4NWDVI6J
FZwcn99O5d2RphwE4g87wJTQCyxtXQDzKxIQOMcYjIJ5jXy/UdscR+ddGdW7AL0l
mkdIzgFPMjuEezPZyV4bsakvR1AvMxQv+QJeBDVEpdlwTgB46GqoQmLgbFllaTRI
7tS5sEYTpiAjxSGumiSt2Mzyh4VPf84usZL82ZYaFXZfZiVVcV4=
=0d0S
-----END PGP SIGNATURE-----

--nextPart1811873.XbjfWosTEp--

