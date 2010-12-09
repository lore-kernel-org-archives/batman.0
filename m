Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  9 Dec 2010 10:23:55 +0100
Message-Id: <1291886638-19344-8-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 07/10] batman-adv: Adding ndp debugfs output
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

Lists all neighbours and their tq/rq values detected and measured by the
Neighbor Discovery Protocol (NDP).

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 bat_debugfs.c |    9 ++++++++
 ndp.c         |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ndp.h         |    1 +
 3 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 0ae81d0..602aa15 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -25,6 +25,7 @@
 
 #include "bat_debugfs.h"
 #include "translation-table.h"
+#include "ndp.h"
 #include "originator.h"
 #include "hard-interface.h"
 #include "gateway_common.h"
@@ -222,6 +223,12 @@ static void debug_log_cleanup(struct bat_priv *bat_priv)
 }
 #endif
 
+static int neighbors_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, ndp_seq_print_text, net_dev);
+}
+
 static int originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -275,6 +282,7 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 		}				\
 };
 
+static BAT_DEBUGINFO(neighbors, S_IRUGO, neighbors_open);
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(softif_neigh, S_IRUGO, softif_neigh_open);
@@ -283,6 +291,7 @@ static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
 static struct bat_debuginfo *mesh_debuginfos[] = {
+	&bat_debuginfo_neighbors,
 	&bat_debuginfo_originators,
 	&bat_debuginfo_gateways,
 	&bat_debuginfo_softif_neigh,
diff --git a/ndp.c b/ndp.c
index 2d30d30..81f273a 100644
--- a/ndp.c
+++ b/ndp.c
@@ -1,6 +1,7 @@
 #include "main.h"
 #include "send.h"
 #include "ndp.h"
+#include "hard-interface.h"
 #include "soft-interface.h"
 #include "originator.h"
 
@@ -242,3 +243,62 @@ ret:
 	spin_unlock_bh(&batman_if->neigh_list_lock);
 	return ret;
 }
+
+int ndp_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct neigh_node *neigh_node;
+	struct batman_if *batman_if;
+	int last_seen_secs;
+	int last_seen_msecs;
+	int batman_count = 0;
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+
+	if ((!bat_priv->primary_if) ||
+	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
+		if (!bat_priv->primary_if)
+			return seq_printf(seq, "BATMAN mesh %s disabled - "
+				    "please specify interfaces to enable it\n",
+				    net_dev->name);
+
+		return seq_printf(seq, "BATMAN mesh %s "
+				  "disabled - primary interface not active\n",
+				  net_dev->name);
+	}
+
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
+		   SOURCE_VERSION, REVISION_VERSION_STR,
+		   bat_priv->primary_if->net_dev->name,
+		   bat_priv->primary_if->net_dev->dev_addr, net_dev->name);
+	seq_printf(seq, "  %-15s %s (%s/%i) [%10s]\n",
+		   "Neighbor", "last-seen", "#TQ,#RQ", TQ_MAX_VALUE, "IF");
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if (batman_if->if_status != IF_ACTIVE)
+			continue;
+
+		spin_lock_bh(&batman_if->neigh_list_lock);
+		list_for_each_entry(neigh_node, &batman_if->neigh_list,
+				    list) {
+			last_seen_secs = jiffies_to_msecs(jiffies -
+						neigh_node->last_valid) / 1000;
+			last_seen_msecs = jiffies_to_msecs(jiffies -
+						neigh_node->last_valid) % 1000;
+
+			seq_printf(seq, "%pM %4i.%03is     (%3i,%3i) [%10s]\n",
+				   neigh_node->addr, last_seen_secs,
+				   last_seen_msecs, neigh_node->tq_avg,
+				   neigh_node->rq, batman_if->net_dev->name);
+
+			batman_count++;
+		}
+		spin_unlock_bh(&batman_if->neigh_list_lock);
+	}
+	rcu_read_unlock();
+
+	if ((batman_count == 0))
+		seq_printf(seq, "No batman nodes in range ...\n");
+
+	return 0;
+}
diff --git a/ndp.h b/ndp.h
index 5679f36..26be41f 100644
--- a/ndp.h
+++ b/ndp.h
@@ -10,3 +10,4 @@ uint8_t ndp_fetch_tq(struct batman_packet_ndp *packet,
 void ndp_purge_neighbors(void);
 int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
 			struct batman_if *batman_if, uint8_t *neigh_addr);
+int ndp_seq_print_text(struct seq_file *seq, void *offset);
-- 
1.7.1

