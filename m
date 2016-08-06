Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  6 Aug 2016 15:50:52 +0200
Message-Id: <1470491452-14194-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Add missing refcnt for
	last_candidate
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

batadv_find_router dereferences last_bonding_candidate from
orig_node without making sure that it has a valid reference. This reference
has to be retrieved by increasing the reference counter while holding
neigh_list_lock. The lock is required to avoid that
batadv_last_bonding_replace removes the current last_bonding_candidate,
reduces the reference counter and maybe destroys the object in this
process.

Fixes: 797edd9e87ac ("batman-adv: add bonding again")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch was only build tested.
---
 net/batman-adv/routing.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bfac086..69d425d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -456,6 +456,29 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_last_bonding_get - Get last_bonding_candidate of orig_node
+ * @orig_node: originator node whose last bonding candidate should be retrieved
+ *
+ * Return: last bonding candidate of router or NULL if not found
+ *
+ * The object is returned with refcounter increased by 1.
+ */
+static struct batadv_orig_ifinfo *
+batadv_last_bonding_get(struct batadv_orig_node *orig_node)
+{
+	struct batadv_orig_ifinfo *last_bonding_candidate;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	last_bonding_candidate = orig_node->last_bonding_candidate;
+
+	if (last_bonding_candidate)
+		kref_get(&last_bonding_candidate->refcount);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	return last_bonding_candidate;
+}
+
+/**
  * batadv_last_bonding_replace - Replace last_bonding_candidate of orig_node
  * @orig_node: originator node whose bonding candidates should be replaced
  * @new_candidate: new bonding candidate or NULL
@@ -525,7 +548,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	 * router - obviously there are no other candidates.
 	 */
 	rcu_read_lock();
-	last_candidate = orig_node->last_bonding_candidate;
+	last_candidate = batadv_last_bonding_get(orig_node);
 	if (last_candidate)
 		last_cand_router = rcu_dereference(last_candidate->router);
 
@@ -617,6 +640,9 @@ next:
 		batadv_orig_ifinfo_put(next_candidate);
 	}
 
+	if (last_candidate)
+		batadv_orig_ifinfo_put(last_candidate);
+
 	return router;
 }
 
-- 
2.8.1

