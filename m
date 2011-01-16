Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 16 Jan 2011 12:36:31 +0100
Message-Id: <1295177791-19401-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201101161235.54223.lindner_marek@yahoo.de>
References: <201101161235.54223.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: protect bonding with rcu locks
	(proposal)
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
 batman-adv/hard-interface.c |    2 +-
 batman-adv/originator.c     |   26 +++---
 batman-adv/originator.h     |    1 +
 batman-adv/routing.c        |  223 +++++++++++++++++++++----------------------
 batman-adv/routing.h        |    6 +-
 batman-adv/types.h          |    7 +-
 6 files changed, 132 insertions(+), 133 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 4f95777..3ab9a20 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -265,7 +265,7 @@ static void hardif_activate_interface(struct batman_if *batman_if)
 static void hardif_deactivate_interface(struct batman_if *batman_if)
 {
 	if ((batman_if->if_status != IF_ACTIVE) &&
-	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
+	    (batman_if->if_status != IF_TO_BE_ACTIVATED))
 		return;
 
 	batman_if->if_status = IF_INACTIVE;
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index a3a275a..35ab3ab 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -72,6 +72,14 @@ static void neigh_node_free_rcu(struct rcu_head *rcu)
 	kref_put(&neigh_node->refcount, neigh_node_free_ref);
 }
 
+void neigh_node_free_rcu_bond(struct rcu_head *rcu)
+{
+	struct neigh_node *neigh_node;
+
+	neigh_node = container_of(rcu, struct neigh_node, rcu_bond);
+	kref_put(&neigh_node->refcount, neigh_node_free_ref);
+}
+
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
 				   uint8_t *neigh,
@@ -113,9 +121,9 @@ void orig_node_free_ref(struct kref *refcount)
 
 	/* for all bonding members ... */
 	list_for_each_entry_safe(neigh_node, tmp_neigh_node,
-				 &orig_node->bond.selected, bonding_list) {
+				 &orig_node->bond_list, bonding_list) {
 		list_del_rcu(&neigh_node->bonding_list);
-		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
+		call_rcu(&neigh_node->rcu_bond, neigh_node_free_rcu_bond);
 	}
 
 	/* for all neighbors towards this originator ... */
@@ -210,7 +218,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 		return NULL;
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
-	INIT_LIST_HEAD(&orig_node->bond.selected);
+	INIT_LIST_HEAD(&orig_node->bond_list);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	kref_init(&orig_node->refcount);
@@ -224,6 +232,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
+	atomic_set(&orig_node->bond_candidates, 0);
+
 	size = bat_priv->num_ifaces * sizeof(unsigned long) * NUM_WORDS;
 
 	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
@@ -299,12 +309,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 			neigh_purged = true;
 
 			hlist_del_rcu(&neigh_node->list);
-
-			if (!list_empty(&neigh_node->bonding_list)) {
-				orig_node->bond.candidates--;
-				list_del_rcu(&neigh_node->bonding_list);
-				call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
-			}
+			bonding_candidate_del(orig_node, neigh_node);
 			call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 		} else {
 			if ((!*best_neigh_node) ||
@@ -336,9 +341,6 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 				      best_neigh_node,
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
-			/* update bonding candidates, we could have lost
-			 * some candidates. */
-			update_bonding_candidates(orig_node);
 		}
 	}
 
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index f5a6964..7739b22 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -26,6 +26,7 @@ int originator_init(struct bat_priv *bat_priv);
 void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
 void orig_node_free_ref(struct kref *refcount);
+void neigh_node_free_rcu_bond(struct rcu_head *rcu);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 3d16261..a90d105 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -268,6 +268,101 @@ out:
 	return ret;
 }
 
+/* caller must hold the neigh_list_lock */
+void bonding_candidate_del(struct orig_node *orig_node,
+			   struct neigh_node *neigh_node)
+{
+	/* this neighbor is not part of our candidate list */
+	if (list_empty(&neigh_node->bonding_list))
+		goto out;
+
+	list_del_rcu(&neigh_node->bonding_list);
+	call_rcu(&neigh_node->rcu_bond, neigh_node_free_rcu_bond);
+	INIT_LIST_HEAD(&neigh_node->bonding_list);
+	atomic_dec(&orig_node->bond_candidates);
+
+out:
+	return;
+}
+
+static void bonding_candidate_add(struct orig_node *orig_node,
+				  struct neigh_node *neigh_node)
+{
+	struct hlist_node *node;
+	struct neigh_node *tmp_neigh_node;
+	uint8_t best_tq, interference_candidate = 0;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+
+	/* only consider if it has the same primary address ...  */
+	if (!compare_orig(orig_node->orig,
+			  neigh_node->orig_node->primary_addr))
+		goto candidate_del;
+
+	if (!orig_node->router)
+		goto candidate_del;
+
+	best_tq = orig_node->router->tq_avg;
+
+	/* ... and is good enough to be considered */
+	if (neigh_node->tq_avg < best_tq - BONDING_TQ_THRESHOLD)
+		goto candidate_del;
+
+	/**
+	 * check if we have another candidate with the same mac address or
+	 * interface. If we do, we won't select this candidate because of
+	 * possible interference.
+	 */
+	hlist_for_each_entry_rcu(tmp_neigh_node, node,
+				 &orig_node->neigh_list, list) {
+
+		if (tmp_neigh_node == neigh_node)
+			continue;
+
+		/* we only care if the other candidate is even
+		* considered as candidate. */
+		if (list_empty(&tmp_neigh_node->bonding_list))
+			continue;
+
+		if ((neigh_node->if_incoming == tmp_neigh_node->if_incoming) ||
+		    (compare_orig(neigh_node->addr, tmp_neigh_node->addr))) {
+			interference_candidate = 1;
+			break;
+		}
+	}
+
+	/* don't care further if it is an interference candidate */
+	if (interference_candidate)
+		goto candidate_del;
+
+	/* this neighbor already is part of our candidate list */
+	if (!list_empty(&neigh_node->bonding_list))
+		goto out;
+
+	list_add_rcu(&neigh_node->bonding_list, &orig_node->bond_list);
+	kref_get(&neigh_node->refcount);
+	atomic_inc(&orig_node->bond_candidates);
+	goto out;
+
+candidate_del:
+	bonding_candidate_del(orig_node, neigh_node);
+
+out:
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+	return;
+}
+
+/* copy primary address for bonding */
+static void bonding_save_primary(struct orig_node *orig_node,
+				 struct orig_node *orig_neigh_node,
+				 struct batman_packet *batman_packet)
+{
+	if (!(batman_packet->flags & PRIMARIES_FIRST_HOP))
+		return;
+
+	memcpy(orig_neigh_node->primary_addr, orig_node->orig, ETH_ALEN);
+}
+
 static void update_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node,
 			struct ethhdr *ethhdr,
@@ -336,6 +431,8 @@ static void update_orig(struct bat_priv *bat_priv,
 		neigh_node->last_ttl = batman_packet->ttl;
 	}
 
+	bonding_candidate_add(orig_node, neigh_node);
+
 	tmp_hna_buff_len = (hna_buff_len > batman_packet->num_hna * ETH_ALEN ?
 			    batman_packet->num_hna * ETH_ALEN : hna_buff_len);
 
@@ -494,110 +591,10 @@ err:
 	return -1;
 }
 
-/* copy primary address for bonding */
-static void mark_bonding_address(struct orig_node *orig_node,
-				 struct orig_node *orig_neigh_node,
-				 struct batman_packet *batman_packet)
-
-{
-	if (batman_packet->flags & PRIMARIES_FIRST_HOP)
-		memcpy(orig_neigh_node->primary_addr,
-		       orig_node->orig, ETH_ALEN);
-
-	return;
-}
-
-/* mark possible bond.candidates in the neighbor list */
-void update_bonding_candidates(struct orig_node *orig_node)
-{
-	int candidates;
-	int interference_candidate;
-	int best_tq;
-	struct hlist_node *node, *node2;
-	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
-
-	/* update the candidates for this originator */
-	if (!orig_node->router) {
-		orig_node->bond.candidates = 0;
-		return;
-	}
-
-	spin_lock_bh(&orig_node->neigh_list_lock);
-	best_tq = orig_node->router->tq_avg;
-
-	/* update bond.candidates */
-
-	candidates = 0;
-
-	/* mark other nodes which also received "PRIMARIES FIRST HOP" packets
-	 * as "bonding partner" */
-
-	/* first, zero the list */
-	list_for_each_entry_safe(tmp_neigh_node, tmp_neigh_node2,
-				 &orig_node->bond.selected, bonding_list) {
-		list_del_rcu(&tmp_neigh_node->bonding_list);
-		kref_put(&tmp_neigh_node->refcount, neigh_node_free_ref);
-	}
-
-	hlist_for_each_entry_rcu(tmp_neigh_node, node,
-		&orig_node->neigh_list, list) {
-
-		/* only consider if it has the same primary address ...  */
-		if (memcmp(orig_node->orig,
-				tmp_neigh_node->orig_node->primary_addr,
-				ETH_ALEN) != 0)
-			continue;
-
-		/* ... and is good enough to be considered */
-		if (tmp_neigh_node->tq_avg < best_tq - BONDING_TQ_THRESHOLD)
-			continue;
-
-		/* check if we have another candidate with the same
-		 * mac address or interface. If we do, we won't
-		 * select this candidate because of possible interference. */
-
-		interference_candidate = 0;
-		hlist_for_each_entry_rcu(tmp_neigh_node2, node2,
-					 &orig_node->neigh_list, list) {
-
-			if (tmp_neigh_node2 == tmp_neigh_node)
-				continue;
-
-			/* we only care if the other candidate is even
-			 * considered as candidate. */
-			if (!list_empty(&tmp_neigh_node2->bonding_list))
-				continue;
-
-
-			if ((tmp_neigh_node->if_incoming ==
-				tmp_neigh_node2->if_incoming)
-				|| (memcmp(tmp_neigh_node->addr,
-				tmp_neigh_node2->addr, ETH_ALEN) == 0)) {
-
-				interference_candidate = 1;
-				break;
-			}
-		}
-		/* don't care further if it is an interference candidate */
-		if (interference_candidate)
-			continue;
-
-		list_add_rcu(&tmp_neigh_node->bonding_list,
-				&orig_node->bond.selected);
-		kref_get(&tmp_neigh_node->refcount);
-
-		candidates++;
-	}
-	orig_node->bond.candidates = candidates;
-
-	spin_unlock_bh(&orig_node->neigh_list_lock);
-
-}
-
 void receive_bat_packet(struct ethhdr *ethhdr,
-				struct batman_packet *batman_packet,
-				unsigned char *hna_buff, int hna_buff_len,
-				struct batman_if *if_incoming)
+			struct batman_packet *batman_packet,
+			unsigned char *hna_buff, int hna_buff_len,
+			struct batman_if *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batman_if *batman_if;
@@ -779,6 +776,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_bidirectional = is_bidirectional_neigh(orig_node, orig_neigh_node,
 						batman_packet, if_incoming);
 
+	bonding_save_primary(orig_node, orig_neigh_node, batman_packet);
+
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate */
 	if (is_bidirectional &&
@@ -788,9 +787,6 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		update_orig(bat_priv, orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
-	mark_bonding_address(orig_node, orig_neigh_node, batman_packet);
-	update_bonding_candidates(orig_node);
-
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 
@@ -1115,7 +1111,6 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 
 	/* without bonding, the first node should
 	 * always choose the default router. */
-
 	bonding_enabled = atomic_read(&bat_priv->bonding);
 
 	rcu_read_lock();
@@ -1149,10 +1144,10 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		if (!primary_orig_node)
 			goto return_router;
 	}
+
 	/* with less than 2 candidates, we can't do any
 	 * bonding and prefer the original router. */
-
-	if (primary_orig_node->bond.candidates < 2)
+	if (atomic_read(&primary_orig_node->bond_candidates) < 2)
 		goto return_router;
 
 
@@ -1168,7 +1163,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		 * robin fashion over the remaining interfaces. */
 
 		list_for_each_entry_rcu(tmp_neigh_node,
-			&primary_orig_node->bond.selected, bonding_list) {
+				&primary_orig_node->bond_list, bonding_list) {
 			if (!first_candidate)
 				first_candidate = tmp_neigh_node;
 			/* recv_if == NULL on the first node. */
@@ -1187,8 +1182,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		spin_lock_bh(&primary_orig_node->neigh_list_lock);
 		/* this is a list_move(), which unfortunately
 		 * does not exist as rcu version */
-		list_del_rcu(&primary_orig_node->bond.selected);
-		list_add_rcu(&primary_orig_node->bond.selected,
+		list_del_rcu(&primary_orig_node->bond_list);
+		list_add_rcu(&primary_orig_node->bond_list,
 				&router->bonding_list);
 		spin_unlock_bh(&primary_orig_node->neigh_list_lock);
 
@@ -1198,7 +1193,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		 * this interface. */
 		best_router_tq = 0;
 		list_for_each_entry_rcu(tmp_neigh_node,
-			&primary_orig_node->bond.selected, bonding_list) {
+			&primary_orig_node->bond_list, bonding_list) {
 			if (!first_candidate)
 				first_candidate = tmp_neigh_node;
 
@@ -1227,7 +1222,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 {
 	struct ethhdr *ethhdr;
 
-/* drop packet if it has not necessary minimum size */
+	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return -1;
 
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 725cc38..e02789e 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -41,7 +41,9 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
-		struct orig_node *orig_node, struct batman_if *recv_if);
-void update_bonding_candidates(struct orig_node *orig_node);
+			       struct orig_node *orig_node,
+			       struct batman_if *recv_if);
+void bonding_candidate_del(struct orig_node *orig_node,
+			   struct neigh_node *neigh_node);
 
 #endif /* _NET_BATMAN_ADV_ROUTING_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index f947336..8e97861 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -90,10 +90,8 @@ struct orig_node {
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
 	spinlock_t ogm_cnt_lock; /* protects ogm counter */
-	struct {
-		uint8_t candidates;
-		struct list_head selected;
-	} bond;
+	atomic_t bond_candidates;
+	struct list_head bond_list;
 };
 
 struct gw_node {
@@ -121,6 +119,7 @@ struct neigh_node {
 	unsigned long real_bits[NUM_WORDS];
 	struct kref refcount;
 	struct rcu_head rcu;
+	struct rcu_head rcu_bond;
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
 };
-- 
1.7.2.3

