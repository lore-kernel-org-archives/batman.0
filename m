Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:11 +0200
Message-Id: <1284836482-23431-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/12] Staging: batman-adv: checkpatch
	cleanup of comments
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

checkpatch now detects the start of a comment and warns about usage of
multiple spaces at the beginning of a line. We have to replace the '   '
in multiple lines comments by ' * ' to fix it.

Checkpatch also wants a comment after a definition of a spinlock_t which
describes what it protects. It is currently not possible to add it
before the actual struct which includes the spinlock.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/packet.h |    2 +-
 drivers/staging/batman-adv/types.h  |   19 ++++++++++---------
 drivers/staging/batman-adv/vis.c    |   16 ++++++++--------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index 44de1bf..2693383 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -79,7 +79,7 @@ struct icmp_packet {
 #define BAT_RR_LEN 16
 
 /* icmp_packet_rr must start with all fields from imcp_packet
-   as this is assumed by code that handles ICMP packets */
+ * as this is assumed by code that handles ICMP packets */
 struct icmp_packet_rr {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 9d744d8..478277f 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -109,6 +109,7 @@ struct neigh_node {
 	struct batman_if *if_incoming;
 };
 
+
 struct bat_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
@@ -133,13 +134,13 @@ struct bat_priv {
 	struct hashtable_t *hna_local_hash;
 	struct hashtable_t *hna_global_hash;
 	struct hashtable_t *vis_hash;
-	spinlock_t orig_hash_lock;
-	spinlock_t forw_bat_list_lock;
-	spinlock_t forw_bcast_list_lock;
-	spinlock_t hna_lhash_lock;
-	spinlock_t hna_ghash_lock;
-	spinlock_t vis_hash_lock;
-	spinlock_t vis_list_lock;
+	spinlock_t orig_hash_lock; /* protects orig_hash */
+	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
+	spinlock_t forw_bcast_list_lock; /* protects  */
+	spinlock_t hna_lhash_lock; /* protects hna_local_hash */
+	spinlock_t hna_ghash_lock; /* protects hna_global_hash */
+	spinlock_t vis_hash_lock; /* protects vis_hash */
+	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	int16_t num_local_hna;
 	atomic_t hna_local_changed;
 	struct delayed_work hna_work;
@@ -152,7 +153,7 @@ struct socket_client {
 	struct list_head queue_list;
 	unsigned int queue_len;
 	unsigned char index;
-	spinlock_t lock;
+	spinlock_t lock; /* protects queue_list, queue_len, index */
 	wait_queue_head_t queue_wait;
 	struct bat_priv *bat_priv;
 };
@@ -204,7 +205,7 @@ struct debug_log {
 	char log_buff[LOG_BUF_LEN];
 	unsigned long log_start;
 	unsigned long log_end;
-	spinlock_t lock;
+	spinlock_t lock; /* protects log_buff, log_start and log_end */
 	wait_queue_head_t queue_wait;
 };
 
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index b2cec8e..6b102a3 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -33,14 +33,14 @@
 #define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
 
 /* Checks if a sequence number x is a predecessor/successor of y.
-   they handle overflows/underflows and can correctly check for a
-   predecessor/successor unless the variable sequence number has grown by
-   more then 2**(bitwidth(x)-1)-1.
-   This means that for a uint8_t with the maximum value 255, it would think:
-    * when adding nothing - it is neither a predecessor nor a successor
-    * before adding more than 127 to the starting value - it is a predecessor,
-    * when adding 128 - it is neither a predecessor nor a successor,
-    * after adding more than 127 to the starting value - it is a successor */
+ * they handle overflows/underflows and can correctly check for a
+ * predecessor/successor unless the variable sequence number has grown by
+ * more then 2**(bitwidth(x)-1)-1.
+ * This means that for a uint8_t with the maximum value 255, it would think:
+ *  - when adding nothing - it is neither a predecessor nor a successor
+ *  - before adding more than 127 to the starting value - it is a predecessor,
+ *  - when adding 128 - it is neither a predecessor nor a successor,
+ *  - after adding more than 127 to the starting value - it is a successor */
 #define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
 			_dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
-- 
1.7.2.3

