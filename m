Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Nov 2010 18:00:30 +0100
Message-Id: <1291050032-20169-7-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011291800.02971.lindner_marek@yahoo.de>
References: <201011291800.02971.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv: replace orig_hash
	hash_iterate() with individual functions
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
 batman-adv/originator.c |  212 +++++++++++++++++++++++++++++++++--------------
 batman-adv/routing.c    |   32 ++++++--
 batman-adv/vis.c        |  157 ++++++++++++++++++++++------------
 3 files changed, 275 insertions(+), 126 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 58c479d..d573a5b 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -133,26 +133,44 @@ void orig_node_free_ref(struct kref *refcount)
 
 void originator_free(struct bat_priv *bat_priv)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk, *safe;
+	struct hlist_head *head;
 	struct element_t *bucket;
+	spinlock_t *list_lock;
 	struct orig_node *orig_node;
+	int i, ret;
 
-	if (!bat_priv->orig_hash)
+	if (!hash)
 		return;
 
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	bat_priv->orig_hash = NULL;
+
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
+
+		if (ret)
+			continue;
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
-		hash_remove_bucket(bat_priv->orig_hash, &hashit);
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
+			hlist_del_rcu(walk);
+			orig_node = bucket->data;
+			kref_put(&orig_node->refcount, orig_node_free_ref);
+			call_rcu(&bucket->rcu, bucket_free_rcu);
+		}
+		spin_unlock_bh(list_lock);
 	}
 
-	bat_priv->orig_hash = NULL;
+	hash_destroy(hash);
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
@@ -307,27 +325,52 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 
 static void _purge_orig(struct bat_priv *bat_priv)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk, *safe;
+	struct hlist_head *head;
 	struct element_t *bucket;
+	spinlock_t *list_lock;
 	struct orig_node *orig_node;
+	int i, ret;
+
+	if (!hash)
+		return;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* for all origins... */
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
-
-		if (purge_orig_node(bat_priv, orig_node)) {
-			if (orig_node->gw_flags)
-				gw_node_delete(bat_priv, orig_node);
-			hash_remove_bucket(bat_priv->orig_hash, &hashit);
-			kref_put(&orig_node->refcount, orig_node_free_ref);
-		}
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
+
+		if (ret)
+			continue;
 
-		if (time_after(jiffies, (orig_node->last_frag_packet +
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
+			orig_node = bucket->data;
+
+			if (purge_orig_node(bat_priv, orig_node)) {
+				if (orig_node->gw_flags)
+					gw_node_delete(bat_priv, orig_node);
+				hlist_del_rcu(walk);
+				kref_put(&orig_node->refcount,
+					 orig_node_free_ref);
+				call_rcu(&bucket->rcu, bucket_free_rcu);
+				hash->elements--;
+				continue;
+			}
+
+			if (time_after(jiffies, (orig_node->last_frag_packet +
 					msecs_to_jiffies(FRAG_TIMEOUT))))
-			frag_list_free(&orig_node->frag_list);
+				frag_list_free(&orig_node->frag_list);
+
+		}
+		spin_unlock_bh(list_lock);
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
@@ -356,16 +399,18 @@ void purge_orig_ref(struct bat_priv *bat_priv)
 
 int orig_seq_print_text(struct seq_file *seq, void *offset)
 {
-	HASHIT(hashit);
-	struct hlist_node *node;
-	struct element_t *bucket;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk, *node;
+	struct hlist_head *head;
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int batman_count = 0;
 	int last_seen_secs;
 	int last_seen_msecs;
+	int i, ret;
 
 	if ((!bat_priv->primary_if) ||
 	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
@@ -389,36 +434,48 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
 
-		if (!orig_node->router)
+		if (ret)
 			continue;
 
-		if (orig_node->router->tq_avg == 0)
-			continue;
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+
+			if (!orig_node->router)
+				continue;
 
-		last_seen_secs = jiffies_to_msecs(jiffies -
+			if (orig_node->router->tq_avg == 0)
+				continue;
+
+			last_seen_secs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) / 1000;
-		last_seen_msecs = jiffies_to_msecs(jiffies -
+			last_seen_msecs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) % 1000;
 
-		seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
-			   orig_node->orig, last_seen_secs, last_seen_msecs,
-			   orig_node->router->tq_avg, orig_node->router->addr,
-			   orig_node->router->if_incoming->net_dev->name);
-
-		rcu_read_lock();
-		hlist_for_each_entry(neigh_node, node,
-				     &orig_node->neigh_list, list) {
-			seq_printf(seq, " %pM (%3i)", neigh_node->addr,
-					   neigh_node->tq_avg);
+			neigh_node = orig_node->router;
+			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
+				   orig_node->orig, last_seen_secs,
+				   last_seen_msecs, neigh_node->tq_avg,
+				   neigh_node->addr,
+				   neigh_node->if_incoming->net_dev->name);
+
+			hlist_for_each_entry(neigh_node, node,
+					&orig_node->neigh_list, list) {
+				seq_printf(seq, " %pM (%3i)", neigh_node->addr,
+						neigh_node->tq_avg);
+			}
+
+			seq_printf(seq, "\n");
+			batman_count++;
 		}
 		rcu_read_unlock();
-
-		seq_printf(seq, "\n");
-		batman_count++;
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
@@ -462,26 +519,42 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
-	struct orig_node *orig_node;
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
+	struct orig_node *orig_node;
+	int i, ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
+
+		if (ret)
+			continue;
+
+		head = &hash->table[i];
 
-		if (orig_node_add_if(orig_node, max_if_num) == -1)
-			goto err;
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+
+			if (orig_node_add_if(orig_node, max_if_num) == -1)
+				goto err;
+		}
+		rcu_read_unlock();
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
+	rcu_read_unlock();
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
@@ -541,25 +614,39 @@ free_own_sum:
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
+	struct element_t *bucket;
 	struct batman_if *batman_if_tmp;
 	struct orig_node *orig_node;
-	HASHIT(hashit);
-	struct element_t *bucket;
-	int ret;
+	int i, ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
+
+		if (ret)
+			continue;
+
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
 
-		ret = orig_node_del_if(orig_node, max_if_num,
-				       batman_if->if_num);
+			ret = orig_node_del_if(orig_node, max_if_num,
+					batman_if->if_num);
 
-		if (ret == -1)
-			goto err;
+			if (ret == -1)
+				goto err;
+		}
+		rcu_read_unlock();
 	}
 
 	/* renumber remaining batman interfaces _inside_ of orig_hash_lock */
@@ -584,6 +671,7 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	return 0;
 
 err:
+	rcu_read_unlock();
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 35abe00..69de72c 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -39,21 +39,37 @@
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
+	int ret, i;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
-		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
+
+		if (ret)
+			continue;
+
+		head = &hash->table[i];
 
-		bit_get_packet(bat_priv, word, 1, 0);
-		orig_node->bcast_own_sum[batman_if->if_num] =
-			bit_packet_count(word);
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			word = &(orig_node->bcast_own[batman_if->if_num *
+								NUM_WORDS]);
+
+			bit_get_packet(bat_priv, word, 1, 0);
+			orig_node->bcast_own_sum[batman_if->if_num] =
+				bit_packet_count(word);
+		}
+		rcu_read_unlock();
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 3af2506..fe7ad15 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -513,24 +513,40 @@ end:
 static int find_best_vis_server(struct bat_priv *bat_priv,
 				struct vis_info *info)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
-	int best_tq = -1;
+	int best_tq = -1, i, ret;
 
 	packet = (struct vis_packet *)info->skb_packet->data;
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
-		if ((orig_node) && (orig_node->router) &&
-		    (orig_node->flags & VIS_SERVER) &&
-		    (orig_node->router->tq_avg > best_tq)) {
-			best_tq = orig_node->router->tq_avg;
-			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
+
+		if (ret)
+			continue;
+
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			if ((orig_node) && (orig_node->router) &&
+			(orig_node->flags & VIS_SERVER) &&
+			(orig_node->router->tq_avg > best_tq)) {
+				best_tq = orig_node->router->tq_avg;
+				memcpy(packet->target_orig,
+				       orig_node->orig, ETH_ALEN);
+			}
 		}
+		rcu_read_unlock();
 	}
+
 	return best_tq;
 }
 
@@ -551,14 +567,17 @@ static bool vis_packet_full(struct vis_info *info)
 static int generate_vis_packet(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit_local);
-	HASHIT(hashit_global);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
+	struct neigh_node *neigh_node;
 	struct vis_info *info = (struct vis_info *)bat_priv->my_vis_info;
 	struct vis_packet *packet = (struct vis_packet *)info->skb_packet->data;
 	struct vis_info_entry *entry;
 	struct hna_local_entry *hna_local_entry;
-	int best_tq = -1;
+	int best_tq = -1, i, ret;
 
 	info->first_seen = jiffies;
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
@@ -579,37 +598,49 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		}
 	}
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit_global)) {
-		bucket = hlist_entry(hashit_global.walk, struct element_t,
-				     hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
 
-		if (!orig_node->router)
+		if (ret)
 			continue;
 
-		if (!compare_orig(orig_node->router->addr, orig_node->orig))
-			continue;
+		head = &hash->table[i];
 
-		if (orig_node->router->if_incoming->if_status != IF_ACTIVE)
-			continue;
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			neigh_node = orig_node->router;
 
-		if (orig_node->router->tq_avg < 1)
-			continue;
+			if (!neigh_node)
+				continue;
 
-		/* fill one entry into buffer. */
-		entry = (struct vis_info_entry *)
-				skb_put(info->skb_packet, sizeof(*entry));
-		memcpy(entry->src,
-		       orig_node->router->if_incoming->net_dev->dev_addr,
-		       ETH_ALEN);
-		memcpy(entry->dest, orig_node->orig, ETH_ALEN);
-		entry->quality = orig_node->router->tq_avg;
-		packet->entries++;
+			if (!compare_orig(neigh_node->addr, orig_node->orig))
+				continue;
 
-		if (vis_packet_full(info)) {
-			spin_unlock_bh(&bat_priv->orig_hash_lock);
-			return 0;
+			if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+				continue;
+
+			if (neigh_node->tq_avg < 1)
+				continue;
+
+			/* fill one entry into buffer. */
+			entry = (struct vis_info_entry *)
+				     skb_put(info->skb_packet, sizeof(*entry));
+			memcpy(entry->src,
+			       neigh_node->if_incoming->net_dev->dev_addr,
+			       ETH_ALEN);
+			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
+			entry->quality = neigh_node->tq_avg;
+			packet->entries++;
+
+			if (vis_packet_full(info)) {
+				spin_unlock_bh(&bat_priv->orig_hash_lock);
+				return 0;
+			}
 		}
+		rcu_read_unlock();
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
@@ -664,45 +695,59 @@ static void purge_vis_packets(struct bat_priv *bat_priv)
 static void broadcast_vis_packet(struct bat_priv *bat_priv,
 				 struct vis_info *info)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
 	struct sk_buff *skb;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
+	int i, ret;
 
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		rcu_read_lock();
+		ret = hlist_empty(&hash->table[i]);
+		rcu_read_unlock();
 
-		/* if it's a vis server and reachable, send it. */
-		if ((!orig_node) || (!orig_node->router))
-			continue;
-		if (!(orig_node->flags & VIS_SERVER))
-			continue;
-		/* don't send it if we already received the packet from
-		 * this node. */
-		if (recv_list_is_in(bat_priv, &info->recv_list,
-							orig_node->orig))
+		if (ret)
 			continue;
 
-		memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
-		batman_if = orig_node->router->if_incoming;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+		head = &hash->table[i];
 
-		skb = skb_clone(info->skb_packet, GFP_ATOMIC);
-		if (skb)
-			send_skb_packet(skb, batman_if, dstaddr);
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
 
-		spin_lock_bh(&bat_priv->orig_hash_lock);
+			/* if it's a vis server and reachable, send it. */
+			if ((!orig_node) || (!orig_node->router))
+				continue;
+			if (!(orig_node->flags & VIS_SERVER))
+				continue;
+			/* don't send it if we already received the packet from
+			* this node. */
+			if (recv_list_is_in(bat_priv, &info->recv_list,
+							orig_node->orig))
+				continue;
 
+			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
+			batman_if = orig_node->router->if_incoming;
+			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+			spin_unlock_bh(&bat_priv->orig_hash_lock);
+
+			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
+			if (skb)
+				send_skb_packet(skb, batman_if, dstaddr);
+
+			spin_lock_bh(&bat_priv->orig_hash_lock);
+		}
+		rcu_read_unlock();
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
-- 
1.7.2.3

