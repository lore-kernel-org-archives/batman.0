Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 18 Jun 2012 18:39:26 +0200
Message-Id: <1340037566-24081-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <20120618104108.GA17473@sven-atom.home.narfation.org>
References: <20120618104108.GA17473@sven-atom.home.narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv5] batman-adv: Add the backbone gateway list
	to debugfs
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

This is especially useful if there are no claims yet, but we still want
to know which gateways are using bridge loop avoidance in the network.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
[EDITv2: forgot to rename the function ...]
[EDITv3: add README entry]
[EDITv4: fix style]
[EDITv5: some more style fixes]
---
 README                  |    7 ++---
 bridge_loop_avoidance.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 bridge_loop_avoidance.h |    8 ++++++
 debugfs.c               |   12 +++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 8f3ae4a..a173d2a 100644
--- a/README
+++ b/README
@@ -75,9 +75,10 @@ folder:
 
 There is a special folder for debugging information:
 
-#  ls /sys/kernel/debug/batman_adv/bat0/
-# bla_claim_table    log                socket             transtable_local
-# gateways           originators        transtable_global  vis_data
+# ls /sys/kernel/debug/batman_adv/bat0/
+# bla_backbone_table  log                 transtable_global
+# bla_claim_table     originators         transtable_local
+# gateways            socket              vis_data
 
 Some of the files contain all sort of status information  regard-
 ing  the  mesh  network.  For  example, you can view the table of
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 38aab1e..03fe5ea 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1592,3 +1592,68 @@ out:
 		batadv_hardif_free_ref(primary_if);
 	return ret;
 }
+
+int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hashtable *hash = bat_priv->backbone_hash;
+	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_hard_iface *primary_if;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	int secs, msecs;
+	uint32_t i;
+	bool is_own;
+	int ret = 0;
+	uint8_t *primary_addr;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if) {
+		ret = seq_printf(seq,
+				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = seq_printf(seq,
+				 "BATMAN mesh %s disabled - primary interface not active\n",
+				 net_dev->name);
+		goto out;
+	}
+
+	primary_addr = primary_if->net_dev->dev_addr;
+	seq_printf(seq,
+		   "Backbones announced for the mesh %s (orig %pM, group id %04x)\n",
+		   net_dev->name, primary_addr,
+		   ntohs(bat_priv->claim_dest.group));
+	seq_printf(seq, "   %-17s    %-5s %-9s (%-4s)\n",
+		   "Originator", "VID", "last seen", "CRC");
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
+			msecs = jiffies_to_msecs(jiffies -
+						 backbone_gw->lasttime);
+			secs = msecs / 1000;
+			msecs = msecs % 1000;
+
+			is_own = batadv_compare_eth(backbone_gw->orig,
+						    primary_addr);
+			if (is_own)
+				continue;
+
+			seq_printf(seq,
+				   " * %pM on % 5d % 4i.%03is (%04x)\n",
+				   backbone_gw->orig, backbone_gw->vid,
+				   secs, msecs, backbone_gw->crc);
+		}
+		rcu_read_unlock();
+	}
+out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	return ret;
+}
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 08d13cb..35d39e3 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -26,6 +26,8 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid);
 int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 			      struct batadv_orig_node *orig_node, int hdr_size);
 int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq,
+					     void *offset);
 int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig);
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct batadv_bcast_packet *bcast_packet,
@@ -64,6 +66,12 @@ static inline int batadv_bla_claim_table_seq_print_text(struct seq_file *seq,
 	return 0;
 }
 
+static inline int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq,
+							   void *offset)
+{
+	return 0;
+}
+
 static inline int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
 						 uint8_t *orig)
 {
diff --git a/debugfs.c b/debugfs.c
index e45cf0e..ee8b322 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -263,6 +263,15 @@ static int batadv_bla_claim_table_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_bla_claim_table_seq_print_text,
 			   net_dev);
 }
+
+static int batadv_bla_backbone_table_open(struct inode *inode,
+					  struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, batadv_bla_backbone_table_seq_print_text,
+			   net_dev);
+}
+
 #endif
 
 static int batadv_transtable_local_open(struct inode *inode, struct file *file)
@@ -301,6 +310,8 @@ static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
 			batadv_transtable_global_open);
 #ifdef CONFIG_BATMAN_ADV_BLA
 static BATADV_DEBUGINFO(bla_claim_table, S_IRUGO, batadv_bla_claim_table_open);
+static BATADV_DEBUGINFO(bla_backbone_table, S_IRUGO,
+			batadv_bla_backbone_table_open);
 #endif
 static BATADV_DEBUGINFO(transtable_local, S_IRUGO,
 			batadv_transtable_local_open);
@@ -312,6 +323,7 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_transtable_global,
 #ifdef CONFIG_BATMAN_ADV_BLA
 	&batadv_debuginfo_bla_claim_table,
+	&batadv_debuginfo_bla_backbone_table,
 #endif
 	&batadv_debuginfo_transtable_local,
 	&batadv_debuginfo_vis_data,
-- 
1.7.10

