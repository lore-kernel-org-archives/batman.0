Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 12 Sep 2009 12:10:20 +0200
Message-Id: <1252750220-19243-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Remove compatibility code for pre 2.6 kernel
	versions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

The earliest version of linux which is compatible to
batman-adv-kernelland is 2.6.20. Their are patches available in debian
for batman-adv-kernelland 0.1 to make it build against linux 2.6.15, but
they cannot be ported to current trunk due to changes to the working
queues. To have "support" for much older versions isn't needed and can
be removed without loosing any functionality.
As result the only remaining LINUX_VERSION_CODE dependend precomiler
code beside compat.h is for netdevice_ops support in soft-interface.c
and result code checking of unregister_chrdev in device.c. For a
possible merge into linux compat.h and all appearances of
LINUX_VERSION_CODE should be removed according to checkpatch.pl.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/device.c |   14 --------------
 batman-adv-kernelland/main.c   |    8 --------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index 80a6215..6383839 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -26,9 +26,7 @@
 
 #include "compat.h"
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
 static struct class *batman_class;
-#endif
 
 static int Major;	/* Major number assigned to our device driver */
 
@@ -65,13 +63,6 @@ int bat_device_setup(void)
 		return 0;
 	}
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-	if (devfs_mk_cdev(MKDEV(tmp_major, 0), S_IFCHR | S_IRUGO | S_IWUGO,
-			  "batman-adv", 0)) {
-		debug_log(LOG_TYPE_WARN, "Could not create /dev/batman-adv\n");
-		return 0;
-	}
-#else
 	batman_class = class_create(THIS_MODULE, "batman-adv");
 
 	if (IS_ERR(batman_class)) {
@@ -81,7 +72,6 @@ int bat_device_setup(void)
 
 	device_create(batman_class, NULL, MKDEV(tmp_major, 0), NULL,
 		      "batman-adv");
-#endif
 
 	Major = tmp_major;
 	return 1;
@@ -94,12 +84,8 @@ void bat_device_destroy(void)
 	if (!Major)
 		return;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-	devfs_remove("batman-adv", 0);
-#else
 	device_destroy(batman_class, MKDEV(Major, 0));
 	class_destroy(batman_class);
-#endif
 
 	/* Unregister the device */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 23)
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index 584b141..8fbefc2 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -203,20 +203,12 @@ void shutdown_module(void)
 
 void inc_module_count(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-	MOD_INC_USE_COUNT;
-#else
 	try_module_get(THIS_MODULE);
-#endif
 }
 
 void dec_module_count(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-	MOD_DEC_USE_COUNT;
-#else
 	module_put(THIS_MODULE);
-#endif
 }
 
 int addr_to_string(char *buff, uint8_t *addr)
-- 
1.6.3.3

