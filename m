Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 16:34:35 +0200
Message-Id: <1366727676-23233-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-1-git-send-email-ordex@autistici.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: add per VLAN interface
	attribute framework
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

Since batman-adv is now fully VLAN-aware, a proper framework
able to handle per-vlan-interface attributes is now needed.
Those attributes will affect the associated VLAN interface
only, rather than the real soft_iface (which would result
in every vlan interface having the same attribute
configuration)

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 main.c           | 44 ++++++++++++++++++++++++++++++++++++
 main.h           |  3 +++
 soft-interface.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 types.h          | 21 +++++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/main.c b/main.c
index 689cf49..d1a049d 100644
--- a/main.c
+++ b/main.c
@@ -108,6 +108,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->gw.list_lock);
 	spin_lock_init(&bat_priv->tvlv.container_list_lock);
 	spin_lock_init(&bat_priv->tvlv.handler_list_lock);
+	spin_lock_init(&bat_priv->priv_vlan_list_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
@@ -117,6 +118,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt.roam_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.container_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
+	INIT_LIST_HEAD(&bat_priv->priv_vlan_list);
 
 	ret = batadv_originator_init(bat_priv);
 	if (ret < 0)
@@ -1099,6 +1101,48 @@ out:
 		batadv_orig_node_free_ref(orig_node);
 }
 
+/**
+ * batadv_priv_vlan_free_ref - decrease vlan refcounter and possibly free it
+ * @priv_vlan: the vlan object to release
+ */
+void batadv_priv_vlan_free_ref(struct batadv_priv_vlan *priv_vlan)
+{
+	if (atomic_dec_and_test(&priv_vlan->refcount))
+		kfree_rcu(priv_vlan, rcu);
+}
+
+/**
+ * batadv_get_priv_vlan - get VLAN priv data
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the identifier of the VLAN data to retrieve
+ *
+ * Return the private data of the VLAN matching vid and increments its
+ * refcounter or NULL otherwise.
+ */
+struct batadv_priv_vlan *batadv_get_priv_vlan(struct batadv_priv *bat_priv,
+					      unsigned short vid)
+{
+	struct batadv_priv_vlan *vlan, *vlan_tmp = NULL;
+
+	if (!(vid & BATADV_VID_MASK))
+		return NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(vlan, &bat_priv->priv_vlan_list, list) {
+		if (vlan->vid != (vid & BATADV_VID_MASK))
+			continue;
+
+		if (!atomic_inc_not_zero(&vlan->refcount))
+			continue;
+
+		vlan_tmp = vlan;
+		break;
+	}
+	rcu_read_unlock();
+
+	return vlan_tmp;
+}
+
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/main.h b/main.h
index a60ab1b..175c0d1 100644
--- a/main.h
+++ b/main.h
@@ -196,6 +196,9 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
+void batadv_priv_vlan_free_ref(struct batadv_priv_vlan *priv_vlan);
+struct batadv_priv_vlan *batadv_get_priv_vlan(struct batadv_priv *bat_priv,
+					      unsigned short vid);
 
 /**
  * enum batadv_dbg_level - available log levels
diff --git a/soft-interface.c b/soft-interface.c
index 8911fe5..986e8e5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -373,6 +373,72 @@ out:
 	return;
 }
 
+/**
+ * batadv_add_vid - ndo_add_vid API implementation
+ * @dev: the netdev of the mesh interface
+ * @vid: identifier of the new VLAN
+ *
+ * Set up all the internal structures for handling the new VLAN on top of the
+ * mesh interface
+ */
+static int batadv_add_vid(struct net_device *dev, unsigned short vid)
+{
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv_vlan *vlan;
+
+	vlan = kmalloc(sizeof(*vlan), GFP_ATOMIC);
+	if (!vlan)
+		return -ENOMEM;
+
+	vlan->vid = vid;
+	atomic_set(&vlan->refcount, 1);
+
+	/* add a new TT local entry. This one will be marked with the NOPURGE
+	 * flag
+	 */
+	batadv_tt_local_add(dev, dev->dev_addr, vid | BATADV_VLAN_HAS_TAG,
+			    BATADV_NULL_IFINDEX);
+
+	spin_lock_bh(&bat_priv->priv_vlan_list_lock);
+	list_add_rcu(&vlan->list, &bat_priv->priv_vlan_list);
+	spin_unlock_bh(&bat_priv->priv_vlan_list_lock);
+
+	return 0;
+}
+
+/**
+ * batadv_kill_vid - ndo_kill_vid API implementation
+ * @dev: the netdev of the mesh interface
+ * @vid: identifier of the deleted VLAN
+ *
+ * Destroy all the internal structures used to handle the VLAN identified by vid
+ * on top of the mesh interface
+ */
+static int batadv_kill_vid(struct net_device *dev, unsigned short vid)
+{
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv_vlan *vlan, *vlan_tmp = NULL;
+
+	list_for_each_entry_rcu(vlan, &bat_priv->priv_vlan_list, list) {
+		if (vlan->vid != vid)
+			continue;
+		vlan_tmp = vlan;
+		break;
+	}
+
+	spin_lock_bh(&bat_priv->priv_vlan_list_lock);
+	list_del_rcu(&vlan->list);
+	spin_unlock_bh(&bat_priv->priv_vlan_list_lock);
+
+	/* explicitly remove the associated TT local entry because it is marked
+	 * with the NOPURGE flag
+	 */
+	batadv_tt_local_remove(bat_priv, dev->dev_addr, vid,
+			       "vlan interface destroyed", false);
+
+	return 0;
+}
+
 /* batman-adv network devices have devices nesting below it and are a special
  * "super class" of normal network devices; split their locks off into a
  * separate class since they always nest.
@@ -573,6 +639,8 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_open = batadv_interface_open,
 	.ndo_stop = batadv_interface_release,
 	.ndo_get_stats = batadv_interface_stats,
+	.ndo_vlan_rx_add_vid = batadv_add_vid,
+	.ndo_vlan_rx_kill_vid = batadv_kill_vid,
 	.ndo_set_mac_address = batadv_interface_set_mac_addr,
 	.ndo_change_mtu = batadv_interface_change_mtu,
 	.ndo_start_xmit = batadv_interface_tx,
@@ -611,6 +679,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = batadv_softif_free;
+	dev->features |= NETIF_F_HW_VLAN_FILTER;
 	dev->tx_queue_len = 0;
 
 	/* can't call min_mtu, because the needed variables
diff --git a/types.h b/types.h
index ddeb497..956d66b 100644
--- a/types.h
+++ b/types.h
@@ -526,6 +526,22 @@ struct batadv_priv_nc {
 	struct batadv_hashtable *decoding_hash;
 };
 
+/*
+ * struct batadv_priv_vlan - per VLAN attributes set
+ * @vid: VLAN identifier
+ * @kobj: kobject for sysfs vlan subdirectory
+ * @list: list node for bat_priv::priv_vlan_list
+ * @refcount: number of context where this object is currently in use
+ * @rcu: struct used for freeing in a RCU-safe manner
+ */
+struct batadv_priv_vlan {
+	unsigned short vid;
+	struct kobject *kobj;
+	struct list_head list;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
 /**
  * struct batadv_priv - per mesh interface data
  * @mesh_state: current status of the mesh (inactive/active/deactivating)
@@ -562,6 +578,9 @@ struct batadv_priv_nc {
  * @primary_if: one of the hard interfaces assigned to this mesh interface
  *  becomes the primary interface
  * @bat_algo_ops: routing algorithm used by this mesh interface
+ * @priv_vlan_list: a list of priv_vlan structs, one per VLAN created on top of
+ *  the mesh interface represented by this object
+ * @priv_vlan_list_lock: lock protecting priv_vlan_list
  * @bla: bridge loope avoidance data
  * @debug_log: holding debug logging relevant data
  * @gw: gateway data
@@ -610,6 +629,8 @@ struct batadv_priv {
 	struct work_struct cleanup_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
+	spinlock_t priv_vlan_list_lock; /* protects priv_vlan_list */
+	struct list_head priv_vlan_list;
 #ifdef CONFIG_BATMAN_ADV_BLA
 	struct batadv_priv_bla bla;
 #endif
-- 
1.8.1.5

