Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  8 May 2011 12:45:45 +0200
Message-Id: <1304851546-16549-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove multiline comments
	from line ending
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

It is slightly irritating that comments after a long line span over
multiple lines without any code. It is easier to put them before the
actual code and reduce the number of lines which the eye has to read.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch makes batman-adv nearly checkpatch clean again - the other part
was submitted to the checkpatch maintainer... maybe he fixes it now
(informed him some months ago and got no reactions - maybe the patch helps
him).

 main.h           |   40 +++++++++++++++++++++-------------------
 packet.h         |    3 +--
 soft-interface.c |    4 ++--
 types.h          |   10 +++++-----
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/main.h b/main.h
index 4832f32..3ca3941 100644
--- a/main.h
+++ b/main.h
@@ -34,16 +34,18 @@
 
 #define TQ_MAX_VALUE 255
 #define JITTER 20
-#define TTL 50			  /* Time To Live of broadcast messages */
 
-#define PURGE_TIMEOUT 200	/* purge originators after time in seconds if no
-				   * valid packet comes in -> TODO: check
-				   * influence on TQ_LOCAL_WINDOW_SIZE */
+ /* Time To Live of broadcast messages */
+#define TTL 50
+
+/* purge originators after time in seconds if no valid packet comes in
+ * -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
+#define PURGE_TIMEOUT 200
 #define TT_LOCAL_TIMEOUT 3600 /* in seconds */
 
-#define TQ_LOCAL_WINDOW_SIZE 64	  /* sliding packet range of received originator
-				   * messages in squence numbers (should be a
-				   * multiple of our word size) */
+/* sliding packet range of received originator messages in squence numbers
+ * (should be a multiple of our word size) */
+#define TQ_LOCAL_WINDOW_SIZE 64
 #define TQ_GLOBAL_WINDOW_SIZE 5
 #define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
@@ -55,21 +57,20 @@
 
 #define VIS_INTERVAL 5000	/* 5 seconds */
 
-/* how much worse secondary interfaces may be to
- * to be considered as bonding candidates */
-
+/* how much worse secondary interfaces may be to be considered as bonding
+ * candidates */
 #define BONDING_TQ_THRESHOLD	50
 
-#define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes or
-				   * change the size of
-				   * forw_packet->direct_link_flags */
+/* should not be bigger than 512 bytes or change the size of
+ * forw_packet->direct_link_flags */
+#define MAX_AGGREGATION_BYTES 512
 #define MAX_AGGREGATION_MS 100
 
 #define SOFTIF_NEIGH_TIMEOUT 180000 /* 3 minutes */
 
+/* don't reset again within 30 seconds */
 #define RESET_PROTECTION_MS 30000
 #define EXPECTED_SEQNO_RANGE	65536
-/* don't reset again within 30 seconds */
 
 #define MESH_INACTIVE 0
 #define MESH_ACTIVE 1
@@ -84,12 +85,13 @@
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* Append 'batman-adv: ' before
-					     * kernel messages */
+/* Append 'batman-adv: ' before kernel messages */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define DBG_BATMAN 1	/* all messages related to routing / flooding /
-			 * broadcasting / etc */
-#define DBG_ROUTES 2	/* route or tt entry added / changed / deleted */
+/* all messages related to routing / flooding / broadcasting / etc */
+#define DBG_BATMAN 1
+/* route or tt entry added / changed / deleted */
+#define DBG_ROUTES 2
 #define DBG_ALL 3
 
 
diff --git a/packet.h b/packet.h
index c225c3a..eda9965 100644
--- a/packet.h
+++ b/packet.h
@@ -128,8 +128,7 @@ struct vis_packet {
 	uint8_t  entries;	 /* number of entries behind this struct */
 	uint32_t seqno;		 /* sequence number */
 	uint8_t  ttl;		 /* TTL */
-	uint8_t  vis_orig[6];	 /* originator that informs about its
-				  * neighbors */
+	uint8_t  vis_orig[6];	 /* originator that announces its neighbors */
 	uint8_t  target_orig[6]; /* who should receive this packet */
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __packed;
diff --git a/soft-interface.c b/soft-interface.c
index ae10ecc..c76a33e 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -789,8 +789,8 @@ static void interface_setup(struct net_device *dev)
 	 * have not been initialized yet
 	 */
 	dev->mtu = ETH_DATA_LEN;
-	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
-						* skbuff for our header */
+	/* reserve more space in the skbuff for our header */
+	dev->hard_header_len = BAT_HEADER_LEN;
 
 	/* generate random address */
 	random_ether_addr(dev_addr);
diff --git a/types.h b/types.h
index 6b6c32e..fab70e8 100644
--- a/types.h
+++ b/types.h
@@ -89,11 +89,11 @@ struct orig_node {
 	struct hlist_node hash_entry;
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
-	spinlock_t ogm_cnt_lock; /* protects: bcast_own, bcast_own_sum,
-				  * neigh_node->real_bits,
-				  * neigh_node->real_packet_count */
-	spinlock_t bcast_seqno_lock; /* protects bcast_bits,
-				      *	 last_bcast_seqno */
+	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
+	 * neigh_node->real_bits, neigh_node->real_packet_count */
+	spinlock_t ogm_cnt_lock;
+	/* bcast_seqno_lock protects bcast_bits, last_bcast_seqno */
+	spinlock_t bcast_seqno_lock;
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
-- 
1.7.5.1

