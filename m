Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:03 +0200
Message-ID: <10673163.SjRvAOM3uS@sven-edge>
In-Reply-To: <1461875848-11720-4-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545719.ZeE3vZlY7d";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: add generic netlink
	query API to replace debugfs files
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

--nextPart1545719.ZeE3vZlY7d
Content-Type: multipart/mixed; boundary="nextPart14769187.XhPCp6XRqi"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart14769187.XhPCp6XRqi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:21 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> debugfs is currently severely broken virtually everywhere in the kernel
> where files are dynamically added and removed (see
> http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02196.html for some
> details). In addition to that, debugfs is not namespace-aware.
> 
> Also, the debugfs interface will try to fix the whole list of originators/
> TT entries into a single buffer. The situation has improved in recent
> kernels,as the seq_file infrastructure will fall back to vmalloc now when
> kmalloc fails. Still, converting all information to text and potentially
> retrying multiple times until the buffer is big enough is very inefficient.
> 
> This commit adds generic infrastructur for the netlink interface to
> batman-adv and implements the following command:
> 
> * BATADV_CMD_GET_ROUTING_ALGOS: will return the list of supported routing
>   algorithms
> * BATADV_CMD_GET_MESH_INFO: will return basic information about a
>   batman-adv softif (name, index and MAC address for both the softif and
>   the primary hardif; routing algorithm; batman-adv version)
> * BATADV_CMD_GET_HARDIFS: will return the list of hardifs (including
>   index, name and MAC address) of all hardifs for a given softif
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  Makefile                        |   1 +
>  include/uapi/linux/batman_adv.h |  49 ++++++++
>  net/batman-adv/Makefile         |   1 +
>  net/batman-adv/main.c           |  48 ++++++++
>  net/batman-adv/main.h           |   1 +
>  net/batman-adv/netlink.c        | 251
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/netlink.h        | 
> 36 ++++++
>  7 files changed, 387 insertions(+)
>  create mode 100644 include/uapi/linux/batman_adv.h
>  create mode 100644 net/batman-adv/netlink.c
>  create mode 100644 net/batman-adv/netlink.h

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart14769187.XhPCp6XRqi
Content-Disposition: attachment; filename="0007-missing-includes-3.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0007-missing-includes-3.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:43:27 +0200
Subject: [PATCH] missing includes 3
=2D--
 net/batman-adv/main.c    |  3 +++
 net/batman-adv/main.h    |  1 +
 net/batman-adv/netlink.c | 13 +++++++++++--
 net/batman-adv/netlink.h |  5 +++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 05fc597..7b5f585 100644
=2D-- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/pkt_sched.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -46,6 +47,8 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index eddbb59..3b770df 100644
=2D-- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -191,6 +191,7 @@ enum batadv_uev_type {
 #include "types.h"
 
 struct batadv_ogm_packet;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 6682f78..e302de3 100644
=2D-- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -18,14 +18,23 @@
 #include "main.h"
 #include "netlink.h"
 
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/if_ether.h>
+#include <linux/init.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
+#include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "hard-interface.h"
=2D#include "originator.h"
 #include "soft-interface.h"
=2D#include "translation-table.h"
 
 struct genl_family batadv_netlink_family = {
 	.id = GENL_ID_GENERATE,
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 31022d4..ae0eeb9 100644
=2D-- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -18,7 +18,12 @@
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
 #define _NET_BATMAN_ADV_NETLINK_H_
 
+#include <linux/compiler.h>
+#include <linux/genetlink.h>
 #include <net/genetlink.h>
+#include <net/netlink.h>
+
+struct nlmsghdr;
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);

=2D-nextPart14769187.XhPCp6XRqi--
This is a multi-part message in MIME format.

--nextPart14769187.XhPCp6XRqi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:21 Andrew Lunn wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> debugfs is currently severely broken virtually everywhere in the kernel
> where files are dynamically added and removed (see
> http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02196.html for some
> details). In addition to that, debugfs is not namespace-aware.
> 
> Also, the debugfs interface will try to fix the whole list of originators/
> TT entries into a single buffer. The situation has improved in recent
> kernels,as the seq_file infrastructure will fall back to vmalloc now when
> kmalloc fails. Still, converting all information to text and potentially
> retrying multiple times until the buffer is big enough is very inefficient.
> 
> This commit adds generic infrastructur for the netlink interface to
> batman-adv and implements the following command:
> 
> * BATADV_CMD_GET_ROUTING_ALGOS: will return the list of supported routing
>   algorithms
> * BATADV_CMD_GET_MESH_INFO: will return basic information about a
>   batman-adv softif (name, index and MAC address for both the softif and
>   the primary hardif; routing algorithm; batman-adv version)
> * BATADV_CMD_GET_HARDIFS: will return the list of hardifs (including
>   index, name and MAC address) of all hardifs for a given softif
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  Makefile                        |   1 +
>  include/uapi/linux/batman_adv.h |  49 ++++++++
>  net/batman-adv/Makefile         |   1 +
>  net/batman-adv/main.c           |  48 ++++++++
>  net/batman-adv/main.h           |   1 +
>  net/batman-adv/netlink.c        | 251
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/netlink.h        | 
> 36 ++++++
>  7 files changed, 387 insertions(+)
>  create mode 100644 include/uapi/linux/batman_adv.h
>  create mode 100644 net/batman-adv/netlink.c
>  create mode 100644 net/batman-adv/netlink.h

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart14769187.XhPCp6XRqi
Content-Disposition: attachment; filename="0007-missing-includes-3.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0007-missing-includes-3.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:43:27 +0200
Subject: [PATCH] missing includes 3
---
 net/batman-adv/main.c    |  3 +++
 net/batman-adv/main.h    |  1 +
 net/batman-adv/netlink.c | 13 +++++++++++--
 net/batman-adv/netlink.h |  5 +++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 05fc597..7b5f585 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/pkt_sched.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -46,6 +47,8 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index eddbb59..3b770df 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -191,6 +191,7 @@ enum batadv_uev_type {
 #include "types.h"
 
 struct batadv_ogm_packet;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 6682f78..e302de3 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -18,14 +18,23 @@
 #include "main.h"
 #include "netlink.h"
 
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/if_ether.h>
+#include <linux/init.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
+#include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "hard-interface.h"
-#include "originator.h"
 #include "soft-interface.h"
-#include "translation-table.h"
 
 struct genl_family batadv_netlink_family = {
 	.id = GENL_ID_GENERATE,
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 31022d4..ae0eeb9 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -18,7 +18,12 @@
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
 #define _NET_BATMAN_ADV_NETLINK_H_
 
+#include <linux/compiler.h>
+#include <linux/genetlink.h>
 #include <net/genetlink.h>
+#include <net/netlink.h>
+
+struct nlmsghdr;
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);

--nextPart14769187.XhPCp6XRqi--

--nextPart1545719.ZeE3vZlY7d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7K3AAoJEF2HCgfBJntG7lgQAIihzr1W8c7C3ZNL1cPLitAH
hhKNvLcuTbc65vlASZqQ0tvvOkpZXQoeYLBVJLBDMWikEQFaG0n0YYuwE3TMqrkk
LPpMT3Z/i3r5OVhghsX9va4a43kHJpEuVPzf2+4laxs9IKmiFsuvsCHAt4V7a3oH
JxVzfnoOZDn7Z72GQ+rsH/f5BNunrK4xPP7PaqDrfdzFKSaV9aV1tbFCsgb4f0Nu
ynWDOMCcNLUOOW/PxVObyWe8NCSYVUU/IEMJiwk7pSOYYo/kX74JhVMFTu6mNcst
FGsCEQe8aLqH2fpxY2fcAGeU/VwFx0sqT7/YO03kPTyDVE5yEGcYjaZ5Bd45VqMM
XBtPuYCq0GggRTww00Ubx+Kuzhc956Hkw7LB2XfGvkrcpNyRyZV2maD2gxy3MGgh
EpkyZ7woBuqu7pxzjaxCh+YlyKEvvF+/JcpZeSWUNUmFfMKup9Ii+rZsG8uTYnWw
+lcEgq76yDgUyX5PqI/cQj7wLHVJHhTdMOwe8/Z9QITE5glsvw1RqR1quOHyXzMP
b3YRJ66eWy8j+KxTAWKKpL60dxlfVBMtGLdSZFyjFB5cbIZ9nYohpFyUbqBuyyhj
WjGWmfu5Z1Itq0rToEnnN8csqb92H+v21sMK2hzl3lSfCP0TlZRbpwkP+Zokzjxe
J4x8ERzKmakNFCqk1C9w
=nTxF
-----END PGP SIGNATURE-----

--nextPart1545719.ZeE3vZlY7d--

