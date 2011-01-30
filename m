Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:17 +0100
Message-Id: <1296362366-3852-10-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 09/18] batman-adv: Output mcast forw table in
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

With this commit the full multicast forwarding table, which is used for
determining whether to forward a multicast data packet or not, can now
be displayed via mcast_forw_table in BATMAN's debugfs directory.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 bat_debugfs.c |    9 +++++
 multicast.c   |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h   |    1 +
 3 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 0e9d435..30cd4e9 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -32,6 +32,7 @@
 #include "soft-interface.h"
 #include "vis.h"
 #include "icmp_socket.h"
+#include "multicast.h"
 
 static struct dentry *bat_debugfs;
 
@@ -250,6 +251,12 @@ static int transtable_local_open(struct inode *inode, struct file *file)
 	return single_open(file, hna_local_seq_print_text, net_dev);
 }
 
+static int mcast_forw_table_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, mcast_forw_table_seq_print_text, net_dev);
+}
+
 static int vis_data_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -278,6 +285,7 @@ static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(softif_neigh, S_IRUGO, softif_neigh_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
+static BAT_DEBUGINFO(mcast_forw_table, S_IRUGO, mcast_forw_table_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
 static struct bat_debuginfo *mesh_debuginfos[] = {
@@ -286,6 +294,7 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 	&bat_debuginfo_softif_neigh,
 	&bat_debuginfo_transtable_global,
 	&bat_debuginfo_transtable_local,
+	&bat_debuginfo_mcast_forw_table,
 	&bat_debuginfo_vis_data,
 	NULL,
 };
diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index b1718c6..b53825f 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -164,6 +164,24 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 	start_mcast_tracker(bat_priv);
 }
 
+static inline int get_remaining_timeout(
+				struct mcast_forw_nexthop_entry *nexthop_entry,
+				struct bat_priv *bat_priv)
+{
+	int tracker_timeout = atomic_read(&bat_priv->mcast_tracker_timeout);
+	if (!tracker_timeout)
+		tracker_timeout = atomic_read(&bat_priv->mcast_tracker_interval)
+				  * TRACKER_TIMEOUT_AUTO_X;
+	if (!tracker_timeout)
+		tracker_timeout = atomic_read(&bat_priv->orig_interval)
+				  * TRACKER_TIMEOUT_AUTO_X / 2;
+
+	tracker_timeout = jiffies_to_msecs(nexthop_entry->timeout) +
+			tracker_timeout - jiffies_to_msecs(jiffies);
+
+	return (tracker_timeout > 0 ? tracker_timeout : 0);
+}
+
 static void prepare_forw_if_entry(struct hlist_head *forw_if_list,
 				  int16_t if_num, uint8_t *neigh_addr)
 {
@@ -961,6 +979,91 @@ ok:
 	return count;
 }
 
+static inline struct batman_if *if_num_to_batman_if(int16_t if_num)
+{
+	struct batman_if *batman_if;
+
+	list_for_each_entry_rcu(batman_if, &if_list, list)
+		if (batman_if->if_num == if_num)
+			return batman_if;
+
+	return NULL;
+}
+
+static void seq_print_if_entry(struct mcast_forw_if_entry *if_entry,
+			       struct bat_priv *bat_priv, struct seq_file *seq)
+{
+	struct mcast_forw_nexthop_entry *nexthop_entry;
+	struct hlist_node *node;
+	struct batman_if *batman_if;
+
+	rcu_read_lock();
+	batman_if = if_num_to_batman_if(if_entry->if_num);
+	if (!batman_if) {
+		rcu_read_unlock();
+		return;
+	}
+
+	seq_printf(seq, "\t\t%s\n", batman_if->net_dev->name);
+	rcu_read_unlock();
+
+	hlist_for_each_entry(nexthop_entry, node,
+			     &if_entry->mcast_nexthop_list, list)
+		seq_printf(seq, "\t\t\t%pM - %i\n", nexthop_entry->neigh_addr,
+			   get_remaining_timeout(nexthop_entry, bat_priv));
+}
+
+static void seq_print_orig_entry(struct mcast_forw_orig_entry *orig_entry,
+				 struct bat_priv *bat_priv,
+				 struct seq_file *seq)
+{
+	struct mcast_forw_if_entry *if_entry;
+	struct hlist_node *node;
+
+	seq_printf(seq, "\t%pM\n", orig_entry->orig);
+	hlist_for_each_entry(if_entry, node, &orig_entry->mcast_if_list,
+			     list)
+		seq_print_if_entry(if_entry, bat_priv, seq);
+}
+
+static void seq_print_table_entry(struct mcast_forw_table_entry *table_entry,
+				  struct bat_priv *bat_priv,
+				  struct seq_file *seq)
+{
+	struct mcast_forw_orig_entry *orig_entry;
+	struct hlist_node *node;
+
+	seq_printf(seq, "%pM\n", table_entry->mcast_addr);
+	hlist_for_each_entry(orig_entry, node, &table_entry->mcast_orig_list,
+			     list)
+		seq_print_orig_entry(orig_entry, bat_priv, seq);
+}
+
+int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct mcast_forw_table_entry *table_entry;
+	struct hlist_node *node;
+
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
+		   SOURCE_VERSION, REVISION_VERSION_STR,
+		   bat_priv->primary_if->net_dev->name,
+		   bat_priv->primary_if->net_dev->dev_addr, net_dev->name);
+	seq_printf(seq, "Multicast group MAC\tOriginator\t"
+			"Outgoing interface\tNexthop - timeout in msecs\n");
+
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
+
+	hlist_for_each_entry(table_entry, node, &bat_priv->mcast_forw_table,
+			     list)
+		seq_print_table_entry(table_entry, bat_priv, seq);
+
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+
+	return 0;
+}
+
 int mcast_init(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->mcast_tracker_work, mcast_tracker_timer);
diff --git a/batman-adv/multicast.h b/batman-adv/multicast.h
index d1a3e83..63d0e97 100644
--- a/batman-adv/multicast.h
+++ b/batman-adv/multicast.h
@@ -29,6 +29,7 @@ int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
 void mcast_tracker_reset(struct bat_priv *bat_priv);
 void route_mcast_tracker_packet(struct sk_buff *tracker_packet,
 				struct bat_priv *bat_priv);
+int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
 
-- 
1.7.2.3

