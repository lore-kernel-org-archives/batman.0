Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 17 Mar 2012 15:28:32 +0800
Message-Id: <1331969315-27535-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: prepare lq_update_lock to be
	shared among different protocols
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
 bat_iv_ogm.c |    9 ++++-----
 originator.c |    1 +
 types.h      |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 85617c4..fa41307 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -43,7 +43,6 @@ static struct neigh_node *bat_iv_ogm_neigh_new(struct hard_iface *hard_iface,
 		goto out;
 
 	INIT_LIST_HEAD(&neigh_node->bonding_list);
-	spin_lock_init(&neigh_node->tq_lock);
 
 	neigh_node->orig_node = orig_neigh;
 	neigh_node->if_incoming = hard_iface;
@@ -638,12 +637,12 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 		if (is_duplicate)
 			continue;
 
-		spin_lock_bh(&tmp_neigh_node->tq_lock);
+		spin_lock_bh(&tmp_neigh_node->lq_update_lock);
 		ring_buffer_set(tmp_neigh_node->tq_recv,
 				&tmp_neigh_node->tq_index, 0);
 		tmp_neigh_node->tq_avg =
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
-		spin_unlock_bh(&tmp_neigh_node->tq_lock);
+		spin_unlock_bh(&tmp_neigh_node->lq_update_lock);
 	}
 
 	if (!neigh_node) {
@@ -669,12 +668,12 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 	orig_node->flags = batman_ogm_packet->flags;
 	neigh_node->last_seen = jiffies;
 
-	spin_lock_bh(&neigh_node->tq_lock);
+	spin_lock_bh(&neigh_node->lq_update_lock);
 	ring_buffer_set(neigh_node->tq_recv,
 			&neigh_node->tq_index,
 			batman_ogm_packet->tq);
 	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
-	spin_unlock_bh(&neigh_node->tq_lock);
+	spin_unlock_bh(&neigh_node->lq_update_lock);
 
 	if (!is_duplicate) {
 		orig_node->last_ttl = batman_ogm_packet->header.ttl;
diff --git a/originator.c b/originator.c
index 4432d64..30889c9 100644
--- a/originator.c
+++ b/originator.c
@@ -99,6 +99,7 @@ struct neigh_node *neigh_node_new(struct hard_iface *hard_iface,
 	INIT_HLIST_NODE(&neigh_node->list);
 
 	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
+	spin_lock_init(&neigh_node->lq_update_lock);
 
 	/* extra reference for return */
 	atomic_set(&neigh_node->refcount, 2);
diff --git a/types.h b/types.h
index 04d6cf5..15f538a 100644
--- a/types.h
+++ b/types.h
@@ -151,7 +151,7 @@ struct neigh_node {
 	struct rcu_head rcu;
 	struct orig_node *orig_node;
 	struct hard_iface *if_incoming;
-	spinlock_t tq_lock;	/* protects: tq_recv, tq_index */
+	spinlock_t lq_update_lock;	/* protects: tq_recv, tq_index */
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-- 
1.7.9.1

