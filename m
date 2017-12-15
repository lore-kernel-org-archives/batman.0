Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:08 +0100
Message-Id: <20171215114320.13645-9-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/20] batman-adv: include gfp.h for GFP_*
 defines
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The linux/gfp.h provides the GFP_ATOMIC and GFP_KERNEL define. It should
therefore be included instead of linux/fs.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            | 2 +-
 net/batman-adv/bat_v_elp.c             | 2 +-
 net/batman-adv/bat_v_ogm.c             | 2 +-
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/fragmentation.c         | 2 +-
 net/batman-adv/gateway_client.c        | 2 +-
 net/batman-adv/hard-interface.c        | 2 +-
 net/batman-adv/hash.c                  | 2 +-
 net/batman-adv/icmp_socket.c           | 1 +
 net/batman-adv/log.c                   | 1 +
 net/batman-adv/main.c                  | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/netlink.c               | 2 +-
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/sysfs.c                 | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 net/batman-adv/tvlv.c                  | 2 +-
 22 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4de912c87c23..250cb4fb66e7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -29,7 +29,7 @@
 #include <linux/cache.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1aa175a41d62..39fbed58e4c8 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -27,7 +27,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 0ce2d95a10aa..3cc5cd2f267e 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -25,7 +25,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f5b917b634df..2f12a556b6b0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -27,7 +27,7 @@
 #include <linux/crc16.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e708fda4654d..1035c53af616 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -26,7 +26,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index c49ca0503030..1c2024487eda 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -25,7 +25,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index b962430a45ee..cffa9e7f3665 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -25,7 +25,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 464c98f2a0c6..7f4596796c46 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -25,7 +25,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 33fd8fae2a1d..0569ee47684f 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -21,7 +21,7 @@
 #include "hash.h"
 #include "main.h"
 
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/lockdep.h>
 #include <linux/slab.h>
 
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index ca51c488f159..f1a67eaaf5f5 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 78e4dddb7f2d..59a1eb138e6a 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6b3db9b42b08..45f0f4ff8a08 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -25,8 +25,8 @@
 #include <linux/byteorder/generic.h>
 #include <linux/crc32c.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
 #include <linux/genetlink.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/init.h>
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 3cef5a764f8d..30c442e42d6f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -27,7 +27,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/icmpv6.h>
 #include <linux/if_bridge.h>
 #include <linux/if_ether.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index d70d0e2d1b2e..a06a2cd4d4e6 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -26,8 +26,8 @@
 #include <linux/cache.h>
 #include <linux/errno.h>
 #include <linux/export.h>
-#include <linux/fs.h>
 #include <linux/genetlink.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index c3d65af33707..f614d74fe74a 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -28,7 +28,7 @@
 #include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <linux/init.h>
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b435106c1617..beb168b148d7 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -24,7 +24,7 @@
 #include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index a9c505b78fcd..68b0bb1ad83e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -26,7 +26,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 178d998b420b..aea576f3e461 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -29,7 +29,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index e54a662b34b1..5c29e38a1ad1 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -25,7 +25,7 @@
 #include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_vlan.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e7b8ed079f94..45e7a77e5127 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -28,7 +28,7 @@
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index efa4ef02639e..66092c6b2f6a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -30,7 +30,7 @@
 #include <linux/crc32c.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jhash.h>
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index fcaa7bd415bd..308a0f3117c7 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -22,7 +22,7 @@
 
 #include <linux/byteorder/generic.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
-- 
2.11.0

