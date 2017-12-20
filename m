Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:12 +0100
Message-Id: <20171220110124.13117-8-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/19] batman-adv: include gfp.h for GFP_*
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
index bff5ec66a2e1..27d9c8adf2ca 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -27,7 +27,7 @@
 #include <linux/cache.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 8375fd679db3..92b56bb5686d 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -25,7 +25,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 22d2bafa814a..7055a9483788 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -23,7 +23,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 007147f3ed9e..ce124a21fce5 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -25,7 +25,7 @@
 #include <linux/crc16.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 3c2faf773335..f704bbc76e2a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -24,7 +24,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 22ce4c0c86c3..741c6b91664e 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -23,7 +23,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e8db19940ab8..21db0165175b 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -23,7 +23,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 2f067a507fd5..394e69b77535 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -23,7 +23,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index a6dbaf2e9fc9..2ce0d5673f40 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -19,7 +19,7 @@
 #include "hash.h"
 #include "main.h"
 
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/lockdep.h>
 #include <linux/slab.h>
 
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index cc76f1365300..71ba58cc51fa 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 148e64e846d2..6fbcdd40a332 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -25,6 +25,7 @@
 #include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5ce2007ea11b..0c3664aa6a58 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -23,8 +23,8 @@
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
index 01546a42b7ad..d8617c2794db 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -25,7 +25,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/icmpv6.h>
 #include <linux/if_bridge.h>
 #include <linux/if_ether.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ce424fe2f24e..f7281685633c 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -24,8 +24,8 @@
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
index 5cfac6e56610..d37fe5ed6117 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -26,7 +26,7 @@
 #include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <linux/init.h>
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0716daf5b9a7..007b6bd8df95 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -22,7 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index a6c53684ba70..c53b11d41d8b 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -24,7 +24,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index e543024f98ef..ba8fd06eee7e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -27,7 +27,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index ab0b95f15b36..374ff46feb8e 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -23,7 +23,7 @@
 #include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_vlan.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 601feb2c4ecf..e33f64f0fcb8 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -26,7 +26,7 @@
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 281bd4cf7f90..db40ca6243b3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -28,7 +28,7 @@
 #include <linux/crc32c.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jhash.h>
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 67b2ba4b824b..d956c2a0e9cb 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -20,7 +20,7 @@
 
 #include <linux/byteorder/generic.h>
 #include <linux/etherdevice.h>
-#include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
-- 
2.11.0

