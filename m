Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:24 +0100
Message-Id: <20171220110124.13117-20-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/19] batman-adv: Add kernel-doc to
 externally visible functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

According to the kernel-doc documentation, externally visible functions
should be documented. This refers to all all non-static function which can
(and will) be used by functions in other sources files.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_algo.c          | 27 ++++++++++++++++++++++++
 net/batman-adv/bat_iv_ogm.c        |  5 +++++
 net/batman-adv/debugfs.c           | 16 ++++++++++++++
 net/batman-adv/gateway_client.c    | 38 +++++++++++++++++++++++++++++++++
 net/batman-adv/gateway_common.c    |  9 ++++++++
 net/batman-adv/hard-interface.c    | 36 ++++++++++++++++++++++++++++++-
 net/batman-adv/hash.c              | 17 +++++++++++++--
 net/batman-adv/icmp_socket.c       |  9 ++++++++
 net/batman-adv/log.c               | 17 +++++++++++++++
 net/batman-adv/main.c              | 31 +++++++++++++++++++++++++++
 net/batman-adv/originator.c        | 43 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/routing.c           | 29 +++++++++++++++++++++++++
 net/batman-adv/send.c              | 18 ++++++++++++++++
 net/batman-adv/soft-interface.c    | 20 ++++++++++++++++++
 net/batman-adv/sysfs.c             | 32 ++++++++++++++++++++++++++++
 net/batman-adv/translation-table.c | 37 ++++++++++++++++++++++++++++++++
 16 files changed, 381 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index aed7ced059df..80c72c7d3cad 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -61,6 +61,12 @@ static struct batadv_algo_ops *batadv_algo_get(char *name)
 	return bat_algo_ops;
 }
 
+/**
+ * batadv_algo_register() - Register callbacks for a mesh algorithm
+ * @bat_algo_ops: mesh algorithm callbacks to add
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 {
 	struct batadv_algo_ops *bat_algo_ops_tmp;
@@ -90,6 +96,19 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	return 0;
 }
 
+/**
+ * batadv_algo_select() - Select algorithm of soft interface
+ * @bat_priv: the bat priv with all the soft interface information
+ * @name: name of the algorithm to select
+ *
+ * The algorithm callbacks for the soft interface will be set when the algorithm
+ * with the correct name was found. Any previous selected algorithm will not be
+ * deinitialized and the new selected algorithm will also not be initialized.
+ * It is therefore not allowed to call batadv_algo_select outside the creation
+ * function of the soft interface.
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
 {
 	struct batadv_algo_ops *bat_algo_ops;
@@ -104,6 +123,14 @@ int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+
+/**
+ * batadv_algo_seq_print_text() - Print the supported algorithms in a seq file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 0973e8c5a063..c9955f29a2bf 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2853,6 +2853,11 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	},
 };
 
+/**
+ * batadv_iv_init() - B.A.T.M.A.N. IV initialization function
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int __init batadv_iv_init(void)
 {
 	int ret;
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 97d6eb45cbf2..21d1189957a7 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -259,6 +259,9 @@ static struct batadv_debuginfo *batadv_hardif_debuginfos[] = {
 	NULL,
 };
 
+/**
+ * batadv_debugfs_init() - Initialize soft interface independent debugfs entries
+ */
 void batadv_debugfs_init(void)
 {
 	struct batadv_debuginfo **bat_debug;
@@ -289,6 +292,9 @@ void batadv_debugfs_init(void)
 	batadv_debugfs = NULL;
 }
 
+/**
+ * batadv_debugfs_destroy() - Remove all debugfs entries
+ */
 void batadv_debugfs_destroy(void)
 {
 	debugfs_remove_recursive(batadv_debugfs);
@@ -355,6 +361,12 @@ void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 	}
 }
 
+/**
+ * batadv_debugfs_add_meshif() - Initialize interface dependent debugfs entries
+ * @dev: netdev struct of the soft interface
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
@@ -401,6 +413,10 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 	return -ENOMEM;
 }
 
+/**
+ * batadv_debugfs_del_meshif() - Remove interface dependent debugfs entries
+ * @dev: netdev struct of the soft interface
+ */
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 6731f7dabeb9..2488e25d0eef 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -93,6 +93,12 @@ void batadv_gw_node_put(struct batadv_gw_node *gw_node)
 	kref_put(&gw_node->refcount, batadv_gw_node_release);
 }
 
+/**
+ * batadv_gw_get_selected_gw_node() - Get currently selected gateway
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: selected gateway (with increased refcnt), NULL on errors
+ */
 struct batadv_gw_node *
 batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
 {
@@ -111,6 +117,12 @@ batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
 	return gw_node;
 }
 
+/**
+ * batadv_gw_get_selected_orig() - Get originator of currently selected gateway
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: orig_node of selected gateway (with increased refcnt), NULL on errors
+ */
 struct batadv_orig_node *
 batadv_gw_get_selected_orig(struct batadv_priv *bat_priv)
 {
@@ -204,6 +216,10 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 	batadv_gw_node_put(curr_gw);
 }
 
+/**
+ * batadv_gw_election() - Elect the best gateway
+ * @bat_priv: the bat priv with all the soft interface information
+ */
 void batadv_gw_election(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw = NULL;
@@ -292,6 +308,11 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 		batadv_neigh_ifinfo_put(router_ifinfo);
 }
 
+/**
+ * batadv_gw_check_election() - Elect orig node as best gateway when eligible
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be checked
+ */
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
 			      struct batadv_orig_node *orig_node)
 {
@@ -460,6 +481,11 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		batadv_gw_node_put(gw_node);
 }
 
+/**
+ * batadv_gw_node_delete() - Remove orig_node from gateway list
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is currently in process of being removed
+ */
 void batadv_gw_node_delete(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node)
 {
@@ -471,6 +497,10 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
 	batadv_gw_node_update(bat_priv, orig_node, &gateway);
 }
 
+/**
+ * batadv_gw_node_free() - Free gateway information from soft interface
+ * @bat_priv: the bat priv with all the soft interface information
+ */
 void batadv_gw_node_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *gw_node;
@@ -486,6 +516,14 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+
+/**
+ * batadv_gw_client_seq_print_text() - Print the gateway table in a seq file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 1c58727835ca..83bfeecf661c 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -165,6 +165,15 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 }
 
+/**
+ * batadv_gw_bandwidth_set() - Parse and set download/upload gateway bandwidth
+ *  from supplied string buffer
+ * @net_dev: netdev struct of the soft interface
+ * @buff: the buffer containing the user data
+ * @count: number of bytes in the buffer
+ *
+ * Return: 'count' on success or a negative error code in case of failure
+ */
 ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 				size_t count)
 {
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 33425a022026..13d04dba0b3a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -67,6 +67,12 @@ void batadv_hardif_release(struct kref *ref)
 	kfree_rcu(hard_iface, rcu);
 }
 
+/**
+ * batadv_hardif_get_by_netdev() - Get hard interface object of a net_device
+ * @net_dev: net_device to search for
+ *
+ * Return: batadv_hard_iface of net_dev (with increased refcnt), NULL on errors
+ */
 struct batadv_hard_iface *
 batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 {
@@ -561,6 +567,13 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
 	soft_iface->needed_tailroom = lower_tailroom;
 }
 
+/**
+ * batadv_hardif_min_mtu() - Calculate maximum MTU for soft interface
+ * @soft_iface: netdev struct of the soft interface
+ *
+ * Return: MTU for the soft-interface (limited by the minimal MTU of all active
+ *  slave interfaces)
+ */
 int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
@@ -607,7 +620,11 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	return min_t(int, min_mtu - batadv_max_header_len(), ETH_DATA_LEN);
 }
 
-/* adjusts the MTU if a new interface with a smaller MTU appeared. */
+/**
+ * batadv_update_min_mtu() - Adjusts the MTU if a new interface with a smaller
+ *  MTU appeared
+ * @soft_iface: netdev struct of the soft interface
+ */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
 	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
@@ -692,6 +709,14 @@ static int batadv_master_del_slave(struct batadv_hard_iface *slave,
 	return ret;
 }
 
+/**
+ * batadv_hardif_enable_interface() - Enslave hard interface to soft interface
+ * @hard_iface: hard interface to add to soft interface
+ * @net: the applicable net namespace
+ * @iface_name: name of the soft interface
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   struct net *net, const char *iface_name)
 {
@@ -803,6 +828,12 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	return ret;
 }
 
+/**
+ * batadv_hardif_disable_interface() - Remove hard interface from soft interface
+ * @hard_iface: hard interface to be removed
+ * @autodel: whether to delete soft interface when it doesn't contain any other
+ *  slave interfaces
+ */
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 				     enum batadv_hard_if_cleanup autodel)
 {
@@ -937,6 +968,9 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(hard_iface);
 }
 
+/**
+ * batadv_hardif_remove_interfaces() - Remove all hard interfaces
+ */
 void batadv_hardif_remove_interfaces(void)
 {
 	struct batadv_hard_iface *hard_iface, *hard_iface_tmp;
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 2ce0d5673f40..04d964358c98 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -34,7 +34,10 @@ static void batadv_hash_init(struct batadv_hashtable *hash)
 	}
 }
 
-/* free only the hashtable and the hash itself. */
+/**
+ * batadv_hash_destroy() - Free only the hashtable and the hash itself
+ * @hash: hash object to destroy
+ */
 void batadv_hash_destroy(struct batadv_hashtable *hash)
 {
 	kfree(hash->list_locks);
@@ -42,7 +45,12 @@ void batadv_hash_destroy(struct batadv_hashtable *hash)
 	kfree(hash);
 }
 
-/* allocates and clears the hash */
+/**
+ * batadv_hash_new() - Allocates and clears the hashtable
+ * @size: number of hash buckets to allocate
+ *
+ * Return: newly allocated hashtable, NULL on errors
+ */
 struct batadv_hashtable *batadv_hash_new(u32 size)
 {
 	struct batadv_hashtable *hash;
@@ -71,6 +79,11 @@ struct batadv_hashtable *batadv_hash_new(u32 size)
 	return NULL;
 }
 
+/**
+ * batadv_hash_set_lock_class() - Set specific lockdep class for hash spinlocks
+ * @hash: hash object to modify
+ * @key: lockdep class key address
+ */
 void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 				struct lock_class_key *key)
 {
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 8af5d30e59b1..f2ef75b7fa73 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -57,6 +57,9 @@ static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 				     struct batadv_icmp_header *icmph,
 				     size_t icmp_len);
 
+/**
+ * batadv_socket_init() - Initialize soft interface independent socket data
+ */
 void batadv_socket_init(void)
 {
 	memset(batadv_socket_client_hash, 0, sizeof(batadv_socket_client_hash));
@@ -316,6 +319,12 @@ static const struct file_operations batadv_fops = {
 	.llseek = no_llseek,
 };
 
+/**
+ * batadv_socket_setup() - Create debugfs "socket" file
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_socket_setup(struct batadv_priv *bat_priv)
 {
 	struct dentry *d;
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 6fbcdd40a332..da004980ab8b 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -88,6 +88,13 @@ static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
 	return 0;
 }
 
+/**
+ * batadv_debug_log() - Add debug log entry
+ * @bat_priv: the bat priv with all the soft interface information
+ * @fmt: format string
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 {
 	va_list args;
@@ -199,6 +206,12 @@ static const struct file_operations batadv_log_fops = {
 	.llseek         = no_llseek,
 };
 
+/**
+ * batadv_debug_log_setup() - Initialize debug log
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 {
 	struct dentry *d;
@@ -224,6 +237,10 @@ int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 	return -ENOMEM;
 }
 
+/**
+ * batadv_debug_log_cleanup() - Destroy debug log
+ * @bat_priv: the bat priv with all the soft interface information
+ */
 void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 {
 	kfree(bat_priv->debug_log);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e6e1f5eae494..8bee4279d579 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -140,6 +140,12 @@ static void __exit batadv_exit(void)
 	batadv_tt_cache_destroy();
 }
 
+/**
+ * batadv_mesh_init() - Initialize soft interface
+ * @soft_iface: netdev struct of the soft interface
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_mesh_init(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
@@ -217,6 +223,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	return ret;
 }
 
+/**
+ * batadv_mesh_free() - Deinitialize soft interface
+ * @soft_iface: netdev struct of the soft interface
+ */
 void batadv_mesh_free(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
@@ -413,6 +423,16 @@ static int batadv_recv_unhandled_packet(struct sk_buff *skb,
 /* incoming packets with the batman ethertype received on any active hard
  * interface
  */
+
+/**
+ * batadv_batman_skb_recv() - Handle incoming message from an hard interface
+ * @skb: the received packet
+ * @dev: the net device that the packet was received on
+ * @ptype: packet type of incoming packet (ETH_P_BATMAN)
+ * @orig_dev: the original receive net device (e.g. bonded device)
+ *
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
+ */
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev)
@@ -536,6 +556,13 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_frag_packet;
 }
 
+/**
+ * batadv_recv_handler_register() - Register handler for batman-adv packet type
+ * @packet_type: batadv_packettype which should be handled
+ * @recv_handler: receive handler for the packet type
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int
 batadv_recv_handler_register(u8 packet_type,
 			     int (*recv_handler)(struct sk_buff *,
@@ -553,6 +580,10 @@ batadv_recv_handler_register(u8 packet_type,
 	return 0;
 }
 
+/**
+ * batadv_recv_handler_unregister() - Unregister handler for packet type
+ * @packet_type: batadv_packettype which should no longer be handled
+ */
 void batadv_recv_handler_unregister(u8 packet_type)
 {
 	batadv_rx_handler[packet_type] = batadv_recv_unhandled_packet;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 412a603b2fda..58a7d9274435 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -58,6 +58,13 @@
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
 
+/**
+ * batadv_orig_hash_find() - Find and return originator from orig_hash
+ * @bat_priv: the bat priv with all the soft interface information
+ * @data: mac address of the originator
+ *
+ * Return: orig_node (with increased refcnt), NULL on errors
+ */
 struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
@@ -201,6 +208,12 @@ void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan)
 	kref_put(&orig_vlan->refcount, batadv_orig_node_vlan_release);
 }
 
+/**
+ * batadv_originator_init() - Initialize all originator structures
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_originator_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->orig_hash)
@@ -959,6 +972,10 @@ void batadv_orig_node_put(struct batadv_orig_node *orig_node)
 	kref_put(&orig_node->refcount, batadv_orig_node_release);
 }
 
+/**
+ * batadv_originator_free() - Free all originator structures
+ * @bat_priv: the bat priv with all the soft interface information
+ */
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
@@ -1374,12 +1391,24 @@ static void batadv_purge_orig(struct work_struct *work)
 			   msecs_to_jiffies(BATADV_ORIG_WORK_PERIOD));
 }
 
+/**
+ * batadv_purge_orig_ref() - Purge all outdated originators
+ * @bat_priv: the bat priv with all the soft interface information
+ */
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 {
 	_batadv_purge_orig(bat_priv);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+
+/**
+ * batadv_orig_seq_print_text() - Print the originator table in a seq file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -1532,6 +1561,13 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	return ret;
 }
 
+/**
+ * batadv_orig_hash_add_if() - Add interface to originators in orig_hash
+ * @hard_iface: hard interface to add (already slave of the soft interface)
+ * @max_if_num: new number of interfaces
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
@@ -1567,6 +1603,13 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	return -ENOMEM;
 }
 
+/**
+ * batadv_orig_hash_del_if() - Remove interface from originators in orig_hash
+ * @hard_iface: hard interface to remove (still slave of the soft interface)
+ * @max_if_num: new number of interfaces
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 01820be4ae5a..eb835bde502a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -181,6 +181,14 @@ bool batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
 	return false;
 }
 
+/**
+ * batadv_check_management_packet() - Check preconditions for management packets
+ * @skb: incoming packet buffer
+ * @hard_iface: incoming hard interface
+ * @header_len: minimal header length of packet type
+ *
+ * Return: true when management preconditions are met, false otherwise
+ */
 bool batadv_check_management_packet(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface,
 				    int header_len)
@@ -348,6 +356,13 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	return ret;
 }
 
+/**
+ * batadv_recv_icmp_packet() - Process incoming icmp packet
+ * @skb: incoming packet buffer
+ * @recv_if: incoming hard interface
+ *
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
+ */
 int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
@@ -936,6 +951,13 @@ int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 	return NET_RX_DROP;
 }
 
+/**
+ * batadv_recv_unicast_packet() - Process incoming unicast packet
+ * @skb: incoming packet buffer
+ * @recv_if: incoming hard interface
+ *
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
+ */
 int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if)
 {
@@ -1156,6 +1178,13 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * batadv_recv_bcast_packet() - Process incoming broadcast packet
+ * @skb: incoming packet buffer
+ * @recv_if: incoming hard interface
+ *
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
+ */
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 0700b3dfb595..2a5ab6f1076d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -124,12 +124,30 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	return NET_XMIT_DROP;
 }
 
+/**
+ * batadv_send_broadcast_skb() - Send broadcast packet via hard interface
+ * @skb: packet to be transmitted (with batadv header and no outer eth header)
+ * @hard_iface: outgoing interface
+ *
+ * Return: A negative errno code is returned on a failure. A success does not
+ * guarantee the frame will be transmitted as it may be dropped due
+ * to congestion or traffic shaping.
+ */
 int batadv_send_broadcast_skb(struct sk_buff *skb,
 			      struct batadv_hard_iface *hard_iface)
 {
 	return batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
 }
 
+/**
+ * batadv_send_unicast_skb() - Send unicast packet to neighbor
+ * @skb: packet to be transmitted (with batadv header and no outer eth header)
+ * @neigh: neighbor which is used as next hop to destination
+ *
+ * Return: A negative errno code is returned on a failure. A success does not
+ * guarantee the frame will be transmitted as it may be dropped due
+ * to congestion or traffic shaping.
+ */
 int batadv_send_unicast_skb(struct sk_buff *skb,
 			    struct batadv_neigh_node *neigh)
 {
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9b66e0edc741..1eb5555c5fe4 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -65,6 +65,13 @@
 #include "sysfs.h"
 #include "translation-table.h"
 
+/**
+ * batadv_skb_head_push() - Increase header size and move (push) head pointer
+ * @skb: packet buffer which should be modified
+ * @len: number of bytes to add
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 {
 	int result;
@@ -1064,6 +1071,13 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->ethtool_ops = &batadv_ethtool_ops;
 }
 
+/**
+ * batadv_softif_create() - Create and register soft interface
+ * @net: the applicable net namespace
+ * @name: name of the new soft interface
+ *
+ * Return: newly allocated soft_interface, NULL on errors
+ */
 struct net_device *batadv_softif_create(struct net *net, const char *name)
 {
 	struct net_device *soft_iface;
@@ -1141,6 +1155,12 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 	unregister_netdevice_queue(soft_iface, head);
 }
 
+/**
+ * batadv_softif_is_valid() - Check whether device is a batadv soft interface
+ * @net_dev: device which should be checked
+ *
+ * Return: true when net_dev is a batman-adv interface, false otherwise
+ */
 bool batadv_softif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == batadv_interface_tx)
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 8e2b7c7d2358..56fb42551453 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -735,6 +735,12 @@ static struct batadv_attribute *batadv_vlan_attrs[] = {
 	NULL,
 };
 
+/**
+ * batadv_sysfs_add_meshif() - Add soft interface specific sysfs entries
+ * @dev: netdev struct of the soft interface
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
@@ -775,6 +781,10 @@ int batadv_sysfs_add_meshif(struct net_device *dev)
 	return -ENOMEM;
 }
 
+/**
+ * batadv_sysfs_del_meshif() - Remove soft interface specific sysfs entries
+ * @dev: netdev struct of the soft interface
+ */
 void batadv_sysfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
@@ -1132,6 +1142,13 @@ static struct batadv_attribute *batadv_batman_attrs[] = {
 	NULL,
 };
 
+/**
+ * batadv_sysfs_add_hardif() - Add hard interface specific sysfs entries
+ * @hardif_obj: address where to store the pointer to new sysfs folder
+ * @dev: netdev struct of the hard interface
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 {
 	struct kobject *hardif_kobject = &dev->dev.kobj;
@@ -1166,6 +1183,11 @@ int batadv_sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 	return -ENOMEM;
 }
 
+/**
+ * batadv_sysfs_del_hardif() - Remove hard interface specific sysfs entries
+ * @hardif_obj: address to the pointer to which stores batman-adv sysfs folder
+ *  of the hard interface
+ */
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 {
 	kobject_uevent(*hardif_obj, KOBJ_REMOVE);
@@ -1174,6 +1196,16 @@ void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 	*hardif_obj = NULL;
 }
 
+/**
+ * batadv_throw_uevent() - Send an uevent with batman-adv specific env data
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: subsystem type of event. Stored in uevent's BATTYPE
+ * @action: action type of event. Stored in uevent's BATACTION
+ * @data: string with additional information to the event (ignored for
+ *  BATADV_UEV_DEL). Stored in uevent's BATDATA
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8b583d3e86e6..0e53be3f8df0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1055,6 +1055,14 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+
+/**
+ * batadv_tt_local_seq_print_text() - Print the local tt table in a seq file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -1927,6 +1935,13 @@ batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_tt_global_seq_print_text() - Print the global tt table in a seq file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -3729,6 +3744,10 @@ static void batadv_tt_purge(struct work_struct *work)
 			   msecs_to_jiffies(BATADV_TT_WORK_PERIOD));
 }
 
+/**
+ * batadv_tt_free() - Free translation table of soft interface
+ * @bat_priv: the bat priv with all the soft interface information
+ */
 void batadv_tt_free(struct batadv_priv *bat_priv)
 {
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_TT, 1);
@@ -3876,6 +3895,15 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.commit_lock);
 }
 
+/**
+ * batadv_is_ap_isolated() - Check if packet from upper layer should be dropped
+ * @bat_priv: the bat priv with all the soft interface information
+ * @src: source mac address of packet
+ * @dst: destination mac address of packet
+ * @vid: vlan id of packet
+ *
+ * Return: true when src+dst(+vid) pair should be isolated, false otherwise
+ */
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 			   unsigned short vid)
 {
@@ -4047,6 +4075,15 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 	return ret;
 }
 
+/**
+ * batadv_tt_add_temporary_global_entry() - Add temporary entry to global TT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which the temporary entry should be associated with
+ * @addr: mac address of the client
+ * @vid: VLAN id of the new temporary global translation table
+ *
+ * Return: true when temporary tt entry could be added, false otherwise
+ */
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr,
-- 
2.11.0

