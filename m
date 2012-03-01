Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  1 Mar 2012 15:35:19 +0800
Message-Id: <1330587321-12177-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: rename last_valid to
	last_seen
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
 bat_iv_ogm.c |    8 ++++----
 originator.c |   16 ++++++++--------
 types.h      |    8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 5833a3e..209722f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -655,7 +655,7 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 	rcu_read_unlock();
 
 	orig_node->flags = batman_ogm_packet->flags;
-	neigh_node->last_valid = jiffies;
+	neigh_node->last_seen = jiffies;
 
 	spin_lock_bh(&neigh_node->tq_lock);
 	ring_buffer_set(neigh_node->tq_recv,
@@ -776,11 +776,11 @@ static int bat_iv_ogm_calc_tq(struct orig_node *orig_node,
 	if (!neigh_node)
 		goto out;
 
-	/* if orig_node is direct neighbor update neigh_node last_valid */
+	/* if orig_node is direct neighbor update neigh_node last_seen */
 	if (orig_node == orig_neigh_node)
-		neigh_node->last_valid = jiffies;
+		neigh_node->last_seen = jiffies;
 
-	orig_node->last_valid = jiffies;
+	orig_node->last_seen = jiffies;
 
 	/* find packet count of corresponding one hop neighbor */
 	spin_lock_bh(&orig_node->ogm_cnt_lock);
diff --git a/originator.c b/originator.c
index 06c8187..aa33337 100644
--- a/originator.c
+++ b/originator.c
@@ -285,7 +285,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
 
-		if ((has_timed_out(neigh_node->last_valid, PURGE_TIMEOUT)) ||
+		if ((has_timed_out(neigh_node->last_seen, PURGE_TIMEOUT)) ||
 		    (neigh_node->if_incoming->if_status == IF_INACTIVE) ||
 		    (neigh_node->if_incoming->if_status == IF_NOT_IN_USE) ||
 		    (neigh_node->if_incoming->if_status == IF_TO_BE_REMOVED)) {
@@ -304,9 +304,9 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 			else
 				bat_dbg(DBG_BATMAN, bat_priv,
 					"neighbor timeout: originator %pM, "
-					"neighbor: %pM, last_valid: %lu\n",
+					"neighbor: %pM, last_seen: %lu\n",
 					orig_node->orig, neigh_node->addr,
-					(neigh_node->last_valid / HZ));
+					(neigh_node->last_seen / HZ));
 
 			neigh_purged = true;
 
@@ -329,10 +329,10 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 {
 	struct neigh_node *best_neigh_node;
 
-	if (has_timed_out(orig_node->last_valid, 2 * PURGE_TIMEOUT)) {
+	if (has_timed_out(orig_node->last_seen, 2 * PURGE_TIMEOUT)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
-			"Originator timeout: originator %pM, last_valid %lu\n",
-			orig_node->orig, (orig_node->last_valid / HZ));
+			"Originator timeout: originator %pM, last_seen %lu\n",
+			orig_node->orig, (orig_node->last_seen / HZ));
 		return true;
 	} else {
 		if (purge_orig_neighbors(bat_priv, orig_node,
@@ -450,9 +450,9 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 				goto next;
 
 			last_seen_secs = jiffies_to_msecs(jiffies -
-						orig_node->last_valid) / 1000;
+						orig_node->last_seen) / 1000;
 			last_seen_msecs = jiffies_to_msecs(jiffies -
-						orig_node->last_valid) % 1000;
+						orig_node->last_seen) % 1000;
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
diff --git a/types.h b/types.h
index 51c59c2..0643271 100644
--- a/types.h
+++ b/types.h
@@ -64,7 +64,7 @@ struct hard_iface {
 /**
  *	orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
- *	@last_valid: when last packet from this node was received
+ *	@last_seen: when last packet from this node was received
  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
  *	@batman_seqno_reset: time when the batman seqno window was reset
  *	@gw_flags: flags related to gateway class
@@ -85,7 +85,7 @@ struct orig_node {
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
-	unsigned long last_valid;
+	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
@@ -135,7 +135,7 @@ struct gw_node {
 
 /**
  *	neigh_node
- *	@last_valid: when last packet via this neighbor was received
+ *	@last_seen: when last packet via this neighbor was received
  */
 struct neigh_node {
 	struct hlist_node list;
@@ -146,7 +146,7 @@ struct neigh_node {
 	uint8_t tq_avg;
 	uint8_t last_ttl;
 	struct list_head bonding_list;
-	unsigned long last_valid;
+	unsigned long last_seen;
 	DECLARE_BITMAP(real_bits, TQ_LOCAL_WINDOW_SIZE);
 	atomic_t refcount;
 	struct rcu_head rcu;
-- 
1.7.9

