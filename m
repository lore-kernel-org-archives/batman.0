Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 15 Jun 2011 09:41:37 +0200
Message-Id: <1308123697-7893-3-git-send-email-sven@narfation.org>
In-Reply-To: <1308123697-7893-1-git-send-email-sven@narfation.org>
References: <1308123697-7893-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Reduce usage of char
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

char was used in different places to store information without really
using the characteristics of that data type or by ignoring the fact that
char has not a well defined signedness.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 aggregation.c    |    2 +-
 aggregation.h    |    2 +-
 bitarray.c       |    4 ++--
 bitarray.h       |    4 ++--
 gateway_client.c |    2 +-
 gateway_common.c |    6 +++---
 main.h           |    2 +-
 routing.c        |    8 ++++----
 send.c           |    6 +++---
 send.h           |    2 +-
 soft-interface.c |    2 +-
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index ede0a56..c583e04 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -190,7 +190,7 @@ static void aggregate(struct forw_packet *forw_packet_aggr,
 
 void add_bat_packet_to_list(struct bat_priv *bat_priv,
 			    unsigned char *packet_buff, int packet_len,
-			    struct hard_iface *if_incoming, char own_packet,
+			    struct hard_iface *if_incoming, int own_packet,
 			    unsigned long send_time)
 {
 	/**
diff --git a/aggregation.h b/aggregation.h
index 2b7b852..216337b 100644
--- a/aggregation.h
+++ b/aggregation.h
@@ -37,7 +37,7 @@ static inline int aggregated_packet(int buff_pos, int packet_len,
 
 void add_bat_packet_to_list(struct bat_priv *bat_priv,
 			    unsigned char *packet_buff, int packet_len,
-			    struct hard_iface *if_incoming, char own_packet,
+			    struct hard_iface *if_incoming, int own_packet,
 			    unsigned long send_time);
 void receive_aggr_bat_packet(const struct ethhdr *ethhdr,
 			     unsigned char *packet_buff, int packet_len,
diff --git a/bitarray.c b/bitarray.c
index 3659a25..c1f4bfc 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -127,8 +127,8 @@ static void bit_reset_window(unsigned long *seq_bits)
  *  1 if the window was moved (either new or very old)
  *  0 if the window was not moved/shifted.
  */
-char bit_get_packet(void *priv, unsigned long *seq_bits,
-		    int32_t seq_num_diff, int8_t set_mark)
+int bit_get_packet(void *priv, unsigned long *seq_bits,
+		    int32_t seq_num_diff, int set_mark)
 {
 	struct bat_priv *bat_priv = priv;
 
diff --git a/bitarray.h b/bitarray.h
index 9fcdbdf..7051f1f 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -35,8 +35,8 @@ void bit_mark(unsigned long *seq_bits, int32_t n);
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
-char bit_get_packet(void *priv, unsigned long *seq_bits,
-		    int32_t seq_num_diff, int8_t set_mark);
+int bit_get_packet(void *priv, unsigned long *seq_bits,
+		   int32_t seq_num_diff, int set_mark);
 
 /* count the hamming weight, how many good packets did we receive? */
 int bit_packet_count(const unsigned long *seq_bits);
diff --git a/gateway_client.c b/gateway_client.c
index d90463a..8b25b52 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -396,7 +396,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
 	struct gw_node *gw_node, *curr_gw;
 	struct hlist_node *node, *node_tmp;
 	unsigned long timeout = 2 * PURGE_TIMEOUT * HZ;
-	char do_deselect = 0;
+	int do_deselect = 0;
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
 
diff --git a/gateway_common.c b/gateway_common.c
index e74307b..18661af 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -61,9 +61,9 @@ static void kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
 /* returns the up and downspeeds in kbit, calculated from the class */
 void gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 {
-	char sbit = (gw_srv_class & 0x80) >> 7;
-	char dpart = (gw_srv_class & 0x78) >> 3;
-	char upart = (gw_srv_class & 0x07);
+	int sbit = (gw_srv_class & 0x80) >> 7;
+	int dpart = (gw_srv_class & 0x78) >> 3;
+	int upart = (gw_srv_class & 0x07);
 
 	if (!gw_srv_class) {
 		*down = 0;
diff --git a/main.h b/main.h
index 059866c..f3fe9f4 100644
--- a/main.h
+++ b/main.h
@@ -174,7 +174,7 @@ int debug_log(struct bat_priv *bat_priv, const char *fmt, ...) __printf(2, 3);
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
 __printf(3, 4)
-static inline void bat_dbg(char type __always_unused,
+static inline void bat_dbg(int type __always_unused,
 			   struct bat_priv *bat_priv __always_unused,
 			   const char *fmt __always_unused, ...)
 {
diff --git a/routing.c b/routing.c
index 2e037e3..d8999a3 100644
--- a/routing.c
+++ b/routing.c
@@ -184,7 +184,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node;
 	struct hlist_node *node;
-	unsigned char total_count;
+	uint8_t total_count;
 	uint8_t orig_eq_count, neigh_rq_count, tq_own;
 	int tq_asym_penalty, ret = 0;
 
@@ -622,9 +622,9 @@ void receive_bat_packet(const struct ethhdr *ethhdr,
 	struct orig_node *orig_neigh_node, *orig_node;
 	struct neigh_node *router = NULL, *router_router = NULL;
 	struct neigh_node *orig_neigh_router = NULL;
-	char has_directlink_flag;
-	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
-	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
+	int has_directlink_flag;
+	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
+	int is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
 	int is_duplicate;
 	uint32_t if_incoming_seqno;
 
diff --git a/send.c b/send.c
index a150c7c..7a2f082 100644
--- a/send.c
+++ b/send.c
@@ -165,7 +165,7 @@ static void send_packet(struct forw_packet *forw_packet)
 	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->skb->data);
-	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
+	int directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not "
@@ -352,12 +352,12 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 void schedule_forward_packet(struct orig_node *orig_node,
 			     const struct ethhdr *ethhdr,
 			     struct batman_packet *batman_packet,
-			     uint8_t directlink,
+			     int directlink,
 			     struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *router;
-	unsigned char in_tq, in_ttl, tq_avg = 0;
+	uint8_t in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 	uint8_t tt_num_changes;
 
diff --git a/send.h b/send.h
index bd5ab77..633224a 100644
--- a/send.h
+++ b/send.h
@@ -28,7 +28,7 @@ void schedule_own_packet(struct hard_iface *hard_iface);
 void schedule_forward_packet(struct orig_node *orig_node,
 			     const struct ethhdr *ethhdr,
 			     struct batman_packet *batman_packet,
-			     uint8_t directlink,
+			     int directlink,
 			     struct hard_iface *if_outgoing);
 int add_bcast_packet_to_list(struct bat_priv *bat_priv,
 			     const struct sk_buff *skb);
diff --git a/soft-interface.c b/soft-interface.c
index 7aeed0d..ab420ea 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -381,7 +381,7 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
 	struct softif_neigh *softif_neigh, *curr_softif_neigh;
 	struct softif_neigh_vid *softif_neigh_vid;
 	struct hlist_node *node, *node_tmp, *node_tmp2;
-	char do_deselect;
+	int do_deselect;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(softif_neigh_vid, node,
-- 
1.7.5.3

