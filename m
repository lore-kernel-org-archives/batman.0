Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:51:42 +0100
Message-Id: <20180302175142.11838-8-sw@simonwunderlich.de>
In-Reply-To: <20180302175142.11838-1-sw@simonwunderlich.de>
References: <20180302175142.11838-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: Fix internal interface
 indices types
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

batman-adv uses internal indices for each enabled and active interface.
It is currently used by the B.A.T.M.A.N. IV algorithm to identifify the
correct position in the ogm_cnt bitmaps.

The type for the number of enabled interfaces (which defines the next
interface index) was set to char. This type can be (depending on the
architecture) either signed (limiting batman-adv to 127 active slave
interfaces) or unsigned (limiting batman-adv to 255 active slave
interfaces).

This limit was not correctly checked when an interface was enabled and thus
an overflow happened. This was only catched on systems with the signed char
type when the B.A.T.M.A.N. IV code tried to resize its counter arrays with
a negative size.

The if_num interface index was only a s16 and therefore significantly
smaller than the ifindex (int) used by the code net code.

Both &batadv_hard_iface->if_num and &batadv_priv->num_ifaces must be
(unsigned) int to support the same number of slave interfaces as the net
core code. And the interface activation code must check the number of
active slave interfaces to avoid integer overflows.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c     | 24 ++++++++++++++----------
 net/batman-adv/hard-interface.c |  9 +++++++--
 net/batman-adv/originator.c     |  4 ++--
 net/batman-adv/originator.h     |  4 ++--
 net/batman-adv/types.h          | 11 ++++++-----
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 8f64439647e3..99abeadf416e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -157,7 +157,7 @@ static void batadv_iv_ogm_orig_free(struct batadv_orig_node *orig_node)
  * Return: 0 on success, a negative error code otherwise.
  */
 static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
-				     int max_if_num)
+				     unsigned int max_if_num)
 {
 	void *data_ptr;
 	size_t old_size;
@@ -201,7 +201,8 @@ static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
  */
 static void
 batadv_iv_ogm_drop_bcast_own_entry(struct batadv_orig_node *orig_node,
-				   int max_if_num, int del_if_num)
+				   unsigned int max_if_num,
+				   unsigned int del_if_num)
 {
 	size_t chunk_size;
 	size_t if_offset;
@@ -239,7 +240,8 @@ batadv_iv_ogm_drop_bcast_own_entry(struct batadv_orig_node *orig_node,
  */
 static void
 batadv_iv_ogm_drop_bcast_own_sum_entry(struct batadv_orig_node *orig_node,
-				       int max_if_num, int del_if_num)
+				       unsigned int max_if_num,
+				       unsigned int del_if_num)
 {
 	size_t if_offset;
 	void *data_ptr;
@@ -276,7 +278,8 @@ batadv_iv_ogm_drop_bcast_own_sum_entry(struct batadv_orig_node *orig_node,
  * Return: 0 on success, a negative error code otherwise.
  */
 static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
-				     int max_if_num, int del_if_num)
+				     unsigned int max_if_num,
+				     unsigned int del_if_num)
 {
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
@@ -311,7 +314,8 @@ static struct batadv_orig_node *
 batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
-	int size, hash_added;
+	int hash_added;
+	size_t size;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
@@ -893,7 +897,7 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	u32 i;
 	size_t word_index;
 	u8 *w;
-	int if_num;
+	unsigned int if_num;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1023,7 +1027,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_node *orig_node_tmp;
-	int if_num;
+	unsigned int if_num;
 	u8 sum_orig, sum_neigh;
 	u8 *neigh_addr;
 	u8 tq_avg;
@@ -1182,7 +1186,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int if_num;
+	unsigned int if_num;
 	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
 	unsigned int tq_iface_penalty;
@@ -1702,9 +1706,9 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 
 	if (is_my_orig) {
 		unsigned long *word;
-		int offset;
+		size_t offset;
 		s32 bit_pos;
-		s16 if_num;
+		unsigned int if_num;
 		u8 *weight;
 
 		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5f186bff284a..68b54a39c51d 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -763,6 +763,11 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
+	if (bat_priv->num_ifaces >= UINT_MAX) {
+		ret = -ENOSPC;
+		goto err_dev;
+	}
+
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   soft_iface, NULL, NULL, NULL);
 	if (ret)
@@ -876,7 +881,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	batadv_hardif_recalc_extra_skbroom(hard_iface->soft_iface);
 
 	/* nobody uses this interface anymore */
-	if (!bat_priv->num_ifaces) {
+	if (bat_priv->num_ifaces == 0) {
 		batadv_gw_check_client_stop(bat_priv);
 
 		if (autodel == BATADV_IF_CLEANUP_AUTO)
@@ -912,7 +917,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (ret)
 		goto free_if;
 
-	hard_iface->if_num = -1;
+	hard_iface->if_num = 0;
 	hard_iface->net_dev = net_dev;
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 58a7d9274435..74782426bb77 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1569,7 +1569,7 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * Return: 0 on success or negative error number in case of failure
  */
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
-			    int max_if_num)
+			    unsigned int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
@@ -1611,7 +1611,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
  * Return: 0 on success or negative error number in case of failure
  */
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
-			    int max_if_num)
+			    unsigned int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 8e543a3cdc6c..15d896b2de6f 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -73,9 +73,9 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
-			    int max_if_num);
+			    unsigned int max_if_num);
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
-			    int max_if_num);
+			    unsigned int max_if_num);
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index bb1578410e0c..a5aa6d61f4e2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -167,7 +167,7 @@ struct batadv_hard_iface {
 	struct list_head list;
 
 	/** @if_num: identificator of the interface */
-	s16 if_num;
+	unsigned int if_num;
 
 	/** @if_status: status of the interface for batman-adv */
 	char if_status;
@@ -1596,7 +1596,7 @@ struct batadv_priv {
 	atomic_t batman_queue_left;
 
 	/** @num_ifaces: number of interfaces assigned to this mesh interface */
-	char num_ifaces;
+	unsigned int num_ifaces;
 
 	/** @mesh_obj: kobject for sysfs mesh subdirectory */
 	struct kobject *mesh_obj;
@@ -2186,15 +2186,16 @@ struct batadv_algo_orig_ops {
 	 *  orig_node due to a new hard-interface being added into the mesh
 	 *  (optional)
 	 */
-	int (*add_if)(struct batadv_orig_node *orig_node, int max_if_num);
+	int (*add_if)(struct batadv_orig_node *orig_node,
+		      unsigned int max_if_num);
 
 	/**
 	 * @del_if: ask the routing algorithm to apply the needed changes to the
 	 *  orig_node due to an hard-interface being removed from the mesh
 	 *  (optional)
 	 */
-	int (*del_if)(struct batadv_orig_node *orig_node, int max_if_num,
-		      int del_if_num);
+	int (*del_if)(struct batadv_orig_node *orig_node,
+		      unsigned int max_if_num, unsigned int del_if_num);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	/** @print: print the originator table (optional) */
-- 
2.11.0

