Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue,  9 Nov 2010 00:53:01 +0100
Message-Id: <1289260381-6415-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1289260381-6415-1-git-send-email-sven.eckelmann@gmx.de>
References: <1289260381-6415-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use kernel functions to
	identify broadcasts
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

linux/etherdevice.h already provides functions to classify different
ethernet addresses. These inlineable functions should be used instead of
custom functions.

The check for multicast can also be removed because
is_multicast_ether_addr was only used together with
is_broadcast_ether_addr and for every ethernet address x following is
always true:

is_broadcast_ether_addr(x) => is_multicast_ether_addr(x)

or when looking more at the implementation:

(FF:FF:FF:FF:FF:FF == x) => [(01:00:00:00:00:00 & x) != 00:00:00:00:00:00]

Reported-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/main.c           |   10 ----------
 batman-adv/main.h           |    3 +--
 batman-adv/routing.c        |   16 ++++++++--------
 batman-adv/soft-interface.c |    2 +-
 batman-adv/unicast.c        |    2 +-
 batman-adv/vis.c            |    4 ++--
 6 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/batman-adv/main.c b/batman-adv/main.c
index c91e635..b827f6a 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -172,16 +172,6 @@ int is_my_mac(uint8_t *addr)
 
 }
 
-int is_bcast(uint8_t *addr)
-{
-	return (addr[0] == (uint8_t)0xff) && (addr[1] == (uint8_t)0xff);
-}
-
-int is_mcast(uint8_t *addr)
-{
-	return *addr & 0x01;
-}
-
 module_init(batman_init);
 module_exit(batman_exit);
 
diff --git a/batman-adv/main.h b/batman-adv/main.h
index 519d3b0..a362433 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -112,6 +112,7 @@
 #include <linux/mutex.h>	/* mutex */
 #include <linux/module.h>	/* needed by all modules */
 #include <linux/netdevice.h>	/* netdevice */
+#include <linux/etherdevice.h>  /* ethernet address classifaction */
 #include <linux/if_ether.h>	/* ethernet header */
 #include <linux/poll.h>		/* poll_table */
 #include <linux/kthread.h>	/* kernel threads */
@@ -141,8 +142,6 @@ void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
 int is_my_mac(uint8_t *addr);
-int is_bcast(uint8_t *addr);
-int is_mcast(uint8_t *addr);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 9f31167..d8b0c5a 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -770,11 +770,11 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with broadcast indication but unicast recipient */
-	if (!is_bcast(ethhdr->h_dest))
+	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		return NET_RX_DROP;
 
 	/* packet with broadcast sender address */
-	if (is_bcast(ethhdr->h_source))
+	if (is_broadcast_ether_addr(ethhdr->h_source))
 		return NET_RX_DROP;
 
 	/* create a copy of the skb, if needed, to modify it. */
@@ -946,11 +946,11 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
-	if (is_bcast(ethhdr->h_dest))
+	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		return NET_RX_DROP;
 
 	/* packet with broadcast sender address */
-	if (is_bcast(ethhdr->h_source))
+	if (is_broadcast_ether_addr(ethhdr->h_source))
 		return NET_RX_DROP;
 
 	/* not for me */
@@ -1118,11 +1118,11 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
-	if (is_bcast(ethhdr->h_dest))
+	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		return -1;
 
 	/* packet with broadcast sender address */
-	if (is_bcast(ethhdr->h_source))
+	if (is_broadcast_ether_addr(ethhdr->h_source))
 		return -1;
 
 	/* not for me */
@@ -1282,11 +1282,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with broadcast indication but unicast recipient */
-	if (!is_bcast(ethhdr->h_dest))
+	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		return NET_RX_DROP;
 
 	/* packet with broadcast sender address */
-	if (is_bcast(ethhdr->h_source))
+	if (is_broadcast_ether_addr(ethhdr->h_source))
 		return NET_RX_DROP;
 
 	/* ignore broadcasts sent by myself */
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 1e55bdb..405d96e 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -378,7 +378,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* TODO: check this for locks */
 	hna_local_add(soft_iface, ethhdr->h_source);
 
-	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
+	if (is_broadcast_ether_addr(ethhdr->h_dest)) {
 		ret = gw_is_target(bat_priv, skb);
 
 		if (ret < 0)
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 7b9385b..15d676f 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -283,7 +283,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* get routing information */
-	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
+	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
 	else
 		orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 65676dc..957a086 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -472,7 +472,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	int are_target = 0;
 
 	/* clients shall not broadcast. */
-	if (is_bcast(vis_packet->target_orig))
+	if (is_broadcast_ether_addr(vis_packet->target_orig))
 		return;
 
 	/* Are we the target for this VIS packet? */
@@ -755,7 +755,7 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 	       ETH_ALEN);
 	packet->ttl--;
 
-	if (is_bcast(packet->target_orig))
+	if (is_broadcast_ether_addr(packet->target_orig))
 		broadcast_vis_packet(bat_priv, info);
 	else
 		unicast_vis_packet(bat_priv, info);
-- 
1.7.2.3

