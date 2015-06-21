Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 22 Jun 2015 00:30:22 +0800
Message-Id: <1434904223-10227-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert orig_node->vlan_list
	to hlist
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Since the list's tail is never accessed using a double linked list head
wastes memory.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/originator.c        | 6 +++---
 net/batman-adv/translation-table.c | 8 ++++----
 net/batman-adv/types.h             | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 4500e3a..ce5e354 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -70,7 +70,7 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 	struct batadv_orig_node_vlan *vlan = NULL, *tmp;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp, &orig_node->vlan_list, list) {
+	hlist_for_each_entry_rcu(tmp, &orig_node->vlan_list, list) {
 		if (tmp->vid != vid)
 			continue;
 
@@ -118,7 +118,7 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 	atomic_set(&vlan->refcount, 2);
 	vlan->vid = vid;
 
-	list_add_rcu(&vlan->list, &orig_node->vlan_list);
+	hlist_add_head_rcu(&vlan->list, &orig_node->vlan_list);
 
 out:
 	spin_unlock_bh(&orig_node->vlan_list_lock);
@@ -673,7 +673,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 		return NULL;
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
-	INIT_LIST_HEAD(&orig_node->vlan_list);
+	INIT_HLIST_HEAD(&orig_node->vlan_list);
 	INIT_HLIST_HEAD(&orig_node->ifinfo_list);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e96710c..ca0bcac 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -315,7 +315,7 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
 
 	if (atomic_add_return(v, &vlan->tt.num_entries) == 0) {
 		spin_lock_bh(&orig_node->vlan_list_lock);
-		list_del_rcu(&vlan->list);
+		hlist_del_rcu(&vlan->list);
 		spin_unlock_bh(&orig_node->vlan_list_lock);
 		batadv_orig_node_vlan_free_ref(vlan);
 	}
@@ -738,7 +738,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u8 *tt_change_ptr;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
 		num_vlan++;
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
@@ -764,7 +764,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
-	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 
@@ -2463,7 +2463,7 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
 
 	/* recompute the global CRC for each VLAN */
 	rcu_read_lock();
-	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
 		/* if orig_node is a backbone node for this VLAN, don't compute
 		 * the CRC as we ignore all the global entries over it
 		 */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index da4c738..e298332 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -190,7 +190,7 @@ struct batadv_vlan_tt {
 struct batadv_orig_node_vlan {
 	unsigned short vid;
 	struct batadv_vlan_tt tt;
-	struct list_head list;
+	struct hlist_node list;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
@@ -302,7 +302,7 @@ struct batadv_orig_node {
 	spinlock_t out_coding_list_lock; /* Protects out_coding_list */
 #endif
 	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
-	struct list_head vlan_list;
+	struct hlist_head vlan_list;
 	spinlock_t vlan_list_lock; /* protects vlan_list */
 	struct batadv_orig_bat_iv bat_iv;
 };
-- 
2.1.4

