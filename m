Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 26 Jun 2011 23:00:15 +0200
Message-Id: <1309122017-29823-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1307307664-19910-1-git-send-email-ordex@autistici.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: implement AP-isolation on
	the receiver side
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

When a node receives a unicast packet it checks if the source and the
destination client can communicate or not due to the AP isolation

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_sysfs.c          |    2 ++
 soft-interface.c     |    4 ++++
 sysfs-class-net-mesh |    8 ++++++++
 translation-table.c  |   42 ++++++++++++++++++++++++++++++++++++++++++
 translation-table.h  |    1 +
 types.h              |    1 +
 6 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index cd15deb..b8a7414 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -380,6 +380,7 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
+BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
@@ -396,6 +397,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
 	&bat_attr_fragmentation,
+	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
diff --git a/soft-interface.c b/soft-interface.c
index 48146e5..839ded9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -739,6 +739,9 @@ void interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
+	if (is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
+		goto dropped;
+
 	netif_rx(skb);
 	goto out;
 
@@ -823,6 +826,7 @@ struct net_device *softif_create(const char *name)
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
+	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index 748fe17..b020014 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -22,6 +22,14 @@ Description:
                 mesh will be fragmented or silently discarded if the
                 packet size exceeds the outgoing interface MTU.
 
+What:		/sys/class/net/<mesh_iface>/mesh/ap_isolation
+Date:		May 2011
+Contact:	Antonio Quartulli <ordex@autistici.org>
+Description:
+		Indicates whether the data traffic going from a
+		wireless client to another wireless client will be
+		silently dropped.
+
 What:           /sys/class/net/<mesh_iface>/mesh/gw_bandwidth
 Date:           October 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
diff --git a/translation-table.c b/translation-table.c
index e1dede1..3deccc0 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -780,6 +780,18 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
 	bat_priv->tt_global_hash = NULL;
 }
 
+static bool _is_ap_isolated(struct tt_local_entry *tt_local_entry,
+			    struct tt_global_entry *tt_global_entry)
+{
+	bool ret = false;
+
+	if (tt_local_entry->flags & TT_CLIENT_WIFI &&
+	    tt_global_entry->flags & TT_CLIENT_WIFI)
+		ret = true;
+
+	return ret;
+}
+
 struct orig_node *transtable_search(struct bat_priv *bat_priv,
 				    const uint8_t *addr)
 {
@@ -1631,3 +1643,33 @@ void tt_free(struct bat_priv *bat_priv)
 
 	kfree(bat_priv->tt_buff);
 }
+
+bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
+{
+	struct tt_local_entry *tt_local_entry = NULL;
+	struct tt_global_entry *tt_global_entry = NULL;
+	bool ret = true;
+
+	if (!atomic_read(&bat_priv->ap_isolation))
+		return false;
+
+	tt_local_entry = tt_local_hash_find(bat_priv, dst);
+	if (!tt_local_entry)
+		goto out;
+
+	tt_global_entry = tt_global_hash_find(bat_priv, src);
+	if (!tt_global_entry)
+		goto out;
+
+	if (_is_ap_isolated(tt_local_entry, tt_global_entry))
+		goto out;
+
+	ret = false;
+
+out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
+	return ret;
+}
diff --git a/translation-table.h b/translation-table.h
index e244858..9b93c16 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -62,5 +62,6 @@ void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
 void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		   struct orig_node *orig_node);
+bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 582283a..4df1f5f 100644
--- a/types.h
+++ b/types.h
@@ -146,6 +146,7 @@ struct bat_priv {
 	atomic_t aggregated_ogms;	/* boolean */
 	atomic_t bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
+	atomic_t ap_isolation;		/* boolean */
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t gw_mode;		/* GW_MODE_* */
 	atomic_t gw_sel_class;		/* uint */
-- 
1.7.3.4

