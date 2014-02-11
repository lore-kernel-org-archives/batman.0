Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:23 +0100
Message-Id: <1392122903-805-24-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 23/23] batman-adv: B.A.T.M.A.N. V - implement
	bat_orig_print API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/bat_v.c b/bat_v.c
index d05d548..6b21afe 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -64,6 +64,103 @@ static void batadv_v_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
 }
 
+/**
+ * batadv_v_orig_print_neigh - print neighbors for the originator table
+ * @orig_node: the orig_node for which the neighbors are printed
+ * @if_outgoing: outgoing interface for these entries
+ * @seq: debugfs table seq_file struct
+ *
+ * Must be called while holding an rcu lock.
+ */
+static void
+batadv_v_orig_print_neigh(struct batadv_orig_node *orig_node,
+			  struct batadv_hard_iface *if_outgoing,
+			  struct seq_file *seq)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_neigh_ifinfo *n_ifinfo;
+
+	hlist_for_each_entry_rcu(neigh_node, &orig_node->neigh_list, list) {
+		n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+		if (!n_ifinfo)
+			continue;
+
+		seq_printf(seq, " %pM (%9u.%1u)",
+			   neigh_node->addr,
+			   n_ifinfo->bat_v.metric / 10,
+			   n_ifinfo->bat_v.metric % 10);
+
+		batadv_neigh_ifinfo_free_ref(n_ifinfo);
+	}
+}
+
+/**
+ * batadv_v_orig_print - print the originator table
+ * @bat_priv: the bat priv with all the soft interface information
+ * @seq: debugfs table seq_file struct
+ * @if_outgoing: the outgoing interface for which this should be printed
+ */
+static void batadv_v_orig_print(struct batadv_priv *bat_priv,
+				struct seq_file *seq,
+				struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	int last_seen_msecs, last_seen_secs;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_ifinfo *n_ifinfo;
+	unsigned long last_seen_jiffies;
+	struct hlist_head *head;
+	int batman_count = 0;
+	uint32_t i;
+
+	seq_printf(seq, "  %-15s %s (%11s) %17s [%10s]: %20s ...\n",
+		   "Originator", "last-seen", "metric", "Nexthop",
+		   "outgoingIF", "Potential nexthops");
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+			neigh_node = batadv_orig_router_get(orig_node,
+							    if_outgoing);
+			if (!neigh_node)
+				continue;
+
+			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
+							   if_outgoing);
+			if (!n_ifinfo)
+				goto next;
+
+			last_seen_jiffies = jiffies - orig_node->last_seen;
+			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+			last_seen_secs = last_seen_msecs / 1000;
+			last_seen_msecs = last_seen_msecs % 1000;
+
+			seq_printf(seq, "%pM %4i.%03is (%9u.%1u) %pM [%10s]:",
+				   orig_node->orig, last_seen_secs,
+				   last_seen_msecs, n_ifinfo->bat_v.metric / 10,
+				   n_ifinfo->bat_v.metric % 10,
+				   neigh_node->addr,
+				   neigh_node->if_incoming->net_dev->name);
+
+			batadv_v_orig_print_neigh(orig_node, if_outgoing, seq);
+			seq_puts(seq, "\n");
+			batman_count++;
+
+next:
+			batadv_neigh_node_free_ref(neigh_node);
+			if (n_ifinfo)
+				batadv_neigh_ifinfo_free_ref(n_ifinfo);
+		}
+		rcu_read_unlock();
+	}
+
+	if (batman_count == 0)
+		seq_puts(seq, "No batman nodes in range ...\n");
+}
+
 static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 			      struct batadv_hard_iface *if_outgoing1,
 			      struct batadv_neigh_node *neigh2,
@@ -112,6 +209,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_primary_iface_set = batadv_v_primary_iface_set,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
+	.bat_orig_print = batadv_v_orig_print,
 	.bat_neigh_cmp = batadv_v_neigh_cmp,
 	.bat_neigh_is_equiv_or_better = batadv_v_neigh_is_eob,
 	.bat_neigh_free = batadv_v_neigh_free,
-- 
1.8.5.3

