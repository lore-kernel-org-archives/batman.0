Date: Wed, 24 Sep 2008 23:59:21 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080924215921.GA9265@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Move more linux 2.6 compat stuff to
	compat26.h
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

---
 batman/linux/modules/gateway.c    |    8 --------
 batman/linux/modules/mod_batman.c |   22 ++--------------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 965f87b..154497e 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -91,11 +91,7 @@ int init_module()
 	if ( IS_ERR( batman_class ) )
 		DBG( "could not register class 'batgat'" );
 	else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)
 		device_create_drvdata(batman_class, NULL, MKDEV(Major, 0), NULL, "batgat");
-#else
-		class_device_create(batman_class, NULL, MKDEV(Major, 0), NULL, "batgat");
-#endif
 
 
 	DBG( "batgat loaded %s", strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : "" );
@@ -120,11 +116,7 @@ void cleanup_module()
 	struct free_client_data *entry, *next;
 	struct gw_client *gw_client;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)
 	device_destroy( batman_class, MKDEV( Major, 0 ) );
-#else
-	class_device_destroy( batman_class, MKDEV( Major, 0 ) );
-#endif
 	class_destroy( batman_class );
 
 	/* Unregister the device */
diff --git a/batman/linux/modules/mod_batman.c b/batman/linux/modules/mod_batman.c
index d34b05e..1b9ecda 100644
--- a/batman/linux/modules/mod_batman.c
+++ b/batman/linux/modules/mod_batman.c
@@ -50,6 +50,8 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 	#include <linux/devfs_fs_kernel.h>
 #else
+#include "compat26.h"
+
 	static struct class *batman_class;
 #endif
 
@@ -117,11 +119,7 @@ int init_module( void ) {
 	if ( IS_ERR(batman_class) )
 		printk( "B.A.T.M.A.N.: Could not register class 'batman' \n" );
 	else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)  
 		device_create_drvdata( batman_class, NULL, MKDEV( Major, 0 ), NULL, "batman" );
-#else
-		class_device_create( batman_class, NULL, MKDEV( Major, 0 ), NULL, "batman" );
-#endif
 #endif
 
 	for ( i = 0; i < 255; i++ ) {
@@ -143,11 +141,7 @@ void cleanup_module( void ) {
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 	devfs_remove( "batman", 0 );
 #else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)  
 	device_destroy_drvdata( batman_class, MKDEV( Major, 0 ) );
-#else
-	class_device_destroy( batman_class, MKDEV( Major, 0 ) );
-#endif
 	class_destroy( batman_class );
 #endif
 
@@ -247,11 +241,7 @@ static int device_release( struct inode *inode, struct file *file ) {
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 		devfs_remove( "batman", minor_num );
 #else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)  
 		device_destroy(minor->minor_class, MKDEV(Major, minor_num));
-#else
-		class_device_destroy( minor->minor_class, MKDEV( Major, minor_num ) );
-#endif
 		class_destroy( minor->minor_class );
 #endif
 		sock_release( minor->raw_sock );
@@ -367,11 +357,7 @@ static int device_ioctl( struct inode *inode, struct file *file, unsigned int cm
 			if ( IS_ERR(minor->minor_class) )
 				printk( "B.A.T.M.A.N.: Could not register class '%s' \n", filename );
 			else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)  
 				device_create_drvdata( minor->minor_class, NULL, MKDEV( Major, minor_num ), NULL, "batman%d", minor_num );
-#else
-				class_device_create( minor->minor_class, NULL, MKDEV( Major, minor_num ), NULL, "batman%d", minor_num );
-#endif
 #endif
 			/* let udev create the device file */
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -395,11 +381,7 @@ static int device_ioctl( struct inode *inode, struct file *file, unsigned int cm
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 					devfs_remove( "batman", minor_num );
 #else
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)  
 					device_destroy( minor->minor_class, MKDEV(Major, minor_num ));
-#else
-					class_device_destroy( minor->minor_class, MKDEV(Major, minor_num ));
-#endif
 					class_destroy( minor->minor_class );
 #endif
 					kfree( minor );
-- 
1.6.0.1


