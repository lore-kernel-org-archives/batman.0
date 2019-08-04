Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 1/2] batman-adv: BATMAN_V: introduce per hard-iface
 OGMv2 queues
Date: Sun, 04 Aug 2019 20:27:16 +0200
Message-ID: <10365865.hbHWKprCQR@sven-edge>
In-Reply-To: <20190804180632.489-2-linus.luessing@c0d3.blue>
References: <20190804180632.489-1-linus.luessing@c0d3.blue>
 <20190804180632.489-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart195619907.GGMvD3etR4";
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

--nextPart195619907.GGMvD3etR4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 4 August 2019 20:06:31 CEST Linus L=FCssing wrote:
[...]
> diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
> index fad95ef6..c33041f6 100644
> --- a/net/batman-adv/bat_v_ogm.c
> +++ b/net/batman-adv/bat_v_ogm.c
> @@ -23,6 +23,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/stddef.h>
>  #include <linux/string.h>
>  #include <linux/types.h>

Please also include the <linux/lockdep.h> for lockdep_assert_held(...)

Kind regards,
	Sven
--nextPart195619907.GGMvD3etR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1HI4QACgkQXYcKB8Em
e0bGrw/9FYmEoJ2nV0G9EkWI5Co5Jg88prauB1/p55JSXua7kxM9aQN79/mi1GGG
ckADE+tsFX6dgW60aYga6TlJpB7Ef+vYuVoFpEyMEfjcFT7j5lnhe1wkP42DhKaC
p701ssuuKmQMkmLf2W3FLLt0En3FkmWVvS9dWXN+3xj1c7gDrTEOiGk4U+AH96FH
yWI1y0A5RZqjOOwAjOOPuD2DwfaQvIVw4ChuZ1lfmCrxJdVNhrVXUcthgAmOGgy1
oncE4mH3a6OgjzlD6API0tcy+dF8tQDOZnW9kNJCjWd5bEuqQlTDVqLKa1+BbzCU
KUdZBxaZYXno0+8o3rOh+6PflPV3aF+0a/n9Xrbx9jYIbu6Xuvu/OVoDCWxb6l8Z
rMPCf8DSbU+u3LvkuCJCu5UQIMglzLQGCeuAe+o5vbR8NbNJVah+qz6MgNMatHtF
rLOQl98UAe4rD84L4Mbfpk/n4NWYAJMdl9WdvCi7BMOMAMz9V2F5VYL6j0wAA1hX
YvCbgjnylg2hjgrYhygHmDTCUS1vxvpCUlVPWorwlD9KDGYaaoRfqqioWCVluFDh
IaKfBmy4poI5K7olGt6rWEs6M6H+Ph8JEDwpDPZ49jVhNXnVvJuM9wSTTJfIwAKO
oIYJ/O3rS9ndpp5bEtSnsYHtZ81gDChnxw/BJvIpxPm1YaBszt0=
=/42/
-----END PGP SIGNATURE-----

--nextPart195619907.GGMvD3etR4--



