Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  1 Oct 2012 09:57:42 +0200
Message-Id: <1349078263-5834-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-1-git-send-email-ordex@autistici.org>
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv12 8/9] batman-adv: Distributed ARP Table -
	add runtime switch
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This patch adds a runtime switch that enables the user to turn the DAT feature
on or off at runtime

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c | 25 +++++++++++++++++++++++++
 distributed-arp-table.h |  1 +
 soft-interface.c        |  3 +++
 sysfs.c                 |  8 ++++++++
 types.h                 |  3 +++
 5 files changed, 40 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f43bf8e..d637d62 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -790,6 +790,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	struct sk_buff *skb_new;
 	struct batadv_hard_iface *primary_if = NULL;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		goto out;
+
 	type = batadv_arp_get_type(bat_priv, skb, 0);
 	/* If the node gets an ARP_REQUEST it has to send a DHT_GET unicast
 	 * message to the selected DHT candidates
@@ -861,6 +864,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	bool ret = false;
 	int err;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		goto out;
+
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REQUEST)
 		goto out;
@@ -924,6 +930,9 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	__be32 ip_src, ip_dst;
 	uint8_t *hw_src, *hw_dst;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return;
+
 	type = batadv_arp_get_type(bat_priv, skb, 0);
 	if (type != ARPOP_REPLY)
 		return;
@@ -959,6 +968,9 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		goto out;
+
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REPLY)
 		goto out;
@@ -1003,6 +1015,9 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	bool ret = false;
 	const size_t bcast_len = sizeof(struct batadv_bcast_packet);
 
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		goto out;
+
 	/* If this packet is an ARP_REQUEST and the node already has the
 	 * information that it is going to ask, then the packet can be dropped
 	 */
@@ -1031,3 +1046,13 @@ out:
 		batadv_dat_entry_free_ref(dat_entry);
 	return ret;
 }
+
+void batadv_dat_switch(struct net_device *net_dev)
+{
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+
+	if (atomic_read(&bat_priv->distributed_arp_table))
+		batadv_dat_init(bat_priv);
+	else
+		batadv_dat_free(bat_priv);
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 77814e8..abdae59 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -73,6 +73,7 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
+void batadv_dat_switch(struct net_device *net_dev);
 
 #else
 
diff --git a/soft-interface.c b/soft-interface.c
index 9dc0ae1..7b4a3a3 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -480,6 +480,9 @@ struct net_device *batadv_softif_create(const char *name)
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
+#ifdef CONFIG_BATMAN_ADV_DAT
+	atomic_set(&bat_priv->distributed_arp_table, 1);
+#endif
 	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->vis_mode, BATADV_VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
diff --git a/sysfs.c b/sysfs.c
index fa6c8b1..7fdc220 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -20,6 +20,7 @@
 #include "main.h"
 #include "sysfs.h"
 #include "translation-table.h"
+#include "distributed-arp-table.h"
 #include "originator.h"
 #include "hard-interface.h"
 #include "gateway_common.h"
@@ -470,6 +471,10 @@ BATADV_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
 BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
+BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR,
+		     batadv_dat_switch);
+#endif
 BATADV_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
 BATADV_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BATADV_ATTR(vis_mode, S_IRUGO | S_IWUSR, batadv_show_vis_mode,
@@ -495,6 +500,9 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 #ifdef CONFIG_BATMAN_ADV_BLA
 	&batadv_attr_bridge_loop_avoidance,
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
+	&batadv_attr_distributed_arp_table,
+#endif
 	&batadv_attr_fragmentation,
 	&batadv_attr_ap_isolation,
 	&batadv_attr_vis_mode,
diff --git a/types.h b/types.h
index 2960acb..6b55645 100644
--- a/types.h
+++ b/types.h
@@ -273,6 +273,9 @@ struct batadv_priv {
 	atomic_t fragmentation;		/* boolean */
 	atomic_t ap_isolation;		/* boolean */
 	atomic_t bridge_loop_avoidance;	/* boolean */
+#ifdef CONFIG_BATMAN_ADV_DAT
+	atomic_t distributed_arp_table;	/* boolean */
+#endif
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t gw_mode;		/* GW_MODE_* */
 	atomic_t gw_sel_class;		/* uint */
-- 
1.7.12

