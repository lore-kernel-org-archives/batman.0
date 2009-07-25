Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 25 Jul 2009 15:13:31 +0200
Message-Id: <1248527611-5246-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Cleanup smaller style problems
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

Make some files clean with respect to the 2.6.29 checkpatch
script. Exceptions are long lines with printk/seq_print.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/compat.h  |    2 +-
 batman-adv-kernelland/proc.c    |   10 +++++-----
 batman-adv-kernelland/routing.c |    8 ++++----
 batman-adv-kernelland/types.h   |   27 +++++++++------------------
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compat.h
index af0cc96..2f0877c 100644
--- a/batman-adv-kernelland/compat.h
+++ b/batman-adv-kernelland/compat.h
@@ -57,6 +57,6 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 23)
 
-#define cancel_delayed_work_sync(wq) cancel_rearming_delayed_work(wq) 
+#define cancel_delayed_work_sync(wq) cancel_rearming_delayed_work(wq)
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 23) */
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 0105c3e..dd109a5 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -597,7 +597,7 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 {
 	char *aggr_string;
 	int not_copied = 0;
-	int16_t aggregation_enabled_tmp;
+	long aggregation_enabled_tmp;
 
 	aggr_string = kmalloc(count, GFP_KERNEL);
 
@@ -607,21 +607,21 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 	not_copied = copy_from_user(aggr_string, buffer, count);
 	aggr_string[count - not_copied - 1] = 0;
 
-	aggregation_enabled_tmp = simple_strtol(aggr_string, NULL, 10);
+	strict_strtol(aggr_string, 10, &aggregation_enabled_tmp);
 
 	if ((aggregation_enabled_tmp != 0) && (aggregation_enabled_tmp != 1)) {
-		debug_log(LOG_TYPE_WARN, "Aggregation can only be enabled (1) or disabled (0), given value: %i\n", aggregation_enabled_tmp);
+		debug_log(LOG_TYPE_WARN, "Aggregation can only be enabled (1) or disabled (0), given value: %li\n", aggregation_enabled_tmp);
 		goto end;
 	}
 
-	debug_log(LOG_TYPE_NOTICE, "Changing aggregation from: %s (%i) to: %s (%i)\n",
+	debug_log(LOG_TYPE_NOTICE, "Changing aggregation from: %s (%i) to: %s (%li)\n",
 		  (atomic_read(&aggregation_enabled) == 1 ?
 		   "enabled" : "disabled"),
 		  atomic_read(&aggregation_enabled),
 		  (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
 		  aggregation_enabled_tmp);
 
-	atomic_set(&aggregation_enabled, aggregation_enabled_tmp);
+	atomic_set(&aggregation_enabled, (unsigned)aggregation_enabled_tmp);
 end:
 	kfree(aggr_string);
 	return count;
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 269c932..b576f8c 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -186,7 +186,7 @@ static void update_routes(struct orig_node *orig_node, struct neigh_node *neigh_
 	/* may be just HNA changed */
 	} else {
 
-		if ((hna_buff_len != orig_node->hna_buff_len) || ((hna_buff_len > 0 ) && (orig_node->hna_buff_len > 0) && (memcmp(orig_node->hna_buff, hna_buff, hna_buff_len) != 0))) {
+		if ((hna_buff_len != orig_node->hna_buff_len) || ((hna_buff_len > 0) && (orig_node->hna_buff_len > 0) && (memcmp(orig_node->hna_buff, hna_buff, hna_buff_len) != 0))) {
 
 			if (orig_node->hna_buff_len > 0)
 				hna_global_del_orig(orig_node, "originator changed hna");
@@ -227,7 +227,7 @@ static int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *o
 				neigh_node = tmp_neigh_node;
 		}
 
-		if ( neigh_node == NULL )
+		if (neigh_node == NULL)
 			neigh_node = create_neighbor(orig_neigh_node, orig_neigh_node, orig_neigh_node->orig, if_incoming);
 	}
 
@@ -612,8 +612,8 @@ int packet_recv_thread(void *data)
 					result = 0;
 					break;
 				}
-
-				if ((result = receive_raw_packet(batman_if->raw_sock, packet_buff, PACKBUFF_SIZE)) <= 0)
+				result = receive_raw_packet(batman_if->raw_sock, packet_buff, PACKBUFF_SIZE);
+				if (result <= 0)
 					break;
 
 				if (result < sizeof(struct ethhdr) + 2)
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index 4001b59..0c31b4d 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -30,8 +30,7 @@
 #define BAT_HEADER_LEN (sizeof(struct ethhdr) + ((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? sizeof(struct unicast_packet) : sizeof(struct bcast_packet))))
 
 
-struct batman_if
-{
+struct batman_if {
 	struct list_head list;
 	int16_t if_num;
 	char *dev;
@@ -46,8 +45,7 @@ struct batman_if
 
 };
 
-struct orig_node                 /* structure for orig_list maintaining nodes of mesh */
-{
+struct orig_node {               /* structure for orig_list maintaining nodes of mesh */
 	uint8_t orig[ETH_ALEN];
 	struct neigh_node *router;
 	struct batman_if *batman_if;
@@ -67,8 +65,7 @@ struct orig_node                 /* structure for orig_list maintaining nodes of
 	struct list_head neigh_list;
 };
 
-struct neigh_node
-{
+struct neigh_node {
 	struct list_head list;
 	uint8_t addr[ETH_ALEN];
 	uint8_t real_packet_count;
@@ -82,13 +79,11 @@ struct neigh_node
 	struct batman_if *if_incoming;
 };
 
-struct bat_priv
-{
+struct bat_priv {
 	struct net_device_stats stats;
 };
 
-struct device_client
-{
+struct device_client {
 	struct list_head queue_list;
 	unsigned int queue_len;
 	unsigned char index;
@@ -96,27 +91,23 @@ struct device_client
 	wait_queue_head_t queue_wait;
 };
 
-struct device_packet
-{
+struct device_packet {
 	struct list_head list;
 	struct icmp_packet icmp_packet;
 };
 
-struct hna_local_entry
-{
+struct hna_local_entry {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
 	char never_purge;
 };
 
-struct hna_global_entry
-{
+struct hna_global_entry {
 	uint8_t addr[ETH_ALEN];
 	struct orig_node *orig_node;
 };
 
-struct forw_packet                 /* structure for forw_list maintaining packets to be send/forwarded */
-{
+struct forw_packet {               /* structure for forw_list maintaining packets to be send/forwarded */
 	struct hlist_node list;
 	unsigned long send_time;
 	uint8_t own;
-- 
1.6.3.3

