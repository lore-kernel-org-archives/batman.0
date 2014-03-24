Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 24 Mar 2014 11:59:28 +0100
Message-Id: <1395658768-9191-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: properly count contexts
	for softif_vlan objects
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

When a VLAN interface (on top of batX) is removed and
re-added within a short timeframe TT does not have enough
time to properly cleanup.
This creates an internal TT state mismatch as the newly
created softif_vlan will be initialized from scratch with a
TT client count of zero.
The resulting TT messages are bogus due to the counter / tt
client listing mismatch, thus creating inconsistencies on
every node in the network

To fix this a softif_vlan object has to be removed from the
vlan list only when all the local TT entries of such VLAN
have been destroyed.

Implement such behaviour by increasing the reference counter
of a softif_vlan object every time a new local TT entry for
such VLAN is created and remove the object from the list
only when all the TT entries have been destroyed.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

Changes since v1:
- destroy and create vlan sysfs folder within softif_vlan_destroy/create() to
  avoid lock troubles with soft-interface destruction and delayed jobs.

 soft-interface.c    | 61 +++++++++++++++++++++++++++++++++++++++++------------
 translation-table.c | 26 +++++++++++++++++++++++
 types.h             |  4 ++++
 3 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index cbe9e33..f41ed79 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -442,10 +442,15 @@ out:
  *  possibly free it
  * @softif_vlan: the vlan object to release
  */
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan)
+void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
 {
-	if (atomic_dec_and_test(&softif_vlan->refcount))
-		kfree_rcu(softif_vlan, rcu);
+	if (atomic_dec_and_test(&vlan->refcount)) {
+		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+		hlist_del_rcu(&vlan->list);
+		spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+
+		kfree_rcu(vlan, rcu);
+	}
 }
 
 /**
@@ -478,6 +483,21 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_softif_vlan_destroy_finish - cleans up the sysfs folder of a vlan
+ * @work: work queue item
+ *
+ * Free the sysfs folder of the vlan object which can not be removed under
+ * rtnl lock (to prevent deadlock/unsolicited sleep situations).
+ */
+static void batadv_softif_vlan_destroy_finish(struct work_struct *work)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = container_of(work, struct batadv_softif_vlan, cleanup_work);
+
+}
+
+/**
  * batadv_create_vlan - allocate the needed resources for a new vlan
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
@@ -499,8 +519,10 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	if (!vlan)
 		return -ENOMEM;
 
+	vlan->bat_priv = bat_priv;
 	vlan->vid = vid;
 	atomic_set(&vlan->refcount, 1);
+	INIT_WORK(&vlan->cleanup_work, batadv_softif_vlan_destroy_finish);
 
 	atomic_set(&vlan->ap_isolation, 0);
 
@@ -510,6 +532,10 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 		return err;
 	}
 
+	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
+	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
+	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
@@ -517,10 +543,6 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
-	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
-
 	return 0;
 }
 
@@ -532,18 +554,13 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 				       struct batadv_softif_vlan *vlan)
 {
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	hlist_del_rcu(&vlan->list);
-	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
-
-	batadv_sysfs_del_vlan(bat_priv, vlan);
-
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
 	 */
 	batadv_tt_local_remove(bat_priv, bat_priv->soft_iface->dev_addr,
 			       vlan->vid, "vlan interface destroyed", false);
 
+	batadv_sysfs_del_vlan(bat_priv, vlan);
 	batadv_softif_vlan_free_ref(vlan);
 }
 
@@ -561,6 +578,8 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct batadv_softif_vlan *vlan;
+	int ret;
 
 	/* only 802.1Q vlans are supported.
 	 * batman-adv does not know how to handle other types
@@ -570,6 +589,22 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 
 	vid |= BATADV_VLAN_HAS_TAG;
 
+	/* if a new vlan is getting created, but it is found in the list, it
+	 * means that it was not deleted yet. Make batadv_softif_vlan_get()
+	 * increase the refcounter by one and return
+	 */
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (vlan) {
+		ret = 0;
+		if (!vlan->kobj) {
+			ret = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
+			if (ret)
+				batadv_softif_vlan_free_ref(vlan);
+		}
+
+		return ret;
+	}
+
 	return batadv_softif_create_vlan(bat_priv, vid);
 }
 
diff --git a/translation-table.c b/translation-table.c
index 959dde7..b689981 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -485,6 +485,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global;
+	struct batadv_softif_vlan *vlan;
 	struct net_device *in_dev = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
@@ -544,6 +545,9 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (!tt_local)
 		goto out;
 
+	/* increase the refcounter of the related vlan */
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new local tt entry: %pM (vid: %d, ttvn: %d)\n",
 		   addr, BATADV_PRINT_VID(vid),
@@ -573,6 +577,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_tt_local_entry_free_ref(tt_local);
+		batadv_softif_vlan_free_ref(vlan);
 		goto out;
 	}
 
@@ -978,6 +983,7 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	uint16_t flags, curr_flags = BATADV_NO_FLAGS;
+	struct batadv_softif_vlan *vlan;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -1008,6 +1014,11 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	hlist_del_rcu(&tt_local_entry->common.hash_entry);
 	batadv_tt_local_entry_free_ref(tt_local_entry);
 
+	/* decrease the reference held for this vlan */
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_free_ref(vlan);
+
 out:
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
@@ -1080,6 +1091,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
+	struct batadv_softif_vlan *vlan;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	uint32_t i;
@@ -1100,6 +1112,13 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
+
+			/* decrease the reference held for this vlan */
+			vlan = batadv_softif_vlan_get(bat_priv,
+						      tt_common_entry->vid);
+			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_free_ref(vlan);
+
 			batadv_tt_local_entry_free_ref(tt_local);
 		}
 		spin_unlock_bh(list_lock);
@@ -3078,6 +3097,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_local_entry *tt_local;
+	struct batadv_softif_vlan *vlan;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -3106,6 +3126,12 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 			tt_local = container_of(tt_common,
 						struct batadv_tt_local_entry,
 						common);
+
+			/* decrease the reference held for this vlan */
+			vlan = batadv_softif_vlan_get(bat_priv, tt_common->vid);
+			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_free_ref(vlan);
+
 			batadv_tt_local_entry_free_ref(tt_local);
 		}
 		spin_unlock_bh(list_lock);
diff --git a/types.h b/types.h
index 78370ab..5fe0930 100644
--- a/types.h
+++ b/types.h
@@ -638,6 +638,7 @@ struct batadv_priv_nc {
 
 /**
  * struct batadv_softif_vlan - per VLAN attributes set
+ * @bat_priv: pointer to the mesh object
  * @vid: VLAN identifier
  * @kobj: kobject for sysfs vlan subdirectory
  * @ap_isolation: AP isolation state
@@ -645,8 +646,10 @@ struct batadv_priv_nc {
  * @list: list node for bat_priv::softif_vlan_list
  * @refcount: number of context where this object is currently in use
  * @rcu: struct used for freeing in a RCU-safe manner
+ * @cleanup_work: queue item to used to schedule the object destruction
  */
 struct batadv_softif_vlan {
+	struct batadv_priv *bat_priv;
 	unsigned short vid;
 	struct kobject *kobj;
 	atomic_t ap_isolation;		/* boolean */
@@ -654,6 +657,7 @@ struct batadv_softif_vlan {
 	struct hlist_node list;
 	atomic_t refcount;
 	struct rcu_head rcu;
+	struct work_struct cleanup_work;
 };
 
 /**
-- 
1.8.3.2

