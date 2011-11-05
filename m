Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat,  5 Nov 2011 18:24:16 +0100
Message-Id: <1320513862-28360-6-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/11] batman-adv: allow multiple entries in
	tt_global_entries
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

as backbone gateways will all independently announce the same clients,
also the tt global table must be able to hold multiple originators per
client entry.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

---
[2011-10-30] recalculate global crc in any case:

 this should not be required, but the crc diverges for some reason.
 Need to dig into this further ...
---
 translation-table.c |  337 ++++++++++++++++++++++++++++++++++++---------------
 types.h             |   11 ++-
 2 files changed, 250 insertions(+), 98 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 76134bc..94a99f8 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -30,10 +30,8 @@
 
 #include <linux/crc16.h>
 
-static void _tt_global_del(struct bat_priv *bat_priv,
-			   struct tt_global_entry *tt_global_entry,
-			   const char *message);
 static void tt_purge(struct work_struct *work);
+static void tt_global_del_orig_list(struct tt_global_entry *tt_global_entry);
 
 /* returns 1 if they are the same mac addr */
 static int compare_tt(const struct hlist_node *node, const void *data2)
@@ -131,17 +129,31 @@ static void tt_global_entry_free_rcu(struct rcu_head *rcu)
 	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
 				       common);
 
-	if (tt_global_entry->orig_node)
-		orig_node_free_ref(tt_global_entry->orig_node);
-
 	kfree(tt_global_entry);
 }
 
 static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 {
-	if (atomic_dec_and_test(&tt_global_entry->common.refcount))
+	if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
+		tt_global_del_orig_list(tt_global_entry);
 		call_rcu(&tt_global_entry->common.rcu,
 			 tt_global_entry_free_rcu);
+	}
+}
+
+static void tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct tt_orig_list_entry *orig_entry;
+
+	orig_entry = container_of(rcu, struct tt_orig_list_entry, rcu);
+	atomic_dec(&orig_entry->orig_node->tt_size);
+	orig_node_free_ref(orig_entry->orig_node);
+	kfree(orig_entry);
+}
+
+static void tt_orig_list_entry_free_ref(struct tt_orig_list_entry *orig_entry)
+{
+	call_rcu(&orig_entry->rcu, tt_orig_list_entry_free_rcu);
 }
 
 static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
@@ -190,6 +202,9 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct tt_orig_list_entry *orig_entry;
 
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
@@ -232,13 +247,21 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	/* Check whether it is a roaming! */
 	if (tt_global_entry) {
-		/* This node is probably going to update its tt table */
-		tt_global_entry->orig_node->tt_poss_change = true;
-		/* The global entry has to be marked as PENDING and has to be
-		 * kept for consistency purpose */
+		/* These node are probably going to update their tt table */
+		head = &tt_global_entry->orig_list;
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_entry,
+				node, head, list) {
+			orig_entry->orig_node->tt_poss_change = true;
+
+			send_roam_adv(bat_priv, tt_global_entry->common.addr,
+				orig_entry->orig_node);
+		}
+		rcu_read_unlock();
+		/* The global entry has to be marked as PENDING and
+		 * has to be kept for consistency purpose */
+
 		tt_global_entry->common.flags |= TT_CLIENT_PENDING;
-		send_roam_adv(bat_priv, tt_global_entry->common.addr,
-			      tt_global_entry->orig_node);
 	}
 out:
 	if (tt_local_entry)
@@ -491,49 +514,90 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 }
 
+/* find out if an orig_node is already in the list of a tt_global_entry.
+ * we expect to have an rcu_readlock outside. */
+static struct tt_orig_list_entry *tt_global_entry_find_orig(
+		struct tt_global_entry *tt_global_entry,
+		struct orig_node *orig_node)
+{
+	struct tt_orig_list_entry *tmp_orig_entry, *orig_entry = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node;
+
+	head = &tt_global_entry->orig_list;
+	hlist_for_each_entry_rcu(tmp_orig_entry,
+			node, head, list) {
+		if (tmp_orig_entry->orig_node == orig_node) {
+			orig_entry = tmp_orig_entry;
+			break;
+		}
+	}
+	return orig_entry;
+}
+
 /* caller must hold orig_node refcount */
 int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming,
 		  bool wifi)
 {
-	struct tt_global_entry *tt_global_entry;
-	struct orig_node *orig_node_tmp;
+	struct tt_global_entry *tt_global_entry = NULL;
+	struct tt_orig_list_entry *orig_entry = NULL;
 	int ret = 0;
 
 	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
 
 	if (!tt_global_entry) {
-		tt_global_entry =
-			kmalloc(sizeof(*tt_global_entry),
-				GFP_ATOMIC);
+		tt_global_entry = kzalloc(sizeof(*tt_global_entry),
+			GFP_ATOMIC);
 		if (!tt_global_entry)
 			goto out;
+		orig_entry = kzalloc(sizeof(*orig_entry), GFP_ATOMIC);
+		if (!orig_entry) {
+			kfree(tt_global_entry);
+			tt_global_entry = NULL;
+			goto out;
+		}
 
 		memcpy(tt_global_entry->common.addr, tt_addr, ETH_ALEN);
+
 		tt_global_entry->common.flags = NO_FLAGS;
+		tt_global_entry->roam_at = 0;
 		atomic_set(&tt_global_entry->common.refcount, 2);
-		/* Assign the new orig_node */
-		atomic_inc(&orig_node->refcount);
-		tt_global_entry->orig_node = orig_node;
-		tt_global_entry->ttvn = ttvn;
-		tt_global_entry->roam_at = 0;
+
+		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
+		spin_lock_init(&tt_global_entry->list_lock);
 
 		hash_add(bat_priv->tt_global_hash, compare_tt,
 			 choose_orig, &tt_global_entry->common,
 			 &tt_global_entry->common.hash_entry);
+	} else {
+		rcu_read_lock();
+		orig_entry = tt_global_entry_find_orig(tt_global_entry,
+				orig_node);
+		rcu_read_unlock();
+
+		if (orig_entry)
+			/* already in the list, no need to add it again */
+			orig_entry = NULL;
+		else
+			orig_entry = kzalloc(sizeof(*orig_entry), GFP_ATOMIC);
+
+		tt_global_entry->common.flags = NO_FLAGS;
+		tt_global_entry->roam_at = 0;
+	}
+
+	/* new orig_entry needs to be added */
+	if (orig_entry) {
+		INIT_HLIST_NODE(&orig_entry->list);
+		atomic_inc(&orig_node->refcount);
 		atomic_inc(&orig_node->tt_size);
-	} else {
-		if (tt_global_entry->orig_node != orig_node) {
-			atomic_dec(&tt_global_entry->orig_node->tt_size);
-			orig_node_tmp = tt_global_entry->orig_node;
-			atomic_inc(&orig_node->refcount);
-			tt_global_entry->orig_node = orig_node;
-			orig_node_free_ref(orig_node_tmp);
-			atomic_inc(&orig_node->tt_size);
-		}
-		tt_global_entry->common.flags = NO_FLAGS;
-		tt_global_entry->ttvn = ttvn;
-		tt_global_entry->roam_at = 0;
+		orig_entry->orig_node = orig_node;
+		orig_entry->ttvn = ttvn;
+
+		spin_lock_bh(&tt_global_entry->list_lock);
+		hlist_add_head_rcu(&orig_entry->list,
+				&tt_global_entry->orig_list);
+		spin_unlock_bh(&tt_global_entry->list_lock);
 	}
 
 	if (wifi)
@@ -553,6 +617,36 @@ out:
 	return ret;
 }
 
+/*
+ * print all orig nodes who announce the address for this global entry.
+ * it is assumed that the caller holds rcu_read_lock();
+ */
+static void tt_global_print_entry(struct tt_global_entry *tt_global_entry,
+		struct seq_file *seq)
+{
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct tt_orig_list_entry *orig_entry;
+	struct tt_common_entry *tt_common_entry;
+
+	tt_common_entry = &tt_global_entry->common;
+
+	head = &tt_global_entry->orig_list;
+
+	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
+		seq_printf(seq,	" * %pM  (%3u) via %pM     (%3u)   "
+			"[%c%c%c]\n", tt_global_entry->common.addr,
+			orig_entry->ttvn,
+			orig_entry->orig_node->orig,
+			(uint8_t) atomic_read(&orig_entry->orig_node->
+				last_ttvn),
+			(tt_common_entry->flags & TT_CLIENT_ROAM ? 'R' : '.'),
+			(tt_common_entry->flags &
+				TT_CLIENT_PENDING ? 'X' : '.'),
+			(tt_common_entry->flags & TT_CLIENT_WIFI ? 'W' : '.'));
+	}
+}
+
 int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -596,20 +690,7 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 			tt_global_entry = container_of(tt_common_entry,
 						       struct tt_global_entry,
 						       common);
-			seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   "
-					"[%c%c%c]\n",
-					tt_global_entry->common.addr,
-					tt_global_entry->ttvn,
-					tt_global_entry->orig_node->orig,
-					(uint8_t) atomic_read(
-						&tt_global_entry->orig_node->
-						last_ttvn),
-					(tt_global_entry->common.flags &
-					 TT_CLIENT_ROAM ? 'R' : '.'),
-					(tt_global_entry->common.flags &
-					 TT_CLIENT_PENDING ? 'X' : '.'),
-					(tt_global_entry->common.flags &
-					 TT_CLIENT_WIFI ? 'W' : '.'));
+			tt_global_print_entry(tt_global_entry, seq);
 		}
 		rcu_read_unlock();
 	}
@@ -619,27 +700,47 @@ out:
 	return ret;
 }
 
-static void _tt_global_del(struct bat_priv *bat_priv,
-			   struct tt_global_entry *tt_global_entry,
-			   const char *message)
+/* deletes the orig list of a tt_global_entry */
+static void tt_global_del_orig_list(struct tt_global_entry *tt_global_entry)
 {
-	if (!tt_global_entry)
-		goto out;
+	struct hlist_head *head;
+	struct hlist_node *node, *safe;
+	struct tt_orig_list_entry *orig_entry;
 
-	bat_dbg(DBG_TT, bat_priv,
-		"Deleting global tt entry %pM (via %pM): %s\n",
-		tt_global_entry->common.addr, tt_global_entry->orig_node->orig,
-		message);
+	spin_lock_bh(&tt_global_entry->list_lock);
+	head = &tt_global_entry->orig_list;
+	hlist_for_each_entry_safe(orig_entry, node, safe, head, list) {
+		hlist_del_rcu(node);
+		tt_orig_list_entry_free_ref(orig_entry);
+	}
+	spin_unlock_bh(&tt_global_entry->list_lock);
 
-	atomic_dec(&tt_global_entry->orig_node->tt_size);
+}
+
+static void tt_global_del_orig_entry(struct bat_priv *bat_priv,
+		struct tt_global_entry *tt_global_entry,
+		struct orig_node *orig_node, const char *message)
+{
+	struct hlist_head *head;
+	struct hlist_node *node, *safe;
+	struct tt_orig_list_entry *orig_entry;
 
-	hash_remove(bat_priv->tt_global_hash, compare_tt, choose_orig,
-		    tt_global_entry->common.addr);
-out:
-	if (tt_global_entry)
-		tt_global_entry_free_ref(tt_global_entry);
+	spin_lock_bh(&tt_global_entry->list_lock);
+	head = &tt_global_entry->orig_list;
+	hlist_for_each_entry_safe(orig_entry, node, safe, head, list) {
+		if (orig_entry->orig_node == orig_node) {
+			bat_dbg(DBG_TT, bat_priv,
+				"Deleting %pM from global tt entry %pM: %s\n",
+				orig_node->orig, tt_global_entry->common.addr,
+				message);
+			hlist_del_rcu(node);
+			tt_orig_list_entry_free_ref(orig_entry);
+		}
+	}
+	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
+
 void tt_global_del(struct bat_priv *bat_priv,
 		   struct orig_node *orig_node, const unsigned char *addr,
 		   const char *message, bool roaming)
@@ -650,13 +751,23 @@ void tt_global_del(struct bat_priv *bat_priv,
 	if (!tt_global_entry)
 		goto out;
 
-	if (tt_global_entry->orig_node == orig_node) {
-		if (roaming) {
-			tt_global_entry->common.flags |= TT_CLIENT_ROAM;
-			tt_global_entry->roam_at = jiffies;
-			goto out;
-		}
-		_tt_global_del(bat_priv, tt_global_entry, message);
+	if (roaming) {
+		tt_global_entry->common.flags |= TT_CLIENT_ROAM;
+		tt_global_entry->roam_at = jiffies;
+		goto out;
+	}
+	tt_global_del_orig_entry(bat_priv, tt_global_entry,
+			orig_node, message);
+
+	if (hlist_empty(&tt_global_entry->orig_list)) {
+		bat_dbg(DBG_TT, bat_priv,
+			"Deleting global tt entry %pM (via %pM): %s\n",
+			tt_global_entry->common.addr, orig_node->orig,
+			message);
+
+		hash_remove(bat_priv->tt_global_hash, compare_tt, choose_orig,
+			    tt_global_entry->common.addr);
+		tt_global_entry_free_ref(tt_global_entry);
 	}
 out:
 	if (tt_global_entry)
@@ -687,12 +798,14 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 			tt_global_entry = container_of(tt_common_entry,
 						       struct tt_global_entry,
 						       common);
-			if (tt_global_entry->orig_node == orig_node) {
+
+			tt_global_del_orig_entry(bat_priv, tt_global_entry,
+					orig_node, message);
+
+			if (hlist_empty(&tt_global_entry->orig_list)) {
 				bat_dbg(DBG_TT, bat_priv,
-					"Deleting global tt entry %pM "
-					"(via %pM): %s\n",
+					"Deleting global tt entry %pM: %s\n",
 					tt_global_entry->common.addr,
-					tt_global_entry->orig_node->orig,
 					message);
 				hlist_del_rcu(node);
 				tt_global_entry_free_ref(tt_global_entry);
@@ -728,11 +841,10 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 			if (!is_out_of_time(tt_global_entry->roam_at,
 					    TT_CLIENT_ROAM_TIMEOUT * 1000))
 				continue;
-
 			bat_dbg(DBG_TT, bat_priv, "Deleting global "
 				"tt entry (%pM): Roaming timeout\n",
 				tt_global_entry->common.addr);
-			atomic_dec(&tt_global_entry->orig_node->tt_size);
+
 			hlist_del_rcu(node);
 			tt_global_entry_free_ref(tt_global_entry);
 		}
@@ -795,6 +907,11 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
 	struct orig_node *orig_node = NULL;
+	struct neigh_node *router = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct tt_orig_list_entry *orig_entry;
+	int best_tq;
 
 	if (src && atomic_read(&bat_priv->ap_isolation)) {
 		tt_local_entry = tt_local_hash_find(bat_priv, src);
@@ -811,16 +928,30 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	if (tt_local_entry && _is_ap_isolated(tt_local_entry, tt_global_entry))
 		goto out;
 
-	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
-		goto out;
-
 	/* A global client marked as PENDING has already moved from that
 	 * originator */
 	if (tt_global_entry->common.flags & TT_CLIENT_PENDING)
 		goto out;
 
-	orig_node = tt_global_entry->orig_node;
+	best_tq = 0;
 
+	rcu_read_lock();
+	head = &tt_global_entry->orig_list;
+	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
+		router = orig_node_get_router(orig_entry->orig_node);
+		if (!router)
+			continue;
+
+		if (router->tq_avg > best_tq) {
+			orig_node = orig_entry->orig_node;
+			best_tq = router->tq_avg;
+		}
+		neigh_node_free_ref(router);
+	}
+	/* found anything? */
+	if (orig_node && !atomic_inc_not_zero(&orig_node->refcount))
+			orig_node = NULL;
+	rcu_read_unlock();
 out:
 	if (tt_global_entry)
 		tt_global_entry_free_ref(tt_global_entry);
@@ -837,6 +968,7 @@ uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
 	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
+	struct tt_orig_list_entry *orig_entry;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
@@ -851,20 +983,25 @@ uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
 			tt_global_entry = container_of(tt_common_entry,
 						       struct tt_global_entry,
 						       common);
-			if (compare_eth(tt_global_entry->orig_node,
-					orig_node)) {
-				/* Roaming clients are in the global table for
-				 * consistency only. They don't have to be
-				 * taken into account while computing the
-				 * global crc */
-				if (tt_common_entry->flags & TT_CLIENT_ROAM)
-					continue;
-				total_one = 0;
-				for (j = 0; j < ETH_ALEN; j++)
-					total_one = crc16_byte(total_one,
-						tt_common_entry->addr[j]);
-				total ^= total_one;
-			}
+			/* Roaming clients are in the global table for
+			 * consistency only. They don't have to be
+			 * taken into account while computing the
+			 * global crc */
+			if (tt_global_entry->common.flags & TT_CLIENT_ROAM)
+				continue;
+
+			/* find out if this global entry is announced by this
+			 * originator */
+			orig_entry = tt_global_entry_find_orig(tt_global_entry,
+					orig_node);
+			if (!orig_entry)
+				continue;
+
+			total_one = 0;
+			for (j = 0; j < ETH_ALEN; j++)
+				total_one = crc16_byte(total_one,
+					tt_global_entry->common.addr[j]);
+			total ^= total_one;
 		}
 		rcu_read_unlock();
 	}
@@ -997,6 +1134,7 @@ static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 	const struct tt_common_entry *tt_common_entry = entry_ptr;
 	const struct tt_global_entry *tt_global_entry;
 	const struct orig_node *orig_node = data_ptr;
+	struct tt_orig_list_entry *orig_entry;
 
 	if (tt_common_entry->flags & TT_CLIENT_ROAM)
 		return 0;
@@ -1004,7 +1142,13 @@ static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
 				       common);
 
-	return (tt_global_entry->orig_node == orig_node);
+	rcu_read_lock();
+	orig_entry = tt_global_entry_find_orig(
+			(struct tt_global_entry *) tt_global_entry,
+			(struct orig_node *) orig_node);
+	rcu_read_unlock();
+
+	return (orig_entry != NULL);
 }
 
 static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
@@ -1846,6 +1990,7 @@ void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	} else {
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data */
+		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
 		if (ttvn != orig_ttvn || orig_node->tt_crc != tt_crc) {
 request_table:
 			bat_dbg(DBG_TT, bat_priv, "TT inconsistency for %pM. "
diff --git a/types.h b/types.h
index 69984c9..82850f6 100644
--- a/types.h
+++ b/types.h
@@ -239,11 +239,18 @@ struct tt_local_entry {
 
 struct tt_global_entry {
 	struct tt_common_entry common;
-	struct orig_node *orig_node;
-	uint8_t ttvn;
+	struct hlist_head orig_list;
+	spinlock_t list_lock;	/* protects the list */
 	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
 };
 
+struct tt_orig_list_entry {
+	struct orig_node *orig_node;
+	uint8_t ttvn;
+	struct rcu_head rcu;
+	struct hlist_node list;
+};
+
 struct backbone_gw {
 	uint8_t orig[ETH_ALEN];
 	short vid;		/* used VLAN ID */
-- 
1.7.7.1

