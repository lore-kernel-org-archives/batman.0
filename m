Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 15 Dec 2017 19:23:12 +0100
Message-Id: <20171215182313.15767-4-sven.eckelmann@openmesh.com>
In-Reply-To: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
References: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v3 3/4] batman-adv: Convert packet.h to uapi
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Tom Herbert <tom@herbertland.com>, Sven Eckelmann <sven.eckelmann@openmesh.com>

The header file is used by different userspace programs to inject packets
or to decode sniffed packets. It should therefore be available to them as
userspace header.

Also other components in the kernel (like the flow dissector) require
access to the packet definitions to be able to decode ETH_P_BATMAN ethernet
packets.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 MAINTAINERS                                                   | 1 +
 net/batman-adv/packet.h => include/uapi/linux/batadv_packet.h | 8 ++++----
 net/batman-adv/bat_iv_ogm.c                                   | 2 +-
 net/batman-adv/bat_v.c                                        | 2 +-
 net/batman-adv/bat_v_elp.c                                    | 2 +-
 net/batman-adv/bat_v_ogm.c                                    | 2 +-
 net/batman-adv/bridge_loop_avoidance.c                        | 2 +-
 net/batman-adv/distributed-arp-table.h                        | 2 +-
 net/batman-adv/fragmentation.c                                | 2 +-
 net/batman-adv/gateway_client.c                               | 2 +-
 net/batman-adv/gateway_common.c                               | 2 +-
 net/batman-adv/hard-interface.c                               | 2 +-
 net/batman-adv/icmp_socket.c                                  | 2 +-
 net/batman-adv/main.c                                         | 2 +-
 net/batman-adv/main.h                                         | 2 +-
 net/batman-adv/multicast.c                                    | 2 +-
 net/batman-adv/netlink.c                                      | 2 +-
 net/batman-adv/network-coding.c                               | 2 +-
 net/batman-adv/routing.c                                      | 2 +-
 net/batman-adv/send.h                                         | 3 +--
 net/batman-adv/soft-interface.c                               | 2 +-
 net/batman-adv/sysfs.c                                        | 2 +-
 net/batman-adv/tp_meter.c                                     | 2 +-
 net/batman-adv/translation-table.c                            | 2 +-
 net/batman-adv/tvlv.c                                         | 2 +-
 net/batman-adv/types.h                                        | 3 +--
 26 files changed, 29 insertions(+), 30 deletions(-)
 rename net/batman-adv/packet.h => include/uapi/linux/batadv_packet.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..4d6af00a5f10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2563,6 +2563,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.rst
+F:	include/uapi/linux/batadv_packet.h
 F:	include/uapi/linux/batman_adv.h
 F:	net/batman-adv/
 
diff --git a/net/batman-adv/packet.h b/include/uapi/linux/batadv_packet.h
similarity index 99%
rename from net/batman-adv/packet.h
rename to include/uapi/linux/batadv_packet.h
index 44f20d03205b..43462e17335a 100644
--- a/net/batman-adv/packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
@@ -16,8 +16,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef _NET_BATMAN_ADV_PACKET_H_
-#define _NET_BATMAN_ADV_PACKET_H_
+#ifndef _UAPI_LINUX_BATADV_PACKET_H_
+#define _UAPI_LINUX_BATADV_PACKET_H_
 
 #include <asm/byteorder.h>
 #include <linux/if_ether.h>
@@ -641,4 +641,4 @@ struct batadv_tvlv_mcast_data {
 	u8 reserved[3];
 };
 
-#endif /* _NET_BATMAN_ADV_PACKET_H_ */
+#endif /* _UAPI_LINUX_BATADV_PACKET_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index c9955f29a2bf..a4a331c56a60 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -52,6 +52,7 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
@@ -63,7 +64,6 @@
 #include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 14ec3677c391..f5abe4a4e247 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -37,6 +37,7 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
@@ -49,7 +50,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 
 struct sk_buff;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 59ae96cef596..a83478c46597 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -42,13 +42,13 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/cfg80211.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "bat_algo.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e415974c540d..ba59b77c605d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -39,13 +39,13 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv_packet.h>
 
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
index e647450e5d0f..fad47853ad3c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -50,6 +50,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "hard-interface.h"
@@ -57,7 +58,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "soft-interface.h"
 #include "sysfs.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 3d47bedaf661..12897eb46268 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -24,9 +24,9 @@
 #include <linux/compiler.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "originator.h"
-#include "packet.h"
 
 struct seq_file;
 struct sk_buff;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 36f8a84153bf..b893627767f2 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -33,10 +33,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "hard-interface.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "soft-interface.h"
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 2488e25d0eef..37fe9a644f22 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -43,6 +43,7 @@
 #include <linux/stddef.h>
 #include <linux/udp.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "gateway_common.h"
@@ -50,7 +51,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "soft-interface.h"
 #include "sysfs.h"
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 83bfeecf661c..b3e156af2256 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -27,10 +27,10 @@
 #include <linux/netdevice.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "gateway_client.h"
 #include "log.h"
-#include "packet.h"
 #include "tvlv.h"
 
 /**
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 13d04dba0b3a..5f186bff284a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -38,6 +38,7 @@
 #include <linux/spinlock.h>
 #include <net/net_namespace.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "bat_v.h"
 #include "bridge_loop_avoidance.h"
@@ -46,7 +47,6 @@
 #include "gateway_client.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "soft-interface.h"
 #include "sysfs.h"
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index f2ef75b7fa73..8041cf106c37 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -44,11 +44,11 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "hard-interface.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 
 static struct batadv_socket_client *batadv_socket_client_hash[256];
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8bee4279d579..d31c8266e244 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -46,6 +46,7 @@
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
@@ -63,7 +64,6 @@
 #include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "soft-interface.h"
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index d5484ac381d3..f7ba3f96d8f3 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -223,8 +223,8 @@ enum batadv_uev_type {
 #include <linux/jiffies.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv_packet.h>
 
-#include "packet.h"
 #include "types.h"
 
 struct net_device;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8a503c526b90..cbdeb47ec3f6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -55,11 +55,11 @@
 #include <net/if_inet6.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
-#include "packet.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 103d4bdcdbdb..a823d3899bad 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -40,6 +40,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
@@ -47,7 +48,6 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "originator.h"
-#include "packet.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 3758be7fd881..b48116bb24ef 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -49,12 +49,12 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
 #include "originator.h"
-#include "packet.h"
 #include "routing.h"
 #include "send.h"
 #include "tvlv.h"
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index eb835bde502a..b6891e8b741c 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -34,6 +34,7 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "bitarray.h"
 #include "bridge_loop_avoidance.h"
@@ -44,7 +45,6 @@
 #include "log.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 8c7399dd06ca..1e8c79093623 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -24,8 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-
-#include "packet.h"
+#include <uapi/linux/batadv_packet.h>
 
 struct sk_buff;
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1eb5555c5fe4..900c5ce21cd4 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -49,6 +49,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
@@ -60,7 +61,6 @@
 #include "multicast.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "sysfs.h"
 #include "translation-table.h"
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 56fb42551453..c1578fa0b952 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -39,6 +39,7 @@
 #include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
@@ -47,7 +48,6 @@
 #include "hard-interface.h"
 #include "log.h"
 #include "network-coding.h"
-#include "packet.h"
 #include "soft-interface.h"
 
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b443b9d28918..c68c41e713a6 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -49,13 +49,13 @@
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "hard-interface.h"
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 
 /**
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0e53be3f8df0..7550a9ccd695 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -52,6 +52,7 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sock.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bridge_loop_avoidance.h"
@@ -60,7 +61,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "packet.h"
 #include "soft-interface.h"
 #include "tvlv.h"
 
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index e189f026974c..5ffcb45ac6ff 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -36,9 +36,9 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <uapi/linux/batadv_packet.h>
 
 #include "originator.h"
-#include "packet.h"
 #include "send.h"
 #include "tvlv.h"
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 77b145eba193..bb1578410e0c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -35,10 +35,9 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
-#include "packet.h"
-
 struct seq_file;
 
 #ifdef CONFIG_BATMAN_ADV_DAT
-- 
2.11.0

