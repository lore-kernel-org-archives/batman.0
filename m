Return-Path: <tklauser@distanz.ch>
From: Tobias Klauser <tklauser@distanz.ch>
Date: Wed,  3 Nov 2010 10:59:02 +0100
Message-Id: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
Subject: [B.A.T.M.A.N.] [PATCH] staging: batman-adv: Use linux/etherdevice.h
	address helper functions
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
To: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Replace custom ethernet address check functions by calls to the helpers
in linux/etherdevice.h

In one case where the address was tested for broadcast and multicast
address, the broadcast address check can be omitted as broadcast is also
a multicast address.

The patch is only compile-tested.

Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/staging/batman-adv/main.c           |   12 +-----------
 drivers/staging/batman-adv/main.h           |    3 +--
 drivers/staging/batman-adv/routing.c        |   16 ++++++++--------
 drivers/staging/batman-adv/soft-interface.c |    2 +-
 drivers/staging/batman-adv/vis.c            |    4 ++--
 5 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 0587940..6ea6420 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -149,7 +149,7 @@ void dec_module_count(void)
 
 int compare_orig(void *data1, void *data2)
 {
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+	return (compare_ether_addr(data1, data2) == 0 ? 1 : 0);
 }
 
 /* hashfunction to choose an entry in a hash table of given size */
@@ -192,16 +192,6 @@ int is_my_mac(uint8_t *addr)
 
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
 
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 5e3f516..14d567d 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -109,6 +109,7 @@
 #include <linux/mutex.h>	/* mutex */
 #include <linux/module.h>	/* needed by all modules */
 #include <linux/netdevice.h>	/* netdevice */
+#include <linux/etherdevice.h>
 #include <linux/if_ether.h>	/* ethernet header */
 #include <linux/poll.h>		/* poll_table */
 #include <linux/kthread.h>	/* kernel threads */
@@ -138,8 +139,6 @@ void dec_module_count(void);
 int compare_orig(void *data1, void *data2);
 int choose_orig(void *data, int32_t size);
 int is_my_mac(uint8_t *addr);
-int is_bcast(uint8_t *addr);
-int is_mcast(uint8_t *addr);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 9010263..d42c165 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -756,11 +756,11 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
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
@@ -933,11 +933,11 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
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
@@ -1107,11 +1107,11 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
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
@@ -1283,11 +1283,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
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
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 3904db9..820e141 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -140,7 +140,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	hna_local_add(soft_iface, ethhdr->h_source);
 
 	/* ethernet packet should be broadcasted */
-	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
+	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		if (!bat_priv->primary_if)
 			goto dropped;
 
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 3d2c1bc..c98a065 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -470,7 +470,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	int are_target = 0;
 
 	/* clients shall not broadcast. */
-	if (is_bcast(vis_packet->target_orig))
+	if (is_broadcast_ether_addr(vis_packet->target_orig))
 		return;
 
 	/* Are we the target for this VIS packet? */
@@ -747,7 +747,7 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 	       ETH_ALEN);
 	packet->ttl--;
 
-	if (is_bcast(packet->target_orig))
+	if (is_broadcast_ether_addr(packet->target_orig))
 		broadcast_vis_packet(bat_priv, info);
 	else
 		unicast_vis_packet(bat_priv, info);
-- 
1.7.0.4

