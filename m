Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:10 +0200
Message-ID: <1946034.2sgYLFZ0kQ@sven-edge>
In-Reply-To: <1461875848-11720-6-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-6-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart30459385.8mQ02RaHCd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 05/10] batman-adv: netlink: add
	originator and neighbor table queries
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

--nextPart30459385.8mQ02RaHCd
Content-Type: multipart/mixed; boundary="nextPart1642747.pOJncRhBeP"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1642747.pOJncRhBeP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:23 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Add BATADV_CMD_GET_ORIGINATORS and BATADV_CMD_GET_NEIGHBORS commands,
> using handlers bat_orig_dump and bat_neigh_dump in batadv_algo_ops. Will
> always return -EOPNOTSUPP for now, as no implementations exist yet.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h |   2 +
>  net/batman-adv/netlink.c        |  13 ++++
>  net/batman-adv/originator.c     | 142
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/originator.h     | 
>  2 +
>  net/batman-adv/types.h          |   7 ++
>  5 files changed, 166 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart1642747.pOJncRhBeP
Content-Disposition: attachment; filename="0011-missing-includes-5.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0011-missing-includes-5.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:51:44 +0200
Subject: [PATCH] missing includes 5
=2D--
 net/batman-adv/netlink.c    | 1 +
 net/batman-adv/originator.c | 2 ++
 net/batman-adv/originator.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1d7dc27..a01bdf5 100644
=2D-- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -33,6 +33,7 @@
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "originator.h"
 #include "hard-interface.h"
 #include "soft-interface.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3e053e1..d2ccbf3 100644
=2D-- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -28,8 +28,10 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index a8eb520..5c932d5 100644
=2D-- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -31,7 +31,9 @@
 
 #include "hash.h"
 
+struct netlink_callback;
 struct seq_file;
+struct sk_buff;
 
 bool batadv_compare_orig(const struct hlist_node *node, const void *data2);
 int batadv_originator_init(struct batadv_priv *bat_priv);

=2D-nextPart1642747.pOJncRhBeP--
This is a multi-part message in MIME format.

--nextPart1642747.pOJncRhBeP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:23 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Add BATADV_CMD_GET_ORIGINATORS and BATADV_CMD_GET_NEIGHBORS commands,
> using handlers bat_orig_dump and bat_neigh_dump in batadv_algo_ops. Will
> always return -EOPNOTSUPP for now, as no implementations exist yet.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h |   2 +
>  net/batman-adv/netlink.c        |  13 ++++
>  net/batman-adv/originator.c     | 142
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/originator.h     | 
>  2 +
>  net/batman-adv/types.h          |   7 ++
>  5 files changed, 166 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart1642747.pOJncRhBeP
Content-Disposition: attachment; filename="0011-missing-includes-5.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0011-missing-includes-5.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:51:44 +0200
Subject: [PATCH] missing includes 5
---
 net/batman-adv/netlink.c    | 1 +
 net/batman-adv/originator.c | 2 ++
 net/batman-adv/originator.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1d7dc27..a01bdf5 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -33,6 +33,7 @@
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "originator.h"
 #include "hard-interface.h"
 #include "soft-interface.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3e053e1..d2ccbf3 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -28,8 +28,10 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index a8eb520..5c932d5 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -31,7 +31,9 @@
 
 #include "hash.h"
 
+struct netlink_callback;
 struct seq_file;
+struct sk_buff;
 
 bool batadv_compare_orig(const struct hlist_node *node, const void *data2);
 int batadv_originator_init(struct batadv_priv *bat_priv);

--nextPart1642747.pOJncRhBeP--

--nextPart30459385.8mQ02RaHCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7K+AAoJEF2HCgfBJntGxwIQAI5S7chuEyu60+F3K+rzC5pN
WGaJcdpwSsZyqXk/P+kGuFLhzo5oeuJFfO/bUO7jpyqv84/Lz+39x38/Vpgt4Fy9
6mWKWEgzJW5QdYFVfD4t21Yc5t6wEWCejWJGzn1VG/bGWCbSZwBViintyapMYdSC
t4pvsn/p9a4lpxlXV/4gRbfdwsQiS6mwlz0Sxy4XNuEnZxdIuZZ6XJqqwUIe/ECZ
easd/8nYQp6Zzot3XL+3ZdeMjECq6YVRNVnvo8EQybJmVBHyTTCE8NeFgZcaTS2s
b/v2hQ8njpz+LXceqrzOOym5NH+oAWr1qH10noLNf/lRhsv2gpXorVwIwS8kFFgN
RSHW6sck0UPvCz/3FEoiZiH2jwIWQ4RUNwr/t4hmODdus50zcmgHYH27AxwBmN6E
DMV4gIktfS5FuNEiz33WV4qPcE9Rc35JFyN674XbGShSo68cCMCABOawttDzz+7T
E/k0qKY4wB0gt/PTf5GT+sQFZe7rwZYXyZaLNpuXcCl2HUq4X4KP1ivS7ECOHoWE
S3ZncqFhwLjv32STsY/I1UZam8NCY8lZO9sJu3FJijIWICjBRZrvTXLTvWDDqsG1
Thq4LkBVtEJmmei/d/TFYhpw0Gk2ZMfJ4CQxAHU6IbJAVu3ACcdzVGN6qbv6AvAC
G5Ln7G5fTJFffXJ7B0Rr
=HGCX
-----END PGP SIGNATURE-----

--nextPart30459385.8mQ02RaHCd--

