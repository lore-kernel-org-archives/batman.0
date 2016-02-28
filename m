Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 18:06:50 +0100
Message-ID: <1802876.jh3TWRFVis@sven-edge>
In-Reply-To: <10118093.UzH4NL7sLW@sven-edge>
References: <1456616348.1958.16.camel@gmail.com>
 <10118093.UzH4NL7sLW@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2243328.n727Reu62P";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batctl: page allocation failure
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

--nextPart2243328.n727Reu62P
Content-Type: multipart/mixed; boundary="nextPart53953365.tJZlBSElka"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart53953365.tJZlBSElka
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 February 2016 17:23:18 Sven Eckelmann wrote:
> On Sunday 28 February 2016 00:39:08 Philipp Psurek wrote:
> > Hi all,
> > 
> > I've got this error with
> 
> [..]
> 
> > ----------------------------------
> 
> [..]
> 
> > [Feb28 00:13] batctl: page allocation failure: order:4, mode:0x40d0
> 
> Does this always happen when you use `batctl o` on a system with many
> entries in the originator table? When yes, then you could try the attached
> (very rough) proof-of-concept patch. It is based on v2016.0-92-gd7c9a9e

Hm, looks like I would have to implement better position selection to get this 
really working. Right now it stops printing when a page is full. I have added 
a minor modification that tries to continue the originator output after it was 
stopped in the middle of a print.

Kind regards,
	Sven
=2D-nextPart53953365.tJZlBSElka
Content-Disposition: attachment; filename="0001-TEST-speedup-originator-output-by-using-seq_operatio.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-TEST-speedup-originator-output-by-using-seq_operatio.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 17:13:12 +0100
Subject: [RFC v2] TEST: speedup originator output by using seq_operations
=2D--
 net/batman-adv/bat_iv_ogm.c            |  93 +++++++++++----------------
 net/batman-adv/bat_v.c                 |  91 +++++++++++----------------
 net/batman-adv/bridge_loop_avoidance.c |   4 +-
 net/batman-adv/debugfs.c               |  50 ++++++++++++++-
 net/batman-adv/distributed-arp-table.c |   2 +-
 net/batman-adv/gateway_client.c        |   2 +-
 net/batman-adv/main.c                  |   5 +-
 net/batman-adv/main.h                  |   3 +-
 net/batman-adv/network-coding.c        |   2 +-
 net/batman-adv/originator.c            | 112 +++++++++++++++++++++++++++++----
 net/batman-adv/originator.h            |   7 ++-
 net/batman-adv/translation-table.c     |   4 +-
 net/batman-adv/types.h                 |  30 ++++++++-
 13 files changed, 266 insertions(+), 139 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 2c65668..cddb3e8 100644
=2D-- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1846,74 +1846,54 @@ batadv_iv_ogm_orig_print_neigh(struct batadv_orig_node *orig_node,
 	}
 }
 
=2D/**
=2D * batadv_iv_ogm_orig_print - print the originator table
=2D * @bat_priv: the bat priv with all the soft interface information
=2D * @seq: debugfs table seq_file struct
=2D * @if_outgoing: the outgoing interface for which this should be printed
=2D */
=2Dstatic void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
=2D				     struct seq_file *seq,
=2D				     struct batadv_hard_iface *if_outgoing)
+static void batadv_iv_ogm_oriq_seq_header(struct batadv_priv *bat_priv,
+					  struct seq_file *seq)
 {
=2D	struct batadv_neigh_node *neigh_node;
=2D	struct batadv_hashtable *hash = bat_priv->orig_hash;
=2D	int last_seen_msecs, last_seen_secs;
=2D	struct batadv_orig_node *orig_node;
=2D	struct batadv_neigh_ifinfo *n_ifinfo;
=2D	unsigned long last_seen_jiffies;
=2D	struct hlist_head *head;
=2D	int batman_count = 0;
=2D	u32 i;
=2D
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
+}
 
=2D	for (i = 0; i < hash->size; i++) {
=2D		head = &hash->table[i];
+static void batadv_iv_ogm_orig_seq_show(struct batadv_priv *bat_priv,
+					struct seq_file *seq,
+					struct batadv_orig_node *orig_node,
+					struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	int last_seen_msecs, last_seen_secs;
+	struct batadv_neigh_ifinfo *n_ifinfo;
+	unsigned long last_seen_jiffies;
 
=2D		rcu_read_lock();
=2D		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
=2D			neigh_node = batadv_orig_router_get(orig_node,
=2D							    if_outgoing);
=2D			if (!neigh_node)
=2D				continue;
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	if (!neigh_node)
+		return;
 
=2D			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
=2D							   if_outgoing);
=2D			if (!n_ifinfo)
=2D				goto next;
+	n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+	if (!n_ifinfo)
+		goto next;
 
=2D			if (n_ifinfo->bat_iv.tq_avg == 0)
=2D				goto next;
+	if (n_ifinfo->bat_iv.tq_avg == 0)
+		goto next;
 
=2D			last_seen_jiffies = jiffies - orig_node->last_seen;
=2D			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
=2D			last_seen_secs = last_seen_msecs / 1000;
=2D			last_seen_msecs = last_seen_msecs % 1000;
+	last_seen_jiffies = jiffies - orig_node->last_seen;
+	last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
 
=2D			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
=2D				   orig_node->orig, last_seen_secs,
=2D				   last_seen_msecs, n_ifinfo->bat_iv.tq_avg,
=2D				   neigh_node->addr,
=2D				   neigh_node->if_incoming->net_dev->name);
+	seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
+			orig_node->orig, last_seen_secs,
+			last_seen_msecs, n_ifinfo->bat_iv.tq_avg,
+			neigh_node->addr,
+			neigh_node->if_incoming->net_dev->name);
 
=2D			batadv_iv_ogm_orig_print_neigh(orig_node, if_outgoing,
=2D						       seq);
=2D			seq_puts(seq, "\n");
=2D			batman_count++;
+	batadv_iv_ogm_orig_print_neigh(orig_node, if_outgoing,
+					seq);
+	seq_puts(seq, "\n");
 
 next:
=2D			batadv_neigh_node_put(neigh_node);
=2D			if (n_ifinfo)
=2D				batadv_neigh_ifinfo_put(n_ifinfo);
=2D		}
=2D		rcu_read_unlock();
=2D	}
=2D
=2D	if (batman_count == 0)
=2D		seq_puts(seq, "No batman nodes in range ...\n");
+	batadv_neigh_node_put(neigh_node);
+	if (n_ifinfo)
+		batadv_neigh_ifinfo_put(n_ifinfo);
 }
 
 /**
@@ -2062,7 +2042,8 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
 	.bat_neigh_print = batadv_iv_neigh_print,
=2D	.bat_orig_print = batadv_iv_ogm_orig_print,
+	.bat_orig_seq_header = batadv_iv_ogm_oriq_seq_header,
+	.bat_orig_seq_show = batadv_iv_ogm_orig_seq_show,
 	.bat_orig_free = batadv_iv_ogm_orig_free,
 	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
 	.bat_orig_del_if = batadv_iv_ogm_orig_del_if,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 3315b9a..6d3ff2d 100644
=2D-- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -171,72 +171,52 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
=2D/**
=2D * batadv_v_orig_print - print the originator table
=2D * @bat_priv: the bat priv with all the soft interface information
=2D * @seq: debugfs table seq_file struct
=2D * @if_outgoing: the outgoing interface for which this should be printed
=2D */
=2Dstatic void batadv_v_orig_print(struct batadv_priv *bat_priv,
=2D				struct seq_file *seq,
=2D				struct batadv_hard_iface *if_outgoing)
+static void batadv_v_orig_seq_header(struct batadv_priv *bat_priv,
+				     struct seq_file *seq)
 {
=2D	struct batadv_neigh_node *neigh_node;
=2D	struct batadv_hashtable *hash = bat_priv->orig_hash;
=2D	int last_seen_msecs, last_seen_secs;
=2D	struct batadv_orig_node *orig_node;
=2D	struct batadv_neigh_ifinfo *n_ifinfo;
=2D	unsigned long last_seen_jiffies;
=2D	struct hlist_head *head;
=2D	int batman_count = 0;
=2D	u32 i;
=2D
 	seq_printf(seq, "  %-15s %s (%11s) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "throughput", "Nexthop",
 		   "outgoingIF", "Potential nexthops");
+}
 
=2D	for (i = 0; i < hash->size; i++) {
=2D		head = &hash->table[i];
+static void batadv_v_orig_seq_show(struct batadv_priv *bat_priv,
+				   struct seq_file *seq,
+				   struct batadv_orig_node *orig_node,
+				   struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_neigh_ifinfo *n_ifinfo;
+	int last_seen_msecs, last_seen_secs;
+	unsigned long last_seen_jiffies;
 
=2D		rcu_read_lock();
=2D		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
=2D			neigh_node = batadv_orig_router_get(orig_node,
=2D							    if_outgoing);
=2D			if (!neigh_node)
=2D				continue;
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	if (!neigh_node)
+		return;
 
=2D			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
=2D							   if_outgoing);
=2D			if (!n_ifinfo)
=2D				goto next;
+	n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+	if (!n_ifinfo)
+		goto next;
 
=2D			last_seen_jiffies = jiffies - orig_node->last_seen;
=2D			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
=2D			last_seen_secs = last_seen_msecs / 1000;
=2D			last_seen_msecs = last_seen_msecs % 1000;
+	last_seen_jiffies = jiffies - orig_node->last_seen;
+	last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
 
=2D			seq_printf(seq, "%pM %4i.%03is (%9u.%1u) %pM [%10s]:",
=2D				   orig_node->orig, last_seen_secs,
=2D				   last_seen_msecs,
=2D				   n_ifinfo->bat_v.throughput / 10,
=2D				   n_ifinfo->bat_v.throughput % 10,
=2D				   neigh_node->addr,
=2D				   neigh_node->if_incoming->net_dev->name);
+	seq_printf(seq, "%pM %4i.%03is (%9u.%1u) %pM [%10s]:",
+			orig_node->orig, last_seen_secs,
+			last_seen_msecs,
+			n_ifinfo->bat_v.throughput / 10,
+			n_ifinfo->bat_v.throughput % 10,
+			neigh_node->addr,
+			neigh_node->if_incoming->net_dev->name);
 
=2D			batadv_v_orig_print_neigh(orig_node, if_outgoing, seq);
=2D			seq_puts(seq, "\n");
=2D			batman_count++;
+	batadv_v_orig_print_neigh(orig_node, if_outgoing, seq);
+	seq_puts(seq, "\n");
 
 next:
=2D			batadv_neigh_node_put(neigh_node);
=2D			if (n_ifinfo)
=2D				batadv_neigh_ifinfo_put(n_ifinfo);
=2D		}
=2D		rcu_read_unlock();
=2D	}
=2D
=2D	if (batman_count == 0)
=2D		seq_puts(seq, "No batman nodes in range ...\n");
+	batadv_neigh_node_put(neigh_node);
+	if (n_ifinfo)
+		batadv_neigh_ifinfo_put(n_ifinfo);
 }
 
 static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
@@ -281,7 +261,8 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_hardif_neigh_init = batadv_v_hardif_neigh_init,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
=2D	.bat_orig_print = batadv_v_orig_print,
+	.bat_orig_seq_header = batadv_v_orig_seq_header,
+	.bat_orig_seq_show = batadv_v_orig_seq_show,
 	.bat_neigh_cmp = batadv_v_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_v_neigh_is_sob,
 	.bat_neigh_print = batadv_v_neigh_print,
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 642167f..c00b9b8 100644
=2D-- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1807,7 +1807,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	bool is_own;
 	u8 *primary_addr;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
@@ -1865,7 +1865,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	bool is_own;
 	u8 *primary_addr;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 3dc5208..ddaae44 100644
=2D-- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -269,11 +269,43 @@ static int neighbors_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_hardif_neigh_seq_print_text, net_dev);
 }
 
=2Dstatic int batadv_originators_open(struct inode *inode, struct file *file)
+static const struct seq_operations batadv_orig_seq_ops = {
+	.start  = batadv_orig_seq_start,
+	.next   = batadv_orig_seq_next,
+	.stop   = batadv_orig_seq_stop,
+	.show   = batadv_orig_seq_show,
+};
+
+/**
+ * batadv_seq_open - TODO
+ * @inode: TODO
+ * @f: TODO
+ * @ops: TODO
+ * @size: TODO
+ *
+ * Return: TODO
+ */
+static int batadv_seq_open(struct inode *inode, struct file *f,
+			   const struct seq_operations *ops, int size)
 {
+	struct batadv_seq_private *p;
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
=2D	return single_open(file, batadv_orig_seq_print_text, net_dev);
+	BUG_ON(size < sizeof(*p));
+
+	p = __seq_open_private(f, ops, size);
+	if (p == NULL)
+		return -ENOMEM;
+
+	p->net_dev = net_dev;
+
+	return 0;
+}
+
+static int batadv_originators_open(struct inode *inode, struct file *file)
+{
+	return batadv_seq_open(inode, file, &batadv_orig_seq_ops,
+			       sizeof(struct batadv_seq_hash_iter));
 }
 
 /**
@@ -375,6 +407,18 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 		}					\
 }
 
+#define BATADV_DEBUGINFO_SEQ(_name, _mode, _open)	\
+struct batadv_debuginfo batadv_debuginfo_##_name = {	\
+	.attr = { .name = __stringify(_name),		\
+		  .mode = _mode, },			\
+	.fops = { .owner = THIS_MODULE,			\
+		  .open = _open,			\
+		  .read	= seq_read,			\
+		  .llseek = seq_lseek,			\
+		  .release = seq_release_private,	\
+		}					\
+}
+
 /* the following attributes are general and therefore they will be directly
  * placed in the BATADV_DEBUGFS_SUBDIR subdirectory of debugfs
  */
@@ -387,7 +431,7 @@ static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 
 /* The following attributes are per soft interface */
 static BATADV_DEBUGINFO(neighbors, S_IRUGO, neighbors_open);
=2Dstatic BATADV_DEBUGINFO(originators, S_IRUGO, batadv_originators_open);
+static BATADV_DEBUGINFO_SEQ(originators, S_IRUGO, batadv_originators_open);
 static BATADV_DEBUGINFO(gateways, S_IRUGO, batadv_gateways_open);
 static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
 			batadv_transtable_global_open);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 919a8d2..dc553e5 100644
=2D-- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -809,7 +809,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	int last_seen_msecs, last_seen_secs, last_seen_mins;
 	u32 i;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index c59aff5..1c2360c 100644
=2D-- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -637,7 +637,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_gw_node *gw_node;
 	int gw_count = 0;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d64ddb9..74c81eb 100644
=2D-- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -269,13 +269,14 @@ bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
  * batadv_seq_print_text_primary_if_get - called from debugfs table printing
  *  function that requires the primary interface
  * @seq: debugfs table seq_file struct
+ * @net_dev: batman-adv net_device
  *
  * Return: primary interface if found or NULL otherwise.
  */
 struct batadv_hard_iface *
=2Dbatadv_seq_print_text_primary_if_get(struct seq_file *seq)
+batadv_seq_print_text_primary_if_get(struct seq_file *seq,
+				     struct net_device *net_dev)
 {
=2D	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hard_iface *primary_if;
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e602408..94e9f57 100644
=2D-- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -203,7 +203,8 @@ int batadv_mesh_init(struct net_device *soft_iface);
 void batadv_mesh_free(struct net_device *soft_iface);
 bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr);
 struct batadv_hard_iface *
=2Dbatadv_seq_print_text_primary_if_get(struct seq_file *seq);
+batadv_seq_print_text_primary_if_get(struct seq_file *seq,
+				     struct net_device *net_dev);
 int batadv_max_header_len(void);
 void batadv_skb_set_priority(struct sk_buff *skb, int offset);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 32f9fa1..38fbecc 100644
=2D-- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1905,7 +1905,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_nc_node *nc_node;
 	int i;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e63d6a5..9288202 100644
=2D-- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -698,7 +698,7 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hard_iface *primary_if;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		return 0;
 
@@ -1235,35 +1235,120 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	_batadv_purge_orig(bat_priv);
 }
 
=2Dint batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
+static void batadv_orig_seq_show_header(struct seq_file *seq)
 {
=2D	struct net_device *net_dev = (struct net_device *)seq->private;
=2D	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
 	struct batadv_hard_iface *primary_if;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, iter->p.net_dev);
 	if (!primary_if)
=2D		return 0;
+		return;
 
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s %s)]\n",
 		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
=2D		   primary_if->net_dev->dev_addr, net_dev->name,
+		   primary_if->net_dev->dev_addr, iter->p.net_dev->name,
 		   bat_priv->bat_algo_ops->name);
 
 	batadv_hardif_put(primary_if);
 
=2D	if (!bat_priv->bat_algo_ops->bat_orig_print) {
=2D		seq_puts(seq,
=2D			 "No printing function for this routing protocol\n");
+	if (bat_priv->bat_algo_ops->bat_orig_seq_header)
+		bat_priv->bat_algo_ops->bat_orig_seq_header(bat_priv, seq);
+}
+
+static void *batadv_orig_seq_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+	loff_t cur = 0;
+
+	iter->bucket = 0;
+	iter->entry = NULL;
+
+	for (; iter->bucket < hash->size; iter->bucket++) {
+		head = &hash->table[iter->bucket];
+		iter->entry = rcu_dereference_raw(hlist_first_rcu(head));
+
+		if (iter->entry) {
+			cur++;
+			if (cur == pos)
+				return iter->entry;
+		}
+	}
+
+	return NULL;
+}
+
+void *batadv_orig_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(RCU)
+{
+	rcu_read_lock();
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+	return batadv_orig_seq_get_idx(seq, *pos);
+}
+
+void *batadv_orig_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+
+	if (v == SEQ_START_TOKEN) {
+		iter->bucket = 0;
+		iter->entry = NULL;
+		/* TODO seq_puts(seq, "No batman nodes in range ...\n"); */
+	} else {
+		iter->entry = rcu_dereference_raw(hlist_next_rcu(iter->entry));
+		if (!iter->entry)
+			iter->bucket++;
+	}
+
+	if (iter->entry)
+		return iter->entry;
+
+	for (; iter->bucket < hash->size; iter->bucket++) {
+		head = &hash->table[iter->bucket];
+		iter->entry = rcu_dereference_raw(hlist_first_rcu(head));
+
+		if (iter->entry)
+			return iter->entry;
+	}
+
+	return NULL;
+}
+
+int batadv_orig_seq_show(struct seq_file *seq, void *v)
+{
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
+	struct batadv_orig_node *orig_node;
+
+	if (v == SEQ_START_TOKEN) {
+		batadv_orig_seq_show_header(seq);
 		return 0;
 	}
 
=2D	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq,
=2D					       BATADV_IF_DEFAULT);
+	orig_node = hlist_entry(iter->entry, struct batadv_orig_node, hash_entry);
+
+	if (bat_priv->bat_algo_ops->bat_orig_seq_show)
+		bat_priv->bat_algo_ops->bat_orig_seq_show(bat_priv, seq,
+							  orig_node,
+							  BATADV_IF_DEFAULT);
 
 	return 0;
 }
 
+void batadv_orig_seq_stop(struct seq_file *seq, void *v)
+	__releases(RCU)
+{
+	rcu_read_unlock();
+}
+
 /**
  * batadv_orig_hardif_seq_print_text - writes originator infos for a specific
  *  outgoing interface
@@ -1285,6 +1370,8 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
+	/*
+	TODO
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 	if (!bat_priv->bat_algo_ops->bat_orig_print) {
 		seq_puts(seq,
@@ -1303,6 +1390,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 		   hard_iface->soft_iface->name, bat_priv->bat_algo_ops->name);
 
 	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, hard_iface);
+	*/
 
 out:
 	if (hard_iface)
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 64a8951..ba5a915 100644
=2D-- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -29,6 +29,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+#include "hard-interface.h"
 #include "hash.h"
 
 struct seq_file;
@@ -71,7 +72,11 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
 void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo);
 
=2Dint batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+void *batadv_orig_seq_start(struct seq_file *seq, loff_t *pos);
+void *batadv_orig_seq_next(struct seq_file *seq, void *v, loff_t *pos);
+int batadv_orig_seq_show(struct seq_file *seq, void *v);
+void batadv_orig_seq_stop(struct seq_file *seq, void *v);
+
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2ed55f4..eab36a9 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1001,7 +1001,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	bool no_purge;
 	u16 np_flag = BATADV_TT_CLIENT_NOPURGE;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
@@ -1699,7 +1699,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_head *head;
 	u32 i;
 
=2D	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9abfb3e..764332e 100644
=2D-- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1297,8 +1297,12 @@ struct batadv_algo_ops {
 	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
 	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
=2D	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
=2D			       struct batadv_hard_iface *hard_iface);
+	void (*bat_orig_seq_header)(struct batadv_priv *priv,
+				    struct seq_file *seq);
+	void (*bat_orig_seq_show)(struct batadv_priv *priv,
+				  struct seq_file *seq,
+				  struct batadv_orig_node *orig_node,
+				  struct batadv_hard_iface *if_outgoing);
 	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
 	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num);
@@ -1403,4 +1407,26 @@ enum batadv_tvlv_handler_flags {
 	BATADV_TVLV_HANDLER_OGM_CALLED = BIT(2),
 };
 
+/**
+ * struct batadv_seq_private - private data of seq_open
+ * @net_dev: network device the seq private data belongs to
+ */
+struct batadv_seq_private {
+	struct net_device *net_dev;
+};
+
+/**
+ * struct batadv_seq_hash_iter - private data of seq_open for hash iterators
+ * @p: standard batadv_seq_private data
+ * @header_shown: whether header was already shown
+ * @bucket: current hash bucket
+ * @entry: current hash entry
+ */
+struct batadv_seq_hash_iter {
+	struct batadv_seq_private p;
+	int header_shown;
+	u32 bucket;
+	struct hlist_node *entry;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */

=2D-nextPart53953365.tJZlBSElka--
This is a multi-part message in MIME format.

--nextPart53953365.tJZlBSElka
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 February 2016 17:23:18 Sven Eckelmann wrote:
> On Sunday 28 February 2016 00:39:08 Philipp Psurek wrote:
> > Hi all,
> > 
> > I've got this error with
> 
> [..]
> 
> > ----------------------------------
> 
> [..]
> 
> > [Feb28 00:13] batctl: page allocation failure: order:4, mode:0x40d0
> 
> Does this always happen when you use `batctl o` on a system with many
> entries in the originator table? When yes, then you could try the attached
> (very rough) proof-of-concept patch. It is based on v2016.0-92-gd7c9a9e

Hm, looks like I would have to implement better position selection to get this 
really working. Right now it stops printing when a page is full. I have added 
a minor modification that tries to continue the originator output after it was 
stopped in the middle of a print.

Kind regards,
	Sven
--nextPart53953365.tJZlBSElka
Content-Disposition: attachment; filename="0001-TEST-speedup-originator-output-by-using-seq_operatio.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-TEST-speedup-originator-output-by-using-seq_operatio.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 17:13:12 +0100
Subject: [RFC v2] TEST: speedup originator output by using seq_operations
---
 net/batman-adv/bat_iv_ogm.c            |  93 +++++++++++----------------
 net/batman-adv/bat_v.c                 |  91 +++++++++++----------------
 net/batman-adv/bridge_loop_avoidance.c |   4 +-
 net/batman-adv/debugfs.c               |  50 ++++++++++++++-
 net/batman-adv/distributed-arp-table.c |   2 +-
 net/batman-adv/gateway_client.c        |   2 +-
 net/batman-adv/main.c                  |   5 +-
 net/batman-adv/main.h                  |   3 +-
 net/batman-adv/network-coding.c        |   2 +-
 net/batman-adv/originator.c            | 112 +++++++++++++++++++++++++++++----
 net/batman-adv/originator.h            |   7 ++-
 net/batman-adv/translation-table.c     |   4 +-
 net/batman-adv/types.h                 |  30 ++++++++-
 13 files changed, 266 insertions(+), 139 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 2c65668..cddb3e8 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1846,74 +1846,54 @@ batadv_iv_ogm_orig_print_neigh(struct batadv_orig_node *orig_node,
 	}
 }
 
-/**
- * batadv_iv_ogm_orig_print - print the originator table
- * @bat_priv: the bat priv with all the soft interface information
- * @seq: debugfs table seq_file struct
- * @if_outgoing: the outgoing interface for which this should be printed
- */
-static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
-				     struct seq_file *seq,
-				     struct batadv_hard_iface *if_outgoing)
+static void batadv_iv_ogm_oriq_seq_header(struct batadv_priv *bat_priv,
+					  struct seq_file *seq)
 {
-	struct batadv_neigh_node *neigh_node;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	int last_seen_msecs, last_seen_secs;
-	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_ifinfo *n_ifinfo;
-	unsigned long last_seen_jiffies;
-	struct hlist_head *head;
-	int batman_count = 0;
-	u32 i;
-
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
+}
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+static void batadv_iv_ogm_orig_seq_show(struct batadv_priv *bat_priv,
+					struct seq_file *seq,
+					struct batadv_orig_node *orig_node,
+					struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	int last_seen_msecs, last_seen_secs;
+	struct batadv_neigh_ifinfo *n_ifinfo;
+	unsigned long last_seen_jiffies;
 
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			neigh_node = batadv_orig_router_get(orig_node,
-							    if_outgoing);
-			if (!neigh_node)
-				continue;
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	if (!neigh_node)
+		return;
 
-			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
-							   if_outgoing);
-			if (!n_ifinfo)
-				goto next;
+	n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+	if (!n_ifinfo)
+		goto next;
 
-			if (n_ifinfo->bat_iv.tq_avg == 0)
-				goto next;
+	if (n_ifinfo->bat_iv.tq_avg == 0)
+		goto next;
 
-			last_seen_jiffies = jiffies - orig_node->last_seen;
-			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
-			last_seen_secs = last_seen_msecs / 1000;
-			last_seen_msecs = last_seen_msecs % 1000;
+	last_seen_jiffies = jiffies - orig_node->last_seen;
+	last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
 
-			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
-				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs, n_ifinfo->bat_iv.tq_avg,
-				   neigh_node->addr,
-				   neigh_node->if_incoming->net_dev->name);
+	seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
+			orig_node->orig, last_seen_secs,
+			last_seen_msecs, n_ifinfo->bat_iv.tq_avg,
+			neigh_node->addr,
+			neigh_node->if_incoming->net_dev->name);
 
-			batadv_iv_ogm_orig_print_neigh(orig_node, if_outgoing,
-						       seq);
-			seq_puts(seq, "\n");
-			batman_count++;
+	batadv_iv_ogm_orig_print_neigh(orig_node, if_outgoing,
+					seq);
+	seq_puts(seq, "\n");
 
 next:
-			batadv_neigh_node_put(neigh_node);
-			if (n_ifinfo)
-				batadv_neigh_ifinfo_put(n_ifinfo);
-		}
-		rcu_read_unlock();
-	}
-
-	if (batman_count == 0)
-		seq_puts(seq, "No batman nodes in range ...\n");
+	batadv_neigh_node_put(neigh_node);
+	if (n_ifinfo)
+		batadv_neigh_ifinfo_put(n_ifinfo);
 }
 
 /**
@@ -2062,7 +2042,8 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
 	.bat_neigh_print = batadv_iv_neigh_print,
-	.bat_orig_print = batadv_iv_ogm_orig_print,
+	.bat_orig_seq_header = batadv_iv_ogm_oriq_seq_header,
+	.bat_orig_seq_show = batadv_iv_ogm_orig_seq_show,
 	.bat_orig_free = batadv_iv_ogm_orig_free,
 	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
 	.bat_orig_del_if = batadv_iv_ogm_orig_del_if,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 3315b9a..6d3ff2d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -171,72 +171,52 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
-/**
- * batadv_v_orig_print - print the originator table
- * @bat_priv: the bat priv with all the soft interface information
- * @seq: debugfs table seq_file struct
- * @if_outgoing: the outgoing interface for which this should be printed
- */
-static void batadv_v_orig_print(struct batadv_priv *bat_priv,
-				struct seq_file *seq,
-				struct batadv_hard_iface *if_outgoing)
+static void batadv_v_orig_seq_header(struct batadv_priv *bat_priv,
+				     struct seq_file *seq)
 {
-	struct batadv_neigh_node *neigh_node;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	int last_seen_msecs, last_seen_secs;
-	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_ifinfo *n_ifinfo;
-	unsigned long last_seen_jiffies;
-	struct hlist_head *head;
-	int batman_count = 0;
-	u32 i;
-
 	seq_printf(seq, "  %-15s %s (%11s) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "throughput", "Nexthop",
 		   "outgoingIF", "Potential nexthops");
+}
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+static void batadv_v_orig_seq_show(struct batadv_priv *bat_priv,
+				   struct seq_file *seq,
+				   struct batadv_orig_node *orig_node,
+				   struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_neigh_ifinfo *n_ifinfo;
+	int last_seen_msecs, last_seen_secs;
+	unsigned long last_seen_jiffies;
 
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			neigh_node = batadv_orig_router_get(orig_node,
-							    if_outgoing);
-			if (!neigh_node)
-				continue;
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	if (!neigh_node)
+		return;
 
-			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
-							   if_outgoing);
-			if (!n_ifinfo)
-				goto next;
+	n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+	if (!n_ifinfo)
+		goto next;
 
-			last_seen_jiffies = jiffies - orig_node->last_seen;
-			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
-			last_seen_secs = last_seen_msecs / 1000;
-			last_seen_msecs = last_seen_msecs % 1000;
+	last_seen_jiffies = jiffies - orig_node->last_seen;
+	last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
 
-			seq_printf(seq, "%pM %4i.%03is (%9u.%1u) %pM [%10s]:",
-				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs,
-				   n_ifinfo->bat_v.throughput / 10,
-				   n_ifinfo->bat_v.throughput % 10,
-				   neigh_node->addr,
-				   neigh_node->if_incoming->net_dev->name);
+	seq_printf(seq, "%pM %4i.%03is (%9u.%1u) %pM [%10s]:",
+			orig_node->orig, last_seen_secs,
+			last_seen_msecs,
+			n_ifinfo->bat_v.throughput / 10,
+			n_ifinfo->bat_v.throughput % 10,
+			neigh_node->addr,
+			neigh_node->if_incoming->net_dev->name);
 
-			batadv_v_orig_print_neigh(orig_node, if_outgoing, seq);
-			seq_puts(seq, "\n");
-			batman_count++;
+	batadv_v_orig_print_neigh(orig_node, if_outgoing, seq);
+	seq_puts(seq, "\n");
 
 next:
-			batadv_neigh_node_put(neigh_node);
-			if (n_ifinfo)
-				batadv_neigh_ifinfo_put(n_ifinfo);
-		}
-		rcu_read_unlock();
-	}
-
-	if (batman_count == 0)
-		seq_puts(seq, "No batman nodes in range ...\n");
+	batadv_neigh_node_put(neigh_node);
+	if (n_ifinfo)
+		batadv_neigh_ifinfo_put(n_ifinfo);
 }
 
 static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
@@ -281,7 +261,8 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_hardif_neigh_init = batadv_v_hardif_neigh_init,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
-	.bat_orig_print = batadv_v_orig_print,
+	.bat_orig_seq_header = batadv_v_orig_seq_header,
+	.bat_orig_seq_show = batadv_v_orig_seq_show,
 	.bat_neigh_cmp = batadv_v_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_v_neigh_is_sob,
 	.bat_neigh_print = batadv_v_neigh_print,
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 642167f..c00b9b8 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1807,7 +1807,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	bool is_own;
 	u8 *primary_addr;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
@@ -1865,7 +1865,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	bool is_own;
 	u8 *primary_addr;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 3dc5208..ddaae44 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -269,11 +269,43 @@ static int neighbors_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_hardif_neigh_seq_print_text, net_dev);
 }
 
-static int batadv_originators_open(struct inode *inode, struct file *file)
+static const struct seq_operations batadv_orig_seq_ops = {
+	.start  = batadv_orig_seq_start,
+	.next   = batadv_orig_seq_next,
+	.stop   = batadv_orig_seq_stop,
+	.show   = batadv_orig_seq_show,
+};
+
+/**
+ * batadv_seq_open - TODO
+ * @inode: TODO
+ * @f: TODO
+ * @ops: TODO
+ * @size: TODO
+ *
+ * Return: TODO
+ */
+static int batadv_seq_open(struct inode *inode, struct file *f,
+			   const struct seq_operations *ops, int size)
 {
+	struct batadv_seq_private *p;
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
-	return single_open(file, batadv_orig_seq_print_text, net_dev);
+	BUG_ON(size < sizeof(*p));
+
+	p = __seq_open_private(f, ops, size);
+	if (p == NULL)
+		return -ENOMEM;
+
+	p->net_dev = net_dev;
+
+	return 0;
+}
+
+static int batadv_originators_open(struct inode *inode, struct file *file)
+{
+	return batadv_seq_open(inode, file, &batadv_orig_seq_ops,
+			       sizeof(struct batadv_seq_hash_iter));
 }
 
 /**
@@ -375,6 +407,18 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 		}					\
 }
 
+#define BATADV_DEBUGINFO_SEQ(_name, _mode, _open)	\
+struct batadv_debuginfo batadv_debuginfo_##_name = {	\
+	.attr = { .name = __stringify(_name),		\
+		  .mode = _mode, },			\
+	.fops = { .owner = THIS_MODULE,			\
+		  .open = _open,			\
+		  .read	= seq_read,			\
+		  .llseek = seq_lseek,			\
+		  .release = seq_release_private,	\
+		}					\
+}
+
 /* the following attributes are general and therefore they will be directly
  * placed in the BATADV_DEBUGFS_SUBDIR subdirectory of debugfs
  */
@@ -387,7 +431,7 @@ static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 
 /* The following attributes are per soft interface */
 static BATADV_DEBUGINFO(neighbors, S_IRUGO, neighbors_open);
-static BATADV_DEBUGINFO(originators, S_IRUGO, batadv_originators_open);
+static BATADV_DEBUGINFO_SEQ(originators, S_IRUGO, batadv_originators_open);
 static BATADV_DEBUGINFO(gateways, S_IRUGO, batadv_gateways_open);
 static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
 			batadv_transtable_global_open);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 919a8d2..dc553e5 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -809,7 +809,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	int last_seen_msecs, last_seen_secs, last_seen_mins;
 	u32 i;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index c59aff5..1c2360c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -637,7 +637,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_gw_node *gw_node;
 	int gw_count = 0;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d64ddb9..74c81eb 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -269,13 +269,14 @@ bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
  * batadv_seq_print_text_primary_if_get - called from debugfs table printing
  *  function that requires the primary interface
  * @seq: debugfs table seq_file struct
+ * @net_dev: batman-adv net_device
  *
  * Return: primary interface if found or NULL otherwise.
  */
 struct batadv_hard_iface *
-batadv_seq_print_text_primary_if_get(struct seq_file *seq)
+batadv_seq_print_text_primary_if_get(struct seq_file *seq,
+				     struct net_device *net_dev)
 {
-	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hard_iface *primary_if;
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e602408..94e9f57 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -203,7 +203,8 @@ int batadv_mesh_init(struct net_device *soft_iface);
 void batadv_mesh_free(struct net_device *soft_iface);
 bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr);
 struct batadv_hard_iface *
-batadv_seq_print_text_primary_if_get(struct seq_file *seq);
+batadv_seq_print_text_primary_if_get(struct seq_file *seq,
+				     struct net_device *net_dev);
 int batadv_max_header_len(void);
 void batadv_skb_set_priority(struct sk_buff *skb, int offset);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 32f9fa1..38fbecc 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1905,7 +1905,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_nc_node *nc_node;
 	int i;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e63d6a5..9288202 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -698,7 +698,7 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hard_iface *primary_if;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		return 0;
 
@@ -1235,35 +1235,120 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	_batadv_purge_orig(bat_priv);
 }
 
-int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
+static void batadv_orig_seq_show_header(struct seq_file *seq)
 {
-	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
 	struct batadv_hard_iface *primary_if;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, iter->p.net_dev);
 	if (!primary_if)
-		return 0;
+		return;
 
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s %s)]\n",
 		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
-		   primary_if->net_dev->dev_addr, net_dev->name,
+		   primary_if->net_dev->dev_addr, iter->p.net_dev->name,
 		   bat_priv->bat_algo_ops->name);
 
 	batadv_hardif_put(primary_if);
 
-	if (!bat_priv->bat_algo_ops->bat_orig_print) {
-		seq_puts(seq,
-			 "No printing function for this routing protocol\n");
+	if (bat_priv->bat_algo_ops->bat_orig_seq_header)
+		bat_priv->bat_algo_ops->bat_orig_seq_header(bat_priv, seq);
+}
+
+static void *batadv_orig_seq_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+	loff_t cur = 0;
+
+	iter->bucket = 0;
+	iter->entry = NULL;
+
+	for (; iter->bucket < hash->size; iter->bucket++) {
+		head = &hash->table[iter->bucket];
+		iter->entry = rcu_dereference_raw(hlist_first_rcu(head));
+
+		if (iter->entry) {
+			cur++;
+			if (cur == pos)
+				return iter->entry;
+		}
+	}
+
+	return NULL;
+}
+
+void *batadv_orig_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(RCU)
+{
+	rcu_read_lock();
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+	return batadv_orig_seq_get_idx(seq, *pos);
+}
+
+void *batadv_orig_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+
+	if (v == SEQ_START_TOKEN) {
+		iter->bucket = 0;
+		iter->entry = NULL;
+		/* TODO seq_puts(seq, "No batman nodes in range ...\n"); */
+	} else {
+		iter->entry = rcu_dereference_raw(hlist_next_rcu(iter->entry));
+		if (!iter->entry)
+			iter->bucket++;
+	}
+
+	if (iter->entry)
+		return iter->entry;
+
+	for (; iter->bucket < hash->size; iter->bucket++) {
+		head = &hash->table[iter->bucket];
+		iter->entry = rcu_dereference_raw(hlist_first_rcu(head));
+
+		if (iter->entry)
+			return iter->entry;
+	}
+
+	return NULL;
+}
+
+int batadv_orig_seq_show(struct seq_file *seq, void *v)
+{
+	struct batadv_seq_hash_iter *iter = seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(iter->p.net_dev);
+	struct batadv_orig_node *orig_node;
+
+	if (v == SEQ_START_TOKEN) {
+		batadv_orig_seq_show_header(seq);
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq,
-					       BATADV_IF_DEFAULT);
+	orig_node = hlist_entry(iter->entry, struct batadv_orig_node, hash_entry);
+
+	if (bat_priv->bat_algo_ops->bat_orig_seq_show)
+		bat_priv->bat_algo_ops->bat_orig_seq_show(bat_priv, seq,
+							  orig_node,
+							  BATADV_IF_DEFAULT);
 
 	return 0;
 }
 
+void batadv_orig_seq_stop(struct seq_file *seq, void *v)
+	__releases(RCU)
+{
+	rcu_read_unlock();
+}
+
 /**
  * batadv_orig_hardif_seq_print_text - writes originator infos for a specific
  *  outgoing interface
@@ -1285,6 +1370,8 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
+	/*
+	TODO
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 	if (!bat_priv->bat_algo_ops->bat_orig_print) {
 		seq_puts(seq,
@@ -1303,6 +1390,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 		   hard_iface->soft_iface->name, bat_priv->bat_algo_ops->name);
 
 	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, hard_iface);
+	*/
 
 out:
 	if (hard_iface)
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 64a8951..ba5a915 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -29,6 +29,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+#include "hard-interface.h"
 #include "hash.h"
 
 struct seq_file;
@@ -71,7 +72,11 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
 void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo);
 
-int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+void *batadv_orig_seq_start(struct seq_file *seq, loff_t *pos);
+void *batadv_orig_seq_next(struct seq_file *seq, void *v, loff_t *pos);
+int batadv_orig_seq_show(struct seq_file *seq, void *v);
+void batadv_orig_seq_stop(struct seq_file *seq, void *v);
+
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2ed55f4..eab36a9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1001,7 +1001,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	bool no_purge;
 	u16 np_flag = BATADV_TT_CLIENT_NOPURGE;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
@@ -1699,7 +1699,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_head *head;
 	u32 i;
 
-	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	primary_if = batadv_seq_print_text_primary_if_get(seq, net_dev);
 	if (!primary_if)
 		goto out;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9abfb3e..764332e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1297,8 +1297,12 @@ struct batadv_algo_ops {
 	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
 	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 	/* orig_node handling API */
-	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
-			       struct batadv_hard_iface *hard_iface);
+	void (*bat_orig_seq_header)(struct batadv_priv *priv,
+				    struct seq_file *seq);
+	void (*bat_orig_seq_show)(struct batadv_priv *priv,
+				  struct seq_file *seq,
+				  struct batadv_orig_node *orig_node,
+				  struct batadv_hard_iface *if_outgoing);
 	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
 	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num);
@@ -1403,4 +1407,26 @@ enum batadv_tvlv_handler_flags {
 	BATADV_TVLV_HANDLER_OGM_CALLED = BIT(2),
 };
 
+/**
+ * struct batadv_seq_private - private data of seq_open
+ * @net_dev: network device the seq private data belongs to
+ */
+struct batadv_seq_private {
+	struct net_device *net_dev;
+};
+
+/**
+ * struct batadv_seq_hash_iter - private data of seq_open for hash iterators
+ * @p: standard batadv_seq_private data
+ * @header_shown: whether header was already shown
+ * @bucket: current hash bucket
+ * @entry: current hash entry
+ */
+struct batadv_seq_hash_iter {
+	struct batadv_seq_private p;
+	int header_shown;
+	u32 bucket;
+	struct hlist_node *entry;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */

--nextPart53953365.tJZlBSElka--

--nextPart2243328.n727Reu62P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0ykqAAoJEF2HCgfBJntGMNAP/3nSgCtQVbWj0vWsI267H35S
LgrAOOVOWEiZCgN4xCNY6Uqd0IcBnjVR5ViKAjbzLWWVzUaXVADTwuXXcvr1PXnL
9bFwJlYyKax8gP61R/D25oO0SefYPGPQkRoslkNeWHStiU9fCHT2EZY02BEOL8vW
eoZ9ei5fvq1VQChLjcC0Hab4ZO4fyAJ9lRMXGcYAq4ssD4cIArvbYMQW2GHoc9RI
87KCpXQJKI8uFq4GMsTyK6hy9StgZV4IJ7jhrcZ6btj8D9GrlcWli9V2gFqELTub
7Q2+b5MJ77E3g/9CiYb2CEY0K/PlaPdUGFpJww/iPy5KaonCY8UJKaWf8NPBWyyk
l+2q2W61xDBAZ3LvS8Y5LeQSoD84IBaMoVb3PuqWFYnI5+ksz3T0hY3WCzCLIOef
FfIl2HHy7sUnghhoSaa9BTzhR8S2sockpGHfRq1BBuK6PaZWFwYcwBB6T6djmIXZ
Ao8O5qCV/numdHAAIJBY+qtFUgQKLYXOghyaI4O3OTMT4FiBz+Ipt0fFnkrBoE87
zhyTee2d9g9/D7lfTP4w/uM5HG/ZghvWwNpLDTfY3Smt1Q91fSehDucZth9FJ03F
vltk71UoNt0I5yT87O3Gj/maf2xzOLWd2EsH50U0afgvQigqpNo1rfqEn3KoqlaT
obnP/qtNdmtMdgiNfn5H
=AA2s
-----END PGP SIGNATURE-----

--nextPart2243328.n727Reu62P--

