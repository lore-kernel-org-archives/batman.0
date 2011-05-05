Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 May 2011 09:13:09 +0200
Message-Id: <1304579589-5222-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1304579589-5222-1-git-send-email-ordex@autistici.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: improved gateway tq-based
	selection
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

If a client issues a DHCPREQUEST for renewal, the packet is dropped
if the old destination (the old gateway for the client) TQ is smaller
than the current best gateway TQ less GW_THRESHOLD

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 gateway_client.c |   28 ++++++++++++++++++++++++++--
 gateway_client.h |    3 ++-
 main.h           |    3 ++-
 soft-interface.c |   10 ++++++++--
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 8a7090c..6b3b775 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -25,6 +25,7 @@
 #include "gateway_common.h"
 #include "hard-interface.h"
 #include "originator.h"
+#include "routing.h"
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
@@ -505,14 +506,17 @@ out:
 	return ret;
 }
 
-int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb,
+		 struct orig_node *old_gw)
 {
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
 	struct ipv6hdr *ipv6hdr;
 	struct udphdr *udphdr;
 	struct gw_node *curr_gw;
+	struct neigh_node *neigh_curr, *neigh_old;
 	unsigned int header_len = 0;
+	int ret = 1;
 
 	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_OFF)
 		return 0;
@@ -580,7 +584,27 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	if (!curr_gw)
 		return 0;
 
+	/* If old_gw != NULL then this packet is unicast.
+	 * So, at this point it can only be a renewal packet (because it is the
+	 * only dhcp client message sent as unicast) and we have to decide
+	 * whether to drop it or not */
+	if (old_gw && curr_gw->orig_node != old_gw) {
+		/* If the dhcp packet has been sent to a different gw, we have
+		 * to evaluate whether the old gw is still enough reliable */
+		neigh_curr = find_router(bat_priv, curr_gw->orig_node, NULL);
+		neigh_old = find_router(bat_priv, old_gw, NULL);
+		if (!neigh_curr || !neigh_old)
+			goto free_neigh;
+		if (neigh_curr->tq_avg - neigh_old->tq_avg < GW_THRESHOLD)
+			ret = -1;
+free_neigh:
+		if (neigh_old)
+			neigh_node_free_ref(neigh_old);
+		if (neigh_curr)
+			neigh_node_free_ref(neigh_curr);
+	}
+
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
-	return 1;
+	return ret;
 }
diff --git a/gateway_client.h b/gateway_client.h
index 1ce8c60..b9b983c 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -31,6 +31,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_purge(struct bat_priv *bat_priv);
 int gw_client_seq_print_text(struct seq_file *seq, void *offset);
-int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb,
+		 struct orig_node *old_gw);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/main.h b/main.h
index 0dfb46e..b59bfad 100644
--- a/main.h
+++ b/main.h
@@ -78,7 +78,6 @@
 #define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
 
-
 enum uev_action {
 	UEV_ADD = 0,
 	UEV_DEL,
@@ -89,6 +88,8 @@ enum uev_type {
 	UEV_GW = 0
 };
 
+#define GW_THRESHOLD	25
+
 /*
  * Debug Messages
  */
diff --git a/soft-interface.c b/soft-interface.c
index 8023c4e..79d4012 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -30,6 +30,7 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "bat_sysfs.h"
+#include "originator.h"
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
@@ -569,6 +570,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
 	struct softif_neigh *curr_softif_neigh = NULL;
+	struct orig_node *orig_node;
 	int data_len = skb->len, ret;
 	short vid = -1;
 	bool do_bcast = false;
@@ -603,8 +605,10 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* TODO: check this for locks */
 	hna_local_add(soft_iface, ethhdr->h_source);
 
-	if (is_multicast_ether_addr(ethhdr->h_dest)) {
-		ret = gw_is_target(bat_priv, skb);
+	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+	if (is_multicast_ether_addr(ethhdr->h_dest) ||
+				(orig_node && orig_node->gw_flags)) {
+		ret = gw_is_target(bat_priv, skb, orig_node);
 
 		if (ret < 0)
 			goto dropped;
@@ -612,6 +616,8 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (ret == 0)
 			do_bcast = true;
 	}
+	if (orig_node)
+		orig_node_free_ref(orig_node);
 
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
-- 
1.7.3.4

