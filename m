Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:38 +0100
Message-Id: <1296337660-12376-12-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/13] batman-adv: Remove unused variables
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_debugfs.c |    4 +---
 net/batman-adv/routing.c     |    7 -------
 2 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/bat_debugfs.c b/net/batman-adv/bat_debugfs.c
index 0ae81d0..d36d305 100644
--- a/net/batman-adv/bat_debugfs.c
+++ b/net/batman-adv/bat_debugfs.c
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
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index e946dc9..3b7e2f7 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -807,13 +807,11 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 {
 	struct orig_node *orig_node;
 	struct icmp_packet_rr *icmp_packet;
-	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
 	int ret;
 	uint8_t dstaddr[ETH_ALEN];
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
@@ -845,7 +843,6 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 			return NET_RX_DROP;
 
 		icmp_packet = (struct icmp_packet_rr *)skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 		memcpy(icmp_packet->orig,
@@ -867,13 +864,11 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 {
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
-	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
 	int ret;
 	uint8_t dstaddr[ETH_ALEN];
 
 	icmp_packet = (struct icmp_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
@@ -906,7 +901,6 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 			return NET_RX_DROP;
 
 		icmp_packet = (struct icmp_packet *) skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 		memcpy(icmp_packet->orig,
@@ -998,7 +992,6 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 			return NET_RX_DROP;
 
 		icmp_packet = (struct icmp_packet_rr *)skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 		/* decrement ttl */
 		icmp_packet->ttl--;
-- 
1.7.2.3

