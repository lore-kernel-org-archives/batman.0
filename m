Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jun 2016 23:52:17 +0200
Message-Id: <1467237137-8418-3-git-send-email-sven@narfation.org>
In-Reply-To: <1467237137-8418-1-git-send-email-sven@narfation.org>
References: <1467237137-8418-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: Fix reference leak in
	batadv_find_router
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

The replacement of last_bonding_candidate in batadv_orig_node has to be an
atomic operation. Otherwise it is possible that the reference counter of a
batadv_orig_ifinfo is reduced which was no longer the
last_bonding_candidate when the new candidate is added. This can either
lead to an invalid memory access or to reference leaks which make it
impossible to an interface which was added to batman-adv.

Fixes: 797edd9e87ac ("batman-adv: add bonding again")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 33 ++++++++++++++++++++++++++-------
 net/batman-adv/types.h   |  4 +++-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6c2901a..82db982 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -456,6 +456,29 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_last_bonding_replace - Replace last_bonding_candidate of orig_node
+ * @orig_node: originator node whose bonding candidates should be replaced
+ * @new_candidate: new bonding candidate or NULL
+ */
+static void
+batadv_last_bonding_replace(struct batadv_orig_node *orig_node,
+			    struct batadv_orig_ifinfo *new_candidate)
+{
+	struct batadv_orig_ifinfo *old_candidate;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	old_candidate = orig_node->last_bonding_candidate;
+
+	if (new_candidate)
+		kref_get(&new_candidate->refcount);
+	orig_node->last_bonding_candidate = new_candidate;
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	if (old_candidate)
+		batadv_orig_ifinfo_put(old_candidate);
+}
+
+/**
  * batadv_find_router - find a suitable router for this originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the destination node
@@ -562,10 +585,6 @@ next:
 	}
 	rcu_read_unlock();
 
-	/* last_bonding_candidate is reset below, remove the old reference. */
-	if (orig_node->last_bonding_candidate)
-		batadv_orig_ifinfo_put(orig_node->last_bonding_candidate);
-
 	/* After finding candidates, handle the three cases:
 	 * 1) there is a next candidate, use that
 	 * 2) there is no next candidate, use the first of the list
@@ -580,15 +599,15 @@ next:
 			batadv_orig_ifinfo_put(first_candidate);
 		}
 		router = next_candidate_router;
-		orig_node->last_bonding_candidate = next_candidate;
+		batadv_last_bonding_replace(orig_node, next_candidate);
 	} else if (first_candidate) {
 		batadv_neigh_node_put(router);
 
 		/* refcounting has already been done in the loop above. */
 		router = first_candidate_router;
-		orig_node->last_bonding_candidate = first_candidate;
+		batadv_last_bonding_replace(orig_node, first_candidate);
 	} else {
-		orig_node->last_bonding_candidate = NULL;
+		batadv_last_bonding_replace(orig_node, NULL);
 	}
 
 	return router;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 21fe6ad..b3f899f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -330,7 +330,9 @@ struct batadv_orig_node {
 	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	u32 last_bcast_seqno;
 	struct hlist_head neigh_list;
-	/* neigh_list_lock protects: neigh_list and router */
+	/* neigh_list_lock protects: neigh_list, ifinfo_list,
+	 * last_bonding_candidate and router
+	 */
 	spinlock_t neigh_list_lock;
 	struct hlist_node hash_entry;
 	struct batadv_priv *bat_priv;
-- 
2.8.1

