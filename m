Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Jul 2015 15:16:28 +0800
Message-Id: <1437894990-15534-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: add list of unique single
	hop neighbors per hard-interface
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/hard-interface.c |   3 +
 net/batman-adv/originator.c     | 130 ++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.h     |   5 ++
 net/batman-adv/types.h          |  21 +++++++
 4 files changed, 159 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f4a15d2..608ea4a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -596,9 +596,12 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 		goto free_sysfs;
 
 	INIT_LIST_HEAD(&hard_iface->list);
+	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 	INIT_WORK(&hard_iface->cleanup_work,
 		  batadv_hardif_remove_interface_finish);
 
+	spin_lock_init(&hard_iface->neigh_list_lock);
+
 	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
 	if (batadv_is_wifi_netdev(net_dev))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1429603..42a5fb2 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -202,6 +202,46 @@ void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 }
 
 /**
+ * batadv_hardif_neigh_free_rcu - free the hardif neigh_node
+ * @rcu: rcu pointer of the neigh_node
+ */
+static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_hardif_neigh_node *hardif_node;
+
+	hardif_node = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
+
+	spin_lock_bh(&hardif_node->if_incoming->neigh_list_lock);
+	hlist_del_init_rcu(&hardif_node->list);
+	spin_unlock_bh(&hardif_node->if_incoming->neigh_list_lock);
+
+	batadv_hardif_free_ref_now(hardif_node->if_incoming);
+	kfree(hardif_node);
+}
+
+/**
+ * batadv_hardif_neigh_free_now - decrement the hardif neighbors refcounter
+ *  and possibly free it (without rcu callback)
+ * @hardif_node: hardif neigh neighbor to free
+ */
+void batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_node)
+{
+       if (atomic_dec_and_test(&hardif_node->refcount))
+               batadv_hardif_neigh_free_rcu(&hardif_node->rcu);
+}
+
+/**
+ * batadv_hardif_neigh_free_ref - decrement the hardif neighbors refcounter
+ *  and possibly free it
+ * @hardif_node: hardif neigh neighbor to free
+ */
+void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_node)
+{
+       if (atomic_dec_and_test(&hardif_node->refcount))
+               call_rcu(&hardif_node->rcu, batadv_hardif_neigh_free_rcu);
+}
+
+/**
  * batadv_neigh_node_free_rcu - free the neigh_node
  * @rcu: rcu pointer of the neigh_node
  */
@@ -209,6 +249,7 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
+	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 	struct batadv_algo_ops *bao;
 
@@ -220,6 +261,14 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
 	}
 
+	hardif_neigh = batadv_hardif_neigh_get(neigh_node->if_incoming,
+					       neigh_node->addr);
+	if (hardif_neigh) {
+		/* batadv_hardif_neigh_get() increases refcount too */
+		batadv_hardif_neigh_free_now(hardif_neigh);
+		batadv_hardif_neigh_free_now(hardif_neigh);
+	}
+
 	if (bao->bat_neigh_free)
 		bao->bat_neigh_free(neigh_node);
 
@@ -443,6 +492,76 @@ out:
 }
 
 /**
+ * batadv_hardif_neigh_get - retrieve a hardif neighbour from the list
+ * @hard_iface: the interface where this neighbour is connected to
+ * @neigh_addr: the address of the neighbour
+ *
+ * Looks for and possibly returns a neighbour belonging to this hard interface.
+ * Returns NULL if the neighbour is not found.
+ */
+struct batadv_hardif_neigh_node *
+batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
+			const u8 *neigh_addr)
+{
+	struct batadv_hardif_neigh_node *tmp_hardif_node, *hardif_node = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_hardif_node,
+				 &hard_iface->neigh_list, list) {
+		if (!batadv_compare_eth(tmp_hardif_node->addr, neigh_addr))
+			continue;
+
+		if (!atomic_inc_not_zero(&tmp_hardif_node->refcount))
+			continue;
+
+		hardif_node = tmp_hardif_node;
+		break;
+	}
+	rcu_read_unlock();
+
+	return hardif_node;
+}
+
+/**
+ * batadv_hardif_neigh_get_or_create - retrieve or create a hardif neighbour node
+ * @hard_iface: the interface this neighbour is connected to
+ * @neigh_addr: the interface address of the neighbour to retrieve
+ *
+ * Returns the hardif neighbour node if found or created or NULL otherwise.
+ */
+static struct batadv_hardif_neigh_node *
+batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
+				  const u8 *neigh_addr)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+
+	hardif_neigh = batadv_hardif_neigh_get(hard_iface, neigh_addr);
+	if (hardif_neigh)
+		return hardif_neigh;
+
+	if (!atomic_inc_not_zero(&hard_iface->refcount))
+		return NULL;
+
+	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
+	if (!hardif_neigh) {
+		batadv_hardif_free_ref(hard_iface);
+		return NULL;
+	}
+
+	INIT_HLIST_NODE(&hardif_neigh->list);
+	ether_addr_copy(hardif_neigh->addr, neigh_addr);
+	hardif_neigh->if_incoming = hard_iface;
+
+	atomic_set(&hardif_neigh->refcount, 1);
+
+	spin_lock_bh(&hard_iface->neigh_list_lock);
+	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
+	spin_unlock_bh(&hard_iface->neigh_list_lock);
+
+	return hardif_neigh;
+}
+
+/**
  * batadv_neigh_node_new - create and init a new neigh_node object
  * @orig_node: originator object representing the neighbour
  * @hard_iface: the interface where the neighbour is connected to
@@ -457,11 +576,17 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 		      const u8 *neigh_addr)
 {
 	struct batadv_neigh_node *neigh_node;
+	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 
 	neigh_node = batadv_neigh_node_get(orig_node, hard_iface, neigh_addr);
 	if (neigh_node)
 		goto out;
 
+	hardif_neigh = batadv_hardif_neigh_get_or_create(hard_iface,
+							 neigh_addr);
+	if (!hardif_neigh)
+		goto out;
+
 	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
 	if (!neigh_node)
 		goto out;
@@ -487,11 +612,16 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	/* increment unique neighbor refcount */
+	atomic_inc(&hardif_neigh->refcount);
+
 	batadv_dbg(BATADV_DBG_BATMAN, orig_node->bat_priv,
 		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
 		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
 
 out:
+	if (hardif_neigh)
+		batadv_hardif_neigh_free_ref(hardif_neigh);
 	return neigh_node;
 }
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index fde3438..99405be 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -41,6 +41,11 @@ void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
 void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr);
+struct batadv_hardif_neigh_node *
+batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
+			const u8 *neigh_addr);
+void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_node);
+void batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_node);
 struct batadv_neigh_node *
 batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 		      const struct batadv_hard_iface *hard_iface,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2f5e6c3..ee12bf8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -100,6 +100,8 @@ struct batadv_hard_iface_bat_iv {
  * @bat_iv: BATMAN IV specific per hard interface data
  * @cleanup_work: work queue callback item for hard interface deinit
  * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
+ * @neigh_list: list of unique single hop neighbors via this interface
+ * @neigh_list_lock: lock protecting neigh_list
  */
 struct batadv_hard_iface {
 	struct list_head list;
@@ -115,6 +117,9 @@ struct batadv_hard_iface {
 	struct batadv_hard_iface_bat_iv bat_iv;
 	struct work_struct cleanup_work;
 	struct dentry *debug_dir;
+	struct hlist_head neigh_list;
+	/* neigh_list_lock protects: neigh_list */
+	spinlock_t neigh_list_lock;
 };
 
 /**
@@ -343,6 +348,22 @@ struct batadv_gw_node {
 };
 
 /**
+ * batadv_hardif_neigh_node - unique neighbor per hard interface
+ * @list: list node for batadv_hard_iface::neigh_list
+ * @addr: the MAC address of the neighboring interface
+ * @if_incoming: pointer to incoming hard interface
+ * @refcount: number of contexts the object is used
+ * @rcu: struct used for freeing in a RCU-safe manner
+ */
+struct batadv_hardif_neigh_node {
+	struct hlist_node list;
+	u8 addr[ETH_ALEN];
+	struct batadv_hard_iface *if_incoming;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
+/**
  * struct batadv_neigh_node - structure for single hops neighbors
  * @list: list node for batadv_orig_node::neigh_list
  * @orig_node: pointer to corresponding orig_node
-- 
2.1.4

