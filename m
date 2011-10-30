Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 23:51:05 +0100
Message-Id: <1320015072-10313-5-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 04/11] batman-adv: export claim tables through
	debugfs
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
[2011-10-27] Changes suggested by Marek Lindner:
 * move rcu_read_lock() more into the loops

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

[2011-10-30] Changes suggested by Marek Lindner:
 * pimp up claim table debugfs output

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bat_debugfs.c           |   10 +++++++++
 bridge_loop_avoidance.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++
 bridge_loop_avoidance.h |    1 +
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 492eec7..20d3fc9 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -32,6 +32,7 @@
 #include "soft-interface.h"
 #include "vis.h"
 #include "icmp_socket.h"
+#include "bridge_loop_avoidance.h"
 
 static struct dentry *bat_debugfs;
 
@@ -239,6 +240,13 @@ static int transtable_global_open(struct inode *inode, struct file *file)
 	return single_open(file, tt_global_seq_print_text, net_dev);
 }
 
+static int bla_claim_table_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, bla_claim_table_seq_print_text, net_dev);
+}
+
+
 static int transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -271,6 +279,7 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
+static BAT_DEBUGINFO(bla_claim_table, S_IRUGO, bla_claim_table_open);
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
@@ -278,6 +287,7 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 	&bat_debuginfo_originators,
 	&bat_debuginfo_gateways,
 	&bat_debuginfo_transtable_global,
+	&bat_debuginfo_bla_claim_table,
 	&bat_debuginfo_transtable_local,
 	&bat_debuginfo_vis_data,
 	NULL,
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 641dbcc..bc4e57f 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1238,3 +1238,54 @@ handled:
 		claim_free_ref(claim);
 	return 1;
 }
+
+int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->claim_hash;
+	struct claim *claim;
+	struct hard_iface *primary_if;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	uint32_t i;
+	int ret = 0;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if) {
+		ret = seq_printf(seq, "BATMAN mesh %s disabled - please "
+				 "specify interfaces to enable it\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	if (primary_if->if_status != IF_ACTIVE) {
+		ret = seq_printf(seq, "BATMAN mesh %s disabled - "
+				 "primary interface not active\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	seq_printf(seq, "Claims announced for the mesh %s "
+			"(orig %pM)\n",
+			net_dev->name, bat_priv->own_orig);
+	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-4s)\n",
+		   "Client", "VID", "Originator", "CRC");
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(claim, node, head, hash_entry)
+			seq_printf(seq,	" * %pM on % 5d by %pM [%c] (%04x)\n",
+				claim->addr, claim->vid,
+				claim->backbone_gw->orig,
+				(compare_eth(claim->backbone_gw->orig,
+					     bat_priv->own_orig) ? 'x' : ' '),
+				claim->backbone_gw->crc);
+		rcu_read_unlock();
+	}
+out:
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	return ret;
+}
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 8df5036..91aa515 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -23,6 +23,7 @@ int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_is_backbone_gw(struct sk_buff *skb,
 		struct orig_node *orig_node, int hdr_size);
+int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
 void bla_update_orig_address(struct bat_priv *bat_priv, uint8_t *newaddr);
 int bla_init(struct bat_priv *bat_priv);
 void bla_free(struct bat_priv *bat_priv);
-- 
1.7.7.1

