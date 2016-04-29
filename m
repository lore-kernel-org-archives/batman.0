Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:13 +0200
Message-ID: <9139175.SbVxbVR2Ph@sven-edge>
In-Reply-To: <1461875848-11720-7-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-7-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9880031.zObpZS1d2U";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 06/10] batman-adv: add B.A.T.M.A.N. IV
	bat_{orig, neigh}_dump implementations
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

--nextPart9880031.zObpZS1d2U
Content-Type: multipart/mixed; boundary="nextPart1694022.yG4pXGFMJO"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1694022.yG4pXGFMJO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:24 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h |   2 +
>  net/batman-adv/bat_iv_ogm.c     | 268
> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 270 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart1694022.yG4pXGFMJO
Content-Disposition: attachment; filename="0013-missing-includes-6.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0013-missing-includes-6.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:55:42 +0200
Subject: [PATCH] missing includes 6
=2D--
 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index e70560e..6659035 100644
=2D-- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -34,6 +34,7 @@
 #include <linux/kref.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/pkt_sched.h>
 #include <linux/printk.h>
 #include <linux/random.h>
@@ -47,6 +48,8 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bitarray.h"

=2D-nextPart1694022.yG4pXGFMJO--
This is a multi-part message in MIME format.

--nextPart1694022.yG4pXGFMJO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:24 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h |   2 +
>  net/batman-adv/bat_iv_ogm.c     | 268
> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 270 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart1694022.yG4pXGFMJO
Content-Disposition: attachment; filename="0013-missing-includes-6.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0013-missing-includes-6.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:55:42 +0200
Subject: [PATCH] missing includes 6
---
 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index e70560e..6659035 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -34,6 +34,7 @@
 #include <linux/kref.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/pkt_sched.h>
 #include <linux/printk.h>
 #include <linux/random.h>
@@ -47,6 +48,8 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bitarray.h"

--nextPart1694022.yG4pXGFMJO--

--nextPart9880031.zObpZS1d2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7LBAAoJEF2HCgfBJntGYpwQAJR4jhcrk3r793MySY0mQC9M
eBrQF4gAuY5G60i+ZKG97BtWAtJhHO+c62dNy8ZyPB5YxzPXoGuAG0DMf6Wf+F1O
uAgZmRVGdAO0Sm20gYz6Gr6OFfDvb0OV9BbfS6hXxQ9iFMEg9YgMZ3prIn9Un6RP
jFKVtBfumnhENbEsUHgv07OrrSNycwIM1FSkvYaOD32Mv/8MZP/lzVtKn8Uql3nc
iMHks6swchNtItq83gMV1lji2/6nLcSJOooj/MQHhzbRNG8AxKRAPu2Ai7en0MxP
vzZx1KPA/JEYcWzBAzMteq1PqkJie6j9sO3iqKXn8Sti90bEjC3a4V6ih5QWD2VO
+Q6XkXBO/Y9ftf68GVwb9FFunbw55m5i2MX8Gsel0CyPcz9nUFkI6eFXW7eLakkC
kUV7dBnpI0sYpQSQ0SucWOjsbypqpSe8d+/fCWJiuXhM+1e9E0kW3+++06kZCTag
MsMRGwwholPm59zcJZrUDit5JrwVBCJKDwNbbBM0tZML5ajKQ3WCPF4nlgrzAxfT
GBarFi/eJMkyDaqxja1INuQNBqPZiyninCYimMGd66K8gzeddz6v35jiW08NlEB7
xoZ3hwQryDnfKWjABxIneMeHUZq3VMIhnikgjfgV8aZ3A9QmoBdEjNIoGfWI666r
3biBXuAg1Zeil0czMSy6
=951C
-----END PGP SIGNATURE-----

--nextPart9880031.zObpZS1d2U--

