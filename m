Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 27 Jan 2014 16:27:17 +0100
Message-Id: <1390836437-3014-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 next] batman-adv: avoid potential race
	condition when adding a new neighbour
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

When adding a new neighbour it is important to atomically
perform the following:
- check if the neighbour already exists
- append the neighbour to the proper list

If the two operations are not performed in an atomic context
it is possible that two concurrent insertions add the same
neighbour twice.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

Change from v2:
- fix typ0

 bat_iv_ogm.c | 22 ++++++++++++++++------
 originator.c | 36 ++++++++++++++++++++++++++++++++++++
 originator.h |  4 ++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 512159b..c450fb8 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -266,7 +266,7 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			struct batadv_orig_node *orig_neigh)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_neigh_node *neigh_node;
+	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node;
 
 	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr, orig_node);
 	if (!neigh_node)
@@ -281,14 +281,24 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 	neigh_node->orig_node = orig_neigh;
 	neigh_node->if_incoming = hard_iface;
 
-	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
-		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
-
 	spin_lock_bh(&orig_node->neigh_list_lock);
-	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	tmp_neigh_node = batadv_neigh_node_get(orig_node, hard_iface,
+					       neigh_addr);
+	if (!tmp_neigh_node) {
+		hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	} else {
+		kfree(neigh_node);
+		batadv_hardif_free_ref(hard_iface);
+		neigh_node = tmp_neigh_node;
+	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	if (!tmp_neigh_node)
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
+			   neigh_addr, orig_node->orig,
+			   hard_iface->net_dev->name);
+
 out:
 	return neigh_node;
 }
diff --git a/originator.c b/originator.c
index 6df12a2..8539416 100644
--- a/originator.c
+++ b/originator.c
@@ -458,6 +458,42 @@ out:
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
+struct batadv_neigh_node *
+batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
+		      const struct batadv_hard_iface *hard_iface,
+		      const uint8_t *addr)
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
  * batadv_orig_ifinfo_free_rcu - free the orig_ifinfo object
  * @rcu: rcu pointer of the orig_ifinfo object
  */
diff --git a/originator.h b/originator.h
index 37be290..db3a9ed 100644
--- a/originator.h
+++ b/originator.h
@@ -29,6 +29,10 @@ void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const uint8_t *addr);
 struct batadv_neigh_node *
+batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
+		      const struct batadv_hard_iface *hard_iface,
+		      const uint8_t *addr);
+struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		      const uint8_t *neigh_addr,
 		      struct batadv_orig_node *orig_node);
-- 
1.8.5.3

