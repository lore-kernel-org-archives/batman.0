Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:07 +0200
Message-ID: <4924357.ZJSNvVin1f@sven-edge>
In-Reply-To: <1461875848-11720-5-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-5-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3849198.yrTxNSF0aF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: netlink: add
	translation table query
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

--nextPart3849198.yrTxNSF0aF
Content-Type: multipart/mixed; boundary="nextPart2158221.QS5XQXo8Tn"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2158221.QS5XQXo8Tn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:22 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> This adds the commands BATADV_CMD_GET_TRANSTABLE_LOCAL and
> BATADV_CMD_GET_TRANSTABLE_GLOBAL, which correspond to the transtable_local
> and transtable_global debugfs files.
> 
> The batadv_tt_client_flags enum is moved to the UAPI to expose it as part
> of the netlink API.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h    |  47 ++++++
>  net/batman-adv/netlink.c           |  12 ++
>  net/batman-adv/packet.h            |  36 -----
>  net/batman-adv/translation-table.c | 305
> +++++++++++++++++++++++++++++++++++++ net/batman-adv/translation-table.h | 
>  2 +
>  5 files changed, 366 insertions(+), 36 deletions(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart2158221.QS5XQXo8Tn
Content-Disposition: attachment; filename="0009-missing-includes-4.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0009-missing-includes-4.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:47:26 +0200
Subject: [PATCH] missing includes 4
=2D--
 net/batman-adv/netlink.c           | 1 +
 net/batman-adv/translation-table.c | 5 ++++-
 net/batman-adv/translation-table.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 7309f18..3fb1c1f 100644
=2D-- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -35,6 +35,7 @@
 
 #include "hard-interface.h"
 #include "soft-interface.h"
+#include "translation-table.h"
 
 struct genl_family batadv_netlink_family = {
 	.id = GENL_ID_GENERATE,
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cd3e4f2..be42b12 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -35,15 +35,18 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
=2D#include <net/net_namespace.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 6d8b5b2..7128fb3 100644
=2D-- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -23,7 +23,9 @@
 #include <linux/types.h>
 
 struct net_device;
+struct netlink_callback;
 struct seq_file;
+struct sk_buff;
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
 bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,

=2D-nextPart2158221.QS5XQXo8Tn--
This is a multi-part message in MIME format.

--nextPart2158221.QS5XQXo8Tn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:22 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> This adds the commands BATADV_CMD_GET_TRANSTABLE_LOCAL and
> BATADV_CMD_GET_TRANSTABLE_GLOBAL, which correspond to the transtable_local
> and transtable_global debugfs files.
> 
> The batadv_tt_client_flags enum is moved to the UAPI to expose it as part
> of the netlink API.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batman_adv.h    |  47 ++++++
>  net/batman-adv/netlink.c           |  12 ++
>  net/batman-adv/packet.h            |  36 -----
>  net/batman-adv/translation-table.c | 305
> +++++++++++++++++++++++++++++++++++++ net/batman-adv/translation-table.h | 
>  2 +
>  5 files changed, 366 insertions(+), 36 deletions(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart2158221.QS5XQXo8Tn
Content-Disposition: attachment; filename="0009-missing-includes-4.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0009-missing-includes-4.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:47:26 +0200
Subject: [PATCH] missing includes 4
---
 net/batman-adv/netlink.c           | 1 +
 net/batman-adv/translation-table.c | 5 ++++-
 net/batman-adv/translation-table.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 7309f18..3fb1c1f 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -35,6 +35,7 @@
 
 #include "hard-interface.h"
 #include "soft-interface.h"
+#include "translation-table.h"
 
 struct genl_family batadv_netlink_family = {
 	.id = GENL_ID_GENERATE,
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cd3e4f2..be42b12 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -35,15 +35,18 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
-#include <net/net_namespace.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 6d8b5b2..7128fb3 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -23,7 +23,9 @@
 #include <linux/types.h>
 
 struct net_device;
+struct netlink_callback;
 struct seq_file;
+struct sk_buff;
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
 bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,

--nextPart2158221.QS5XQXo8Tn--

--nextPart3849198.yrTxNSF0aF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7K7AAoJEF2HCgfBJntGAPwP/jMg1ZAcNkVfOV8UdS23amyd
teVhqCalLlBs5rsuk1Bwjm3k3SQ312dWa0TuhfRM0z+aYYU/C9Tgk7C4htNcqGYn
lW9D/H16XIbL8LYm/n4kfY2alMSHXkd3VWkkwBmYUP2Vas8CAj6xe+OkYcoviQc1
ZJSwEIJBAVuTjy9l/YF/GFhJ6WCikREt7YDiffW56Y+peg2vLshSfn2S6b74lAh3
XEkvi6Z6BdjtYswNAMkOvETQUdKP+iSD9u1lkIsMGICNJGrR0x8vC/K893ywY6wn
ApG29qCNuq3fkNlrf70ENwe71DwIc0NTWUjge43zuQ5qlQxYoZJmG/L8lEzNgEyB
tJR3Gguztk/9uSY9i9KCHk7w5eETx04TNwde+E0TmU8zrQvA9fjr38RwgNrjHlWS
jkhiknBcEWzMmjy1HIF82BPKWixCsNVUvu5pnSxiT3ptS0NB5bgnwFV1YC1bqcur
+XH/MM74ZMJ7SmhsaqFSHSHwf+uR5SIbnLTOJ/lcHQ6+m3kMgiYQvmoQQ5rGv2DA
j+ZA5BiwFYzqQ2U+zQbOK+5UbJpf9Xwi4jEXL+mEBYbLO8iOddoD0FmPDOXj7jO6
Ct37HnDA5UVThMI7Mbx8fiPbHnBIEo7KBlFGvZN080yfO6TvdBhGBSoiUKv0rYTo
WQYxQ+BtuCe7gCd4U9wV
=l4Ac
-----END PGP SIGNATURE-----

--nextPart3849198.yrTxNSF0aF--

