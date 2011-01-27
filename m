Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 27 Jan 2011 15:34:13 +0100
Message-Id: <1296138853-17657-1-git-send-email-sven@narfation.org>
In-Reply-To: <1296136571-13226-5-git-send-email-sven@narfation.org>
References: <1296136571-13226-5-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: Remove unused variables
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Remove best_router_tq which is only in master, but not in next.

 batman-adv/bat_debugfs.c |    4 +---
 batman-adv/routing.c     |   10 ----------
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 0ae81d0..d36d305 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -52,7 +52,6 @@ static void emit_log_char(struct debug_log *debug_log, char c)
 
 static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
 {
-	int printed_len;
 	va_list args;
 	static char debug_log_buf[256];
 	char *p;
@@ -62,8 +61,7 @@ static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
 
 	spin_lock_bh(&debug_log->lock);
 	va_start(args, fmt);
-	printed_len = vscnprintf(debug_log_buf, sizeof(debug_log_buf),
-				 fmt, args);
+	vscnprintf(debug_log_buf, sizeof(debug_log_buf), fmt, args);
 	va_end(args);
 
 	for (p = debug_log_buf; *p != 0; p++)
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 6168648..480c178 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -866,11 +866,9 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	struct icmp_packet_rr *icmp_packet;
-	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
@@ -904,7 +902,6 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 		goto out;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 	memcpy(icmp_packet->orig,
@@ -932,11 +929,9 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	struct icmp_packet *icmp_packet;
-	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
 
 	icmp_packet = (struct icmp_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
@@ -971,7 +966,6 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		goto out;
 
 	icmp_packet = (struct icmp_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 	memcpy(icmp_packet->orig,
@@ -1068,7 +1062,6 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		goto out;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* decrement ttl */
 	icmp_packet->ttl--;
@@ -1100,7 +1093,6 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	struct neigh_node *router, *first_candidate, *tmp_neigh_node;
 	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 	int bonding_enabled;
-	int best_router_tq;
 
 	if (!orig_node)
 		return NULL;
@@ -1190,7 +1182,6 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		/* if bonding is disabled, use the best of the
 		 * remaining candidates which are not using
 		 * this interface. */
-		best_router_tq = 0;
 		list_for_each_entry_rcu(tmp_neigh_node,
 			&primary_orig_node->bond_list, bonding_list) {
 			if (!first_candidate)
@@ -1203,7 +1194,6 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 				if ((!router) ||
 				(tmp_neigh_node->tq_avg > router->tq_avg)) {
 					router = tmp_neigh_node;
-					best_router_tq = 0;
 				}
 		}
 
-- 
1.7.2.3

