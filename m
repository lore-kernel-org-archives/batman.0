Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 23 Oct 2010 11:31:43 +0200
Message-Id: <1287826303-6762-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287660411-4238-1-git-send-email-sven.eckelmann@gmx.de>
References: <1287660411-4238-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Include compat.h only once
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

compat.h is included in all files which may need newer functionality
than the target kernel has. This include is may forgotton when new
changes are made to the sources.

The compat.h can also be included in main.h which is included by all
source files. In theory also all header files must include main.h. This
is currently not and hopefully will never be necessary.

It is also important that all header files which declare functions which
are redefined in compat.h to be included before compat.h is included.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
rebased on top of current master

 batman-adv/bat_debugfs.c       |    1 -
 batman-adv/bat_printk.c        |    3 ++-
 batman-adv/bat_sysfs.c         |    1 -
 batman-adv/gateway_client.c    |    1 -
 batman-adv/gateway_common.c    |    1 -
 batman-adv/hard-interface.c    |    2 --
 batman-adv/icmp_socket.c       |    3 ---
 batman-adv/main.c              |    1 -
 batman-adv/main.h              |    5 +++++
 batman-adv/originator.c        |    1 -
 batman-adv/routing.c           |    1 -
 batman-adv/send.c              |    2 --
 batman-adv/soft-interface.c    |    1 -
 batman-adv/translation-table.c |    1 -
 batman-adv/vis.c               |    1 -
 15 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 3fcb102..2c4a247 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -32,7 +32,6 @@
 #include "soft-interface.h"
 #include "vis.h"
 #include "icmp_socket.h"
-#include "compat.h"
 
 static struct dentry *bat_debugfs;
 
diff --git a/batman-adv/bat_printk.c b/batman-adv/bat_printk.c
index 6615876..4fa3e18 100644
--- a/batman-adv/bat_printk.c
+++ b/batman-adv/bat_printk.c
@@ -30,7 +30,8 @@
 #include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/div64.h>
 #include <asm/sections.h>	/* for dereference_function_descriptor() */
-#include "compat.h"
+
+#include "main.h"
 
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index e85a922..8e3dbef 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -27,7 +27,6 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "vis.h"
-#include "compat.h"
 
 #define to_dev(obj)		container_of(obj, struct device, kobj)
 #define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index ae1ab1e..49cd0cd 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -23,7 +23,6 @@
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
-#include "compat.h"
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
diff --git a/batman-adv/gateway_common.c b/batman-adv/gateway_common.c
index 3851930..a88ce41 100644
--- a/batman-adv/gateway_common.c
+++ b/batman-adv/gateway_common.c
@@ -22,7 +22,6 @@
 #include "main.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
-#include "compat.h"
 
 /* calculates the gateway class from kbit */
 static void kbit_to_gw_srv_class(int down, int up, long *gw_srv_class)
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 3c59209..2ce2f3b 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -31,8 +31,6 @@
 
 #include <linux/if_arp.h>
 
-#include "compat.h"
-
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
 /* protect update critical side of if_list - but not the content */
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index b9201c5..c316a62 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -29,9 +29,6 @@
 #include "originator.h"
 #include "hard-interface.h"
 
-#include "compat.h"
-
-
 static struct socket_client *socket_client_hash[256];
 
 static void bat_socket_add_packet(struct socket_client *socket_client,
diff --git a/batman-adv/main.c b/batman-adv/main.c
index 9c14832..e873b42 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -33,7 +33,6 @@
 #include "types.h"
 #include "vis.h"
 #include "hash.h"
-#include "compat.h"
 
 struct list_head if_list;
 
diff --git a/batman-adv/main.h b/batman-adv/main.h
index b305f55..73e4ce7 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -86,6 +86,9 @@
 /*
  * Debug Messages
  */
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* Append 'batman-adv: ' before
 					     * kernel messages */
 
@@ -121,6 +124,8 @@
 #include <linux/seq_file.h>
 #include "types.h"
 
+#include "compat.h"
+
 #ifndef REVISION_VERSION
 #define REVISION_VERSION_STR ""
 #else
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index afac4eb..7cdb175 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -26,7 +26,6 @@
 #include "hash.h"
 #include "translation-table.h"
 #include "routing.h"
-#include "compat.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "unicast.h"
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 186428d..a63391c 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -32,7 +32,6 @@
 #include "ring_buffer.h"
 #include "vis.h"
 #include "aggregation.h"
-#include "compat.h"
 #include "gateway_client.h"
 #include "unicast.h"
 
diff --git a/batman-adv/send.c b/batman-adv/send.c
index a6cb644..cae3a60 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -31,8 +31,6 @@
 #include "gateway_common.h"
 #include "originator.h"
 
-#include "compat.h"
-
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* apply hop penalty for a normal link */
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 69c283c..bc251ad 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -36,7 +36,6 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
-#include "compat.h"
 #include "unicast.h"
 #include "routing.h"
 
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index f435718..6639bfb 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -25,7 +25,6 @@
 #include "types.h"
 #include "hash.h"
 #include "originator.h"
-#include "compat.h"
 
 static void hna_local_purge(struct work_struct *work);
 static void _hna_global_del_orig(struct bat_priv *bat_priv,
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 9e41f81..4cb8a8e 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -27,7 +27,6 @@
 #include "hard-interface.h"
 #include "hash.h"
 #include "originator.h"
-#include "compat.h"
 
 #define MAX_VIS_PACKET_SIZE 1000
 
-- 
1.7.2.3

