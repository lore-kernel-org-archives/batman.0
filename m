Return-Path: <antonio@meshcoding.com>
Message-ID: <549EC29D.1070408@meshcoding.com>
Date: Sat, 27 Dec 2014 15:30:53 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DBLduExj3Wm9vrIDqEib6J55N3OoCdwFx"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBLduExj3Wm9vrIDqEib6J55N3OoCdwFx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Markus,

first of all you should know that I really appreciate your hard work.
Thank you very much for this!

On 26/12/14 12:41, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  packet.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/packet.h b/packet.h
> index facd1feddd4e..5fd0d814b6de 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -18,6 +18,11 @@
>  #ifndef _NET_BATMAN_ADV_PACKET_H_
>  #define _NET_BATMAN_ADV_PACKET_H_
> =20
> +#ifdef __KERNEL__
> +#include <linux/bitops.h>
> +#include <uapi/linux/if_ether.h>
> +#endif /* __KERNEL__ */

Unfortunately we can't do this :-(

Patches sent to the kernel cannot contain conditional code on being in
the kernel or not (same is true for checks against a particular kernel
version - such code can't be in the kernel).

Patches sent to the kernel must assume that they are only for the kernel
(and for that particular version we are sending the patches against).

Of course this makes everything a bit trickier for us since we share
files between kernel and userspace .....

This is one of the reasons why we have compat.c/h in the batman-adv
package: you will see that in those files we had to implement all sort
of hackish/dirty tricks in order to keep the code in the other files
clean (compat.h/c are not sent to the kernel but are part of the
batman-adv out-of-the-tree package).


However, as far as I know, you should be able to simply do:

#include <linux/if_ether.h> (without the uapi subfolder)

and this should happily work for both the kernel and the userspace. Have
you tried that? I might be wrong - it's quite some time I haven't used
uapi headers.


Otherwise we might need to find a different solution - or live we what
we have now :)

Cheers,


> +
>  /**
>   * enum batadv_packettype - types for batman-adv encapsulated packets
>   * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
>=20

--=20
Antonio Quartulli


--DBLduExj3Wm9vrIDqEib6J55N3OoCdwFx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUnsKgAAoJEJgn97Bh2u9em84QALZepDxQO9A/L1qS+uCQP+jQ
EopAKZ7V+9LjSCYdR972ScgwFVJuvbIEvA6t3XPJ/PmLAnHpRgABDCmlV5mCI5bE
iuCjgbFyENj2FnLIpGs7XGL1qdaGQ1RMT0CijiECISoA5aQtxx+semfrTylzmvrA
2SMdxFOWm9Wg937GTy1RoybijjrSRRbyAXbQT81bnkZzf+7VHCk1A9pXxnZNjvD9
fha37368R3/koLXcMW3qM0AhOe4Yzwlhlcb1O0vyo+Myq4PQPH2R9+Tx2fyEHWOY
viymGpA9Do6Rp4Ua+aaPdWyixQTcYEuryEHHRb/gxZSyo9ZVsV+BOZvVZH5eu9Eg
ozgnTmpC/p3UITtOL5GsZiqZswQLbwVrzaLrmG3EUHb0ay3UwAaaj4wJu3e2QwRj
UhUQMX9qU59ZP0vWym8jWahquP1mrCgnC2wb1lvXMBpXxR1hrSdt9+EDTpoOhfgZ
W7dqdqwE4vl0YNYChqgT4sisVXWHTxwfKDQ0W3pnHkgNmVjaLgZBWe3hKMdYdNRN
Qv89SA8L77Bw2tMftPKUFynaoeVWTtUeAe2FYipf4ARDFmvLtX/4ximhK5iIYeNx
4JynxkhMWHjsMtNT/B8MCshof16FAyT7FFPT2G4WxDP+Wpuu+1I87FBePK9L41uA
Ig0nTMRdJbEzOubzlMKo
=rmNP
-----END PGP SIGNATURE-----

--DBLduExj3Wm9vrIDqEib6J55N3OoCdwFx--
