Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  9 Oct 2013 15:05:38 +0200
Message-Id: <1381323938-26931-8-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: add debugfs support to view
	multiif tables
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Show tables for the multi interface operation. To keep the
implementation simple, all tables are put into one debugfs file.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c |   27 +++++++++++++++------------
 debugfs.c    |   16 ++++++++++++++++
 originator.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 originator.h |    1 +
 types.h      |    3 ++-
 5 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 017da4b..eae3b92 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1766,15 +1766,17 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
  * batadv_iv_ogm_orig_print - print the originator table
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: debugfs table seq_file struct
+ * @if_outgoing: the outgoing interface for which this should be printed
  */
 static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
-				     struct seq_file *seq)
+				     struct seq_file *seq,
+				     struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *neigh_node, *neigh_node_tmp;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	int last_seen_msecs, last_seen_secs;
 	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
+	struct batadv_neigh_node_ifinfo *n_ifinfo;
 	unsigned long last_seen_jiffies;
 	struct hlist_head *head;
 	int batman_count = 0;
@@ -1790,16 +1792,16 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			neigh_node = batadv_orig_node_get_router(orig_node,
-								 NULL);
+								 if_outgoing);
 			if (!neigh_node)
 				continue;
 
-			neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
-								    NULL);
-			if (!neigh_ifinfo)
+			n_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+								if_outgoing);
+			if (!n_ifinfo)
 				goto next;
 
-			if (neigh_ifinfo->bat_iv.tq_avg == 0)
+			if (n_ifinfo->bat_iv.tq_avg == 0)
 				goto next;
 
 			last_seen_jiffies = jiffies - orig_node->last_seen;
@@ -1809,20 +1811,21 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs, neigh_ifinfo->bat_iv.tq_avg,
+				   last_seen_msecs, n_ifinfo->bat_iv.tq_avg,
 				   neigh_node->addr,
 				   neigh_node->if_incoming->net_dev->name);
 
 			hlist_for_each_entry_rcu(neigh_node_tmp,
 						 &orig_node->neigh_list, list) {
-				neigh_ifinfo = batadv_neigh_node_get_ifinfo(
-							neigh_node, NULL);
-				if (!neigh_ifinfo)
+				n_ifinfo = batadv_neigh_node_get_ifinfo(
+							neigh_node,
+							if_outgoing);
+				if (!n_ifinfo)
 					continue;
 
 				seq_printf(seq, " %pM (%3i)",
 					   neigh_node_tmp->addr,
-					   neigh_ifinfo->bat_iv.tq_avg);
+					   n_ifinfo->bat_iv.tq_avg);
 			}
 
 			seq_puts(seq, "\n");
diff --git a/debugfs.c b/debugfs.c
index 049a7a2..1a4bcb5 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -250,6 +250,19 @@ static int batadv_originators_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_orig_seq_print_text, net_dev);
 }
 
+/**
+ * batadv_originators_open_multiif - handles debugfs output for the
+ *	originators_multiif table
+ * @inode: inode pointer to debugfs file
+ * @file: pointer to the seq_file
+ */
+static int batadv_originators_open_multiif(struct inode *inode,
+					   struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, batadv_orig_multiif_seq_print_text, net_dev);
+}
+
 static int batadv_gateways_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -336,6 +349,8 @@ static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 
 /* The following attributes are per soft interface */
 static BATADV_DEBUGINFO(originators, S_IRUGO, batadv_originators_open);
+static BATADV_DEBUGINFO(originators_multiif, S_IRUGO,
+			batadv_originators_open_multiif);
 static BATADV_DEBUGINFO(gateways, S_IRUGO, batadv_gateways_open);
 static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
 			batadv_transtable_global_open);
@@ -355,6 +370,7 @@ static BATADV_DEBUGINFO(nc_nodes, S_IRUGO, batadv_nc_nodes_open);
 
 static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_originators,
+	&batadv_debuginfo_originators_multiif,
 	&batadv_debuginfo_gateways,
 	&batadv_debuginfo_transtable_global,
 #ifdef CONFIG_BATMAN_ADV_BLA
diff --git a/originator.c b/originator.c
index 6d7e978..a35ec2d 100644
--- a/originator.c
+++ b/originator.c
@@ -776,7 +776,49 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq);
+	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, NULL);
+
+	return 0;
+}
+
+/**
+ * batadv_orig_multiif_seq_print_text - writes originator infos for all
+ *	outgoing interfaces
+ * @seq: debugfs table seq_file struct
+ * @offset: not used
+ *
+ * Returns 0
+ */
+int batadv_orig_multiif_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *hard_iface;
+
+	if (!bat_priv->bat_algo_ops->bat_orig_print) {
+		seq_puts(seq,
+			 "No printing function for this routing protocol\n");
+		return 0;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		seq_printf(seq,
+			   "[B.A.T.M.A.N. adv %s, IF/MAC: %s/%pM (%s %s)]\n",
+			   BATADV_SOURCE_VERSION, hard_iface->net_dev->name,
+			   hard_iface->net_dev->dev_addr, net_dev->name,
+			   bat_priv->bat_algo_ops->name);
+
+		bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq,
+						       hard_iface);
+	}
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/originator.h b/originator.h
index ef2500a..0b4b0c9 100644
--- a/originator.h
+++ b/originator.h
@@ -46,6 +46,7 @@ struct batadv_neigh_node_ifinfo *
 batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
 			     struct batadv_hard_iface *if_outgoing);
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_orig_multiif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
diff --git a/types.h b/types.h
index 9587cfe..99e2ab7 100644
--- a/types.h
+++ b/types.h
@@ -1049,7 +1049,8 @@ struct batadv_algo_ops {
 		 struct batadv_neigh_node *neigh2,
 		 struct batadv_hard_iface *if_outgoing2);
 	/* orig_node handling API */
-	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
+	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
+			       struct batadv_hard_iface *hard_iface);
 	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
 	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num);
-- 
1.7.10.4

