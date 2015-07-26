Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Jul 2015 15:16:30 +0800
Message-Id: <1437894990-15534-3-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1437894990-15534-1-git-send-email-mareklindner@neomailbox.ch>
References: <1437894990-15534-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: export singe hop neighbor
	list via debugfs
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
 net/batman-adv/bat_iv_ogm.c | 35 +++++++++++++++++++++++++++++++++++
 net/batman-adv/debugfs.c    |  8 ++++++++
 net/batman-adv/originator.c | 34 ++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.h |  2 ++
 net/batman-adv/types.h      |  2 ++
 5 files changed, 81 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 912d9c3..567b47e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1862,6 +1862,40 @@ next:
 }
 
 /**
+ * batadv_iv_ogm_neigh_print - print the single hop neighbour list
+ * @bat_priv: the bat priv with all the soft interface information
+ * @seq: neighbour table seq_file struct
+ */
+void batadv_iv_ogm_neigh_print(struct batadv_priv *bat_priv,
+			       struct seq_file *seq)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct batadv_hard_iface *hard_iface;
+	int batman_count = 0;
+
+	seq_printf(seq, "   %10s        %-13s\n", "interface", "neighbor");
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != net_dev)
+			continue;
+
+		hlist_for_each_entry_rcu(hardif_neigh,
+					&hard_iface->neigh_list, list) {
+			seq_printf(seq, "   %10s   %pM\n",
+				   hard_iface->net_dev->name,
+				   hardif_neigh->addr);
+			batman_count++;
+		}
+	}
+	rcu_read_unlock();
+
+	if (batman_count == 0)
+		seq_printf(seq, "No batman nodes in range ...\n");
+}
+
+/**
  * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
  * @neigh1: the first neighbor object of the comparison
  * @if_outgoing1: outgoing interface for the first neighbor
@@ -1954,6 +1988,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_ogm_emit = batadv_iv_ogm_emit,
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
 	.bat_neigh_is_equiv_or_better = batadv_iv_ogm_neigh_is_eob,
+	.bat_neigh_print = batadv_iv_ogm_neigh_print,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 	.bat_orig_free = batadv_iv_ogm_orig_free,
 	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index c4c1e80..c00bcec 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -262,6 +262,12 @@ static int batadv_algorithms_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_algo_seq_print_text, NULL);
 }
 
+static int neighbors_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, batadv_hardif_neigh_seq_print_text, net_dev);
+}
+
 static int batadv_originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -375,6 +381,7 @@ static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 };
 
 /* The following attributes are per soft interface */
+static BATADV_DEBUGINFO(neighbors, S_IRUGO, neighbors_open);
 static BATADV_DEBUGINFO(originators, S_IRUGO, batadv_originators_open);
 static BATADV_DEBUGINFO(gateways, S_IRUGO, batadv_gateways_open);
 static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
@@ -394,6 +401,7 @@ static BATADV_DEBUGINFO(nc_nodes, S_IRUGO, batadv_nc_nodes_open);
 #endif
 
 static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
+	&batadv_debuginfo_neighbors,
 	&batadv_debuginfo_originators,
 	&batadv_debuginfo_gateways,
 	&batadv_debuginfo_transtable_global,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 615ad0f..df78a64 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -666,6 +666,40 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 }
 
 /**
+ * batadv_hardif_neigh_seq_print_text - print the single hop neighbour list
+ * @seq: neighbour table seq_file struct
+ * @offset: not used
+ *
+ * Always returns 0.
+ */
+int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
+		return 0;
+
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s %s)]\n",
+		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
+		   primary_if->net_dev->dev_addr, net_dev->name,
+		   bat_priv->bat_algo_ops->name);
+
+	batadv_hardif_free_ref(primary_if);
+
+	if (!bat_priv->bat_algo_ops->bat_neigh_print) {
+		seq_puts(seq,
+			 "No printing function for this routing protocol\n");
+		return 0;
+	}
+
+	bat_priv->bat_algo_ops->bat_neigh_print(bat_priv, seq);
+	return 0;
+}
+
+/**
  * batadv_orig_ifinfo_free_rcu - free the orig_ifinfo object
  * @rcu: rcu pointer of the orig_ifinfo object
  */
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 99405be..7bb7f6d 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -66,6 +66,8 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
 void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo);
 
+int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset);
+
 struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f9ec98d..7cf5f80 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1160,6 +1160,7 @@ struct batadv_forw_packet {
  * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or better
  *  than neigh2 for their respective outgoing interface from the metric
  *  prospective
+ * @bat_neigh_print: print the signle hop neighbor list (optional)
  * @bat_neigh_free: free the resources allocated by the routing algorithm for a
  *  neigh_node object
  * @bat_orig_print: print the originator table (optional)
@@ -1190,6 +1191,7 @@ struct batadv_algo_ops {
 		 struct batadv_hard_iface *if_outgoing1,
 		 struct batadv_neigh_node *neigh2,
 		 struct batadv_hard_iface *if_outgoing2);
+	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
 	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
-- 
2.1.4

