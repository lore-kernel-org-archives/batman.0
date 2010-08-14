Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:08:02 +0200
Message-Id: <1281820085-13507-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Don't inform about dropped
	packets in nodebug
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

Information about dropped packets are usually only interesting for
debugging purposes and otherwise open the possibility to flood the logs
of the target machine with useless information.

pr_debug will not output those information on a nodebug kernel.

Reported-by: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/compat.h  |    8 ++++++++
 batman-adv/routing.c |   15 +++++++--------
 batman-adv/vis.c     |    2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 617d23c..d59d709 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -90,6 +90,14 @@ static inline int skb_cow_head(struct sk_buff *skb, unsigned int headroom)
 #define pr_warning(fmt, ...) \
        printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
 
+#if defined(DEBUG)
+#define pr_debug(fmt, ...) \
+	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#else
+#define pr_debug(fmt, ...) \
+	({ if (0) printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); 0; })
+#endif
+
 #define dev_get_by_name(x, y) dev_get_by_name(y)
 
 #endif /* < KERNEL_VERSION(2, 6, 24) */
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 454a84c..a2c64a4 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -871,9 +871,9 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		pr_warning("Warning - can't forward icmp packet from %pM to "
-			   "%pM: ttl exceeded\n", icmp_packet->orig,
-			   icmp_packet->dst);
+		pr_debug("Warning - can't forward icmp packet from %pM to "
+			 "%pM: ttl exceeded\n", icmp_packet->orig,
+			 icmp_packet->dst);
 		return NET_RX_DROP;
 	}
 
@@ -1153,9 +1153,9 @@ static int route_unicast_packet(struct sk_buff *skb,
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		pr_warning("Warning - can't forward unicast packet from %pM to "
-			   "%pM: ttl exceeded\n", ethhdr->h_source,
-			   unicast_packet->dest);
+		pr_debug("Warning - can't forward unicast packet from %pM to "
+			 "%pM: ttl exceeded\n", ethhdr->h_source,
+			 unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
@@ -1236,8 +1236,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 			hash_find(bat_priv->orig_hash, unicast_packet->orig));
 
 		if (!orig_node) {
-			pr_warning("couldn't find orig node for "
-				"fragmentation\n");
+			pr_debug("couldn't find orig node for fragmentation\n");
 			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
 					       flags);
 			return NET_RX_DROP;
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index ac3779b..6de5c76 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -746,7 +746,7 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 
 	packet = (struct vis_packet *)info->skb_packet->data;
 	if (packet->ttl < 2) {
-		pr_warning("Error - can't send vis packet: ttl exceeded\n");
+		pr_debug("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
-- 
1.7.1

