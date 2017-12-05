Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Tue,  5 Dec 2017 15:35:13 +0100
Message-Id: <20171205143514.4441-6-sven.eckelmann@openmesh.com>
In-Reply-To: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v2 5/6] batman-adv: Convert packet.h to uapi
 header
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

The header file is used by different userspace programs to inject packets
or to decode sniffed packets. It should therefore be available to them as
userspace header.

Also other components in the kernel (like the flow dissector) require
access to the packet definitions to be able to decode ETH_P_BATMAN ethernet
packets.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 MAINTAINERS                                            | 1 +
 net/batman-adv/packet.h => include/uapi/linux/batadv.h | 9 +++++----
 net/batman-adv/bat_iv_ogm.c                            | 2 +-
 net/batman-adv/bat_v.c                                 | 2 +-
 net/batman-adv/bat_v_elp.c                             | 2 +-
 net/batman-adv/bat_v_ogm.c                             | 2 +-
 net/batman-adv/bridge_loop_avoidance.c                 | 2 +-
 net/batman-adv/distributed-arp-table.h                 | 2 +-
 net/batman-adv/fragmentation.c                         | 2 +-
 net/batman-adv/gateway_client.c                        | 2 +-
 net/batman-adv/gateway_common.c                        | 2 +-
 net/batman-adv/hard-interface.c                        | 2 +-
 net/batman-adv/icmp_socket.c                           | 2 +-
 net/batman-adv/main.c                                  | 2 +-
 net/batman-adv/main.h                                  | 2 +-
 net/batman-adv/multicast.c                             | 2 +-
 net/batman-adv/netlink.c                               | 2 +-
 net/batman-adv/network-coding.c                        | 2 +-
 net/batman-adv/routing.c                               | 2 +-
 net/batman-adv/send.h                                  | 3 +--
 net/batman-adv/soft-interface.c                        | 2 +-
 net/batman-adv/sysfs.c                                 | 2 +-
 net/batman-adv/tp_meter.c                              | 2 +-
 net/batman-adv/translation-table.c                     | 2 +-
 net/batman-adv/tvlv.c                                  | 2 +-
 net/batman-adv/types.h                                 | 3 +--
 26 files changed, 30 insertions(+), 30 deletions(-)
 rename net/batman-adv/packet.h => include/uapi/linux/batadv.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68abe39ee87a..10c42a978c59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2563,6 +2563,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.rst
+F:	include/uapi/linux/batadv.h
 F:	include/uapi/linux/batadv_genl.h
 F:	net/batman-adv/
 
diff --git a/net/batman-adv/packet.h b/include/uapi/linux/batadv.h
similarity index 98%
rename from net/batman-adv/packet.h
rename to include/uapi/linux/batadv.h
index 311ac6fd76ff..46a22ab79b76 100644
--- a/net/batman-adv/packet.h
+++ b/include/uapi/linux/batadv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
@@ -16,10 +16,11 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
+ * License-Filename: LICENSES/exceptions/Linux-syscall-note
  */
 
-#ifndef _NET_BATMAN_ADV_PACKET_H_
-#define _NET_BATMAN_ADV_PACKET_H_
+#ifndef _UAPI_LINUX_BATADV_H_
+#define _UAPI_LINUX_BATADV_H_
 
 #include <asm/byteorder.h>
 #include <linux/if_ether.h>
@@ -643,4 +644,4 @@ struct batadv_tvlv_mcast_data {
 	u8 reserved[3];
 };
 
-#endif /* _NET_BATMAN_ADV_PACKET_H_ */
+#endif /* _UAPI_LINUX_BATADV_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7727a39c4265..201529d1f015 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -54,6 +54,7 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
@@ -65,7 +66,6 @@
 #include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index b43ba53daafd..4b08d2b4d66f 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -39,6 +39,7 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
@@ -51,7 +52,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 
 struct sk_buff;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 0908e313d121..9fb1718248b8 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -44,13 +44,13 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/cfg80211.h>
+#include <uapi/linux/batadv.h>
 
 #include "bat_algo.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index a79e89ca5667..0f4050193e30 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -41,13 +41,13 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv.h>
 
 #include "bat_algo.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 1a9594d68db2..54d5feeb8ee2 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -52,6 +52,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "hard-interface.h"
@@ -59,7 +60,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "soft-interface.h"
 #include "sysfs.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 351de492430d..a9303faaaf54 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -26,9 +26,9 @@
 #include <linux/compiler.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv.h>
 
 #include "originator.h"
-#include "packet.h"
 
 struct seq_file;
 struct sk_buff;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 3890186b6f70..22b98cf39cfa 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -35,10 +35,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <uapi/linux/batadv.h>
 
 #include "hard-interface.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "soft-interface.h"
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 23c8032ce478..9a25b840fb33 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -45,6 +45,7 @@
 #include <linux/stddef.h>
 #include <linux/udp.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "gateway_common.h"
@@ -52,7 +53,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "soft-interface.h"
 #include "sysfs.h"
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index d918a176fa7b..a0e95a78b529 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -29,10 +29,10 @@
 #include <linux/netdevice.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <uapi/linux/batadv.h>
 
 #include "gateway_client.h"
 #include "log.h"
-#include "packet.h"
 #include "tvlv.h"
 
 /**
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f8a1dbc75f42..7519545cd0de 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -40,6 +40,7 @@
 #include <linux/spinlock.h>
 #include <net/net_namespace.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/batadv.h>
 
 #include "bat_v.h"
 #include "bridge_loop_avoidance.h"
@@ -48,7 +49,6 @@
 #include "gateway_client.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "soft-interface.h"
 #include "sysfs.h"
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 7bac7b4ee165..6dba4fbbbf70 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -46,11 +46,11 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
+#include <uapi/linux/batadv.h>
 
 #include "hard-interface.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 
 static struct batadv_socket_client *batadv_socket_client_hash[256];
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index c034e5c504c4..d6ca1b92afc5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -48,6 +48,7 @@
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
@@ -65,7 +66,6 @@
 #include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "soft-interface.h"
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 231bbc47910e..44f72cb41e93 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -225,8 +225,8 @@ enum batadv_uev_type {
 #include <linux/jiffies.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv.h>
 
-#include "packet.h"
 #include "types.h"
 
 struct net_device;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 2bda4540466d..f95af5101a8c 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -57,11 +57,11 @@
 #include <net/if_inet6.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <uapi/linux/batadv.h>
 
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
-#include "packet.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5a66eb6c45f1..551c0bd1fecf 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -42,6 +42,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "bat_algo.h"
@@ -49,7 +50,6 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "originator.h"
-#include "packet.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index aea92d09d7e8..bd72619106ba 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -51,12 +51,12 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv.h>
 
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "tvlv.h"
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 36001738917b..b462442b6d59 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -36,6 +36,7 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
+#include <uapi/linux/batadv.h>
 
 #include "bitarray.h"
 #include "bridge_loop_avoidance.h"
@@ -46,7 +47,6 @@
 #include "log.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index b9ef010bfb03..a9a0ebae73da 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -26,8 +26,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-
-#include "packet.h"
+#include <uapi/linux/batadv.h>
 
 struct sk_buff;
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 64d82e90d23c..cd46ac77ff14 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -51,6 +51,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv.h>
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
@@ -62,7 +63,6 @@
 #include "multicast.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "sysfs.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index eebd3d1ebfd7..328b5ff15aa6 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv.h>
 
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
@@ -49,7 +50,6 @@
 #include "hard-interface.h"
 #include "log.h"
 #include "network-coding.h"
-#include "packet.h"
 #include "soft-interface.h"
 
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 152189b6f862..8c1230ce4697 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -51,13 +51,13 @@
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "hard-interface.h"
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 
 /**
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0065b8a2a1e4..030cfac888e3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -54,6 +54,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
 #include "bridge_loop_avoidance.h"
@@ -62,7 +63,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "soft-interface.h"
 #include "tvlv.h"
 
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index e5857e755ffd..509f251a5e7c 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -38,9 +38,9 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv.h>
 
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "tvlv.h"
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9b78d9364e45..afe5a3ac2f39 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -37,10 +37,9 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv.h>
 #include <uapi/linux/batadv_genl.h>
 
-#include "packet.h"
-
 struct seq_file;
 
 #ifdef CONFIG_BATMAN_ADV_DAT
-- 
2.11.0

