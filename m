Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 1 May 2010 15:28:30 +0200
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-5-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1856934.FYrazMZk8O";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005011528.33100.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: include cleanup: Update
	gfp.h and slab.h includes to prepare for breaking implicit...
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
Cc: lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart1856934.FYrazMZk8O
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> diff --git a/device.c b/device.c
> index 5f7655b..b2ecba2 100644
> --- a/device.c
> +++ b/device.c
> @@ -20,6 +20,7 @@
>   */
>=20
>  #include <linux/device.h>
> +#include <linux/slab.h>
>  #include "main.h"
>  #include "device.h"
>  #include "send.h"
> @@ -27,8 +28,6 @@
>  #include "hash.h"
>  #include "hard-interface.h"
>=20
> -#include "compat.h"
> -
>  static struct class *batman_class;
>=20
>  static int Major;	/* Major number assigned to our device driver */

Can you explain why it is here ok to remove compat.h in maint?

Best regards,
	Sven

--nextPart1856934.FYrazMZk8O
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3Cx/AAoJEF2HCgfBJntGWgYP/R7YOFNe1n3Vl7Ll94Tae+1W
nACEPxZhArx8WQ8NXRzSkrh4igHaoMEOHJDywOFW3wX6l1fGXU1WiervuG1ZGxiH
CoH5kHcM5QHXyO7pwt1k7TIRNAg/Ce9LktODjJFugzvkL4ekdYp7abeFSPGLX6o5
ZgTtYxhKOHbuXWsxtw3kymOhZsk7ywFEmhlPunRB4KGx8PAiW68GnSrPWpyGf8kP
aYYPj24F3k7wJWV2Ugw/v8wh0YcikDclAio6HfvQawGkV/JXbW7+ZS67a/agVLvL
pDWqVTRB3z64m62EnXRCrgTyPsYOwfwsNNpl5JmOyGrdAQqkZJ6/I2CMZVpWqrDQ
JxeQiIpFzG/ZvXgZwc8FodMmeXdlIY34YP0xVPjPHttNpUaVWPl7QWAQ68R2DGTR
RCGh0RDTILNqSQK/+WL6nyRvNO1Gu9NvMqQhn8+n5sUI0DalTEgGRLIVKucGiMGI
J+T/VHyOWkPbVR2cVujwZNAoAi6AhysNV51ThRRFH/+OOV6celYlUCdbjPr9c+Rj
BinPpsZeRRYHknEJXtGGl3hBS86Kiz9ApyFyT0hbTEn8yUPmrNhL3rJswF+Fo5+5
t77JQNgYjhtAz2dlUdS4WgmRnyLfUsx8up0r8pVZk/5AKrZCzjNdoQ+I/2XOvQW3
Ir+K6gofgUztISRx8vLu
=grwf
-----END PGP SIGNATURE-----

--nextPart1856934.FYrazMZk8O--
