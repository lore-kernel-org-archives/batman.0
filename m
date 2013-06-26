Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 26 Jun 2013 23:12:34 +0200
Message-Id: <1372281154-628-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1372281154-628-1-git-send-email-ordex@autistici.org>
References: <1372281154-628-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv10 3/3] batman-adv: make the AP isolation
	attribute VLAN specific
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

AP isolation has to be enabled on one VLAN interface only.
This patch moves the AP isolation attribute to the per-vlan
interface attribute set, enabling it to have a different
value depending on the selected vlan.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 soft-interface.c     |  5 +++--
 sysfs-class-net-mesh |  5 +++--
 sysfs.c              |  5 +++--
 translation-table.c  | 27 ++++++++++++++++++++-------
 translation-table.h  |  2 +-
 types.h              |  4 ++--
 6 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 9086c8c..0fad27b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -372,7 +372,8 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
 						     ethhdr->h_source, vid);
 
-	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
+	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest,
+				  vid))
 		goto dropped;
 
 	netif_rx(skb);
@@ -449,6 +450,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	batadv_tt_local_add(bat_priv->soft_iface,
 			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX);
+	atomic_set(&vlan->ap_isolation, 0);
 
 	err = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
 	if (err)
@@ -639,7 +641,6 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
-	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index f00a69b..ee4a479 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -6,13 +6,14 @@ Description:
                 Indicates whether the batman protocol messages of the
                 mesh <mesh_iface> shall be aggregated or not.
 
-What:           /sys/class/net/<mesh_iface>/mesh/ap_isolation
+What:           /sys/class/net/<mesh_iface>/mesh/<vlan_subdir>/ap_isolation
 Date:           May 2011
 Contact:        Antonio Quartulli <ordex@autistici.org>
 Description:
                 Indicates whether the data traffic going from a
                 wireless client to another wireless client will be
-                silently dropped.
+                silently dropped. <vlan_subdir> is empty when referring
+		to the untagged lan.
 
 What:           /sys/class/net/<mesh_iface>/mesh/bonding
 Date:           June 2010
diff --git a/sysfs.c b/sysfs.c
index e2a0b00..8529682 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -449,7 +449,6 @@ BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR,
 		     batadv_dat_status_update);
 #endif
 BATADV_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
-BATADV_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BATADV_ATTR(routing_algo, S_IRUGO, batadv_show_bat_algo, NULL);
 static BATADV_ATTR(gw_mode, S_IRUGO | S_IWUSR, batadv_show_gw_mode,
 		   batadv_store_gw_mode);
@@ -479,7 +478,6 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_distributed_arp_table,
 #endif
 	&batadv_attr_fragmentation,
-	&batadv_attr_ap_isolation,
 	&batadv_attr_routing_algo,
 	&batadv_attr_gw_mode,
 	&batadv_attr_orig_interval,
@@ -495,10 +493,13 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	NULL,
 };
 
+BATADV_ATTR_VLAN_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
+
 /**
  * batadv_vlan_attrs - array of vlan specific sysfs attributes
  */
 static struct batadv_attribute *batadv_vlan_attrs[] = {
+	&batadv_attr_vlan_ap_isolation,
 	NULL,
 };
 
diff --git a/translation-table.c b/translation-table.c
index 8404eef..7ac5ddc 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1482,8 +1482,19 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tt_orig_list_entry *best_entry;
+	bool ap_isolation_enabled = false;
+	struct batadv_softif_vlan *vlan;
 
-	if (src && atomic_read(&bat_priv->ap_isolation)) {
+	/* if the AP isolation is requested on a VLAN, then check for its
+	 * setting in the proper VLAN private data structure
+	 */
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (vlan) {
+		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
+		batadv_softif_vlan_free_ref(vlan);
+	}
+
+	if (src && ap_isolation_enabled) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
 		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
@@ -2547,22 +2558,22 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 }
 
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
-			   uint8_t *dst)
+			   uint8_t *dst, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_softif_vlan *vlan;
 	bool ret = false;
 
-	if (!atomic_read(&bat_priv->ap_isolation))
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (!vlan || !atomic_read(&vlan->ap_isolation))
 		goto out;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst,
-						   BATADV_NO_FLAGS);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
 	if (!tt_local_entry)
 		goto out;
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src,
-						     BATADV_NO_FLAGS);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src, vid);
 	if (!tt_global_entry)
 		goto out;
 
@@ -2572,6 +2583,8 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 	ret = true;
 
 out:
+	if (vlan)
+		batadv_softif_vlan_free_ref(vlan);
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
diff --git a/translation-table.h b/translation-table.h
index 1d9506d..c6bf33c 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -39,7 +39,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv);
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr,
 			 unsigned short vid);
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
-			   uint8_t *dst);
+			   uint8_t *dst, unsigned short vid);
 void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv);
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					uint8_t *addr, unsigned short vid);
diff --git a/types.h b/types.h
index be08721..0fbf07c 100644
--- a/types.h
+++ b/types.h
@@ -534,6 +534,7 @@ struct batadv_priv_nc {
  * struct batadv_softif_vlan - per VLAN attributes set
  * @vid: VLAN identifier
  * @kobj: kobject for sysfs vlan subdirectory
+ * @ap_isolation: AP isolation state
  * @list: list node for bat_priv::softif_vlan_list
  * @refcount: number of context where this object is currently in use
  * @rcu: struct used for freeing in a RCU-safe manner
@@ -541,6 +542,7 @@ struct batadv_priv_nc {
 struct batadv_softif_vlan {
 	unsigned short vid;
 	struct kobject *kobj;
+	atomic_t ap_isolation;		/* boolean */
 	struct hlist_node list;
 	atomic_t refcount;
 	struct rcu_head rcu;
@@ -556,7 +558,6 @@ struct batadv_softif_vlan {
  * @bonding: bool indicating whether traffic bonding is enabled
  * @fragmentation: bool indicating whether traffic fragmentation is enabled
  * @frag_seqno: incremental counter to identify chains of egress fragments
- * @ap_isolation: bool indicating whether ap isolation is enabled
  * @bridge_loop_avoidance: bool indicating whether bridge loop avoidance is
  *  enabled
  * @distributed_arp_table: bool indicating whether distributed ARP table is
@@ -603,7 +604,6 @@ struct batadv_priv {
 	atomic_t bonding;
 	atomic_t fragmentation;
 	atomic_t frag_seqno;
-	atomic_t ap_isolation;
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_t bridge_loop_avoidance;
 #endif
-- 
1.8.1.5

