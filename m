Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 May 2016 18:45:45 +0200
Message-ID: <1498708.bHHSHfNHLf@bentobox>
In-Reply-To: <1463034697-8867-2-git-send-email-apape@phoenixcontact.com>
References: <1463034697-8867-1-git-send-email-apape@phoenixcontact.com>
 <1463034697-8867-2-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1721976.Gxs8BP1121";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 1/6] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enbled
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

--nextPart1721976.Gxs8BP1121
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -48,6 +48,7 @@
>  #include "originator.h"
>  #include "send.h"
>  #include "translation-table.h"
> +#include "bridge_loop_avoidance.h"

Please try to keep the includes in alphabetical order like this:

+#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "originator.h"
 #include "send.h"
 #include "translation-table.h"

Maybe Marek can also do this when he wants to apply it (in case 
Simon/Marek/... don't find anything else problematic in the patchset)


Kind regards,
	Sven
--nextPart1721976.Gxs8BP1121
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXNgS5AAoJEF2HCgfBJntGEesP/iChnn6BeHXt2SIXAgNHM8Us
VkFYBaOV9y5LwCqi5MUpoIPZHnIWuhj5bX0bOcQDwqpzgw95Xu2KG9SrvO7sLX2q
Tb7MSWU1lb3oCPNiaeT+kAFc6ZpDyuqEZbtLnCvWBzseIxaSPb0QBkHS1gDrnS1P
NCdKmV8MxtBTo1XFqnTZztV/vUUWoN/KR3PBRwecEhKC3qwHx1XbB00eU0xP4vjt
Fzi1PcUOBG/EabbzEgIFiO+Zer1rso0dLJPg1mbE4s5rF295EaBUqzElO7m/NsgG
Zpfiw5I16llfdTnDNsaFOHctzerARftBG4YX81HSPNGP1iOTlEEpAhmeYLI4a4xt
oofDgnfsDp+rjFqudSBoK6iMinEkyrrkHBBRkux1Qe7AEyGDOd4xIUsL9CIFh3nS
JGCFiq5N3H1/CCIzFQXQq9tQTz1i4Ccxlrqsqz2Kqe6dOIqhYfdiBNdDbEbTJ7z+
pv7S/u8PbZeORQAqQ7iV+KKGs6pRj4IDnwN3qboUH15ERVzx2j9u8ycEwRC4//a8
WfeaPSh+No8wMUZBmhOmzk+QNothJOPZcC/S9V1arNBlzKb6cc03/5QizCOdlIFN
Q7ifDFDmslsq2bWZGQsV38p0cBUhuwLwCWtRy+QvNARpsde6o24dUWATRl/aGadk
UGvL6Xvj9yLi+D+qCEXt
=1yq+
-----END PGP SIGNATURE-----

--nextPart1721976.Gxs8BP1121--

