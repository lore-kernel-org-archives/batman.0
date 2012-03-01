Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  1 Mar 2012 15:35:21 +0800
Message-Id: <1330587321-12177-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: split neigh_new function
	into generic and batman iv specific parts
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
 bat_iv_ogm.c |   40 ++++++++++++++++++++++++++++++++++------
 originator.c |   27 ++++++++++-----------------
 originator.h |    6 ++----
 3 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 209722f..2d2cc73 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -30,6 +30,32 @@
 #include "send.h"
 #include "bat_algo.h"
 
+static struct neigh_node *bat_iv_ogm_neigh_new(struct hard_iface *hard_iface,
+					       const uint8_t *neigh_addr,
+					       struct orig_node *orig_node,
+					       struct orig_node *orig_neigh,
+					       uint32_t seqno)
+{
+	struct neigh_node *neigh_node;
+
+	neigh_node = neigh_node_new(hard_iface, neigh_addr, seqno);
+	if (!neigh_node)
+		goto out;
+
+	INIT_LIST_HEAD(&neigh_node->bonding_list);
+	spin_lock_init(&neigh_node->tq_lock);
+
+	neigh_node->orig_node = orig_neigh;
+	neigh_node->if_incoming = hard_iface;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+out:
+	return neigh_node;
+}
+
 static int bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
@@ -642,8 +668,9 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 		if (!orig_tmp)
 			goto unlock;
 
-		neigh_node = create_neighbor(orig_node, orig_tmp,
-					     ethhdr->h_source, if_incoming);
+		neigh_node = bat_iv_ogm_neigh_new(if_incoming, ethhdr->h_source,
+						  orig_node, orig_tmp,
+						  batman_ogm_packet->seqno);
 
 		orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
@@ -768,10 +795,11 @@ static int bat_iv_ogm_calc_tq(struct orig_node *orig_node,
 	rcu_read_unlock();
 
 	if (!neigh_node)
-		neigh_node = create_neighbor(orig_neigh_node,
-					     orig_neigh_node,
-					     orig_neigh_node->orig,
-					     if_incoming);
+		neigh_node = bat_iv_ogm_neigh_new(if_incoming,
+						  orig_neigh_node->orig,
+						  orig_neigh_node,
+						  orig_neigh_node,
+						  batman_ogm_packet->seqno);
 
 	if (!neigh_node)
 		goto out;
diff --git a/originator.c b/originator.c
index 183a1fe..9f32aa0 100644
--- a/originator.c
+++ b/originator.c
@@ -86,35 +86,28 @@ struct neigh_node *orig_node_get_router(struct orig_node *orig_node)
 	return router;
 }
 
-struct neigh_node *create_neighbor(struct orig_node *orig_node,
-				   struct orig_node *orig_neigh_node,
-				   const uint8_t *neigh,
-				   struct hard_iface *if_incoming)
+struct neigh_node *neigh_node_new(struct hard_iface *hard_iface,
+				  const uint8_t *neigh_addr, uint32_t seqno)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct neigh_node *neigh_node;
 
-	bat_dbg(DBG_BATMAN, bat_priv,
-		"Creating new last-hop neighbor of originator\n");
-
 	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
 	if (!neigh_node)
-		return NULL;
+		goto out;
 
 	INIT_HLIST_NODE(&neigh_node->list);
-	INIT_LIST_HEAD(&neigh_node->bonding_list);
-	spin_lock_init(&neigh_node->tq_lock);
 
-	memcpy(neigh_node->addr, neigh, ETH_ALEN);
-	neigh_node->orig_node = orig_neigh_node;
-	neigh_node->if_incoming = if_incoming;
+	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
 
 	/* extra reference for return */
 	atomic_set(&neigh_node->refcount, 2);
 
-	spin_lock_bh(&orig_node->neigh_list_lock);
-	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
-	spin_unlock_bh(&orig_node->neigh_list_lock);
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Creating new neighbor %pM, initial seqno %d\n",
+		neigh_addr, seqno);
+
+out:
 	return neigh_node;
 }
 
diff --git a/originator.h b/originator.h
index 3fe2eda..64c5d94 100644
--- a/originator.h
+++ b/originator.h
@@ -29,10 +29,8 @@ void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
 void orig_node_free_ref(struct orig_node *orig_node);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr);
-struct neigh_node *create_neighbor(struct orig_node *orig_node,
-				   struct orig_node *orig_neigh_node,
-				   const uint8_t *neigh,
-				   struct hard_iface *if_incoming);
+struct neigh_node *neigh_node_new(struct hard_iface *hard_iface,
+				  const uint8_t *neigh_addr, uint32_t seqno);
 void neigh_node_free_ref(struct neigh_node *neigh_node);
 struct neigh_node *orig_node_get_router(struct orig_node *orig_node);
 int orig_seq_print_text(struct seq_file *seq, void *offset);
-- 
1.7.9

