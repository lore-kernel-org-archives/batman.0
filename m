Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:14:52 +0200
Message-ID: <1996426.1KP8lIW3md@sven-edge>
In-Reply-To: <1461875848-11720-2-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2126879.j2ZDeBCukE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Handle parent
	interfaces in a different netns
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

--nextPart2126879.j2ZDeBCukE
Content-Type: multipart/mixed; boundary="nextPart2322509.dKPzMjGbIz"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2322509.dKPzMjGbIz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:19 Andrew Lunn wrote:
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> namespace, so also retrieve the parents name space when finding the
> parent and use it when doing the comparison.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@untable.cc>
> ---
>  net/batman-adv/hard-interface.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart2322509.dKPzMjGbIz
Content-Disposition: attachment; filename="0002-missing-includes-1.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-missing-includes-1.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:26:24 +0200
Subject: [PATCH] missing includes 1
=2D--
 net/batman-adv/hard-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index e0cd7ce..2dfbb84 100644
=2D-- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -36,6 +36,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <net/net_namespace.h>
+#include <net/rtnetlink.h>
 
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"

=2D-nextPart2322509.dKPzMjGbIz--
This is a multi-part message in MIME format.

--nextPart2322509.dKPzMjGbIz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:19 Andrew Lunn wrote:
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> namespace, so also retrieve the parents name space when finding the
> parent and use it when doing the comparison.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@untable.cc>
> ---
>  net/batman-adv/hard-interface.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart2322509.dKPzMjGbIz
Content-Disposition: attachment; filename="0002-missing-includes-1.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-missing-includes-1.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:26:24 +0200
Subject: [PATCH] missing includes 1
---
 net/batman-adv/hard-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index e0cd7ce..2dfbb84 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -36,6 +36,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <net/net_namespace.h>
+#include <net/rtnetlink.h>
 
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"

--nextPart2322509.dKPzMjGbIz--

--nextPart2126879.j2ZDeBCukE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7KsAAoJEF2HCgfBJntGc+AP+gO2cDskGCkIfgFjmajjtiCD
4YZI0XuHmNtWl15y6Ja5Q6FxWsFp/MLiISvAJg2He1QaCCn1C8MPjnbb6iu2vrxL
hA3iRNhdygdq85FqeGQ9TEFI7tBXvJ/oJwY9P3U1qf79MWuTDYPA8xOxjNst7RaH
bJMV9bz1P9Kaw5QK3yePiAPKEl+89UYsbFwtjpzVGPQIHeK2bZbsumTBGzYT4Cj0
KjFwCuuCoobA0xcL0gv499rEtLs03CqKvdF0w9b13hm82ByEiqO51yduciu11Axd
4549WcE6rgYfi3Vfr2MVzW0REGLaIolDUX7ki02iDA6SOSmrGa7rj0WlHLhc7HZb
Hh8ZeOECW3vCp/rI4aZDuWmiH+0M0+PrS0eI+nU08CuOwXATZzY33s/gFMluJsL/
f39YQeghYbMkaAx7JTYbqADKavvijYESRqIQWQb4p/4bBDogBaPBODq16AVQ5m+p
jCVMh6yddRrFe3lcZe1qZ0hoEOps0rcyYz09HSjFXDwKeppX7eG+IcbIYT1ZKVRM
5ou+Gmpxfzw+LPiePRvybzE6Vi//AiFxSrwBBDGyPCRSstcpZUAJuj1R8DV25dZ0
NHcOk0NwGTBU1x7zTZRRGc6dPXAafxc8L93C0PJH7EsGz32qedbrikfgv4m1Zx4E
7mcasnyqI40HmfVQdgax
=mC5o
-----END PGP SIGNATURE-----

--nextPart2126879.j2ZDeBCukE--

