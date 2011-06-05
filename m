Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  5 Jun 2011 23:01:03 +0200
Message-Id: <1307307664-19910-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1307307664-19910-1-git-send-email-ordex@autistici.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: implement AP-isolation on
	the sender side
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

If a node has to send a packet issued by a WIFI client to another WIFI client,
the packet is dropped.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_sysfs.c          |    2 ++
 routing.c            |    2 +-
 soft-interface.c     |    1 +
 sysfs-class-net-mesh |    8 ++++++++
 translation-table.c  |   38 ++++++++++++++++++++++++++++++++------
 translation-table.h  |    2 +-
 types.h              |    1 +
 unicast.c            |    6 ++++--
 8 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 63738ec..29cba25 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -366,6 +366,7 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
+BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
@@ -382,6 +383,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
 	&bat_attr_fragmentation,
+	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
diff --git a/routing.c b/routing.c
index 70c39dd..d5fd35f 100644
--- a/routing.c
+++ b/routing.c
@@ -1527,7 +1527,7 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 		ethhdr = (struct ethhdr *)(skb->data +
 			sizeof(struct unicast_packet));
-		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+		orig_node = transtable_search(bat_priv, NULL, ethhdr->h_dest);
 
 		if (!orig_node) {
 			if (!is_my_client(bat_priv, ethhdr->h_dest))
diff --git a/soft-interface.c b/soft-interface.c
index 60234af..6489665 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -817,6 +817,7 @@ struct net_device *softif_create(const char *name)
 
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
index 1d4c34c..e0c5945 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -807,25 +807,51 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
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
-				    const uint8_t *addr)
+				    const uint8_t *src, const uint8_t *addr)
 {
-	struct tt_global_entry *tt_global_entry;
+	struct tt_local_entry *tt_local_entry = NULL;
+	struct tt_global_entry *tt_global_entry = NULL;
 	struct orig_node *orig_node = NULL;
 
-	tt_global_entry = tt_global_hash_find(bat_priv, addr);
+	if (src && atomic_read(&bat_priv->ap_isolation)) {
+		tt_local_entry = tt_local_hash_find(bat_priv, src);
+		if (!tt_local_entry)
+			goto out;
+	}
 
+	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 	if (!tt_global_entry)
 		goto out;
 
+	/* check whether the clients should not communicate due to AP
+	 * isolation */
+	if (tt_local_entry && _is_ap_isolated(tt_local_entry, tt_global_entry))
+		goto out;
+
 	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
-		goto free_tt;
+		goto out;
 
 	orig_node = tt_global_entry->orig_node;
 
-free_tt:
-	tt_global_entry_free_ref(tt_global_entry);
 out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
+
 	return orig_node;
 }
 
diff --git a/translation-table.h b/translation-table.h
index b62ae00..3055b8b 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -48,7 +48,7 @@ void tt_global_del(struct bat_priv *bat_priv,
 		   struct orig_node *orig_node, const unsigned char *addr,
 		   const char *message, bool roaming);
 struct orig_node *transtable_search(struct bat_priv *bat_priv,
-				    const uint8_t *addr);
+				    const uint8_t *src, const uint8_t *addr);
 void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			 const unsigned char *tt_buff, uint8_t tt_num_changes);
 uint16_t tt_local_crc(struct bat_priv *bat_priv);
diff --git a/types.h b/types.h
index 0d85ba7..2ec748d 100644
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
diff --git a/unicast.c b/unicast.c
index 32b125f..07d1c1d 100644
--- a/unicast.c
+++ b/unicast.c
@@ -299,8 +299,10 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 			goto find_router;
 	}
 
-	/* check for tt host - increases orig_node refcount */
-	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+	/* check for tt host - increases orig_node refcount.
+	 * returns NULL in case of AP isolation */
+	orig_node = transtable_search(bat_priv, ethhdr->h_source,
+				      ethhdr->h_dest);
 
 find_router:
 	/**
-- 
1.7.3.4

