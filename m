Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 18 Jan 2010 21:42:29 +0100
Message-Id: <1263847349-2690-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <201001151934.41937.sven.eckelmann@gmx.de>
References: <201001151934.41937.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: atomic variable for vis-srv
	activation
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

This fixes the bug discovered by Marek Lindner which did not allow
turning on the vis-server before an interface has been added. With this
patch we are using a global atomic variable for activating and
deactiating the vis-server-mode instead, which can be used before
inserting an interface.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batman-adv-kernelland/main.c |    2 +
 batman-adv-kernelland/main.h |    1 +
 batman-adv-kernelland/proc.c |   13 ++++++-----
 batman-adv-kernelland/send.c |    3 +-
 batman-adv-kernelland/vis.c  |   45 +++++------------------------------------
 batman-adv-kernelland/vis.h  |    2 -
 6 files changed, 18 insertions(+), 48 deletions(-)

diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index a64f070..002e6ea 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -46,6 +46,7 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 atomic_t originator_interval;
 atomic_t vis_interval;
+atomic_t vis_mode;
 atomic_t aggregation_enabled;
 int16_t num_hna;
 int16_t num_ifs;
@@ -86,6 +87,7 @@ int init_module(void)
 	atomic_set(&originator_interval, 1000);
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
+	atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&aggregation_enabled, 1);
 	atomic_set(&gw_mode, GW_MODE_OFF);
 	atomic_set(&gw_srv_class, 0);
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index 3dfe5fe..5daa9a4 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -130,6 +130,7 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
+extern atomic_t vis_mode;
 extern atomic_t aggregation_enabled;
 extern int16_t num_hna;
 extern int16_t num_ifs;
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 747ed5f..c41dc19 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -342,11 +342,11 @@ static ssize_t proc_vis_srv_write(struct file *file, const char __user * buffer,
 	if ((strcmp(vis_mode_string, "client") == 0) ||
 			(strcmp(vis_mode_string, "disabled") == 0)) {
 		printk(KERN_INFO "batman-adv:Setting VIS mode to client (disabling vis server)\n");
-		vis_set_mode(VIS_TYPE_CLIENT_UPDATE);
+		atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	} else if ((strcmp(vis_mode_string, "server") == 0) ||
 			(strcmp(vis_mode_string, "enabled") == 0)) {
 		printk(KERN_INFO "batman-adv:Setting VIS mode to server (enabling vis server)\n");
-		vis_set_mode(VIS_TYPE_SERVER_SYNC);
+		atomic_set(&vis_mode, VIS_TYPE_SERVER_SYNC);
 	} else
 		printk(KERN_ERR "batman-adv:Unknown VIS mode: %s\n",
 		       vis_mode_string);
@@ -357,12 +357,12 @@ static ssize_t proc_vis_srv_write(struct file *file, const char __user * buffer,
 
 static int proc_vis_srv_read(struct seq_file *seq, void *offset)
 {
-	int vis_server = is_vis_server();
+	int vis_server = atomic_read(&vis_mode);
 
 	seq_printf(seq, "[%c] client mode (server disabled) \n",
-			(!vis_server) ? 'x' : ' ');
+			(vis_server == VIS_TYPE_CLIENT_UPDATE) ? 'x' : ' ');
 	seq_printf(seq, "[%c] server mode (server enabled) \n",
-			(vis_server) ? 'x' : ' ');
+			(vis_server == VIS_TYPE_SERVER_SYNC) ? 'x' : ' ');
 
 	return 0;
 }
@@ -381,9 +381,10 @@ static int proc_vis_data_read(struct seq_file *seq, void *offset)
 	int i;
 	char tmp_addr_str[ETH_STR_LEN];
 	unsigned long flags;
+	int vis_server = atomic_read(&vis_mode);
 
 	rcu_read_lock();
-	if (list_empty(&if_list) || (!is_vis_server())) {
+	if (list_empty(&if_list) || (vis_server == VIS_TYPE_CLIENT_UPDATE)) {
 		rcu_read_unlock();
 		goto end;
 	}
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index a40e8b8..dc9b217 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -251,6 +251,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 {
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
+	int vis_server = atomic_read(&vis_mode);
 
 	/**
 	 * the interface gets activated here to avoid race conditions between
@@ -275,7 +276,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	/* change sequence number to network order */
 	batman_packet->seqno = htons((uint16_t)atomic_read(&batman_if->seqno));
 
-	if (is_vis_server())
+	if (vis_server == VIS_TYPE_SERVER_SYNC)
 		batman_packet->flags = VIS_SERVER;
 	else
 		batman_packet->flags = 0;
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index fa8afdb..b118d1e 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
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
@@ -272,6 +237,7 @@ void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
 	struct vis_info *info;
 	int is_new;
 	unsigned long flags;
+	int vis_server = atomic_read(&vis_mode);
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	info = add_packet(vis_packet, vis_info_len, &is_new);
@@ -280,7 +246,7 @@ void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
 
 	/* only if we are server ourselves and packet is newer than the one in
 	 * hash.*/
-	if (is_vis_server_locked() && is_new) {
+	if (vis_server == VIS_TYPE_SERVER_SYNC && is_new) {
 		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 		if (list_empty(&info->send_list))
 			list_add_tail(&info->send_list, &send_list);
@@ -296,6 +262,7 @@ void receive_client_update_packet(struct vis_packet *vis_packet,
 	struct vis_info *info;
 	int is_new;
 	unsigned long flags;
+	int vis_server = atomic_read(&vis_mode);
 
 	/* clients shall not broadcast. */
 	if (is_bcast(vis_packet->target_orig))
@@ -309,7 +276,7 @@ void receive_client_update_packet(struct vis_packet *vis_packet,
 
 
 	/* send only if we're the target server or ... */
-	if (is_vis_server_locked() &&
+	if (vis_server == VIS_TYPE_SERVER_SYNC  &&
 	    is_my_mac(info->packet.target_orig) &&
 	    is_new) {
 		info->packet.vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
@@ -373,6 +340,7 @@ static int generate_vis_packet(void)
 	unsigned long flags;
 
 	info->first_seen = jiffies;
+	info->packet.vis_type = atomic_read(&vis_mode);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
@@ -380,7 +348,7 @@ static int generate_vis_packet(void)
 	info->packet.seqno++;
 	info->packet.entries = 0;
 
-	if (!is_vis_server_locked()) {
+	if (info->packet.vis_type == VIS_TYPE_CLIENT_UPDATE) {
 		best_tq = find_best_vis_server(info);
 		if (best_tq < 0) {
 			spin_unlock_irqrestore(&orig_hash_lock, flags);
@@ -578,7 +546,6 @@ int vis_init(void)
 	INIT_LIST_HEAD(&my_vis_info->send_list);
 	my_vis_info->packet.version = COMPAT_VERSION;
 	my_vis_info->packet.packet_type = BAT_VIS;
-	my_vis_info->packet.vis_type = VIS_TYPE_CLIENT_UPDATE;
 	my_vis_info->packet.ttl = TTL;
 	my_vis_info->packet.seqno = 0;
 	my_vis_info->packet.entries = 0;
diff --git a/batman-adv-kernelland/vis.h b/batman-adv-kernelland/vis.h
index 2e24258..0cdafde 100644
--- a/batman-adv-kernelland/vis.h
+++ b/batman-adv-kernelland/vis.h
@@ -48,8 +48,6 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-void vis_set_mode(int mode);
-int is_vis_server(void);
 void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
 				struct hlist_head *if_list,
-- 
1.6.6

