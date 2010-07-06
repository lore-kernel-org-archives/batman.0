Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue,  6 Jul 2010 21:05:16 +0200
Message-Id: <1278443118-19528-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
References: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] Staging: batman-adv: add routing debug
	log accessible via debugfs
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

All routing debug messages are saved in a ring buffer that can be
read via the debugfs file "log".
Note that CONFIG_BATMAN_ADV_DEBUG must be activated to have the
debug logs compiled in.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c       |    5 +-
 drivers/staging/batman-adv/bat_debugfs.c       |  190 ++++++++++++++++++++++++
 drivers/staging/batman-adv/bat_sysfs.c         |   54 +++++++
 drivers/staging/batman-adv/bitarray.c          |    7 +-
 drivers/staging/batman-adv/hard-interface.c    |    4 +-
 drivers/staging/batman-adv/icmp_socket.c       |    8 +-
 drivers/staging/batman-adv/main.c              |   11 --
 drivers/staging/batman-adv/main.h              |   31 +++--
 drivers/staging/batman-adv/originator.c        |   16 ++-
 drivers/staging/batman-adv/routing.c           |   60 +++++---
 drivers/staging/batman-adv/send.c              |   25 +++-
 drivers/staging/batman-adv/translation-table.c |   21 ++-
 drivers/staging/batman-adv/types.h             |   12 ++-
 13 files changed, 371 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index 3a5c349..9862d16 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -106,11 +106,14 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 {
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!atomic_dec_not_zero(&batman_queue_left)) {
-			bat_dbg(DBG_BATMAN, "batman packet queue full\n");
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"batman packet queue full\n");
 			return;
 		}
 	}
diff --git a/drivers/staging/batman-adv/bat_debugfs.c b/drivers/staging/batman-adv/bat_debugfs.c
index fafca9f..f818d5e 100644
--- a/drivers/staging/batman-adv/bat_debugfs.c
+++ b/drivers/staging/batman-adv/bat_debugfs.c
@@ -31,6 +31,193 @@
 
 static struct dentry *bat_debugfs;
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+#define LOG_BUFF_MASK (log_buff_len-1)
+#define LOG_BUFF(idx) (debug_log->log_buff[(idx) & LOG_BUFF_MASK])
+
+static int log_buff_len = LOG_BUF_LEN;
+
+static void emit_log_char(struct debug_log *debug_log, char c)
+{
+	LOG_BUFF(debug_log->log_end) = c;
+	debug_log->log_end++;
+
+	if (debug_log->log_end - debug_log->log_start > log_buff_len)
+		debug_log->log_start = debug_log->log_end - log_buff_len;
+}
+
+static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
+{
+	int printed_len;
+	va_list args;
+	static char debug_log_buf[256];
+	char *p;
+	unsigned long flags;
+
+	if (!debug_log)
+		return 0;
+
+	spin_lock_irqsave(&debug_log->lock, flags);
+	va_start(args, fmt);
+	printed_len = vscnprintf(debug_log_buf, sizeof(debug_log_buf),
+				 fmt, args);
+	va_end(args);
+
+	for (p = debug_log_buf; *p != 0; p++)
+		emit_log_char(debug_log, *p);
+
+	spin_unlock_irqrestore(&debug_log->lock, flags);
+
+	wake_up(&debug_log->queue_wait);
+
+	return 0;
+}
+
+int debug_log(struct bat_priv *bat_priv, char *fmt, ...)
+{
+	va_list args;
+	char tmp_log_buf[256];
+
+	va_start(args, fmt);
+	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
+	fdebug_log(bat_priv->debug_log, "[%10u] %s",
+		   (jiffies / HZ), tmp_log_buf);
+	va_end(args);
+
+	return 0;
+}
+
+static int log_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	inc_module_count();
+	return 0;
+}
+
+static int log_release(struct inode *inode, struct file *file)
+{
+	dec_module_count();
+	return 0;
+}
+
+static ssize_t log_read(struct file *file, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct bat_priv *bat_priv = (struct bat_priv *)file->private_data;
+	struct debug_log *debug_log = bat_priv->debug_log;
+	int error, i = 0;
+	char c;
+	unsigned long flags;
+
+	if ((file->f_flags & O_NONBLOCK) &&
+	    !(debug_log->log_end - debug_log->log_start))
+		return -EAGAIN;
+
+	if ((!buf) || (count < 0))
+		return -EINVAL;
+
+	if (count == 0)
+		return 0;
+
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
+
+	error = wait_event_interruptible(debug_log->queue_wait,
+				(debug_log->log_start - debug_log->log_end));
+
+	if (error)
+		return error;
+
+	spin_lock_irqsave(&debug_log->lock, flags);
+
+	while ((!error) && (i < count) &&
+	       (debug_log->log_start != debug_log->log_end)) {
+		c = LOG_BUFF(debug_log->log_start);
+
+		debug_log->log_start++;
+
+		spin_unlock_irqrestore(&debug_log->lock, flags);
+
+		error = __put_user(c, buf);
+
+		spin_lock_irqsave(&debug_log->lock, flags);
+
+		buf++;
+		i++;
+
+	}
+
+	spin_unlock_irqrestore(&debug_log->lock, flags);
+
+	if (!error)
+		return i;
+
+	return error;
+}
+
+static unsigned int log_poll(struct file *file, poll_table *wait)
+{
+	struct bat_priv *bat_priv = (struct bat_priv *)file->private_data;
+	struct debug_log *debug_log = bat_priv->debug_log;
+
+	poll_wait(file, &debug_log->queue_wait, wait);
+
+	if (debug_log->log_end - debug_log->log_start)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static const struct file_operations log_fops = {
+	.open           = log_open,
+	.release        = log_release,
+	.read           = log_read,
+	.poll           = log_poll,
+};
+
+static int debug_log_setup(struct bat_priv *bat_priv)
+{
+	struct dentry *d;
+
+	if (!bat_priv->debug_dir)
+		goto err;
+
+	bat_priv->debug_log = kzalloc(sizeof(struct debug_log), GFP_ATOMIC);
+	if (!bat_priv->debug_log)
+		goto err;
+
+	spin_lock_init(&bat_priv->debug_log->lock);
+	init_waitqueue_head(&bat_priv->debug_log->queue_wait);
+
+	d = debugfs_create_file("log", S_IFREG | S_IRUSR,
+				bat_priv->debug_dir, bat_priv, &log_fops);
+	if (d)
+		goto err;
+
+	return 0;
+
+err:
+	return 1;
+}
+
+static void debug_log_cleanup(struct bat_priv *bat_priv)
+{
+	kfree(bat_priv->debug_log);
+	bat_priv->debug_log = NULL;
+}
+#else /* CONFIG_BATMAN_ADV_DEBUG */
+static int debug_log_setup(struct bat_priv *bat_priv)
+{
+	bat_priv->debug_log = NULL;
+	return 0;
+}
+
+static void debug_log_cleanup(struct bat_priv *bat_priv)
+{
+	return;
+}
+#endif
+
 static int originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -114,6 +301,7 @@ int debugfs_add_meshif(struct net_device *dev)
 		goto out;
 
 	bat_socket_setup(bat_priv);
+	debug_log_setup(bat_priv);
 
 	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
 		file = debugfs_create_file(((*bat_debug)->attr).name,
@@ -143,6 +331,8 @@ void debugfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 
+	debug_log_cleanup(bat_priv);
+
 	if (bat_debugfs) {
 		debugfs_remove_recursive(bat_priv->debug_dir);
 		bat_priv->debug_dir = NULL;
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 4e9c71d..65e1465 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -229,18 +229,70 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+static ssize_t show_log_level(struct kobject *kobj, struct attribute *attr,
+			     char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int log_level = atomic_read(&bat_priv->log_level);
+
+	return sprintf(buff, "%d\n", log_level);
+}
+
+static ssize_t store_log_level(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long log_level_tmp;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &log_level_tmp);
+	if (ret) {
+		printk(KERN_INFO "batman-adv:Invalid parameter for 'log_level' setting on mesh %s received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (log_level_tmp > 3) {
+		printk(KERN_INFO "batman-adv:New log level too big: %li (max: %i)\n",
+		       log_level_tmp, 3);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->log_level) == log_level_tmp)
+		return count;
+
+	printk(KERN_INFO
+	       "batman-adv:Changing log level from: %i to: %li on mesh: %s\n",
+	       atomic_read(&bat_priv->log_level),
+	       log_level_tmp, net_dev->name);
+
+	atomic_set(&bat_priv->log_level, (unsigned)log_level_tmp);
+	return count;
+}
+#endif
+
 static BAT_ATTR(aggregated_ogms, S_IRUGO | S_IWUSR,
 		show_aggr_ogms, store_aggr_ogms);
 static BAT_ATTR(bonding, S_IRUGO | S_IWUSR, show_bond, store_bond);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
 		show_orig_interval, store_orig_interval);
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+static BAT_ATTR(log_level, S_IRUGO | S_IWUSR, show_log_level, store_log_level);
+#endif
 
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
 	&bat_attr_vis_mode,
 	&bat_attr_orig_interval,
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+	&bat_attr_log_level,
+#endif
 	NULL,
 };
 
@@ -257,6 +309,8 @@ int sysfs_add_meshif(struct net_device *dev)
 	atomic_set(&bat_priv->bonding_enabled, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->orig_interval, 1000);
+	atomic_set(&bat_priv->log_level, 0);
+
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
diff --git a/drivers/staging/batman-adv/bitarray.c b/drivers/staging/batman-adv/bitarray.c
index c10fe03..dd4193c 100644
--- a/drivers/staging/batman-adv/bitarray.c
+++ b/drivers/staging/batman-adv/bitarray.c
@@ -128,6 +128,9 @@ static void bit_reset_window(TYPE_OF_WORD *seq_bits)
 char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 		    int8_t set_mark)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+
 	/* sequence number is slightly older. We already got a sequence number
 	 * higher than this one, so we just mark it. */
 
@@ -152,7 +155,7 @@ char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 
 	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"We missed a lot of packets (%i) !\n",
 			seq_num_diff - 1);
 		bit_reset_window(seq_bits);
@@ -169,7 +172,7 @@ char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
 
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Other host probably restarted!\n");
 
 		bit_reset_window(seq_bits);
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index ba7ddfc..b5a0f1b 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -443,6 +443,8 @@ static int batman_skb_recv_finish(struct sk_buff *skb)
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct packet_type *ptype, struct net_device *orig_dev)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
 	struct net_device_stats *stats;
@@ -490,7 +492,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	batman_packet = (struct batman_packet *)skb->data;
 
 	if (batman_packet->version != COMPAT_VERSION) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
 			batman_packet->version);
 		goto err_free;
diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index 08a5f7b..eea4ed7 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -154,6 +154,8 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 				size_t len, loff_t *off)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct socket_client *socket_client =
 		(struct socket_client *)file->private_data;
 	struct icmp_packet_rr icmp_packet;
@@ -164,7 +166,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"invalid packet size\n");
 		return -EINVAL;
@@ -180,14 +182,14 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		return -EFAULT;
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"got bogus packet type (expected: BAT_ICMP)\n");
 		return -EINVAL;
 	}
 
 	if (icmp_packet.msg_type != ECHO_REQUEST) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"got bogus message type (expected: ECHO_REQUEST)\n");
 		return -EINVAL;
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index d7e2960..5477d42 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -59,17 +59,6 @@ static struct packet_type batman_adv_packet_type __read_mostly = {
 
 struct workqueue_struct *bat_event_workqueue;
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-int debug;
-
-module_param(debug, int, 0644);
-
-int bat_debug_type(int type)
-{
-	return debug & type;
-}
-#endif
-
 int init_module(void)
 {
 	int retval;
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index e308673..dc42d44 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -91,20 +91,8 @@
 			 * broadcasting / etc */
 #define DBG_ROUTES 2	/* route or hna added / changed / deleted */
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-extern int debug;
+#define LOG_BUF_LEN 8192          /* has to be a power of 2 */
 
-extern int bat_debug_type(int type);
-#define bat_dbg(type, fmt, arg...) do {					\
-		if (bat_debug_type(type))				\
-			printk(KERN_DEBUG "batman-adv:" fmt, ## arg);	\
-	}								\
-	while (0)
-#else /* !CONFIG_BATMAN_ADV_DEBUG */
-#define bat_dbg(type, fmt, arg...) do {		\
-	}					\
-	while (0)
-#endif
 
 /*
  *  Vis
@@ -166,4 +154,21 @@ int is_my_mac(uint8_t *addr);
 int is_bcast(uint8_t *addr);
 int is_mcast(uint8_t *addr);
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+extern int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
+
+#define bat_dbg(type, bat_priv, fmt, arg...)			\
+	do {							\
+		if (atomic_read(&bat_priv->log_level) & type)	\
+			debug_log(bat_priv, fmt, ## arg);	\
+	}							\
+	while (0)
+#else /* !CONFIG_BATMAN_ADV_DEBUG */
+static inline void bat_dbg(char type __attribute__((unused)),
+			   struct bat_priv *bat_priv __attribute__((unused)),
+			   char *fmt __attribute__((unused)), ...)
+{
+}
+#endif
+
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 26bbf2d..3febdb8 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -60,9 +60,12 @@ struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *neigh_node;
 
-	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbor of originator\n");
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Creating new last-hop neighbor of originator\n");
 
 	neigh_node = kzalloc(sizeof(struct neigh_node), GFP_ATOMIC);
 	if (!neigh_node)
@@ -129,7 +132,8 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	if (orig_node != NULL)
 		return orig_node;
 
-	bat_dbg(DBG_BATMAN, "Creating new originator: %pM\n", addr);
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Creating new originator: %pM\n", addr);
 
 	orig_node = kzalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	if (!orig_node)
@@ -182,6 +186,8 @@ free_orig_node:
 static bool purge_orig_neighbors(struct orig_node *orig_node,
 				 struct neigh_node **best_neigh_node)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
@@ -199,13 +205,13 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
 			if (neigh_node->if_incoming->if_status ==
 							IF_TO_BE_REMOVED)
-				bat_dbg(DBG_BATMAN,
+				bat_dbg(DBG_BATMAN, bat_priv,
 					"neighbor purge: originator %pM, "
 					"neighbor: %pM, iface: %s\n",
 					orig_node->orig, neigh_node->addr,
 					neigh_node->if_incoming->dev);
 			else
-				bat_dbg(DBG_BATMAN,
+				bat_dbg(DBG_BATMAN, bat_priv,
 					"neighbor timeout: originator %pM, "
 					"neighbor: %pM, last_valid: %lu\n",
 					orig_node->orig, neigh_node->addr,
@@ -232,7 +238,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 	if (time_after(jiffies,
 		orig_node->last_valid + 2 * PURGE_TIMEOUT * HZ)) {
 
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Originator timeout: originator %pM, last_valid %lu\n",
 			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 127cfbf..418ae09 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -77,24 +77,27 @@ static void update_route(struct orig_node *orig_node,
 			 struct neigh_node *neigh_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+
 	/* route deleted */
 	if ((orig_node->router != NULL) && (neigh_node == NULL)) {
 
-		bat_dbg(DBG_ROUTES, "Deleting route towards: %pM\n",
+		bat_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
 			orig_node->orig);
 		hna_global_del_orig(orig_node, "originator timed out");
 
 		/* route added */
 	} else if ((orig_node->router == NULL) && (neigh_node != NULL)) {
 
-		bat_dbg(DBG_ROUTES,
+		bat_dbg(DBG_ROUTES, bat_priv,
 			"Adding route towards: %pM (via %pM)\n",
 			orig_node->orig, neigh_node->addr);
 		hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
 
 		/* route changed */
 	} else {
-		bat_dbg(DBG_ROUTES,
+		bat_dbg(DBG_ROUTES, bat_priv,
 			"Changing route towards: %pM "
 			"(now via %pM - was via %pM)\n",
 			orig_node->orig, neigh_node->addr,
@@ -125,6 +128,8 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct batman_packet *batman_packet,
 				struct batman_if *if_incoming)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	unsigned char total_count;
 
@@ -211,7 +216,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN,
+	bat_dbg(DBG_BATMAN, bat_priv,
 		"bidirectional: "
 		"orig = %-15pM neigh = %-15pM => own_bcast = %2i, "
 		"real recv = %2i, local tq: %3i, asym_penalty: %3i, "
@@ -234,10 +239,12 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
 {
+	/* FIXME: get bat_priv */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): "
+	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
 		"Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
@@ -269,7 +276,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 		if (!neigh_node)
 			return;
 	} else
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Updating existing last-hop neighbor of originator\n");
 
 	orig_node->flags = batman_packet->flags;
@@ -321,13 +328,16 @@ update_hna:
 static int window_protected(int32_t seq_num_diff,
 				unsigned long *last_reset)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
 		if (time_after(jiffies, *last_reset +
 			msecs_to_jiffies(RESET_PROTECTION_MS))) {
 
 			*last_reset = jiffies;
-			bat_dbg(DBG_BATMAN,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"old packet received, start protection\n");
 
 			return 0;
@@ -349,6 +359,8 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			       struct batman_packet *batman_packet,
 			       struct batman_if *if_incoming)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	char is_duplicate = 0;
@@ -387,7 +399,8 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	}
 
 	if (need_update) {
-		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d\n",
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"updating last_seqno: old %d, new %d\n",
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
@@ -540,7 +553,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] "
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Received BATMAN packet via NB: %pM, IF: %s [%s] "
 		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
 		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
@@ -569,14 +583,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	if (batman_packet->version != COMPAT_VERSION) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
 			batman_packet->version);
 		return;
 	}
 
 	if (is_my_addr) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: received my own broadcast (sender: %pM"
 			")\n",
 			ethhdr->h_source);
@@ -584,7 +598,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: "
+		bat_dbg(DBG_BATMAN, bat_priv, "Drop packet: "
 		"ignoring all packets with broadcast source addr (sender: %pM"
 		")\n", ethhdr->h_source);
 		return;
@@ -614,13 +628,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				bit_packet_count(word);
 		}
 
-		bat_dbg(DBG_BATMAN, "Drop packet: "
+		bat_dbg(DBG_BATMAN, bat_priv, "Drop packet: "
 			"originator packet from myself (via neighbor)\n");
 		return;
 	}
 
 	if (is_my_oldorig) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: ignoring all rebroadcast echos (sender: "
 			"%pM)\n", ethhdr->h_source);
 		return;
@@ -633,14 +647,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
 
 	if (is_duplicate == -1) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: packet within seqno protection time "
 			"(sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
 	if (batman_packet->tq == 0) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: originator packet with tq equal 0\n");
 		return;
 	}
@@ -653,7 +667,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: ignoring all rebroadcast packets that "
 			"may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
@@ -670,7 +684,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	 * don't route towards it */
 	if (!is_single_hop_neigh &&
 	    (orig_neigh_node->router == NULL)) {
-		bat_dbg(DBG_BATMAN, "Drop packet: OGM via unknown neighbor!\n");
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Drop packet: OGM via unknown neighbor!\n");
 		return;
 	}
 
@@ -697,24 +712,25 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		schedule_forward_packet(orig_node, ethhdr, batman_packet,
 					1, hna_buff_len, if_incoming);
 
-		bat_dbg(DBG_BATMAN, "Forwarding packet: "
+		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
 			"rebroadcast neighbor packet with direct link flag\n");
 		return;
 	}
 
 	/* multihop originator */
 	if (!is_bidirectional) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: not received via bidirectional link\n");
 		return;
 	}
 
 	if (is_duplicate) {
-		bat_dbg(DBG_BATMAN, "Drop packet: duplicate packet received\n");
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Drop packet: duplicate packet received\n");
 		return;
 	}
 
-	bat_dbg(DBG_BATMAN,
+	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
 	schedule_forward_packet(orig_node, ethhdr, batman_packet,
 				0, hna_buff_len, if_incoming);
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index d4b92ef..8e8c0b6 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -126,6 +126,8 @@ void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
 static void send_packet_to_if(struct forw_packet *forw_packet,
 			      struct batman_if *batman_if)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	char *fwd_str;
 	uint8_t packet_num;
 	int16_t buff_pos;
@@ -155,7 +157,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
 							    "Sending own" :
 							    "Forwarding"));
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
 			" IDF %s) on interface %s [%s]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
@@ -180,6 +182,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 /* send a batman packet */
 static void send_packet(struct forw_packet *forw_packet)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->packet_buff);
@@ -200,7 +204,7 @@ static void send_packet(struct forw_packet *forw_packet)
 	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
 
 		/* FIXME: what about aggregated packets ? */
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s packet (originator %pM, seqno %d, TTL %d) "
 			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
@@ -313,7 +317,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned long send_time;
 
 	if (batman_packet->ttl <= 1) {
-		bat_dbg(DBG_BATMAN, "ttl exceeded\n");
+		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
 		return;
 	}
 
@@ -342,7 +346,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, "
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
@@ -402,9 +407,11 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 {
 	struct forw_packet *forw_packet;
 	struct bcast_packet *bcast_packet;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	if (!atomic_dec_not_zero(&bcast_queue_left)) {
-		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
+		bat_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
 		goto out;
 	}
 
@@ -516,15 +523,19 @@ out:
 
 void purge_outstanding_packets(struct batman_if *batman_if)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
 	unsigned long flags;
 
 	if (batman_if)
-		bat_dbg(DBG_BATMAN, "purge_outstanding_packets(): %s\n",
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"purge_outstanding_packets(): %s\n",
 			batman_if->dev);
 	else
-		bat_dbg(DBG_BATMAN, "purge_outstanding_packets()\n");
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"purge_outstanding_packets()\n");
 
 	/* free bcast list */
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 9e3c845..992fc7c 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -60,6 +60,8 @@ int hna_local_init(void)
 
 void hna_local_add(uint8_t *addr)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
@@ -80,15 +82,15 @@ void hna_local_add(uint8_t *addr)
 	   MAC-flooding. */
 	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
 	    (num_hna + 1 > 255)) {
-		bat_dbg(DBG_ROUTES,
+		bat_dbg(DBG_ROUTES, bat_priv,
 			"Can't add new local hna entry (%pM): "
 			"number of local hna entries exceeds packet size\n",
 			addr);
 		return;
 	}
 
-	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %pM\n",
-		addr);
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Creating new local hna entry: %pM\n", addr);
 
 	hna_local_entry = kmalloc(sizeof(struct hna_local_entry), GFP_ATOMIC);
 	if (!hna_local_entry)
@@ -223,7 +225,9 @@ static void _hna_local_del(void *data)
 static void hna_local_del(struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s\n",
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
 	hash_remove(hna_local_hash, hna_local_entry->addr);
@@ -293,6 +297,8 @@ int hna_global_init(void)
 void hna_global_add_orig(struct orig_node *orig_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
 	struct hashtable_t *swaphash;
@@ -319,7 +325,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 
 			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
-			bat_dbg(DBG_ROUTES,
+			bat_dbg(DBG_ROUTES, bat_priv,
 				"Creating new global hna entry: "
 				"%pM (via %pM)\n",
 				hna_global_entry->addr, orig_node->orig);
@@ -428,7 +434,10 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 				 char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s\n",
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Deleting global hna entry %pM (via %pM): %s\n",
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
 		message);
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 82602d0..21d0717 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -21,8 +21,6 @@
 
 
 
-
-
 #ifndef _NET_BATMAN_ADV_TYPES_H_
 #define _NET_BATMAN_ADV_TYPES_H_
 
@@ -114,7 +112,9 @@ struct bat_priv {
 	atomic_t bonding_enabled;
 	atomic_t vis_mode;
 	atomic_t orig_interval;
+	atomic_t log_level;
 	char num_ifaces;
+	struct debug_log *debug_log;
 	struct batman_if *primary_if;
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
@@ -172,4 +172,12 @@ struct if_list_entry {
 	struct hlist_node list;
 };
 
+struct debug_log {
+	char log_buff[LOG_BUF_LEN];
+	unsigned long log_start;
+	unsigned long log_end;
+	spinlock_t lock;
+	wait_queue_head_t queue_wait;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.1

