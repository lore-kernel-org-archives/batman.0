Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Tue,  5 Dec 2017 15:35:10 +0100
Message-Id: <20171205143514.4441-3-sven.eckelmann@openmesh.com>
In-Reply-To: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@openmesh.com>

This file contains the relevant information to let userspace communicate
with batman-adv over generic netlink. The relevant genl enums for the
attributes and commands have the prefix batadv_genl. Renaming this file to
this name therefore represents the content better and avoids confusion with
the file which will contain the packet format definitions.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 MAINTAINERS                                        | 2 +-
 include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---
 net/batman-adv/bat_algo.c                          | 2 +-
 net/batman-adv/bat_iv_ogm.c                        | 2 +-
 net/batman-adv/bat_v.c                             | 2 +-
 net/batman-adv/bridge_loop_avoidance.c             | 2 +-
 net/batman-adv/gateway_client.c                    | 2 +-
 net/batman-adv/main.c                              | 2 +-
 net/batman-adv/netlink.c                           | 2 +-
 net/batman-adv/originator.c                        | 2 +-
 net/batman-adv/tp_meter.c                          | 2 +-
 net/batman-adv/translation-table.c                 | 2 +-
 net/batman-adv/types.h                             | 2 +-
 13 files changed, 15 insertions(+), 15 deletions(-)
 rename include/uapi/linux/{batman_adv.h => batadv_genl.h} (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..68abe39ee87a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2563,7 +2563,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.rst
-F:	include/uapi/linux/batman_adv.h
+F:	include/uapi/linux/batadv_genl.h
 F:	net/batman-adv/
 
 BAYCOM/HDLCDRV DRIVERS FOR AX.25
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batadv_genl.h
similarity index 98%
rename from include/uapi/linux/batman_adv.h
rename to include/uapi/linux/batadv_genl.h
index a0fed6c01a46..8ed28676e198 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batadv_genl.h
@@ -22,8 +22,8 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef _UAPI_LINUX_BATMAN_ADV_H_
-#define _UAPI_LINUX_BATMAN_ADV_H_
+#ifndef _UAPI_LINUX_BATADV_GENL_H_
+#define _UAPI_LINUX_BATADV_GENL_H_
 
 #define BATADV_GENL_NAME "batadv"
 
@@ -423,4 +423,4 @@ enum batadv_tp_meter_reason {
 	BATADV_TP_REASON_TOO_MANY		= 133,
 };
 
-#endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
+#endif /* _UAPI_LINUX_BATADV_GENL_H_ */
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 37390a21e5e9..07392a25235f 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -31,7 +31,7 @@
 #include <linux/string.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
 #include "netlink.h"
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4055338de7f0..7727a39c4265 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -54,7 +54,7 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
 #include "bitarray.h"
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 7eea24204b55..b43ba53daafd 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -39,7 +39,7 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
 #include "bat_v_elp.h"
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 15d64a575034..1a9594d68db2 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -52,7 +52,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "hard-interface.h"
 #include "hash.h"
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 5e2d00731e9f..23c8032ce478 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -45,7 +45,7 @@
 #include <linux/stddef.h>
 #include <linux/udp.h>
 #include <net/sock.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "gateway_common.h"
 #include "hard-interface.h"
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a56ae758f799..c034e5c504c4 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -48,7 +48,7 @@
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
 #include <net/rtnetlink.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
 #include "bat_iv_ogm.h"
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a9679bdca432..5a66eb6c45f1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -42,7 +42,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index dafc73811aa6..ec7b357e1781 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -41,7 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/workqueue.h>
 #include <net/sock.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
 #include "distributed-arp-table.h"
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index d73346057310..152189b6f862 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -51,7 +51,7 @@
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "hard-interface.h"
 #include "log.h"
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5d3ba12002df..0065b8a2a1e4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -54,7 +54,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e4a79f9e2e24..9b78d9364e45 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -37,7 +37,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
-#include <uapi/linux/batman_adv.h>
+#include <uapi/linux/batadv_genl.h>
 
 #include "packet.h"
 
-- 
2.11.0

