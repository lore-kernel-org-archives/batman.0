Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jun 2010 02:33:08 +0200
Message-Id: <1277598789-29769-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201006270232.48439.lindner_marek@yahoo.de>
References: <201006270232.48439.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
	accessible via debugfs
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

All routing debug messages are saved in a ring buffer that can be
read via the debugfs file "log".
Note that CONFIG_BATMAN_ADV_DEBUG must be activated to have the
debug logs compiled in.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/aggregation.c       |    3 +-
 batman-adv/bat_debugfs.c       |  187 ++++++++++++++++++++++++++++++++++++++++
 batman-adv/bat_sysfs.c         |   53 +++++++++++
 batman-adv/bitarray.c          |    7 +-
 batman-adv/gateway_client.c    |   20 +++--
 batman-adv/hard-interface.c    |    4 +-
 batman-adv/icmp_socket.c       |    8 +-
 batman-adv/main.h              |   33 ++++---
 batman-adv/originator.c        |   16 +++-
 batman-adv/routing.c           |   58 ++++++++-----
 batman-adv/send.c              |   23 ++++--
 batman-adv/translation-table.c |   21 +++--
 batman-adv/types.h             |   12 ++-
 13 files changed, 375 insertions(+), 70 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index 61b6192..d738b7a 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -112,7 +112,8 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
-			bat_dbg(DBG_BATMAN, "batman packet queue full\n");
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"batman packet queue full\n");
 			return;
 		}
 	}
diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 6fe2900..4f99c5c 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -34,6 +34,190 @@
 
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
@@ -125,6 +309,7 @@ int debugfs_add_meshif(struct net_device *dev)
 		goto out;
 
 	bat_socket_setup(bat_priv);
+	debug_log_setup(bat_priv);
 
 	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
 		file = debugfs_create_file(((*bat_debug)->attr).name,
@@ -154,6 +339,8 @@ void debugfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 
+	debug_log_cleanup(bat_priv);
+
 	if (bat_debugfs) {
 		debugfs_remove_recursive(bat_priv->debug_dir);
 		bat_priv->debug_dir = NULL;
diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 68ce453..669b88f 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -276,6 +276,52 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
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
@@ -283,6 +329,9 @@ static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
 		show_orig_interval, store_orig_interval);
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+static BAT_ATTR(log_level, S_IRUGO | S_IWUSR, show_log_level, store_log_level);
+#endif
 
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
@@ -290,6 +339,9 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+	&bat_attr_log_level,
+#endif
 	NULL,
 };
 
@@ -308,6 +360,7 @@ int sysfs_add_meshif(struct net_device *dev)
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_class, 0);
 	atomic_set(&bat_priv->orig_interval, 1000);
+	atomic_set(&bat_priv->log_level, 0);
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
diff --git a/batman-adv/bitarray.c b/batman-adv/bitarray.c
index c10fe03..dd4193c 100644
--- a/batman-adv/bitarray.c
+++ b/batman-adv/bitarray.c
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
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 2288a96..f50bc41 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -80,7 +80,7 @@ void gw_election(void)
 		rcu_read_unlock();
 
 		if (curr_gateway) {
-			bat_dbg(DBG_BATMAN,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
 			gw_deselect();
@@ -137,18 +137,18 @@ void gw_election(void)
 	spin_lock(&curr_gw_lock);
 	if (curr_gateway != curr_gw_tmp) {
 		if ((curr_gateway) && (!curr_gw_tmp))
-			bat_dbg(DBG_BATMAN,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
 		else if ((!curr_gateway) && (curr_gw_tmp))
-			bat_dbg(DBG_BATMAN,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Adding route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
 				curr_gw_tmp->orig_node->orig,
 				curr_gw_tmp->orig_node->gw_flags,
 				curr_gw_tmp->orig_node->router->tq_avg);
 		else
-			bat_dbg(DBG_BATMAN,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Changing route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
 				curr_gw_tmp->orig_node->orig,
@@ -200,7 +200,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_class)))
 		return;
 
-	bat_dbg(DBG_BATMAN,
+	bat_dbg(DBG_BATMAN, bat_priv,
 		"Restarting gateway selection: better gateway found (tq curr: "
 		"%i, tq new: %i)\n",
 		gw_tq_avg, orig_tq_avg);
@@ -211,6 +211,8 @@ deselect:
 
 static void gw_node_add(struct orig_node *orig_node, uint8_t new_gwflags)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct gw_node *gw_node;
 	int down, up;
 
@@ -225,7 +227,7 @@ static void gw_node_add(struct orig_node *orig_node, uint8_t new_gwflags)
 	list_add_tail_rcu(&gw_node->list, &gw_list);
 
 	gw_srv_class_to_kbit(new_gwflags, &down, &up);
-	bat_dbg(DBG_BATMAN,
+	bat_dbg(DBG_BATMAN, bat_priv,
 		"Found new gateway %pM -> gw_class: %i - %i%s/%i%s\n",
 		orig_node->orig, new_gwflags,
 		(down > 2048 ? down / 1024 : down),
@@ -236,6 +238,8 @@ static void gw_node_add(struct orig_node *orig_node, uint8_t new_gwflags)
 
 void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct gw_node *gw_node;
 
 	rcu_read_lock();
@@ -243,7 +247,7 @@ void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
 		if (gw_node->orig_node != orig_node)
 			continue;
 
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Gateway class of originator %pM changed from "
 			"%i to %i\n",
 			orig_node->orig, gw_node->orig_node->gw_flags,
@@ -253,7 +257,7 @@ void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
 
 		if (new_gwflags == 0) {
 			gw_node->deleted = jiffies;
-			bat_dbg(DBG_BATMAN,
+			bat_dbg(DBG_BATMAN, bat_priv,
 				"Gateway %pM removed from gateway list\n",
 				orig_node->orig);
 
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 0773420..fe07c0e 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -445,6 +445,8 @@ static int batman_skb_recv_finish(struct sk_buff *skb)
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct packet_type *ptype, struct net_device *orig_dev)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
 	struct net_device_stats *stats;
@@ -492,7 +494,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	batman_packet = (struct batman_packet *)skb->data;
 
 	if (batman_packet->version != COMPAT_VERSION) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
 			batman_packet->version);
 		goto err_free;
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 08cca22..484f021 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -156,6 +156,8 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 				size_t len, loff_t *off)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct socket_client *socket_client =
 		(struct socket_client *)file->private_data;
 	struct icmp_packet_rr icmp_packet;
@@ -166,7 +168,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"invalid packet size\n");
 		return -EINVAL;
@@ -182,14 +184,14 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
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
diff --git a/batman-adv/main.h b/batman-adv/main.h
index d147f28..656bb25 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
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
@@ -164,4 +152,23 @@ int is_my_mac(uint8_t *addr);
 int is_bcast(uint8_t *addr);
 int is_mcast(uint8_t *addr);
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+extern int debug;
+
+extern int bat_debug_type(int type);
+extern int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
+
+#define bat_dbg(type, bat_priv, fmt, arg...) do {		\
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
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index d276afd..363a412 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -62,9 +62,12 @@ struct neigh_node *
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
@@ -131,7 +134,8 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	if (orig_node != NULL)
 		return orig_node;
 
-	bat_dbg(DBG_BATMAN, "Creating new originator: %pM\n", addr);
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Creating new originator: %pM\n", addr);
 
 	orig_node = kzalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	if (!orig_node)
@@ -184,6 +188,8 @@ free_orig_node:
 static bool purge_orig_neighbors(struct orig_node *orig_node,
 				 struct neigh_node **best_neigh_node)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
@@ -201,13 +207,13 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
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
@@ -234,7 +240,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 	if (time_after(jiffies,
 		orig_node->last_valid + 2 * PURGE_TIMEOUT * HZ)) {
 
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Originator timeout: originator %pM, last_valid %lu\n",
 			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a37c288..b629d8b 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -79,24 +79,27 @@ static void update_route(struct orig_node *orig_node,
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
@@ -127,6 +130,8 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct batman_packet *batman_packet,
 				struct batman_if *if_incoming)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	unsigned char total_count;
 
@@ -213,7 +218,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN,
+	bat_dbg(DBG_BATMAN, bat_priv,
 		"bidirectional: "
 		"orig = %-15pM neigh = %-15pM => own_bcast = %2i, "
 		"real recv = %2i, local tq: %3i, asym_penalty: %3i, "
@@ -241,7 +246,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): "
+	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
 		"Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
@@ -273,7 +278,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 		if (!neigh_node)
 			return;
 	} else
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Updating existing last-hop neighbor of originator\n");
 
 	orig_node->flags = batman_packet->flags;
@@ -335,13 +340,16 @@ update_gw:
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
@@ -363,6 +371,8 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			       struct batman_packet *batman_packet,
 			       struct batman_if *if_incoming)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	char is_duplicate = 0;
@@ -401,7 +411,8 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	}
 
 	if (need_update) {
-		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d\n",
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"updating last_seqno: old %d, new %d\n",
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
@@ -554,7 +565,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] "
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Received BATMAN packet via NB: %pM, IF: %s [%s] "
 		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
 		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
@@ -583,14 +595,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
@@ -598,7 +610,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: "
+		bat_dbg(DBG_BATMAN, bat_priv, "Drop packet: "
 		"ignoring all packets with broadcast source addr (sender: %pM"
 		")\n", ethhdr->h_source);
 		return;
@@ -628,13 +640,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
@@ -647,14 +659,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
@@ -667,7 +679,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: ignoring all rebroadcast packets that "
 			"may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
@@ -684,7 +696,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	 * don't route towards it */
 	if (!is_single_hop_neigh &&
 	    (orig_neigh_node->router == NULL)) {
-		bat_dbg(DBG_BATMAN, "Drop packet: OGM via unknown neighbor!\n");
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Drop packet: OGM via unknown neighbor!\n");
 		return;
 	}
 
@@ -711,24 +724,25 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 3c0bb7d..ba032b9 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -128,6 +128,8 @@ void send_raw_packet(unsigned char *pack_buff, int pack_buff_len,
 static void send_packet_to_if(struct forw_packet *forw_packet,
 			      struct batman_if *batman_if)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	char *fwd_str;
 	uint8_t packet_num;
 	int16_t buff_pos;
@@ -157,7 +159,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
 							    "Sending own" :
 							    "Forwarding"));
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
 			" IDF %s) on interface %s [%s]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
@@ -182,6 +184,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 /* send a batman packet */
 static void send_packet(struct forw_packet *forw_packet)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->packet_buff);
@@ -202,7 +206,7 @@ static void send_packet(struct forw_packet *forw_packet)
 	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
 
 		/* FIXME: what about aggregated packets ? */
-		bat_dbg(DBG_BATMAN,
+		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s packet (originator %pM, seqno %d, TTL %d) "
 			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
@@ -321,7 +325,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned long send_time;
 
 	if (batman_packet->ttl <= 1) {
-		bat_dbg(DBG_BATMAN, "ttl exceeded\n");
+		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
 		return;
 	}
 
@@ -350,7 +354,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, "
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
@@ -414,7 +419,7 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	if (!atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
-		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
+		bat_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
 		goto out;
 	}
 
@@ -530,15 +535,19 @@ out:
 
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
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index b969fe7..1223609 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -61,6 +61,8 @@ int hna_local_init(void)
 
 void hna_local_add(uint8_t *addr)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
@@ -81,15 +83,15 @@ void hna_local_add(uint8_t *addr)
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
@@ -224,7 +226,9 @@ static void _hna_local_del(void *data)
 static void hna_local_del(struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s\n",
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
 	hash_remove(hna_local_hash, hna_local_entry->addr);
@@ -294,6 +298,8 @@ int hna_global_init(void)
 void hna_global_add_orig(struct orig_node *orig_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
 	struct hashtable_t *swaphash;
@@ -320,7 +326,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 
 			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
-			bat_dbg(DBG_ROUTES,
+			bat_dbg(DBG_ROUTES, bat_priv,
 				"Creating new global hna entry: "
 				"%pM (via %pM)\n",
 				hna_global_entry->addr, orig_node->orig);
@@ -429,7 +435,10 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
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
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1daebed..9cd19b7 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -21,8 +21,6 @@
 
 
 
-
-
 #ifndef _NET_BATMAN_ADV_TYPES_H_
 #define _NET_BATMAN_ADV_TYPES_H_
 
@@ -124,9 +122,11 @@ struct bat_priv {
 	atomic_t gw_mode;
 	atomic_t gw_class;
 	atomic_t orig_interval;
+	atomic_t log_level;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
 	char num_ifaces;
+	struct debug_log *debug_log;
 	struct batman_if *primary_if;
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
@@ -184,4 +184,12 @@ struct if_list_entry {
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

