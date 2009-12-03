Return-Path: <sven@narfation.org>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu,  3 Dec 2009 13:13:42 +0100
Message-Id: <1259842422-2566-1-git-send-email-simon.wunderlich@s2003.tu-chemnitz.de>
In-Reply-To: <20091129200950.GA19275@pandem0nium>
References: <20091129200950.GA19275@pandem0nium>
Subject: [B.A.T.M.A.N.] [PATCHv2] [batman-adv] Removing the big batman lock
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

The orig_hash_lock locks big sections of the batman-adv code base, which
might lead to unneccesary performance degradation at some points.

Therefore this patch moves the locking from the whole originator hash
table to individual orig nodes, introducing a reference count based
system to identify whether a node is still in use or can be free()d.

To summarize the changes:

 * when iterating, the hash is only locked while an item is picked from
   the hash. Access to the orig_nodes themselves is no longer protected
   by orig_hash_lock.
 * Each orig_node is referenced when it is used or referenced (e.g. as
   neighbor), and freed when there are no references left. This makes it
   neccesary to carefully reference and unreference nodes.
 * orig_nodes receive an individual spin lock to protect access to their
   data.

Signed-off-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
---
I did some testing, including loading, unloading, killing individual
nodes etc, which seems to be clean so far. However there might be more
race conditions introduced by this large patch, and i'm therefore
requesting a careful review before committing.

It seems to deadlock according to
 https://lists.open-mesh.net/pipermail/b.a.t.m.a.n/2009-December/001938.html

Patch was modified by Sven Eckelmann <sven.eckelmann@gmx.de> to apply
cleanly against r1490.

 batman-adv-kernelland/Makefile.kbuild     |    2 +-
 batman-adv-kernelland/device.c            |   22 ++-
 batman-adv-kernelland/hard-interface.c    |   20 ++--
 batman-adv-kernelland/main.c              |    3 +-
 batman-adv-kernelland/main.h              |    1 -
 batman-adv-kernelland/originator.c        |  161 +++++++++++++++++----
 batman-adv-kernelland/originator.h        |    6 +
 batman-adv-kernelland/proc.c              |   11 +-
 batman-adv-kernelland/routing.c           |  224 +++++++++++++++++------------
 batman-adv-kernelland/send.c              |    2 +
 batman-adv-kernelland/soft-interface.c    |   75 +++++-----
 batman-adv-kernelland/translation-table.c |   10 +-
 batman-adv-kernelland/types.h             |    2 +
 batman-adv-kernelland/vis.c               |   57 ++++----
 14 files changed, 384 insertions(+), 212 deletions(-)

diff --git a/batman-adv-kernelland/Makefile.kbuild b/batman-adv-kernelland/Makefile.kbuild
index cff1185..4b851e0 100644
--- a/batman-adv-kernelland/Makefile.kbuild
+++ b/batman-adv-kernelland/Makefile.kbuild
@@ -25,7 +25,7 @@ ifeq ($(MAKING_MODULES),1)
 -include $(TOPDIR)/Rules.make
 endif
 
-# EXTRA_CFLAGS += -DCONFIG_BATMAN_DEBUG
+EXTRA_CFLAGS += -DCONFIG_BATMAN_DEBUG
 
 ifneq ($(REVISION),)
 EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index 12f2de9..98a6b53 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -24,6 +24,7 @@
 #include "send.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 
 #include "compat.h"
 
@@ -205,6 +206,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	struct icmp_packet icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
+	uint8_t router_addr[ETH_ALEN];
 
 	if (len < sizeof(struct icmp_packet)) {
 		printk(KERN_DEBUG "batman-adv:Error - can't send packet from char device: invalid packet size\n");
@@ -239,15 +241,20 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dst_unreach;
 
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
+	orig_node = orig_find(icmp_packet.dst);
 
 	if (!orig_node)
-		goto unlock;
+		goto dst_unreach;
+
+	spin_lock(&orig_node->lock);
 
 	if (!orig_node->router)
 		goto unlock;
 
+	memcpy(router_addr,
+	       orig_node->router->addr,
+	       ETH_ALEN);
+
 	batman_if = orig_node->batman_if;
 
 	if (!batman_if)
@@ -257,15 +264,18 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	       batman_if->net_dev->dev_addr,
 	       ETH_ALEN);
 
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
+
 	send_raw_packet((unsigned char *)&icmp_packet,
 			sizeof(struct icmp_packet),
-			batman_if, orig_node->router->addr);
+			batman_if, router_addr);
 
-	spin_unlock(&orig_hash_lock);
 	goto out;
 
 unlock:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
 dst_unreach:
 	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
 	bat_device_add_packet(device_client, &icmp_packet);
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index e9cb977..b8af96a 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -26,6 +26,7 @@
 #include "translation-table.h"
 #include "routing.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
 
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
@@ -317,8 +318,9 @@ int hardif_add_interface(char *dev, int if_num)
 {
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	struct hash_it_t *hashit = NULL;
+	int ret;
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_KERNEL);
 
@@ -375,17 +377,17 @@ int hardif_add_interface(char *dev, int if_num)
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock(&orig_hash_lock);
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
-		if (resize_orig(orig_node, if_num) == -1) {
-			spin_unlock(&orig_hash_lock);
-			goto out;
-		}
+	ret = 0;
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
+		ret |= resize_orig(orig_node, if_num);
+	}
+
+	if (ret) {
+		printk(KERN_ERR "batman-adv:Resizing originators for %s failed.\n", batman_if->dev);
+		goto out;
 	}
 
-	spin_unlock(&orig_hash_lock);
 
 	if (!hardif_is_interface_up(batman_if->dev))
 		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): interface not active\n", batman_if->dev);
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index a74bfbe..5477e07 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -23,7 +23,6 @@
 #include "proc.h"
 #include "routing.h"
 #include "send.h"
-#include "originator.h"
 #include "soft-interface.h"
 #include "device.h"
 #include "translation-table.h"
@@ -31,6 +30,7 @@
 #include "types.h"
 #include "vis.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
 
 struct list_head if_list;
@@ -38,7 +38,6 @@ struct hlist_head forw_bat_list;
 struct hlist_head forw_bcast_list;
 struct hashtable_t *orig_hash;
 
-DEFINE_SPINLOCK(orig_hash_lock);
 DEFINE_SPINLOCK(forw_bat_list_lock);
 DEFINE_SPINLOCK(forw_bcast_list_lock);
 
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index 6907cac..225e8d6 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -124,7 +124,6 @@ extern struct hlist_head forw_bat_list;
 extern struct hlist_head forw_bcast_list;
 extern struct hashtable_t *orig_hash;
 
-extern spinlock_t orig_hash_lock;
 extern spinlock_t forw_bat_list_lock;
 extern spinlock_t forw_bcast_list_lock;
 
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 9962af7..3fee416 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -19,17 +19,86 @@
  *
  */
 
-/* increase the reference counter for this originator */
-
 #include "main.h"
-#include "originator.h"
 #include "hash.h"
+#include "originator.h"
 #include "translation-table.h"
 #include "routing.h"
 
 
+DEFINE_SPINLOCK(orig_hash_lock);
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
+/* increase the reference counter for this originator */
+
+struct orig_node *orig_reference(struct orig_node *orig_node)
+{
+	if (orig_node == NULL) {
+		printk(KERN_ERR "batman-adv: tried to reference a NULL orig\n");
+		dump_stack();
+		return NULL;
+	} else if (atomic_read(&orig_node->refcnt) < 1) {
+		printk(KERN_DEBUG "batman-adv: trying to access a vanished node with refcnt %d\n", atomic_read(&orig_node->refcnt));
+		return NULL;
+	} else {
+		atomic_inc(&orig_node->refcnt);
+
+		return orig_node;
+	}
+}
+
+static void __free_orig_node(void *data)
+{
+	struct orig_node *orig_node = (struct orig_node *)data;
+
+	hna_global_del_orig(orig_node, "__free_orig_node");
+
+	kfree(orig_node->bcast_own);
+	kfree(orig_node->bcast_own_sum);
+	kfree(orig_node);
+}
+
+
+/* decrease the reference counter for this originator */
+struct orig_node *orig_unreference(struct orig_node *orig_node)
+{
+	char orig_str[ETH_STR_LEN];
+
+	if (orig_node == NULL) {
+		printk(KERN_ERR "batman-adv: tried to reference a NULL orig\n");
+		dump_stack();
+		return NULL;
+	} else if (atomic_read(&orig_node->refcnt) < 1) {
+		printk(KERN_DEBUG "batman-adv: trying to access a vanished node with refcnt %d\n", atomic_read(&orig_node->refcnt));
+		return NULL;
+	} else {
+
+		if (atomic_dec_and_test(&orig_node->refcnt)) {
+			addr_to_string(orig_str, orig_node->orig);
+			bat_dbg(DBG_BATMAN,"%s:decreasing refcnt of orig %s to %d, time to free\n", __func__, orig_str, atomic_read(&orig_node->refcnt));
+			__free_orig_node(orig_node);
+		}
+		return orig_node;
+	}
+}
+
+
+/* find an orig node and increase the reference counter */
+
+struct orig_node *orig_find(char *mac)
+{
+	struct orig_node *orig_node;
+
+	spin_lock(&orig_hash_lock);
+	orig_node = ((struct orig_node *)hash_find(orig_hash, mac));
+	spin_unlock(&orig_hash_lock);
+
+	if (orig_node)
+		orig_node = orig_reference(orig_node);
+
+	return orig_node;
+}
+
 static void start_purge_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &purge_orig_wq, 1 * HZ);
@@ -64,6 +133,7 @@ void originator_free(void)
 
 	spin_lock(&orig_hash_lock);
 	hash_delete(orig_hash, free_orig_node);
+
 	orig_hash = NULL;
 	spin_unlock(&orig_hash_lock);
 }
@@ -81,7 +151,7 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 	INIT_LIST_HEAD(&neigh_node->list);
 
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
-	neigh_node->orig_node = orig_neigh_node;
+	neigh_node->orig_node = orig_reference(orig_neigh_node);
 	neigh_node->if_incoming = if_incoming;
 
 	list_add_tail(&neigh_node->list, &orig_node->neigh_list);
@@ -90,39 +160,35 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 
 void free_orig_node(void *data)
 {
+	struct orig_node *orig_node = (struct orig_node *) data;
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
-	struct orig_node *orig_node = (struct orig_node *)data;
 
+	hna_global_del_orig(orig_node, "originator timeout");
+
+	spin_lock(&orig_node->lock);
 	/* for all neighbours towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
 
+		orig_unreference(neigh_node->orig_node);
+
 		list_del(list_pos);
 		kfree(neigh_node);
 	}
+	orig_node->router = NULL;
+	spin_unlock(&orig_node->lock);
 
-	hna_global_del_orig(orig_node, "originator timed out");
-
-	kfree(orig_node->bcast_own);
-	kfree(orig_node->bcast_own_sum);
-	kfree(orig_node);
+	orig_unreference(orig_node);
 }
 
-/* this function finds or creates an originator entry for the given
- * address if it does not exits */
-struct orig_node *get_orig_node(uint8_t *addr)
+struct orig_node *orig_node_create(uint8_t *addr)
 {
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
 	char orig_str[ETH_STR_LEN];
 	int size;
 
-	orig_node = ((struct orig_node *)hash_find(orig_hash, addr));
-
-	if (orig_node != NULL)
-		return orig_node;
-
 	addr_to_string(orig_str, addr);
 	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
 
@@ -131,9 +197,12 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	INIT_LIST_HEAD(&orig_node->neigh_list);
 
 	memcpy(orig_node->orig, addr, ETH_ALEN);
+
+	orig_node->lock = __SPIN_LOCK_UNLOCKED(device_client->lock);
 	orig_node->router = NULL;
 	orig_node->batman_if = NULL;
 	orig_node->hna_buff = NULL;
+	atomic_set(&orig_node->refcnt, 1);
 
 	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
 
@@ -155,6 +224,23 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		else
 			orig_hash = swaphash;
 	}
+	return orig_node;
+}
+
+/* this function finds or creates an originator entry for the given
+ * address if it does not exits */
+struct orig_node *get_orig_node(uint8_t *addr)
+{
+	struct orig_node *orig_node;
+
+	orig_node = orig_find(addr);
+
+	if (orig_node)
+		return orig_node;
+
+	orig_node = orig_node_create(addr);
+	if (orig_node)
+		orig_node = orig_reference(orig_node_create(addr));
 
 	return orig_node;
 }
@@ -181,8 +267,11 @@ static bool purge_orig_neigbours(struct orig_node *orig_node,
 			addr_to_string(neigh_str, neigh_node->addr);
 			addr_to_string(orig_str, orig_node->orig);
 			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
-
 			neigh_purged = true;
+			if (neigh_node == orig_node->router)
+				orig_node->router = NULL;
+
+			orig_unreference(neigh_node->orig_node);
 			list_del(list_pos);
 			kfree(neigh_node);
 		} else {
@@ -202,10 +291,10 @@ static bool purge_orig_node(struct orig_node *orig_node)
 
 	addr_to_string(orig_str, orig_node->orig);
 
+	spin_lock(&orig_node->lock);
 	if (time_after(jiffies,
 		       (orig_node->last_valid +
 			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
-
 		bat_dbg(DBG_BATMAN,
 			"Originator timeout: originator %s, last_valid %lu\n",
 			orig_str, (orig_node->last_valid / HZ));
@@ -216,28 +305,48 @@ static bool purge_orig_node(struct orig_node *orig_node)
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
 	}
+	spin_unlock(&orig_node->lock);
 	return false;
 }
 
 void purge_orig(struct work_struct *work)
 {
 	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 
-	spin_lock(&orig_hash_lock);
 
 	/* for all origins... */
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
+
 		if (purge_orig_node(orig_node)) {
 			hash_remove_bucket(orig_hash, hashit);
 			free_orig_node(orig_node);
 		}
 	}
 
-	spin_unlock(&orig_hash_lock);
-
 	start_purge_timer();
 }
 
 
+/* iterates over the originator hash, automatically referencing acquired orig_nodes.
+ * It also unreferences the last node if it is given.
+ *
+ * The calling function does not have to handle the orig_hash locks as this function
+ * does it. */
+struct orig_node *orig_hash_iterate(struct hash_it_t **hashit, struct orig_node *orig_node)
+{
+	if (orig_node)
+		orig_unreference(orig_node);
+
+	spin_lock(&orig_hash_lock);
+
+	*hashit = hash_iterate(orig_hash, *hashit);
+	if (*hashit)
+		orig_node = orig_reference((*hashit)->bucket->data);
+	else
+		orig_node = NULL;
+
+	spin_unlock(&orig_hash_lock);
+
+	return orig_node;
+}
diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/originator.h
index 6ef7a05..6a6561f 100644
--- a/batman-adv-kernelland/originator.h
+++ b/batman-adv-kernelland/originator.h
@@ -19,6 +19,8 @@
  *
  */
 
+extern spinlock_t orig_hash_lock;
+
 int originator_init(void);
 void free_orig_node(void *data);
 void originator_free(void);
@@ -28,4 +30,8 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
+struct orig_node *orig_reference(struct orig_node *orig);
+struct orig_node *orig_unreference(struct orig_node *orig);
+struct orig_node *orig_find(char *mac);
+struct orig_node *orig_hash_iterate(struct hash_it_t **hashit, struct orig_node *orig_node);
 
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index ed4c734..184b538 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -28,6 +28,7 @@
 #include "hash.h"
 #include "vis.h"
 #include "compat.h"
+#include "originator.h"
 
 static uint8_t vis_format = DOT_DRAW;
 
@@ -187,7 +188,7 @@ static int proc_orig_interval_open(struct inode *inode, struct file *file)
 static int proc_originators_read(struct seq_file *seq, void *offset)
 {
 	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node;
 	int batman_count = 0;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
@@ -213,11 +214,10 @@ static int proc_originators_read(struct seq_file *seq, void *offset)
 		   ((struct batman_if *)if_list.next)->addr_str);
 
 	rcu_read_unlock();
-	spin_lock(&orig_hash_lock);
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
 
-		orig_node = hashit->bucket->data;
+		spin_lock(&orig_node->lock);
 
 		if (!orig_node->router)
 			continue;
@@ -241,11 +241,10 @@ static int proc_originators_read(struct seq_file *seq, void *offset)
 		}
 
 		seq_printf(seq, "\n");
+		spin_unlock(&orig_node->lock);
 
 	}
 
-	spin_unlock(&orig_hash_lock);
-
 	if (batman_count == 0)
 		seq_printf(seq, "No batman nodes in range ... \n");
 
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index f4be6be..a70dd18 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -38,24 +38,21 @@ DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
 static atomic_t data_ready_cond;
 atomic_t exit_cond;
+
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	TYPE_OF_WORD *word;
 
-	spin_lock(&orig_hash_lock);
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
 		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
 
 		bit_get_packet(word, 1, 0);
 		orig_node->bcast_own_sum[batman_if->if_num] =
 			bit_packet_count(word);
 	}
-
-	spin_unlock(&orig_hash_lock);
 }
 
 static void update_HNA(struct orig_node *orig_node,
@@ -131,6 +128,8 @@ void update_routes(struct orig_node *orig_node,
 		update_HNA(orig_node, hna_buff, hna_buff_len);
 }
 
+/* TODO: rename and comment this function */
+/* TODO: review referencing here */
 static int isBidirectionalNeigh(struct orig_node *orig_node,
 				struct orig_node *orig_neigh_node,
 				struct batman_packet *batman_packet,
@@ -144,25 +143,29 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 	addr_to_string(neigh_str, orig_neigh_node->orig);
 
 	if (orig_node == orig_neigh_node) {
+		spin_lock(&orig_node->lock);
 		list_for_each_entry(tmp_neigh_node,
 				    &orig_node->neigh_list,
 				    list) {
 
 			if (compare_orig(tmp_neigh_node->addr,
-					 orig_neigh_node->orig) &&
+					 orig_node->orig) &&
 			    (tmp_neigh_node->if_incoming == if_incoming))
 				neigh_node = tmp_neigh_node;
 		}
 
 		if (neigh_node == NULL)
 			neigh_node = create_neighbor(orig_node,
-						     orig_neigh_node,
-						     orig_neigh_node->orig,
+						     orig_node,
+						     orig_node->orig,
 						     if_incoming);
 
 		neigh_node->last_valid = jiffies;
+		spin_unlock(&orig_node->lock);
 	} else {
 		/* find packet count of corresponding one hop neighbor */
+		spin_lock(&orig_neigh_node->lock);
+
 		list_for_each_entry(tmp_neigh_node,
 				    &orig_neigh_node->neigh_list, list) {
 
@@ -177,6 +180,7 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 						     orig_neigh_node,
 						     orig_neigh_node->orig,
 						     if_incoming);
+		spin_unlock(&orig_neigh_node->lock);
 	}
 
 	orig_node->last_valid = jiffies;
@@ -239,6 +243,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
 {
+	struct orig_node *source_orig_node;
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
@@ -260,11 +265,13 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 	}
 
-	if (neigh_node == NULL)
+	if (neigh_node == NULL) {
+		source_orig_node = get_orig_node(ethhdr->h_source);
 		neigh_node = create_neighbor(orig_node,
-					     get_orig_node(ethhdr->h_source),
+					     source_orig_node,
 					     ethhdr->h_source, if_incoming);
-	else
+		orig_unreference(source_orig_node);
+	} else
 		bat_dbg(DBG_BATMAN,
 			"Updating existing last-hop neighbour of originator\n");
 
@@ -323,6 +330,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	if (orig_node == NULL)
 		return 0;
 
+	spin_lock(&orig_node->lock);
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 
 		if (!is_duplicate)
@@ -346,10 +354,13 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
 
 	return is_duplicate;
 }
 
+/* receive and handle one batman packet */
 void receive_bat_packet(struct ethhdr *ethhdr,
 			struct batman_packet *batman_packet,
 			unsigned char *hna_buff,
@@ -448,10 +459,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		 * come via the corresponding interface */
 		/* if received seqno equals last send seqno save new
 		 * seqno for bidirectional check */
+
+		spin_lock(&orig_neigh_node->lock);
 		if (has_directlink_flag &&
 		    compare_orig(if_incoming->net_dev->dev_addr,
 				 batman_packet->orig) &&
 		    (batman_packet->seqno - if_incoming_seqno + 2 == 0)) {
+
 			offset = if_incoming->if_num * NUM_WORDS;
 			word = &(orig_neigh_node->bcast_own[offset]);
 			bit_mark(word, 0);
@@ -459,6 +473,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				bit_packet_count(word);
 		}
 
+		spin_unlock(&orig_neigh_node->lock);
+		orig_unreference(orig_neigh_node);
+
 		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via neighbour) \n");
 		return;
 	}
@@ -481,6 +498,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	if (orig_node == NULL)
 		return;
 
+	spin_lock(&orig_node->lock);
+
 	/* avoid temporary routing loops */
 	if ((orig_node->router) &&
 	    (orig_node->router->orig_node->router) &&
@@ -489,36 +508,49 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
+
 		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %s) \n", neigh_str);
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 		return;
 	}
+	spin_unlock(&orig_node->lock);
 
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac */
 	orig_neigh_node = (is_single_hop_neigh ?
-			   orig_node : get_orig_node(ethhdr->h_source));
-	if (orig_neigh_node == NULL)
+			   orig_reference(orig_node) : get_orig_node(ethhdr->h_source));
+	if (orig_neigh_node == NULL) {
+		orig_unreference(orig_node);
 		return;
+	}
 
 	/* drop packet if sender is not a direct neighbor and if we
 	 * don't route towards it */
 	if (!is_single_hop_neigh &&
 	    (orig_neigh_node->router == NULL)) {
 		bat_dbg(DBG_BATMAN, "Drop packet: OGM via unknown neighbor!\n");
+
+		orig_unreference(orig_node);
+		orig_unreference(orig_neigh_node);
 		return;
 	}
 
 	is_bidirectional = isBidirectionalNeigh(orig_node, orig_neigh_node,
 						batman_packet, if_incoming);
+	orig_unreference(orig_neigh_node);
 
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate */
+	spin_lock(&orig_node->lock);
 	if (is_bidirectional &&
 	    (!is_duplicate ||
 	     ((orig_node->last_real_seqno == batman_packet->seqno) &&
 	      (orig_node->last_ttl - 3 <= batman_packet->ttl))))
 		update_orig(orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
+	spin_unlock(&orig_node->lock);
 
 	/* is single hop (direct) neighbour */
 	if (is_single_hop_neigh) {
@@ -528,6 +560,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 					1, hna_buff_len, if_incoming);
 
 		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbour packet with direct link flag\n");
+		orig_unreference(orig_node);
 		return;
 	}
 
@@ -535,11 +568,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	if (!is_bidirectional) {
 		bat_dbg(DBG_BATMAN,
 			"Drop packet: not received via bidirectional link\n");
+		orig_unreference(orig_node);
 		return;
 	}
 
 	if (is_duplicate) {
 		bat_dbg(DBG_BATMAN, "Drop packet: duplicate packet received\n");
+		orig_unreference(orig_node);
 		return;
 	}
 
@@ -547,6 +582,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		"Forwarding packet: rebroadcast originator packet\n");
 	schedule_forward_packet(orig_node, ethhdr, batman_packet,
 				0, hna_buff_len, if_incoming);
+	orig_unreference(orig_node);
 }
 
 
@@ -585,12 +621,10 @@ static void recv_bat_packet(struct ethhdr *ethhdr,
 	if (result < sizeof(struct ethhdr) + sizeof(struct batman_packet))
 		return;
 
-	spin_lock(&orig_hash_lock);
 	receive_aggr_bat_packet(ethhdr,
 				packet_buff + sizeof(struct ethhdr),
 				result - sizeof(struct ethhdr),
 				batman_if);
-	spin_unlock(&orig_hash_lock);
 }
 
 static void recv_my_icmp_packet(struct ethhdr *ethhdr,
@@ -608,25 +642,28 @@ static void recv_my_icmp_packet(struct ethhdr *ethhdr,
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)hash_find(orig_hash,
-						   icmp_packet->orig));
-
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
-		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
-		icmp_packet->msg_type = ECHO_REPLY;
-		icmp_packet->ttl = TTL;
-
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+	orig_node = orig_find(icmp_packet->orig);
+
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
+
+		if ((orig_node->batman_if != NULL) &&
+		    (orig_node->router != NULL)) {
+			memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+			memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
+			icmp_packet->msg_type = ECHO_REPLY;
+			icmp_packet->ttl = TTL;
+
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
 
-	spin_unlock(&orig_hash_lock);
 	return;
 }
 
@@ -642,33 +679,32 @@ static void recv_icmp_ttl_exceeded(struct icmp_packet *icmp_packet,
 	addr_to_string(src_str, icmp_packet->orig);
 	addr_to_string(dst_str, icmp_packet->dst);
 
-	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
-
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST)
 		return;
 
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, icmp_packet->orig));
-
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
-		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
-		icmp_packet->msg_type = TTL_EXCEEDED;
-		icmp_packet->ttl = TTL;
-
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+	orig_node = orig_find(icmp_packet->orig);
+
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
+
+		if ((orig_node->batman_if != NULL) &&
+		    (orig_node->router != NULL)) {
+			memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+			memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
+			icmp_packet->msg_type = TTL_EXCEEDED;
+			icmp_packet->ttl = TTL;
+
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
 
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
-
-	spin_unlock(&orig_hash_lock);
 }
 
 
@@ -713,24 +749,27 @@ static void recv_icmp_packet(struct ethhdr *ethhdr,
 	}
 
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, icmp_packet->dst));
+	orig_node = orig_find(icmp_packet->dst);
 
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
 
-		/* decrement ttl */
-		icmp_packet->ttl--;
+	    if ((orig_node->batman_if != NULL) &&
+		    (orig_node->router != NULL)) {
+
+			/* decrement ttl */
+			icmp_packet->ttl--;
+
+			/* route it */
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 
-		/* route it */
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
 	}
-	spin_unlock(&orig_hash_lock);
 }
 
 static void recv_unicast_packet(struct ethhdr *ethhdr,
@@ -781,23 +820,26 @@ static void recv_unicast_packet(struct ethhdr *ethhdr,
 	}
 
 	/* get routing information */
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, unicast_packet->dest));
-
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
-		/* decrement ttl */
-		unicast_packet->ttl--;
-
-		/* route it */
-		send_raw_packet(packet_buff + sizeof(struct ethhdr),
-				result - sizeof(struct ethhdr),
-				orig_node->batman_if,
-				orig_node->router->addr);
+	orig_node = orig_find(unicast_packet->dest);
+
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
+
+	    if ((orig_node->batman_if != NULL) &&
+		    (orig_node->router != NULL)) {
+			/* decrement ttl */
+			unicast_packet->ttl--;
+
+			/* route it */
+			send_raw_packet(packet_buff + sizeof(struct ethhdr),
+					result - sizeof(struct ethhdr),
+					orig_node->batman_if,
+					orig_node->router->addr);
+		}
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
-	spin_unlock(&orig_hash_lock);
 }
 
 
@@ -833,20 +875,19 @@ static void recv_bcast_packet(struct ethhdr *ethhdr,
 	if (is_my_mac(bcast_packet->orig))
 		return;
 
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, bcast_packet->orig));
+	orig_node = orig_find(bcast_packet->orig);
 
-	if (orig_node == NULL) {
-		spin_unlock(&orig_hash_lock);
+	if (!orig_node)
 		return;
-	}
+
+	spin_lock(&orig_node->lock);
 
 	/* check flood history */
 	if (get_bit_status(orig_node->bcast_bits,
 			   orig_node->last_bcast_seqno,
 			   ntohs(bcast_packet->seqno))) {
-		spin_unlock(&orig_hash_lock);
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 		return;
 	}
 
@@ -856,7 +897,8 @@ static void recv_bcast_packet(struct ethhdr *ethhdr,
 			   orig_node->last_bcast_seqno, 1))
 		orig_node->last_bcast_seqno = ntohs(bcast_packet->seqno);
 
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
 
 	/* broadcast for me */
 	interface_rx(soft_device, packet_buff + hdr_size, result - hdr_size);
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 2712b03..3f7616a 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -294,6 +294,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	batman_packet->ttl--;
 	memcpy(batman_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
 
+	spin_lock(&orig_node->lock);
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
 	 * of our best tq value */
 	if ((orig_node->router) && (orig_node->router->tq_avg != 0)) {
@@ -308,6 +309,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 
 		tq_avg = orig_node->router->tq_avg;
 	}
+	spin_unlock(&orig_node->lock);
 
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index 168a4e1..286ae99 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -26,6 +26,7 @@
 #include "translation-table.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include "compat.h"
@@ -34,7 +35,6 @@ static uint16_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 				  * broadcast storms */
 static int32_t skb_packets;
 static int32_t skb_bad_packets;
-static int32_t lock_dropped;
 
 unsigned char mainIfAddr[ETH_ALEN];
 static unsigned char mainIfAddr_default[ETH_ALEN];
@@ -205,60 +205,55 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	/* unicast packet */
 	} else {
 
-		/* simply spin_lock()ing can deadlock when the lock is already
-		 * hold. */
-		/* TODO: defer the work in a working queue instead of
-		 * dropping */
-		if (!spin_trylock(&orig_hash_lock)) {
-			lock_dropped++;
-			printk(KERN_WARNING "batman-adv:%d packets dropped because lock was hold\n", lock_dropped);
-			goto dropped;
-		}
-
 		/* get routing information */
-		orig_node = ((struct orig_node *)hash_find(orig_hash,
-							   ethhdr->h_dest));
+		orig_node = orig_find(ethhdr->h_dest);
 
 		/* check for hna host */
 		if (!orig_node)
 			orig_node = transtable_search(ethhdr->h_dest);
 
-		if ((orig_node) &&
-		    (orig_node->batman_if) &&
-		    (orig_node->router)) {
-			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
-				goto unlock;
-
-			unicast_packet = (struct unicast_packet *)skb->data;
-
-			unicast_packet->version = COMPAT_VERSION;
-			/* batman packet type: unicast */
-			unicast_packet->packet_type = BAT_UNICAST;
-			/* set unicast ttl */
-			unicast_packet->ttl = TTL;
-			/* copy the destination for faster routing */
-			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-
-			/* net_dev won't be available when not active */
-			if (orig_node->batman_if->if_active != IF_ACTIVE)
-				goto unlock;
-
-			send_raw_packet(skb->data, skb->len,
-					orig_node->batman_if,
-					orig_node->router->addr);
-		} else {
+		if (!orig_node)
+			goto dropped;
+
+		spin_lock(&orig_node->lock);
+
+	    if (!((orig_node->batman_if) &&
+		    (orig_node->router)))
+			goto unlock;
+
+		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
 			goto unlock;
-		}
 
-		spin_unlock(&orig_hash_lock);
+		unicast_packet = (struct unicast_packet *)skb->data;
+
+		unicast_packet->version = COMPAT_VERSION;
+		/* batman packet type: unicast */
+		unicast_packet->packet_type = BAT_UNICAST;
+		/* set unicast ttl */
+		unicast_packet->ttl = TTL;
+		/* copy the destination for faster routing */
+		memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+
+		/* net_dev won't be available when not active */
+		if (orig_node->batman_if->if_active != IF_ACTIVE)
+			goto unlock;
+
+		send_raw_packet(skb->data, skb->len,
+			orig_node->batman_if,
+			orig_node->router->addr);
+
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
 
 	priv->stats.tx_packets++;
 	priv->stats.tx_bytes += data_len;
 	goto end;
 
+
 unlock:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&orig_node->lock);
+	orig_unreference(orig_node);
 dropped:
 	priv->stats.tx_dropped++;
 end:
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index c7122da..c4134f5 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -24,6 +24,7 @@
 #include "soft-interface.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
 
 struct hashtable_t *hna_local_hash;
@@ -257,6 +258,9 @@ int hna_global_init(void)
 	return 1;
 }
 
+
+/* adds an HNA entry to the global address table.
+ * orig_node's spinlock should be hold from outside */
 void hna_global_add_orig(struct orig_node *orig_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
@@ -299,7 +303,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 
 		}
 
-		hna_global_entry->orig_node = orig_node;
+		hna_global_entry->orig_node = orig_reference(orig_node);
 		spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 
 		/* remove address from local hash if present */
@@ -391,6 +395,8 @@ void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 		hna_str, orig_str, message);
 
 	hash_remove(hna_global_hash, hna_global_entry->addr);
+	orig_unreference(hna_global_entry->orig_node);
+
 	kfree(hna_global_entry);
 }
 
@@ -452,5 +458,5 @@ struct orig_node *transtable_search(uint8_t *addr)
 	if (hna_global_entry == NULL)
 		return NULL;
 
-	return hna_global_entry->orig_node;
+	return orig_reference(hna_global_entry->orig_node);
 }
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index 3a0ef0c..877e0a9 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -62,6 +62,8 @@ struct orig_node {               /* structure for orig_list maintaining nodes of
 	int16_t  hna_buff_len;
 	uint16_t last_real_seqno;   /* last and best known squence number */
 	uint8_t last_ttl;         /* ttl of last received packet */
+	spinlock_t lock;
+	atomic_t refcnt;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint16_t last_bcast_seqno;  /* last broadcast sequence number received by this host */
 	struct list_head neigh_list;
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index cdb8aab..7fe8708 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -26,6 +26,7 @@
 #include "soft-interface.h"
 #include "hard-interface.h"
 #include "hash.h"
+#include "originator.h"
 #include "compat.h"
 
 struct hashtable_t *vis_hash;
@@ -262,16 +263,16 @@ end:
 
 /* Walk the originators and find the VIS server with the best tq. Set the packet
  * address to its address and return the best_tq.
- *
- * Must be called with the originator hash locked */
+ */
 static int find_best_vis_server(struct vis_info *info)
 {
 	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	int best_tq = -1;
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
+
+		spin_lock(&orig_node->lock);
 		if ((orig_node != NULL) &&
 		    (orig_node->router != NULL) &&
 		    (orig_node->flags & VIS_SERVER) &&
@@ -280,6 +281,7 @@ static int find_best_vis_server(struct vis_info *info)
 			memcpy(info->packet.target_orig, orig_node->orig,
 			       ETH_ALEN);
 		}
+		spin_unlock(&orig_node->lock);
 	}
 	return best_tq;
 }
@@ -298,7 +300,7 @@ static bool vis_packet_full(struct vis_info *info)
 static int generate_vis_packet(void)
 {
 	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	struct vis_info *info = (struct vis_info *)my_vis_info;
 	struct vis_info_entry *entry, *entry_array;
 	struct hna_local_entry *hna_local_entry;
@@ -307,7 +309,6 @@ static int generate_vis_packet(void)
 
 	info->first_seen = jiffies;
 
-	spin_lock(&orig_hash_lock);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 	info->packet.ttl = TTL;
 	info->packet.seqno++;
@@ -316,17 +317,17 @@ static int generate_vis_packet(void)
 	if (!is_vis_server_locked()) {
 		best_tq = find_best_vis_server(info);
 		if (best_tq < 0) {
-			spin_unlock(&orig_hash_lock);
 			return -1;
 		}
 	}
-	hashit = NULL;
 
 	entry_array = (struct vis_info_entry *)
 		((char *)info + sizeof(struct vis_info));
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
+
+		spin_lock(&orig_node->lock);
+
 		if (orig_node->router != NULL
 			&& compare_orig(orig_node->router->addr, orig_node->orig)
 			&& orig_node->batman_if
@@ -340,15 +341,16 @@ static int generate_vis_packet(void)
 			entry->quality = orig_node->router->tq_avg;
 			info->packet.entries++;
 
+			/* TODO: this is is a possible memory leak,
+			 * hashit should be freed somewhere. */
 			if (vis_packet_full(info)) {
-				spin_unlock(&orig_hash_lock);
+				spin_unlock(&orig_node->lock);
+				orig_unreference(orig_node);
 				return 0;
 			}
 		}
 	}
 
-	spin_unlock(&orig_hash_lock);
-
 	hashit = NULL;
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 	while (NULL != (hashit = hash_iterate(hna_local_hash, hashit))) {
@@ -388,14 +390,12 @@ static void purge_vis_packets(void)
 static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
-
-	spin_lock(&orig_hash_lock);
+	struct orig_node *orig_node = NULL;
 
 	/* send to all routers in range. */
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {
 
+		spin_lock(&orig_node->lock);
 		/* if it's a vis server and reachable, send it. */
 		if (orig_node &&
 		    (orig_node->flags & VIS_SERVER) &&
@@ -415,27 +415,28 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 					orig_node->batman_if,
 					orig_node->router->addr);
 		}
+		spin_unlock(&orig_node->lock);
 	}
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-	spin_unlock(&orig_hash_lock);
 }
 
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
 
-	spin_lock(&orig_hash_lock);
-	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, info->packet.target_orig));
+	orig_node = orig_find(info->packet.target_orig);
 
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
-		send_raw_packet((unsigned char *) &info->packet, packet_length,
+	if (orig_node) {
+		spin_lock(&orig_node->lock);
+	    if ((orig_node->batman_if != NULL) &&
+	        (orig_node->router != NULL)) {
+			send_raw_packet((unsigned char *) &info->packet, packet_length,
 				orig_node->batman_if,
 				orig_node->router->addr);
+		}
+		spin_unlock(&orig_node->lock);
+		orig_unreference(orig_node);
 	}
-	spin_unlock(&orig_hash_lock);
 }
 
 /* only send one vis packet. called from send_vis_packets() */
-- 
1.6.5.3

