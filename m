Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:47:24 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718144724.GM4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup main.[ch]
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make main.[ch] clean with respect to the 2.6.29 checkpatch
script. Exceptions are long lines with debug_log and the use of
KERNEL_VERSION.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/main.c
===================================================================
--- batman-adv-kernelland/main.c	(revision 1351)
+++ batman-adv-kernelland/main.c	(working copy)
@@ -17,7 +17,6 @@
  *
  */
 
-
 #include "main.h"
 #include "proc.h"
 #include "log.h"
@@ -27,13 +26,11 @@
 #include "device.h"
 #include "translation-table.h"
 #include "hard-interface.h"
-#include "vis.h"
 #include "types.h"
+#include "vis.h"
 #include "hash.h"
 #include "compat.h"
 
-
-
 struct list_head if_list;
 struct hlist_head forw_bat_list;
 struct hlist_head forw_bcast_list;
@@ -47,21 +44,19 @@
 atomic_t originator_interval;
 atomic_t vis_interval;
 atomic_t aggregation_enabled;
-int16_t num_hna = 0;
-int16_t num_ifs = 0;
+int16_t num_hna;
+int16_t num_ifs;
 
-struct net_device *soft_device = NULL;
+struct net_device *soft_device;
 
-static struct task_struct *kthread_task = NULL;
+static struct task_struct *kthread_task;
 
 unsigned char broadcastAddr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-char hna_local_changed = 0;
+char hna_local_changed;
 char module_state = MODULE_INACTIVE;
 
-struct workqueue_struct *bat_event_workqueue = NULL;
+struct workqueue_struct *bat_event_workqueue;
 
-
-
 int init_module(void)
 {
 	int retval;
@@ -71,16 +66,19 @@
 	INIT_HLIST_HEAD(&forw_bat_list);
 	INIT_HLIST_HEAD(&forw_bcast_list);
 	atomic_set(&originator_interval, 1000);
-	atomic_set(&vis_interval, 1000);	/* TODO: raise this later, this is only for debugging now. */
+	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
+					 * for debugging now. */
 	atomic_set(&aggregation_enabled, 1);
 
-	/* the name should not be longer than 10 chars - see http://lwn.net/Articles/23634/ */
+	/* the name should not be longer than 10 chars - see
+	 * http://lwn.net/Articles/23634/ */
 	bat_event_workqueue = create_singlethread_workqueue("bat_events");
 
 	if (!bat_event_workqueue)
 		return -ENOMEM;
 
-	if ((retval = setup_procfs()) < 0)
+	retval = setup_procfs();
+	if (retval < 0)
 		return retval;
 
 	orig_hash = hash_new(128, compare_orig, choose_orig);
@@ -97,7 +95,8 @@
 	bat_device_init();
 
 	/* initialize layer 2 interface */
-	soft_device = alloc_netdev(sizeof(struct bat_priv) , "bat%d", interface_setup);
+	soft_device = alloc_netdev(sizeof(struct bat_priv) , "bat%d",
+				   interface_setup);
 
 	if (soft_device == NULL) {
 		debug_log(LOG_TYPE_CRIT, "Unable to allocate the batman interface\n");
@@ -114,13 +113,13 @@
 	hna_local_add(soft_device->dev_addr);
 
 	start_hardif_check_timer();
-	debug_log(LOG_TYPE_CRIT, "B.A.T.M.A.N. advanced %s%s (compability version %i) loaded \n", SOURCE_VERSION, (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""), COMPAT_VERSION);
 
+	debug_log(LOG_TYPE_CRIT, "B.A.T.M.A.N. advanced %s%s (compability version %i) loaded \n",
+		  SOURCE_VERSION,
+		  (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""),
+		  COMPAT_VERSION);
+
 	return 0;
-/* for later use ...
-unregister_soft_device:
-	unregister_netdev(soft_device);
-*/
 
 free_soft_device:
 	free_netdev(soft_device);
@@ -214,13 +213,11 @@
 
 	hardif_remove_interfaces();
 	synchronize_rcu();
-
-
 }
 
 void inc_module_count(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
 	MOD_INC_USE_COUNT;
 #else
 	try_module_get(THIS_MODULE);
@@ -229,7 +226,7 @@
 
 void dec_module_count(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
 	MOD_DEC_USE_COUNT;
 #else
 	module_put(THIS_MODULE);
@@ -238,7 +235,8 @@
 
 int addr_to_string(char *buff, uint8_t *addr)
 {
-	return sprintf(buff, "%02x:%02x:%02x:%02x:%02x:%02x", addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+	return sprintf(buff, "%02x:%02x:%02x:%02x:%02x:%02x",
+		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 }
 
 int compare_orig(void *data1, void *data2)
@@ -250,7 +248,7 @@
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 int choose_orig(void *data, int32_t size)
 {
-	unsigned char *key= data;
+	unsigned char *key = data;
 	uint32_t hash = 0;
 	size_t i;
 
@@ -264,17 +262,16 @@
 	hash ^= (hash >> 11);
 	hash += (hash << 15);
 
-	return (hash % size);
+	return hash % size;
 }
 
-
-
 int is_my_mac(uint8_t *addr)
 {
 	struct batman_if *batman_if;
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if ((batman_if->net_dev != NULL) && (compare_orig(batman_if->net_dev->dev_addr, addr))) {
+		if ((batman_if->net_dev != NULL) &&
+		    (compare_orig(batman_if->net_dev->dev_addr, addr))) {
 			rcu_read_unlock();
 			return 1;
 		}
@@ -286,19 +283,16 @@
 
 int is_bcast(uint8_t *addr)
 {
-	return ((addr[0] == (uint8_t)0xff) && (addr[1] == (uint8_t)0xff));
+	return (addr[0] == (uint8_t)0xff) && (addr[1] == (uint8_t)0xff);
 }
 
 int is_mcast(uint8_t *addr)
 {
-	return (*addr & 0x01);
+	return *addr & 0x01;
 }
 
-
-
 MODULE_LICENSE("GPL");
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_SUPPORTED_DEVICE(DRIVER_DEVICE);
-
Index: batman-adv-kernelland/main.h
===================================================================
--- batman-adv-kernelland/main.h	(revision 1351)
+++ batman-adv-kernelland/main.h	(working copy)
@@ -27,14 +27,18 @@
 #define SOURCE_VERSION "0.2-beta"
 #define TQ_MAX_VALUE 255
 #define JITTER 20
-#define TTL 50		/* Time To Live of broadcast messages */
-#define MAX_ADDR 16	/* number of interfaces which can be added to batman. */
+#define TTL 50		          /* Time To Live of broadcast messages */
+#define MAX_ADDR 16	          /* number of interfaces which can be added to
+				   * batman. */
 
-
-#define PURGE_TIMEOUT 200000  /* purge originators after time in ms if no valid packet comes in -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
+#define PURGE_TIMEOUT 200000      /* purge originators after time in ms if no
+				   * valid packet comes in -> TODO: check
+				   * influence on TQ_LOCAL_WINDOW_SIZE */
 #define LOCAL_HNA_TIMEOUT 3600000
 
-#define TQ_LOCAL_WINDOW_SIZE 64     /* sliding packet range of received originator messages in sequence numbers (should be a multiple of our word size) */
+#define TQ_LOCAL_WINDOW_SIZE 64   /* sliding packet range of received originator
+				   * messages in squence numbers (should be a
+				   * multiple of our word size) */
 #define TQ_GLOBAL_WINDOW_SIZE 10
 #define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
@@ -45,10 +49,12 @@
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define PACKBUFF_SIZE 2000
-#define LOG_BUF_LEN 8192	/* has to be a power of 2 */
+#define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 #define ETH_STR_LEN 20
 
-#define MAX_AGGREGATION_BYTES 512   /* should not be bigger than 512 bytes or change the size of forw_packet->direct_link_flags */
+#define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes or
+				   * change the size of
+				   * forw_packet->direct_link_flags */
 #define MAX_AGGREGATION_MS 100
 
 #define MODULE_INACTIVE 0
@@ -60,10 +66,15 @@
  * Logging
  */
 
-#define LOG_TYPE_CRIT 0		/* highest priority for fatal errors such as blocked sockets / failed packet delivery / programming errors */
-#define LOG_TYPE_WARN 1		/* warnings for  small errors like wrong user input / damaged packets / etc */
-#define LOG_TYPE_NOTICE 2	/* notice information for new interfaces / changed settings / new originators / etc */
-#define LOG_TYPE_BATMAN 4	/* all messages related to routing / flooding / broadcasting / etc */
+#define LOG_TYPE_CRIT 0		/* highest priority for fatal errors such as
+				 * blocked sockets / failed packet delivery /
+				 * programming errors */
+#define LOG_TYPE_WARN 1		/* warnings for small errors like wrong user
+				 * input / damaged packets / etc */
+#define LOG_TYPE_NOTICE 2	/* notice information for new interfaces /
+				 * changed settings / new originators / etc */
+#define LOG_TYPE_BATMAN 4	/* all messages related to routing / flooding /
+				 * broadcasting / etc */
 #define LOG_TYPE_ROUTES 8	/* route or hna added / changed / deleted */
 #define LOG_TYPE_CRIT_NAME	"critical"
 #define LOG_TYPE_WARN_NAME	"warnings"
@@ -85,6 +96,7 @@
 #include <linux/pkt_sched.h>	/* schedule types */
 #include <linux/workqueue.h>	/* workqueue */
 #include <net/sock.h>		/* struct sock */
+#include <linux/jiffies.h>
 #include "types.h"
 
 extern struct list_head if_list;
@@ -109,10 +121,6 @@
 extern char module_state;
 extern struct workqueue_struct *bat_event_workqueue;
 
-
-
-
-
 void start_purge_timer(void);
 void activate_module(void);
 void shutdown_module(void);
