Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  9 May 2011 23:15:58 +0200
Message-Id: <1304975758-9412-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1304579589-5222-1-git-send-email-ordex@autistici.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 3/3] batman-adv: improved gateway tq-based
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
Removed a useless decrement in is_type_dhcprequest()

 gateway_client.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 gateway_client.h |    3 +-
 main.h           |    3 +-
 soft-interface.c |   10 ++++-
 4 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 761dcfb..3b43781 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -25,11 +25,17 @@
 #include "gateway_common.h"
 #include "hard-interface.h"
 #include "originator.h"
+#include "routing.h"
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
+/* This is the offset of the options field in a dhcp packet starting at
+ * the beginning of the dhcp header */
+#define DHCP_OPTIONS_OFFSET 240
+#define DHCP_REQUEST 3
+
 static void gw_node_free_rcu(struct rcu_head *rcu)
 {
 	struct gw_node *gw_node;
@@ -509,14 +515,75 @@ out:
 	return ret;
 }
 
-int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
+static bool is_type_dhcprequest(struct sk_buff *skb, int header_len)
+{
+	int ret = false;
+	unsigned char *p;
+	int pkt_len;
+
+	if (skb_linearize(skb) < 0)
+		goto out;
+
+	pkt_len = skb_headlen(skb);
+
+	if (pkt_len < header_len + DHCP_OPTIONS_OFFSET + 1)
+		goto out;
+
+	p = skb->data + header_len + DHCP_OPTIONS_OFFSET;
+	pkt_len -= header_len + DHCP_OPTIONS_OFFSET + 1;
+
+	/* Access the dhcp option lists. Each entry is made up by:
+	 * - octect 1: option type
+	 * - octect 2: option data len (only if type != 255 and 0)
+	 * - octect 3: option data */
+	while (*p != 255 && !ret) {
+		/* p now points to the first octect: option type */
+		if (*p == 53) {
+			/* type 53 is the message type option.
+			 * Jump the len octect and go to the data octect */
+			if (pkt_len < 2)
+				goto out;
+			p += 2;
+
+			/* check if the message type is what we need */
+			if (*p == DHCP_REQUEST)
+				ret = true;
+			break;
+		} else if (*p == 0) {
+			/* option type 0 (padding), just go forward */
+			if (pkt_len < 1)
+				goto out;
+			pkt_len--;
+			p++;
+		} else {
+			/* This is any other option. So we get the length... */
+			if (pkt_len < 1)
+				goto out;
+			pkt_len--;
+			p++;
+
+			/* ...and then we jump over the data */
+			if (pkt_len < *p)
+				goto out;
+			pkt_len -= *p;
+			p += (*p);
+		}
+	}
+out:
+	return ret;
+}
+
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb,
+		 struct orig_node *old_gw)
 {
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
 	struct ipv6hdr *ipv6hdr;
 	struct udphdr *udphdr;
 	struct gw_node *curr_gw;
+	struct neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	unsigned int header_len = 0;
+	int ret = 1;
 
 	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_OFF)
 		return 0;
@@ -584,7 +651,30 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	if (!curr_gw)
 		return 0;
 
+	/* If old_gw != NULL then this packet is unicast.
+	 * So, at this point we have to check the message type: if it is a
+	 * DHCPREQUEST we have to decide whether to drop it or not */
+	if (old_gw && curr_gw->orig_node != old_gw) {
+		if (is_type_dhcprequest(skb, header_len)) {
+			/* If the dhcp packet has been sent to a different gw,
+			 * we have to evaluate whether the old gw is still
+			 * reliable enough */
+			neigh_curr = find_router(bat_priv, curr_gw->orig_node,
+						 NULL);
+			neigh_old = find_router(bat_priv, old_gw, NULL);
+			if (!neigh_curr || !neigh_old)
+				goto free_neigh;
+			if (neigh_curr->tq_avg - neigh_old->tq_avg <
+								GW_THRESHOLD)
+				ret = -1;
+		}
+	}
+free_neigh:
+	if (neigh_old)
+		neigh_node_free_ref(neigh_old);
+	if (neigh_curr)
+		neigh_node_free_ref(neigh_curr);
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
index 4f9991d..5b7ad0a 100644
--- a/main.h
+++ b/main.h
@@ -79,7 +79,6 @@
 #define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
 
-
 enum uev_action {
 	UEV_ADD = 0,
 	UEV_DEL,
@@ -90,6 +89,8 @@ enum uev_type {
 	UEV_GW = 0
 };
 
+#define GW_THRESHOLD	50
+
 /*
  * Debug Messages
  */
diff --git a/soft-interface.c b/soft-interface.c
index c76a33e..6d02d92 100644
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
 	tt_local_add(soft_iface, ethhdr->h_source);
 
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

