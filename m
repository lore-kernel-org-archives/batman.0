Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 15 Jul 2014 04:22:53 +0200
Message-Id: <1405390973-5066-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1405390973-5066-1-git-send-email-linus.luessing@web.de>
References: <1405390973-5066-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 2/2] batman-adv: Add debugfs table for
	mcast flags
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

This patch adds a debugfs table with originators and their according
multicast flags to help users figure out why multicast optimizations
might be enabled or disabled for them.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Changes in v4:
* initial {ad,e}dition of this patch

 debugfs.c   |   21 +++++++++++++++++++
 multicast.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h |    2 ++
 3 files changed, 88 insertions(+)

diff --git a/debugfs.c b/debugfs.c
index a12e25e..957c303 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -30,6 +30,7 @@
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "network-coding.h"
+#include "multicast.h"
 
 static struct dentry *batadv_debugfs;
 
@@ -332,6 +333,20 @@ static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
 }
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_MCAST
+/**
+ * batadv_dat_cache_open - Prepare file handler for reads from dat_chache
+ * @inode: inode which was opened
+ * @file: file handle to be initialized
+ */
+static int batadv_mcast_flags_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
+	return single_open(file, batadv_mcast_flags_seq_print_text, net_dev);
+}
+#endif
+
 #define BATADV_DEBUGINFO(_name, _mode, _open)		\
 struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 	.attr = { .name = __stringify(_name),		\
@@ -372,6 +387,9 @@ static BATADV_DEBUGINFO(transtable_local, S_IRUGO,
 #ifdef CONFIG_BATMAN_ADV_NC
 static BATADV_DEBUGINFO(nc_nodes, S_IRUGO, batadv_nc_nodes_open);
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST
+static BATADV_DEBUGINFO(mcast_flags, S_IRUGO, batadv_mcast_flags_open);
+#endif
 
 static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_originators,
@@ -388,6 +406,9 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 #ifdef CONFIG_BATMAN_ADV_NC
 	&batadv_debuginfo_nc_nodes,
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	&batadv_debuginfo_mcast_flags,
+#endif
 	NULL,
 };
 
diff --git a/multicast.c b/multicast.c
index 5e8a931..46a293f 100644
--- a/multicast.c
+++ b/multicast.c
@@ -877,6 +877,71 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_mcast_flags_seq_print_text - print the mcast flags of other nodes
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * This prints a table of (primary) originators and their according
+ * multicast flags, including our own in the header.
+ */
+int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *primary_if;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_orig_node *orig_node;
+	struct hlist_head *head;
+	uint8_t flags;
+	uint32_t i;
+
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
+		return 0;
+
+	flags = bat_priv->mcast.flags;
+
+	seq_printf(seq, "Multicast flags (own flags: [%c%c%c])\n",
+		   flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		   flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		   flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+	seq_printf(seq, "       %-10s %s\n", "Originator", "Flags");
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+			if (!(orig_node->capa_initialized &
+			      BATADV_ORIG_CAPA_HAS_MCAST))
+				continue;
+
+			flags = orig_node->mcast_flags;
+
+			if (!(orig_node->capabilities &
+			      BATADV_ORIG_CAPA_HAS_MCAST)) {
+				seq_printf(seq, "%pM -\n", orig_node->orig);
+				continue;
+			}
+
+			seq_printf(seq, "%pM [%c%c%c]\n", orig_node->orig,
+				   (flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ?
+				    'U' : '.'),
+				   (flags & BATADV_MCAST_WANT_ALL_IPV4 ?
+				    '4' : '.'),
+				   (flags & BATADV_MCAST_WANT_ALL_IPV6 ?
+				    '6' : '.'));
+		}
+		rcu_read_unlock();
+	}
+
+	batadv_hardif_free_ref(primary_if);
+
+	return 0;
+}
+
+
+/**
  * batadv_mcast_free - free the multicast optimizations structures
  * @bat_priv: the bat priv with all the soft interface information
  */
diff --git a/multicast.h b/multicast.h
index 73b5d45..5344160 100644
--- a/multicast.h
+++ b/multicast.h
@@ -42,6 +42,8 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 void batadv_mcast_init(struct batadv_priv *bat_priv);
 
+int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset);
+
 void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
-- 
1.7.10.4

