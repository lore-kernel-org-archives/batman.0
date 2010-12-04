Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  4 Dec 2010 21:03:47 +0100
Message-Id: <1291493028-29957-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201012042042.16056.sven.eckelmann@gmx.de>
References: <201012042042.16056.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: protect ogm counter arrays
	with spinlock
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

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/originator.c |   11 +++++++++--
 batman-adv/routing.c    |   27 +++++++++++++++++++++++----
 batman-adv/types.h      |    1 +
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index fa34ea0..6a97879 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -195,6 +195,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 		return NULL;
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
+	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	kref_init(&orig_node->refcount);
 
@@ -502,7 +503,7 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
-	int i;
+	int i, ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
@@ -515,7 +516,11 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
 			orig_node = bucket->data;
 
-			if (orig_node_add_if(orig_node, max_if_num) == -1)
+			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			ret = orig_node_add_if(orig_node, max_if_num);
+			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+
+			if (ret == -1)
 				goto err;
 		}
 		rcu_read_unlock();
@@ -604,8 +609,10 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
 			orig_node = bucket->data;
 
+			spin_lock_bh(&orig_node->ogm_cnt_lock);
 			ret = orig_node_del_if(orig_node, max_if_num,
 					batman_if->if_num);
+			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
 			if (ret == -1)
 				goto err;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a9a30ff..aa3f21a 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -56,12 +56,14 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
 			orig_node = bucket->data;
+			spin_lock_bh(&orig_node->ogm_cnt_lock);
 			word_index = batman_if->if_num * NUM_WORDS;
 			word = &(orig_node->bcast_own[word_index]);
 
 			bit_get_packet(bat_priv, word, 1, 0);
 			orig_node->bcast_own_sum[batman_if->if_num] =
 				bit_packet_count(word);
+			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 		}
 		rcu_read_unlock();
 	}
@@ -267,8 +269,10 @@ static void update_orig(struct bat_priv *bat_priv,
 			char is_duplicate)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct orig_node *orig_node_tmp;
 	struct hlist_node *node;
 	int tmp_hna_buff_len;
+	uint8_t bcast_own_sum_orig, bcast_own_sum_neigh;
 
 	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
 		"Searching and updating originator entry of received packet\n");
@@ -338,10 +342,22 @@ static void update_orig(struct bat_priv *bat_priv,
 	/* if the TQ is the same and the link not more symetric we
 	 * won't consider it either */
 	if ((orig_node->router) &&
-	     ((neigh_node->tq_avg == orig_node->router->tq_avg) &&
-	     (orig_node->router->orig_node->bcast_own_sum[if_incoming->if_num]
-	      >= neigh_node->orig_node->bcast_own_sum[if_incoming->if_num])))
-		goto update_hna;
+	     (neigh_node->tq_avg == orig_node->router->tq_avg)) {
+		orig_node_tmp = orig_node->router->orig_node;
+		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
+		bcast_own_sum_orig =
+			orig_node_tmp->bcast_own_sum[if_incoming->if_num];
+		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
+
+		orig_node_tmp = neigh_node->orig_node;
+		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
+		bcast_own_sum_neigh =
+			orig_node_tmp->bcast_own_sum[if_incoming->if_num];
+		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
+
+		if (bcast_own_sum_orig >= bcast_own_sum_neigh)
+			goto update_hna;
+	}
 
 	update_routes(bat_priv, orig_node, neigh_node,
 		      hna_buff, tmp_hna_buff_len);
@@ -686,10 +702,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				 batman_packet->orig) &&
 		    (batman_packet->seqno - if_incoming_seqno + 2 == 0)) {
 			offset = if_incoming->if_num * NUM_WORDS;
+
+			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 			word = &(orig_neigh_node->bcast_own[offset]);
 			bit_mark(word, 0);
 			orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
 				bit_packet_count(word);
+			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
 		}
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Drop packet: "
diff --git a/batman-adv/types.h b/batman-adv/types.h
index f4ce526..de4efa0 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -89,6 +89,7 @@ struct orig_node {
 	struct kref refcount;
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
+	spinlock_t ogm_cnt_lock; /* protects ogm counter */
 	struct {
 		uint8_t candidates;
 		struct neigh_node *selected;
-- 
1.7.2.3

