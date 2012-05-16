Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 May 2012 20:23:21 +0200
Message-Id: <1337192605-8652-9-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-1-git-send-email-sven@narfation.org>
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/13] batman-adv: Replace simple function
	like defines with functions
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
 bat_debugfs.c           |    5 +---
 distributed-arp-table.c |   76 +++++++++++++++++++++++++++++++++--------------
 distributed-arp-table.h |    8 -----
 main.h                  |   37 +++++++++++++++--------
 4 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 004d94f..b4d622b 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -74,16 +74,13 @@ static int batadv_fdebug_log(struct debug_log *debug_log, const char *fmt, ...)
 	return 0;
 }
 
-int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, va_list args)
 {
-	va_list args;
 	char tmp_log_buf[256];
 
-	va_start(args, fmt);
 	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
 	batadv_fdebug_log(bat_priv->debug_log, "[%10u] %s",
 			  jiffies_to_msecs(jiffies), tmp_log_buf);
-	va_end(args);
 
 	return 0;
 }
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index d03f441..c9d1322 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -32,6 +32,31 @@
 #include "translation-table.h"
 #include "unicast.h"
 
+static uint8_t *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
+{
+	uint8_t *addr;
+
+	addr = (uint8_t *)(skb->data + hdr_size);
+	addr += ETH_HLEN + sizeof(struct arphdr);
+
+	return addr;
+}
+
+static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
+{
+	return *(__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
+}
+
+static uint8_t *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
+{
+	return batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN + 4;
+}
+
+static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
+{
+	return *(__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4);
+}
+
 /* hash function to choose an entry in a hash table of given size.
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
  */
@@ -60,14 +85,19 @@ static void batadv_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
 			   uint16_t type, int hdr_size, char *msg)
 {
 	struct unicast_4addr_packet *unicast_4addr_packet;
+	__be32 src_ip, dst_ip;
 
 	if (msg)
 		batadv_dbg(DBG_DAT, bat_priv, "%s\n", msg);
 
+	src_ip = batadv_arp_ip_src(skb, hdr_size);
+	dst_ip = batadv_arp_ip_dst(skb, hdr_size);
 	batadv_dbg(DBG_DAT, bat_priv,
 		   "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
-		   ARP_HW_SRC(skb, hdr_size), &ARP_IP_SRC(skb, hdr_size),
-		   ARP_HW_DST(skb, hdr_size), &ARP_IP_DST(skb, hdr_size));
+		   batadv_arp_hw_src(skb, hdr_size),
+		   &src_ip,
+		   batadv_arp_hw_dst(skb, hdr_size),
+		   &dst_ip);
 
 	if (hdr_size == 0)
 		return;
@@ -383,8 +413,8 @@ static uint16_t batadv_arp_get_type(struct bat_priv *bat_priv,
 	/* Check for bad reply/request. If the ARP message is not sane, DAT
 	 * will simply ignore it
 	 */
-	ip_src = ARP_IP_SRC(skb, hdr_size);
-	ip_dst = ARP_IP_DST(skb, hdr_size);
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
 	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst))
 		goto out;
@@ -418,9 +448,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 
 	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
 
-	ip_src = ARP_IP_SRC(skb, 0);
-	hw_src = ARP_HW_SRC(skb, 0);
-	ip_dst = ARP_IP_DST(skb, 0);
+	ip_src = batadv_arp_ip_src(skb, 0);
+	hw_src = batadv_arp_hw_src(skb, 0);
+	ip_dst = batadv_arp_ip_dst(skb, 0);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -480,9 +510,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 	if (type != ARPOP_REQUEST)
 		goto out;
 
-	hw_src = ARP_HW_SRC(skb, hdr_size);
-	ip_src = ARP_IP_SRC(skb, hdr_size);
-	ip_dst = ARP_IP_DST(skb, hdr_size);
+	hw_src = batadv_arp_hw_src(skb, hdr_size);
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");
@@ -538,10 +568,10 @@ bool batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 
 	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
 
-	hw_src = ARP_HW_SRC(skb, 0);
-	ip_src = ARP_IP_SRC(skb, 0);
-	hw_dst = ARP_HW_DST(skb, 0);
-	ip_dst = ARP_IP_DST(skb, 0);
+	hw_src = batadv_arp_hw_src(skb, 0);
+	ip_src = batadv_arp_ip_src(skb, 0);
+	hw_dst = batadv_arp_hw_dst(skb, 0);
+	ip_dst = batadv_arp_ip_dst(skb, 0);
 
 	batadv_arp_neigh_update(bat_priv, ip_src, hw_src);
 	batadv_arp_neigh_update(bat_priv, ip_dst, hw_dst);
@@ -576,10 +606,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REPLY");
 
-	hw_src = ARP_HW_SRC(skb, hdr_size);
-	ip_src = ARP_IP_SRC(skb, hdr_size);
-	hw_dst = ARP_HW_DST(skb, hdr_size);
-	ip_dst = ARP_IP_DST(skb, hdr_size);
+	hw_src = batadv_arp_hw_src(skb, hdr_size);
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
 	/* Update our internal cache with both the IP addresses we fetched from
 	 * the ARP reply
@@ -603,6 +633,7 @@ bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	struct neighbour *n = NULL;
 	uint16_t type;
 	bool ret = false;
+	__be32 ip_dst;
 
 	/* If this packet is an ARP_REQUEST and we already have the information
 	 * that it is going to ask, we can drop the packet
@@ -614,20 +645,19 @@ bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	if (type != ARPOP_REQUEST)
 		goto out;
 
-	n = neigh_lookup(&arp_tbl, &ARP_IP_DST(forw_packet->skb, bcast_len),
+	ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
+	n = neigh_lookup(&arp_tbl, &ip_dst,
 			 forw_packet->if_incoming->soft_iface);
 
 	/* check if we already know this neigh */
 	if (!n || !(n->nud_state & NUD_CONNECTED)) {
 		batadv_dbg(DBG_DAT, bat_priv,
-			   "ARP Request for %pI4: fallback\n",
-			   &ARP_IP_DST(forw_packet->skb, bcast_len));
+			   "ARP Request for %pI4: fallback\n", &ip_dst);
 		goto out;
 	}
 
 	batadv_dbg(DBG_DAT, bat_priv,
-		   "ARP Request for %pI4: fallback prevented\n",
-		   &ARP_IP_DST(forw_packet->skb, bcast_len));
+		   "ARP Request for %pI4: fallback prevented\n", &ip_dst);
 	ret = true;
 
 out:
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 6b1d22c..47fe32f 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -29,14 +29,6 @@
 
 #define DAT_ADDR_MAX ((dat_addr_t)~(dat_addr_t)0)
 
-#define ARP_HW_SRC(skb, hdr_size) ((uint8_t *)(skb->data + hdr_size) + \
-				   ETH_HLEN + sizeof(struct arphdr))
-#define ARP_IP_SRC(skb, hdr_size) (*(__be32 *)(ARP_HW_SRC(skb, hdr_size) + \
-				   ETH_ALEN))
-#define ARP_HW_DST(skb, hdr_size) (ARP_HW_SRC(skb, hdr_size) + ETH_ALEN + 4)
-#define ARP_IP_DST(skb, hdr_size) (*(__be32 *)(ARP_HW_SRC(skb, hdr_size) + \
-				   ETH_ALEN * 2 + 4))
-
 bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 					   struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
diff --git a/main.h b/main.h
index 245323b..ea5d7d5 100644
--- a/main.h
+++ b/main.h
@@ -187,24 +187,37 @@ int batadv_algo_select(struct bat_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
-__printf(2, 3);
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, va_list args);
+
+static inline void batadv_vdbg(int type, struct bat_priv *bat_priv,
+			       const char *fmt, va_list args)
+{
+	if (atomic_read(&bat_priv->log_level) & type)
+			batadv_debug_log(bat_priv, fmt, args);
+}
 
-#define batadv_dbg(type, bat_priv, fmt, arg...)			\
-	do {							\
-		if (atomic_read(&bat_priv->log_level) & type)	\
-			batadv_debug_log(bat_priv, fmt, ## arg);\
-	}							\
-	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
-__printf(3, 4)
-static inline void batadv_dbg(int type __always_unused,
-			      struct bat_priv *bat_priv __always_unused,
-			      const char *fmt __always_unused, ...)
+
+static inline void batadv_vdbg(int type __always_unused,
+			       struct bat_priv *bat_priv __always_unused,
+			       const char *fmt __always_unused,
+			       va_list args __always_unused)
 {
 }
+
 #endif
 
+__printf(3, 4)
+static inline void batadv_dbg(int type, struct bat_priv *bat_priv,
+			       const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	batadv_vdbg(type, bat_priv, fmt, args);
+	va_end(args);
+}
+
 #define bat_info(net_dev, fmt, arg...)					\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
-- 
1.7.10

