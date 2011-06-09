Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  9 Jun 2011 23:09:14 +0200
Message-Id: <1307653754-5014-7-git-send-email-sven@narfation.org>
In-Reply-To: <1307653754-5014-1-git-send-email-sven@narfation.org>
References: <1307653754-5014-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: use NO_FLAGS define instead
	of hard-coding 0
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

The definition NO_FLAGS was introduced to make the code more
readable and shall be used to initialize flag fields.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/aggregation.c    |    2 +-
 net/batman-adv/gateway_client.c |    4 ++--
 net/batman-adv/hard-interface.c |    2 +-
 net/batman-adv/main.h           |    2 ++
 net/batman-adv/send.c           |    2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/aggregation.c b/net/batman-adv/aggregation.c
index b41f25b..4080970 100644
--- a/net/batman-adv/aggregation.c
+++ b/net/batman-adv/aggregation.c
@@ -151,7 +151,7 @@ static void new_aggregated_packet(const unsigned char *packet_buff,
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
 	forw_packet_aggr->num_packets = 0;
-	forw_packet_aggr->direct_link_flags = 0;
+	forw_packet_aggr->direct_link_flags = NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
 
 	/* save packet direct link flag status */
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index cf7f95e..24aee56 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -322,7 +322,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 
 		gw_node->deleted = 0;
 
-		if (new_gwflags == 0) {
+		if (new_gwflags == NO_FLAGS) {
 			gw_node->deleted = jiffies;
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Gateway %pM removed from gateway list\n",
@@ -335,7 +335,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 		goto unlock;
 	}
 
-	if (new_gwflags == 0)
+	if (new_gwflags == NO_FLAGS)
 		goto unlock;
 
 	gw_node_add(bat_priv, orig_node, new_gwflags);
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a3fbfb5..b55e861 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -337,7 +337,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	batman_packet = (struct batman_packet *)(hard_iface->packet_buff);
 	batman_packet->packet_type = BAT_PACKET;
 	batman_packet->version = COMPAT_VERSION;
-	batman_packet->flags = 0;
+	batman_packet->flags = NO_FLAGS;
 	batman_packet->ttl = 2;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_tt = 0;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 27ad734..ed488cb 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -51,6 +51,8 @@
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
 #define TQ_TOTAL_BIDRECT_LIMIT 1
 
+#define NO_FLAGS 0
+
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d0cfa95..a1b8c31 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -289,7 +289,7 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 		batman_packet->gw_flags =
 				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
 	else
-		batman_packet->gw_flags = 0;
+		batman_packet->gw_flags = NO_FLAGS;
 
 	atomic_inc(&hard_iface->seqno);
 
-- 
1.7.5.3

