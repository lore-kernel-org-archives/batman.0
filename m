Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:40:06 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718144006.GK4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup hardinterface.[ch]
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

Make hardinterface.[ch] clean with respect to the 2.6.29 checkpatch
script. Exceptions are long lines with debug_log.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/hard-interface.c
===================================================================
--- batman-adv-kernelland/hard-interface.c	(revision 1351)
+++ batman-adv-kernelland/hard-interface.c	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "hard-interface.h"
 #include "log.h"
@@ -31,15 +27,14 @@
 #include "hash.h"
 #include "compat.h"
 
-#define MIN(x,y) ((x) < (y) ? (x):(y))
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
 
+static DECLARE_DELAYED_WORK(hardif_check_interfaces_wq,
+			    hardif_check_interfaces_status_wq);
 
+static char avail_ifs;
+static char active_ifs;
 
-static DECLARE_DELAYED_WORK(hardif_check_interfaces_wq, hardif_check_interfaces_status_wq);
-
-static char avail_ifs = 0;
-static char active_ifs = 0;
-
 static void hardif_free_interface(struct rcu_head *rcu);
 
 int hardif_min_mtu(void)
@@ -52,7 +47,8 @@
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (batman_if->if_active == IF_ACTIVE)
-			min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN, min_mtu);
+			min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
+				      min_mtu);
 	}
 	rcu_read_unlock();
 
@@ -68,26 +64,26 @@
 	 * if we already have an interface in our interface list and
 	 * the current interface is not the primary interface and
 	 * the primary interface is not up and
-	 * the primary interface has never been up - don't activate any secondary interface !
+	 * the primary interface has never been up - don't activate any
+	 * secondary interface !
 	 */
 
 	rcu_read_lock();
 	if ((!list_empty(&if_list)) &&
-		     (strncmp(((struct batman_if *)if_list.next)->dev, dev, IFNAMSIZ) != 0) &&
-		     !(((struct batman_if *)if_list.next)->if_active == IF_ACTIVE) &&
-		     (!main_if_was_up())) {
-
+	    strncmp(((struct batman_if *)if_list.next)->dev, dev, IFNAMSIZ) &&
+	    !(((struct batman_if *)if_list.next)->if_active == IF_ACTIVE) &&
+	    (!main_if_was_up())) {
 		rcu_read_unlock();
 		goto end;
-
 	}
 	rcu_read_unlock();
 
 #ifdef __NET_NET_NAMESPACE_H
-	if ((net_dev = dev_get_by_name(&init_net, dev)) == NULL)
+	net_dev = dev_get_by_name(&init_net, dev);
 #else
-	if ((net_dev = dev_get_by_name(dev)) == NULL)
+	net_dev = dev_get_by_name(dev);
 #endif
+	if (!net_dev)
 		goto end;
 
 	if (!(net_dev->flags & IFF_UP))
@@ -108,8 +104,6 @@
 	if (batman_if->raw_sock != NULL)
 		sock_release(batman_if->raw_sock);
 
-	/* batman_if->raw_sock->sk->sk_data_ready = batman_if->raw_sock->sk->sk_user_data; */
-
 	/**
 	 * batman_if->net_dev has been acquired by dev_get_by_name() in
 	 * proc_interfaces_write() and has to be unreferenced.
@@ -124,7 +118,8 @@
 	batman_if->if_active = IF_INACTIVE;
 	active_ifs--;
 
-	debug_log(LOG_TYPE_NOTICE, "Interface deactivated: %s\n", batman_if->dev);
+	debug_log(LOG_TYPE_NOTICE, "Interface deactivated: %s\n",
+		  batman_if->dev);
 }
 
 /* (re)activate given interface. */
@@ -134,14 +129,20 @@
 	int retval;
 
 #ifdef __NET_NET_NAMESPACE_H
-	if ((batman_if->net_dev = dev_get_by_name(&init_net, batman_if->dev)) == NULL)
+	batman_if->net_dev = dev_get_by_name(&init_net, batman_if->dev);
 #else
-	if ((batman_if->net_dev = dev_get_by_name(batman_if->dev)) == NULL)
+	batman_if->net_dev = dev_get_by_name(batman_if->dev);
 #endif
+	if (!batman_if->net_dev)
 		goto error;
 
-	if ((retval = sock_create_kern(PF_PACKET, SOCK_RAW, __constant_htons(ETH_P_BATMAN), &batman_if->raw_sock)) < 0) {
-		debug_log(LOG_TYPE_WARN, "Can't create raw socket: %i\n", retval);
+	retval = sock_create_kern(PF_PACKET, SOCK_RAW,
+				  __constant_htons(ETH_P_BATMAN),
+				  &batman_if->raw_sock);
+
+	if (retval < 0) {
+		debug_log(LOG_TYPE_WARN, "Can't create raw socket: %i\n",
+			  retval);
 		goto error;
 	}
 
@@ -149,18 +150,25 @@
 	bind_addr.sll_ifindex = batman_if->net_dev->ifindex;
 	bind_addr.sll_protocol = 0;	/* is set by the kernel */
 
-	if ((retval = kernel_bind(batman_if->raw_sock, (struct sockaddr *)&bind_addr, sizeof(bind_addr))) < 0) {
-		debug_log(LOG_TYPE_WARN, "Can't create bind raw socket: %i\n", retval);
+	retval = kernel_bind(batman_if->raw_sock,
+			     (struct sockaddr *)&bind_addr, sizeof(bind_addr));
+
+	if (retval < 0) {
+		debug_log(LOG_TYPE_WARN, "Can't create bind raw socket: %i\n",
+			  retval);
 		goto error;
 	}
 
-	batman_if->raw_sock->sk->sk_user_data = batman_if->raw_sock->sk->sk_data_ready;
+	batman_if->raw_sock->sk->sk_user_data =
+		batman_if->raw_sock->sk->sk_data_ready;
 	batman_if->raw_sock->sk->sk_data_ready = batman_data_ready;
 
 	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
 
-	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig, batman_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(((struct batman_packet *)(batman_if->packet_buff))->old_orig, batman_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
+	       batman_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(((struct batman_packet *)(batman_if->packet_buff))->old_orig,
+	       batman_if->net_dev->dev_addr, ETH_ALEN);
 
 	batman_if->if_active = IF_ACTIVE;
 	active_ifs++;
@@ -209,12 +217,41 @@
 	}
 }
 
+static int resize_orig(struct orig_node *orig_node, int if_num)
+{
+	void *data_ptr;
+
+	data_ptr = kmalloc((if_num + 1) * sizeof(TYPE_OF_WORD) * NUM_WORDS,
+			   GFP_KERNEL);
+	if (!data_ptr) {
+		debug_log(LOG_TYPE_WARN, "Can't resize orig: out of memory\n");
+		return -1;
+	}
+
+	memcpy(data_ptr, orig_node->bcast_own,
+	       if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS);
+	kfree(orig_node->bcast_own);
+	orig_node->bcast_own = data_ptr;
+
+	data_ptr = kmalloc((if_num + 1) * sizeof(uint8_t), GFP_KERNEL);
+	if (!data_ptr) {
+		debug_log(LOG_TYPE_WARN, "Can't resize orig: out of memory\n");
+		return -1;
+	}
+
+	memcpy(data_ptr, orig_node->bcast_own_sum, if_num * sizeof(uint8_t));
+	kfree(orig_node->bcast_own_sum);
+	orig_node->bcast_own_sum = data_ptr;
+
+	return 0;
+}
+
+
 /* adds an interface the interface list and activate it, if possible */
 int hardif_add_interface(char *dev, int if_num)
 {
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet;
-	void *data_ptr;
 	struct orig_node *orig_node;
 	struct hash_it_t *hashit = NULL;
 
@@ -229,9 +266,9 @@
 	batman_if->net_dev = NULL;
 
 	if ((if_num == 0) && (num_hna > 0))
-		batman_if->packet_len = sizeof(struct batman_packet) + num_hna * ETH_ALEN;
+		batman_if->packet_len = BAT_PACKET_LEN + num_hna * ETH_ALEN;
 	else
-		batman_if->packet_len = sizeof(struct batman_packet);
+		batman_if->packet_len = BAT_PACKET_LEN;
 
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_KERNEL);
 
@@ -259,27 +296,27 @@
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_hna = 0;
 
-	if (batman_if->packet_len != sizeof(struct batman_packet))
-		batman_packet->num_hna = hna_local_fill_buffer(batman_if->packet_buff + sizeof(struct batman_packet), batman_if->packet_len - sizeof(struct batman_packet));
+	if (batman_if->packet_len != BAT_PACKET_LEN) {
+		unsigned char *hna_buff;
+		int hna_len;
 
+		hna_buff = batman_if->packet_buff + BAT_PACKET_LEN;
+		hna_len = batman_if->packet_len - BAT_PACKET_LEN;
+		batman_packet->num_hna = hna_local_fill_buffer(hna_buff,
+							       hna_len);
+	}
 	atomic_set(&batman_if->seqno, 1);
 
-
-	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on if_num */
+	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
+	 * if_num */
 	spin_lock(&orig_hash_lock);
 
 	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
 		orig_node = hashit->bucket->data;
-
-		data_ptr = kmalloc((if_num + 1) * sizeof(TYPE_OF_WORD) * NUM_WORDS, GFP_KERNEL);
-		memcpy(data_ptr, orig_node->bcast_own, if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS);
-		kfree(orig_node->bcast_own);
-		orig_node->bcast_own = data_ptr;
-
-		data_ptr = kmalloc((if_num + 1) * sizeof(uint8_t), GFP_KERNEL);
-		memcpy(data_ptr, orig_node->bcast_own_sum, if_num * sizeof(uint8_t));
-		kfree(orig_node->bcast_own_sum);
-		orig_node->bcast_own_sum = data_ptr;
+		if (resize_orig(orig_node, if_num) == -1) {
+			spin_unlock(&orig_hash_lock);
+			goto out;
+		}
 	}
 
 	spin_unlock(&orig_hash_lock);
@@ -314,14 +351,15 @@
 		return;
 
 	/**
-	 * wait for readers of the interfaces, so update won't be a problem.
+	 * wait for readers of the the interfaces, so update won't be a problem.
 	 * this function is not time critical and can wait a bit ....
 	 */
 	synchronize_rcu();
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if ((batman_if->if_active == IF_INACTIVE) && (hardif_is_interface_up(batman_if->dev)))
+		if ((batman_if->if_active == IF_INACTIVE) &&
+		    (hardif_is_interface_up(batman_if->dev)))
 			hardif_activate_interface(batman_if);
 
 		if (batman_if->if_active == IF_TO_BE_DEACTIVATED)
@@ -329,8 +367,10 @@
 	}
 	rcu_read_unlock();
 
-	/* waiting for activation? if interfaces are available now, we can activate. */
-	if ((module_state == MODULE_WAITING) && (hardif_get_active_if_num() > 0))
+	/* waiting for activation? if interfaces are available now, we can
+	 * activate. */
+	if ((module_state == MODULE_WAITING) &&
+	    (hardif_get_active_if_num() > 0))
 		activate_module();
 
 	/* decrease the MTU if a new interface with a smaller MTU appeared. */
@@ -348,11 +388,11 @@
 
 void start_hardif_check_timer(void)
 {
-	queue_delayed_work(bat_event_workqueue, &hardif_check_interfaces_wq, 1 * HZ);
+	queue_delayed_work(bat_event_workqueue, &hardif_check_interfaces_wq,
+			   1 * HZ);
 }
 
 void destroy_hardif_check_timer(void)
 {
 	cancel_delayed_work_sync(&hardif_check_interfaces_wq);
 }
-
Index: batman-adv-kernelland/hard-interface.h
===================================================================
--- batman-adv-kernelland/hard-interface.h	(revision 1351)
+++ batman-adv-kernelland/hard-interface.h	(working copy)
@@ -17,14 +17,10 @@
  *
  */
 
-
-
 #define IF_INACTIVE 0
 #define IF_ACTIVE 1
 #define IF_TO_BE_DEACTIVATED 2
 
-
-
 void hardif_remove_interfaces(void);
 int hardif_add_interface(char *dev, int if_num);
 void hardif_deactivate_interface(struct batman_if *batman_if);
