Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 17 Apr 2012 12:24:53 +0200
Message-Id: <1334658294-2413-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334658294-2413-1-git-send-email-ordex@autistici.org>
References: <1334658294-2413-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: introduce a boolean switch
	to enable/disable DAT
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

This patch introduces a boolean switch which enables D.A.T. (Distributed ARP
Table) to be activated/deactivated at run-time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_sysfs.c             |    7 +++++
 distributed-arp-table.c |   72 +++++++++++++++++++++++++++++++++++------------
 distributed-arp-table.h |    3 +-
 soft-interface.c        |    3 +-
 types.h                 |    1 +
 5 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index d0f8453..9415f9f 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -21,6 +21,7 @@
 
 #include "main.h"
 #include "bat_sysfs.h"
+#include "distributed-arp-table.h"
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
@@ -433,6 +434,9 @@ BAT_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
 BAT_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
+BAT_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR, dat_sysfs_change);
+#endif
 BAT_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 BAT_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
@@ -454,6 +458,9 @@ static struct bat_attribute *mesh_attrs[] = {
 #ifdef CONFIG_BATMAN_ADV_BLA
 	&bat_attr_bridge_loop_avoidance,
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
+	&bat_attr_distributed_arp_table,
+#endif
 	&bat_attr_fragmentation,
 	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 5386af0..eb94e43 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -345,6 +345,45 @@ out:
 	return type;
 }
 
+static void arp_change_timeout(struct net_device *soft_iface, bool enable_dat)
+{
+	struct in_device *in_dev = in_dev_get(soft_iface);
+	if (!in_dev) {
+		pr_err("Unable to set ARP parameters for the batman interface '%s'\n",
+		       soft_iface->name);
+		return;
+	}
+
+	if (enable_dat) {
+		/* Introduce a delay in the ARP state-machine transactions.
+		 * Entries will be kept in the ARP table for the default time
+		 * multiplied by 4
+		 */
+		in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
+		in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
+		in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
+	} else {
+		in_dev->arp_parms->base_reachable_time /= ARP_TIMEOUT_FACTOR;
+		in_dev->arp_parms->gc_staletime /= ARP_TIMEOUT_FACTOR;
+		in_dev->arp_parms->reachable_time /= ARP_TIMEOUT_FACTOR;
+	}
+
+	in_dev_put(in_dev);
+}
+
+void dat_sysfs_change(struct net_device *soft_iface)
+{
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+
+	if (!bat_priv)
+		return;
+
+	/* increase or decrease the ARP timeout */
+	arp_change_timeout(soft_iface,
+			   atomic_read(&bat_priv->distributed_arp_table));
+}
+
+
 /* return true if the message has been sent to the dht candidates, false
  * otherwise. In case of true the message has to be enqueued to permit the
  * fallback */
@@ -359,6 +398,9 @@ bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 	struct hard_iface *primary_if = NULL;
 	struct sk_buff *skb_new;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return false;
+
 	type = arp_get_type(bat_priv, skb, 0);
 	/* If we get an ARP_REQUEST we have to send the unicast message to the
 	 * selected DHT candidates */
@@ -421,6 +463,9 @@ bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 	struct neighbour *n = NULL;
 	bool ret = false;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return false;
+
 	type = arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REQUEST)
 		goto out;
@@ -474,6 +519,9 @@ bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return false;
+
 	type = arp_get_type(bat_priv, skb, 0);
 	if (type != ARPOP_REPLY)
 		goto out;
@@ -507,6 +555,9 @@ bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return false;
+
 	type = arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REPLY)
 		goto out;
@@ -537,6 +588,9 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 {
 	struct neighbour *n;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return false;
+
 	/* If this packet is an ARP_REQUEST and we already have the information
 	 * that it is going to ask, we can drop the packet */
 	if (!forw_packet->num_packets &&
@@ -561,21 +615,3 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	}
 	return false;
 }
-
-void arp_change_timeout(struct net_device *soft_iface)
-{
-	struct in_device *in_dev = in_dev_get(soft_iface);
-	if (!in_dev) {
-		pr_err("Unable to set ARP parameters for the batman interface '%s'\n",
-		       soft_iface->name);
-		return;
-	}
-
-	/* Introduce a delay in the ARP state-machine transactions. Entries
-	 * will be kept in the ARP table for the default time multiplied by 4 */
-	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
-	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
-	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
-
-	in_dev_put(in_dev);
-}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index c16aa1b..0e93c75 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -39,6 +39,7 @@
 #define ARP_IP_DST(skb, hdr_size) (*(uint32_t *)(ARP_HW_SRC(skb, hdr_size) + \
 				   ETH_ALEN * 2 + 4))
 
+void dat_sysfs_change(struct net_device *soft_iface);
 bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 				    struct sk_buff *skb);
 bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
@@ -49,7 +50,6 @@ bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 				  struct sk_buff *skb, int hdr_size);
 bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 			       struct forw_packet *forw_packet);
-void arp_change_timeout(struct net_device *soft_iface);
 
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
@@ -93,7 +93,6 @@ static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
 #define dat_snoop_outgoing_arp_reply(...)
 #define dat_snoop_incoming_arp_reply(...) (0)
 #define dat_drop_broadcast_packet(...) (0)
-#define arp_change_timeout(...)
 #define dat_init_orig_node_dht_addr(...)
 #define dat_init_own_dht_addr(...)
 
diff --git a/soft-interface.c b/soft-interface.c
index de0ceb2..3ce67c6 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -381,13 +381,12 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
-	arp_change_timeout(soft_iface);
-
 	bat_priv = netdev_priv(soft_iface);
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
+	atomic_set(&bat_priv->distributed_arp_table, 0);
 	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
diff --git a/types.h b/types.h
index 15f538a..8728266 100644
--- a/types.h
+++ b/types.h
@@ -170,6 +170,7 @@ struct bat_priv {
 	atomic_t fragmentation;		/* boolean */
 	atomic_t ap_isolation;		/* boolean */
 	atomic_t bridge_loop_avoidance;	/* boolean */
+	atomic_t distributed_arp_table;	/* boolean */
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t gw_mode;		/* GW_MODE_* */
 	atomic_t gw_sel_class;		/* uint */
-- 
1.7.9.4

