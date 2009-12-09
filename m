Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:28 +0100
Message-Id: <1260389373-1071-6-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-5-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
	<1260389373-1071-5-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 05/10] staging:batman-adv:split originator
	handling parts off routing.c
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
To: gregkh@suse.de
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net

From: simon <simon@45894c77-fb22-0410-b583-ff6e7d5dbf6c>

Signed-off-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
git-svn-id: http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland@1488 45894c77-fb22-0410-b583-ff6e7d5dbf6c
---
 Makefile.kbuild |    2 +-
 main.c          |    1 +
 originator.c    |  242 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 originator.h    |   31 +++++++
 routing.c       |  215 +------------------------------------------------
 routing.h       |   12 ++-
 6 files changed, 285 insertions(+), 218 deletions(-)
 create mode 100644 originator.c
 create mode 100644 originator.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 401f648..cff1185 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -32,4 +32,4 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o
+batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o
diff --git a/main.c b/main.c
index 4b93a5d..a74bfbe 100644
--- a/main.c
+++ b/main.c
@@ -23,6 +23,7 @@
 #include "proc.h"
 #include "routing.h"
 #include "send.h"
+#include "originator.h"
 #include "soft-interface.h"
 #include "device.h"
 #include "translation-table.h"
diff --git a/originator.c b/originator.c
new file mode 100644
index 0000000..d0640a7
--- /dev/null
+++ b/originator.c
@@ -0,0 +1,242 @@
+/*
+ * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+/* increase the reference counter for this originator */
+
+#include "main.h"
+#include "originator.h"
+#include "hash.h"
+#include "translation-table.h"
+#include "routing.h"
+
+
+static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
+
+static void start_purge_timer(void)
+{
+	queue_delayed_work(bat_event_workqueue, &purge_orig_wq, 1 * HZ);
+}
+
+int originator_init(void)
+{
+	if (orig_hash)
+		return 1;
+
+	spin_lock(&orig_hash_lock);
+	orig_hash = hash_new(128, compare_orig, choose_orig);
+
+	if (!orig_hash)
+		goto err;
+
+	spin_unlock(&orig_hash_lock);
+	start_purge_timer();
+	return 1;
+
+err:
+	spin_unlock(&orig_hash_lock);
+	return 0;
+}
+
+void originator_free(void)
+{
+	if (!orig_hash)
+		return;
+
+	cancel_delayed_work_sync(&purge_orig_wq);
+
+	spin_lock(&orig_hash_lock);
+	hash_delete(orig_hash, free_orig_node);
+	orig_hash = NULL;
+	spin_unlock(&orig_hash_lock);
+}
+
+struct neigh_node *
+create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
+		uint8_t *neigh, struct batman_if *if_incoming)
+{
+	struct neigh_node *neigh_node;
+
+	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbour of originator\n");
+
+	neigh_node = kmalloc(sizeof(struct neigh_node), GFP_ATOMIC);
+	memset(neigh_node, 0, sizeof(struct neigh_node));
+	INIT_LIST_HEAD(&neigh_node->list);
+
+	memcpy(neigh_node->addr, neigh, ETH_ALEN);
+	neigh_node->orig_node = orig_neigh_node;
+	neigh_node->if_incoming = if_incoming;
+
+	list_add_tail(&neigh_node->list, &orig_node->neigh_list);
+	return neigh_node;
+}
+
+void free_orig_node(void *data)
+{
+	struct list_head *list_pos, *list_pos_tmp;
+	struct neigh_node *neigh_node;
+	struct orig_node *orig_node = (struct orig_node *)data;
+
+	/* for all neighbours towards this originator ... */
+	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
+		neigh_node = list_entry(list_pos, struct neigh_node, list);
+
+		list_del(list_pos);
+		kfree(neigh_node);
+	}
+
+	hna_global_del_orig(orig_node, "originator timed out");
+
+	kfree(orig_node->bcast_own);
+	kfree(orig_node->bcast_own_sum);
+	kfree(orig_node);
+}
+
+/* this function finds or creates an originator entry for the given
+ * address if it does not exits */
+struct orig_node *get_orig_node(uint8_t *addr)
+{
+	struct orig_node *orig_node;
+	struct hashtable_t *swaphash;
+	char orig_str[ETH_STR_LEN];
+	int size;
+
+	orig_node = ((struct orig_node *)hash_find(orig_hash, addr));
+
+	if (orig_node != NULL)
+		return orig_node;
+
+	addr_to_string(orig_str, addr);
+	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
+
+	orig_node = kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
+	memset(orig_node, 0, sizeof(struct orig_node));
+	INIT_LIST_HEAD(&orig_node->neigh_list);
+
+	memcpy(orig_node->orig, addr, ETH_ALEN);
+	orig_node->router = NULL;
+	orig_node->batman_if = NULL;
+	orig_node->hna_buff = NULL;
+
+	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
+
+	orig_node->bcast_own = kmalloc(size, GFP_ATOMIC);
+	memset(orig_node->bcast_own, 0, size);
+
+	size = num_ifs * sizeof(uint8_t);
+	orig_node->bcast_own_sum = kmalloc(size, GFP_ATOMIC);
+	memset(orig_node->bcast_own_sum, 0, size);
+
+	hash_add(orig_hash, orig_node);
+
+	if (orig_hash->elements * 4 > orig_hash->size) {
+		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
+
+		if (swaphash == NULL)
+			printk(KERN_ERR
+			       "batman-adv:Couldn't resize orig hash table \n");
+		else
+			orig_hash = swaphash;
+	}
+
+	return orig_node;
+}
+
+static bool purge_orig_neigbours(struct orig_node *orig_node,
+				 struct neigh_node **best_neigh_node)
+{
+	struct list_head *list_pos, *list_pos_tmp;
+	char neigh_str[ETH_STR_LEN];
+	struct neigh_node *neigh_node;
+	bool neigh_purged = false;
+
+	*best_neigh_node = NULL;
+
+
+	/* for all neighbours towards this originator ... */
+	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
+		neigh_node = list_entry(list_pos, struct neigh_node, list);
+
+		if (time_after(jiffies,
+			       (neigh_node->last_valid +
+				((PURGE_TIMEOUT * HZ) / 1000)))) {
+
+			addr_to_string(neigh_str, neigh_node->addr);
+			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
+
+			neigh_purged = true;
+			list_del(list_pos);
+			kfree(neigh_node);
+		} else {
+			if ((*best_neigh_node == NULL) ||
+			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
+				*best_neigh_node = neigh_node;
+		}
+	}
+	return neigh_purged;
+}
+
+
+static bool purge_orig_node(struct orig_node *orig_node)
+{
+	struct neigh_node *best_neigh_node;
+	char orig_str[ETH_STR_LEN];
+
+	addr_to_string(orig_str, orig_node->orig);
+
+	if (time_after(jiffies,
+		       (orig_node->last_valid +
+			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
+
+		bat_dbg(DBG_BATMAN,
+			"Originator timeout: originator %s, last_valid %lu\n",
+			orig_str, (orig_node->last_valid / HZ));
+		return true;
+	} else {
+		if (purge_orig_neigbours(orig_node, &best_neigh_node))
+			update_routes(orig_node, best_neigh_node,
+				      orig_node->hna_buff,
+				      orig_node->hna_buff_len);
+	}
+	return false;
+}
+
+void purge_orig(struct work_struct *work)
+{
+	struct hash_it_t *hashit = NULL;
+	struct orig_node *orig_node;
+
+	spin_lock(&orig_hash_lock);
+
+	/* for all origins... */
+	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
+		orig_node = hashit->bucket->data;
+		if (purge_orig_node(orig_node)) {
+			hash_remove_bucket(orig_hash, hashit);
+			free_orig_node(orig_node);
+		}
+	}
+
+	spin_unlock(&orig_hash_lock);
+
+	start_purge_timer();
+}
+
+
diff --git a/originator.h b/originator.h
new file mode 100644
index 0000000..6ef7a05
--- /dev/null
+++ b/originator.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+int originator_init(void);
+void free_orig_node(void *data);
+void originator_free(void);
+void purge_orig(struct work_struct *work);
+struct orig_node *orig_find(char *mac);
+struct orig_node *get_orig_node(uint8_t *addr);
+struct neigh_node *
+create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
+		uint8_t *neigh, struct batman_if *if_incoming);
+
diff --git a/routing.c b/routing.c
index 26320d5..e7eb766 100644
--- a/routing.c
+++ b/routing.c
@@ -22,152 +22,22 @@
 #include "main.h"
 #include "routing.h"
 #include "send.h"
+#include "hash.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
 #include "device.h"
 #include "translation-table.h"
+#include "originator.h"
 #include "types.h"
-#include "hash.h"
 #include "ring_buffer.h"
 #include "vis.h"
 #include "aggregation.h"
 #include "compat.h"
 
 DECLARE_WAIT_QUEUE_HEAD(thread_wait);
-static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
 static atomic_t data_ready_cond;
 atomic_t exit_cond;
-
-static void start_purge_timer(void)
-{
-	queue_delayed_work(bat_event_workqueue, &purge_orig_wq, 1 * HZ);
-}
-
-int originator_init(void)
-{
-	if (orig_hash)
-		return 1;
-
-	spin_lock(&orig_hash_lock);
-	orig_hash = hash_new(128, compare_orig, choose_orig);
-
-	if (!orig_hash)
-		goto err;
-
-	spin_unlock(&orig_hash_lock);
-	start_purge_timer();
-	return 1;
-
-err:
-	spin_unlock(&orig_hash_lock);
-	return 0;
-}
-
-void originator_free(void)
-{
-	if (!orig_hash)
-		return;
-
-	cancel_delayed_work_sync(&purge_orig_wq);
-
-	spin_lock(&orig_hash_lock);
-	hash_delete(orig_hash, free_orig_node);
-	orig_hash = NULL;
-	spin_unlock(&orig_hash_lock);
-}
-
-static struct neigh_node *
-create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
-		uint8_t *neigh, struct batman_if *if_incoming)
-{
-	struct neigh_node *neigh_node;
-
-	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbour of originator\n");
-
-	neigh_node = kmalloc(sizeof(struct neigh_node), GFP_ATOMIC);
-	memset(neigh_node, 0, sizeof(struct neigh_node));
-	INIT_LIST_HEAD(&neigh_node->list);
-
-	memcpy(neigh_node->addr, neigh, ETH_ALEN);
-	neigh_node->orig_node = orig_neigh_node;
-	neigh_node->if_incoming = if_incoming;
-
-	list_add_tail(&neigh_node->list, &orig_node->neigh_list);
-	return neigh_node;
-}
-
-void free_orig_node(void *data)
-{
-	struct list_head *list_pos, *list_pos_tmp;
-	struct neigh_node *neigh_node;
-	struct orig_node *orig_node = (struct orig_node *)data;
-
-	/* for all neighbours towards this originator ... */
-	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
-		neigh_node = list_entry(list_pos, struct neigh_node, list);
-
-		list_del(list_pos);
-		kfree(neigh_node);
-	}
-
-	hna_global_del_orig(orig_node, "originator timed out");
-
-	kfree(orig_node->bcast_own);
-	kfree(orig_node->bcast_own_sum);
-	kfree(orig_node);
-}
-
-/* this function finds or creates an originator entry for the given
- * address if it does not exits */
-static struct orig_node *get_orig_node(uint8_t *addr)
-{
-	struct orig_node *orig_node;
-	struct hashtable_t *swaphash;
-	char orig_str[ETH_STR_LEN];
-	int size;
-
-	orig_node = ((struct orig_node *)hash_find(orig_hash, addr));
-
-	if (orig_node != NULL)
-		return orig_node;
-
-	addr_to_string(orig_str, addr);
-	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
-
-	orig_node = kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
-	memset(orig_node, 0, sizeof(struct orig_node));
-	INIT_LIST_HEAD(&orig_node->neigh_list);
-
-	memcpy(orig_node->orig, addr, ETH_ALEN);
-	orig_node->router = NULL;
-	orig_node->batman_if = NULL;
-	orig_node->hna_buff = NULL;
-
-	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
-
-	orig_node->bcast_own = kmalloc(size, GFP_ATOMIC);
-	memset(orig_node->bcast_own, 0, size);
-
-	size = num_ifs * sizeof(uint8_t);
-	orig_node->bcast_own_sum = kmalloc(size, GFP_ATOMIC);
-	memset(orig_node->bcast_own_sum, 0, size);
-
-	hash_add(orig_hash, orig_node);
-
-	if (orig_hash->elements * 4 > orig_hash->size) {
-		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
-
-		if (swaphash == NULL)
-			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table \n");
-		else
-			orig_hash = swaphash;
-	}
-
-	return orig_node;
-}
-
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct hash_it_t *hashit = NULL;
@@ -246,7 +116,7 @@ static void update_route(struct orig_node *orig_node,
 }
 
 
-static void update_routes(struct orig_node *orig_node,
+void update_routes(struct orig_node *orig_node,
 			  struct neigh_node *neigh_node,
 			  unsigned char *hna_buff, int hna_buff_len)
 {
@@ -679,85 +549,6 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				0, hna_buff_len, if_incoming);
 }
 
-static bool purge_orig_neigbours(struct orig_node *orig_node,
-				 struct neigh_node **best_neigh_node)
-{
-	struct list_head *list_pos, *list_pos_tmp;
-	char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
-	struct neigh_node *neigh_node;
-	bool neigh_purged = false;
-
-	*best_neigh_node = NULL;
-
-
-	/* for all neighbours towards this originator ... */
-	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
-		neigh_node = list_entry(list_pos, struct neigh_node, list);
-
-		if (time_after(jiffies,
-			       (neigh_node->last_valid +
-				((PURGE_TIMEOUT * HZ) / 1000)))) {
-
-			addr_to_string(neigh_str, neigh_node->addr);
-			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
-
-			neigh_purged = true;
-			list_del(list_pos);
-			kfree(neigh_node);
-		} else {
-			if ((*best_neigh_node == NULL) ||
-			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
-				*best_neigh_node = neigh_node;
-		}
-	}
-	return neigh_purged;
-}
-
-static bool purge_orig_node(struct orig_node *orig_node)
-{
-	struct neigh_node *best_neigh_node;
-	char orig_str[ETH_STR_LEN];
-
-	addr_to_string(orig_str, orig_node->orig);
-
-	if (time_after(jiffies,
-		       (orig_node->last_valid +
-			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
-
-		bat_dbg(DBG_BATMAN,
-			"Originator timeout: originator %s, last_valid %lu\n",
-			orig_str, (orig_node->last_valid / HZ));
-		return true;
-	} else {
-		if (purge_orig_neigbours(orig_node, &best_neigh_node))
-			update_routes(orig_node, best_neigh_node,
-				      orig_node->hna_buff,
-				      orig_node->hna_buff_len);
-	}
-	return false;
-}
-
-
-void purge_orig(struct work_struct *work)
-{
-	struct hash_it_t *hashit = NULL;
-	struct orig_node *orig_node;
-
-	spin_lock(&orig_hash_lock);
-
-	/* for all origins... */
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
-		if (purge_orig_node(orig_node)) {
-			hash_remove_bucket(orig_hash, hashit);
-			free_orig_node(orig_node);
-		}
-	}
-
-	spin_unlock(&orig_hash_lock);
-
-	start_purge_timer();
-}
 
 static int receive_raw_packet(struct socket *raw_sock,
 			      unsigned char *packet_buff, int packet_buff_len)
diff --git a/routing.h b/routing.h
index 0123ea8..985728f 100644
--- a/routing.h
+++ b/routing.h
@@ -24,11 +24,13 @@
 extern wait_queue_head_t thread_wait;
 extern atomic_t exit_cond;
 
-int originator_init(void);
-void free_orig_node(void *data);
-void originator_free(void);
 void slide_own_bcast_window(struct batman_if *batman_if);
 void batman_data_ready(struct sock *sk, int len);
-void purge_orig(struct work_struct *work);
 int packet_recv_thread(void *data);
-void receive_bat_packet(struct ethhdr *ethhdr, struct batman_packet *batman_packet, unsigned char *hna_buff, int hna_buff_len, struct batman_if *if_incoming);
+void receive_bat_packet(struct ethhdr *ethhdr, 
+				struct batman_packet *batman_packet, 
+				unsigned char *hna_buff, int hna_buff_len, 
+				struct batman_if *if_incoming);
+void update_routes(struct orig_node *orig_node,
+				struct neigh_node *neigh_node,
+				unsigned char *hna_buff, int hna_buff_len);
-- 
1.6.5.4

