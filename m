Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:15 +0200
Message-ID: <3524730.XqCTiFIBvg@sven-edge>
In-Reply-To: <1461875848-11720-8-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-8-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1518495.kZXd1bfVBd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/10] batman-adv: add B.A.T.M.A.N. V
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

--nextPart1518495.kZXd1bfVBd
Content-Type: multipart/mixed; boundary="nextPart5279766.BGegk0089z"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart5279766.BGegk0089z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:25 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h |   1 +
>  net/batman-adv/bat_v.c          | 250
> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 251 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart5279766.BGegk0089z
Content-Disposition: attachment; filename="0015-missing-includes-7.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0015-missing-includes-7.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:58:10 +0200
Subject: [PATCH] missing includes 7
=2D--
 net/batman-adv/bat_v.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 1630684..cb890b7 100644
=2D-- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -21,14 +21,19 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/cache.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bat_v_elp.h"
@@ -39,6 +44,8 @@
 #include "originator.h"
 #include "packet.h"
 
+struct sk_buff;
+
 static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 {
 	/* B.A.T.M.A.N. V does not use any queuing mechanism, therefore it can

=2D-nextPart5279766.BGegk0089z--
This is a multi-part message in MIME format.

--nextPart5279766.BGegk0089z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:25 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h |   1 +
>  net/batman-adv/bat_v.c          | 250
> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 251 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart5279766.BGegk0089z
Content-Disposition: attachment; filename="0015-missing-includes-7.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0015-missing-includes-7.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:58:10 +0200
Subject: [PATCH] missing includes 7
---
 net/batman-adv/bat_v.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 1630684..cb890b7 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -21,14 +21,19 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/cache.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bat_v_elp.h"
@@ -39,6 +44,8 @@
 #include "originator.h"
 #include "packet.h"
 
+struct sk_buff;
+
 static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 {
 	/* B.A.T.M.A.N. V does not use any queuing mechanism, therefore it can

--nextPart5279766.BGegk0089z--

--nextPart1518495.kZXd1bfVBd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7LDAAoJEF2HCgfBJntGzawP/iOJjNju6p/9NR0WRIRgIPgX
H49TRP5iOCC5QjUPB539m8KVObCk3gIPKII75b5xZLas0r96VZWdRD9YZEq4mJow
88c2lCh64feRKg+79QICcgwfKe+Ri9ZlPKBMu98HLb0VVm9gXBy/HkGtsc/IHgzi
vGGqtGyWOVrTKBoZMWeDRu6gpQHJ+JHNdJ56RRjm0KCU+cyUcvXZ6kQ22qcaYdIX
zahLCxHAAgirrBKqmgwTuUgarjb1uBpP2LWg3T42ZvgPuxTccS7KxyNSct3MkGrA
i6yOrftd+b6i8G3kVe4OJjpHExwOGhDyyBJgDUqF5LR5JwO36fEIn6dcFZIvXUaO
LLvml/a+46lbN7uipwPlwwRbrZhj2vWWG05vFAqY9ZJnVTAzNPaEoiahHJ7Owlpo
xPNN6h7svMi7ulOlNDE/HXei+9FnJadHlCBtQsxIDIAhc8EKUD9vrdue2BfFeNZn
FptO13ZtKS7aVcuwuoMloA7HBcDj+U3kTPaqvcHpUDZrcSqGRU+Swmw3gjHI8neM
oJK0ZVQ6zta1rJfXf2Vjwd1D4KBBp23gBmCXhJ2T2opgD5po7+wdtRPXK9EfDrEq
eGz7SHkF8I/cz+4YjaOkS5TgLW0V/q6bAuvlNOhZzmO7/CcCczFtdP28VUv8cBz/
Kh/UKWaOY4/WUIEEGzZw
=XRFT
-----END PGP SIGNATURE-----

--nextPart1518495.kZXd1bfVBd--

