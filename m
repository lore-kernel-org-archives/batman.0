Date: Fri, 18 Jul 2008 13:18:09 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080718111809.GA30576@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Move more compatibility code to compat.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Use the madwifi-like compat.h to keep as much of the #ifLINUX_VERSION..
stuff out of the code to increase the readability.
Parts which weren't moved are the device creation/deletion, which is to
different to move it to compat.h, and the module count.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/batman-core/compat.h |   16 ++++++++++++++--
 batman-adv-kernelland/batman-core/device.c |   12 +-----------
 batman-adv-kernelland/batman-core/main.c   |    1 +
 batman-adv-kernelland/batman-core/main.h   |    1 -
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/batman-adv-kernelland/batman-core/compat.h b/batman-adv-kernelland/batman-core/compat.h
index cb94665..5f58f8f 100644
--- a/batman-adv-kernelland/batman-core/compat.h
+++ b/batman-adv-kernelland/batman-core/compat.h
@@ -20,8 +20,9 @@
  * of the Linux kernel.
  */
 
+#include <linux/version.h>	/* LINUX_VERSION_CODE */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,22)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 22)
 
 #define skb_set_network_header(_skb, _offset) \
 	do { (_skb)->nh.raw = (_skb)->data + (_offset); } while (0)
@@ -32,4 +33,15 @@
 #define list_first_entry(ptr, type, member) \
 	list_entry((ptr)->next, type, member)
 
-#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 22) */
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 26)
+
+#define device_create_drvdata(_cls, _parent, _devt, _device, _fmt) \
+	class_device_create(_cls, _parent, _devt, _device, _fmt)
+
+#define device_destroy(_cls, _device) \
+	class_device_destroy(_cls, _device)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 26) */
diff --git a/batman-adv-kernelland/batman-core/device.c b/batman-adv-kernelland/batman-core/device.c
index 18b026a..6608f13 100644
--- a/batman-adv-kernelland/batman-core/device.c
+++ b/batman-adv-kernelland/batman-core/device.c
@@ -30,9 +30,7 @@
 
 #include "compat.h"
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-#include <linux/devfs_fs_kernel.h>
-#else
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
 static struct class *batman_class;
 #endif
 
@@ -85,11 +83,7 @@ void bat_device_setup(void)
 		debug_log(LOG_TYPE_WARN, "Could not register class 'batman-adv' \n");
 		return;
 	} else {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)
 		device_create_drvdata(batman_class, NULL, MKDEV(tmp_major, 0), NULL, "batman-adv");
-#else
-		class_device_create(batman_class, NULL, MKDEV(tmp_major, 0), NULL, "batman-adv");
-#endif
 	}
 #endif
 
@@ -106,11 +100,7 @@ void bat_device_destroy(void)
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 	devfs_remove("batman-adv", 0);
 #else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)
 	device_destroy(batman_class, MKDEV(Major, 0));
-#else
-	class_device_destroy(batman_class, MKDEV(Major, 0));
-#endif
 	class_destroy(batman_class);
 #endif
 
diff --git a/batman-adv-kernelland/batman-core/main.c b/batman-adv-kernelland/batman-core/main.c
index bf2a52c..7628865 100644
--- a/batman-adv-kernelland/batman-core/main.c
+++ b/batman-adv-kernelland/batman-core/main.c
@@ -30,6 +30,7 @@
 #include "vis.h"
 #include "types.h"
 #include "hash.h"
+#include "compat.h"
 
 
 
diff --git a/batman-adv-kernelland/batman-core/main.h b/batman-adv-kernelland/batman-core/main.h
index 517fbc6..4208ae5 100644
--- a/batman-adv-kernelland/batman-core/main.h
+++ b/batman-adv-kernelland/batman-core/main.h
@@ -78,7 +78,6 @@
 
 #include <linux/mutex.h>	/* mutex */
 #include <linux/module.h>	/* needed by all modules */
-#include <linux/version.h>	/* LINUX_VERSION_CODE */
 #include <linux/netdevice.h>	/* netdevice */
 #include <linux/timer.h>	/* timer */
 #include <linux/if_ether.h>	/* ethernet header */
-- 
1.5.6.3


