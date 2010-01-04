Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  4 Jan 2010 23:46:16 +0800
Message-Id: <1262619976-5632-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1262619976-5632-2-git-send-email-lindner_marek@yahoo.de>
References: <201001042344.02273.lindner_marek@yahoo.de>
	<1262619976-5632-1-git-send-email-lindner_marek@yahoo.de>
	<1262619976-5632-2-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: send DHCP requests directly
	to the chosen gw
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

If the gateway client mode is active batman-adv will send the broadcasted
DHCP requests via unicast to the currently selected best gateway. Therefore
attached clients can profit from batman's knowledge about the network
topology.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/gateway_client.c |   45 ++++++++++++++++++++++++++++++++
 batman-adv-kernelland/gateway_client.h |    2 +
 batman-adv-kernelland/soft-interface.c |   17 ++++++++++--
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index 55789ad..434af2b 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -20,6 +20,8 @@
 #include "main.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
+#include <linux/ip.h>
+#include <linux/udp.h>
 
 LIST_HEAD(gw_list);
 DEFINE_SPINLOCK(curr_gw_lock);
@@ -27,6 +29,20 @@ DEFINE_SPINLOCK(gw_list_lock);
 atomic_t gw_clnt_class;
 static struct gw_node *curr_gateway;
 
+void *gw_get_selected(void)
+{
+	struct gw_node *curr_gateway_tmp = NULL;
+
+	spin_lock(&curr_gw_lock);
+	curr_gateway_tmp = curr_gateway;
+	spin_unlock(&curr_gw_lock);
+
+	if (!curr_gateway_tmp)
+		return NULL;
+
+	return curr_gateway_tmp->orig_node;
+}
+
 void gw_deselect(void)
 {
 	spin_lock(&curr_gw_lock);
@@ -333,3 +349,32 @@ int gw_client_fill_buffer_text(unsigned char *buff, int buff_len)
 
 	return bytes_written;
 }
+
+bool gw_is_target(struct sk_buff *skb)
+{
+	struct ethhdr *ethhdr;
+	struct iphdr *iphdr;
+	struct udphdr *udphdr;
+
+	if (atomic_read(&gw_mode) != GW_MODE_CLIENT)
+		return false;
+
+	if (!curr_gateway)
+		return false;
+
+	ethhdr = (struct ethhdr *)skb->data;
+	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
+		return false;
+
+	iphdr = (struct iphdr *)(skb->data + ETH_HLEN);
+
+	if (iphdr->protocol != IPPROTO_UDP)
+		return false;
+
+	udphdr = (struct udphdr *)(skb->data + ETH_HLEN + (iphdr->ihl * 4));
+
+	if (ntohs(udphdr->dest) != 67)
+		return false;
+
+	return true;
+}
diff --git a/batman-adv-kernelland/gateway_client.h b/batman-adv-kernelland/gateway_client.h
index 5eb1e4c..fc7a0df 100644
--- a/batman-adv-kernelland/gateway_client.h
+++ b/batman-adv-kernelland/gateway_client.h
@@ -21,9 +21,11 @@ extern atomic_t gw_clnt_class;
 
 void gw_deselect(void);
 void gw_election(void);
+void *gw_get_selected(void);
 void gw_check_election(struct orig_node *orig_node);
 void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags);
 void gw_node_delete(struct orig_node *orig_node);
 void gw_node_purge_deleted(void);
 void gw_node_list_free(void);
 int gw_client_fill_buffer_text(unsigned char *buff, int buff_len);
+bool gw_is_target(struct sk_buff *skb);
diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index ee9aa39..80f7a23 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -26,6 +26,7 @@
 #include "translation-table.h"
 #include "types.h"
 #include "hash.h"
+#include "gateway_client.h"
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include "compat.h"
@@ -181,6 +182,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	uint8_t dstaddr[6];
 	int data_len = skb->len;
 	unsigned long flags;
+	bool bcast_dst = false, do_bcast = true;
 
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dropped;
@@ -189,9 +191,14 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	/* TODO: check this for locks */
 	hna_local_add(ethhdr->h_source);
 
-	/* ethernet packet should be broadcasted */
-	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
+	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
+		bcast_dst = true;
+
+	if ((bcast_dst) && gw_is_target(skb))
+		do_bcast = false;
 
+	/* ethernet packet should be broadcasted */
+	if (bcast_dst && do_bcast) {
 		if (my_skb_push(skb, sizeof(struct bcast_packet)) < 0)
 			goto dropped;
 
@@ -219,8 +226,12 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	/* unicast packet */
 	} else {
 		spin_lock_irqsave(&orig_hash_lock, flags);
+
 		/* get routing information */
-		orig_node = ((struct orig_node *)hash_find(orig_hash,
+		if (bcast_dst)
+			orig_node = (struct orig_node *)gw_get_selected();
+		else
+			orig_node = ((struct orig_node *)hash_find(orig_hash,
 							   ethhdr->h_dest));
 
 		/* check for hna host */
-- 
1.6.5.7

