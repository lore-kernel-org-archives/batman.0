Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Nov 2010 18:00:29 +0100
Message-Id: <1291050032-20169-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011291800.02971.lindner_marek@yahoo.de>
References: <201011291800.02971.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: protect originator nodes
	with reference counters
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
 batman-adv/originator.c |   34 +++++++++++++++++++++++++++-------
 batman-adv/originator.h |    1 +
 batman-adv/routing.c    |   39 ++++++++++++++++++++++++++-------------
 batman-adv/types.h      |    2 ++
 4 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 8847bdd..58c479d 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -103,12 +103,13 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 	return neigh_node;
 }
 
-static void free_orig_node(void *data, void *arg)
+void orig_node_free_ref(struct kref *refcount)
 {
 	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node;
-	struct orig_node *orig_node = (struct orig_node *)data;
-	struct bat_priv *bat_priv = (struct bat_priv *)arg;
+	struct orig_node *orig_node;
+
+	orig_node = container_of(refcount, struct orig_node, refcount);
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -122,7 +123,8 @@ static void free_orig_node(void *data, void *arg)
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	frag_list_free(&orig_node->frag_list);
-	hna_global_del_orig(bat_priv, orig_node, "originator timed out");
+	hna_global_del_orig(orig_node->bat_priv, orig_node,
+			    "originator timed out");
 
 	kfree(orig_node->bcast_own);
 	kfree(orig_node->bcast_own_sum);
@@ -131,13 +133,25 @@ static void free_orig_node(void *data, void *arg)
 
 void originator_free(struct bat_priv *bat_priv)
 {
+	HASHIT(hashit);
+	struct element_t *bucket;
+	struct orig_node *orig_node;
+
 	if (!bat_priv->orig_hash)
 		return;
 
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
-	hash_delete(bat_priv->orig_hash, free_orig_node, bat_priv);
+
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
+
+		hash_remove_bucket(bat_priv->orig_hash, &hashit);
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	}
+
 	bat_priv->orig_hash = NULL;
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
@@ -156,8 +170,10 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 						   addr));
 	rcu_read_unlock();
 
-	if (orig_node)
+	if (orig_node) {
+		kref_get(&orig_node->refcount);
 		return orig_node;
+	}
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Creating new originator: %pM\n", addr);
@@ -168,7 +184,9 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	spin_lock_init(&orig_node->neigh_list_lock);
+	kref_init(&orig_node->refcount);
 
+	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
@@ -197,6 +215,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (hash_added < 0)
 		goto free_bcast_own_sum;
 
+	/* extra reference for return */
+	kref_get(&orig_node->refcount);
 	return orig_node;
 free_bcast_own_sum:
 	kfree(orig_node->bcast_own_sum);
@@ -302,7 +322,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 			if (orig_node->gw_flags)
 				gw_node_delete(bat_priv, orig_node);
 			hash_remove_bucket(bat_priv->orig_hash, &hashit);
-			free_orig_node(orig_node, bat_priv);
+			kref_put(&orig_node->refcount, orig_node_free_ref);
 		}
 
 		if (time_after(jiffies, (orig_node->last_frag_packet +
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index f3676fa..f5a6964 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -25,6 +25,7 @@
 int originator_init(struct bat_priv *bat_priv);
 void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
+void orig_node_free_ref(struct kref *refcount);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 5d1a35f..35abe00 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -291,6 +291,8 @@ static void update_orig(struct bat_priv *bat_priv,
 
 		neigh_node = create_neighbor(orig_node, orig_tmp,
 					     ethhdr->h_source, if_incoming);
+
+		kref_put(&orig_tmp->refcount, orig_node_free_ref);
 		if (!neigh_node)
 			return;
 	} else
@@ -399,7 +401,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	int set_mark;
 
 	orig_node = get_orig_node(bat_priv, batman_packet->orig);
-	if (orig_node == NULL)
+	if (!orig_node)
 		return 0;
 
 	seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
@@ -407,7 +409,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	/* signalize caller that the packet is to be dropped. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->batman_seqno_reset))
-		return -1;
+		goto err;
 
 	rcu_read_lock();
 	hlist_for_each_entry(tmp_neigh_node, node,
@@ -440,7 +442,12 @@ static char count_real_packets(struct ethhdr *ethhdr,
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
 
+	kref_put(&orig_node->refcount, orig_node_free_ref);
 	return is_duplicate;
+
+err:
+	kref_put(&orig_node->refcount, orig_node_free_ref);
+	return -1;
 }
 
 /* copy primary address for bonding */
@@ -657,7 +664,6 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		int offset;
 
 		orig_neigh_node = get_orig_node(bat_priv, ethhdr->h_source);
-
 		if (!orig_neigh_node)
 			return;
 
@@ -678,6 +684,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Drop packet: "
 			"originator packet from myself (via neighbor)\n");
+		kref_put(&orig_neigh_node->refcount, orig_node_free_ref);
 		return;
 	}
 
@@ -689,7 +696,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	orig_node = get_orig_node(bat_priv, batman_packet->orig);
-	if (orig_node == NULL)
+	if (!orig_node)
 		return;
 
 	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
@@ -698,13 +705,13 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: packet within seqno protection time "
 			"(sender: %pM)\n", ethhdr->h_source);
-		return;
+		goto out;
 	}
 
 	if (batman_packet->tq == 0) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: originator packet with tq equal 0\n");
-		return;
+		goto out;
 	}
 
 	/* avoid temporary routing loops */
@@ -718,7 +725,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: ignoring all rebroadcast packets that "
 			"may make me loop (sender: %pM)\n", ethhdr->h_source);
-		return;
+		goto out;
 	}
 
 	/* if sender is a direct neighbor the sender mac equals
@@ -726,8 +733,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	orig_neigh_node = (is_single_hop_neigh ?
 			   orig_node :
 			   get_orig_node(bat_priv, ethhdr->h_source));
-	if (orig_neigh_node == NULL)
-		return;
+	if (!orig_neigh_node)
+		goto out_neigh;
 
 	/* drop packet if sender is not a direct neighbor and if we
 	 * don't route towards it */
@@ -735,7 +742,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    (orig_neigh_node->router == NULL)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: OGM via unknown neighbor!\n");
-		return;
+		goto out_neigh;
 	}
 
 	is_bidirectional = is_bidirectional_neigh(orig_node, orig_neigh_node,
@@ -763,26 +770,32 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
 			"rebroadcast neighbor packet with direct link flag\n");
-		return;
+		goto out_neigh;
 	}
 
 	/* multihop originator */
 	if (!is_bidirectional) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: not received via bidirectional link\n");
-		return;
+		goto out_neigh;
 	}
 
 	if (is_duplicate) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: duplicate packet received\n");
-		return;
+		goto out_neigh;
 	}
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
 	schedule_forward_packet(orig_node, ethhdr, batman_packet,
 				0, hna_buff_len, if_incoming);
+
+out_neigh:
+	if (!is_single_hop_neigh)
+		kref_put(&orig_neigh_node->refcount, orig_node_free_ref);
+out:
+	kref_put(&orig_node->refcount, orig_node_free_ref);
 }
 
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1d6365d..f4ce526 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -86,6 +86,8 @@ struct orig_node {
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
 	spinlock_t neigh_list_lock; /* protects neighbor list */
+	struct kref refcount;
+	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
 	struct {
 		uint8_t candidates;
-- 
1.7.2.3

