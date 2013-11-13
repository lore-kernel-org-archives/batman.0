Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Nov 2013 19:14:52 +0100
Message-Id: <1384366492-27310-9-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 8/8] batman-adv: add debugfs support to
	view multiif tables
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

Show tables for the multi interface operation. Originator tables
are added per hard interface.

This patch also changes the API by adding the interface to the
bat_orig_print() parameters.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCHv2:
 * use name "originators", not "originators_multiif" for the
   originator table per interface.

Changes to PATCH:
 * use one file per interface instead of all tables in one file
 * kernel doc and commit message improvement
---
 bat_iv_ogm.c |   12 +++++++-----
 debugfs.c    |   16 ++++++++++++++++
 originator.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 originator.h |    1 +
 types.h      |    3 ++-
 5 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index dbd55f0..bf4fd9c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1781,9 +1781,11 @@ batadv_iv_ogm_orig_print_neigh(struct batadv_orig_node *orig_node,
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
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
@@ -1805,12 +1807,12 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			neigh_node = batadv_orig_router_get(orig_node,
-							    BATADV_IF_DEFAULT);
+							    if_outgoing);
 			if (!neigh_node)
 				continue;
 
 			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
-							   BATADV_IF_DEFAULT);
+							   if_outgoing);
 			if (!n_ifinfo)
 				goto next;
 
@@ -1828,8 +1830,8 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 				   neigh_node->addr,
 				   neigh_node->if_incoming->net_dev->name);
 
-			batadv_iv_ogm_orig_print_neigh(orig_node,
-						       BATADV_IF_DEFAULT, seq);
+			batadv_iv_ogm_orig_print_neigh(orig_node, if_outgoing,
+						       seq);
 			seq_puts(seq, "\n");
 			batman_count++;
 
diff --git a/debugfs.c b/debugfs.c
index 97a3f34..c3ee8e3 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -246,6 +246,19 @@ static int batadv_originators_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_orig_seq_print_text, net_dev);
 }
 
+/**
+ * batadv_originators_open_multiif - handles debugfs output for the
+ *  originators_multiif table
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
@@ -378,8 +391,11 @@ struct batadv_debuginfo batadv_hardif_debuginfo_##_name = {	\
 		  .release = single_release,			\
 		}						\
 };
+static BATADV_HARDIF_DEBUGINFO(originators, S_IRUGO,
+			       batadv_originators_open_multiif);
 
 static struct batadv_debuginfo *batadv_hardif_debuginfos[] = {
+	&batadv_hardif_debuginfo_originators,
 	NULL,
 };
 
diff --git a/originator.c b/originator.c
index 9f0ae77..0f4ff1b 100644
--- a/originator.c
+++ b/originator.c
@@ -932,11 +932,57 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq);
+	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq,
+					       BATADV_IF_DEFAULT);
 
 	return 0;
 }
 
+/**
+ * batadv_orig_multiif_seq_print_text - writes originator infos for all
+ *  outgoing interfaces
+ * @seq: debugfs table seq_file struct
+ * @offset: not used
+ *
+ * Returns 0
+ */
+int batadv_orig_multiif_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
+
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
+
+	if (!hard_iface || !hard_iface->soft_iface) {
+		seq_puts(seq, "Interface not known to to B.A.T.M.A.N.\n");
+		goto out;
+	}
+
+	bat_priv = netdev_priv(hard_iface->soft_iface);
+	if (!bat_priv->bat_algo_ops->bat_orig_print) {
+		seq_puts(seq,
+			 "No printing function for this routing protocol\n");
+		goto out;
+	}
+
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		seq_puts(seq, "Interface not active\n");
+		goto out;
+	}
+
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s, IF/MAC: %s/%pM (%s %s)]\n",
+		   BATADV_SOURCE_VERSION, hard_iface->net_dev->name,
+		   hard_iface->net_dev->dev_addr,
+		   hard_iface->soft_iface->name, bat_priv->bat_algo_ops->name);
+
+	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, hard_iface);
+
+out:
+	batadv_hardif_free_ref(hard_iface);
+	return 0;
+}
+
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
diff --git a/originator.h b/originator.h
index 382f335..0abc9af 100644
--- a/originator.h
+++ b/originator.h
@@ -50,6 +50,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo);
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_orig_multiif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
diff --git a/types.h b/types.h
index 0e5d238..2627a3d 100644
--- a/types.h
+++ b/types.h
@@ -1080,7 +1080,8 @@ struct batadv_algo_ops {
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

