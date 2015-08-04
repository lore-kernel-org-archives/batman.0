Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue,  4 Aug 2015 23:31:44 +0800
Message-Id: <1438702304-26197-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: turn batadv_neigh_node_get()
	into local function
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

commit c214ebe1eb29 ("batman-adv: move neigh_node list add into
batadv_neigh_node_new()") removed external calls to
batadv_neigh_node_get().

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/originator.c | 72 ++++++++++++++++++++++-----------------------
 net/batman-adv/originator.h |  4 ---
 2 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 099a84a..7486df9 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -443,6 +443,42 @@ out:
 }
 
 /**
+ * batadv_neigh_node_get - retrieve a neighbour from the list
+ * @orig_node: originator which the neighbour belongs to
+ * @hard_iface: the interface where this neighbour is connected to
+ * @addr: the address of the neighbour
+ *
+ * Looks for and possibly returns a neighbour belonging to this originator list
+ * which is connected through the provided hard interface.
+ * Returns NULL if the neighbour is not found.
+ */
+static struct batadv_neigh_node *
+batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
+		      const struct batadv_hard_iface *hard_iface,
+		      const u8 *addr)
+{
+	struct batadv_neigh_node *tmp_neigh_node, *res = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_neigh_node, &orig_node->neigh_list, list) {
+		if (!batadv_compare_eth(tmp_neigh_node->addr, addr))
+			continue;
+
+		if (tmp_neigh_node->if_incoming != hard_iface)
+			continue;
+
+		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+			continue;
+
+		res = tmp_neigh_node;
+		break;
+	}
+	rcu_read_unlock();
+
+	return res;
+}
+
+/**
  * batadv_neigh_node_new - create and init a new neigh_node object
  * @orig_node: originator object representing the neighbour
  * @hard_iface: the interface where the neighbour is connected to
@@ -496,42 +532,6 @@ out:
 }
 
 /**
- * batadv_neigh_node_get - retrieve a neighbour from the list
- * @orig_node: originator which the neighbour belongs to
- * @hard_iface: the interface where this neighbour is connected to
- * @addr: the address of the neighbour
- *
- * Looks for and possibly returns a neighbour belonging to this originator list
- * which is connected through the provided hard interface.
- * Returns NULL if the neighbour is not found.
- */
-struct batadv_neigh_node *
-batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
-		      const struct batadv_hard_iface *hard_iface,
-		      const u8 *addr)
-{
-	struct batadv_neigh_node *tmp_neigh_node, *res = NULL;
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(tmp_neigh_node, &orig_node->neigh_list, list) {
-		if (!batadv_compare_eth(tmp_neigh_node->addr, addr))
-			continue;
-
-		if (tmp_neigh_node->if_incoming != hard_iface)
-			continue;
-
-		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
-			continue;
-
-		res = tmp_neigh_node;
-		break;
-	}
-	rcu_read_unlock();
-
-	return res;
-}
-
-/**
  * batadv_orig_ifinfo_free_rcu - free the orig_ifinfo object
  * @rcu: rcu pointer of the orig_ifinfo object
  */
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index fde3438..fa18f9b 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -42,10 +42,6 @@ void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr);
 struct batadv_neigh_node *
-batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
-		      const struct batadv_hard_iface *hard_iface,
-		      const u8 *addr);
-struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 		      struct batadv_hard_iface *hard_iface,
 		      const u8 *neigh_addr);
-- 
2.5.0

