Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:14:59 +0200
Message-ID: <6196676.aNASJDfWgs@sven-edge>
In-Reply-To: <1461875848-11720-3-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4556326.k5zWH3hlhr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: Suppress debugfs
	entries for netns's
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

--nextPart4556326.k5zWH3hlhr
Content-Type: multipart/mixed; boundary="nextPart2133075.52soJF7hlr"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2133075.52soJF7hlr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:20 Andrew Lunn wrote:
> Debugfs is not netns aware. It thus has problems when the same
> interface name exists in multiple network name spaces.
> 
> Work around this by not creating entries for interfaces in name spaces
> other than the default name space. This means meshes in network
> namespaces cannot be managed via debugfs, but there will soon be a
> netlink interface which is netns aware.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/debugfs.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart2133075.52soJF7hlr
Content-Disposition: attachment; filename="0005-missing-includes-2.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0005-missing-includes-2.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:29:25 +0200
Subject: [PATCH] missing includes 2
=2D--
 net/batman-adv/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 4a43ee1..e54f0da 100644
=2D-- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -42,6 +42,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
+#include <net/net_namespace.h>
 #include <stdarg.h>
 
 #include "bridge_loop_avoidance.h"

=2D-nextPart2133075.52soJF7hlr--
This is a multi-part message in MIME format.

--nextPart2133075.52soJF7hlr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:20 Andrew Lunn wrote:
> Debugfs is not netns aware. It thus has problems when the same
> interface name exists in multiple network name spaces.
> 
> Work around this by not creating entries for interfaces in name spaces
> other than the default name space. This means meshes in network
> namespaces cannot be managed via debugfs, but there will soon be a
> netlink interface which is netns aware.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/debugfs.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart2133075.52soJF7hlr
Content-Disposition: attachment; filename="0005-missing-includes-2.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0005-missing-includes-2.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:29:25 +0200
Subject: [PATCH] missing includes 2
---
 net/batman-adv/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 4a43ee1..e54f0da 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -42,6 +42,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
+#include <net/net_namespace.h>
 #include <stdarg.h>
 
 #include "bridge_loop_avoidance.h"

--nextPart2133075.52soJF7hlr--

--nextPart4556326.k5zWH3hlhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7KzAAoJEF2HCgfBJntGuesQAMHmyFyeWfdkb8mvG9A/5Aa1
snlSpn+CLKN9dDMDOaogpE68/0KhzvMw/YP9WbYY3JHOFOx26wYKRoTfOWbYAS7m
CrszfhvhvK0tg7eApvAOA7TxYPCcotgmGN/zOizFr3m2DDHqA0ubyzS/nLgvP29y
tTyMazeVsQllzSYCWtG/j0kQFoAx3tnnBxduxhcfNgAWDfQl3kJqQC+norMiUITM
PNPp4BSk0n+lpdIWGYrYuOKS0ck4yNQNmKxB85iI4mmv6cZDY/U5vsxhzw7TDpZW
4PU8UoCVB2Jhl1rcgFkfLbN+auXb2Jx/8ur0Vw7dh4+7fifAXVr2VZTu/42kaSJ9
TDZ9MHpTqG2zM8Nupu1+p6EPjvUz5A5bvzmfId6eaFv21kHIxG4SwAXapFCZ4WBZ
NyoY4kEWfdi92ZokKYEIadka9bwZ4j85faUORoemnzerXDxxkABe7W7HIFWb3rhE
Vtc/+NHeLlAcKSHTFy+0q4PMt5+I/ONh/Xsmr12RLGyY5iWNTKmUEi1P8Ls7jTAM
tqlJlpJenlFhjOQf2locQE/V5b9qM7NBRzpqzypIaVTa41G4FEypfE1+0Mcjlnw0
RAxh55GDrwqJZEy3eubsFpSejzeAu+rZPhqkgsXt3dQKrzRk6KkGnNVAFxLHB1+4
qyvcP97lkLgkXN+4bU5S
=NldJ
-----END PGP SIGNATURE-----

--nextPart4556326.k5zWH3hlhr--

