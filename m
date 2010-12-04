Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  4 Dec 2010 21:03:42 +0100
Message-Id: <1291493028-29957-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201012042042.16056.sven.eckelmann@gmx.de>
References: <201012042042.16056.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: protect neighbor nodes with
	reference counters
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
 batman-adv/originator.c |   20 +++++++++++++++-----
 batman-adv/originator.h |    8 +++++---
 batman-adv/routing.c    |    7 +++++++
 batman-adv/types.h      |    1 +
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 7b1fc52..cc778ea 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -59,9 +59,18 @@ err:
 	return 0;
 }
 
-struct neigh_node *
-create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
-		uint8_t *neigh, struct batman_if *if_incoming)
+void neigh_node_free_ref(struct kref *refcount)
+{
+	struct neigh_node *neigh_node;
+
+	neigh_node = container_of(refcount, struct neigh_node, refcount);
+	kfree(neigh_node);
+}
+
+struct neigh_node *create_neighbor(struct orig_node *orig_node,
+				   struct orig_node *orig_neigh_node,
+				   uint8_t *neigh,
+				   struct batman_if *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node;
@@ -78,6 +87,7 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node = orig_neigh_node;
 	neigh_node->if_incoming = if_incoming;
+	kref_init(&neigh_node->refcount);
 
 	list_add_tail(&neigh_node->list, &orig_node->neigh_list);
 	return neigh_node;
@@ -95,7 +105,7 @@ static void free_orig_node(void *data, void *arg)
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
 
 		list_del(list_pos);
-		kfree(neigh_node);
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
 	}
 
 	frag_list_free(&orig_node->frag_list);
@@ -216,7 +226,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 
 			neigh_purged = true;
 			list_del(list_pos);
-			kfree(neigh_node);
+			kref_put(&neigh_node->refcount, neigh_node_free_ref);
 		} else {
 			if ((*best_neigh_node == NULL) ||
 			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index d474ceb..f3676fa 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -26,9 +26,11 @@ int originator_init(struct bat_priv *bat_priv);
 void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
-struct neigh_node *
-create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
-		uint8_t *neigh, struct batman_if *if_incoming);
+struct neigh_node *create_neighbor(struct orig_node *orig_node,
+				   struct orig_node *orig_neigh_node,
+				   uint8_t *neigh,
+				   struct batman_if *if_incoming);
+void neigh_node_free_ref(struct kref *refcount);
 int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 8cec99b..014413e 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -90,6 +90,8 @@ static void update_route(struct bat_priv *bat_priv,
 			 struct neigh_node *neigh_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
+	struct neigh_node *neigh_node_tmp;
+
 	/* route deleted */
 	if ((orig_node->router != NULL) && (neigh_node == NULL)) {
 
@@ -116,7 +118,12 @@ static void update_route(struct bat_priv *bat_priv,
 			orig_node->router->addr);
 	}
 
+	if (neigh_node)
+		kref_get(&neigh_node->refcount);
+	neigh_node_tmp = orig_node->router;
 	orig_node->router = neigh_node;
+	if (neigh_node_tmp)
+		kref_put(&neigh_node_tmp->refcount, neigh_node_free_ref);
 }
 
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1d00849..c1accbf 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -115,6 +115,7 @@ struct neigh_node {
 	struct neigh_node *next_bond_candidate;
 	unsigned long last_valid;
 	TYPE_OF_WORD real_bits[NUM_WORDS];
+	struct kref refcount;
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
 };
-- 
1.7.2.3

