Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Nov 2010 02:26:28 +0100
Message-Id: <1289957194-5455-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011170226.09739.lindner_marek@yahoo.de>
References: <201011170226.09739.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: convert neighbor list to
	hlist
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
 batman-adv/originator.c |   28 +++++++++++++++-------------
 batman-adv/routing.c    |   29 ++++++++++++++++++-----------
 batman-adv/types.h      |    4 ++--
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 9aff835..dbc0dd1 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -82,29 +82,28 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 	if (!neigh_node)
 		return NULL;
 
-	INIT_LIST_HEAD(&neigh_node->list);
+	INIT_HLIST_NODE(&neigh_node->list);
 
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node = orig_neigh_node;
 	neigh_node->if_incoming = if_incoming;
 	kref_init(&neigh_node->refcount);
 
-	list_add_tail(&neigh_node->list, &orig_node->neigh_list);
+	hlist_add_head(&neigh_node->list, &orig_node->neigh_list);
 	return neigh_node;
 }
 
 static void free_orig_node(void *data, void *arg)
 {
-	struct list_head *list_pos, *list_pos_tmp;
+	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node;
 	struct orig_node *orig_node = (struct orig_node *)data;
 	struct bat_priv *bat_priv = (struct bat_priv *)arg;
 
 	/* for all neighbors towards this originator ... */
-	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
-		neigh_node = list_entry(list_pos, struct neigh_node, list);
-
-		list_del(list_pos);
+	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
+				  &orig_node->neigh_list, list) {
+		hlist_del(&neigh_node->list);
 		kref_put(&neigh_node->refcount, neigh_node_free_ref);
 	}
 
@@ -152,7 +151,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (!orig_node)
 		return NULL;
 
-	INIT_LIST_HEAD(&orig_node->neigh_list);
+	INIT_HLIST_HEAD(&orig_node->neigh_list);
 
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
@@ -207,15 +206,15 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 				 struct orig_node *orig_node,
 				 struct neigh_node **best_neigh_node)
 {
-	struct list_head *list_pos, *list_pos_tmp;
+	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
 
 	*best_neigh_node = NULL;
 
 	/* for all neighbors towards this originator ... */
-	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
-		neigh_node = list_entry(list_pos, struct neigh_node, list);
+	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
+				  &orig_node->neigh_list, list) {
 
 		if ((time_after(jiffies,
 			neigh_node->last_valid + PURGE_TIMEOUT * HZ)) ||
@@ -237,7 +236,8 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 					(neigh_node->last_valid / HZ));
 
 			neigh_purged = true;
-			list_del(list_pos);
+
+			hlist_del(&neigh_node->list);
 			kref_put(&neigh_node->refcount, neigh_node_free_ref);
 		} else {
 			if ((*best_neigh_node == NULL) ||
@@ -328,6 +328,7 @@ void purge_orig_ref(struct bat_priv *bat_priv)
 int orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
+	struct hlist_node *node;
 	struct element_t *bucket;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -379,7 +380,8 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 			   orig_node->router->tq_avg, orig_node->router->addr,
 			   orig_node->router->if_incoming->net_dev->name);
 
-		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
+		hlist_for_each_entry(neigh_node, node,
+				     &orig_node->neigh_list, list) {
 			seq_printf(seq, " %pM (%3i)", neigh_node->addr,
 					   neigh_node->tq_avg);
 		}
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 881e444..c4ab00b 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -142,12 +142,12 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct hlist_node *node;
 	unsigned char total_count;
 
 	if (orig_node == orig_neigh_node) {
-		list_for_each_entry(tmp_neigh_node,
-				    &orig_node->neigh_list,
-				    list) {
+		hlist_for_each_entry(tmp_neigh_node, node,
+				     &orig_node->neigh_list, list) {
 
 			if (compare_orig(tmp_neigh_node->addr,
 					 orig_neigh_node->orig) &&
@@ -167,8 +167,8 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		neigh_node->last_valid = jiffies;
 	} else {
 		/* find packet count of corresponding one hop neighbor */
-		list_for_each_entry(tmp_neigh_node,
-				    &orig_neigh_node->neigh_list, list) {
+		hlist_for_each_entry(tmp_neigh_node, node,
+				     &orig_neigh_node->neigh_list, list) {
 
 			if (compare_orig(tmp_neigh_node->addr,
 					 orig_neigh_node->orig) &&
@@ -253,12 +253,14 @@ static void update_orig(struct bat_priv *bat_priv,
 			char is_duplicate)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct hlist_node *node;
 	int tmp_hna_buff_len;
 
 	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
 		"Searching and updating originator entry of received packet\n");
 
-	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
+	hlist_for_each_entry(tmp_neigh_node, node,
+			     &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
 		    (tmp_neigh_node->if_incoming == if_incoming)) {
 			neigh_node = tmp_neigh_node;
@@ -384,6 +386,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
+	struct hlist_node *node;
 	char is_duplicate = 0;
 	int32_t seq_diff;
 	int need_update = 0;
@@ -400,7 +403,8 @@ static char count_real_packets(struct ethhdr *ethhdr,
 			     &orig_node->batman_seqno_reset))
 		return -1;
 
-	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
+	hlist_for_each_entry(tmp_neigh_node, node,
+			     &orig_node->neigh_list, list) {
 
 		is_duplicate |= get_bit_status(tmp_neigh_node->real_bits,
 					       orig_node->last_real_seqno,
@@ -452,6 +456,7 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 	int candidates;
 	int interference_candidate;
 	int best_tq;
+	struct hlist_node *node, *node2;
 	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
 	struct neigh_node *first_candidate, *last_candidate;
 
@@ -471,13 +476,15 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 	 * as "bonding partner" */
 
 	/* first, zero the list */
-	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
+	hlist_for_each_entry(tmp_neigh_node, node,
+			     &orig_node->neigh_list, list) {
 		tmp_neigh_node->next_bond_candidate = NULL;
 	}
 
 	first_candidate = NULL;
 	last_candidate = NULL;
-	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
+	hlist_for_each_entry(tmp_neigh_node, node,
+			     &orig_node->neigh_list, list) {
 
 		/* only consider if it has the same primary address ...  */
 		if (memcmp(orig_node->orig,
@@ -494,8 +501,8 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 		 * select this candidate because of possible interference. */
 
 		interference_candidate = 0;
-		list_for_each_entry(tmp_neigh_node2,
-				&orig_node->neigh_list, list) {
+		hlist_for_each_entry(tmp_neigh_node2, node2,
+				     &orig_node->neigh_list, list) {
 
 			if (tmp_neigh_node2 == tmp_neigh_node)
 				continue;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index c1accbf..1ce91f6 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -83,7 +83,7 @@ struct orig_node {
 	uint8_t last_ttl;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
-	struct list_head neigh_list;
+	struct hlist_head neigh_list;
 	struct list_head frag_list;
 	unsigned long last_frag_packet;
 	struct {
@@ -105,7 +105,7 @@ struct gw_node {
  *	@last_valid: when last packet via this neighbor was received
  */
 struct neigh_node {
-	struct list_head list;
+	struct hlist_node list;
 	uint8_t addr[ETH_ALEN];
 	uint8_t real_packet_count;
 	uint8_t tq_recv[TQ_GLOBAL_WINDOW_SIZE];
-- 
1.7.2.3

