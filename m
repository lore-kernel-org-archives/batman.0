Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Mar 2012 22:51:13 +0100
Message-Id: <1332453075-27999-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [RFC 3/5] batman-adv: ELP - exporting neighbor list
	via debugfs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Linus Luessing <linus.luessing@web.de>

Lists all neighbours and their tq/rq values detected and measured by the Echo
Location Protocol (ELP).

Developed by Linus during a 6 months trainee study period in Ascom (Switzerland)
AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_debugfs.c |   16 +++++++++++++
 bat_v_elp.c   |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 3b588f8..5365554 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -227,6 +227,16 @@ static int bat_algorithms_open(struct inode *inode, struct file *file)
 	return single_open(file, bat_algo_seq_print_text, NULL);
 }
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+int bat_v_elp_seq_print_text(struct seq_file *seq, void *offset);
+
+static int neighbors_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, bat_v_elp_seq_print_text, net_dev);
+}
+#endif
+
 static int originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -283,6 +293,9 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 };
 
 static BAT_DEBUGINFO(routing_algos, S_IRUGO, bat_algorithms_open);
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+static BAT_DEBUGINFO(neighbors, S_IRUGO, neighbors_open);
+#endif
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
@@ -293,6 +306,9 @@ static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
 static struct bat_debuginfo *mesh_debuginfos[] = {
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	&bat_debuginfo_neighbors,
+#endif
 	&bat_debuginfo_originators,
 	&bat_debuginfo_gateways,
 	&bat_debuginfo_transtable_global,
diff --git a/bat_v_elp.c b/bat_v_elp.c
index e252c04..9232f28 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -394,6 +394,73 @@ out:
 	return NET_RX_SUCCESS;
 }
 
+static void bat_v_elp_seq_print_neigh(struct seq_file *seq,
+				      struct hard_iface *hard_iface,
+				      struct neigh_node *neigh_node)
+{
+	int last_secs, last_msecs;
+
+	last_secs = jiffies_to_msecs(jiffies - neigh_node->last_seen) / 1000;
+	last_msecs = jiffies_to_msecs(jiffies - neigh_node->last_seen) % 1000;
+
+	seq_printf(seq, "%pM %4i.%03is     (%3i,%3i) [%10s]\n",
+		   neigh_node->addr, last_secs, last_msecs, neigh_node->tq,
+		   neigh_node->rq, hard_iface->net_dev->name);
+}
+
+int bat_v_elp_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hard_iface *hard_iface, *primary_if;
+	struct neigh_node *neigh_node;
+	struct hlist_node *node;
+	int ret = 0, batman_count = 0;
+
+	primary_if = primary_if_get_selected(bat_priv);
+
+	if (!primary_if) {
+		ret = seq_printf(seq, "BATMAN mesh %s disabled - "
+				 "please specify interfaces to enable it\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	if (primary_if->if_status != IF_ACTIVE) {
+		ret = seq_printf(seq, "BATMAN mesh %s "
+				 "disabled - primary interface not active\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
+		   SOURCE_VERSION, primary_if->net_dev->name,
+		   primary_if->net_dev->dev_addr, net_dev->name);
+	seq_printf(seq, "  %-15s %s (%s/%i) [%10s]\n",
+		   "Neighbor", "last-seen", "#TQ,#RQ", TQ_MAX_VALUE, "IF");
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+		if (hard_iface->soft_iface != net_dev)
+			continue;
+
+		hlist_for_each_entry_rcu(neigh_node, node,
+					 &hard_iface->neigh_list, list) {
+			bat_v_elp_seq_print_neigh(seq, hard_iface, neigh_node);
+			batman_count++;
+		}
+	}
+	rcu_read_unlock();
+
+	if (batman_count == 0)
+		seq_printf(seq, "No batman nodes in range ...\n");
+
+out:
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	return ret;
+}
+
 static struct bat_algo_ops batman_v __read_mostly = {
 	.name = "BATMAN V",
 	.bat_iface_enable = bat_v_elp_iface_enable,
-- 
1.7.9.1

