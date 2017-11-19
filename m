Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 17:12:02 +0100
Message-Id: <20171119161207.32588-2-sven@narfation.org>
In-Reply-To: <20171119161207.32588-1-sven@narfation.org>
References: <20171119161207.32588-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: include gfp.h for GFP_*
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
To: b.a.t.m.a.n@lists.open-mesh.org

The linux/gfp.h provides the GFP_ATOMIC and GFP_KERNEL define. It should
therefore be included instead of linux/fs.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
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
index 4de912c8..250cb4fb 100644
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
index 1aa175a4..39fbed58 100644
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
index 0ce2d95a..3cc5cd2f 100644
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
index f5b917b6..2f12a556 100644
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
index e708fda4..1035c53a 100644
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
index c49ca050..1c202448 100644
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
index b962430a..cffa9e7f 100644
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
index 464c98f2..7f459679 100644
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
index 33fd8fae..0569ee47 100644
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
index ca51c488..f1a67eaa 100644
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
index 78e4dddb..59a1eb13 100644
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
index 6b3db9b4..45f0f4ff 100644
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
index 3cef5a76..30c442e4 100644
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
index d70d0e2d..a06a2cd4 100644
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
index c3d65af3..f614d74f 100644
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
index f365de37..4018ecba 100644
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
index a9c505b7..68b0bb1a 100644
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
index 178d998b..aea576f3 100644
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
index e54a662b..5c29e38a 100644
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
index f890319b..52e667ec 100644
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
index efa4ef02..66092c6b 100644
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
index fcaa7bd4..308a0f31 100644
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

