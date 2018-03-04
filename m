Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 13:36:30 +0100
Message-ID: <10439742.yrGnshK4dX@sven-edge>
In-Reply-To: <20180227081016.13122-1-linus.luessing@c0d3.blue>
References: <20180227081016.13122-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6108307.WkqsnKbJNM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add DAT cache netlink
 support
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

--nextPart6108307.WkqsnKbJNM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
> index 19b15de4..aca34e95 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -43,13 +43,18 @@
>  #include <linux/string.h>
>  #include <linux/workqueue.h>
>  #include <net/arp.h>
> +#include <net/genetlink.h>
> +#include <net/netlink.h>
> +#include <net/sock.h>
>  
>  #include "bridge_loop_avoidance.h"
>  #include "hard-interface.h"
>  #include "hash.h"
>  #include "log.h"
> +#include "netlink.h"
>  #include "originator.h"
>  #include "send.h"
> +#include "soft-interface.h"
>  #include "translation-table.h"
>  #include "tvlv.h"

Please also add:

* #include <linux/netlink.h> for
  - netlink_callback
  - NETLINK_CB
* #include <uapi/linux/batman_adv.h>
  - for all the new batadv genl attributes

> diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
> index e24aa960..23d11494 100644
> --- a/net/batman-adv/distributed-arp-table.h
> +++ b/net/batman-adv/distributed-arp-table.h

Please also add forward declaration for "struct netlink_callback;" (above 
"struct seq_file;").

Kind regards,
	Sven
--nextPart6108307.WkqsnKbJNM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqb6E4ACgkQXYcKB8Em
e0afHg/9F2QGOFqSl4aIsmRX91RVFBgRiXQvBGQEzSRR5JbRb+wUCgNyU2v6WJms
WM51M8GKOSGvlyFekYde62gV14yOhg1+p9ZNoUII8aZ/XGLTR7RVH2akoV3SmS3P
w0jcHnXVjXbSwIALzgD153rA7Js+ZIZCFuuJevIAt61I7iC5xprFUmIlJUta8uoP
ZrGF1VnDRZG2SNjJDwkHofdN6yjtVVD33SSBSdgJjtGe6NO22Px2ryngUvse5V5C
1eNViMNad7BDI1eJv0zwTcQHc4WnFfoP2bQ6gO2Vp+g8HCzkRi3j0fn0pWcDaf0c
sf2V2jDhCBNCrti/ME57CDeEdVC29Qttdf+uKhM1+CxTuA9QfOduJR8hAbz0eUkI
siInlxSB3vOIOhGx5UNZ/jA32w4o/wVTvngOu6W5CyVvmIHml48MtPVidWViTyMY
bmEtpPFgn+sVBeDSZNYhEOa+RpJJ74ywnMM/s5yEuTXxSVQhxUwrqokaZs+K1D2u
1ssfsqJYzJvh3Jw9kbbFJisMcVdtPissRGQWM1fmrEkpcIiGr7g5Ey2B6Js4YZLj
SLyHsGogmgaeocQs0cpP0PQYWH7Epmtde56W7aiZx4k3TmBPMl2oI+PqO5tEi+KJ
d2C7OHcUKlr/mSdGQ5YzU4pToo55lvzZFzZIVYQ1vqpzponWyH8=
=apX4
-----END PGP SIGNATURE-----

--nextPart6108307.WkqsnKbJNM--

