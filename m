Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:26 +0100
Message-Id: <1296362366-3852-19-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 18/18] batman-adv: Use rcu-locking for
	multicast forwarding table
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


Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c |  102 +++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 64 insertions(+), 38 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index 24bc85a..f85d876 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -108,6 +108,7 @@ struct mcast_forw_nexthop_entry {
 	struct hlist_node list;
 	uint8_t neigh_addr[6];
 	unsigned long timeout;	/* old jiffies value */
+	struct rcu_head rcu;
 };
 
 struct mcast_forw_if_entry {
@@ -115,6 +116,7 @@ struct mcast_forw_if_entry {
 	int16_t if_num;
 	int num_nexthops;
 	struct hlist_head mcast_nexthop_list;
+	struct rcu_head rcu;
 };
 
 struct mcast_forw_orig_entry {
@@ -123,12 +125,14 @@ struct mcast_forw_orig_entry {
 	uint32_t last_mcast_seqno;
 	unsigned long mcast_bits[NUM_WORDS];
 	struct hlist_head mcast_if_list;
+	struct rcu_head rcu;
 };
 
 struct mcast_forw_table_entry {
 	struct hlist_node list;
 	uint8_t mcast_addr[6];
 	struct hlist_head mcast_orig_list;
+	struct rcu_head rcu;
 };
 
 /* how long to wait until sending a multicast tracker packet */
@@ -861,6 +865,39 @@ free:
 	}
 }
 
+static void nexthop_entry_free(struct rcu_head *rcu)
+{
+	struct mcast_forw_nexthop_entry *nexthop_entry;
+
+	nexthop_entry = container_of(rcu, struct mcast_forw_nexthop_entry,
+				     rcu);
+	kfree(nexthop_entry);
+}
+
+static void if_entry_free(struct rcu_head *rcu)
+{
+	struct mcast_forw_if_entry *if_entry;
+
+	if_entry = container_of(rcu, struct mcast_forw_if_entry, rcu);
+	kfree(if_entry);
+}
+
+static void orig_entry_free(struct rcu_head *rcu)
+{
+	struct mcast_forw_orig_entry *orig_entry;
+
+	orig_entry = container_of(rcu, struct mcast_forw_orig_entry, rcu);
+	kfree(orig_entry);
+}
+
+static void table_entry_free(struct rcu_head *rcu)
+{
+	struct mcast_forw_table_entry *table_entry;
+
+	table_entry = container_of(rcu, struct mcast_forw_table_entry, rcu);
+	kfree(table_entry);
+}
+
 static void purge_mcast_nexthop_list(struct hlist_head *mcast_nexthop_list,
 				     int *num_nexthops,
 				     struct bat_priv *bat_priv)
@@ -873,8 +910,8 @@ static void purge_mcast_nexthop_list(struct hlist_head *mcast_nexthop_list,
 		if (get_remaining_timeout(nexthop_entry, bat_priv))
 			continue;
 
-		hlist_del(&nexthop_entry->list);
-		kfree(nexthop_entry);
+		hlist_del_rcu(&nexthop_entry->list);
+		call_rcu(&nexthop_entry->rcu, nexthop_entry_free);
 		*num_nexthops = *num_nexthops - 1;
 	}
 }
@@ -894,8 +931,8 @@ static void purge_mcast_if_list(struct hlist_head *mcast_if_list,
 		if (!hlist_empty(&if_entry->mcast_nexthop_list))
 				continue;
 
-		hlist_del(&if_entry->list);
-		kfree(if_entry);
+		hlist_del_rcu(&if_entry->list);
+		call_rcu(&if_entry->rcu, if_entry_free);
 	}
 }
 
@@ -912,8 +949,8 @@ static void purge_mcast_orig_list(struct hlist_head *mcast_orig_list,
 		if (!hlist_empty(&orig_entry->mcast_if_list))
 			continue;
 
-		hlist_del(&orig_entry->list);
-		kfree(orig_entry);
+		hlist_del_rcu(&orig_entry->list);
+		call_rcu(&orig_entry->rcu, orig_entry_free);
 	}
 }
 
@@ -930,8 +967,8 @@ void purge_mcast_forw_table(struct bat_priv *bat_priv)
 		if (!hlist_empty(&table_entry->mcast_orig_list))
 			continue;
 
-		hlist_del(&table_entry->list);
-		kfree(table_entry);
+		hlist_del_rcu(&table_entry->list);
+		call_rcu(&table_entry->rcu, table_entry_free);
 	}
 	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
 }
@@ -1073,18 +1110,14 @@ static void seq_print_if_entry(struct mcast_forw_if_entry *if_entry,
 	struct hlist_node *node;
 	struct batman_if *batman_if;
 
-	rcu_read_lock();
 	batman_if = if_num_to_batman_if(if_entry->if_num);
-	if (!batman_if) {
-		rcu_read_unlock();
+	if (!batman_if)
 		return;
-	}
 
 	seq_printf(seq, "\t\t%s\n", batman_if->net_dev->name);
-	rcu_read_unlock();
 
-	hlist_for_each_entry(nexthop_entry, node,
-			     &if_entry->mcast_nexthop_list, list)
+	hlist_for_each_entry_rcu(nexthop_entry, node,
+				 &if_entry->mcast_nexthop_list, list)
 		seq_printf(seq, "\t\t\t%pM - %i\n", nexthop_entry->neigh_addr,
 			   get_remaining_timeout(nexthop_entry, bat_priv));
 }
@@ -1097,8 +1130,8 @@ static void seq_print_orig_entry(struct mcast_forw_orig_entry *orig_entry,
 	struct hlist_node *node;
 
 	seq_printf(seq, "\t%pM\n", orig_entry->orig);
-	hlist_for_each_entry(if_entry, node, &orig_entry->mcast_if_list,
-			     list)
+	hlist_for_each_entry_rcu(if_entry, node, &orig_entry->mcast_if_list,
+				 list)
 		seq_print_if_entry(if_entry, bat_priv, seq);
 }
 
@@ -1110,8 +1143,8 @@ static void seq_print_table_entry(struct mcast_forw_table_entry *table_entry,
 	struct hlist_node *node;
 
 	seq_printf(seq, "%pM\n", table_entry->mcast_addr);
-	hlist_for_each_entry(orig_entry, node, &table_entry->mcast_orig_list,
-			     list)
+	hlist_for_each_entry_rcu(orig_entry, node,
+				 &table_entry->mcast_orig_list, list)
 		seq_print_orig_entry(orig_entry, bat_priv, seq);
 }
 
@@ -1129,13 +1162,11 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "Multicast group MAC\tOriginator\t"
 			"Outgoing interface\tNexthop - timeout in msecs\n");
 
-	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
-
-	hlist_for_each_entry(table_entry, node, &bat_priv->mcast_forw_table,
-			     list)
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(table_entry, node,
+				 &bat_priv->mcast_forw_table, list)
 		seq_print_table_entry(table_entry, bat_priv, seq);
-
-	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -1151,17 +1182,12 @@ static inline void nexthops_from_if_list(struct hlist_head *mcast_if_list,
 	struct dest_entries_list *dest_entry;
 	int mcast_fanout = atomic_read(&bat_priv->mcast_fanout);
 
-	hlist_for_each_entry(if_entry, node, mcast_if_list, list) {
-		rcu_read_lock();
+	hlist_for_each_entry_rcu(if_entry, node, mcast_if_list, list) {
 		batman_if = if_num_to_batman_if(if_entry->if_num);
-		if (!batman_if) {
-			rcu_read_unlock();
+		if (!batman_if)
 			continue;
-		}
 
 		kref_get(&batman_if->refcount);
-		rcu_read_unlock();
-
 
 		/* send via broadcast */
 		if (if_entry->num_nexthops > mcast_fanout) {
@@ -1174,8 +1200,8 @@ static inline void nexthops_from_if_list(struct hlist_head *mcast_if_list,
 		}
 
 		/* send separate unicast packets */
-		hlist_for_each_entry(nexthop_entry, node2,
-				     &if_entry->mcast_nexthop_list, list) {
+		hlist_for_each_entry_rcu(nexthop_entry, node2,
+				         &if_entry->mcast_nexthop_list, list) {
 			if (!get_remaining_timeout(nexthop_entry, bat_priv))
 				continue;
 
@@ -1200,7 +1226,7 @@ static inline void nexthops_from_orig_list(uint8_t *orig,
 	struct mcast_forw_orig_entry *orig_entry;
 	struct hlist_node *node;
 
-	hlist_for_each_entry(orig_entry, node, mcast_orig_list, list) {
+	hlist_for_each_entry_rcu(orig_entry, node, mcast_orig_list, list) {
 		if (memcmp(orig, orig_entry->orig, ETH_ALEN))
 			continue;
 
@@ -1218,7 +1244,7 @@ static inline void nexthops_from_table(uint8_t *dest, uint8_t *orig,
 	struct mcast_forw_table_entry *table_entry;
 	struct hlist_node *node;
 
-	hlist_for_each_entry(table_entry, node, mcast_forw_table, list) {
+	hlist_for_each_entry_rcu(table_entry, node, mcast_forw_table, list) {
 		if (memcmp(dest, table_entry->mcast_addr, ETH_ALEN))
 			continue;
 
@@ -1244,11 +1270,11 @@ void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
 
 	mcast_packet->ttl--;
 
-	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
+	rcu_read_lock();
 	nexthops_from_table(ethhdr->h_dest, mcast_packet->orig,
 			    &bat_priv->mcast_forw_table, &nexthop_list,
 			    bat_priv);
-	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+	rcu_read_unlock();
 
 	list_for_each_entry_safe(dest_entry, tmp, &nexthop_list, list) {
 		if (is_broadcast_ether_addr(dest_entry->dest)) {
-- 
1.7.2.3

