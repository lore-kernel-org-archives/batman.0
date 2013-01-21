Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 21 Jan 2013 11:22:22 +0100
Message-Id: <1358763746-16742-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1358763746-16742-1-git-send-email-martin@hundeboll.net>
References: <1358763746-16742-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: Detect coding nodes and
	remove these after timeout
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

To use network coding efficiently, a relay must know when neighbor nodes
are likely to have enough information to be able to decode a network
coded packet. This is detected by using OGMs from batman-adv to discover
when one neighbor is in range of another neighbor. The relay check the
TLL to detect when an OGM is forwarded from one neighbor by another
neighbor, and thereby knows that the two neighbors are in range and thus
overhear packets sent by each other.

This information is saved in the orig_node struct to be used when
searching for coding opportunities. Two lists are added to the
orig_node struct: One for neighbors that can hear the orig_node
(outgoing nc_nodes) and one for neighbors that the orig_node can hear
(incoming nc_nodes).

Information about nc_nodes is kept for 10 seconds and is available
through debugfs in batman_adv/nc_nodes to use when debugging network
coding.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
v3:
 * Fixed typos in kernel doc

 bat_iv_ogm.c     |   5 +
 debugfs.c        |  18 +++
 main.h           |   2 +
 network-coding.c | 416 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h |  47 +++++++
 originator.c     |   6 +
 types.h          |  31 +++++
 7 files changed, 525 insertions(+)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 72fe1bb..7654b76 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -27,6 +27,7 @@
 #include "hard-interface.h"
 #include "send.h"
 #include "bat_algo.h"
+#include "network-coding.h"
 
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
@@ -1189,6 +1190,10 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (!orig_neigh_node)
 		goto out;
 
+	/* Update nc_nodes of the originator */
+	batadv_nc_update_nc_node(bat_priv, orig_node, orig_neigh_node,
+				 batadv_ogm_packet, is_single_hop_neigh);
+
 	orig_neigh_router = batadv_orig_node_get_router(orig_neigh_node);
 
 	/* drop packet if sender is not a direct neighbor and if we
diff --git a/debugfs.c b/debugfs.c
index 6ae8651..f186a55 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -32,6 +32,7 @@
 #include "icmp_socket.h"
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
+#include "network-coding.h"
 
 static struct dentry *batadv_debugfs;
 
@@ -310,6 +311,14 @@ struct batadv_debuginfo {
 	const struct file_operations fops;
 };
 
+#ifdef CONFIG_BATMAN_ADV_NC
+static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, batadv_nc_nodes_seq_print_text, net_dev);
+}
+#endif
+
 #define BATADV_DEBUGINFO(_name, _mode, _open)		\
 struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 	.attr = { .name = __stringify(_name),		\
@@ -348,6 +357,9 @@ static BATADV_DEBUGINFO(dat_cache, S_IRUGO, batadv_dat_cache_open);
 static BATADV_DEBUGINFO(transtable_local, S_IRUGO,
 			batadv_transtable_local_open);
 static BATADV_DEBUGINFO(vis_data, S_IRUGO, batadv_vis_data_open);
+#ifdef CONFIG_BATMAN_ADV_NC
+static BATADV_DEBUGINFO(nc_nodes, S_IRUGO, batadv_nc_nodes_open);
+#endif
 
 static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_originators,
@@ -362,6 +374,9 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 #endif
 	&batadv_debuginfo_transtable_local,
 	&batadv_debuginfo_vis_data,
+#ifdef CONFIG_BATMAN_ADV_NC
+	&batadv_debuginfo_nc_nodes,
+#endif
 	NULL,
 };
 
@@ -431,6 +446,9 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 		}
 	}
 
+	if (batadv_nc_init_debugfs(bat_priv) < 0)
+		goto rem_attr;
+
 	return 0;
 rem_attr:
 	debugfs_remove_recursive(bat_priv->debug_dir);
diff --git a/main.h b/main.h
index bf70aed..4e81d93 100644
--- a/main.h
+++ b/main.h
@@ -105,6 +105,8 @@
 #define BATADV_RESET_PROTECTION_MS 30000
 #define BATADV_EXPECTED_SEQNO_RANGE	65536
 
+#define BATADV_NC_NODE_TIMEOUT 10000 /* Milliseconds */
+
 enum batadv_mesh_state {
 	BATADV_MESH_INACTIVE,
 	BATADV_MESH_ACTIVE,
diff --git a/network-coding.c b/network-coding.c
index 9c2d54b..0be0c75 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -17,8 +17,12 @@
  * 02110-1301, USA
  */
 
+#include <linux/debugfs.h>
+
 #include "main.h"
 #include "network-coding.h"
+#include "originator.h"
+#include "hard-interface.h"
 
 static void batadv_nc_worker(struct work_struct *work);
 
@@ -51,6 +55,152 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
 	atomic_set(&bat_priv->network_coding, 1);
+	bat_priv->nc.min_tq = 200;
+}
+
+/**
+ * batadv_nc_init_orig - initialise the nc fields of an orig_node
+ * @orig_node: the orig_node which is going to be initialised
+ */
+void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
+{
+	INIT_LIST_HEAD(&orig_node->in_coding_list);
+	INIT_LIST_HEAD(&orig_node->out_coding_list);
+	spin_lock_init(&orig_node->in_coding_list_lock);
+	spin_lock_init(&orig_node->out_coding_list_lock);
+}
+
+/**
+ * batadv_nc_node_free_rcu - rcu callback to free an nc node and remove
+ *  its refcount on the orig_node
+ * @rcu: rcu pointer of the nc node
+ */
+static void batadv_nc_node_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_nc_node *nc_node;
+
+	nc_node = container_of(rcu, struct batadv_nc_node, rcu);
+	batadv_orig_node_free_ref(nc_node->orig_node);
+	kfree(nc_node);
+}
+
+/**
+ * batadv_nc_node_free_ref - decrements the nc node refcounter and possibly
+ * frees it
+ * @nc_node: the nc node to free
+ */
+static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
+{
+	if (atomic_dec_and_test(&nc_node->refcount))
+		call_rcu(&nc_node->rcu, batadv_nc_node_free_rcu);
+}
+
+/**
+ * batadv_nc_to_purge_nc_node - checks whether an nc node has to be purged
+ * @bat_priv: the bat priv with all the soft interface information
+ * @nc_node: the nc node to check
+ *
+ * Returns true if the entry has to be purged now, false otherwise
+ */
+static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
+				       struct batadv_nc_node *nc_node)
+{
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		return true;
+
+	return batadv_has_timed_out(nc_node->last_seen, BATADV_NC_NODE_TIMEOUT);
+}
+
+/**
+ * batadv_nc_purge_orig_nc_nodes - go through list of nc nodes and purge stale
+ *  entries
+ * @bat_priv: the bat priv with all the soft interface information
+ * @list: list of nc nodes
+ * @lock: nc node list lock
+ * @to_purge: function in charge to decide whether an entry has to be purged or
+ *	      not. This function takes the nc node as argument and has to return
+ *	      a boolean value: true if the entry has to be deleted, false
+ *	      otherwise
+ */
+static void
+batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
+			      struct list_head *list,
+			      spinlock_t *lock,
+			      bool (*to_purge)(struct batadv_priv *,
+					       struct batadv_nc_node *))
+{
+	struct batadv_nc_node *nc_node, *nc_node_tmp;
+
+	/* For each nc_node in list */
+	spin_lock_bh(lock);
+	list_for_each_entry_safe(nc_node, nc_node_tmp, list, list) {
+		/* if an helper function has been passed as parameter,
+		 * ask it if the entry has to be purged or not
+		 */
+		if (to_purge && !to_purge(bat_priv, nc_node))
+			continue;
+
+		batadv_dbg(BATADV_DBG_NC, bat_priv,
+			   "Removing nc_node %pM -> %pM\n",
+			   nc_node->addr, nc_node->orig_node->orig);
+		list_del_rcu(&nc_node->list);
+		batadv_nc_node_free_ref(nc_node);
+	}
+	spin_unlock_bh(lock);
+}
+
+/**
+ * batadv_nc_purge_orig - purges all nc node data attached of the given
+ *  originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig_node with the nc node entries to be purged
+ * @to_purge: function in charge to decide whether an entry has to be purged or
+ *	      not. This function takes the nc node as argument and has to return
+ *	      a boolean value: true is the entry has to be deleted, false
+ *	      otherwise
+ */
+void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
+			  struct batadv_orig_node *orig_node,
+			  bool (*to_purge)(struct batadv_priv *,
+					   struct batadv_nc_node *))
+{
+	/* Check ingoing nc_node's of this orig_node */
+	batadv_nc_purge_orig_nc_nodes(bat_priv, &orig_node->in_coding_list,
+				      &orig_node->in_coding_list_lock,
+				      to_purge);
+
+	/* Check outgoing nc_node's of this orig_node */
+	batadv_nc_purge_orig_nc_nodes(bat_priv, &orig_node->out_coding_list,
+				      &orig_node->out_coding_list_lock,
+				      to_purge);
+}
+
+/**
+ * batadv_nc_purge_orig_hash - traverse entire originator hash to check if they
+ *  have timed out nc nodes
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
+{
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct batadv_orig_node *orig_node;
+	uint32_t i;
+
+	if (!hash)
+		return;
+
+	/* For each orig_node */
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry)
+			batadv_nc_purge_orig(bat_priv, orig_node,
+					     batadv_nc_to_purge_nc_node);
+		rcu_read_unlock();
+	}
 }
 
 /**
@@ -67,11 +217,197 @@ static void batadv_nc_worker(struct work_struct *work)
 	priv_nc = container_of(delayed_work, struct batadv_priv_nc, work);
 	bat_priv = container_of(priv_nc, struct batadv_priv, nc);
 
+	batadv_nc_purge_orig_hash(bat_priv);
+
 	/* Schedule a new check */
 	batadv_nc_start_timer(bat_priv);
 }
 
 /**
+ * batadv_can_nc_with_orig - checks whether the given orig node is suitable for
+ *  coding or not
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: neighboring orig node which may be used as nc candidate
+ * @ogm_packet: incoming ogm packet also used for the checks
+ *
+ * Returns true if:
+ *  1) The OGM must have the most recent sequence number.
+ *  2) The TTL must be decremented by one and only one.
+ *  3) The OGM must be received from the first hop from orig_node.
+ *  4) The TQ value of the OGM must be above bat_priv->nc.min_tq.
+ */
+static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
+				    struct batadv_orig_node *orig_node,
+				    struct batadv_ogm_packet *ogm_packet)
+{
+	if (orig_node->last_real_seqno != ogm_packet->seqno)
+		return false;
+	if (orig_node->last_ttl != ogm_packet->header.ttl + 1)
+		return false;
+	if (!batadv_compare_eth(ogm_packet->orig, ogm_packet->prev_sender))
+		return false;
+	if (ogm_packet->tq < bat_priv->nc.min_tq)
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_nc_find_nc_node - search for an existing nc node and return it
+ * @orig_node: orig node originating the ogm packet
+ * @orig_neigh_node: neighboring orig node from which we received the ogm packet
+ *  (can be equal to orig_node)
+ * @in_coding: traverse incoming or outgoing network coding list
+ *
+ * Returns the nc_node if found, NULL otherwise.
+ */
+static struct batadv_nc_node
+*batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
+			struct batadv_orig_node *orig_neigh_node,
+			bool in_coding)
+{
+	struct batadv_nc_node *nc_node, *nc_node_out = NULL;
+	struct list_head *list;
+
+	if (in_coding)
+		list = &orig_neigh_node->in_coding_list;
+	else
+		list = &orig_neigh_node->out_coding_list;
+
+	/* Traverse list of nc_nodes to orig_node */
+	rcu_read_lock();
+	list_for_each_entry_rcu(nc_node, list, list) {
+		if (!batadv_compare_eth(nc_node->addr, orig_node->orig))
+			continue;
+
+		if (!atomic_inc_not_zero(&nc_node->refcount))
+			continue;
+
+		/* Found a match */
+		nc_node_out = nc_node;
+		break;
+	}
+	rcu_read_unlock();
+
+	return nc_node_out;
+}
+
+/**
+ * batadv_nc_get_nc_node - retrieves an nc node or creates the entry if it was
+ *  not found
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node originating the ogm packet
+ * @orig_neigh_node: neighboring orig node from which we received the ogm packet
+ *  (can be equal to orig_node)
+ * @in_coding: traverse incoming or outgoing network coding list
+ *
+ * Returns the nc_node if found or created, NULL in case of an error.
+ */
+static struct batadv_nc_node
+*batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
+		       struct batadv_orig_node *orig_node,
+		       struct batadv_orig_node *orig_neigh_node,
+		       bool in_coding)
+{
+	struct batadv_nc_node *nc_node;
+	spinlock_t *lock; /* Used to lock list selected by "int in_coding" */
+	struct list_head *list;
+
+	/* Check if nc_node is already added */
+	nc_node = batadv_nc_find_nc_node(orig_node, orig_neigh_node, in_coding);
+
+	/* Node found */
+	if (nc_node)
+		return nc_node;
+
+	nc_node = kzalloc(sizeof(*nc_node), GFP_ATOMIC);
+	if (!nc_node)
+		return NULL;
+
+	if (!atomic_inc_not_zero(&orig_neigh_node->refcount))
+		goto free;
+
+	/* Initialize nc_node */
+	INIT_LIST_HEAD(&nc_node->list);
+	memcpy(nc_node->addr, orig_node->orig, ETH_ALEN);
+	nc_node->orig_node = orig_neigh_node;
+	atomic_set(&nc_node->refcount, 2);
+
+	/* Select ingoing or outgoing coding node */
+	if (in_coding) {
+		lock = &orig_neigh_node->in_coding_list_lock;
+		list = &orig_neigh_node->in_coding_list;
+	} else {
+		lock = &orig_neigh_node->out_coding_list_lock;
+		list = &orig_neigh_node->out_coding_list;
+	}
+
+	batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_node %pM -> %pM\n",
+		   nc_node->addr, nc_node->orig_node->orig);
+
+	/* Add nc_node to orig_node */
+	spin_lock_bh(lock);
+	list_add_tail_rcu(&nc_node->list, list);
+	spin_unlock_bh(lock);
+
+	return nc_node;
+
+free:
+	kfree(nc_node);
+	return NULL;
+}
+
+/**
+ * batadv_nc_update_nc_node - updates stored incoming and outgoing nc node structs
+ *  (best called on incoming OGMs)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node originating the ogm packet
+ * @orig_neigh_node: neighboring orig node from which we received the ogm packet
+ *  (can be equal to orig_node)
+ * @ogm_packet: incoming ogm packet
+ * @is_single_hop_neigh: orig_node is a single hop neighbor
+ */
+void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
+			      struct batadv_orig_node *orig_node,
+			      struct batadv_orig_node *orig_neigh_node,
+			      struct batadv_ogm_packet *ogm_packet,
+			      int is_single_hop_neigh)
+{
+	struct batadv_nc_node *in_nc_node = NULL, *out_nc_node = NULL;
+
+	/* Check if network coding is enabled */
+	if (!atomic_read(&bat_priv->network_coding))
+		goto out;
+
+	/* accept ogms from 'good' neighbors and single hop neighbors */
+	if (!batadv_can_nc_with_orig(bat_priv, orig_node, ogm_packet) &&
+	    !is_single_hop_neigh)
+		goto out;
+
+	/* Add orig_node as in_nc_node on hop */
+	in_nc_node = batadv_nc_get_nc_node(bat_priv, orig_node,
+					   orig_neigh_node, true);
+	if (!in_nc_node)
+		goto out;
+
+	in_nc_node->last_seen = jiffies;
+
+	/* Add hop as out_nc_node on orig_node */
+	out_nc_node = batadv_nc_get_nc_node(bat_priv, orig_neigh_node,
+					    orig_node, false);
+	if (!out_nc_node)
+		goto out;
+
+	out_nc_node->last_seen = jiffies;
+
+out:
+	if (in_nc_node)
+		batadv_nc_node_free_ref(in_nc_node);
+	if (out_nc_node)
+		batadv_nc_node_free_ref(out_nc_node);
+}
+
+/**
  * batadv_nc_free - clean up network coding memory
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -79,3 +415,83 @@ void batadv_nc_free(struct batadv_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 }
+
+/**
+ * batadv_nc_nodes_seq_print_text - print the nc node information
+ * @seq: seq file to print on
+ * @offset: not used
+ */
+int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hard_iface *primary_if;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct batadv_orig_node *orig_node;
+	struct batadv_nc_node *nc_node;
+	int i;
+
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
+		goto out;
+
+	/* Traverse list of originators */
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		/* For each orig_node in this bin */
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
+			seq_printf(seq, "Node:      %pM\n", orig_node->orig);
+
+			seq_printf(seq, " Ingoing:  ");
+			/* For each in_nc_node to this orig_node */
+			list_for_each_entry_rcu(nc_node,
+						&orig_node->in_coding_list,
+						list)
+				seq_printf(seq, "%pM ",
+					   nc_node->addr);
+			seq_printf(seq, "\n");
+
+			seq_printf(seq, " Outgoing: ");
+			/* For out_nc_node to this orig_node */
+			list_for_each_entry_rcu(nc_node,
+						&orig_node->out_coding_list,
+						list)
+				seq_printf(seq, "%pM ",
+					   nc_node->addr);
+			seq_printf(seq, "\n\n");
+		}
+		rcu_read_unlock();
+	}
+
+out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	return 0;
+}
+
+/**
+ * batadv_nc_init_debugfs - create nc folder and related files in debugfs
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
+{
+	struct dentry *nc_dir, *file;
+
+	nc_dir = debugfs_create_dir("nc", bat_priv->debug_dir);
+	if (!nc_dir)
+		goto out;
+
+	file = debugfs_create_u8("min_tq", S_IRUGO | S_IWUSR, nc_dir,
+				 &bat_priv->nc.min_tq);
+	if (!file)
+		goto out;
+
+	return 0;
+
+out:
+	return -ENOMEM;
+}
diff --git a/network-coding.h b/network-coding.h
index 8ee4046..55e5a7b 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -24,7 +24,19 @@
 
 int batadv_nc_init(struct batadv_priv *bat_priv);
 void batadv_nc_free(struct batadv_priv *bat_priv);
+void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
+			      struct batadv_orig_node *orig_node,
+			      struct batadv_orig_node *orig_neigh_node,
+			      struct batadv_ogm_packet *ogm_packet,
+			      int is_single_hop_neigh);
+void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
+			  struct batadv_orig_node *orig_node,
+			  bool (*to_purge)(struct batadv_priv *,
+					   struct batadv_nc_node *));
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
+void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
+int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
 #else /* ifdef CONFIG_BATMAN_ADV_NC */
 
@@ -38,11 +50,46 @@ static inline void batadv_nc_free(struct batadv_priv *bat_priv)
 	return;
 }
 
+static inline void
+batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node,
+			 struct batadv_orig_node *orig_neigh_node,
+			 struct batadv_ogm_packet *ogm_packet,
+			 int is_single_hop_neigh)
+{
+	return;
+}
+
+static inline void
+batadv_nc_purge_orig(struct batadv_priv *bat_priv,
+		     struct batadv_orig_node *orig_node,
+		     bool (*to_purge)(struct batadv_priv *,
+				      struct batadv_nc_node *))
+{
+	return;
+}
+
 static inline void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
 	return;
 }
 
+static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
+{
+	return;
+}
+
+static inline int batadv_nc_nodes_seq_print_text(struct seq_file *seq,
+						 void *offset)
+{
+	return 0;
+}
+
+static inline int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_NC */
 
 #endif /* _NET_BATMAN_ADV_NETWORK_CODING_H */
diff --git a/originator.c b/originator.c
index 457ea44..9bedd50 100644
--- a/originator.c
+++ b/originator.c
@@ -28,6 +28,7 @@
 #include "unicast.h"
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
+#include "network-coding.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
@@ -142,6 +143,9 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	/* Free nc_nodes */
+	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
+
 	batadv_frag_list_free(&orig_node->frag_list);
 	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
 				  "originator timed out");
@@ -219,6 +223,8 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
 
+	batadv_nc_init_orig(orig_node);
+
 	/* extra reference for return */
 	atomic_set(&orig_node->refcount, 2);
 
diff --git a/types.h b/types.h
index 20de752..fd15bf6 100644
--- a/types.h
+++ b/types.h
@@ -128,6 +128,10 @@ struct batadv_hard_iface {
  * @bond_list: list of bonding candidates
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
+ * @in_coding_list: list of nodes this orig can hear
+ * @out_coding_list: list of nodes that can hear this orig
+ * @in_coding_list_lock: protects in_coding_list
+ * @out_coding_list_lock: protects out_coding_list
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
@@ -171,6 +175,12 @@ struct batadv_orig_node {
 	struct list_head bond_list;
 	atomic_t refcount;
 	struct rcu_head rcu;
+#ifdef CONFIG_BATMAN_ADV_NC
+	struct list_head in_coding_list;
+	struct list_head out_coding_list;
+	spinlock_t in_coding_list_lock; /* Protects in_coding_list */
+	spinlock_t out_coding_list_lock; /* Protects out_coding_list */
+#endif
 };
 
 /**
@@ -430,9 +440,12 @@ struct batadv_priv_dat {
 /**
  * struct batadv_priv_nc - per mesh interface network coding private data
  * @work: work queue callback item for cleanup
+ * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
  */
 struct batadv_priv_nc {
 	struct delayed_work work;
+	struct dentry *debug_dir;
+	u8 min_tq;
 };
 
 /**
@@ -716,6 +729,24 @@ struct batadv_tt_roam_node {
 };
 
 /**
+ * struct batadv_nc_node - network coding node
+ * @list: next and prev pointer for the list handling
+ * @addr: the node's mac address
+ * @refcount: number of contexts the object is used by
+ * @rcu: struct used for freeing in an RCU-safe manner
+ * @orig_node: pointer to corresponding orig node struct
+ * @last_seen: timestamp of last ogm received from this node
+ */
+struct batadv_nc_node {
+	struct list_head list;
+	uint8_t addr[ETH_ALEN];
+	atomic_t refcount;
+	struct rcu_head rcu;
+	struct batadv_orig_node *orig_node;
+	unsigned long last_seen;
+};
+
+/**
  * struct batadv_forw_packet - structure for bcast packets to be sent/forwarded
  * @list: list node for batadv_socket_client::queue_list
  * @send_time: execution time for delayed_work (packet sending)
-- 
1.8.1.1

