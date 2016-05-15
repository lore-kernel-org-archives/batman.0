Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 11:07:42 +0200
Message-Id: <1463303266-25979-2-git-send-email-sven@narfation.org>
In-Reply-To: <1463303266-25979-1-git-send-email-sven@narfation.org>
References: <1463303266-25979-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 2/6] batman-adv: Keep includes ordered by
	filename
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

It is easier to detect if a include is already there for a used
functionality when the includes are ordered. Using an alphabetic order
together with the grouping in commit 7df620092727 ("batman-adv: Add
required includes to all files") makes includes better manageable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - adjusted title
v2:
 - never existed
---
 net/batman-adv/bat_iv_ogm.c     | 2 +-
 net/batman-adv/gateway_common.c | 2 +-
 net/batman-adv/hard-interface.c | 2 +-
 net/batman-adv/main.h           | 6 +++---
 net/batman-adv/multicast.c      | 2 +-
 net/batman-adv/netlink.c        | 4 ++--
 net/batman-adv/send.c           | 2 +-
 net/batman-adv/sysfs.c          | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4815db9..6dc89b0 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -31,8 +31,8 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_sched.h>
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 3c26945..7754435 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -19,8 +19,8 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/errno.h>
 #include <linux/byteorder/generic.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/netdevice.h>
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a8cda76..1e26a0b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -23,9 +23,9 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
-#include <linux/if.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 832df0f..94bf4f8 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -181,12 +181,12 @@ enum batadv_uev_type {
 #include <linux/cpumask.h>
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h> /* for packet.h */
+#include <linux/if_vlan.h>
+#include <linux/jiffies.h>
 #include <linux/netdevice.h>
+#include <linux/percpu.h>
 #include <linux/printk.h>
 #include <linux/types.h>
-#include <linux/percpu.h>
-#include <linux/jiffies.h>
-#include <linux/if_vlan.h>
 
 #include "types.h"
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index abb12f1..5a22943 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -29,8 +29,8 @@
 #include <linux/if_bridge.h>
 #include <linux/if_ether.h>
 #include <linux/igmp.h>
-#include <linux/in6.h>
 #include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/kernel.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 54724b7..68152aa 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -15,8 +15,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "main.h"
 #include "netlink.h"
+#include "main.h"
 
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -25,8 +25,8 @@
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
-#include <linux/stddef.h>
 #include <linux/printk.h>
+#include <linux/stddef.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 638d1c1..45ca6ac 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -22,8 +22,8 @@
 #include <linux/byteorder/generic.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
-#include <linux/if_ether.h>
 #include <linux/if.h>
+#include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 233abcf..6244a9a 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -25,8 +25,8 @@
 #include <linux/fs.h>
 #include <linux/if.h>
 #include <linux/if_vlan.h>
-#include <linux/kref.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
@@ -38,10 +38,10 @@
 #include <linux/string.h>
 #include <linux/stringify.h>
 
+#include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
-#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "network-coding.h"
 #include "packet.h"
-- 
2.8.1

