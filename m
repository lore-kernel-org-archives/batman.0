Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 14 Jan 2011 01:59:53 +0100
Message-Id: <1294966794-17780-11-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
References: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 10/11] batman-adv: Use rcu locking +
	ref-counting for neigh_list
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

With this commit only spinlocking for reading/writing variables inside
a neigh_node for NDP is used. The neigh_list traversal and entry
deleting/adding is done with rcu-locking and reference counting instead
to greatly reduce the time of (concurrent) spinlocking.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 ndp.c        |   58 ++++++++++++++++++++++++++++++++++++++++------------------
 originator.c |    2 +-
 originator.h |    1 +
 routing.c    |   14 +++++++++-----
 types.h      |    2 ++
 5 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/batman-adv/ndp.c b/batman-adv/ndp.c
index 1fd107c..87ea204 100644
--- a/batman-adv/ndp.c
+++ b/batman-adv/ndp.c
@@ -66,19 +66,23 @@ static void ndp_send(struct work_struct *work)
 	       ETH_ALEN);
 
 	neigh_entry = (struct neigh_entry *)(ndp_packet + 1);
-	spin_lock_bh(&batman_if->neigh_list_lock);
-	hlist_for_each_entry(neigh_node, node, &batman_if->neigh_list, list) {
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh_node, node, &batman_if->neigh_list,
+				 list) {
 		if (entries_len + sizeof(struct neigh_entry) >
 		    skb_tailroom(skb))
 			break;
 
+		spin_lock_bh(&neigh_node->update_lock);
 		memcpy(neigh_entry->addr, neigh_node->addr, ETH_ALEN);
 		neigh_entry->rq = neigh_node->rq;
+		spin_unlock_bh(&neigh_node->update_lock);
+
 		ndp_packet->num_neighbors++;
 		neigh_entry++;
 		entries_len += sizeof(struct neigh_entry);
 	}
-	spin_unlock_bh(&batman_if->neigh_list_lock);
+	rcu_read_unlock();
 	skb_put(skb, entries_len);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -133,8 +137,8 @@ void ndp_free(struct batman_if *batman_if)
 	spin_lock_bh(&batman_if->neigh_list_lock);
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &batman_if->neigh_list, list) {
-		hlist_del(&neigh_node->list);
-		kfree(neigh_node);
+		hlist_del_rcu(&neigh_node->list);
+		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 	}
 	spin_unlock_bh(&batman_if->neigh_list_lock);
 }
@@ -216,6 +220,9 @@ static struct neigh_node *ndp_create_neighbor(uint8_t my_tq, uint32_t seqno,
 		return NULL;
 
 	INIT_HLIST_NODE(&neigh_node->list);
+	spin_lock_init(&neigh_node->update_lock);
+	kref_init(&neigh_node->refcount);
+
 	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
 	neigh_node->last_rq_seqno = seqno - 1;
 
@@ -227,6 +234,7 @@ void ndp_purge_neighbors(void)
 	struct neigh_node *neigh_node;
 	struct hlist_node *node, *node_tmp;
 	struct batman_if *batman_if;
+	unsigned long last_valid;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
@@ -236,13 +244,17 @@ void ndp_purge_neighbors(void)
 		spin_lock_bh(&batman_if->neigh_list_lock);
 		hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 					  &batman_if->neigh_list, list) {
-			if (time_before(jiffies, neigh_node->last_valid +
+			spin_lock(&neigh_node->update_lock);
+			last_valid = neigh_node->last_valid;
+			spin_unlock(&neigh_node->update_lock);
+
+			if (time_before(jiffies, last_valid +
 					msecs_to_jiffies(PURGE_TIMEOUT *
 							 1000)))
 				continue;
 
-			hlist_del(&neigh_node->list);
-			kfree(neigh_node);
+			hlist_del_rcu(&neigh_node->list);
+			call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 		}
 		spin_unlock_bh(&batman_if->neigh_list_lock);
 	}
@@ -257,16 +269,17 @@ int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
 	struct hlist_node *node;
 	int ret = 1;
 
-	spin_lock_bh(&batman_if->neigh_list_lock);
-	/* old neighbor? */
-	hlist_for_each_entry(tmp_neigh_node, node, &batman_if->neigh_list,
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_neigh_node, node, &batman_if->neigh_list,
 			     list) {
 		if (!compare_orig(tmp_neigh_node->addr, neigh_addr))
 			continue;
 
 		neigh_node = tmp_neigh_node;
+		kref_get(&neigh_node->refcount);
 		break;
 	}
+	rcu_read_unlock();
 
 	/* new neighbor? */
 	if (!neigh_node) {
@@ -275,15 +288,24 @@ int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
 		if (!neigh_node)
 			goto ret;
 
-		hlist_add_head(&neigh_node->list, &batman_if->neigh_list);
+		ndp_update_neighbor_lq(my_tq, seqno, neigh_node, bat_priv);
+
+		spin_lock_bh(&batman_if->neigh_list_lock);
+		hlist_add_head_rcu(&neigh_node->list, &batman_if->neigh_list);
+		spin_unlock_bh(&batman_if->neigh_list_lock);
 	}
+	/* old neighbor? */
+	else {
+		spin_lock_bh(&neigh_node->update_lock);
+		ndp_update_neighbor_lq(my_tq, seqno, neigh_node, bat_priv);
+		spin_unlock_bh(&neigh_node->update_lock);
 
-	ndp_update_neighbor_lq(my_tq, seqno, neigh_node, bat_priv);
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	}
 
 	ret = 0;
 
 ret:
-	spin_unlock_bh(&batman_if->neigh_list_lock);
 	return ret;
 }
 
@@ -322,9 +344,9 @@ int ndp_seq_print_text(struct seq_file *seq, void *offset)
 		if (batman_if->if_status != IF_ACTIVE)
 			continue;
 
-		spin_lock_bh(&batman_if->neigh_list_lock);
-		hlist_for_each_entry(neigh_node, node, &batman_if->neigh_list,
-				    list) {
+		hlist_for_each_entry_rcu(neigh_node, node,
+					 &batman_if->neigh_list, list) {
+			spin_lock_bh(&neigh_node->update_lock);
 			last_seen_secs = jiffies_to_msecs(jiffies -
 						neigh_node->last_valid) / 1000;
 			last_seen_msecs = jiffies_to_msecs(jiffies -
@@ -335,9 +357,9 @@ int ndp_seq_print_text(struct seq_file *seq, void *offset)
 				   last_seen_msecs, neigh_node->tq_avg,
 				   neigh_node->rq, batman_if->net_dev->name);
 
+			spin_unlock_bh(&neigh_node->update_lock);
 			batman_count++;
 		}
-		spin_unlock_bh(&batman_if->neigh_list_lock);
 	}
 	rcu_read_unlock();
 
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index e98add5..699dbfc 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -68,7 +68,7 @@ void neigh_node_free_ref(struct kref *refcount)
 	kfree(neigh_node);
 }
 
-static void neigh_node_free_rcu(struct rcu_head *rcu)
+void neigh_node_free_rcu(struct rcu_head *rcu)
 {
 	struct neigh_node *neigh_node;
 
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index f3676fa..2a7d68b 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -31,6 +31,7 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   uint8_t *neigh,
 				   struct batman_if *if_incoming);
 void neigh_node_free_ref(struct kref *refcount);
+void neigh_node_free_rcu(struct rcu_head *rcu);
 int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 8a3acfa..785ddc2 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -199,20 +199,24 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			return 0;
 	}
 
-	/* note, bottom halves are already deactivated outside in
-	 * recv_bat_packet() */
-	spin_lock(&if_incoming->neigh_list_lock);
-	hlist_for_each_entry(neigh_node, node, &if_incoming->neigh_list,
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh_node, node, &if_incoming->neigh_list,
 								list) {
 		if (!compare_orig(neigh_node->addr, orig_neigh_node->orig))
 			continue;
 
 		orig_node->last_valid = jiffies;
+
+		/* note, bottom halves are already deactivated outside in
+		 * recv_bat_packet() */
+		spin_lock(&neigh_node->update_lock);
 		local_tq = neigh_node->tq_avg;
 		local_rq = neigh_node->rq;
+		spin_unlock(&neigh_node->update_lock);
+
 		break;
 	}
-	spin_unlock(&if_incoming->neigh_list_lock);
+	rcu_read_unlock();
 
 	if (local_tq == 0)
 		return 0;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 5a21611..37b4eef 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -129,6 +129,8 @@ struct neigh_node {
 	struct rcu_head rcu;
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
+	spinlock_t update_lock;	/* protects last_rq_seqno, ndp_rq_window, rq,
+				   last_valid, tq_avg for NDP */
 };
 
 struct neigh_entry {
-- 
1.7.1

