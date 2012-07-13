Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Jul 2012 01:41:46 +0200
Message-Id: <1342222910-20627-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1342222910-20627-1-git-send-email-ordex@autistici.org>
References: <1342222910-20627-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv9 4/8] batman-adv: Distributed ARP Table -
	implement local storage
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

Since batman-adv cannot inter-operate with the host ARP table, this patch
introduces a batman-adv private storage for ARP entries exchanged within DAT.
This storage will represent the node local cache in the DAT protocol.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.c                |    8 ++
 compat.h                |    1 +
 debugfs.c               |   10 ++
 distributed-arp-table.c |  340 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |    4 +
 main.c                  |    7 +
 main.h                  |    1 +
 types.h                 |   15 +++
 8 files changed, 386 insertions(+)

diff --git a/compat.c b/compat.c
index 6114f72..21f23fe 100644
--- a/compat.c
+++ b/compat.c
@@ -64,4 +64,12 @@ void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
 }
 #endif
 
+void batadv_free_rcu_dat_entry(struct rcu_head *rcu)
+{
+	struct batadv_dat_entry *dat_entry;
+
+	dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
+	kfree(dat_entry);
+}
+
 #endif /* < KERNEL_VERSION(3, 0, 0) */
diff --git a/compat.h b/compat.h
index 13253dd..9a210e0 100644
--- a/compat.h
+++ b/compat.h
@@ -144,6 +144,7 @@ void batadv_free_rcu_gw_node(struct rcu_head *rcu);
 void batadv_free_rcu_neigh_node(struct rcu_head *rcu);
 void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu);
 void batadv_free_rcu_backbone_gw(struct rcu_head *rcu);
+void batadv_free_rcu_dat_entry(struct rcu_head *rcu);
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
diff --git a/debugfs.c b/debugfs.c
index 391d4fb..f7cf001 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -31,6 +31,7 @@
 #include "vis.h"
 #include "icmp_socket.h"
 #include "bridge_loop_avoidance.h"
+#include "distributed-arp-table.h"
 
 static struct dentry *batadv_debugfs;
 
@@ -278,6 +279,13 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 
 #endif
 
+static int batadv_dat_cache_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, batadv_dat_cache_seq_print_text, net_dev);
+}
+
+
 static int batadv_transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -317,6 +325,7 @@ static BATADV_DEBUGINFO(bla_claim_table, S_IRUGO, batadv_bla_claim_table_open);
 static BATADV_DEBUGINFO(bla_backbone_table, S_IRUGO,
 			batadv_bla_backbone_table_open);
 #endif
+static BATADV_DEBUGINFO(dat_cache, S_IRUGO, batadv_dat_cache_open);
 static BATADV_DEBUGINFO(transtable_local, S_IRUGO,
 			batadv_transtable_local_open);
 static BATADV_DEBUGINFO(vis_data, S_IRUGO, batadv_vis_data_open);
@@ -329,6 +338,7 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_bla_claim_table,
 	&batadv_debuginfo_bla_backbone_table,
 #endif
+	&batadv_debuginfo_dat_cache,
 	&batadv_debuginfo_transtable_local,
 	&batadv_debuginfo_vis_data,
 	NULL,
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 64beacf..939a181 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -28,6 +28,93 @@
 #include "types.h"
 #include "unicast.h"
 
+static void batadv_dat_purge(struct work_struct *work);
+
+/**
+ * batadv_dat_start_timer - initialise the DAT periodic worker
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
+{
+	INIT_DELAYED_WORK(&bat_priv->dat_work, batadv_dat_purge);
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat_work,
+			   msecs_to_jiffies(10000));
+}
+
+/**
+ * batadv_dat_entry_free_ref - decrements the dat_entry refcounter and possibly
+ * free it
+ *
+ * @dat_entry: the oentry to free
+ */
+static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
+{
+	if (atomic_dec_and_test(&dat_entry->refcount))
+		kfree_rcu(dat_entry, rcu);
+}
+
+/**
+ * batadv_dat_purge - periodic task that deletes old entry from the local cache
+ *
+ * @work: kernel work struct
+ */
+static void batadv_dat_purge(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_priv *bat_priv;
+	struct batadv_hashtable *hash;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct batadv_dat_entry *dat_entry;
+	struct hlist_node *node, *node_tmp;
+	struct hlist_head *head;
+	uint32_t i;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	bat_priv = container_of(delayed_work, struct batadv_priv, dat_work);
+
+	if (!bat_priv->dat_hash)
+		goto out;
+
+	hash = bat_priv->dat_hash;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(dat_entry, node, node_tmp, head,
+					  hash_entry) {
+			if (!batadv_has_timed_out(dat_entry->last_update,
+						  BATADV_DAT_ENTRY_TIMEOUT))
+				continue;
+
+			hlist_del_rcu(node);
+			batadv_dat_entry_free_ref(dat_entry);
+		}
+		spin_unlock_bh(list_lock);
+	}
+
+out:
+	batadv_dat_start_timer(bat_priv);
+}
+
+/**
+ * batadv_compare_dat - comparing function used in the local DAT storage
+ *
+ * @node: node in the local table
+ * @data2: second object to compare the node to
+ *
+ * Returns 1 if the two entry are the same, 0 otherwise
+ */
+static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
+{
+	const void *data1 = container_of(node, struct batadv_dat_entry,
+					 hash_entry);
+
+	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+}
+
 /**
  * batadv_hash_dat_global - compute the hash value for the global DAT cache
  *
@@ -56,6 +143,128 @@ static uint32_t batadv_hash_dat_global(const void *data, uint32_t size)
 }
 
 /**
+ * batadv_hash_dat_local - hash function for the local DAT storage.
+ * In order to populate our local DAT storage, we have to use a different hash
+ * function than the one used to "globally assign" the ARP entries to orig
+ * nodes. This is needed because the values computed by the global hash function
+ * on the entries stored on the same node are likely close to each other
+ *
+ * @data: data to hash
+ * @size: size of the hash table
+ *
+ * Returns the selected index in the hash table for the given data
+ */
+static uint32_t batadv_hash_dat_local(const void *data, uint32_t size)
+{
+	const unsigned char *key = data;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 4; i > 0; i--) {
+		hash += key[i - 1];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
+/**
+ * batadv_dat_entry_hash_find - looks for a given dat_entry in the local storage
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: search key
+ *
+ * Returns the dat_entry if found, NULL otherwise
+ */
+static struct batadv_dat_entry *
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
+{
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct batadv_dat_entry *dat_entry, *dat_entry_tmp = NULL;
+	struct batadv_hashtable *hash = bat_priv->dat_hash;
+	uint32_t index;
+
+	if (!hash)
+		return NULL;
+
+	index = batadv_hash_dat_local(&ip, hash->size);
+	head = &hash->table[index];
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(dat_entry, node, head, hash_entry) {
+		if (dat_entry->ip != ip)
+			continue;
+
+		if (!atomic_inc_not_zero(&dat_entry->refcount))
+			continue;
+
+		dat_entry_tmp = dat_entry;
+		break;
+	}
+	rcu_read_unlock();
+
+	return dat_entry_tmp;
+}
+
+/**
+ * batadv_dat_entry_add - add a new dat entry or update it if already exists
+ *
+ * @ip: ipv4 to add/edit
+ * @mac_addr: mac address to assign to the given ipv4
+ */
+static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
+				 uint8_t *mac_addr)
+{
+	struct batadv_dat_entry *dat_entry;
+	int hash_added;
+
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
+	/* if this entry is already known, we simply refresh it */
+	if (dat_entry) {
+		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
+			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
+		dat_entry->last_update = jiffies;
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "Update entry: %pI4 %pM\n", &dat_entry->ip,
+			   dat_entry->mac_addr);
+		goto out;
+	}
+
+	dat_entry = kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
+	if (!dat_entry)
+		goto out;
+
+	dat_entry->ip = ip;
+	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
+	dat_entry->last_update = jiffies;
+	atomic_set(&dat_entry->refcount, 2);
+
+	hash_added = batadv_hash_add(bat_priv->dat_hash, batadv_compare_dat,
+				     batadv_hash_dat_local,
+				     &dat_entry->ip,
+				     &dat_entry->hash_entry);
+
+	if (unlikely(hash_added != 0)) {
+		/* remove the reference for the hash */
+		batadv_dat_entry_free_ref(dat_entry);
+		goto out;
+	}
+
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "Addin new entry: %pI4 %pM\n",
+		   &dat_entry->ip, dat_entry->mac_addr);
+
+out:
+	if (dat_entry)
+		batadv_dat_entry_free_ref(dat_entry);
+}
+
+/**
  * batadv_is_orig_node_eligible - check whether a node can be a DHT candidate
  *
  * @res: the array with the already selected candidates
@@ -270,3 +479,134 @@ out:
 	kfree(cand);
 	return ret;
 }
+
+/**
+ * batadv_dat_hash_free - free the local DAT storage
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
+{
+	struct batadv_hashtable *hash;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct batadv_dat_entry *dat_entry;
+	struct hlist_node *node, *node_tmp;
+	struct hlist_head *head;
+	uint32_t i;
+
+	if (!bat_priv->dat_hash)
+		return;
+
+	hash = bat_priv->dat_hash;
+
+	bat_priv->dat_hash = NULL;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(dat_entry, node, node_tmp, head,
+					  hash_entry) {
+			hlist_del_rcu(node);
+			batadv_dat_entry_free_ref(dat_entry);
+		}
+		spin_unlock_bh(list_lock);
+	}
+
+	batadv_hash_destroy(hash);
+}
+
+/**
+ * batadv_dat_init - initialise the DAT internals
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+int batadv_dat_init(struct batadv_priv *bat_priv)
+{
+	if (bat_priv->dat_hash)
+		return 0;
+
+	bat_priv->dat_hash = batadv_hash_new(1024);
+
+	if (!bat_priv->dat_hash)
+		return -ENOMEM;
+
+	batadv_dat_start_timer(bat_priv);
+
+	return 0;
+}
+
+/**
+ * batadv_dat_free - free the DAT internals
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_dat_free(struct batadv_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->dat_work);
+
+	batadv_dat_hash_free(bat_priv);
+}
+
+/**
+ * batadv_dat_cache_seq_print_text - print the local DAT storage
+ *
+ * @seq: seq file to print on
+ * @offset: not used
+ */
+int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hashtable *hash = bat_priv->dat_hash;
+	struct batadv_dat_entry *dat_entry;
+	struct batadv_hard_iface *primary_if;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	unsigned long last_seen_jiffies;
+	int last_seen_msecs, last_seen_secs, last_seen_mins;
+	uint32_t i;
+	int ret = 0;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if) {
+		ret = seq_printf(seq,
+				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = seq_printf(seq,
+				 "BATMAN mesh %s disabled - primary interface not active\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	seq_printf(seq, "Distributed ARP Table (local storage for %s):\n",
+		   net_dev->name);
+	seq_printf(seq, "          %-7s          %-13s %5s\n",
+		   "IPv4", "MAC", "last-seen");
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(dat_entry, node, head, hash_entry) {
+			last_seen_jiffies = jiffies - dat_entry->last_update;
+			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+			last_seen_mins = last_seen_msecs / 60000;
+			last_seen_msecs = last_seen_msecs % 60000;
+			last_seen_secs = last_seen_msecs / 1000;
+
+			seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
+				   &dat_entry->ip, dat_entry->mac_addr,
+				   last_seen_mins, last_seen_secs);
+		}
+		rcu_read_unlock();
+	}
+out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	return ret;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 8d26c90..0014583 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -46,4 +46,8 @@ batadv_dat_init_own_dht_addr(struct batadv_priv *bat_priv,
 	bat_priv->dht_addr = (batadv_dat_addr_t)addr;
 }
 
+int batadv_dat_init(struct batadv_priv *bat_priv);
+void batadv_dat_free(struct batadv_priv *bat_priv);
+int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
+
 #endif /* _NET_BATMAN_ADV_ARP_H_ */
diff --git a/main.c b/main.c
index ad0d2fe..fc15919 100644
--- a/main.c
+++ b/main.c
@@ -29,6 +29,7 @@
 #include "hard-interface.h"
 #include "gateway_client.h"
 #include "bridge_loop_avoidance.h"
+#include "distributed-arp-table.h"
 #include "vis.h"
 #include "hash.h"
 #include "bat_algo.h"
@@ -128,6 +129,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
+	ret = batadv_dat_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	atomic_set(&bat_priv->gw_reselect, 0);
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
@@ -155,6 +160,8 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_bla_free(bat_priv);
 
+	batadv_dat_free(bat_priv);
+
 	free_percpu(bat_priv->bat_counters);
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
diff --git a/main.h b/main.h
index 076dbc5..d5aebcb 100644
--- a/main.h
+++ b/main.h
@@ -44,6 +44,7 @@
 #define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in milliseconds */
 #define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in milliseconds */
 #define BATADV_TT_CLIENT_TEMP_TIMEOUT 600000 /* in milliseconds */
+#define BATADV_DAT_ENTRY_TIMEOUT (5*60000) /* 5 mins in milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
diff --git a/types.h b/types.h
index f9de55a..e826a7b 100644
--- a/types.h
+++ b/types.h
@@ -218,6 +218,7 @@ struct batadv_priv {
 	struct batadv_hashtable *claim_hash;
 	struct batadv_hashtable *backbone_hash;
 #endif
+	struct batadv_hashtable *dat_hash;
 	struct list_head tt_req_list; /* list of pending tt_requests */
 	struct list_head tt_roam_list;
 	struct batadv_hashtable *vis_hash;
@@ -244,12 +245,14 @@ struct batadv_priv {
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
 	struct delayed_work bla_work;
+	struct delayed_work dat_work;
 	struct batadv_gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_vis_info *my_vis_info;
 	struct batadv_algo_ops *bat_algo_ops;
 	batadv_dat_addr_t dht_addr;
+
 };
 
 struct batadv_socket_client {
@@ -422,6 +425,18 @@ struct batadv_algo_ops {
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 };
 
+/* struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
+ * is used to stored ARP entries used to implement the global DAT cache
+ */
+struct batadv_dat_entry {
+	__be32 ip;
+	uint8_t mac_addr[ETH_ALEN];
+	unsigned long last_update;
+	struct hlist_node hash_entry;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
 struct batadv_dht_candidate {
 	int type;
 	struct batadv_orig_node *orig_node;
-- 
1.7.9.4

