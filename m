Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jun 2012 20:26:30 +0200
Message-Id: <1340130390-4518-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix alignment after opened
	parentheses
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
ordex: This one is important for you. Please check whether patches in
batman-adv/next touch these code parts. They may be the reason that these
problems were introduced and must be fixed. Therefore, I would suggest to put
this patch directly (after reviewing of course) in next.

 bat_iv_ogm.c     |    2 +-
 compat.h         |    4 ++--
 debugfs.c        |   18 +++++++++++-------
 gateway_client.c |    4 ++--
 hard-interface.c |   10 +++++-----
 originator.c     |    9 +++++----
 routing.c        |    3 +--
 sysfs.c          |    2 +-
 unicast.c        |    5 +++--
 9 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 1dfe0e4..e877af8 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -145,7 +145,7 @@ static uint8_t batadv_hop_penalty(uint8_t tq,
 
 /* is there another aggregated packet here? */
 static int batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
-				  int tt_num_changes)
+				     int tt_num_changes)
 {
 	int next_buff_pos = 0;
 
diff --git a/compat.h b/compat.h
index d58ba17..13253dd 100644
--- a/compat.h
+++ b/compat.h
@@ -72,8 +72,8 @@
 
 #define __hlist_for_each_rcu(pos, head) \
 	for (pos = rcu_dereference(hlist_first_rcu(head)); \
-	pos && ({ prefetch(pos->next); 1; }); \
-	pos = rcu_dereference(hlist_next_rcu(pos)))
+	     pos && ({ prefetch(pos->next); 1; }); \
+	     pos = rcu_dereference(hlist_next_rcu(pos)))
 
 #define rcu_dereference_protected(p, c) (p)
 
diff --git a/debugfs.c b/debugfs.c
index e45cf0e..34fbb16 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -111,6 +111,11 @@ static int batadv_log_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int batadv_log_empty(struct batadv_debug_log *debug_log)
+{
+	return !(debug_log->log_start - debug_log->log_end);
+}
+
 static ssize_t batadv_log_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
@@ -120,8 +125,7 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 	char *char_addr;
 	char c;
 
-	if ((file->f_flags & O_NONBLOCK) &&
-	    !(debug_log->log_end - debug_log->log_start))
+	if ((file->f_flags & O_NONBLOCK) && batadv_log_empty(debug_log))
 		return -EAGAIN;
 
 	if (!buf)
@@ -134,7 +138,7 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 		return -EFAULT;
 
 	error = wait_event_interruptible(debug_log->queue_wait,
-				(debug_log->log_start - debug_log->log_end));
+					 (!batadv_log_empty(debug_log)));
 
 	if (error)
 		return error;
@@ -175,7 +179,7 @@ static unsigned int batadv_log_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &debug_log->queue_wait, wait);
 
-	if (debug_log->log_end - debug_log->log_start)
+	if (!batadv_log_empty(debug_log))
 		return POLLIN | POLLRDNORM;
 
 	return 0;
@@ -370,9 +374,9 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 
 	for (bat_debug = batadv_mesh_debuginfos; *bat_debug; ++bat_debug) {
 		file = debugfs_create_file(((*bat_debug)->attr).name,
-					  S_IFREG | ((*bat_debug)->attr).mode,
-					  bat_priv->debug_dir,
-					  dev, &(*bat_debug)->fops);
+					   S_IFREG | ((*bat_debug)->attr).mode,
+					   bat_priv->debug_dir,
+					   dev, &(*bat_debug)->fops);
 		if (!file) {
 			batadv_err(dev, "Can't add debugfs file: %s/%s\n",
 				   dev->name, ((*bat_debug)->attr).name);
diff --git a/gateway_client.c b/gateway_client.c
index 6fe5cc8..b421cc4 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -228,8 +228,8 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	} else if ((!curr_gw) && (next_gw)) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
-			    next_gw->orig_node->orig,
-			    next_gw->orig_node->gw_flags, router->tq_avg);
+			   next_gw->orig_node->orig,
+			   next_gw->orig_node->gw_flags, router->tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
diff --git a/hard-interface.c b/hard-interface.c
index 14e17ea..282bf6e 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -324,15 +324,15 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	batadv_info(hard_iface->soft_iface, "Adding interface: %s\n",
 		    hard_iface->net_dev->name);
 
-	if (atomic_read(&bat_priv->fragmentation) && hard_iface->net_dev->mtu <
-		ETH_DATA_LEN + BATADV_HEADER_LEN)
+	if (atomic_read(&bat_priv->fragmentation) &&
+	    hard_iface->net_dev->mtu < ETH_DATA_LEN + BATADV_HEADER_LEN)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %zi would solve the problem.\n",
 			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
 			    ETH_DATA_LEN + BATADV_HEADER_LEN);
 
-	if (!atomic_read(&bat_priv->fragmentation) && hard_iface->net_dev->mtu <
-		ETH_DATA_LEN + BATADV_HEADER_LEN)
+	if (!atomic_read(&bat_priv->fragmentation) &&
+	    hard_iface->net_dev->mtu < ETH_DATA_LEN + BATADV_HEADER_LEN)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %zi.\n",
 			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
@@ -486,7 +486,7 @@ void batadv_hardif_remove_interfaces(void)
 }
 
 static int batadv_hard_if_event(struct notifier_block *this,
-			 unsigned long event, void *ptr)
+				unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = ptr;
 	struct batadv_hard_iface *hard_iface;
diff --git a/originator.c b/originator.c
index fc1ce26..ac9bdf8 100644
--- a/originator.c
+++ b/originator.c
@@ -413,6 +413,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	int batman_count = 0;
 	int last_seen_secs;
 	int last_seen_msecs;
+	unsigned long last_seen_jiffies;
 	uint32_t i;
 	int ret = 0;
 
@@ -451,10 +452,10 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 			if (neigh_node->tq_avg == 0)
 				goto next;
 
-			last_seen_secs = jiffies_to_msecs(jiffies -
-						orig_node->last_seen) / 1000;
-			last_seen_msecs = jiffies_to_msecs(jiffies -
-						orig_node->last_seen) % 1000;
+			last_seen_jiffies = jiffies - orig_node->last_seen;
+			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+			last_seen_secs = last_seen_msecs / 1000;
+			last_seen_msecs = last_seen_msecs % 1000;
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
diff --git a/routing.c b/routing.c
index b79e42e..bc2b88b 100644
--- a/routing.c
+++ b/routing.c
@@ -969,8 +969,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 				  ETH_HLEN) < 0)
 			return 0;
 
-		ethhdr = (struct ethhdr *)(skb->data +
-			sizeof(struct batadv_unicast_packet));
+		ethhdr = (struct ethhdr *)(skb->data + sizeof(*unicast_packet));
 
 		/* we don't have an updated route for this client, so we should
 		 * not try to reroute the packet!!
diff --git a/sysfs.c b/sysfs.c
index 6d519ee..66518c7 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -119,7 +119,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR_SIF_STORE_UINT(_name, _min, _max, _post_func)\
 	static BATADV_ATTR_SIF_SHOW_UINT(_name)				\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
-			batadv_store_##_name)
+			   batadv_store_##_name)
 
 
 #define BATADV_ATTR_HIF_STORE_UINT(_name, _min, _max, _post_func)	\
diff --git a/unicast.c b/unicast.c
index c42b81d..0016464 100644
--- a/unicast.c
+++ b/unicast.c
@@ -296,6 +296,7 @@ int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv)
 	struct batadv_neigh_node *neigh_node;
 	int data_len = skb->len;
 	int ret = 1;
+	unsigned int dev_mtu;
 
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
@@ -344,9 +345,9 @@ find_router:
 	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
+	dev_mtu = neigh_node->if_incoming->net_dev->mtu;
 	if (atomic_read(&bat_priv->fragmentation) &&
-	    data_len + sizeof(*unicast_packet) >
-				neigh_node->if_incoming->net_dev->mtu) {
+	    data_len + sizeof(*unicast_packet) > dev_mtu) {
 		/* send frag skb decreases ttl */
 		unicast_packet->header.ttl++;
 		ret = batadv_frag_send_skb(skb, bat_priv,
-- 
1.7.10

