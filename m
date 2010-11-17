Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Nov 2010 02:26:29 +0100
Message-Id: <1289957194-5455-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011170226.09739.lindner_marek@yahoo.de>
References: <201011170226.09739.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: protect neighbor list with
	rcu locks
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/originator.c |   31 ++++++++++++++++++++++++++-----
 batman-adv/routing.c    |   13 +++++++++++++
 batman-adv/types.h      |    2 ++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index dbc0dd1..71480af 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -67,6 +67,14 @@ void neigh_node_free_ref(struct kref *refcount)
 	kfree(neigh_node);
 }
 
+static void neigh_node_free_rcu(struct rcu_head *rcu)
+{
+	struct neigh_node *neigh_node;
+
+	neigh_node = container_of(rcu, struct neigh_node, rcu);
+	kref_put(&neigh_node->refcount, neigh_node_free_ref);
+}
+
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
 				   uint8_t *neigh,
@@ -89,7 +97,9 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 	neigh_node->if_incoming = if_incoming;
 	kref_init(&neigh_node->refcount);
 
-	hlist_add_head(&neigh_node->list, &orig_node->neigh_list);
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
 	return neigh_node;
 }
 
@@ -100,13 +110,17 @@ static void free_orig_node(void *data, void *arg)
 	struct orig_node *orig_node = (struct orig_node *)data;
 	struct bat_priv *bat_priv = (struct bat_priv *)arg;
 
+	spin_lock_bh(&orig_node->neigh_list_lock);
+
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
-		hlist_del(&neigh_node->list);
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		hlist_del_rcu(&neigh_node->list);
+		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 	}
 
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
 	frag_list_free(&orig_node->frag_list);
 	hna_global_del_orig(bat_priv, orig_node, "originator timed out");
 
@@ -152,6 +166,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 		return NULL;
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
+	spin_lock_init(&orig_node->neigh_list_lock);
 
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
@@ -212,6 +227,8 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 
 	*best_neigh_node = NULL;
 
+	spin_lock_bh(&orig_node->neigh_list_lock);
+
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
@@ -237,14 +254,16 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 
 			neigh_purged = true;
 
-			hlist_del(&neigh_node->list);
-			kref_put(&neigh_node->refcount, neigh_node_free_ref);
+			hlist_del_rcu(&neigh_node->list);
+			call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 		} else {
 			if ((*best_neigh_node == NULL) ||
 			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
 				*best_neigh_node = neigh_node;
 		}
 	}
+
+	spin_unlock_bh(&orig_node->neigh_list_lock);
 	return neigh_purged;
 }
 
@@ -380,11 +399,13 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 			   orig_node->router->tq_avg, orig_node->router->addr,
 			   orig_node->router->if_incoming->net_dev->name);
 
+		rcu_read_lock();
 		hlist_for_each_entry(neigh_node, node,
 				     &orig_node->neigh_list, list) {
 			seq_printf(seq, " %pM (%3i)", neigh_node->addr,
 					   neigh_node->tq_avg);
 		}
+		rcu_read_unlock();
 
 		seq_printf(seq, "\n");
 		batman_count++;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index c4ab00b..34df9c1 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -146,6 +146,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	unsigned char total_count;
 
 	if (orig_node == orig_neigh_node) {
+		rcu_read_lock();
 		hlist_for_each_entry(tmp_neigh_node, node,
 				     &orig_node->neigh_list, list) {
 
@@ -154,6 +155,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			    (tmp_neigh_node->if_incoming == if_incoming))
 				neigh_node = tmp_neigh_node;
 		}
+		rcu_read_unlock();
 
 		if (!neigh_node)
 			neigh_node = create_neighbor(orig_node,
@@ -167,6 +169,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		neigh_node->last_valid = jiffies;
 	} else {
 		/* find packet count of corresponding one hop neighbor */
+		rcu_read_lock();
 		hlist_for_each_entry(tmp_neigh_node, node,
 				     &orig_neigh_node->neigh_list, list) {
 
@@ -175,6 +178,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			    (tmp_neigh_node->if_incoming == if_incoming))
 				neigh_node = tmp_neigh_node;
 		}
+		rcu_read_unlock();
 
 		if (!neigh_node)
 			neigh_node = create_neighbor(orig_neigh_node,
@@ -259,6 +263,7 @@ static void update_orig(struct bat_priv *bat_priv,
 	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
 		"Searching and updating originator entry of received packet\n");
 
+	rcu_read_lock();
 	hlist_for_each_entry(tmp_neigh_node, node,
 			     &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
@@ -275,6 +280,7 @@ static void update_orig(struct bat_priv *bat_priv,
 		tmp_neigh_node->tq_avg =
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 	}
+	rcu_read_unlock();
 
 	if (!neigh_node) {
 		struct orig_node *orig_tmp;
@@ -403,6 +409,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			     &orig_node->batman_seqno_reset))
 		return -1;
 
+	rcu_read_lock();
 	hlist_for_each_entry(tmp_neigh_node, node,
 			     &orig_node->neigh_list, list) {
 
@@ -424,6 +431,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 		tmp_neigh_node->real_packet_count =
 			bit_packet_count(tmp_neigh_node->real_bits);
 	}
+	rcu_read_unlock();
 
 	if (need_update) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -476,13 +484,17 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 	 * as "bonding partner" */
 
 	/* first, zero the list */
+	rcu_read_lock();
 	hlist_for_each_entry(tmp_neigh_node, node,
 			     &orig_node->neigh_list, list) {
 		tmp_neigh_node->next_bond_candidate = NULL;
 	}
+	rcu_read_unlock();
 
 	first_candidate = NULL;
 	last_candidate = NULL;
+
+	rcu_read_lock();
 	hlist_for_each_entry(tmp_neigh_node, node,
 			     &orig_node->neigh_list, list) {
 
@@ -536,6 +548,7 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 
 		candidates++;
 	}
+	rcu_read_unlock();
 
 	if (candidates > 0) {
 		first_candidate->next_bond_candidate = last_candidate;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1ce91f6..1d6365d 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -85,6 +85,7 @@ struct orig_node {
 	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
+	spinlock_t neigh_list_lock; /* protects neighbor list */
 	unsigned long last_frag_packet;
 	struct {
 		uint8_t candidates;
@@ -116,6 +117,7 @@ struct neigh_node {
 	unsigned long last_valid;
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct kref refcount;
+	struct rcu_head rcu;
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
 };
-- 
1.7.2.3

