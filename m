Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:05 +0100
Message-Id: <1392122903-805-6-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 05/23] batman-adv: ELP - exporting neighbor
	list via debugfs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Linus Luessing <linus.luessing@web.de>

Lists all neighbours detected by the Echo Locating Protocol
(ELP) and their metric values.

Initially Developed by Linus during a 6 months trainee study
period in Ascom (Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_elp.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat_v_elp.h |  1 +
 debugfs.c   | 17 +++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index ee4207d..9c40415 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -379,3 +379,83 @@ out:
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 }
+
+/**
+ * batadv_v_elp_seq_print_neigh - print a single ELP neighbour node
+ * @seq: neighbour table seq_file struct
+ * @hard_iface: interface the neighbour is connected to
+ * @neigh: the neighbour node to print
+ */
+static void batadv_v_elp_seq_print_neigh(struct seq_file *seq,
+					 struct batadv_hard_iface *hard_iface,
+					 struct batadv_elp_neigh_node *neigh)
+{
+	int last_secs, last_msecs;
+	uint32_t metric;
+
+	last_secs = jiffies_to_msecs(jiffies - neigh->last_seen) / 1000;
+	last_msecs = jiffies_to_msecs(jiffies - neigh->last_seen) % 1000;
+	metric = ewma_read(&neigh->metric);
+
+	seq_printf(seq, "%pM %4i.%03is (%9u.%1u) [%10s]\n",
+		   neigh->addr, last_secs, last_msecs, metric / 10,
+		   metric % 10, hard_iface->net_dev->name);
+}
+
+/**
+ * batadv_v_elp_seq_print_text - print the neighbour table
+ * @seq: neighbour table seq_file struct
+ * @offset: not used
+ *
+ * Returns always 0.
+ */
+int batadv_v_elp_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *hard_iface, *primary_if;
+	struct batadv_elp_neigh_node *neigh;
+	int batman_count = 0;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+
+	if (!primary_if) {
+		seq_printf(seq,
+			   "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+			   net_dev->name);
+		goto out;
+	}
+
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		seq_printf(seq,
+			   "BATMAN mesh %s disabled - primary interface not active\n",
+			   net_dev->name);
+		goto out;
+	}
+
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
+		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
+		   primary_if->net_dev->dev_addr, net_dev->name);
+	seq_printf(seq, "  %-15s %s (%11s) [%10s]\n", "Neighbor",
+		   "last-seen", "metric", "IF");
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != net_dev)
+			continue;
+
+		hlist_for_each_entry_rcu(neigh, &hard_iface->bat_v.neigh_list, list) {
+			batadv_v_elp_seq_print_neigh(seq, hard_iface, neigh);
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
+		batadv_hardif_free_ref(primary_if);
+	return 0;
+}
diff --git a/bat_v_elp.h b/bat_v_elp.h
index 186ff4b..4f34ecb 100644
--- a/bat_v_elp.h
+++ b/bat_v_elp.h
@@ -32,5 +32,6 @@ void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
+int batadv_v_elp_seq_print_text(struct seq_file *seq, void *offset);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/debugfs.c b/debugfs.c
index b758881..23990cf 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -20,6 +20,7 @@
 #include <linux/debugfs.h>
 
 #include "debugfs.h"
+#include "bat_v_elp.h"
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
@@ -242,6 +243,16 @@ static int batadv_algorithms_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_algo_seq_print_text, NULL);
 }
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+int batadv_v_elp_seq_print_text(struct seq_file *seq, void *offset);
+
+static int neighbors_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, batadv_v_elp_seq_print_text, net_dev);
+}
+#endif
+
 static int batadv_originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -346,6 +357,9 @@ static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 };
 
 /* The following attributes are per soft interface */
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+static BATADV_DEBUGINFO(neighbors, S_IRUGO, neighbors_open);
+#endif
 static BATADV_DEBUGINFO(originators, S_IRUGO, batadv_originators_open);
 static BATADV_DEBUGINFO(gateways, S_IRUGO, batadv_gateways_open);
 static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
@@ -365,6 +379,9 @@ static BATADV_DEBUGINFO(nc_nodes, S_IRUGO, batadv_nc_nodes_open);
 #endif
 
 static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	&batadv_debuginfo_neighbors,
+#endif
 	&batadv_debuginfo_originators,
 	&batadv_debuginfo_gateways,
 	&batadv_debuginfo_transtable_global,
-- 
1.8.5.3

