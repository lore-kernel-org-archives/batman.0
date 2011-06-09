Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  9 Jun 2011 17:13:09 +0200
Message-Id: <1307632389-31676-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use NO_FLAGS define instead of
	hard-coding 0
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

The definition NO_FLAGS was introduced to make the code more
readable and shall be used to initialize flag fields.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 aggregation.c    |    2 +-
 gateway_client.c |    4 ++--
 hard-interface.c |    2 +-
 send.c           |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index ef26011..ede0a56 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -146,7 +146,7 @@ static void new_aggregated_packet(const unsigned char *packet_buff,
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
 	forw_packet_aggr->num_packets = 0;
-	forw_packet_aggr->direct_link_flags = 0;
+	forw_packet_aggr->direct_link_flags = NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
 
 	/* save packet direct link flag status */
diff --git a/gateway_client.c b/gateway_client.c
index cf7f95e..24aee56 100644
--- a/gateway_client.c
+++ b/gateway_client.c
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
diff --git a/hard-interface.c b/hard-interface.c
index cf972c3..db7aacf 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -331,7 +331,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	batman_packet = (struct batman_packet *)(hard_iface->packet_buff);
 	batman_packet->packet_type = BAT_PACKET;
 	batman_packet->version = COMPAT_VERSION;
-	batman_packet->flags = 0;
+	batman_packet->flags = NO_FLAGS;
 	batman_packet->ttl = 2;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->tt_num_changes = 0;
diff --git a/send.c b/send.c
index 0c5d671..a150c7c 100644
--- a/send.c
+++ b/send.c
@@ -334,7 +334,7 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 		batman_packet->gw_flags =
 				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
 	else
-		batman_packet->gw_flags = 0;
+		batman_packet->gw_flags = NO_FLAGS;
 
 	atomic_inc(&hard_iface->seqno);
 
-- 
1.7.5.3

