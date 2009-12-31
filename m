Return-Path: <linus.luessing@web.de>
Date: Thu, 31 Dec 2009 04:37:52 +0100
From: =?utf-8?B?PT9VVEYtOD9xP0xpbnVzPTIwTD1DMz1CQ3NzaW5nPz0=?=
	<linus.luessing@web.de>
Message-ID: <20091231033752.GA18781@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: atomic variable for vis-srv
	activation
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

This fixes the bug discovered by Marek which did not allow turning on
the vis-server before an interface has been added. This is now being
done in a similar way as for (de)activating the aggregation mode with an
atomic variable.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c |    2 ++
 main.h |    1 +
 proc.c |   43 ++++++++++++++++++++++++-------------------
 send.c |    2 +-
 vis.c  |   41 +++--------------------------------------
 vis.h  |    2 --
 6 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/main.c b/main.c
index c733504..843d552 100644
--- a/main.c
+++ b/main.c
@@ -44,6 +44,7 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 atomic_t originator_interval;
 atomic_t vis_interval;
+atomic_t vis_srv_enabled;
 atomic_t aggregation_enabled;
 int16_t num_hna;
 int16_t num_ifs;
@@ -84,6 +85,7 @@ int init_module(void)
 	atomic_set(&originator_interval, 1000);
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
+	atomic_set(&vis_srv_enabled, 0);
 	atomic_set(&aggregation_enabled, 1);
 
 	/* the name should not be longer than 10 chars - see
diff --git a/main.h b/main.h
index 3dfe5fe..385818f 100644
--- a/main.h
+++ b/main.h
@@ -130,6 +130,7 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
+extern atomic_t vis_srv_enabled;
 extern atomic_t aggregation_enabled;
 extern int16_t num_hna;
 extern int16_t num_ifs;
diff --git a/proc.c b/proc.c
index 61e1d0d..e7b7bf3 100644
--- a/proc.c
+++ b/proc.c
@@ -325,36 +325,41 @@ static int proc_transt_global_open(struct inode *inode, struct file *file)
 static ssize_t proc_vis_srv_write(struct file *file, const char __user * buffer,
 			      size_t count, loff_t *ppos)
 {
-	char *vis_mode_string;
+	char *vis_srv_string;
 	int not_copied = 0;
+	unsigned long vis_srv_enabled_tmp;
+	int retval;
 
-	vis_mode_string = kmalloc(count, GFP_KERNEL);
+	vis_srv_string = kmalloc(count, GFP_KERNEL);
 
-	if (!vis_mode_string)
+	if (!vis_srv_string)
 		return -ENOMEM;
 
-	not_copied = copy_from_user(vis_mode_string, buffer, count);
-	vis_mode_string[count - not_copied - 1] = 0;
-
-	if ((strcmp(vis_mode_string, "client") == 0) ||
-			(strcmp(vis_mode_string, "disabled") == 0)) {
-		printk(KERN_INFO "batman-adv:Setting VIS mode to client (disabling vis server)\n");
-		vis_set_mode(VIS_TYPE_CLIENT_UPDATE);
-	} else if ((strcmp(vis_mode_string, "server") == 0) ||
-			(strcmp(vis_mode_string, "enabled") == 0)) {
-		printk(KERN_INFO "batman-adv:Setting VIS mode to server (enabling vis server)\n");
-		vis_set_mode(VIS_TYPE_SERVER_SYNC);
-	} else
+	not_copied = copy_from_user(vis_srv_string, buffer, count);
+	vis_srv_string[count - not_copied - 1] = 0;
+
+	retval = strict_strtoul(vis_srv_string, 10, &vis_srv_enabled_tmp);
+
+	/* Unknown vis mode input? */
+	if (retval == -EINVAL || vis_srv_enabled_tmp > 1) {
 		printk(KERN_ERR "batman-adv:Unknown VIS mode: %s\n",
-		       vis_mode_string);
+		       vis_srv_string);
+	}
+	else {
+		if (vis_srv_enabled_tmp == 0)
+			printk(KERN_INFO "batman-adv:Setting VIS mode to client (disabling vis server)\n");
+		else
+			printk(KERN_INFO "batman-adv:Setting VIS mode to server (enabling vis server)\n");
+		atomic_set(&vis_srv_enabled, vis_srv_enabled_tmp);
+	}
 
-	kfree(vis_mode_string);
+	kfree(vis_srv_string);
 	return count;
 }
 
 static int proc_vis_srv_read(struct seq_file *seq, void *offset)
 {
-	int vis_server = is_vis_server();
+	int vis_server = atomic_read(&vis_srv_enabled);
 
 	seq_printf(seq, "[%c] client mode (server disabled) \n",
 			(!vis_server) ? 'x' : ' ');
@@ -380,7 +385,7 @@ static int proc_vis_data_read(struct seq_file *seq, void *offset)
 	unsigned long flags;
 
 	rcu_read_lock();
-	if (list_empty(&if_list) || (!is_vis_server())) {
+	if (list_empty(&if_list) || (!atomic_read(&vis_srv_enabled))) {
 		rcu_read_unlock();
 		goto end;
 	}
diff --git a/send.c b/send.c
index fd48f3f..92d14a6 100644
--- a/send.c
+++ b/send.c
@@ -279,7 +279,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	/* change sequence number to network order */
 	batman_packet->seqno = htons((uint16_t)atomic_read(&batman_if->seqno));
 
-	if (is_vis_server())
+	if (atomic_read(&vis_srv_enabled))
 		batman_packet->flags = VIS_SERVER;
 	else
 		batman_packet->flags = 0;
diff --git a/vis.c b/vis.c
index fa8afdb..e7c14b5 100644
--- a/vis.c
+++ b/vis.c
@@ -49,41 +49,6 @@ static void free_info(void *data)
 	kfree(info);
 }
 
-/* set the mode of the visualization to client or server */
-void vis_set_mode(int mode)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&vis_hash_lock, flags);
-
-	if (my_vis_info != NULL)
-		my_vis_info->packet.vis_type = mode;
-
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-}
-
-/* is_vis_server(), locked outside */
-static int is_vis_server_locked(void)
-{
-	if (my_vis_info != NULL)
-		if (my_vis_info->packet.vis_type == VIS_TYPE_SERVER_SYNC)
-			return 1;
-
-	return 0;
-}
-
-/* get the current set mode */
-int is_vis_server(void)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vis_hash_lock, flags);
-	ret = is_vis_server_locked();
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-
-	return ret;
-}
-
 /* Compare two vis packets, used by the hashing algorithm */
 static int vis_info_cmp(void *data1, void *data2)
 {
@@ -280,7 +245,7 @@ void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
 
 	/* only if we are server ourselves and packet is newer than the one in
 	 * hash.*/
-	if (is_vis_server_locked() && is_new) {
+	if (atomic_read(&vis_srv_enabled) && is_new) {
 		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
@@ -309,7 +274,7 @@ void receive_client_update_packet(struct vis_packet *vis_packet,
 
 
 	/* send only if we're the target server or ... */
-	if (is_vis_server_locked() &&
+	if (atomic_read(&vis_srv_enabled) &&
 	    is_my_mac(info->packet.target_orig) &&
 	    is_new) {
 		info->packet.vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
@@ -380,7 +345,7 @@ static int generate_vis_packet(void)
 	info->packet.seqno++;
 	info->packet.entries = 0;
 
-	if (!is_vis_server_locked()) {
+	if (!atomic_read(&vis_srv_enabled)) {
 		best_tq = find_best_vis_server(info);
 		if (best_tq < 0) {
 			spin_unlock_irqrestore(&orig_hash_lock, flags);
diff --git a/vis.h b/vis.h
index 2e24258..0cdafde 100644
--- a/vis.h
+++ b/vis.h
@@ -48,8 +48,6 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-void vis_set_mode(int mode);
-int is_vis_server(void);
 void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
 				struct hlist_head *if_list,
-- 
1.6.5.7

